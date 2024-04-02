Return-Path: <linux-kernel+bounces-127643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF0894ED9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8CC1C22B34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC558AB4;
	Tue,  2 Apr 2024 09:36:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366458AA1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050598; cv=none; b=EG+5cuDAV95haAlzDIRDZ+Z1CS+dau9o+1D1t2rsu072Ql4P28pyBMxK/RgH1KBjKYtrULaEW4wQQi3RRsRn1kB1LQu25X0rwnnAb85dKZfla8JhAwHl7XluMOD1xOuXH72XjO0Po4NLsG5VLAG6Hqi6Olk9SVSVK+sZnsPbA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050598; c=relaxed/simple;
	bh=I87Swk8xDGHCuIDb6sqs1PP64vyg94WKNCeVuOo/9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEXNotVOevp4mAp39Ss6DQE1XD+2i4LYcXcs3LsdWDYP9TyJIMgt94N+s5l3UN0jdoOQU8ORolVlnKPFFngvpizewmKIJqh24y8AY/Oc+pyT1gqa/S1Pl5acXOHsL6PIlzNarpfTp5hudLcAKRFS5KEhmvxWg47/MMCs06dcDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FF51042;
	Tue,  2 Apr 2024 02:37:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.18.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39B603F64C;
	Tue,  2 Apr 2024 02:36:32 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:36:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
Message-ID: <ZgvRmhbvVoGHcLqu@FVFF77S0Q05N>
References: <20231222022741.8223-1-boy.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222022741.8223-1-boy.wu@mediatek.com>

Hi,

On Fri, Dec 22, 2023 at 10:27:41AM +0800, boy.wu wrote:
> From: Boy Wu <boy.wu@mediatek.com>
> 
> We found below OOB crash:
> 
> [   33.452494] ==================================================================
> [   33.453513] BUG: KASAN: stack-out-of-bounds in refresh_cpu_vm_stats.constprop.0+0xcc/0x2ec
> [   33.454660] Write of size 164 at addr c1d03d30 by task swapper/0/0
> [   33.455515]
> [   33.455767] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.1.25-mainline #1
> [   33.456880] Hardware name: Generic DT based system
> [   33.457555]  unwind_backtrace from show_stack+0x18/0x1c
> [   33.458326]  show_stack from dump_stack_lvl+0x40/0x4c
> [   33.459072]  dump_stack_lvl from print_report+0x158/0x4a4
> [   33.459863]  print_report from kasan_report+0x9c/0x148
> [   33.460616]  kasan_report from kasan_check_range+0x94/0x1a0
> [   33.461424]  kasan_check_range from memset+0x20/0x3c
> [   33.462157]  memset from refresh_cpu_vm_stats.constprop.0+0xcc/0x2ec
> [   33.463064]  refresh_cpu_vm_stats.constprop.0 from tick_nohz_idle_stop_tick+0x180/0x53c
> [   33.464181]  tick_nohz_idle_stop_tick from do_idle+0x264/0x354
> [   33.465029]  do_idle from cpu_startup_entry+0x20/0x24
> [   33.465769]  cpu_startup_entry from rest_init+0xf0/0xf4
> [   33.466528]  rest_init from arch_post_acpi_subsys_init+0x0/0x18
> [   33.467397]
> [   33.467644] The buggy address belongs to stack of task swapper/0/0
> [   33.468493]  and is located at offset 112 in frame:
> [   33.469172]  refresh_cpu_vm_stats.constprop.0+0x0/0x2ec
> [   33.469917]
> [   33.470165] This frame has 2 objects:
> [   33.470696]  [32, 76) 'global_zone_diff'
> [   33.470729]  [112, 276) 'global_node_diff'
> [   33.471294]
> [   33.472095] The buggy address belongs to the physical page:
> [   33.472862] page:3cd72da8 refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0x41d03
> [   33.473944] flags: 0x1000(reserved|zone=0)
> [   33.474565] raw: 00001000 ed741470 ed741470 00000000 00000000 00000000 ffffffff 00000001
> [   33.475656] raw: 00000000
> [   33.476050] page dumped because: kasan: bad access detected
> [   33.476816]
> [   33.477061] Memory state around the buggy address:
> [   33.477732]  c1d03c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   33.478630]  c1d03c80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
> [   33.479526] >c1d03d00: 00 04 f2 f2 f2 f2 00 00 00 00 00 00 f1 f1 f1 f1
> [   33.480415]                                                ^
> [   33.481195]  c1d03d80: 00 00 00 00 00 00 00 00 00 00 04 f3 f3 f3 f3 f3
> [   33.482088]  c1d03e00: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> [   33.482978] ==================================================================
> 
> We find the root cause of this OOB is that arm does not clear stale stack
> poison in the case of cpuidle.
> 
> This patch refer to arch/arm64/kernel/sleep.S to resolve this issue.
> 
> Signed-off-by: Boy Wu <boy.wu@mediatek.com>

It looks like you're specifically referring to what arm64 did in commit:

  0d97e6d8024c71cc ("arm64: kasan: clear stale stack poison")

Where the commit message explained the problem:

| Functions which the compiler has instrumented for KASAN place poison on
| the stack shadow upon entry and remove this poison prior to returning.
| 
| In the case of cpuidle, CPUs exit the kernel a number of levels deep in
| C code.  Any instrumented functions on this critical path will leave
| portions of the stack shadow poisoned.
| 
| If CPUs lose context and return to the kernel via a cold path, we
| restore a prior context saved in __cpu_suspend_enter are forgotten, and
| we never remove the poison they placed in the stack shadow area by
| functions calls between this and the actual exit of the kernel.
| 
| Thus, (depending on stackframe layout) subsequent calls to instrumented
| functions may hit this stale poison, resulting in (spurious) KASAN
| splats to the console.
| 
| To avoid this, clear any stale poison from the idle thread for a CPU
| prior to bringing a CPU online.

.. which we then extended to check for CONFIG_KASAN_STACK in commit:

  d56a9ef84bd0e1e8 ("kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK")

If you can fold in the description above (i.e. cite commit 0d97e6d8024c71cc and
a copy of its commit message):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/kernel/sleep.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index a86a1d4f3461..93afd1005b43 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -127,6 +127,10 @@ cpu_resume_after_mmu:
>  	instr_sync
>  #endif
>  	bl	cpu_init		@ restore the und/abt/irq banked regs
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
> +	mov	r0, sp
> +	bl	kasan_unpoison_task_stack_below
> +#endif
>  	mov	r0, #0			@ return zero on success
>  	ldmfd	sp!, {r4 - r11, pc}
>  ENDPROC(cpu_resume_after_mmu)
> -- 
> 2.18.0
> 
> 

