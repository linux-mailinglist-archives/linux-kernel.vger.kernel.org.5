Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70180D1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbjLKQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjLKQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:33:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355F8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EAJ/+IT1OXCwbVZ/WlVxVWxl84qH6ej/2kZUo5gORJ4=; b=nllv4TWb8WrqI2idm0/EjcSH4P
        dFsPRaiIrwWe7afDhhCh/7OT5+7tx5kU+hwd6sy29JKbWj3w4HRaCtNwgO2NaQGKhNI1yDjrD1Kr/
        M1/Hp+Mdz+K6TWXPAdZI/5d4czs6yuSP9/NOL3IEmw4pdfBPZo1ydiSUWfeS/02g45wk3WdxgjfND
        UCVxrXcvbVpIEtFOsMf9UF9Xove5kf6ULWk5FptTD6wkkjaq1O7UTD0B5oZ1AMfqNUw2zBnGYKmT3
        6QVsF+G0In5EkLSG54VGvfpBsMmVquv4EkZU9VasQJPaKbxnk55iEy9IZnh1tXaupOQmphMuNs750
        tao/DMLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rCjDv-0090sx-OC; Mon, 11 Dec 2023 16:33:39 +0000
Date:   Mon, 11 Dec 2023 16:33:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 02/39] mm/rmap: introduce and use hugetlb_remove_rmap()
Message-ID: <ZXc54xgLxaBSTuaq@casper.infradead.org>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211155652.131054-3-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:56:15PM +0100, David Hildenbrand wrote:
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
> code from page_remove_rmap(). This effectively removes one check on the
> small-folio path as well.
> 
> Note: all possible candidates that need care are page_remove_rmap() that
>       pass compound=true.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +++ b/mm/rmap.c
> @@ -1482,13 +1482,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> -	/* Hugetlb pages are not counted in NR_*MAPPED */
> -	if (unlikely(folio_test_hugetlb(folio))) {
> -		/* hugetlb pages are always mapped with pmds */
> -		atomic_dec(&folio->_entire_mapcount);
> -		return;
> -	}

Maybe add
	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);

