Return-Path: <linux-kernel+bounces-156123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6F8AFE32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E047B1C22119
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC18101F2;
	Wed, 24 Apr 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5sGIPwW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E14A35
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924639; cv=none; b=AEQNU97utG9FaOtjc4s8Vjum5QvMJzO+m98yAJEwlNcgFuVjoqgSTrU83wGvqVEfFYZeGRY5XhpCnYei699n0FrrTFlUvNnVBiBq+toJhEBxXf7kQZ944hSFi2G0/to9c3zPVg0HdM/8FpghyarW1HiEPjX+hhzEchUQcLY2R0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924639; c=relaxed/simple;
	bh=RRNI4/7VVEnd7y+k5NL0P3TLP6wMm4RpMH3kMOh2/U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqCVcsJ/34MeXa6reIMTXfFhkbqwhE9+J+7m3umR9MCEPKPTAej5SfffUsGjZylNEzHUogTHMi/tAE0ql2fQZmUZubf1jdn3pswkDxPNScM7v2dtPHaphbkknUJEfW83c7af37OjtzeS0V/K6I3wmpp+DPBzUesrzex2wCppqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5sGIPwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F61C116B1;
	Wed, 24 Apr 2024 02:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713924639;
	bh=RRNI4/7VVEnd7y+k5NL0P3TLP6wMm4RpMH3kMOh2/U8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t5sGIPwWFi10+5CFCGtkDYZ3hKY9oN3hFIC7JVcoUonFfo8TL5nv1Bh8g1qxL6jHI
	 Nw0y7UDOSHF4KgSJCL7hvQ05qVz6Tz4+CX1t7urUAebvwFvEjQ+MzVV3HC4PKTpTa9
	 wy2fa0kVOE6jjArBgj0bjiWtsOrIGVtBdAMBa3L1KAQYnO083Y5Og0V9Lju5IdB10A
	 WRGzI+RkPiwTq+PrFRE/7Ajp/e7YyDRBlfIBpYYyPw6ay7GMSMuyHONSPYo9WCxsLc
	 zNpeCklgoPTTt51jv9AYEngSyyMHUXFaIEyayIxgWoFSVGFO1KzBnpTjwsydwliJDm
	 o1ZKVIGS3qdlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 037FFCE0962; Tue, 23 Apr 2024 19:10:39 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:10:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] lkdtm/bugs: add test for hung smp_call_function_single()
Message-ID: <c4c404c2-86ce-4913-99bf-b7f1d72077e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240419103452.3530155-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419103452.3530155-1-mark.rutland@arm.com>

