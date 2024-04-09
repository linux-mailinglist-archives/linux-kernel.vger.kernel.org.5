Return-Path: <linux-kernel+bounces-137453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2889E25F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7BF1F23E11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F428156861;
	Tue,  9 Apr 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1UehCBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E7156883
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686604; cv=none; b=oVE8vpSXGkuaTeQW3PTeCyeezvYEc6Wglc1Rn+UEwk+pjJ1JR1fNevbhRbiUnolMGWJqRv5mJsGLPGjW/qcnAO3MbD0ZZrzTNIsB7SiQJmihNLhFrFSxuIhyYY0wXJn+21g+gOKwe7cCC7yoSSKUl2nil4ucdoCEp5rpFRLyJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686604; c=relaxed/simple;
	bh=xx5nJgPBYfQGg8nUKkmyefd8lfIOFiEmSmWrpC3/z4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQhlmYPNXCmqrftPOmj5tBHk3UmO821e01Qahe9aQWtFU2fNLxHC31cQTGyL/NnRB3TIkIaJ8rXYox/K2dXKnpCRJVmSKshgslgFjSls9X91dHJjsO0vOUFnb5VyLiJQQj1xWgVQaa+XG7kgcioeYiEw5zwgVupWBEmUviQb2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1UehCBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F00AC433F1;
	Tue,  9 Apr 2024 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712686604;
	bh=xx5nJgPBYfQGg8nUKkmyefd8lfIOFiEmSmWrpC3/z4A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=H1UehCBs7+Uztx4JxSqPup2ByxAOyoi/VXnUTgjLEiY1M/wzj7JPNwT44EOAWKYAL
	 zYwpc+QpMAG3ds86eoKSRnoHywHUifuGddbRAbiVL6zj4W+efr69RFm57AQVEDf4aD
	 TLKm+4FcQsw5liVdeuUxVljoWZqqjDL/t3ouBFjeB9Th5nkJ1bZ7HaWqojqRn08L4/
	 tz1NTbH0Xj4DnKxqTnQlSE+wAHV0Cb84ERlIel1ov0eAfMhS5+r0X6QkVCZcw5+Iu+
	 kUQZAtUkNa4c3ODXRm3ekryDg1ls1p5CJIk2CpLkd+BBfsFa5zhIHfo7YFjCL92DiT
	 5QfxUR3hzl9Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 764AECE2D22; Tue,  9 Apr 2024 11:16:43 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:16:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop_machine: call rcu_momentary_dyntick_idle() from irq
 disable path
Message-ID: <0696bf2e-29a3-40a3-80dc-c5002f447f4b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1712649736-27058-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712649736-27058-1-git-send-email-quic_mojha@quicinc.com>

On Tue, Apr 09, 2024 at 01:32:16PM +0530, Mukesh Ojha wrote:
> rcu_momentary_dyntick_idle() is getting called from all the irq
> disable path(also documented in rcu_momentary_dyntick_idle())
> however, in multi_cpu_stop() it is not.
> 
> "
> 
>  * Let the RCU core know that this CPU has gone through the scheduler,
>  * which is a quiescent state.  This is called when the need for a
>  * quiescent state is urgent, so we burn an atomic operation and full
>  * memory barriers to let the RCU core know about it, regardless of what
>  * this CPU might (or might not) do in the near future.
>  *
>  * We inform the RCU core by emulating a zero-duration dyntick-idle period.
>  *
>  * The caller must have disabled interrupts and must not be idle.
> 
> "
> 
> 
> Let's fix this as it is possible that during stop_machine() call for
> a kprobe registration[1] can get stuck when one cpu(cpu4) calls
> rcu_momentary_dyntick_idle() after acking MULTI_STOP_PREPARE state[2]
> and other cpus have acked MULTI_STOP_DISABLE_IRQ and waiting for earlier
> cpu to reach to next state [3].

