Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8D7587EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGRWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGRWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF081997
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7836272f36eso294087239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689717670; x=1692309670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvXtdjiTdSu7pRelEcHGOcRS4iWAssoWYQyugv4oWIQ=;
        b=zQOyvfMDZir+7hpHfKayyWYecVl7ZFPqcSf2Yq2eh9hlGt8SxPV0tbJZZfI6jcCUSk
         I2N3wzhtJOlYCu/Iaoi1pYGCU21nxKnlXrbJVD8/LAs96v2ehgagcDFNHce450Grl8+Q
         h4kXyTuMfmlSKEDp0pCLXAswN7AEnU8iInHqh/eT+viITxM65pLHB44Oz8Ux4OvRE085
         OjLtmXN73t5fdHTMKLxV3qR6n75Aws6IVQRUMVIlYh2wuiIsoS0LP9c7trwsyHJ3Pth7
         8EFFDcttjDJ7ClHaWPVqJWfbTAZYHnXanhKPqQ8CO4yyTq6+P+7MH8zr+hhR9E28u/7L
         XilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717670; x=1692309670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvXtdjiTdSu7pRelEcHGOcRS4iWAssoWYQyugv4oWIQ=;
        b=l+yS2RonV3tx5+6XrOrQAiHl0ZQObuD5s6pjdX5ni0k0+GUxS8cSLJ/SJ7wPMHKNAn
         nDXmEg7iO6khOCTlJt7StBMp9SZclP1fAXn96avVof6PaOGlS5WmicYtEsAEiemuoxly
         TtOOAOcDCAZNYpPCth7xPEPFUB3qxJxnWjS5rn4c3CSdehNpaRtDLMxI5Z+TlP0/OUGI
         2DAN1RgNZzzwvJBVlgoAo59Pa5J0ggzr3IBBmB6uI7sKlqzRbapcK34Alwwz9djDwxyb
         keTLXcdKP5ujym97x7j0V8NSXzdTQfyHRybKQzGX44MVl/L4+zlidTsBrxaK5JLTmiz/
         S19A==
X-Gm-Message-State: ABy/qLbmG3Iy6B9URilC/UYgRoauJ4DqYxaccV/8oEkYJDYIh4PuGfEX
        0haj4La1JadaHHcIjiGqPUWPnrKoJ4MCCd2v+Yx4sw==
X-Google-Smtp-Source: APBJJlEIvyhsuAY/IAmmsxTlJjteq7JzxRm+oSSx0aQac6TD2PdPOPWHCK5RTKNhyDnxcXMM++CBeA==
X-Received: by 2002:a5d:9ada:0:b0:785:fbe8:1da0 with SMTP id x26-20020a5d9ada000000b00785fbe81da0mr3178779ion.15.1689717670404;
        Tue, 18 Jul 2023 15:01:10 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:1ddf:dfe:d771:e9d2])
        by smtp.gmail.com with ESMTPSA id h8-20020a6bfb08000000b0077e24ace3edsm865699iog.52.2023.07.18.15.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:09 -0700 (PDT)
Date:   Tue, 18 Jul 2023 16:01:06 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230718220106.GA3117638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been trying to use the 'movablecore=' kernel command line option to create
a ZONE_MOVABLE memory zone on my x86_64 systems, and have noticed that
offlining the resulting ZONE_MOVABLE area consistently fails in my setups
because that zone contains unmovable pages.  My testing has been in a x86_64
QEMU VM with a single NUMA node and 4G, 8G or 16G of memory, all of which fail
100% of the time.

Digging into it a bit, these unmovable pages are Reserved pages which were
allocated in early boot as part of the memblock allocator.  Many of these
allocations are for data structures for the SPARSEMEM memory model, including
'struct mem_section' objects.  These memblock allocations can be tracked by
setting the 'memblock=debug' kernel command line parameter, and are marked as
reserved in:

	memmap_init_reserved_pages()
		reserve_bootmem_region()

With the command line params 'movablecore=256M memblock=debug' and a v6.5.0-rc2
kernel I get the following on my 4G system:

  # lsmem --split ZONES --output-all
  RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
  0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
  0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
  0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
  0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
  
  Memory block size:       128M
  Total online memory:       4G
  Total offline memory:      0B

And when I try to offline memory block 39, I get:

  # echo 0 > /sys/devices/system/memory/memory39/online
  bash: echo: write error: Device or resource busy

with dmesg saying:

  [   57.439849] page:0000000076a3e320 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ff00
  [   57.444073] flags: 0x1fffffc0001000(reserved|node=0|zone=3|lastcpupid=0x1fffff)
  [   57.447301] page_type: 0xffffffff()
  [   57.448754] raw: 001fffffc0001000 ffffdd6384ffc008 ffffdd6384ffc008 0000000000000000
  [   57.450383] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
  [   57.452011] page dumped because: unmovable page

Looking back at the memblock allocations, I can see that the physical address for
pfn:0x13ff00 was used in a memblock allocation:

  [    0.395180] memblock_reserve: [0x000000013ff00000-0x000000013ffbffff] memblock_alloc_range_nid+0xe0/0x150

The full dmesg output can be found here: https://pastebin.com/cNztqa4u

