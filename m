Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9F7D140A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377866AbjJTQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjJTQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:34:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EEBD6B;
        Fri, 20 Oct 2023 09:34:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C26C433C7;
        Fri, 20 Oct 2023 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697819648;
        bh=dKYd/12MjaWQfmGSj1V3kcKO/BZ3aLW0Ffk7QfWNPBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zPs2WckD1f1dvmFYwwvemYD6GDE5M8HkbjSPYVlx/K4R0WRe0vBlqvn4prb+p3SCR
         qmT70LEpvgWad7VaRpyqoULmHnnxk4/m0Ok1UYAtXO/RgGk9kIXNWdLhOx3pFEDxIZ
         3kIjPeMBxpcguF9j9ZCr/5f8vynAFi2Edos8Xqwo=
Date:   Fri, 20 Oct 2023 09:34:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Zach O'Keefe <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 1/2] mm/khugepaged: Fix an uninitialized variable bug
Message-Id: <20231020093407.02be8ef4984ce31a7222f69f@linux-foundation.org>
In-Reply-To: <a1f3242f-1aae-4b46-9893-36b11ee0a6dd@moroto.mountain>
References: <a1f3242f-1aae-4b46-9893-36b11ee0a6dd@moroto.mountain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:13:32 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Smatch complains that "hpage" can be used uninitialized:
> 
>     mm/khugepaged.c:1234 collapse_huge_page()
>     error: uninitialized symbol 'hpage'.
> 
> Initialized it on this path.
> 
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1062,8 +1062,10 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>  	int node = hpage_collapse_find_target_node(cc);
>  	struct folio *folio;
>  
> -	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask))
> +	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
> +		*hpage = NULL;
>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
> +	}
>  
>  	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>  		folio_put(folio);

Thanks.   Seems this was accidentally fixed by 

Author:     Peter Xu <peterx@redhat.com>
AuthorDate: Wed Feb 22 14:52:47 2023 -0500
Commit:     Andrew Morton <akpm@linux-foundation.org>
CommitDate: Tue Mar 28 16:20:06 2023 -0700

    mm/khugepaged: alloc_charge_hpage() take care of mem charge errors


Which was quite a long time ago.  Are you scanning old kernel versions?
