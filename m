Return-Path: <linux-kernel+bounces-30698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168383232F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04791F22DED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22D15A4;
	Fri, 19 Jan 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v3DntcEi"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C1137E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629317; cv=none; b=TMPcNTaJK2QJX57AcP4OEJ+fhsxq/GOJsI8mfoNrqgqGIJa7ySk3fsOdO+V8/qItxBlmh5FmakXUP0sK2oOX0dCvZeq0QWMltT2xudoEXPKMbe09MWaTiq3+j8tj/Zp4goRiDywYftJl3cmJ3MfUD0G17J6gs8a25b8Hxlk+uPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629317; c=relaxed/simple;
	bh=lnh9B2h/RWCq+LZ9oCbKCmYI+tuSYS8zA8HFQWnuLY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUBEYnpwu4C7D8EkdZVlja+qG4LnTYu8ZtRV2wTHt8R4SBRcHL9cxzf7eotdu1YHcl1vD5N73FlnvOZpxHoRy2AseFjnCtTJdIO/8IPOYRR8quGYhEW8NSwbMn2lLqOhPn0xNg+mB6Wkd33GfaW1l4M6FPLJFbsMu3cEPHFmDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=v3DntcEi; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36074b286d8so1104515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1705629314; x=1706234114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXpNpZlTIemJdSNv8ZOrmuJqt0K0OO1cizPdd0s4020=;
        b=v3DntcEikQwNn+W94nDgo5jDyiGsdezgwL8VB97nECpayLir4vZKsSp50jULtYox5C
         VMqTmXPJRbp0aBxgZGkvqsvSP4t0Cr9ytUyhXaWldKJtph7fkXPENR1T5Ftrboxa5Anh
         c9LFXDw66HprxPe+l9fUePx2ZnQ3BdhyVbAx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629314; x=1706234114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXpNpZlTIemJdSNv8ZOrmuJqt0K0OO1cizPdd0s4020=;
        b=vPgkVPuPf72M7pNQwChY+KGB5bvTpBr2C5gC7B1MZLmSevlUjSu64JmJjgMqcWRaOQ
         CXb8LnQDamk0rmML0WFn9iT3mvFxyBCghysLQPSE4x6kEqfKXoIzbc5+jhLTiXNk+CCO
         ychecW8JFbQOz3AGU2QUHQ2h3zrNvzodwO/JnYwz9xhLsHw7CicYimrZ6DHIFtaMAxvg
         B1ddNhD6pIBod83GWUi2vrrQwsAXc+CrjfY1q5exbP4jxur3seWkA2g2910OqzftltfU
         zCtkHa0HNASJ5l4A09nUbvwniQIOZMUjgK8Gv6+jujVYym7mRAPaZsgWlsm6Si5Sa3VO
         NoPA==
X-Gm-Message-State: AOJu0Yz5AySQaoUCx5zKnvRbcy4pRKUhf/CWqsH5YoqNVIkK7CifJzkB
	zGKD+oGuYLiFWpAqxqW26Jxag2iD7utJi8uFolZ4zKY2hY9BvW5qZ01IwOjTlLU=
X-Google-Smtp-Source: AGHT+IHOxsBlpBM7Hd4PcnGU7puB1JvcaTAFl8DvF7uuWPTY2gDb0TxYSyCjJGF5AKyFek+BgK7Mzw==
X-Received: by 2002:a92:da8e:0:b0:361:a975:58a9 with SMTP id u14-20020a92da8e000000b00361a97558a9mr435545iln.35.1705629314667;
        Thu, 18 Jan 2024 17:55:14 -0800 (PST)
Received: from localhost (125.91.188.35.bc.googleusercontent.com. [35.188.91.125])
        by smtp.gmail.com with ESMTPSA id q9-20020a056e02106900b00361a24b9e06sm487802ilj.18.2024.01.18.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:55:14 -0800 (PST)
Date: Fri, 19 Jan 2024 01:55:13 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <20240119015513.GA2187855@google.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
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
is hard to reproduce and only syzbot has luck reproducing these.

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


