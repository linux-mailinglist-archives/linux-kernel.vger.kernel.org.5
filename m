Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4C79D0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjILMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjILMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:18:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025F10D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/SJd7uAeq+C6xNw7E5T8lhkAqYav/AoZkSdrJ8MoKw=; b=P2fGgS+NSCITBCYpab2tKiIUMc
        ua7MWnLjEr4edXKkTTXlW+/r+64NTQ2mv0lAr0AxtCloRxXCIBWGoQkkkD7eg0sqkmj91m4+fYsaz
        j9gIivwbqeZPQ8QmQuUCdoH1C6Mf9cW/05ZsqgYDmpSj219sVDycFJ2cVmCPeejRv24IPXPG62CFa
        XzlxwgjORqVcyIzzIOSZHMRHNWKSjl96Ct7tzW/lWZDsT2zoKtw55G2peEHFLQNvjgFtEfcI60D79
        igRA0Q8j+oMlorXeDYXwfSVMa3LSrqIMNymA6ibgXQN3P42C3YLQpmftSvAlYYHOYoiyPyS4JWGQH
        OJfY3RDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg2Ki-007VF8-0o; Tue, 12 Sep 2023 12:17:32 +0000
Date:   Tue, 12 Sep 2023 13:17:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] arch: arm: remove redundant clear_page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on
Message-ID: <ZQBW23Upv/CdN9v6@casper.infradead.org>
References: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:33:34PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Double times of clear_page observed in an arm SOC(A55) when
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
> vma_alloc_zeroed_movable_folio within do_anonymous_pages.
> Since there is no D-cache operation within v6's clear_user_highpage,
> I would like to suggest to remove the redundant clear_page.
> 
> struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> 				   unsigned long vaddr)
> {
> 	struct folio *folio;
> 
> //first clear_page invoked by vma_alloc_folio==>alloc_page==>post_alloc_hook
> 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
> 	if (folio)
> //second clear_page which is meaningless since it do nothing to D-cache in armv6
> 		clear_user_highpage(&folio->page, vaddr);

This is, of course, not the only place which calls clear_user_highpage().
Please explain why this patch is safe for all the _other_ places which
call clear_user_highpage().

> 	return folio;
> }
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  arch/arm/mm/copypage-v6.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index a1a71f36d850..6f8bee1b3203 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/pagemap.h>
> +#include <linux/gfp.h>
>  
>  #include <asm/shmparam.h>
>  #include <asm/tlbflush.h>
> @@ -45,6 +46,13 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
>   */
>  static void v6_clear_user_highpage_nonaliasing(struct page *page, unsigned long vaddr)
>  {
> +	/*
> +	 * This criteria only help bailing out when CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> +	 * is on. The page has been memset to zero when it allocated and the
> +	 * bellowing clear_page will do it again.
> +	 */
> +	if (want_init_on_alloc(GFP_HIGHUSER_MOVABLE))
> +		return;
>  	void *kaddr = kmap_atomic(page);
>  	clear_page(kaddr);
>  	kunmap_atomic(kaddr);
> -- 
> 2.25.1
> 
