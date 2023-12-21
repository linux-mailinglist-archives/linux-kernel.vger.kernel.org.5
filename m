Return-Path: <linux-kernel+bounces-8597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44381B9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F4B2346A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F739360B8;
	Thu, 21 Dec 2023 14:56:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07753360AE;
	Thu, 21 Dec 2023 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rGKSq-0002PT-00; Thu, 21 Dec 2023 15:55:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id F34F9C028A; Thu, 21 Dec 2023 15:38:01 +0100 (CET)
Date: Thu, 21 Dec 2023 15:38:01 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Baoquan He <bhe@redhat.com>, Chao-ying Fu <cfu@wavecomp.com>,
	Yinglu Yang <yangyinglu@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Marc Zyngier <maz@kernel.org>,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] MIPS: mm: Fix some memory-related issues
Message-ID: <ZYRNyX+SnNh3LkC0@alpha.franken.de>
References: <20231202111430.18059-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202111430.18059-1-fancer.lancer@gmail.com>

On Sat, Dec 02, 2023 at 02:14:17PM +0300, Serge Semin wrote:
> Just recently I've rebased my MIPS32-related work from kernel 6.5-rc4 onto
> the latest kernel 6.7-rc1 and immediately got into a bootup-time
> mm-related bug (see patches 3-4 in this series). After fixing it I decided
> it was time to submit for review the generic MIPS code fixes which I have
> been collecting in my local repo for the last year. I was going to submit
> them a bit later after I finished working on a patchset with my SoC
> arch-specific changes, but since it was getting bigger and bigger, it
> turned to be reasonable to spill out the generic part of series right away
> especially seeing it might get to be useful in the most recent kernel.
> 
> So this series starts with the MIPS-specific dmi_early_remap()
> implementation fix. It is utilized by the DMI driver in the framework of
> the dmi_setup() method, which is called at the very early boot stage - in
> setup_arch((). No VM and slab available at that stage which is required
> for the ioremap_cache() to properly work. Thus it was a mistake to have
> the dmi_early_remap() macro-function defined as ioremap_cache(). It should
> have been ioremap() in first place.
> 
> After that goes a fix for the high-memory zone PFNs calculation procedure
> on MIPS. It turned out that after some not that recent commit the
> IO-memory or just non-memory PFNs got to the high-memory even though they
> were directly reachable, thus should have been left in the normal zone.
> 
> Then a series of fixes for the recently discovered mm-bug is presented.
> Any attempt to re-map the IO-memory with the cached attribute caused the
> bootup procedure to crash with the "Unhandled kernel unaligned access"
> message. After some digging I found out that the problem was in the
> uninitialized IO-memory pages. Please see the patch "mips: Fix max_mapnr
> being uninitialized on early stages" description for the detailed
> explanation of the problem and suggested fix.
> 
> After that goes a patch which adds the slab availability check into the
> ioremap_prot() method. Indeed VM mapping performs the slab allocation in
> the framework of the get_vm_area() method. Thus any other than uncached
> IO-remappings must be proceeded only at the stages when slab is available.
> A similar fix was just recently added to the generic version of
> ioremap_prot() in the framework of commit a5f616483110 ("mm/ioremap: add
> slab availability checking in ioremap_prot").
> 
> The patchset is closed with a small improvement which sets the MIPS
> board/machine name to the dump-stack module in order to print
> arch-personalized oopses in the same way as it's done on ARM, ARM64,
> RISC-V, etc.
> 
> That's it for today.) Thanks for review in advance. Any tests are very
> welcome.
> 
> Link: https://lore.kernel.org/linux-mips/20231122182419.30633-1-fancer.lancer@gmail.com/
> Changelog v2:
> - Drop the patches:
>   [PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
>   [PATCH 6/7] mm/mm_init.c: Append '\n' to the unavailable ranges log-message
>   since they have been picked up by Andrew. (@Andrew)
> - Replace ioremap_uc() with using ioremap() due to having the former one
>   deprecated. (@Arnd)
> - Add a new patch:
>   [PATCH v2 5/6] mips: mm: add slab availability checking in ioremap_prot
>   picked up from the generic ioremap_prot() implementation.
> - Extend early DMI mem remapping patch log with a note regarding the unsynched
>   caches concern. (@Jiaxun)
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Cc: Aleksandar Rikalo <arikalo@gmail.com>
> Cc: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Chao-ying Fu <cfu@wavecomp.com>
> Cc: Yinglu Yang <yangyinglu@loongson.cn>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (6):
>   mips: dmi: Fix early remap on MIPS32
>   mips: Fix incorrect max_low_pfn adjustment
>   mips: Fix max_mapnr being uninitialized on early stages
>   mips: Optimize max_mapnr init procedure
>   mips: mm: add slab availability checking in ioremap_prot
>   mips: Set dump-stack arch description
> 
>  arch/mips/include/asm/dmi.h |  2 +-
>  arch/mips/kernel/prom.c     |  2 ++
>  arch/mips/kernel/setup.c    |  4 ++--
>  arch/mips/mm/init.c         | 16 +++++++++-------
>  arch/mips/mm/ioremap.c      |  4 ++++
>  5 files changed, 18 insertions(+), 10 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

