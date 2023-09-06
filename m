Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4E793C68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjIFMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjIFMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:02:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893210F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE5C433C7;
        Wed,  6 Sep 2023 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694001753;
        bh=q+ygTF8Sz49mjT86dwdndFEl1wHyqfAEeqoYnTLNyGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4gSYhhWb41sEFzjBM4Wa0QAmG9tJCgHQyQwwJDbQ90H9pFR8n88pnukSZjfn3u3y
         fIH3EuX15fHKYDtmPPkQ3sVPSz9/yWvOMVZcWpdmGwfUP0Pu59lK6QnQpPXiA4Zn83
         /D7NlBucE73BK5jVzcygsJzUUT0ZJZQ07Xlfi6WhgxE/WON7h+VjeKXIoyXW1KSdz5
         7rInuyy5Cp29Q2JHf/Gi+jX/3onWjHnyP4t5RQVoGHKfTFGsq/u7kUdHLIYDDwU2ON
         ooUqPBi0XuPMlPDEiZyEdgCrEJRyL28dtd8YNV7wjoDxjtyQLg0zybLNJE8vwH/+j6
         mvwh4l84d+/ZA==
Date:   Wed, 6 Sep 2023 15:01:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v4 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Message-ID: <20230906120148.GJ3223@kernel.org>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-4-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906112605.2286994-4-usama.arif@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:26:04PM +0100, Usama Arif wrote:
> For reserved memory regions marked with this flag,
> reserve_bootmem_region is not called during memmap_init_reserved_pages.
> This can be used to avoid struct page initialization for
> regions which won't need them, for e.g. hugepages with
> HVO enabled.

Nit: please spell out HVO, otherwise
 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 33 ++++++++++++++++++++++++++++-----
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 1c1072e3ca06..ae3bde302f70 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
>   * via a driver, and never indicated in the firmware-provided memory map as
>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>   * kernel resource tree.
> + * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
> + * not initialized (only for reserved regions).
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -47,6 +49,7 @@ enum memblock_flags {
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>  };
>  
>  /**
> @@ -125,6 +128,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> +int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free_all(void);
>  void memblock_free(void *ptr, size_t size);
> @@ -259,6 +263,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_NOMAP;
>  }
>  
> +static inline bool memblock_is_reserved_noinit(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_RSRV_NOINIT;
> +}
> +
>  static inline bool memblock_is_driver_managed(struct memblock_region *m)
>  {
>  	return m->flags & MEMBLOCK_DRIVER_MANAGED;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a49efbaee7e0..8f7a0cb668d4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -996,6 +996,24 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>  	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
>  }
>  
> +/**
> + * memblock_reserved_mark_noinit - Mark a reserved memory region with flag
> + * MEMBLOCK_RSRV_NOINIT which results in the struct pages not being initialized
> + * for this region.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * struct pages will not be initialized for reserved memory regions marked with
> + * %MEMBLOCK_RSRV_NOINIT.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
> +				    MEMBLOCK_RSRV_NOINIT);
> +}
> +
>  static bool should_skip_region(struct memblock_type *type,
>  			       struct memblock_region *m,
>  			       int nid, int flags)
> @@ -2112,13 +2130,18 @@ static void __init memmap_init_reserved_pages(void)
>  		memblock_set_node(start, end, &memblock.reserved, nid);
>  	}
>  
> -	/* initialize struct pages for the reserved regions */
> +	/*
> +	 * initialize struct pages for reserved regions that don't have
> +	 * the MEMBLOCK_RSRV_NOINIT flag set
> +	 */
>  	for_each_reserved_mem_region(region) {
> -		nid = memblock_get_region_node(region);
> -		start = region->base;
> -		end = start + region->size;
> +		if (!memblock_is_reserved_noinit(region)) {
> +			nid = memblock_get_region_node(region);
> +			start = region->base;
> +			end = start + region->size;
>  
> -		reserve_bootmem_region(start, end, nid);
> +			reserve_bootmem_region(start, end, nid);
> +		}
>  	}
>  }
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