Good eyes!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> [1]
> 
>     [<ffffffdb78c75c54>] __switch_to+0x1e8
>     [<ffffffdb78c76520>] __schedule+0x6bc
>     [<ffffffdb78c76af0>] preempt_schedule_common+0xb4
>     [<ffffffdb78c75e60>] preempt_schedule[jt]+0x20
>     [<ffffffdb77dd7bd0>] queue_stop_cpus_work[jt]+0xdc
>     [<ffffffdb77dd781c>] stop_machine_cpuslocked+0xdc
>     [<ffffffdb78c816f8>] aarch64_insn_patch_text[jt]+0x4c
>     [<ffffffdb78c81938>] arch_arm_kprobe+0x40
>     [<ffffffdb77de88c0>] arm_kprobe+0x3c
>     [<ffffffdb77de84f4>] register_kprobe+0x3fc
> 
> 
> [2]
> 000|check_preemption_disabled(what1 = 0xFFFFFFDB79153D0B, what2 = 0xFFFFFFDB7912A911)
>     |  what1 = 0xFFFFFFDB79153D0B
>     |  what2 = 0xFFFFFFDB7912A911
> -001|__this_cpu_preempt_check(op = ?)
> -002|rcu_preempt_need_deferred_qs(inline)
>     |  t = 0xFFFFFF8806879F80
>     |  pscr_ret__ = 0
> -002|rcu_preempt_deferred_qs(inline)
>     |  t = 0xFFFFFF8806879F80
>     |  flags = 0
> -002|rcu_momentary_dyntick_idle()
> -003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_PREPARE     ==> This seems to have acked MULTI_STOP_PREPARE
>                                              state and calls rcu_momentary_dyntick_idle()
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -004|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6D812F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -005|smpboot_thread_fn(:data = 0xFFFFFF8805C063C0)
>     |  data = 0xFFFFFF8805C063C0
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -006|kthread(_create = 0xFFFFFF8806B7EC00)
>     |  _create = 0xFFFFFF8806B7EC00
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C063C0
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806402F00
>     |  done = 0xFFFFFFC08005BA98
> -007|ret_from_fork(asm)
> 
> [3]
> 000|touch_softlockup_watchdog()                                                    
> -001|touch_nmi_watchdog(inline)                                             
> -001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  newstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -002|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6D04EF28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -003|smpboot_thread_fn(:data = 0xFFFFFF8805C06230)
>     |  data = 0xFFFFFF8805C06230
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -004|kthread(_create = 0xFFFFFF8806469D80)
>     |  _create = 0xFFFFFF8806469D80
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C06230
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806401500
>     |  done = 0xFFFFFFC08005B888
> -005|ret_from_fork(asm)
> ---|end of frame
>  
> cpu1:
>  
> -000|touch_softlockup_watchdog()
> -001|touch_nmi_watchdog(inline)
> -001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  newstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -002|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6D23FF28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -003|smpboot_thread_fn(:data = 0xFFFFFF8805C06270)
>     |  data = 0xFFFFFF8805C06270
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -004|kthread(_create = 0xFFFFFF88066119C0)
>     |  _create = 0xFFFFFF88066119C0
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C06270
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806401000
>     |  done = 0xFFFFFFC08005BA98
> -005|ret_from_fork(asm)
> ---|end of frame
>  
> cpu2:
>  
> -000|touch_softlockup_watchdog()
> -001|touch_nmi_watchdog(inline)
> -001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  newstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -002|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6D430F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -003|smpboot_thread_fn(:data = 0xFFFFFF8805C062E0)
>     |  data = 0xFFFFFF8805C062E0
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -004|kthread(_create = 0xFFFFFF88067D5B80)
>     |  _create = 0xFFFFFF88067D5B80
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C062E0
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806403F00
>     |  done = 0xFFFFFFC08005BA98
> -005|ret_from_fork(asm)
> ---|end of frame
>  
> cpu3:
>  
> -000|touch_softlockup_watchdog_sched(inline)
>     |  __ptr = 18446743916840366040
> -000|touch_softlockup_watchdog()
> -001|touch_nmi_watchdog(inline)
> -001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  newstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -002|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6D621F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -003|smpboot_thread_fn(:data = 0xFFFFFF8805C06350)
>     |  data = 0xFFFFFF8805C06350
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -004|kthread(_create = 0xFFFFFF88069E7300)
>     |  _create = 0xFFFFFF88069E7300
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C06350
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806403300
>     |  done = 0xFFFFFFC08005BA98
> -005|ret_from_fork(asm)
> ---|end of frame
>  
>  
> Cpu5:
>  
> -000|check_preemption_disabled(what1 = ?, what2 = ?)
>     |  what1 = ?
>     |  what2 = ?
> -001|debug_smp_processor_id()
> -002|ct_state_inc(inline)
>     |  incby = 8
>     |  __ptr = 0
> -002|rcu_momentary_dyntick_idle()
>     |  seq = 0
> -003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -004|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6DA03F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -005|smpboot_thread_fn(:data = 0xFFFFFF8805C06430)
>     |  data = 0xFFFFFF8805C06430
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -006|kthread(_create = 0xFFFFFF8806D58180)
>     |  _create = 0xFFFFFF8806D58180
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C06430
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806402400
>     |  done = 0xFFFFFFC08005BA98
> -007|ret_from_fork(asm)
> ---|end of frame
>  
> Cpu6:
>  
> -000|check_preemption_disabled(what1 = ?, what2 = ?)
>     |  what1 = ?
>     |  what2 = ?
> -001|__this_cpu_preempt_check(op = ?)
> -002|rcu_preempt_need_deferred_qs(inline)
>     |  t = 0xFFFFFF8806E03F00
>     |  pscr_ret__ = 0
> -002|rcu_preempt_deferred_qs(inline)
>     |  t = 0xFFFFFF8806E03F00
>     |  flags = 0
> -002|rcu_momentary_dyntick_idle()
> -003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -004|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6DBF4F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -005|smpboot_thread_fn(:data = 0xFFFFFF8805C064A0)
>     |  data = 0xFFFFFF8805C064A0
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -006|kthread(_create = 0xFFFFFF8806F67D00)
>     |  _create = 0xFFFFFF8806F67D00
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C064A0
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806402600
>     |  done = 0xFFFFFFC08005BA98
> -007|ret_from_fork(asm)
> ---|end of frame
>  
> Cpu7:
>  
> -000|check_preemption_disabled(what1 = ?, what2 = ?)
>     |  what1 = ?
>     |  what2 = ?
> -001|__this_cpu_preempt_check(op = ?)
> -002|rcu_preempt_need_deferred_qs(inline)
>     |  t = 0xFFFFFF8806E1DE80
>     |  pscr_ret__ = 0
> -002|rcu_preempt_deferred_qs(inline)
>     |  t = 0xFFFFFF8806E1DE80
>     |  flags = 0
> -002|rcu_momentary_dyntick_idle()
> -003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
>     |  data = 0xFFFFFFC084343478
>     |  msdata = 0x0
>     |  curstate = MULTI_STOP_DISABLE_IRQ
>     |  flags = 0
>     |  is_active = TRUE
>     |  cpumask = 0xFFFFFFDB79E37718
>     |  err = 0
> -004|cpu_stopper_thread(cpu = ?)
>     |  cpu = ?
>     |  __already_done = FALSE
>     |  stopper = 0xFFFFFF8B6DDE5F28
>     |  fn = 0xFFFFFFDB77DD74C4
>     |  arg = 0xFFFFFFC084343478
>     |  done = 0xFFFFFFC0843434A0
>     |  ret = ???
> -005|smpboot_thread_fn(:data = 0xFFFFFF8805C06510)
>     |  data = 0xFFFFFF8805C06510
>     |  td = 0x0
>     |  ht = 0xFFFFFFDB79EE8B40
> -006|kthread(_create = 0xFFFFFF88070FF300)
>     |  _create = 0xFFFFFF88070FF300
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF8805C06510
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF8806407D00
>     |  done = 0xFFFFFFC08005BA98
> -007|ret_from_fork(asm)
> ---|end of frame
> 
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  kernel/stop_machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..f93e6deb8150 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -250,8 +250,8 @@ static int multi_cpu_stop(void *data)
>  			 * be detected and reported on their side.
>  			 */
>  			touch_nmi_watchdog();
> +			rcu_momentary_dyntick_idle();
>  		}
> -		rcu_momentary_dyntick_idle();
>  	} while (curstate != MULTI_STOP_EXIT);
>  
>  	local_irq_restore(flags);
> -- 
> 2.7.4
> 

