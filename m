Return-Path: <linux-kernel+bounces-119494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED688C9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEE81F8222C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1DE17543;
	Tue, 26 Mar 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K66bOyz+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162912E6D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471576; cv=none; b=ob+ORQu3qax2eiD+1rqAqyJQsb9jGSJsMLsAIMs3KqTS8IiuDFLN434XmUPq/Q/HTPIQOOi/S1H7XhM8QZHdno8N96TDVGR9xaAITTqP787hNyCMHlQzWHLLbTtLWwVVUmWc1Ph9NPEWX6nyn2am87Y8f7AkV+tHaYjPrYeBgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471576; c=relaxed/simple;
	bh=PGEJKSyR3dKryFSZaBORLq7xsAzvi6++4k/BbJbRro0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUYcfkjql09lfWFwBVUQNq9Vrj9rfrHBTf060befa6ewDqlqX/ym8BE9oxQ1wDg3TLYYCp5CwMlNP8+JY9AjES93pm8nwvNjry8JYAryLKS1yXP61DnydsBc9n3nivs++t/DoNpYiJiGj6C5lgmoS+UfQU1B6tfD2RfPpqsV2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K66bOyz+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711471573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTeIfJgqqvwbzhtFi5ncrTU7NPCUF/rEKgoFtSMwubw=;
	b=K66bOyz+2GFT9jSsjYItQvcR1qeEhUSzhfxIG7W5yH1kFEfANIXG0ZHCBSRzGCgFo6YsYk
	+JUekzLxu681MsnW/uwZAKLRPa1QFZ76gd10ERtWHUl0TBytiVgiW7IZeTcv1v/VMvp/6t
	CPsvVLt3wv4vyZ1dDxyR4wPktDUCCJI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-na3DdmMvPlGlP96x2hOpag-1; Tue, 26 Mar 2024 12:46:12 -0400
X-MC-Unique: na3DdmMvPlGlP96x2hOpag-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69046d68828so70268766d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471571; x=1712076371;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTeIfJgqqvwbzhtFi5ncrTU7NPCUF/rEKgoFtSMwubw=;
        b=MA2Lk5SrOltavrUTIW7Nvd61Py21KcC9r1iekgDFJ7P0NGy8GXrgPqghQxfHTBp/O/
         6qJiP89VUuC3YHI/zUI5cRIRZ7NS9JDm+6P7z2HhsCTg0uxOY91oMUivMYvndO9M56VY
         cmeMCAJPRZJS/QgCTbQmhYWhiN9IMxtx2ed2ks63FAxnVo04UmxqyVK2vxvKN32dtf0k
         wSx+Nwx1ulca31QI3qgEMWZp2ftfo5+arA4tm5MEckdvVdBymCMA+T+cKz74iwL3hrYg
         +ouDNFVf1WEG5MEdbTIOjXl4kd27YIWtKubeuxvOKaDTQaVlzk9wluimbBeCIkHD1654
         GWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUE1w0fMcr+Yw4svqQi8x5+BeQZovoNdsdGw7wjUEPbOoZ1TTD0Z+g6bCaFNUmXc8WgQ50W57bytZBqxe/rQMukgwXSoB7cbS8ZRPVp
X-Gm-Message-State: AOJu0YxEBtxfjaWUV6/iclYI9x2PILwIiY4aO786TcXFb90UN4of4CNl
	vKppQwr8UXSe4FpOe5/F1NAuBJTZKLka8mbrTC/7Y75bYFTvEG5gnLeIhzCOCpG1Sz0VmGS5Q8h
	wVFZRca+Qg6MzOW9zws4tb5dhAJYONyEwNSZlr/szdMbinboUuHmkcE+VMx19zg==
X-Received: by 2002:a05:6214:18b:b0:696:7ba4:260 with SMTP id q11-20020a056214018b00b006967ba40260mr171219qvr.35.1711471571577;
        Tue, 26 Mar 2024 09:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMFgL/hFQCAmhE6Guz8fuBYWBJEGGFiShB7hQlHqsUHNl1seVJfJj8UEriw+7wVAVlN42bOw==
X-Received: by 2002:a05:6214:18b:b0:696:7ba4:260 with SMTP id q11-20020a056214018b00b006967ba40260mr171202qvr.35.1711471571254;
        Tue, 26 Mar 2024 09:46:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a056214040f00b00690c77505bdsm5408414qvx.37.2024.03.26.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:46:10 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
In-Reply-To: <Zf2GDjekyemQKn7I@lothringen>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
Date: Tue, 26 Mar 2024 17:46:07 +0100
Message-ID: <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I've just noticed this thread while cleaning up my inbox, apologies for the
delayed response.

