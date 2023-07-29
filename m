Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64954767CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjG2G7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2G7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FC4211
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2116068C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C40C433C8;
        Sat, 29 Jul 2023 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690613941;
        bh=MQ5sX5BNVLtCUJ5SoZaQ2/ejVdHwvmb5bb41ld3hbAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOv3AI7l4GXLDwbgcI5zIbdmjg8k8wNj1IsITudj8j6uVtJEqAAKSlzMGr/5Xr8Sn
         MeiCoDjZe9pNSmuVZVt4g/Da1qhUZs35j3l2MVV7ly1b+rAdc9PFsfc6H6PJFLYsxS
         2UJPj46MmitJCclymRUGkWtjybclbT5tAv3a8I76gVS5rXyFuUJ7FUW26nGfYDKdUL
         63lHSXBkTT0dETSvyD0J8DU8fVQ1QTtmqvDSpU5jkr2Hw0BxjGsHgjHVdAMsvnE//1
         9nXjyBqPxMqgPNHcqnDLhWoDd4H2lrHm9nn8U3FfjkRYgNXmWjwj6xsXJYodr+wQBS
         HeHEVV/3dVD/w==
Date:   Sat, 29 Jul 2023 09:58:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [v1 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Message-ID: <20230729065822.GF1901145@kernel.org>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-5-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-5-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:46:22PM +0100, Usama Arif wrote:
> For reserved memory regions marked with this flag,
> reserve_bootmem_region is not called during memmap_init_reserved_pages.
> This can be used to avoid struct page initialization for
> regions which won't need them, for e.g. hugepages with
> HVO enabled.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  include/linux/memblock.h |  7 +++++++
>  mm/memblock.c            | 32 ++++++++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..7f9d06c08592 100644
> --e a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -47,6 +47,7 @@ enum memblock_flags {
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't call reserve_bootmem_region for this region */

The comment should reflect what it does, not how.

>  };
>  
>  /**
> @@ -125,6 +126,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> +int memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size);

Please spell out reserved here.

>  void memblock_free_all(void);
>  void memblock_free(void *ptr, size_t size);
> @@ -259,6 +261,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_NOMAP;
>  }
>  
> +static inline bool memblock_is_noinit(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_RSRV_NOINIT;
> +}
> +
>  static inline bool memblock_is_driver_managed(struct memblock_region *m)
>  {
>  	return m->flags & MEMBLOCK_DRIVER_MANAGED;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4fd431d16ef2..3a15708af3b6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -997,6 +997,22 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>  	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
>  }
>  
> +/**
> + * memblock_rsrv_mark_noinit - Mark a reserved memory region with flag MEMBLOCK_RSRV_NOINIT.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * For memory regions marked with %MEMBLOCK_RSRV_NOINIT, reserve_bootmem_region
> + * is not called during memmap_init_reserved_pages, hence struct pages are not
> + * initialized for this region.

Here as well, the part of how is much less important. Here you should
emphasize that struct pages for MEMBLOCK_RSRV_NOINIT regions are not
initialized.

> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_RSRV_NOINIT, 1);
> +}
> +
>  static bool should_skip_region(struct memblock_type *type,
>  			       struct memblock_region *m,
>  			       int nid, int flags)
> @@ -2113,13 +2129,17 @@ static void __init memmap_init_reserved_pages(void)
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
> -
> -		reserve_bootmem_region(start, end, nid);
> +		if (!memblock_is_noinit(region)) {
> +			nid = memblock_get_region_node(region);
> +			start = region->base;
> +			end = start + region->size;

Please keep the empty line here
  
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
