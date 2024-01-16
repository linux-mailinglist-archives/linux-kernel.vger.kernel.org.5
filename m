Return-Path: <linux-kernel+bounces-27134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308E82EAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9442285370
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EA12B61;
	Tue, 16 Jan 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akc4r1LU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30748125A3;
	Tue, 16 Jan 2024 08:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED1C433F1;
	Tue, 16 Jan 2024 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705394386;
	bh=zMBkNvcbW1+IjSGQQV5Zw6ssVa4un4ZiyvEjDOZ0/UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akc4r1LUSBobkRaqvTAjbmScrg3YVE9bgsGUF/R4Deev/WicJd81uP8RUtACPi+1Y
	 ijs7qcDxLzOAa+xAz7a6M747uoIxAQo5W1buqO6IbRYpNLARGM1LZlKLpCzpaPanoJ
	 HtCh/TOB3AMTxe/irtQDm0KrDJXZGhVCf9X6hsMyQiNY6/4nMdfzHmAGTM9to2Z7Fx
	 tN28jAtzPrfmeKqGxcxuV+Rqc/NBoc4Yb262+SXGE0k7qlzQxm5ZY15dboItZUG56h
	 o9+hrfGKOlQwMVMafr2ueLWjfs1fsjjVFRKsFgLCJKj8lC1tFdXaOcXSzeLm+7qHff
	 o+GRrPnB19CCA==
Date: Tue, 16 Jan 2024 10:39:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mm@kvack.org, Bibo Mao <maobibo@loongson.cn>,
	linux-mips@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
	Li Xuefeng <lixuefeng@loongson.cn>,
	Yang Tiezhu <yangtiezhu@loongson.cn>,
	Gao Juxin <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Huang Pei <huangpei@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: memblock_reserve for unadded region (was: [PATCH] MIPS:
 loongson64: fix boot failure)
Message-ID: <ZaZAqMwuql9Y5Gra@kernel.org>
References: <20231225093025.23215-1-huangpei@loongson.cn>
 <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>

On Mon, Jan 15, 2024 at 02:08:21PM +0000, Jiaxun Yang wrote:
> Hi mm folks,
> 
> Just a quick question, what is the expected behavior of memblock_reserve
> a region that is not added to memblock with memblock_add?
> 
> I'm unable to find any documentation about memblock_reserve in comments and
> boot-time-mm, but as per my understanding to the code, this should be a
> legit usage?

Yes, memblock allows reserving memory that was not added to memblock with
memblock_add().
 
> In practical we run into uninitialized nid of reserved block problem, should
> we fix it
> in our usage, or on memblock side?

Apparently it's a bug in memblock :(

If you revert 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
does the issue disappear?
 
> Thanks
> 
> 在 2023/12/25 09:30, Huang Pei 写道:
> > Since commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()),
> > loongson64 booting failed with CONFIG_DEFERRED_STRUCT_PAGE_INIT like
> > this:
> > ----------------------------------------------------------------------
> >   Call Trace:
> >   [<ffffffff8235d088>] reserve_bootmem_region+0xa8/0x184
> >   [<ffffffff82333940>] memblock_free_all+0x104/0x2a8
> >   [<ffffffff8231d8e4>] mem_init+0x84/0x94
> >   [<ffffffff82330958>] mm_core_init+0xf8/0x308
> >   [<ffffffff82318c38>] start_kernel+0x43c/0x86c
> > 
> >   Code: 10400028  2402fff0  de420000 <dc432880> 0203182b 14600022
> >   64420070  00003025  24040003
> > 
> >   ---[ end trace 0000000000000000 ]---
> >   Kernel panic - not syncing: Attempted to kill the idle task!
> >   ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> > ----------------------------------------------------------------------
> > 
> > The root cause is no memory region "0x0-0x1fffff" paired with
> > memory-reserved region "0x0-0x1fffff" and "0x0-0xfff", with "memblock
> > =debug":
> > 
> > ----------------------------------------------------------------------
> >    memory[0x0]     [0x0000000000200000-0x000000000effffff],
> >    0x000000000ee00000 bytes on node 0 flags: 0x0 !!!!here
> >    memory[0x1]     [0x0000000090000000-0x00000000fdffffff],
> >    0x000000006e000000 bytes on node 0 flags: 0x0
> >    memory[0x2]     [0x0000000100000000-0x000000027fffffff],
> >    0x0000000180000000 bytes on node 0 flags: 0x0
> >    memory[0x3]     [0x0000100000000000-0x000010000fffffff],
> >    0x0000000010000000 bytes on node 1 flags: 0x0
> >    memory[0x4]     [0x0000100090000000-0x000010027fffffff],
> >    0x00000001f0000000 bytes on node 1 flags: 0x0
> >    reserved.cnt  = 0x1f
> >    reserved[0x0]   [0x0000000000000000-0x000000000190c80a],
> >    0x000000000190c80b bytes flags: 0x0 !!!!oops 0x0-0x1fffff not in memory[0]
> >    reserved[0x1]   [0x000000000190c810-0x000000000190eea3],
> >    0x0000000000002694 bytes flags: 0x0
> > ----------------------------------------------------------------------
> > 
> > It caused memory-reserved region "0x0-0x1fffff" without valid node id
> > in "memblock_get_region_node" from "memmap_init_reserved_pages", lead to
> > "reserve_bootmem_region-> init_reserved_page -> early_pfn_to_nid()"
> > accessing "node_data" out of bound.
> > 
> > To fix this bug, we should remove unnecessary memory block reservation.
> > 
> > +. no need to reserve 0x0-0x1fffff below kernel loading address, since
> > it is not registered by "memblock_add_node"
> > 
> > +. no need to reserve 0x0-0xfff for exception handling if it is not
> > registered by "memblock_add" either.
> > 
> > Fixes: commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region())
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >   arch/mips/kernel/traps.c    | 3 ++-
> >   arch/mips/loongson64/numa.c | 2 --
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index 246c6a6b0261..9b632b4c10c3 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -2007,7 +2007,8 @@ unsigned long vi_handlers[64];
> >   void reserve_exception_space(phys_addr_t addr, unsigned long size)
> >   {
> > -	memblock_reserve(addr, size);
> > +	if(memblock_is_region_memory(addr, size))
> > +		memblock_reserve(addr, size);
> >   }
> >   void __init *set_except_vector(int n, void *addr)
> > diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> > index 8f61e93c0c5b..0f516dde81da 100644
> > --- a/arch/mips/loongson64/numa.c
> > +++ b/arch/mips/loongson64/numa.c
> > @@ -130,8 +130,6 @@ static void __init node_mem_init(unsigned int node)
> >   			memblock_reserve((node_addrspace_offset | 0xfe000000),
> >   					 32 << 20);
> > -		/* Reserve pfn range 0~node[0]->node_start_pfn */
> > -		memblock_reserve(0, PAGE_SIZE * start_pfn);
> >   	}
> >   }
> 
> -- 
> ---
> Jiaxun Yang
> 

-- 
Sincerely yours,
Mike.

