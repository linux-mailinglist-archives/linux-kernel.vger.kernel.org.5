Return-Path: <linux-kernel+bounces-28577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3771E83003F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B21C23B10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A09463;
	Wed, 17 Jan 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBSWz74y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F418F47;
	Wed, 17 Jan 2024 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474012; cv=none; b=bLnf99uQieHxv7Jcg+PZVlr4+hgVssNKr+pP4TAT7pg00CaSE5HYxRHRka49gdaNhwtOgGlSJ0QB9cnOfab5dKn8RAbySjRv5Aemzgf5M9dCYd/nxl3I7GzoXzc2nHC3d2INr9Y+KMspvhwA/aE5Z7lyrwSmqdEx6WjB5LVyqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474012; c=relaxed/simple;
	bh=L1+4cpHaNAVqDu2nvNa5bHQAQBMX3SCYFC7ExPfRGR8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=fRQnhVcAuj1a0ckYvX2iClohm7L0seMqCG9RrqEP/LY9xNpOrhfVtRFddej0i1X03tfym4NuQkKBGHYHObtVNO66Cugqjo85VD4muSwhlK8/tN+8wDJUImG/sFkI5kHfPjevANHbwPWWNPVhkdNBYMtmRxHqfh37RtmuqTjdC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBSWz74y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267E6C433F1;
	Wed, 17 Jan 2024 06:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705474011;
	bh=L1+4cpHaNAVqDu2nvNa5bHQAQBMX3SCYFC7ExPfRGR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBSWz74ymkkxntfCUFRqRsrFuJ8NYeVJuj/MPwcTta/DoEcuVhsplYs4u82t6fnfc
	 YOgsS+Hq5lxtkTemcU13ADCupRO6e6jxanb8m2pWDbqF/b7MsfMy/FjmIgb80Glm3C
	 e69C3dvpe9xz9MRKDYQWuneeMHDxy2gct6NMHk055BiYMEeD94Qr104FoFWZHdyrHR
	 UeZO27Bu2r6k3AVNewTYa3/nHohXQNya0/MBncoeQsex2Gv28am4l9yABim5kzFXco
	 4i7Q8jxSYkqxdR3UeU4HlRSgD5cAl6Wg5XgC7mVPZ40oB/HJn0soEPUQ8kHotlyQew
	 1wXm9gWqy+nhQ==
Date: Wed, 17 Jan 2024 08:46:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Huang Pei <huangpei@loongson.cn>
Cc: Yajun Deng <yajun.deng@linux.dev>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mm@kvack.org,
	Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
	Paul Burton <paulburton@kernel.org>,
	Li Xuefeng <lixuefeng@loongson.cn>,
	Yang Tiezhu <yangtiezhu@loongson.cn>,
	Gao Juxin <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org
Subject: Re: memblock_reserve for unadded region (was: [PATCH] MIPS:
 loongson64: fix boot failure)
Message-ID: <Zad3ynuuu8S-51eI@kernel.org>
References: <20231225093025.23215-1-huangpei@loongson.cn>
 <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>
 <ZaZAqMwuql9Y5Gra@kernel.org>
 <20240116122304.qwzy7san2vgspt2x@Board-3A3000>
 <3fc2f75e-d163-1ad1-009a-0e4538011885@linux.dev>
 <20240117030113.gs2fjs6vydthsc6l@Board-3A3000>
 <234ddaeb-5988-858d-6ba1-0fef90fb7a87@linux.dev>
 <20240117035910.453ofvotbvkzje6k@Board-3A3000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117035910.453ofvotbvkzje6k@Board-3A3000>

On Wed, Jan 17, 2024 at 11:59:10AM +0800, Huang Pei wrote:
> On Wed, Jan 17, 2024 at 11:17:18AM +0800, Yajun Deng wrote:
> > 
> > On 2024/1/17 11:01, Huang Pei wrote:
> > > On Wed, Jan 17, 2024 at 10:20:00AM +0800, Yajun Deng wrote:
> > > > On 2024/1/16 20:23, Huang Pei wrote:
> > > > > On Tue, Jan 16, 2024 at 10:39:04AM +0200, Mike Rapoport wrote:
> > > > > > On Mon, Jan 15, 2024 at 02:08:21PM +0000, Jiaxun Yang wrote:
> > > > > > > Hi mm folks,
> > > > > > > 
> > > > > > > Just a quick question, what is the expected behavior of memblock_reserve
> > > > > > > a region that is not added to memblock with memblock_add?
> > > > > > > 
> > > > > > > I'm unable to find any documentation about memblock_reserve in comments and
> > > > > > > boot-time-mm, but as per my understanding to the code, this should be a
> > > > > > > legit usage?
> > > > > > Yes, memblock allows reserving memory that was not added to memblock with
> > > > > > memblock_add().
> > > > > I think arch/platform specific code should fix this bug, like,
> > > > > --------------------------------------------------------------------------
> > > > > //for loongson64
> > > > > memblock_set_node(0, 1ULL << 44, &memblock.reserved, 0);
> > > > > 
> > > > > --------------------------------------------------------------------------
> > > > > 
> > > > > or maybe memblock provide something like memblock_reserve_node
> > > > Hi pei,
> > > > 
> > > > Can you test the following patch to see if it fixes this bug?
> > > > 
> > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > index 2c19f5515e36..97721d99fdce 100644
> > > > --- a/mm/mm_init.c
> > > > +++ b/mm/mm_init.c
> > > > @@ -708,6 +708,9 @@ static void __meminit init_reserved_page(unsigned long
> > > > pfn, int nid)
> > > >          pg_data_t *pgdat;
> > > >          int zid;
> > > > 
> > > > +       if (unlikely(nid == NUMA_NO_NODE || nid >= MAX_NUMNODES))
> > > > +               nid = early_pfn_to_nid(pfn);
> > > > +
> > > >          if (early_page_initialised(pfn, nid))
> > > >                  return;

