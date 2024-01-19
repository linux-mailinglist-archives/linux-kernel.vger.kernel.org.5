Return-Path: <linux-kernel+bounces-30693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634E832322
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766071F2359C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273491111;
	Fri, 19 Jan 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SWoiMBFT"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF5ECE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628951; cv=none; b=TtradnVvO/c2cUB2t3BwPWYnX1uLUilCReCX3n4ibaSM4tCBxX3Gm5+EeSXQMnaQ3LYY5uz6U6Z3gW/x0L8GEoad7lX+Q44wD8VPDR8BN7RUeJKJygJ/Y4RR1Ta5B5T3PA4SYWm1FaMCWNjmCZJwKhQ7LDR09z/Y7EqRcOdrW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628951; c=relaxed/simple;
	bh=gK+OQleKuS/cknsECiEA6hYX9ZAmgFg8eMAlDjCpRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bsbCEWKm4Hvhose8Uu/zLxmRAb/EaS0xfYYiwPEzvcC8zGrxLd1y8vK7VV4AqJBFT30ftiq0wRNHlDL3PM422oZqGVD29aTpGo8oN9IvxaapTYNSC8ENDZHqC2OnYsZf0RLhSLnsjd60Hafr6Ss7RORETlVrKE7AOEbK5Ohp1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=SWoiMBFT; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso1409135ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1705628948; x=1706233748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHLdFHbRnf6XCw7/IIoZaKINkGtuONK6C7RzvtQh+FE=;
        b=SWoiMBFTg2onlx+ylCFK5Gg5anWbk2k8TayicwDKpOh4uBH1QJw6xFdtqLa9U5YhXl
         zSv7mg47u+Jtv2jM5pzFf2cR4EKohVoYNP8OkNip623b/2v3y9wtklYBjwSW8QaMkYao
         I+CUx0u7c2MnmsOzWCPAXAXSJGCsKUMLVoeb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628948; x=1706233748;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHLdFHbRnf6XCw7/IIoZaKINkGtuONK6C7RzvtQh+FE=;
        b=fHpgE81rpeVSd/ZET5xB6DuInjbv7dPO2yrIDHJc4w+IqkyvS+FRtkPv7zNcVOrgR1
         NFSbCR9BX2pup1SCs0PWeJI8maca+pjoY4IQl8/pdf2U6RJ5WF7nQQDKKUPIBJGf6+f4
         DQGkhPH5BO7KAdTXLFwIcd2WD8Gnl8SFJElX9vCbqVvbJk1HTd+23C6u3hdTWChggHAU
         Des9PnszAFvk1xCrztAxqnyu9NsrzlBv2Xb2wVEbLtEJB2h4bPKctrfZuOQk1DDDWNT/
         p1Gw6w6W0hlbiUdc/W9C2tnIK0Ka+9LmUZFvFyCQqlKZqozSRM6BZrQp6t8d8bwpEbSC
         NgRw==
X-Gm-Message-State: AOJu0YzidCV42SQ5XN+hvLhrCHdphYgqam63f6Pp/2zq7aQ8RBso0eVb
	CU+46kTnbCHKHkuQUSih0boyEw7L3ey0v6JJiW20YWrz6EhkSBx2uZsAzPXMy68=
X-Google-Smtp-Source: AGHT+IHnBpf5qPOkJPuoxdidkIQlFCjvIy07l78lKcv9ClFOLG+eILEnZd8kEdvSBrKH/GMLan/KtQ==
X-Received: by 2002:a05:6e02:ec9:b0:361:a3ba:cd28 with SMTP id i9-20020a056e020ec900b00361a3bacd28mr1189572ilk.15.1705628947753;
        Thu, 18 Jan 2024 17:49:07 -0800 (PST)
Received: from localhost (125.91.188.35.bc.googleusercontent.com. [35.188.91.125])
        by smtp.gmail.com with ESMTPSA id ck12-20020a056e02370c00b003608a649906sm5151527ilb.43.2024.01.18.17.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:49:07 -0800 (PST)
Date: Fri, 19 Jan 2024 01:49:06 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>, suleiman@google.com
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <20240119013217.GA3948162@joelbox2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>

On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
> Add an interface for fair server setup on debugfs.
> 
> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
> 
>  - fair_server_runtime: set runtime in ns
>  - fair_server_period: set period in ns
>  - fair_server_defer: on/off for the defer mechanism
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Hi Daniel, Peter,
I am writing on behalf of the ChromeOS scheduler team.

