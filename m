Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF17546A2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGODuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGODus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:50:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FC26B2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccG7mskW8Dq9YRopcLjZW0gxB+SYHaHO1+yWP7Eip+Q=; b=QKcM6d31KsZm3FfuNhdVNbgdEq
        zrh59dM/2Co+6wVeyGxbGC2/3/1Z42SqrXbN9UBiKLfDHPyy70NZbPq5I0p3hGsSWRSP+Z8XWymnm
        DLn+fsLWqsbLPBDHAwXLpmeam8PGkx3kIe2ISps1qDjFdcC03E39htrrUHomBsVCjJGMV8POLJC+J
        2uhesGvypH88hyLFp4zQWXgItoPxPv3itmADbr1ymB3lJwfrjeBNdmUsUldMxsBBa5rwAU+pAhGFo
        gBpH6Uop2pimj92agwluNhOZG7ciUOO6NSgkyLYRZ7WM4t4cqeY9eifCBLQ5ZMMg40Ls+S2dqlkJY
        9HwVIR3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWId-001nY7-Vz; Sat, 15 Jul 2023 03:50:28 +0000
Date:   Sat, 15 Jul 2023 04:50:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/swapfile: fix wrong swap entry type for
 hwpoisoned swapcache page
Message-ID: <ZLIXg7BPPAoUYUGV@casper.infradead.org>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715031729.2420338-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:17:26AM +0800, Miaohe Lin wrote:
> Hwpoisoned dirty swap cache page is kept in the swap cache and there's
> simple interception code in do_swap_page() to catch it. But when trying
> to swapoff, unuse_pte() will wrongly install a general sense of "future
> accesses are invalid" swap entry for hwpoisoned swap cache page due to
> unaware of such type of page. The user will receive SIGBUS signal without
> expected BUS_MCEERR_AR payload.

Have you observed this, or do you just think it's true?

> +++ b/mm/swapfile.c
> @@ -1767,7 +1767,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		swp_entry_t swp_entry;
>  
>  		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> -		if (hwposioned) {
> +		/* Hwpoisoned swapcache page is also !PageUptodate. */
> +		if (hwposioned || PageHWPoison(page)) {

This line makes no sense to me.  How do we get here with PageHWPoison()
being true and hwposioned being false?

>  			swp_entry = make_hwpoison_entry(swapcache);
>  			page = swapcache;
>  		} else {
> -- 
> 2.33.0
> 
> 