IMO this will fix the bug. Before 61167ad5fecd we had nid = first_online_node
for reserved pages that didn't have nid set in memblock.reserved. After
61167ad5fecd we try to initialize these pages with MAX_NUMNODES and
obviously crash when accessing node structure.

I think that the check for a valid nid should be moved to
memmap_init_reserved_pages() though. An entire reserved region will have
nid set to MAX_NUMNODES, so there is no point to check every page in it.

> > > I do not think this fix set the right nid, ONLY arch/platform know that
> > > nid

Why does it matter to have the right nid in a reserved page that is not
part of usable memory?

That's true that only arch knows on which node those reserved pages are,
but core mm does not care about reserved pages that are not in memory.
 
> > >   int __meminit early_pfn_to_nid(unsigned long pfn)
> > > {
> > > 	static DEFINE_SPINLOCK(early_pfn_lock);
> > > 	int nid;
> > > 
> > > 	spin_lock(&early_pfn_lock);
> > > 	nid = __early_pfn_to_nid(pfn,
> > > 			&early_pfnnid_cache);
> > > 	if (nid < 0)
> > > 	//!!!first_online_node MAY NOT be the node the pfn belong to!!!
> > > 		nid = first_online_node;
> > > 
> > > 	spin_unlock(&early_pfn_lock);
> > > 
> > > 	return
> > > 		nid;
> > > }
> > 
> > 
> > Okay, I don't think this bug is caused by commit 61167ad5fecd ("mm: pass nid
> > to reserve_bootmem_region()"),
> > 
> > because even if you revert this commit, it will still get nid by
> > early_pfn_to_nid(). Did I get that right?
> 
> Yes, more accurately, this bug is exposed by commit 61167ad5fecd. My
> previous fix is based on presumptions that memory_reserve should reserve memory 
> added by memblock_add{,_node}, if going across this limitation, there need
> to set the valid nid for reserved memory region.
> > 
> > > > 
> > > > > > > In practical we run into uninitialized nid of reserved block problem, should
> > > > > > > we fix it
> > > > > > > in our usage, or on memblock side?
> > > > > > Apparently it's a bug in memblock :(
> > > > > > 
> > > > > > If you revert 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> > > > > > does the issue disappear?
> > > > > Yes, I git bisect this commit.
> > > > > 
> > > > > But I don't think it is a bug in memblock. IMO, memblock_reserve under
> > > > > NUMA set nid of reserved region to MAX_NUMNODES, which is the point
> > > > > that cause the "memblock_get_region_node from memmap_init_reserved_pages "
> > > > > passing a invalid node id(aka MAX_NUMNODES) to "reserver_bootmem_region
> > > > > -> init_reserved_page -> early_pfn_to_nid". If arch-specific code DOES NOT
> > > > > initialize the nid of reserved region(only it know that), or the reserved
> > > > > region NOT within a memblock added by memblock_add, memblock can not
> > > > > give a valid node id to the reserved region. Commit 61167ad5fecd ("mm: pass nid to
> > > > > reserve_bootmem_region()") just reveals the embarrassment case by an
> > > > > out of bound memory access.
> > > > > 
> > > > > > > Thanks
> > > > > > > 
> > > > > > > 在 2023/12/25 09:30, Huang Pei 写道:
> > > > > > > > Since commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()),
> > > > > > > > loongson64 booting failed with CONFIG_DEFERRED_STRUCT_PAGE_INIT like
> > > > > > > > this:
> > > > > > > > ----------------------------------------------------------------------
> > > > > > > >     Call Trace:
> > > > > > > >     [<ffffffff8235d088>] reserve_bootmem_region+0xa8/0x184
> > > > > > > >     [<ffffffff82333940>] memblock_free_all+0x104/0x2a8
> > > > > > > >     [<ffffffff8231d8e4>] mem_init+0x84/0x94
> > > > > > > >     [<ffffffff82330958>] mm_core_init+0xf8/0x308
> > > > > > > >     [<ffffffff82318c38>] start_kernel+0x43c/0x86c
> > > > > > > > 
> > > > > > > >     Code: 10400028  2402fff0  de420000 <dc432880> 0203182b 14600022
> > > > > > > >     64420070  00003025  24040003
> > > > > > > > 
> > > > > > > >     ---[ end trace 0000000000000000 ]---
> > > > > > > >     Kernel panic - not syncing: Attempted to kill the idle task!
> > > > > > > >     ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> > > > > > > > ----------------------------------------------------------------------
> > > > > > > > 
> > > > > > > > The root cause is no memory region "0x0-0x1fffff" paired with
> > > > > > > > memory-reserved region "0x0-0x1fffff" and "0x0-0xfff", with "memblock
> > > > > > > > =debug":
> > > > > > > > 
> > > > > > > > ----------------------------------------------------------------------
> > > > > > > >      memory[0x0]     [0x0000000000200000-0x000000000effffff],
> > > > > > > >      0x000000000ee00000 bytes on node 0 flags: 0x0 !!!!here
> > > > > > > >      memory[0x1]     [0x0000000090000000-0x00000000fdffffff],
> > > > > > > >      0x000000006e000000 bytes on node 0 flags: 0x0
> > > > > > > >      memory[0x2]     [0x0000000100000000-0x000000027fffffff],
> > > > > > > >      0x0000000180000000 bytes on node 0 flags: 0x0
> > > > > > > >      memory[0x3]     [0x0000100000000000-0x000010000fffffff],
> > > > > > > >      0x0000000010000000 bytes on node 1 flags: 0x0
> > > > > > > >      memory[0x4]     [0x0000100090000000-0x000010027fffffff],
> > > > > > > >      0x00000001f0000000 bytes on node 1 flags: 0x0
> > > > > > > >      reserved.cnt  = 0x1f
> > > > > > > >      reserved[0x0]   [0x0000000000000000-0x000000000190c80a],
> > > > > > > >      0x000000000190c80b bytes flags: 0x0 !!!!oops 0x0-0x1fffff not in memory[0]
> > > > > > > >      reserved[0x1]   [0x000000000190c810-0x000000000190eea3],
> > > > > > > >      0x0000000000002694 bytes flags: 0x0
> > > > > > > > ----------------------------------------------------------------------
> > > > > > > > 
> > > > > > > > It caused memory-reserved region "0x0-0x1fffff" without valid node id
> > > > > > > > in "memblock_get_region_node" from "memmap_init_reserved_pages", lead to
> > > > > > > > "reserve_bootmem_region-> init_reserved_page -> early_pfn_to_nid()"
> > > > > > > > accessing "node_data" out of bound.
> > > > > > > > 
> > > > > > > > To fix this bug, we should remove unnecessary memory block reservation.
> > > > > > > > 
> > > > > > > > +. no need to reserve 0x0-0x1fffff below kernel loading address, since
> > > > > > > > it is not registered by "memblock_add_node"
> > > > > > > > 
> > > > > > > > +. no need to reserve 0x0-0xfff for exception handling if it is not
> > > > > > > > registered by "memblock_add" either.
> > > > > > > > 
> > > > > > > > Fixes: commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region())
> > > > > > > > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > > > > > > > ---
> > > > > > > >     arch/mips/kernel/traps.c    | 3 ++-
> > > > > > > >     arch/mips/loongson64/numa.c | 2 --
> > > > > > > >     2 files changed, 2 insertions(+), 3 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > > > > > > > index 246c6a6b0261..9b632b4c10c3 100644
> > > > > > > > --- a/arch/mips/kernel/traps.c
> > > > > > > > +++ b/arch/mips/kernel/traps.c
> > > > > > > > @@ -2007,7 +2007,8 @@ unsigned long vi_handlers[64];
> > > > > > > >     void reserve_exception_space(phys_addr_t addr, unsigned long size)
> > > > > > > >     {
> > > > > > > > -	memblock_reserve(addr, size);
> > > > > > > > +	if(memblock_is_region_memory(addr, size))
> > > > > > > > +		memblock_reserve(addr, size);
> > > > > > > >     }
> > > > > > > >     void __init *set_except_vector(int n, void *addr)
> > > > > > > > diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> > > > > > > > index 8f61e93c0c5b..0f516dde81da 100644
> > > > > > > > --- a/arch/mips/loongson64/numa.c
> > > > > > > > +++ b/arch/mips/loongson64/numa.c
> > > > > > > > @@ -130,8 +130,6 @@ static void __init node_mem_init(unsigned int node)
> > > > > > > >     			memblock_reserve((node_addrspace_offset | 0xfe000000),
> > > > > > > >     					 32 << 20);
> > > > > > > > -		/* Reserve pfn range 0~node[0]->node_start_pfn */
> > > > > > > > -		memblock_reserve(0, PAGE_SIZE * start_pfn);
> > > > > > > >     	}
> > > > > > > >     }
> > > > > > > -- 
> > > > > > > ---
> > > > > > > Jiaxun Yang
> > > > > > > 
> > > > > > -- 
> > > > > > Sincerely yours,
> > > > > > Mike.
> 

-- 
Sincerely yours,
Mike.

