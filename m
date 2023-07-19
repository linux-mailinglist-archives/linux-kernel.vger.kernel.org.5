Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4C758D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSFpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSFpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8D1BF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D344060DC7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0156BC433C7;
        Wed, 19 Jul 2023 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689745497;
        bh=IfoJE0zPjK1ppvZCoH2Y9VSMGRPBr9T1+ihlhDAbYx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFSF08aTY7rP2st7xworYXgiG7h3RVLVpmQmMBLy+NQfCszJ6dzFiBrd4qeoyvYpW
         /RdA6PVyplI9G77BOsYXfg/NmHaUXulfaX2FsKFPFJopy2Or0RHceOaliaEwYGuiN7
         vl8SAVekcfiuAwiW1WxpEgJ0lijG9EMe4RFFWpiz6SwR8EaNz/SvcJV8RRBJXCa+mW
         4Cy5xNleZX0nd7OJ2P2pnuS9HGN84wQmA/q+9440LNuGp8EvMTmqDpl8K2fMBom+Sv
         064pOFirCjgvJhYvvKonUBtuM4y4MeaVrvjLuwFinnSI21BfmV1SyEz9xtScgmSSPI
         9nyiMkl0s2c5g==
Date:   Wed, 19 Jul 2023 08:44:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230719054434.GG1901145@kernel.org>
References: <20230718220106.GA3117638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718220106.GA3117638@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 18, 2023 at 04:01:06PM -0600, Ross Zwisler wrote:
> Hello,
> 
> I've been trying to use the 'movablecore=' kernel command line option to create
> a ZONE_MOVABLE memory zone on my x86_64 systems, and have noticed that
> offlining the resulting ZONE_MOVABLE area consistently fails in my setups
> because that zone contains unmovable pages.  My testing has been in a x86_64
> QEMU VM with a single NUMA node and 4G, 8G or 16G of memory, all of which fail
> 100% of the time.
> 
> Digging into it a bit, these unmovable pages are Reserved pages which were
> allocated in early boot as part of the memblock allocator.  Many of these
> allocations are for data structures for the SPARSEMEM memory model, including
> 'struct mem_section' objects.  These memblock allocations can be tracked by
> setting the 'memblock=debug' kernel command line parameter, and are marked as
> reserved in:
> 
> 	memmap_init_reserved_pages()
> 		reserve_bootmem_region()
> 
> With the command line params 'movablecore=256M memblock=debug' and a v6.5.0-rc2
> kernel I get the following on my 4G system:
> 
>   # lsmem --split ZONES --output-all
>   RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
>   0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
>   0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
>   0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
>   0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
>   
>   Memory block size:       128M
>   Total online memory:       4G
>   Total offline memory:      0B
> 
> And when I try to offline memory block 39, I get:
> 
>   # echo 0 > /sys/devices/system/memory/memory39/online
>   bash: echo: write error: Device or resource busy
> 
> with dmesg saying:
> 
>   [   57.439849] page:0000000076a3e320 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ff00
>   [   57.444073] flags: 0x1fffffc0001000(reserved|node=0|zone=3|lastcpupid=0x1fffff)
>   [   57.447301] page_type: 0xffffffff()
>   [   57.448754] raw: 001fffffc0001000 ffffdd6384ffc008 ffffdd6384ffc008 0000000000000000
>   [   57.450383] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>   [   57.452011] page dumped because: unmovable page
> 
> Looking back at the memblock allocations, I can see that the physical address for
> pfn:0x13ff00 was used in a memblock allocation:
> 
>   [    0.395180] memblock_reserve: [0x000000013ff00000-0x000000013ffbffff] memblock_alloc_range_nid+0xe0/0x150
> 
> The full dmesg output can be found here: https://pastebin.com/cNztqa4u
> 
> The 'movablecore=' command line parameter is handled in
> 'find_zone_movable_pfns_for_nodes()', which decides where ZONE_MOVABLE should
> start and end.  Currently ZONE_MOVABLE is always located at the end of a NUMA
> node.
> 
> The issue is that the memblock allocator and the processing of the movablecore=
> command line parameter don't know about one another, and in my x86_64 testing
> they both always use memory at the end of the NUMA node and have collisions.
> 
> From several comments in the code I believe that this is a known issue:
> 
> https://elixir.bootlin.com/linux/v6.5-rc2/source/mm/page_isolation.c#L59
> 	/*
> 	 * Both, bootmem allocations and memory holes are marked
> 	 * PG_reserved and are unmovable. We can even have unmovable
> 	 * allocations inside ZONE_MOVABLE, for example when
> 	 * specifying "movablecore".
> 	 */
> 
> https://elixir.bootlin.com/linux/v6.5-rc2/source/include/linux/mmzone.h#L765
> 	 * 2. memblock allocations: kernelcore/movablecore setups might create
> 	 *    situations where ZONE_MOVABLE contains unmovable allocations
> 	 *    after boot. Memory offlining and allocations fail early.
> 
> We check for these unmovable pages by scanning for 'PageReserved()' in the area
> we are trying to offline, which happens in has_unmovable_pages().
> 
> Interestingly, the boot timing works out like this:
> 
> 1. Allocate memblock areas to set up the SPARSEMEM model.
>   [    0.369990] Call Trace:
>   [    0.370404]  <TASK>
>   [    0.370759]  ? dump_stack_lvl+0x43/0x60
>   [    0.371410]  ? sparse_init_nid+0x2dc/0x560
>   [    0.372116]  ? sparse_init+0x346/0x450
>   [    0.372755]  ? paging_init+0xa/0x20
>   [    0.373349]  ? setup_arch+0xa6a/0xfc0
>   [    0.373970]  ? slab_is_available+0x5/0x20
>   [    0.374651]  ? start_kernel+0x5e/0x770
>   [    0.375290]  ? x86_64_start_reservations+0x14/0x30
>   [    0.376109]  ? x86_64_start_kernel+0x71/0x80
>   [    0.376835]  ? secondary_startup_64_no_verify+0x167/0x16b
>   [    0.377755]  </TASK>
> 
> 2. Process movablecore= kernel command line parameter and set up memory zones
>   [    0.489382] Call Trace:
>   [    0.489818]  <TASK>
>   [    0.490187]  ? dump_stack_lvl+0x43/0x60
>   [    0.490873]  ? free_area_init+0x115/0xc80
>   [    0.491588]  ? __printk_cpu_sync_put+0x5/0x30
>   [    0.492354]  ? dump_stack_lvl+0x48/0x60
>   [    0.493002]  ? sparse_init_nid+0x2dc/0x560
>   [    0.493697]  ? zone_sizes_init+0x60/0x80
>   [    0.494361]  ? setup_arch+0xa6a/0xfc0
>   [    0.494981]  ? slab_is_available+0x5/0x20
>   [    0.495674]  ? start_kernel+0x5e/0x770
>   [    0.496312]  ? x86_64_start_reservations+0x14/0x30
>   [    0.497123]  ? x86_64_start_kernel+0x71/0x80
>   [    0.497847]  ? secondary_startup_64_no_verify+0x167/0x16b
>   [    0.498768]  </TASK>
> 
> 3. Mark memblock areas as Reserved.
>   [    0.761136] Call Trace:
>   [    0.761534]  <TASK>
>   [    0.761876]  dump_stack_lvl+0x43/0x60
>   [    0.762474]  reserve_bootmem_region+0x1e/0x170
>   [    0.763201]  memblock_free_all+0xe3/0x250
>   [    0.763862]  ? swiotlb_init_io_tlb_mem.constprop.0+0x11a/0x130
>   [    0.764812]  ? swiotlb_init_remap+0x195/0x2c0
>   [    0.765519]  mem_init+0x19/0x1b0
>   [    0.766047]  mm_core_init+0x9c/0x3d0
>   [    0.766630]  start_kernel+0x264/0x770
>   [    0.767229]  x86_64_start_reservations+0x14/0x30
>   [    0.767987]  x86_64_start_kernel+0x71/0x80
>   [    0.768666]  secondary_startup_64_no_verify+0x167/0x16b
>   [    0.769534]  </TASK>
> 
> So, during ZONE_MOVABLE setup we currently can't do the same
> has_unmovable_pages() scan looking for PageReserved() to check for overlap
> because the pages have not yet been marked as Reserved.
> 
> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> allocations, because this issue essentially makes the movablecore= kernel
> command line parameter useless in many cases, as the ZONE_MOVABLE region it
> creates will often actually be unmovable.
> 
> Here are the options I currently see for resolution:
> 
> 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
> the beginning of the NUMA node instead of the end. This should fix my use case,
> but again is prone to breakage in other configurations (# of NUMA nodes, other
> architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
> think that this should be relatively straightforward and low risk, though.
> 
> 2. Make the code which processes the movablecore= command line option aware of
> the memblock allocations, and have it choose a region for ZONE_MOVABLE which
> does not have these allocations. This might be done by checking for
> PageReserved() as we do with offlining memory, though that will take some boot
> time reordering, or we'll have to figure out the overlap in another way. This
> may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
> a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?  If
> we can get it working, this seems like the most correct solution to me, but
> also the most difficult and risky because it involves significant changes in
> the code for memory setup at early boot.
> 
> Am I missing anything are there other solutions we should consider, or do you
> have an opinion on which solution we should pursue?

I'd add

3. Switch memblock to use bottom up allocations. Historically memblock
allocated memory from the top to avoid corrupting the kernel image and to
avoid exhausting precious ZONE_DMA. I believe we can use bottom-up
allocations with lower limit of memblock allocations set to 16M.

With the hack below no memblock allocations will end up in ZONE_MOVABLE:

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..5e940f057dd4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1116,6 +1116,7 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
+	memblock_set_bottom_up(true);
 
 	/*
 	 * Needs to run after memblock setup because it needs the physical
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..ed1e14a2a62d 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -660,16 +660,6 @@ static int __init numa_init(int (*init_func)(void))
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * We reset memblock back to the top-down direction
-	 * here because if we configured ACPI_NUMA, we have
-	 * parsed SRAT in init_func(). It is ok to have the
-	 * reset here even if we did't configure ACPI_NUMA
-	 * or acpi numa init fails and fallbacks to dummy
-	 * numa init.
-	 */
-	memblock_set_bottom_up(false);
-
 	ret = numa_cleanup_meminfo(&numa_meminfo);
 	if (ret < 0)
 		return ret;
diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..7ba040bf8da2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1388,6 +1388,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					bool exact_nid)
 {
 	enum memblock_flags flags = choose_memblock_flags();
+	phys_addr_t min = SZ_16M;
 	phys_addr_t found;
 
 	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
@@ -1400,13 +1401,13 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	}
 
 again:
-	found = memblock_find_in_range_node(size, align, start, end, nid,
+	found = memblock_find_in_range_node(size, align, min, end, nid,
 					    flags);
 	if (found && !memblock_reserve(found, size))
 		goto done;
 
 	if (nid != NUMA_NO_NODE && !exact_nid) {
-		found = memblock_find_in_range_node(size, align, start,
+		found = memblock_find_in_range_node(size, align, min,
 						    end, NUMA_NO_NODE,
 						    flags);
 		if (found && !memblock_reserve(found, size))
@@ -1420,6 +1421,11 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		goto again;
 	}
 
+	if (start < min) {
+		min = start;
+		goto again;
+	}
+
 	return 0;
 
 done:
 
> Thanks,
> - Ross

-- 
Sincerely yours,
Mike.
