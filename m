Return-Path: <linux-kernel+bounces-47534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B799844F11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E8B1F28D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06823171B1;
	Thu,  1 Feb 2024 02:18:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515F125D2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753909; cv=none; b=nVO+7ETTE4OkOtOMc6VEcDPyacVGZQGyYlrPMDmFPOCJSzGo1EFG67MvJtarT1Ves7IkM3K1BNCP1BPAw4qAjgDSXCdSc+y7SY7RqfsvP3lpN3iISELbRAjm5Nr3nvn5+Ci08dH31u36FI5GWUvYUWWGZ/4JgiwrXTJC4h9lGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753909; c=relaxed/simple;
	bh=o0I7VGHAAa0YEhzWfU/7LZbAlEEt9A61d4gqgFb8IuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1J+hS1fxHBrdQBIs/Y5mDYNmkohmUq5ZKD4h5eyVBAllzQx1oej+4aWlLnX6VvLSTH2OB7qFA1iV9eAhg20m/3WRO8uQDXZOhbucmBUHvca2wmcuFNfufgWWtHmAmSNhrxhreEciXRsfYDzAma48tHQ88NPOaVGArHroh1VoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8a-65baff673055
Date: Thu, 1 Feb 2024 11:18:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v7 0/8] Reduce TLB flushes by 94% by improving folio
 migration
Message-ID: <20240201021810.GA34306@system.software.com>
References: <20240122010040.74346-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsXC9ZZnkW7G/12pBuvOclrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK2PO9BbGgsc2FX1z7RoY2/S6GDk5JARMJFad3cgIY//4OI8dxGYRUJH43/6Z
	BcRmE1CXuHHjJzOILQJUs73zKVMXIxcHs8BdJokFTxqYQBLCAiESW3rmsYLYvAIWEq/+zAWL
	CwmYSsz9sJMRIi4ocXLmE7ChzAJaEjf+vQSq4QCypSWW/+MACXMKmElM+dUF1ioqoCxxYNtx
	sF0SArvYJe5/+s0CcaikxMEVN1gmMArMQjJ2FpKxsxDGLmBkXsUolJlXlpuYmWOil1GZl1mh
	l5yfu4kRGJvLav9E72D8dCH4EKMAB6MSD2+E965UIdbEsuLK3EOMEhzMSiK8K+V2pgrxpiRW
	VqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgXPfX1bHiQ57/jAXc
	/zfcvvmw4VtFuOeLDdXiYhaGS3R/yWp8XjP18NJsxT3rzUo/18/dtcP68YUSJrHeEy/XrVm8
	ev+sXW5uV9d5ehQcvJB90WLvqpsWppPCl/w7u3V/t5RK6ozXMWu0n5fK7BMQYLVY5nZ8lcSc
	vPn3N/uJ1iQuC36vcd9PIEqJpTgj0VCLuag4EQDa/CgxyQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXC5WfdrJv+f1eqwdz9JhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgy5kxvYSx4bFPRN9eugbFNr4uRk0NCwETix8d57CA2i4CK
	xP/2zywgNpuAusSNGz+ZQWwRoJrtnU+Zuhi5OJgF7jJJLHjSwASSEBYIkdjSM48VxOYVsJB4
	9WcuWFxIwFRi7oedjBBxQYmTM5+ADWUW0JK48e8lUA0HkC0tsfwfB0iYU8BMYsqvLrBWUQFl
	iQPbjjNNYOSdhaR7FpLuWQjdCxiZVzGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgRG2rLaPxN3
	MH657H6IUYCDUYmHN8J7V6oQa2JZcWXuIUYJDmYlEd6VcjtThXhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjzjt2wm9CoEMwiEylYct7k5KXFslsur1Dh
	FPrYEFRwtLX8nWhFz+5MBfYb059ul6zO7tRfHxZj9+KQbBDngmMlKze87TJ+ElsaabO2m8dk
	h7pA25KjP05e5HkpZvzBft56raUbHyUx/8mq+nxokkQhw1GOMI2tTXWXdr+Ju/x2x/xVkUe4
	z6xXYinOSDTUYi4qTgQAx4DZYLACAAA=
