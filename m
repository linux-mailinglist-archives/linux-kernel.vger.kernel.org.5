Return-Path: <linux-kernel+bounces-35576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B2839387
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FD1F29F38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F8629E1;
	Tue, 23 Jan 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wnGarE2M"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACD6280F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024388; cv=none; b=qGTcGQmNsf/fjDp5s+yF+h7j/2LmqvhwOg4cnew1gpmqCNDZsBi5oeaFN6MoB9UryVkklFBWCvDp8DK6max0DWgl8k+v/BK9tI/NnfE6Dgrm/sxJD/dRYleYw1bcs+qwmF34OPHwyzIrxmaEUPAfW8Dd0Va2T7W+hPyNILS5OD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024388; c=relaxed/simple;
	bh=a4lm+M3kBCZfNNMVDvae5TfH+v0peF+o5u0dFdVdnz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTHeJ6QqIXhWk4qGxjEA3+eQjc7CJLkIx1bgPFB9I5wSllKDwIHKVVw0zyTvtashj9xCVuufh7E3pzB7QzUGgU/1keRDz4H47w6ru5OkIvjyBSavlPCVi63aE0HQgtv/SUHdoC7MOS6gxpSU35YaMEsyIvSn/dMx8ftyMpsI9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=wnGarE2M; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6868f31a564so8492996d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706024385; x=1706629185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jg/36DXjVSIOJwnqQmLY+I7w/sgkBWIrFqbZcbe04C0=;
        b=wnGarE2MjKqD1Kv2ssmF3FEjik2YR6SzFkEGbsrUW7o4gubP2A2ZkaeBZG30qpV7uZ
         W05BTRVK3+NfzOzHAYW+hDeAKrHqj/i3Gn5Gvz73b/0QmjQrxfZlpEctMe6nOaO0+5wl
         kpkOpKdlYs0oIgB+qgHMQ/rFmpPm+zRqxYO+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024385; x=1706629185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg/36DXjVSIOJwnqQmLY+I7w/sgkBWIrFqbZcbe04C0=;
        b=gEphhgHjQnhG20n3i1rB3ucVJDPwxOcD1OF5i9es9iSjQPnd1ffHJbkQz+WM968JxT
         fkP/VDEMmvDT4DY7Qk+q0yACbaW9JtCf/+h3yEO8DY2m1Cydv0oAt2WESnYtf+3vsagm
         sdCiT/5Ua3AOTF1EuNO5mDpXZs1I8yYGEGoPfBH/+LtcrE2EUA0A1HnxKGrEvlPURwgG
         rHzjowPDUoWNYgPDlTcz7Fpin7/kM3a/jh2SNtCXiio4z/MTSjDAWD7MurNlBu0qRRLp
         0osRibgM2Oo2jJeFKjJa03sEwVziJnjRpHhQ8R1OnrQkUvUnFYAfjvZKC87J9czFnR8T
         8g9g==
X-Gm-Message-State: AOJu0Yx4S91dXtj5Nu3O2CSdbRCbewl7DDifSuGuHa8CES5LYeAA8XQX
	w1a6EMIzG4vTjcwCWo2CzBW8mrV+vigObYw3VtE9VmrNmNojGKUsGKBycSEbHfk=
X-Google-Smtp-Source: AGHT+IEFP4ynd2iBwDvVgH/Qejs86ak5Lf6u1wSvbm+5oUIweAj8S+3fRRPoanQCsYkvw7A6mR7Cog==
X-Received: by 2002:a0c:9c8d:0:b0:681:7ba9:e1da with SMTP id i13-20020a0c9c8d000000b006817ba9e1damr992289qvf.121.1706024384795;
        Tue, 23 Jan 2024 07:39:44 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ceb07000000b00681092cb7b4sm3518197qvp.103.2024.01.23.07.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:39:44 -0800 (PST)
Message-ID: <2b0868a5-a399-4aa6-8321-90c10e380d90@joelfernandes.org>
Date: Tue, 23 Jan 2024 10:39:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@redhat.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 suleiman@google.com
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20240119015513.GA2187855@google.com>
 <3f002616-0975-49b8-a2bf-04abd0446b95@redhat.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <3f002616-0975-49b8-a2bf-04abd0446b95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 1/22/2024 9:14 AM, Daniel Bristot de Oliveira wrote:
