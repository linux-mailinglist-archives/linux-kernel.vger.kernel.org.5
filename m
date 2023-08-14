Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E277BD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHNQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjHNQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5627710E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48DD61A8D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E2C433C8;
        Mon, 14 Aug 2023 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692028816;
        bh=jhjaS/2Y9cwyx9ts23hmnkLwn6OVV/aozByHwgTXnW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tt7RxJi+gxkL2yCcnmyoOFprL73XugXUVREtoBV3EASp64W/qhZkt7Mc7T5WdejI2
         FNF3cINVYKlcQp4lbBCCnzBs9sQKkn3V1P1URs+eZGPq/WVnD/6XFtV4AqXlVT8OqE
         xA6mJBV9TK1fQBJVains9cIXKguOwxD992ctwFhwqu5lM4KMQm4+o4qm3tzODLRdDW
         0e+gZtrL1LZ+RfEMIh3sCydLyiSUsmkj00KQtZ8VuM5c35XrA/recr6ZeVviLFIaBy
         nT3QZzAtJ/q7/Q8L7n0mq8ZxTC19iON58m+xD3wM5Sg9vw7m0o/jzDO8VrQ6kiXPBm
         GKHeXxQOxAilg==
Date:   Mon, 14 Aug 2023 18:59:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, zhoubinbin@loongson.cn,
        chenfeiyang@loongson.cn, jiaxun.yang@flygoat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        luto@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@xen0n.name, chenhuacai@kernel.org
Subject: Re: [RESEND PATCH V3] NUMA:Improve the efficiency of calculating
 pages loss
Message-ID: <20230814155911.GN2607694@kernel.org>
References: <CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFOccN4kjJqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFOccN4kjJqA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:32:51PM +0800, Liam Ni wrote:
> Optimize the way of calculating missing pages.
> 
> In the previous implementation, We calculate missing pages as follows:
> 1. calculate numaram by traverse all the numa_meminfo's and for each of
> them traverse all the regions in memblock.memory to prepare for
> counting missing pages.
> 
> 2. Traverse all the regions in memblock.memory again to get e820ram.
> 
> 3. the missing page is (e820ram - numaram )
> 
> But,it's enough to count memory in ‘memblock.memory’ that doesn't have
> the node assigned.
> 
> V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.com/
> V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail.com/
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/loongarch/kernel/numa.c | 23 ++++++++---------------
>  arch/x86/mm/numa.c           | 26 +++++++-------------------
>  include/linux/mm.h           |  1 +
>  mm/mm_init.c                 | 20 ++++++++++++++++++++
>  4 files changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 708665895b47..0239891e4d19 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -262,25 +262,18 @@ static void __init node_mem_init(unsigned int node)
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init memblock_validate_numa_coverage(const u64 limit)

There is no need to have arch specific memblock_validate_numa_coverage().
You can add this function to memblock and call it from NUMA initialization
instead of numa_meminfo_cover_memory().

The memblock_validate_numa_coverage() will count all the pages without node
ID set and compare to the threshold provided by the architectures.

>  {
> -       int i;
> -       u64 numaram, biosram;
> +       u64 lo_pg;
> 
> -       numaram = 0;
> -       for (i = 0; i < mi->nr_blks; i++) {
> -               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> +       lo_pg = max_pfn - calculate_without_node_pages_in_range();
> 
> -               numaram += e - s;
> -               numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -               if ((s64)numaram < 0)
> -                       numaram = 0;
> +       /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> +       if (lo_pg >= limit) {
> +               pr_err("NUMA: We lost 1m size page.\n");
> +               return false;
>         }
> -       max_pfn = max_low_pfn;
> -       biosram = max_pfn - absent_pages_in_range(0, max_pfn);
> 
> -       BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
>         return true;
>  }
> 
> @@ -428,7 +421,7 @@ int __init init_numa_memory(void)
>                 return -EINVAL;
> 
>         init_node_memblock();
> -       if (numa_meminfo_cover_memory(&numa_meminfo) == false)
> +       if (memblock_validate_numa_coverage(SZ_1M) == false)
>                 return -EINVAL;
> 
>         for_each_node_mask(node, node_possible_map) {
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..14feec144675 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -451,30 +451,18 @@ EXPORT_SYMBOL(__node_distance);
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init memblock_validate_numa_coverage(const u64 limit)
>  {
> -       u64 numaram, e820ram;
> -       int i;
> +       u64 lo_pg;
> 
> -       numaram = 0;
> -       for (i = 0; i < mi->nr_blks; i++) {
> -               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -               numaram += e - s;
> -               numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -               if ((s64)numaram < 0)
> -                       numaram = 0;
> -       }
> -
> -       e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> +       lo_pg = max_pfn - calculate_without_node_pages_in_range();
> 
>         /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -       if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> -               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your
> %LuMB e820 RAM. Not used.\n",
> -                      (numaram << PAGE_SHIFT) >> 20,
> -                      (e820ram << PAGE_SHIFT) >> 20);
> +       if (lo_pg >= limit) {
> +               pr_err("NUMA: We lost 1m size page.\n");
>                 return false;
>         }
> +
>         return true;
>  }
> 
> @@ -583,7 +571,7 @@ static int __init numa_register_memblks(struct
> numa_meminfo *mi)
>                         return -EINVAL;
>                 }
>         }
> -       if (!numa_meminfo_cover_memory(mi))
> +       if (!memblock_validate_numa_coverage(SZ_1M))
>                 return -EINVAL;
> 
>         /* Finally register nodes. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0daef3f2f029..b32457ad1ae3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3043,6 +3043,7 @@ unsigned long __absent_pages_in_range(int nid,
> unsigned long start_pfn,
>                                                 unsigned long end_pfn);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>                                                 unsigned long end_pfn);
> +extern unsigned long calculate_without_node_pages_in_range(void);
>  extern void get_pfn_range_for_nid(unsigned int nid,
>                         unsigned long *start_pfn, unsigned long *end_pfn);
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ddd18a89b66..13a4883787e3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1132,6 +1132,26 @@ static void __init
> adjust_zone_range_for_zone_movable(int nid,
>         }
>  }
> 
> +/**
> + * @start_pfn: The start PFN to start searching for holes
> + * @end_pfn: The end PFN to stop searching for holes
> + *
> + * Return: Return the number of page frames without node assigned
> within a range.
> + */
> +unsigned long __init calculate_without_node_pages_in_range(void)
> +{
> +       unsigned long num_pages;
> +       unsigned long start_pfn, end_pfn;
> +       int nid, i;
> +
> +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> +               if (nid == NUMA_NO_NODE)
> +                       num_pages += end_pfn - start_pfn;
> +       }
> +
> +       return num_pages;
> +}
> +
>  /*
>   * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>   * then all holes in the requested range will be accounted for.
> --
> 2.25.1

-- 
Sincerely yours,
Mike.