X-CFilter-Loop: Reflected

On Mon, Jan 22, 2024 at 10:00:32AM +0900, Byungchul Park wrote:
> Hi everyone,
> 
> While I'm working with CXL memory, I have been facing migration overhead
> esp. TLB shootdown on promotion or demotion between different tiers.
> Yeah.. most TLB shootdowns on migration through hinting fault can be
> avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
> flushing TLB in batch if PTE is inaccessible"). See the following link:
> 
> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> 
> However, it's only for ones using hinting fault. I thought it'd be much
> better if we have a general mechanism to reduce the number of TLB
> flushes and TLB misses, that we can apply to any type of migration. I
> tried it only for tiering migration for now tho.
> 
> I'm suggesting a mechanism to reduce TLB flushes by keeping source and
> destination of folios participated in the migrations until all TLB
> flushes required are done, only if those folios are not mapped with
> write permission PTE entries at all. I worked Based on v6.7.
> 
> I saw the number of iTLB full flush was reduced by 94%, iTLB miss was
> reduced by 45.5% and the total runtime was reduced by 3.5% with the
> workload I tested with, XSBench. However, I believe that it would help
> more with other ones or any real ones. It'd be appreciated to let me
> know if I'm missing something.

I didn't introduce additional PG flags.

Migrc mechanism that defers needed TLB flushes as long as possible by
keeping read-only pages until it can be freed safely, significantly
reduced TLB flushes and TLB misses, when migrations are happening by
numa tiering e.g. auto numa tiering, demotion and so on.

What's your thoughts about the idea resulting in over 90% reduction of
TLB flushes and over 40% reduction of TLB misses?

	Byungchul