On Fri, Apr 19, 2024 at 11:34:52AM +0100, Mark Rutland wrote:
> The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> smp_call_function*() calls (e.g. when the target CPU gets stuck within
> the callback function). Testing this option requires triggering such
> hangs.
> 
> This patch adds an lkdtm test with a hung smp_call_function_single()
> callbac, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> of the hung target CPU).
> 
> On arm64 using pseudo-NMI, this looks like:
> 
> | # mount -t debugfs none /sys/kernel/debug/
> | # echo CSDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry CSDLOCKUP
> | smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5000001136 ns for CPU#01 __lkdtm_CSDLOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> | Sending NMI from CPU 0 to CPUs 1:
> | NMI backtrace for cpu 1
> | CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-rc4-00001-gda84b9dede43 #7
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> | pc : __lkdtm_CSDLOCKUP+0x0/0x8
> | lr : __flush_smp_call_function_queue+0x1b0/0x290
> | sp : ffff80008000bf30
> | pmr_save: 00000060
> | x29: ffff80008000bf30 x28: fff00000c02dc500 x27: 0000000000000000
> | x26: 0000000000000000 x25: fff00000c02dc500 x24: ffffa41b939aa140
> | x23: ffffa41b939aa140 x22: 0000000000000000 x21: ffff80008066bc40
> | x20: 0000000000000000 x19: 0000000000000000 x18: fff05be56bd37000
> | x17: fff05be56bd07000 x16: ffff800080008000 x15: 00005b132023e6fd
> | x14: 00005aeabb53d8c3 x13: 000000000000032e x12: 0000000000000001
> | x11: 0000000000000040 x10: fff00000c003d0a8 x9 : fff00000c003d0a0
> | x8 : fff00000c0400270 x7 : 0000000000000000 x6 : ffffa41b9251b810
> | x5 : 0000000000000000 x4 : fff05be56bd07000 x3 : ffff80008000bf30
> | x2 : fff05be56bd07000 x1 : ffffa41b939aa140 x0 : 0000000000000000
> | Call trace:
> |  __lkdtm_CSDLOCKUP+0x0/0x8
> |  generic_smp_call_function_single_interrupt+0x14/0x20
> |  ipi_handler+0xb8/0x178
> |  handle_percpu_devid_irq+0x84/0x130
> |  generic_handle_domain_irq+0x2c/0x44
> |  gic_handle_irq+0x118/0x240
> |  call_on_irq_stack+0x24/0x4c
> |  do_interrupt_handler+0x80/0x84
> |  el1_interrupt+0x44/0xc0
> |  el1h_64_irq_handler+0x18/0x24
> |  el1h_64_irq+0x78/0x7c
> |  default_idle_call+0x40/0x60
> |  do_idle+0x23c/0x2d0
> |  cpu_startup_entry+0x38/0x3c
> |  secondary_start_kernel+0x148/0x180
> |  __secondary_switched+0xb8/0xbc
> | CPU: 0 PID: 143 Comm: sh Not tainted 6.9.0-rc4-00001-gda84b9dede43 #7
> | Hardware name: linux,dummy-virt (DT)
> | Call trace:
> |  dump_backtrace+0x90/0xe8
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0xac/0xe8
> |  dump_stack+0x18/0x24
> |  csd_lock_wait_toolong+0x268/0x338
> |  smp_call_function_single+0x1dc/0x2f0
> |  lkdtm_CSDLOCKUP+0xcc/0xfc
> |  lkdtm_do_action+0x1c/0x38
> |  direct_entry+0xbc/0x14c
> |  full_proxy_write+0x60/0xb4
> |  vfs_write+0xd0/0x35c
> |  ksys_write+0x70/0x104
> |  __arm64_sys_write+0x1c/0x28
> |  invoke_syscall+0x48/0x114
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x38/0x108
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x1a4/0x1a8
> | smp: csd: Continued non-responsive CSD lock (#1) on CPU#0, waiting 10000001888 ns for CPU#01 __lkdtm_CSDLOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/misc/lkdtm/bugs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> I wrote this because I needed to guide someone through debugging a hung
> smp_call_function() call, and I needed examples with/without an NMI
> backtrace. It seems like it'd be useful for testing the CSD lockup
> detector and NMI backtrace code in future.
> 
> I'm not sure about the CSDLOCKUP name, but everything else I tried
> didn't seem great either:
> 
> * IPILOCKUP sounds like it's testing IPIs generally
> * SMPCALLLOCKUP and similar look weirdly long
> * SMP_CALL_LOCKUP and similar look different to {HARD,SOFT,SPIN}LOCKUP
> 
> ... and I'm happy to defer to Kees for the naming. ;)
> 
> Mark.
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 5178c02b21eba..47cd1be09ac1f 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -286,6 +286,35 @@ static void lkdtm_HARDLOCKUP(void)
>  		cpu_relax();
>  }
>  
> +static void __lkdtm_CSDLOCKUP(void *unused)
> +{
> +	for (;;)
> +		cpu_relax();
> +}
> +
> +static void lkdtm_CSDLOCKUP(void)
> +{
> +	unsigned int cpu, target;
> +
> +	cpus_read_lock();
> +
> +	cpu = get_cpu();
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target >= nr_cpu_ids) {
> +		pr_err("FAIL: no other online CPUs\n");
> +		goto out_put_cpus;
> +	}
> +
> +	smp_call_function_single(target, __lkdtm_CSDLOCKUP, NULL, 1);
> +
> +	pr_err("FAIL: did not hang\n");
> +
> +out_put_cpus:
> +	put_cpu();
> +	cpus_read_unlock();
> +}
> +
>  static void lkdtm_SPINLOCKUP(void)
>  {
>  	/* Must be called twice to trigger. */
> @@ -680,6 +709,7 @@ static struct crashtype crashtypes[] = {
>  	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
>  	CRASHTYPE(SOFTLOCKUP),
>  	CRASHTYPE(HARDLOCKUP),
> +	CRASHTYPE(CSDLOCKUP),
>  	CRASHTYPE(SPINLOCKUP),
>  	CRASHTYPE(HUNG_TASK),
>  	CRASHTYPE(OVERFLOW_SIGNED),
> -- 
> 2.30.2
> 

