Return-Path: <linux-kernel+bounces-119668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902B88CBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B3A1F8551A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B686AC6;
	Tue, 26 Mar 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnYlXgyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CC84D0D;
	Tue, 26 Mar 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476740; cv=none; b=qUYmhuKw3bbiAIm4+NrC1SXSJnQhsCUMi2hOYoLAkgcVDxH8cHDWQ1Vayv0UtFCloQUUQ/qYfct49233kz7SkyRaItSbnbOho+/HdabGpxOkvBVI5/tKlyqNTlC6yIiqoqMoVoB1gHMNeS+X1jBYBTSGQKvvKLTO0dn7J49wQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476740; c=relaxed/simple;
	bh=ZcohJvmfRg15SwcF1OZOo/kVQIEEfjHr6XbmDLUndHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIUKRnf4ZrvJpDoN7e8hzrnReOhHF4j0iZNBv5D3AxfRUbr48Ug5gYOMXWeS7bA/Wt9O2CdVRbjnq9AF/LD0MfmGI1eMQMtFAuwuqOsSD9rF9JyciRSnasKck6n+p2T1QogbUv6+Al1HqlH81FiCX3ZJnrq3Z3QWBdn8JRa2C6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnYlXgyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B33BC433C7;
	Tue, 26 Mar 2024 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476740;
	bh=ZcohJvmfRg15SwcF1OZOo/kVQIEEfjHr6XbmDLUndHM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UnYlXgynHB/OdGQ3SlzWtZXKNc4VnzI/sxDokA1pKHvYRuUJf1AXogGtbY0shgsy9
	 rXf1pz/j683VzLwQXpv58yJltQfcuo8XNQq/LueWaI9GbfX1Jrf5ML1p8FokgOM8cW
	 h0ISa2ILiQVph8YZ9A2mLdMyGJ5ANUEs3iG+5Zmfj1Ire8uTQtY6r8ip2JgXr/ZMFa
	 FGF/62OkuNNnFa/sLRR7Xs+iwEdtliSPNT8CcGUgQa+nm77qpnXWUIx6nbkt+Fp+LS
	 prLN24V+oxXQYO67hmZndviRpOHFyhs0bDaX+10onul3JBROz1/UlnXGY/QfOlgwzV
	 l8ZGwntlfuuYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 956B3CE129B; Tue, 26 Mar 2024 11:12:19 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:12:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix invalid context warning when enable srcu
 barrier testing
Message-ID: <ea12722c-772b-47de-ae3a-022fe1f8da3e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240325075219.10367-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325075219.10367-1-qiang.zhang1211@gmail.com>

