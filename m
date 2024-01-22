Return-Path: <linux-kernel+bounces-33145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D446F836532
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A3E1C21EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9DC3D392;
	Mon, 22 Jan 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyEMlHbL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DA3D3BD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932873; cv=none; b=ma+ChYFJNEjN0KqOou9ZcQ/B5fVJd1yoHsyIz+HRoXCbweg/2xBntfbm0Ipyycr1WKq1iOsdOMraPTEjOlzqKgOmBWEk+jstgVOfUZjypt02YpbeJfrbgP4Lj1kdHWNm2uLMYUqP+xPFNmACtDKhg6vXtr//JMI7ERHS5lg2i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932873; c=relaxed/simple;
	bh=BQ6gFzHqZAx03sLDR1/WL2v2QuZhXNI1WhQrc0qkpQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5kXdOSxX209zJGXmwB6HM0EU61fInmvvJLOY5NUUcHbBNywGKIoBwWFfoA7RRkyWDM7n7msyuMXX6sK6dxXedWZNsNXahhfLxik8O/WQGQn4XdR7387FYDqEjAkVCk7Pjp7/7DLC9/D35G2pAH8m54O1X2RUI4swruQPoXBw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyEMlHbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705932870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XEEjzdk0Rf+nEQCD7UZIB/maeiQi36/Xok7ETyhddQ=;
	b=UyEMlHbLlFkB0dIGR2uYSi7WJuQPe5r5tamTloIpYaLJj8rRcErsPN+skeMuhEsD5t7aj/
	58f+BOOT/1e/DhKvQm8fbu5jbtfP6Qg5iJP97xqCUXppjIG3aGU3sRxIj8/k0I2dN4wjH5
	INg2pCFYUzSvNPj0ziS/AwTaksIlr3U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DVBJW_3POF2yF7RO89NINQ-1; Mon, 22 Jan 2024 09:14:28 -0500
X-MC-Unique: DVBJW_3POF2yF7RO89NINQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50edc80b859so2700461e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932866; x=1706537666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XEEjzdk0Rf+nEQCD7UZIB/maeiQi36/Xok7ETyhddQ=;
        b=aEhGZhLmxqgoTJU3kkEHEG1xb3MYG/vUmKeCxtevAwQO1n1K+3BaiB6OSGXdQD5xhp
         MsPbnwF+oZYCSCeh93WZ1mcOboaZCx2qSxpSTRHQ3F1VBTobAwioCFnPznLrvPY3mdl6
         vqX32UdbuOWxv0upTkfvNCm4XItvVgBfOWR/o4iV9RmYev1SBg7++Oz8HDlF4/mU1Sc+
         mJ5aoZ4SwFpIBPgiElbXHylfGc9Yyhpn7sRrBSCxuCcmtgjigZuHqRWmAqo/VxvY2H6/
         O+Rqi/mn9hunnIM0aGAKLypq9PQf3rmR7Q1KRXrX6w8IYm3LVYkFiKci/qAp4g1kyaVM
         jicg==
X-Gm-Message-State: AOJu0Yx9n6pncRH8umc47geJQyX0U+G6SUStWONWpmXcH6wv3mOQ5YE8
	gsOzT64orhAJpUM6sh7mU0t8VnBlL24/kudOYrK3MY38uFd/WuMJ/KivGnq3YglZfDjVslInLUH
	MnSWoBTLGl9Dhe8DjGQphIHxHAApamlXT00dzkbedcQ8/VT546Hc+UPuF1okvxg==
X-Received: by 2002:a05:6512:108b:b0:50e:76ca:52c6 with SMTP id j11-20020a056512108b00b0050e76ca52c6mr2125852lfg.52.1705932866706;
        Mon, 22 Jan 2024 06:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo40sQ0u2EUJVSZcUQzW6OuIefuJhXgUD9VxMgB9KIi+Q5twdhyWeqfEVGEgtkcTDbUjvOLw==
X-Received: by 2002:a05:6512:108b:b0:50e:76ca:52c6 with SMTP id j11-20020a056512108b00b0050e76ca52c6mr2125825lfg.52.1705932866304;
        Mon, 22 Jan 2024 06:14:26 -0800 (PST)