We had to revert the last 3 patches in this series because of a syzkaller
reported bug, this happens on the sched/more branch in Peter's tree:

 WARNING: CPU: 0 PID: 2404 at kernel/sched/fair.c:5220
 place_entity+0x240/0x290 kernel/sched/fair.c:5147
 Call Trace:
 <TASK>
  enqueue_entity+0xdf/0x1130 kernel/sched/fair.c:5283
  enqueue_task_fair+0x241/0xbd0 kernel/sched/fair.c:6717
  enqueue_task+0x199/0x2f0 kernel/sched/core.c:2117
  activate_task+0x60/0xc0 kernel/sched/core.c:2147
  ttwu_do_activate+0x18d/0x6b0 kernel/sched/core.c:3794
  ttwu_queue kernel/sched/core.c:4047 [inline]
  try_to_wake_up+0x805/0x12f0 kernel/sched/core.c:4368
  kick_pool+0x2e7/0x3b0 kernel/workqueue.c:1142
  __queue_work+0xcf8/0xfe0 kernel/workqueue.c:1800
  queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:1986
  queue_delayed_work include/linux/workqueue.h:577 [inline]
  srcu_funnel_gp_start kernel/rcu/srcutree.c:1068 [inline]

which is basically this warning in place_entity:
		if (WARN_ON_ONCE(!load))
			load = 1;

Full log (scroll to the bottom as there is console/lockdep side effects which
are likely not relevant to this issue): https://paste.debian.net/1304579/

Side note, we are also looking into a KASAN nullptr deref but this happens
only on our backport of the patches to a 5.15 kernel, as far as we know.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 1592 Comm: syz-executor.0 Not tainted [...]
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
 RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline] 
 RIP: 0010:rb_erase+0x664/0xe1e lib/rbtree.c:445
 [...]
Call Trace:
 <TASK>
  set_next_entity+0x6e/0x576 kernel/sched/fair.c:4728
  set_next_task_fair+0x1bb/0x355 kernel/sched/fair.c:11943
  set_next_task kernel/sched/sched.h:2241 [inline] 
  pick_next_task kernel/sched/core.c:6014 [inline] 
  __schedule+0x36fb/0x402d kernel/sched/core.c:6378
  preempt_schedule_common+0x74/0xc0 kernel/sched/core.c:6590
  preempt_schedule+0xd6/0xdd kernel/sched/core.c:6615

Full splat: https://paste.debian.net/1304573/

Investigation is on going but could you also please take a look at these? It
is hard to reproduce and only syzkaller's syzbot has luck so for reproducing
these.

Also I had a comment below:

> +int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
> +{
> +	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +	u64 new_bw = to_ratio(period, runtime);
> +	struct rq *rq = dl_se->rq;
> +	int cpu = cpu_of(rq);
> +	struct dl_bw *dl_b;
> +	unsigned long cap;
> +	int retval = 0;
> +	int cpus;
> +
> +	dl_b = dl_bw_of(cpu);
> +	raw_spin_lock(&dl_b->lock);
> +	cpus = dl_bw_cpus(cpu);
> +	cap = dl_bw_capacity(cpu);
> +
> +	if (__dl_overflow(dl_b, cap, old_bw, new_bw)) {

The dl_overflow() call here seems introducing an issue with our conceptual
understanding of how the dl server is supposed to work.

Suppose we have a 4 CPU system. Also suppose RT throttling is disabled.
Suppose the DL server params are 50ms runtime in 100ms period (basically we
want to dedicate 50% of the bandwidth of each CPU to CFS).

In such a situation, __dl_overflow() will return an error right? Because
total bandwidth will exceed 100% (4 times 50% is 200%).

Further, this complicates the setting of the parameters since it means we
have to check the number of CPUs in advance and then set the parameters to
prevent dl_overflow(). As an example of this, 30% (runtime / period) for each
CPU will work fine if we have 2 CPUs. But if we have 4 CPUs, it will not work
because __dl_overflow() will fail.

How do you suggest we remedy this? Can we make the dlserver calculate how
much bandwidth is allowed on a per-CPU basis? My understanding is the fake
dl_se are all pinned to their respective CPUs, so we don't have the same
requirement as real DL tasks which may migrate freely within the root domain.

thanks,

 - Joel