The 'movablecore=' command line parameter is handled in
'find_zone_movable_pfns_for_nodes()', which decides where ZONE_MOVABLE should
start and end.  Currently ZONE_MOVABLE is always located at the end of a NUMA
node.

The issue is that the memblock allocator and the processing of the movablecore=
command line parameter don't know about one another, and in my x86_64 testing
they both always use memory at the end of the NUMA node and have collisions.

From several comments in the code I believe that this is a known issue:

https://elixir.bootlin.com/linux/v6.5-rc2/source/mm/page_isolation.c#L59
	/*
	 * Both, bootmem allocations and memory holes are marked
	 * PG_reserved and are unmovable. We can even have unmovable
	 * allocations inside ZONE_MOVABLE, for example when
	 * specifying "movablecore".
	 */

https://elixir.bootlin.com/linux/v6.5-rc2/source/include/linux/mmzone.h#L765
	 * 2. memblock allocations: kernelcore/movablecore setups might create
	 *    situations where ZONE_MOVABLE contains unmovable allocations
	 *    after boot. Memory offlining and allocations fail early.

We check for these unmovable pages by scanning for 'PageReserved()' in the area
we are trying to offline, which happens in has_unmovable_pages().

Interestingly, the boot timing works out like this:

1. Allocate memblock areas to set up the SPARSEMEM model.
  [    0.369990] Call Trace:
  [    0.370404]  <TASK>
  [    0.370759]  ? dump_stack_lvl+0x43/0x60
  [    0.371410]  ? sparse_init_nid+0x2dc/0x560
  [    0.372116]  ? sparse_init+0x346/0x450
  [    0.372755]  ? paging_init+0xa/0x20
  [    0.373349]  ? setup_arch+0xa6a/0xfc0
  [    0.373970]  ? slab_is_available+0x5/0x20
  [    0.374651]  ? start_kernel+0x5e/0x770
  [    0.375290]  ? x86_64_start_reservations+0x14/0x30
  [    0.376109]  ? x86_64_start_kernel+0x71/0x80
  [    0.376835]  ? secondary_startup_64_no_verify+0x167/0x16b
  [    0.377755]  </TASK>

2. Process movablecore= kernel command line parameter and set up memory zones
  [    0.489382] Call Trace:
  [    0.489818]  <TASK>
  [    0.490187]  ? dump_stack_lvl+0x43/0x60
  [    0.490873]  ? free_area_init+0x115/0xc80
  [    0.491588]  ? __printk_cpu_sync_put+0x5/0x30
  [    0.492354]  ? dump_stack_lvl+0x48/0x60
  [    0.493002]  ? sparse_init_nid+0x2dc/0x560
  [    0.493697]  ? zone_sizes_init+0x60/0x80
  [    0.494361]  ? setup_arch+0xa6a/0xfc0
  [    0.494981]  ? slab_is_available+0x5/0x20
  [    0.495674]  ? start_kernel+0x5e/0x770
  [    0.496312]  ? x86_64_start_reservations+0x14/0x30
  [    0.497123]  ? x86_64_start_kernel+0x71/0x80
  [    0.497847]  ? secondary_startup_64_no_verify+0x167/0x16b
  [    0.498768]  </TASK>

3. Mark memblock areas as Reserved.
  [    0.761136] Call Trace:
  [    0.761534]  <TASK>
  [    0.761876]  dump_stack_lvl+0x43/0x60
  [    0.762474]  reserve_bootmem_region+0x1e/0x170
  [    0.763201]  memblock_free_all+0xe3/0x250
  [    0.763862]  ? swiotlb_init_io_tlb_mem.constprop.0+0x11a/0x130
  [    0.764812]  ? swiotlb_init_remap+0x195/0x2c0
  [    0.765519]  mem_init+0x19/0x1b0
  [    0.766047]  mm_core_init+0x9c/0x3d0
  [    0.766630]  start_kernel+0x264/0x770
  [    0.767229]  x86_64_start_reservations+0x14/0x30
  [    0.767987]  x86_64_start_kernel+0x71/0x80
  [    0.768666]  secondary_startup_64_no_verify+0x167/0x16b
  [    0.769534]  </TASK>

So, during ZONE_MOVABLE setup we currently can't do the same
has_unmovable_pages() scan looking for PageReserved() to check for overlap
because the pages have not yet been marked as Reserved.

I do think that we need to fix this collision between ZONE_MOVABLE and memmap
allocations, because this issue essentially makes the movablecore= kernel
command line parameter useless in many cases, as the ZONE_MOVABLE region it
creates will often actually be unmovable.

Here are the options I currently see for resolution:

1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
the beginning of the NUMA node instead of the end. This should fix my use case,
but again is prone to breakage in other configurations (# of NUMA nodes, other
architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
think that this should be relatively straightforward and low risk, though.

2. Make the code which processes the movablecore= command line option aware of
the memblock allocations, and have it choose a region for ZONE_MOVABLE which
does not have these allocations. This might be done by checking for
PageReserved() as we do with offlining memory, though that will take some boot
time reordering, or we'll have to figure out the overlap in another way. This
may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?  If
we can get it working, this seems like the most correct solution to me, but
also the most difficult and risky because it involves significant changes in
the code for memory setup at early boot.

Am I missing anything are there other solutions we should consider, or do you
have an opinion on which solution we should pursue?

Thanks,
- Ross