On Mon, Mar 25, 2024 at 03:52:19PM +0800, Zqiang wrote:
> When the torture_type is set srcu or srcud and cb_barrier is
> non-zero, running the rcutorture test will trigger the
> following warning:
> 
> [  163.910989][    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [  163.910994][    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> [  163.910999][    C1] preempt_count: 10001, expected: 0
> [  163.911002][    C1] RCU nest depth: 0, expected: 0
> [  163.911005][    C1] INFO: lockdep is turned off.
> [  163.911007][    C1] irq event stamp: 30964
> [  163.911010][    C1] hardirqs last  enabled at (30963): [<ffffffffabc7df52>] do_idle+0x362/0x500
> [  163.911018][    C1] hardirqs last disabled at (30964): [<ffffffffae616eff>] sysvec_call_function_single+0xf/0xd0
> [  163.911025][    C1] softirqs last  enabled at (0): [<ffffffffabb6475f>] copy_process+0x16ff/0x6580
> [  163.911033][    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  163.911038][    C1] Preemption disabled at:
> [  163.911039][    C1] [<ffffffffacf1964b>] stack_depot_save_flags+0x24b/0x6c0
> [  163.911063][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.8.0-rc4-rt4-yocto-preempt-rt+ #3 1e39aa9a737dd024a3275c4f835a872f673a7d3a
> [  163.911071][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  163.911075][    C1] Call Trace:
> [  163.911078][    C1]  <IRQ>
> [  163.911080][    C1]  dump_stack_lvl+0x88/0xd0
> [  163.911089][    C1]  dump_stack+0x10/0x20
> [  163.911095][    C1]  __might_resched+0x36f/0x530
> [  163.911105][    C1]  rt_spin_lock+0x82/0x1c0
> [  163.911112][    C1]  spin_lock_irqsave_ssp_contention+0xb8/0x100
> [  163.911121][    C1]  srcu_gp_start_if_needed+0x782/0xf00
> [  163.911128][    C1]  ? _raw_spin_unlock_irqrestore+0x46/0x70
> [  163.911136][    C1]  ? debug_object_active_state+0x336/0x470
> [  163.911148][    C1]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
> [  163.911156][    C1]  ? __pfx_lock_release+0x10/0x10
> [  163.911165][    C1]  ? __pfx_rcu_torture_barrier_cbf+0x10/0x10
> [  163.911188][    C1]  __call_srcu+0x9f/0xe0
> [  163.911196][    C1]  call_srcu+0x13/0x20
> [  163.911201][    C1]  srcu_torture_call+0x1b/0x30
> [  163.911224][    C1]  rcu_torture_barrier1cb+0x4a/0x60
> [  163.911247][    C1]  __flush_smp_call_function_queue+0x267/0xca0
> [  163.911256][    C1]  ? __pfx_rcu_torture_barrier1cb+0x10/0x10
> [  163.911281][    C1]  generic_smp_call_function_single_interrupt+0x13/0x20
> [  163.911288][    C1]  __sysvec_call_function_single+0x7d/0x280
> [  163.911295][    C1]  sysvec_call_function_single+0x93/0xd0
> [  163.911302][    C1]  </IRQ>
> [  163.911304][    C1]  <TASK>
> [  163.911308][    C1]  asm_sysvec_call_function_single+0x1b/0x20
> [  163.911313][    C1] RIP: 0010:default_idle+0x17/0x20
> [  163.911326][    C1] RSP: 0018:ffff888001997dc8 EFLAGS: 00000246
> [  163.911333][    C1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffffae618b51
> [  163.911337][    C1] RDX: 0000000000000000 RSI: ffffffffaea80920 RDI: ffffffffaec2de80
> [  163.911342][    C1] RBP: ffff888001997dc8 R08: 0000000000000001 R09: ffffed100d740cad
> [  163.911346][    C1] R10: ffffed100d740cac R11: ffff88806ba06563 R12: 0000000000000001
> [  163.911350][    C1] R13: ffffffffafe460c0 R14: ffffffffafe460c0 R15: 0000000000000000
> [  163.911358][    C1]  ? ct_kernel_exit.constprop.3+0x121/0x160
> [  163.911369][    C1]  ? lockdep_hardirqs_on+0xc4/0x150
> [  163.911376][    C1]  arch_cpu_idle+0x9/0x10
> [  163.911383][    C1]  default_idle_call+0x7a/0xb0
> [  163.911390][    C1]  do_idle+0x362/0x500
> [  163.911398][    C1]  ? __pfx_do_idle+0x10/0x10
> [  163.911404][    C1]  ? complete_with_flags+0x8b/0xb0
> [  163.911416][    C1]  cpu_startup_entry+0x58/0x70
> [  163.911423][    C1]  start_secondary+0x221/0x280
> [  163.911430][    C1]  ? __pfx_start_secondary+0x10/0x10
> [  163.911440][    C1]  secondary_startup_64_no_verify+0x17f/0x18b
> [  163.911455][    C1]  </TASK>
> 
> This commit therefore use smp_call_on_cpu() instead of
> smp_call_function_single(), make rcu_torture_barrier1cb() invoked
> happens on task-context.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Huh.  The use of non-raw spinlocks does constrain call_rcu() use, doesn't
it?  Good catch!

Queued for testing and further review.  Are there any uses of call_srcu()
out there that are unsafe on -rt?

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 48a9d47ec90e..498aae52333e 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3041,11 +3041,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
>  }
>  
>  /* IPI handler to get callback posted on desired CPU, if online. */
> -static void rcu_torture_barrier1cb(void *rcu_void)
> +static int rcu_torture_barrier1cb(void *rcu_void)
>  {
>  	struct rcu_head *rhp = rcu_void;
>  
>  	cur_ops->call(rhp, rcu_torture_barrier_cbf);
> +	return 0;
>  }
>  
>  /* kthread function to register callbacks used to test RCU barriers. */
> @@ -3071,11 +3072,9 @@ static int rcu_torture_barrier_cbs(void *arg)
>  		 * The above smp_load_acquire() ensures barrier_phase load
>  		 * is ordered before the following ->call().
>  		 */
> -		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
> -					     &rcu, 1)) {
> -			// IPI failed, so use direct call from current CPU.
> +		if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
>  			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
> -		}
> +
>  		if (atomic_dec_and_test(&barrier_cbs_count))
>  			wake_up(&barrier_wq);
>  	} while (!torture_must_stop());
> -- 
> 2.17.1
> 