On 22/03/24 14:22, Frederic Weisbecker wrote:
> On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
>> On Thu, Mar 21, 2024 at 05:47:59AM -0700, Paul E. McKenney wrote:
>> [ 1484.955213] WARNING: CPU: 6 PID: 162 at kernel/time/hrtimer.c:1088 enqueue_hrtimer+0x6f/0x80
>> [ 1484.962513] Modules linked in:
>> [ 1484.966476] CPU: 6 PID: 162 Comm: rcu_torture_rea Not tainted 6.8.0 #25
>> [ 1484.972975] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>> [ 1484.977653] RIP: 0010:enqueue_hrtimer+0x6f/0x80
>> [ 1484.978679] Code: a3 05 75 6a b7 01 73 bd 48 8b 05 e4 47 b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 eb bd ff ff 48 8b 03 f6 40 10 10 75 a5 90 <0f> 0b 90 eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
>> [ 1484.983136] RSP: 0000:ffffa553805cfd70 EFLAGS: 00010046
>> [ 1484.984386] RAX: ffff8c395f260440 RBX: ffff8c395f260480 RCX: ffff8c395f260440
>> [ 1484.986121] RDX: 0000000000000000 RSI: ffff8c395f260480 RDI: ffffa553805cfde0
>> [ 1484.987704] RBP: ffffa553805cfde0 R08: 0000000000000001 R09: 000000000000fc03
>> [ 1484.989513] R10: 0000000000000001 R11: ffff8c3941248e40 R12: 0000000000000040
>> [ 1484.991116] R13: ffff8c395f260480 R14: ffff8c395f260480 R15: ffff8c395f260440
>> [ 1484.992835] FS:  0000000000000000(0000) GS:ffff8c395f380000(0000) knlGS:0000000000000000
>> [ 1484.994683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1484.995985] CR2: 0000000000000000 CR3: 000000001a62c000 CR4: 00000000000006f0
>> [ 1484.997789] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 1484.999376] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 1485.001177] Call Trace:
>> [ 1485.002388]  <TASK>
>> [ 1485.002923]  ? __warn+0x78/0x120
>> [ 1485.003641]  ? enqueue_hrtimer+0x6f/0x80
>> [ 1485.004641]  ? report_bug+0xf1/0x1d0
>> [ 1485.005537]  ? handle_bug+0x40/0x70
>> [ 1485.006318]  ? exc_invalid_op+0x13/0x70
>> [ 1485.007167]  ? asm_exc_invalid_op+0x16/0x20
>> [ 1485.008117]  ? enqueue_hrtimer+0x6f/0x80
>> [ 1485.009131]  hrtimer_start_range_ns+0x258/0x2f0
>> [ 1485.010153]  ? __pfx_rcu_torture_reader+0x10/0x10
>> [ 1485.011185]  schedule_hrtimeout_range_clock+0x96/0x120
>> [ 1485.012394]  ? __pfx_hrtimer_wakeup+0x10/0x10
>> [ 1485.013502]  stutter_wait+0x7f/0x90
>> [ 1485.014319]  rcu_torture_reader+0x10e/0x280
>> [ 1485.015240]  ? __pfx_rcu_torture_timer+0x10/0x10
>> [ 1485.016317]  ? kthread+0xc6/0xf0
>> [ 1485.017169]  ? __pfx_rcu_torture_reader+0x10/0x10
>> [ 1485.018215]  kthread+0xc6/0xf0
>> [ 1485.018899]  ? __pfx_kthread+0x10/0x10
>> [ 1485.019703]  ret_from_fork+0x2b/0x40
>> [ 1485.020546]  ? __pfx_kthread+0x10/0x10
>> [ 1485.021428]  ret_from_fork_asm+0x1b/0x30
>> [ 1485.022295]  </TASK>
>> 
>> This happens within the following loop
>> 
>> 	for_each_domain(cpu, sd) {
>> 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
>> 			if (cpu == i)
>> 				continue;
>> 
>> 			if (!idle_cpu(i))
>> 				return i;
>> 		}
>> 	}
>> 
>> An offline CPU is returned from there. Which is not supposed to happen
>> as it's within an RCU read side. But I can't manage to find where those
>> rq->sd things are modified when a CPU is offlining. The code path is hard
>> to follow. Adding some scheduler people involved in topology just in case.
>> Investigation continues...
>
> So I just tried a simple test. I applied the following PoF patch, under the
> assumption that right after the exit of takedown_cpu(), the target CPU is
> offline and all CPUs must see the updates perfomed by the now dead target
> CPU. I expect also that the target CPU should have removed itself from the
> scheduling domains (though I don't know where that happens in the maze):
>

If it's of any help:

during hot-unplug, the scheduler will start poking the sched_domains in
CPUHP_AP_ACTIVE:sched_cpu_deactivate(). We then get to, in the "worst" case
with CONFIG_CPUSET=y:

sched_cpu_deactivate()
`\
  cpuset_cpu_inactive()
  `\
    cpuset_update_active_cpus() # delegated to a workqueue because cpusets are fun

cpuset_hotplug_workfn()
`\
  rebuild_sched_domains()
  `\
    rebuild_sched_domains_locked()

And there, eventually, we assign a NULL rq->sd to the offline CPU:

partition_sched_domains_locked()
`\
  detach_destroy_domains()
  `\
    for_each_cpu(i, cpu_map)
      cpu_attach_domain(NULL, &def_root_domain, i);
        rcu_assign_pointer(rq->sd, sd);

The steps can be followed with CONFIG_SCHED_DEBUG=y and sched_verbose on
the cmdline:

# echo 0 > /sys/devices/system/cpu/cpu3/online
[   23.173551] smpboot: CPU 3 is now offline

# That's the detach_destroy_domains() loop:
[   23.174125] CPU0 attaching NULL sched-domain.
[   23.174570] CPU1 attaching NULL sched-domain.
[   23.175008] CPU2 attaching NULL sched-domain.
[   23.175410] CPU3 attaching NULL sched-domain.

# That's the build_sched_domains() loop:
[   23.175767] CPU0 attaching sched-domain(s):
[   23.176091]  domain-0: span=0-2 level=MC
[   23.176381]   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }
[   23.176805] CPU1 attaching sched-domain(s):
[   23.177127]  domain-0: span=0-2 level=MC
[   23.177426]   groups: 1:{ span=1 }, 2:{ span=2 }, 0:{ span=0 }
[   23.177849] CPU2 attaching sched-domain(s):
[   23.178171]  domain-0: span=0-2 level=MC
[   23.178482]   groups: 2:{ span=2 }, 0:{ span=0 }, 1:{ span=1 }
[   23.178902] root domain span: 0-2

> diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> index 6d67e9a5af6b..2e0580abc73a 100644
> --- a/include/linux/sched/nohz.h
> +++ b/include/linux/sched/nohz.h
> @@ -9,6 +9,7 @@
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  extern void nohz_balance_enter_idle(int cpu);
>  extern int get_nohz_timer_target(void);
> +extern void sched_assert_online_domains(int cpu);
>  #else
>  static inline void nohz_balance_enter_idle(int cpu) { }
>  #endif
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6c0a92ca6bb5..3424d1d40142 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1024,7 +1024,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  }
>  
>  /* Take this CPU down. */
> -static int take_cpu_down(void *_param)
> +int take_cpu_down(void *_param)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..57f483fc1037 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1055,6 +1055,22 @@ void resched_cpu(int cpu)
>  
>  #ifdef CONFIG_SMP
>  #ifdef CONFIG_NO_HZ_COMMON
> +void sched_assert_online_domains(int cpu)
> +{
> +	struct sched_domain *sd;
> +	int i;
> +
> +	rcu_read_lock();
> +	for_each_domain(cpu, sd) {
> +		for_each_cpu(i, sched_domain_span(sd)) {
> +			if (cpu == i)
> +				continue;
> +
> +			WARN_ON_ONCE(cpu_is_offline(i));
> +		}
> +	}
> +	rcu_read_unlock();
> +}
>  /*
>   * In the semi idle case, use the nearest busy CPU for migrating timers
>   * from an idle CPU.  This is good for power-savings.
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..354806156bd9 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -22,6 +22,7 @@
>  #include <linux/atomic.h>
>  #include <linux/nmi.h>
>  #include <linux/sched/wake_q.h>
> +#include <linux/sched/nohz.h>
>  
>  /*
>   * Structure to determine completion condition and record errors.  May
> @@ -199,6 +200,8 @@ notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
>  	cpu_relax();
>  }
>  
> +extern int take_cpu_down(void *_param);
> +
>  /* This is the cpu_stop function which stops the CPU. */
>  static int multi_cpu_stop(void *data)
>  {
> @@ -255,6 +258,8 @@ static int multi_cpu_stop(void *data)
>  	} while (curstate != MULTI_STOP_EXIT);
>  
>  	local_irq_restore(flags);
> +	if (!is_active && msdata->fn == take_cpu_down)
> +		sched_assert_online_domains(smp_processor_id());
>  	return err;
>  }
>  
> Then with that patch I ran TREE07, just some short iterations:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" --allcpus --bootargs "rcutorture.onoff_interval=200" --duration 2
>
> And the warning triggers very quickly. At least since v6.3 but maybe since
> earlier. Is this expected behaviour or am I right to assume that
> for_each_domain()/sched_domain_span() shouldn't return an offline CPU?
>

I would very much assume an offline CPU shouldn't show up in a
sched_domain_span().

Now, on top of the above, there's one more thing worth noting:
  cpu_up_down_serialize_trainwrecks()

This just flushes the cpuset work, so after that the sched_domain topology
should be sane. However I see it's invoked at the tail end of _cpu_down(),
IOW /after/ takedown_cpu() has run, which sounds too late. The comments
around this vs. lock ordering aren't very reassuring however, so I need to
look into this more.

Maybe as a "quick" test to see if this is the right culprit, you could try
that with CONFIG_CPUSET=n? Because in that case the sched_domain update is
ran within sched_cpu_deactivate().

> Thanks.


