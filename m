Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79F793305
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbjIFAtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjIFAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6ED199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5z10LnLWSXAHPqe7mz8C6zD93RhuMzewKOg+qlq2WQ=; b=EflQnnTC1wk0PT/HVjR2GU2oUt
        BK1bETdOUojcH9S+JKWOronEzzK8U6dJ8ad18XhZYzV9P73J/8Rwn05gzKurMAH532fJiGUr+KlkS
        eHj4tzjDP/u+cgemcOiQp7GZradrJNeZr2jj0QpKXMfnlRvF+zc+28O79pAuPv1mQwlFCrcZvmW/a
        MmJ2KpstyduM1WuiMiXp74ZQ1nPhz+2liGyY5wjM15oUeq4w2pOQfz8zwSx8hySdri3ac+eoGhvld
        OZGRxQnYbharvNn2T4GT5czXK7xMXXuHX/DSrM8kkRg3fZdVI4nXa6qTsq2XwtTkyeWmRkMahkEnE
        C7dF7pJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdgj0-00F5yq-OT; Wed, 06 Sep 2023 00:48:54 +0000
Date:   Wed, 6 Sep 2023 01:48:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <ZPfMds3PloTLeZPP@casper.infradead.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905214412.89152-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> @@ -456,6 +457,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>  	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>  	unsigned long vmemmap_reuse;
>  
> +	VM_WARN_ON_ONCE(!PageHuge(head));
>  	if (!HPageVmemmapOptimized(head))
>  		return 0;
>  
> @@ -550,6 +552,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>  	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>  	unsigned long vmemmap_reuse;
>  
> +	VM_WARN_ON_ONCE(!PageHuge(head));
>  	if (!vmemmap_should_optimize(h, head))
>  		return;

Someone who's looking for an easy patch or three should convert both
of these functions to take a folio instead of a page.  All callers
pass &folio->page.  Obviously do that work on top of Mike's patch set
to avoid creating more work for him.
