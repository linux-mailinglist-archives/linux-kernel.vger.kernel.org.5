Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4CA767C96
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjG2GnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjG2GnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C413592
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96DE602FB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47722C433C8;
        Sat, 29 Jul 2023 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690612991;
        bh=3umf+ONMIblL2nAVUVYoR39EvcxsUy91gC3porAPrFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuAwOwKe4/IrvZW96FVeiNu4RWLHWmB0VhtgEO9nFxUFx9oBTlA4uOIY+HNCzAkcU
         gfXunkPulxjvCaFeIBbjzsA05Z6tNxthhDiyoIZsnKed0KRKZKoYf8+mHX2404u5sF
         88kS/F7yYFDWrJw2xpy8Ye9mgnMU5xFG8s8ijtVN7p1YTJ14+bzC1chMtNWwTrFF8t
         5YQRzbAg7V+mkxE/sFzivz7E5GYcqWvFbQRv2ZVxcxLvFkcsG8NIFfK/t5VMAlzd0i
         W6K7g8PahV4VYz8loyiG6/y6Q1qcCuisXlnNsFv5XzXez3hiMklkA0Hz+3NDQ1wokE
         +lJVQUbKey8jg==
Date:   Sat, 29 Jul 2023 09:42:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [v1 3/6] memblock: add parameter to memblock_setclr_flag for
 selecting memblock_type
Message-ID: <20230729064233.GE1901145@kernel.org>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-4-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-4-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:46:21PM +0100, Usama Arif wrote:
> This is in preparation for setting flags (for e.g. to not initialize
> struct pages) on reserved memory region.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/memblock.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f9e61e565a53..4fd431d16ef2 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -897,11 +897,16 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>   * Return: 0 on success, -errno on failure.
>   */
>  static int __init_memblock memblock_setclr_flag(phys_addr_t base,
> -				phys_addr_t size, int set, int flag)
> +				phys_addr_t size, int set, int flag, bool reserved)
>  {

Please pass struct memblock_type * as the first parameter and set the flags
unconditionally.
The boolean parameters make code less readable. Besides if we'll add more
flags for reserved regions it'll become really hairy.

> -	struct memblock_type *type = &memblock.memory;
> +	struct memblock_type *type;
>  	int i, ret, start_rgn, end_rgn;
>  
> +	if (reserved)
> +		type = &memblock.reserved;
> +	else
> +		type = &memblock.memory;
> +
>  	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
>  	if (ret)
>  		return ret;
> @@ -928,7 +933,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>   */
>  int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG, 0);
>  }
>  
>  /**
> @@ -940,7 +945,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG, 0);
>  }
>  
>  /**
> @@ -957,7 +962,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>  
>  	system_has_some_mirror = true;
>  
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR, 0);
>  }
>  
>  /**
> @@ -977,7 +982,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP, 0);
>  }
>  
>  /**
> @@ -989,7 +994,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
>  }
>  
>  static bool should_skip_region(struct memblock_type *type,
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
