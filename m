Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852367B1220
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjI1Fbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjI1Fbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:31:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5298
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:31:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A53C433CA;
        Thu, 28 Sep 2023 05:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695879093;
        bh=jLJr0+v2Tu+NU/8srovtu2AdASkhpyBHDz0WXnuiKO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PI99Mn6IhUjmgddAYTialnPteqviOBMI3VHWk6CQf8yJCFtSWPBasoWP1N0nEvjnw
         cx30LVN/rSqc7zRaWyXk5MuKoYJyV/CYcKtDtvUGHOBIeMqBCI6Kh1r56Jb1LQBO9g
         SDeD0Vwrva8hQAMttkML9Ws26NKg7e6aNb2DyQyKtj0H6V/skjHT4ReaY8jWwX3bfu
         SpPsVVcg9GSm8wPV96sIFVHnKuu6xAIR07Cv2vebKAKdERiAraD4vFXTgYAtMdZiJZ
         n60mQV3VRBHQXxLvWmGJaaJiekB0+YaQrZwNobnjZTlnWhWqcvN3mYRL2hwpxgXoqD
         g1YETPY4DwdTA==
Date:   Thu, 28 Sep 2023 08:30:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: pass page count and reserved to
 __init_single_page
Message-ID: <20230928053039.GR3303@kernel.org>
References: <20230926023341.991124-1-yajun.deng@linux.dev>
 <20230926023341.991124-2-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926023341.991124-2-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:33:40AM +0800, Yajun Deng wrote:
> When we init a single page, we need to mark this page reserved if it
> does. And some pages may not need to set page count, such as compound
> pages.
> 
> Introduce enum init_page_flags, the caller init page count and mark page
> reserved by passing INIT_PAGE_COUNT and INIT_PAGE_RESERVED.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v3: Introduce enum init_page_flags.
> v2: Introduce INIT_PAGE_COUNT and INIT_PAGE_RESERVED.
> v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
> ---
>  mm/hugetlb.c  |  2 +-
>  mm/internal.h |  8 +++++++-
>  mm/mm_init.c  | 31 +++++++++++++++++--------------
>  3 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 06a72c223bce..07fe7e489769 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1041,7 +1043,7 @@ static void __ref memmap_init_compound(struct page *head,
>  	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap, 0);

I think the first patch should not contain any functional changes, but only
add the flags parameter to __init_single_page().

>  		prep_compound_tail(head, pfn - head_pfn);
>  		set_page_count(page, 0);
>  

-- 
Sincerely yours,
Mike.
