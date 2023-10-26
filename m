Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918B47D7C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:00:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EE115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:59:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAEFC433C8;
        Thu, 26 Oct 2023 05:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698299996;
        bh=t3J9H/h2snw+b56w9zIz6vz35i/sxpaoxI32J+Gzy5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxCfxY1Kmyk9puXLiX3QWldxdqhhHYeeKrw7GPEdnlQ7bWr6ni7VPdkfmANFQ4fCz
         ++ILmouYywP335eyCjg8+XjeV8zS8ibSEEQDtTnZqYZjzk+UotDtGpPIw4DWGBXlV7
         D0HY9lEJ3NVE7ZjDH7AEHkBRnWkDReOcmxhm5R3YoaVETRTPKFc0N+HLbUknEgaKar
         PzLaVpbEzyLjKzFqlP2g1WdWTx6yQYXd1gMu6PVdI1kF78OGf/VpU5PaVhXbYWzk0n
         /URO4tzbJMk2O5Vpp26iyn7kxYnNMTkHiB/TegrBsR3gp/KZTPJIZsKRtHwWRpbAS/
         TrU3e/uK2ll7Q==
Date:   Thu, 26 Oct 2023 08:59:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, chenhuacai@kernel.org,
        kernel@xen0n.name, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, maobibo@loongson.cn,
        chenfeiyang@loongson.cn, zhoubinbin@loongson.cn
Subject: Re: [RESEND PATCH V7] NUMA: optimize detection of memory with no
 node id assigned by firmware
Message-ID: <20231026055940.GH2824@kernel.org>
References: <20231026020329.327329-1-zhiguangni01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026020329.327329-1-zhiguangni01@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:03:29AM +0800, Liam Ni wrote:
> Sanity check that makes sure the nodes cover all memory loops over
> numa_meminfo to count the pages that have node id assigned by the firmware,
> then loops again over memblock.memory to find the total amount of memory
> and in the end checks that the difference between the total memory and
> memory that covered by nodes is less than some threshold. Worse, the loop
> over numa_meminfo calls __absent_pages_in_range() that also partially
> traverses memblock.memory.
> 
> It's much simpler and more efficient to have a single traversal of
> memblock.memory that verifies that amount of memory not covered by nodes is
> less than a threshold.
> 
> Introduce memblock_validate_numa_coverage() that does exactly that and use
> it instead of numa_meminfo_cover_memory().
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/loongarch/kernel/numa.c | 28 +---------------------------
>  arch/x86/mm/numa.c           | 34 ++--------------------------------
>  include/linux/memblock.h     |  1 +
>  mm/memblock.c                | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index cb00804826f7..0e69679bfc8d 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -226,32 +226,6 @@ static void __init node_mem_init(unsigned int node)
>  
>  #ifdef CONFIG_ACPI_NUMA
>  
> -/*
> - * Sanity check to catch more bad NUMA configurations (they are amazingly
> - * common).  Make sure the nodes cover all memory.
> - */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> -{
> -	int i;
> -	u64 numaram, biosram;
> -
> -	numaram = 0;
> -	for (i = 0; i < mi->nr_blks; i++) {
> -		u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -		u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -
> -		numaram += e - s;
> -		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -		if ((s64)numaram < 0)
> -			numaram = 0;
> -	}
> -	max_pfn = max_low_pfn;
> -	biosram = max_pfn - absent_pages_in_range(0, max_pfn);
> -
> -	BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
> -	return true;
> -}
> -
>  static void __init add_node_intersection(u32 node, u64 start, u64 size, u32 type)
>  {
>  	static unsigned long num_physpages;
> @@ -396,7 +370,7 @@ int __init init_numa_memory(void)
>  		return -EINVAL;
>  
>  	init_node_memblock();
> -	if (numa_meminfo_cover_memory(&numa_meminfo) == false)
> +	if (!memblock_validate_numa_coverage(SZ_1M))
>  		return -EINVAL;
>  
>  	for_each_node_mask(node, node_possible_map) {
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..4079c9edaa93 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -447,37 +447,6 @@ int __node_distance(int from, int to)
>  }
>  EXPORT_SYMBOL(__node_distance);
>  
> -/*
> - * Sanity check to catch more bad NUMA configurations (they are amazingly
> - * common).  Make sure the nodes cover all memory.
> - */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> -{
> -	u64 numaram, e820ram;
> -	int i;
> -
> -	numaram = 0;
> -	for (i = 0; i < mi->nr_blks; i++) {
> -		u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -		u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -		numaram += e - s;
> -		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -		if ((s64)numaram < 0)
> -			numaram = 0;
> -	}
> -
> -	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> -
> -	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> -		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
> -		       (numaram << PAGE_SHIFT) >> 20,
> -		       (e820ram << PAGE_SHIFT) >> 20);
> -		return false;
> -	}
> -	return true;
> -}
> -
>  /*
>   * Mark all currently memblock-reserved physical memory (which covers the
>   * kernel's own memory ranges) as hot-unswappable.
> @@ -583,7 +552,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>  			return -EINVAL;
>  		}
>  	}
> -	if (!numa_meminfo_cover_memory(mi))
> +
> +	if (!memblock_validate_numa_coverage(SZ_1M))
>  		return -EINVAL;
>  
>  	/* Finally register nodes. */
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 1c1072e3ca06..a94efe977539 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -120,6 +120,7 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
> +bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 0863222af4a4..397d61c4896a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -734,6 +734,40 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
>  	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
>  }
>  
> +/**
> + * memblock_validate_numa_coverage - check if amount of memory with
> + * no node ID assigned is less than a threshold
> + * @threshold_bytes: maximal number of pages that can have unassigned node
> + * ID (in bytes).
> + *
> + * A buggy firmware may report memory that does not belong to any node.
> + * Check if amount of such memory is below @threshold_bytes.
> + *
> + * Return: true on success, false on failure.
> + */
> +bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_bytes)
> +{
> +	unsigned long nr_pages = 0;
> +	unsigned long start_pfn, end_pfn, mem_size_mb;
> +	int nid, i;
> +
> +	/* calculate lose page */
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> +		if (nid == NUMA_NO_NODE)
> +			nr_pages += end_pfn - start_pfn;
> +	}
> +
> +	if ((nr_pages << PAGE_SHIFT) >= threshold_bytes) {
> +		mem_size_mb = memblock_phys_mem_size() >> 20;
> +		pr_err("NUMA: no nodes coverage for %luMB of %luMB RAM\n",
> +		       (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +
>  /**
>   * memblock_isolate_range - isolate given range into disjoint memblocks
>   * @type: memblock type to isolate range for
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