> 	Byungchul
> 
> ---
> 
> Changes from v6:
> 	1. Fix build errors in case of
> 	   CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH disabled by moving
> 	   migrc_flush_{start,end}() calls from arch code to
> 	   try_to_unmap_flush() in mm/rmap.c.
> 
> Changes from v5:
> 	1. Fix build errors in case of CONFIG_MIGRATION disabled or
> 	   CONFIG_HWPOISON_INJECT moduled. (feedbacked by kernel test
> 	   bot and Raymond Jay Golo)
> 	2. Organize migrc code with two kconfigs, CONFIG_MIGRATION and
> 	   CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.
> 
> Changes from v4:
> 
> 	1. Rebase on v6.7.
> 	2. Fix build errors in arm64 that is doing nothing for TLB flush
> 	   but has CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH. (reported
> 	   by kernel test robot)
> 	3. Don't use any page flag. So the system would give up migrc
> 	   mechanism more often but it's okay. The final improvement is
> 	   good enough.
> 	4. Instead, optimize full TLB flush(arch_tlbbatch_flush()) by
> 	   avoiding redundant CPUs from TLB flush.
> 
> Changes from v3:
> 
> 	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
> 	   migrc_enable. (feedbacked by Nadav)
> 	2. Remove the optimization skipping CPUs that have already
> 	   performed TLB flushes needed by any reason when performing
> 	   TLB flushes by migrc because I can't tell the performance
> 	   difference between w/ the optimization and w/o that.
> 	   (feedbacked by Nadav)
> 	3. Minimize arch-specific code. While at it, move all the migrc
>            declarations and inline functions from include/linux/mm.h to
>            mm/internal.h (feedbacked by Dave Hansen, Nadav)
> 	4. Separate a part making migrc paused when the system is in
> 	   high memory pressure to another patch. (feedbacked by Nadav)
> 	5. Rename:
> 	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
> 	      b. tlb_ubc_nowr to tlb_ubc_ro,
> 	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
> 	      d. migrc_stop to migrc_pause.
> 	   (feedbacked by Nadav)
> 	6. Use ->lru list_head instead of introducing a new llist_head.
> 	   (feedbacked by Nadav)
> 	7. Use non-atomic operations of page-flag when it's safe.
> 	   (feedbacked by Nadav)
> 	8. Use stack instead of keeping a pointer of 'struct migrc_req'
> 	   in struct task, which is for manipulating it locally.
> 	   (feedbacked by Nadav)
> 	9. Replace a lot of simple functions to inline functions placed
> 	   in a header, mm/internal.h. (feedbacked by Nadav)
> 	10. Add additional sufficient comments. (feedbacked by Nadav)
> 	11. Remove a lot of wrapper functions. (feedbacked by Nadav)
> 
> Changes from RFC v2:
> 
> 	1. Remove additional occupation in struct page. To do that,
> 	   unioned with lru field for migrc's list and added a page
> 	   flag. I know page flag is a thing that we don't like to add
> 	   but no choice because migrc should distinguish folios under
> 	   migrc's control from others. Instead, I force migrc to be
> 	   used only on 64 bit system to mitigate you guys from getting
> 	   angry.
> 	2. Remove meaningless internal object allocator that I
> 	   introduced to minimize impact onto the system. However, a ton
> 	   of tests showed there was no difference.
> 	3. Stop migrc from working when the system is in high memory
> 	   pressure like about to perform direct reclaim. At the
> 	   condition where the swap mechanism is heavily used, I found
> 	   the system suffered from regression without this control.
> 	4. Exclude folios that pte_dirty() == true from migrc's interest
> 	   so that migrc can work simpler.
> 	5. Combine several patches that work tightly coupled to one.
> 	6. Add sufficient comments for better review.
> 	7. Manage migrc's request in per-node manner (from globally).
> 	8. Add TLB miss improvement in commit message.
> 	9. Test with more CPUs(4 -> 16) to see bigger improvement.
> 
> Changes from RFC:
> 
> 	1. Fix a bug triggered when a destination folio at the previous
> 	   migration becomes a source folio at the next migration,
> 	   before the folio gets handled properly so that the folio can
> 	   play with another migration. There was inconsistency in the
> 	   folio's state. Fixed it.
> 	2. Split the patch set into more pieces so that the folks can
> 	   review better. (Feedbacked by Nadav Amit)
> 	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
> 	   (Feedbacked by Nadav Amit)
> 	4. Tried to add sufficient comments to explain the patch set
> 	   better. (Feedbacked by Nadav Amit)
> 
> Byungchul Park (8):
>   x86/tlb: Add APIs manipulating tlb batch's arch data
>   arm64: tlbflush: Add APIs manipulating tlb batch's arch data
>   mm/rmap: Recognize read-only TLB entries during batched TLB flush
>   x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of
>     arch_tlbbatch_flush()
>   mm: Separate move/undo doing on folio list from migrate_pages_batch()
>   mm: Add APIs to free a folio directly to the buddy bypassing pcp
>   mm: Defer TLB flush by keeping both src and dst folios at migration
>   mm: Pause migrc mechanism at high memory pressure
> 
>  arch/arm64/include/asm/tlbflush.h |  19 ++
>  arch/x86/include/asm/tlbflush.h   |  18 ++
>  arch/x86/mm/tlb.c                 |   2 -
>  include/linux/mm.h                |  23 ++
>  include/linux/mmzone.h            |   7 +
>  include/linux/sched.h             |   9 +
>  mm/internal.h                     |  78 ++++++
>  mm/memory.c                       |   8 +
>  mm/migrate.c                      | 411 ++++++++++++++++++++++++++----
>  mm/page_alloc.c                   |  34 ++-
>  mm/rmap.c                         |  40 ++-
>  mm/swap.c                         |   7 +
>  12 files changed, 597 insertions(+), 59 deletions(-)
> 
> 
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> -- 
> 2.17.1