Received: from [192.168.0.182] (host-79-47-205-27.retail.telecomitalia.it. [79.47.205.27])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a3025e05665sm1645538ejc.14.2024.01.22.06.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 06:14:25 -0800 (PST)
Message-ID: <3f002616-0975-49b8-a2bf-04abd0446b95@redhat.com>
Date: Mon, 22 Jan 2024 15:14:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
To: Joel Fernandes <joel@joelfernandes.org>,
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
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240119015513.GA2187855@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 02:55, Joel Fernandes wrote:
> On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>
>>  - fair_server_runtime: set runtime in ns
>>  - fair_server_period: set period in ns
>>  - fair_server_defer: on/off for the defer mechanism
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
> Hi Daniel, Peter,
> I am writing on behalf of the ChromeOS scheduler team.
> 
> We had to revert the last 3 patches in this series because of a syzkaller
> reported bug, this happens on the sched/more branch in Peter's tree:
> 
>  WARNING: CPU: 0 PID: 2404 at kernel/sched/fair.c:5220
>  place_entity+0x240/0x290 kernel/sched/fair.c:5147
>  Call Trace:
>  <TASK>
>   enqueue_entity+0xdf/0x1130 kernel/sched/fair.c:5283
>   enqueue_task_fair+0x241/0xbd0 kernel/sched/fair.c:6717
>   enqueue_task+0x199/0x2f0 kernel/sched/core.c:2117
>   activate_task+0x60/0xc0 kernel/sched/core.c:2147
>   ttwu_do_activate+0x18d/0x6b0 kernel/sched/core.c:3794
>   ttwu_queue kernel/sched/core.c:4047 [inline]
>   try_to_wake_up+0x805/0x12f0 kernel/sched/core.c:4368
>   kick_pool+0x2e7/0x3b0 kernel/workqueue.c:1142
>   __queue_work+0xcf8/0xfe0 kernel/workqueue.c:1800
>   queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:1986
>   queue_delayed_work include/linux/workqueue.h:577 [inline]
>   srcu_funnel_gp_start kernel/rcu/srcutree.c:1068 [inline]
> 
> which is basically this warning in place_entity:
> 		if (WARN_ON_ONCE(!load))
> 			load = 1;
> 
> Full log (scroll to the bottom as there is console/lockdep side effects which
> are likely not relevant to this issue): https://paste.debian.net/1304579/
> 
> Side note, we are also looking into a KASAN nullptr deref but this happens
> only on our backport of the patches to a 5.15 kernel, as far as we know.
> 
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 1592 Comm: syz-executor.0 Not tainted [...]
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>  RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline] 
>  RIP: 0010:rb_erase+0x664/0xe1e lib/rbtree.c:445
>  [...]
> Call Trace:
>  <TASK>
>   set_next_entity+0x6e/0x576 kernel/sched/fair.c:4728
>   set_next_task_fair+0x1bb/0x355 kernel/sched/fair.c:11943
>   set_next_task kernel/sched/sched.h:2241 [inline] 
>   pick_next_task kernel/sched/core.c:6014 [inline] 
>   __schedule+0x36fb/0x402d kernel/sched/core.c:6378
>   preempt_schedule_common+0x74/0xc0 kernel/sched/core.c:6590
>   preempt_schedule+0xd6/0xdd kernel/sched/core.c:6615
> 
> Full splat: https://paste.debian.net/1304573/

Interesting, does it keep any task hung? I am having a case where I see
a hung task, but I do not get the splat because the system freezes (printk
with rq_lock I guess)...

It might be the same problem.

> Investigation is on going but could you also please take a look at these? It
> is hard to reproduce and only syzbot has luck reproducing these.
> 
> Also I had a comment below:
> 
>> +int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
>> +{
>> +	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
>> +	u64 new_bw = to_ratio(period, runtime);
>> +	struct rq *rq = dl_se->rq;
>> +	int cpu = cpu_of(rq);
>> +	struct dl_bw *dl_b;
>> +	unsigned long cap;
>> +	int retval = 0;
>> +	int cpus;
>> +
>> +	dl_b = dl_bw_of(cpu);
>> +	raw_spin_lock(&dl_b->lock);
>> +	cpus = dl_bw_cpus(cpu);
>> +	cap = dl_bw_capacity(cpu);
>> +
>> +	if (__dl_overflow(dl_b, cap, old_bw, new_bw)) {
> 
> The dl_overflow() call here seems introducing an issue with our conceptual
> understanding of how the dl server is supposed to work.
> 
> Suppose we have a 4 CPU system. Also suppose RT throttling is disabled.
> Suppose the DL server params are 50ms runtime in 100ms period (basically we
> want to dedicate 50% of the bandwidth of each CPU to CFS).
> 
> In such a situation, __dl_overflow() will return an error right? Because
> total bandwidth will exceed 100% (4 times 50% is 200%).

I might be missing something in your case, but, it accepts:

root@fedora:/sys/kernel/debug/sched/fair_server# find . -type f -exec cat {} \;
1
1000000000
500000000
1
1000000000
500000000
1
1000000000
500000000
1
1000000000
500000000

your system accepts 400%... the percentage is "global".

is it failing in your system?

-- Daniel


