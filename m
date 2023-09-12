Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F093979D074
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjILL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjILL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:57:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 052531703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:57:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5521C15;
        Tue, 12 Sep 2023 04:57:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE083F67D;
        Tue, 12 Sep 2023 04:57:16 -0700 (PDT)
Message-ID: <2b4a7aee-1997-cf2f-e8e8-19ab4adc09b5@arm.com>
Date:   Tue, 12 Sep 2023 12:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dma-mapping: fix dma_addressing_limited if dma_range_map
 is scanned
Content-Language: en-GB
To:     Jia He <justin.he@arm.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <20230912084002.2168-1-justin.he@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230912084002.2168-1-justin.he@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 9:40 am, Jia He wrote:
> After scanning the dma_range_map, if it is found that not all of the
> system RAM ranges are encompassed within it, an incorrect calculation
> occurs for dma_addressing_limited(), which prevents the nvme device
> dma mapping in the checking path of phys_to_dma().

Nit: the subject and this description aren't very clear - the key point 
here is the unusual case that the range map covers right up to the top 
of system RAM, but leaves a hole somewhere lower down. There's no issue 
with the more typical case where some RAM exists above the top of the 
range map, since bus_dma_limit will capture that and work as expected.

> E.g. On an Armv8 Ampere server, the dsdt ACPI table is:
>   Method (_DMA, 0, Serialized)  // _DMA: Direct Memory Access
>              {
>                  Name (RBUF, ResourceTemplate ()
>                  {
>                      QWordMemory (ResourceConsumer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
>                          0x0000000000000000, // Granularity
>                          0x0000000000000000, // Range Minimum
>                          0x00000000FFFFFFFF, // Range Maximum
>                          0x0000000000000000, // Translation Offset
>                          0x0000000100000000, // Length
>                          ,, , AddressRangeMemory, TypeStatic)
>                      QWordMemory (ResourceConsumer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
>                          0x0000000000000000, // Granularity
>                          0x0000006010200000, // Range Minimum
>                          0x000000602FFFFFFF, // Range Maximum
>                          0x0000000000000000, // Translation Offset
>                          0x000000001FE00000, // Length
>                          ,, , AddressRangeMemory, TypeStatic)
>                      QWordMemory (ResourceConsumer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
>                          0x0000000000000000, // Granularity
>                          0x00000060F0000000, // Range Minimum
>                          0x00000060FFFFFFFF, // Range Maximum
>                          0x0000000000000000, // Translation Offset
>                          0x0000000010000000, // Length
>                          ,, , AddressRangeMemory, TypeStatic)
>                      QWordMemory (ResourceConsumer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
>                          0x0000000000000000, // Granularity
>                          0x0000007000000000, // Range Minimum
>                          0x000003FFFFFFFFFF, // Range Maximum
>                          0x0000000000000000, // Translation Offset
>                          0x0000039000000000, // Length
>                          ,, , AddressRangeMemory, TypeStatic)
>                  })
> 
> But the System RAM ranges are:
> cat /proc/iomem |grep -i ram
> 90000000-91ffffff : System RAM
> 92900000-fffbffff : System RAM
> 880000000-fffffffff : System RAM
> 8800000000-bff5990fff : System RAM
> bff59d0000-bff5a4ffff : System RAM
> bff8000000-bfffffffff : System RAM
> So some RAM ranges are out of dma_range_map.
> 
> Fixes it by checking whether each of the system RAM resources can be
> properly encompassed within the dma_range_map.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>   include/linux/dma-mapping.h |  8 +++++--
>   kernel/dma/mapping.c        | 45 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f0ccca16a0ac..d9d1c67c8579 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -144,6 +144,7 @@ bool dma_pci_p2pdma_supported(struct device *dev);
>   int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>   u64 dma_get_required_mask(struct device *dev);
> +bool all_ram_in_dma_range_map(struct device *dev);
>   size_t dma_max_mapping_size(struct device *dev);
>   size_t dma_opt_mapping_size(struct device *dev);
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
> @@ -475,8 +476,11 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>    */
>   static inline bool dma_addressing_limited(struct device *dev)
>   {
> -	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> -			    dma_get_required_mask(dev);
> +	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> +						dma_get_required_mask(dev))

Nit: indentation

> +		return true;
> +
> +	return !all_ram_in_dma_range_map(dev);
>   }
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index e323ca48f7f2..ab407deb81b8 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -14,6 +14,7 @@
>   #include <linux/of_device.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
> +#include <linux/dma-direct.h>

Nit: please keep the includes sorted alphabetically, however I do wonder 
whether this whole thing shouldn't belong in dma-direct anyway.

>   #include "debug.h"
>   #include "direct.h"
>   
> @@ -819,6 +820,50 @@ size_t dma_opt_mapping_size(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
>   
> +/*
> + * To check whether all ram resource ranges are mapped in dma range map
> + * Returns 0 when continuous check is needed
> + * Returns 1 if there is some ram range can't be mapped to dma_range_map
> + */
> +static int check_ram_in_range_map(unsigned long start_pfn,
> +				  unsigned long nr_pages, void *data)
> +{
> +	phys_addr_t end_paddr = (start_pfn + nr_pages) << PAGE_SHIFT;

This could still wrap to 0 on 32-bit. I think the robust thing to do is 
either spray some extra -1s and +1s around to make all the "end" values 
inclusive limits, or maybe just do everything in units of pages rather 
than bytes (i.e. use PFN_DOWN() on the bus_dma_region entry values).

> +	phys_addr_t start_paddr = start_pfn << PAGE_SHIFT;
> +	struct device *dev = (struct device *)data;
> +	struct bus_dma_region *region = NULL;
> +	const struct bus_dma_region *m;
> +
> +	while (start_paddr < end_paddr) {
> +		// find region containing start_paddr

Nit: inconsistent comment style (although it's not a particularly 
valuable comment anyway, IMO the loop itself is clear enough).

Thanks,
Robin.

> +		for (m = dev->dma_range_map; m->size; m++) {
> +			if (start_paddr >= m->cpu_start
> +			    && start_paddr - m->cpu_start < m->size) {
> +				region = (struct bus_dma_region *)m;
> +				break;
> +			}
> +		}
> +		if (!region)
> +			return 1;
> +
> +		start_paddr = region->cpu_start + region->size;
> +		/* handle overflow of phys_addr_t */
> +		if (start_paddr == 0)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +bool all_ram_in_dma_range_map(struct device *dev)
> +{
> +	if (!dev->dma_range_map)
> +		return 1;
> +
> +	return !walk_system_ram_range(0, ULONG_MAX, dev, check_ram_in_range_map);
> +}
> +EXPORT_SYMBOL_GPL(all_ram_in_dma_range_map);
> +
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
