Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC976EACB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjHCNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjHCNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED675FD0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F48F61DB0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F5C433C7;
        Thu,  3 Aug 2023 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691069671;
        bh=dy2GYZR2b61H37bLEusad9qBv/xyGvAOvToaUiJ8fPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPNtGO/G/KDpCholqvr3N0nX4pD8T/WItCJQqZC2kMIwLCDa/Hi06gwXkIVNrxnQ0
         crjMIH/Z7xnSpWIPYms1nKzwaQYfuuEFdOtQy5qXs2DCbX+SIjwIkcL1Cys8Zuq8zi
         u0izyAnIBeM2dpxct27jWPzW0Npdu5qzO122h4iP38Z8dAlU6/6xu85mjaPFHA3tUE
         OxrxV9n4+SxohnOTlvAjMAzEEqU3wrJ2+ehFCJ1yNVujMxFJ2281TVAinPYoJFspjV
         VYpprauA7rG0iPYmChb0u2/1iSBQ7Uc60Ick8sbs0yZ3XuFq0Ygp4hN3fH+O8O8PxN
         0iG4WBlkbMRow==
Date:   Thu, 3 Aug 2023 16:33:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init: use helper macro BITS_PER_LONG
Message-ID: <20230803133346.GH2607694@kernel.org>
References: <20230803114051.637709-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803114051.637709-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:40:51PM +0800, Miaohe Lin wrote:
> It's more readable to use helper macro BITS_PER_LONG. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mm_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 66aca3f6accd..2f37dbb5ff9a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
>  	int shift, width;
>  	unsigned long or_mask, add_mask;
>  
> -	shift = 8 * sizeof(unsigned long);
> +	shift = BITS_PER_LONG;
>  	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
>  		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
>  	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
> @@ -1431,7 +1431,7 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>  	usemapsize = roundup(zonesize, pageblock_nr_pages);
>  	usemapsize = usemapsize >> pageblock_order;
>  	usemapsize *= NR_PAGEBLOCK_BITS;
> -	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
> +	usemapsize = roundup(usemapsize, BITS_PER_LONG);
>  
>  	return usemapsize / 8;

BITS_PER_BYTE instead of 8 here?

>  }

-- 
Sincerely yours,
Mike.