> On 1/19/24 02:55, Joel Fernandes wrote:
>> On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
>>> Add an interface for fair server setup on debugfs.
>>>
>>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>>
>>>  - fair_server_runtime: set runtime in ns
>>>  - fair_server_period: set period in ns
>>>  - fair_server_defer: on/off for the defer mechanism
>>>
>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>>
>> Hi Daniel, Peter,
>> I am writing on behalf of the ChromeOS scheduler team.
>>
>> We had to revert the last 3 patches in this series because of a syzkaller
>> reported bug, this happens on the sched/more branch in Peter's tree:
>>
>>  WARNING: CPU: 0 PID: 2404 at kernel/sched/fair.c:5220
>>  place_entity+0x240/0x290 kernel/sched/fair.c:5147
>>  Call Trace:
>>  <TASK>
>>   enqueue_entity+0xdf/0x1130 kernel/sched/fair.c:5283
>>   enqueue_task_fair+0x241/0xbd0 kernel/sched/fair.c:6717
>>   enqueue_task+0x199/0x2f0 kernel/sched/core.c:2117
>>   activate_task+0x60/0xc0 kernel/sched/core.c:2147
>>   ttwu_do_activate+0x18d/0x6b0 kernel/sched/core.c:3794
>>   ttwu_queue kernel/sched/core.c:4047 [inline]
>>   try_to_wake_up+0x805/0x12f0 kernel/sched/core.c:4368
>>   kick_pool+0x2e7/0x3b0 kernel/workqueue.c:1142
>>   __queue_work+0xcf8/0xfe0 kernel/workqueue.c:1800
>>   queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:1986
>>   queue_delayed_work include/linux/workqueue.h:577 [inline]
>>   srcu_funnel_gp_start kernel/rcu/srcutree.c:1068 [inline]
>>
>> which is basically this warning in place_entity:
>> 		if (WARN_ON_ONCE(!load))
>> 			load = 1;
>>
>> Full log (scroll to the bottom as there is console/lockdep side effects which
>> are likely not relevant to this issue): https://paste.debian.net/1304579/
>>
>> Side note, we are also looking into a KASAN nullptr deref but this happens
>> only on our backport of the patches to a 5.15 kernel, as far as we know.
>>
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 0 PID: 1592 Comm: syz-executor.0 Not tainted [...]
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>>  RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline] 
>>  RIP: 0010:rb_erase+0x664/0xe1e lib/rbtree.c:445
>>  [...]
>> Call Trace:
>>  <TASK>
>>   set_next_entity+0x6e/0x576 kernel/sched/fair.c:4728
>>   set_next_task_fair+0x1bb/0x355 kernel/sched/fair.c:11943
>>   set_next_task kernel/sched/sched.h:2241 [inline] 
>>   pick_next_task kernel/sched/core.c:6014 [inline] 
>>   __schedule+0x36fb/0x402d kernel/sched/core.c:6378
>>   preempt_schedule_common+0x74/0xc0 kernel/sched/core.c:6590
>>   preempt_schedule+0xd6/0xdd kernel/sched/core.c:6615
>>
>> Full splat: https://paste.debian.net/1304573/
> 
> Interesting, does it keep any task hung? I am having a case where I see
> a hung task, but I do not get the splat because the system freezes (printk
> with rq_lock I guess)...
> 
> It might be the same problem.

Ah, we have an update. Suleiman found this is happening because of core
scheduling's pick logic. I have some patches to fix it, there's also more fixes
we have on other issues. Will coordinate with the team to send these out soon.
We are currently testing them more.

>> Investigation is on going but could you also please take a look at these? It
>> is hard to reproduce and only syzbot has luck reproducing these.
>>
>> Also I had a comment below:
>>
>>> +int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
>>> +{
>>> +	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
>>> +	u64 new_bw = to_ratio(period, runtime);
>>> +	struct rq *rq = dl_se->rq;
>>> +	int cpu = cpu_of(rq);
>>> +	struct dl_bw *dl_b;
>>> +	unsigned long cap;
>>> +	int retval = 0;
>>> +	int cpus;
>>> +
>>> +	dl_b = dl_bw_of(cpu);
>>> +	raw_spin_lock(&dl_b->lock);
>>> +	cpus = dl_bw_cpus(cpu);
>>> +	cap = dl_bw_capacity(cpu);
>>> +
>>> +	if (__dl_overflow(dl_b, cap, old_bw, new_bw)) {
>>
>> The dl_overflow() call here seems introducing an issue with our conceptual
>> understanding of how the dl server is supposed to work.
>>
>> Suppose we have a 4 CPU system. Also suppose RT throttling is disabled.
>> Suppose the DL server params are 50ms runtime in 100ms period (basically we
>> want to dedicate 50% of the bandwidth of each CPU to CFS).
>>
>> In such a situation, __dl_overflow() will return an error right? Because
>> total bandwidth will exceed 100% (4 times 50% is 200%).
> 
> I might be missing something in your case, but, it accepts:
> 
> root@fedora:/sys/kernel/debug/sched/fair_server# find . -type f -exec cat {} \;
> 1
> 1000000000
> 500000000
> 1
> 1000000000
> 500000000
> 1
> 1000000000
> 500000000
> 1
> 1000000000
> 500000000
> 
> your system accepts 400%... the percentage is "global".
> 
> is it failing in your system?

You are right, I was actually trying to change it manually in my kernel in
dl_server_start(). In this case dlserver_apply_server_params() gets init=1 and
old_bw is 0.

I tried using the debugfs, and that works. So I think we will just use the
debugfs. I was being lazy and setting it in my kernel manually for testing like
this:

@@ -1475,7 +1475,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
         * this before getting generic.
         */
        if (!dl_server(dl_se)) {
               u64 runtime = 12 * NSEC_PER_MSEC;
                u64 period = 15 * NSEC_PER_MSEC;

That doesn't work but I tried debugfs and it works. But for production, we will
set it from userspace so it should not be an issue.

I feel so much better now :) Thanks Daniel.

By the way, what's the plan on remaining patches in sched/more branch, are you
planning to resend those later? If so, we can just post our fixes on top of
that, and if you don't mind you could include it in your next series posting
(sched/more + our fixes + your fixes).

Thanks!

 - Joel


