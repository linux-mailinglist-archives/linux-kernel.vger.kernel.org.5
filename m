Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6697559C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGQCyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:54:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81E107
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tGd1yCQhYeeKe+QXwVCH6YaT7yIPkDWSzAJINmGu34o=; b=XdXRGKlPhu5Jy1YbEuygfcyIe0
        6IIE+h8we/HNR8+llm7e1LsKdtv8RShgxjAfpRGXA6okU1ySCzbJ9FuWcGQCAU2nGCVIjVZNI5ytC
        zw7+Dzs4fu7gtw6JzmZxOV9BH4N89UwoD6ykd1GZO3C1ZHTUiM+pWUfIiJZjjoUEZwroazbSp1O8d
        Cn6hJwjjlVkh2K20RmXTlSU2deIGjlJcASBhsk8i1OEfd18rSAAsYJlazvFz+Zp3KKtThFyA4+dhz
        poRJf3aVA8BOtSS9y6/K3YTED5UlWrbIYFwvoOjZFlVKw6HTbsvaJhRS51uNtg130cOExU6odCqD+
        uUBizUiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLEN1-003Xi2-JB; Mon, 17 Jul 2023 02:53:55 +0000
Date:   Mon, 17 Jul 2023 03:53:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/swapfile: fix wrong swap entry type for
 hwpoisoned swapcache page
Message-ID: <ZLStQ5QACPOHJcd2@casper.infradead.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-2-linmiaohe@huawei.com>
 <ZLIXg7BPPAoUYUGV@casper.infradead.org>
 <33748ced-5fd3-f3f7-f358-ca016ca8ba36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33748ced-5fd3-f3f7-f358-ca016ca8ba36@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:33:14AM +0800, Miaohe Lin wrote:
> On 2023/7/15 11:50, Matthew Wilcox wrote:
> > On Sat, Jul 15, 2023 at 11:17:26AM +0800, Miaohe Lin wrote:
> >> Hwpoisoned dirty swap cache page is kept in the swap cache and there's
> >> simple interception code in do_swap_page() to catch it. But when trying
> >> to swapoff, unuse_pte() will wrongly install a general sense of "future
> >> accesses are invalid" swap entry for hwpoisoned swap cache page due to
> >> unaware of such type of page. The user will receive SIGBUS signal without
> >> expected BUS_MCEERR_AR payload.
> > 
> > Have you observed this, or do you just think it's true?
> > 
> >> +++ b/mm/swapfile.c
> >> @@ -1767,7 +1767,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >>  		swp_entry_t swp_entry;
> >>  
> >>  		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >> -		if (hwposioned) {
> >> +		/* Hwpoisoned swapcache page is also !PageUptodate. */
> >> +		if (hwposioned || PageHWPoison(page)) {
> > 
> > This line makes no sense to me.  How do we get here with PageHWPoison()
> > being true and hwposioned being false?
> 
> hwposioned will be true iff ksm_might_need_to_copy returns -EHWPOISON.
> And there's PageUptodate check in ksm_might_need_to_copy before we can return -EHWPOISON:
> 
>   ksm_might_need_to_copy
>     if (!PageUptodate(page))
>       return page;		/* let do_swap_page report the error */
>     ^^^
>     Will return here because hwpoisoned swapcache page is !PageUptodate(cleared via me_swapcache_dirty()).
> 
> Or am I miss something?

Ah!  So we don't even get to calling copy_mc_to_kernel().  That seems
like a bug in ksm_might_need_to_copy(), don't you think?  Maybe this
would be a better fix:

+	if (PageHWPoison(page))
+		return ERR_PTR(-EHWPOISON);
	if (!PageUptodate(page))
		return page;
