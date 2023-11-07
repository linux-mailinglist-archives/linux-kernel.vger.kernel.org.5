Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA67E41C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjKGOYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:24:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3199C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2nocopVJrZg5DkEAMHz/LkgkqbkKX5Z643rJ6AjI3Og=; b=oumPiU5jlO53htmdUDzf0meBVJ
        AMxD++rMI0xVxAZxwDna+AoxCGNEFq/Afnm/sMNXDMIc9HFY+bqVLiNNuV4Gxq6j/wkw2W8tgB1v8
        /bNuT3ge3rHgxtVaFG+v3UH/+uuo3aDRpYAuczCKhyPU3Aoih4Btu4xmSCALjTuj1lkraRxiirYV8
        0h9LDPXB+FiTtyyjdDUnTZ23thodnmZpF+aw+z0Bo5qZSUIL37zshKXAReFwMA5B7yS0BYpUA3h2A
        SRih7jcUnSWNe7WSiM7gRBzvk4iC3i+TpQFqhJsMkCZcJpUN61TGP30Ucl+0LPx2AwhV+j8idsdsM
        Z8nlwAVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0N0A-00Ckwp-O5; Tue, 07 Nov 2023 14:24:22 +0000
Date:   Tue, 7 Nov 2023 14:24:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/6] mm: ksm: use more folio api in
 ksm_might_need_to_copy()
Message-ID: <ZUpIlkO0E7+i2hCg@casper.infradead.org>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107135216.415926-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:52:11PM +0800, Kefeng Wang wrote:
>  struct page *ksm_might_need_to_copy(struct page *page,
> -			struct vm_area_struct *vma, unsigned long address)
> +			struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct anon_vma *anon_vma = folio_anon_vma(folio);
> -	struct page *new_page;
> +	struct folio *new_folio;
>  
> -	if (PageKsm(page)) {
> -		if (page_stable_node(page) &&
> +	if (folio_test_ksm(folio)) {
> +		if (folio_stable_node(folio) &&
>  		    !(ksm_run & KSM_RUN_UNMERGE))
>  			return page;	/* no need to copy it */
>  	} else if (!anon_vma) {
>  		return page;		/* no need to copy it */
> -	} else if (page->index == linear_page_index(vma, address) &&
> +	} else if (page->index == linear_page_index(vma, addr) &&

Hmm.  page->index is going away.  What should we do here instead?

The rest of this looks good.
