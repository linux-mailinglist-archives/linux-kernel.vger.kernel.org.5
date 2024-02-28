Return-Path: <linux-kernel+bounces-85185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B286B1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2FF1F2448F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05871612FC;
	Wed, 28 Feb 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I9a1Eqv1"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01A37140
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130741; cv=none; b=V2oia1QXNRswMaM7tgaJZAOesm2FWL3pcysPYeD4fxbYSsE8qmIpTBCV0pL8xJcj8SLuqtUjzl0PtYDKL/V5suEywKoZSTo0wQAbNLLCvkUHUgULVZnbxnbhlU/GyPZ5bPe7hd3iXXGvl1nmXqMgngY8DdAKRUCANX/CUB0vMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130741; c=relaxed/simple;
	bh=15MoiuiISB93ItUXn/dMMVi2ONQU2BJzf8977IxO8RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTBbwLaUaTb47KsyYPG9OSRZScrhcdv92L5Oz7Oi5SsTzLt+AI7tNR7LYD5j4hd0K/6cGoCGptNH3G8IU8/Mwf5IbxYxJNxx1pDb3wrnvim0Z8qAJWYbBO+Cwluu50CtOEJNkXZg3tZ+m+wURxmGYkR1wo5CUcUmgdBz5Jwc8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=I9a1Eqv1; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c48ef54d9bso118278339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709130738; x=1709735538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUafWbf8Gqrdc1XkYunFZEFWTkiZ2ixMRNi+7B77x0M=;
        b=I9a1Eqv1cilkMsvfefXLfpJYkZm227La7X1289ZcKL2ehikmZ+DKeqcE1hGe2F/YMD
         YSIw24hibYW+CFwO5AAaDNrbI0IFpTtROVpPnRx5b9iIW0O7yQyToMEKvz/R1kZCc1Rz
         t1C4/8fEnvRViZj4u7aLn9hZN3Z2Iz7GQdEa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130738; x=1709735538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUafWbf8Gqrdc1XkYunFZEFWTkiZ2ixMRNi+7B77x0M=;
        b=IEghbCmnQaFN4ZeH2d+s8AWv+/3fXCUEu7AVA7tMarl+j9MsgbRxg7cMW2msSwqlqk
         aDi1QMTIlat1s2BwwiU0TLjCwdhWy0fPRWjFvIoNOJfcbQyjbGKewevAnYEXySsePunh
         4e7Yj1Vc2v+6pxO6EjZD9s++y0GMji/dQbbyf++pEf0hBhAnwkYXGLeeglSKigwL7iMw
         sYtD0d+Edo3bp3/8NL8uhYAM5IlkJ/hptujegyGv6qrTMI7lwxKSiFb5xNxTy/swIWc2
         GbaMOsKhqIMngeJ7ZCAAADLyZoqwrZhsa+aZXsRSqoLyxALz8mNKztom50iTdzPuGVGG
         qyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXI/G1pe50NARFYFsbPdLkWDU0lWaCo14s/fZ9DUZZHedHoS8LrdxvHbEZJsjC6/r+ffOKjeQ2qb6dTwkTfXGhMR9Bby7WCJQr6zbQb
X-Gm-Message-State: AOJu0YycF10oG3ssC3Kgw5t+RPaXhB0/J8/qZagGuJOVqt2qVXyGd7jV
	T48E6nMf48+UmkqhCtswUYLSiR0oAzCgCkTgOybVttzF724srgQQ1xxQxvvOX10=
X-Google-Smtp-Source: AGHT+IHzIuRXX9W3uUuLUpzSzy3HfsCBnxCVoprN0zB2pTYV1pFfHLuiZpkLlTP8FaFF2sGzpHHYmA==
X-Received: by 2002:a05:6602:1642:b0:7c7:2099:8bc0 with SMTP id y2-20020a056602164200b007c720998bc0mr17698169iow.2.1709130738179;
        Wed, 28 Feb 2024 06:32:18 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id b21-20020a02a595000000b00474267973afsm2223464jam.36.2024.02.28.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:32:17 -0800 (PST)
Message-ID: <572f9069-f79f-4432-b2ac-7f963a526c0b@joelfernandes.org>
Date: Wed, 28 Feb 2024 09:32:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240220183115.74124-3-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
> A call to a synchronize_rcu() can be optimized from a latency
> point of view. Workloads which depend on this can benefit of it.
> 
> The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> depends on several factors:
> 
> - how fast a process of offloading is started. Combination of:
>     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
>     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
>     - other.
> - when started, invoking path is interrupted due to:
>     - time limit;
>     - need_resched();
>     - if limit is reached.
> - where in a nocb list it is located;
> - how fast previous callbacks completed;
> 
> Example:
> 
> 1. On our embedded devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
> 
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> <snip>
> 
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
> 
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
> 
> cgroup_attach_task():
>  -> cgroup_migrate_execute()
>    -> cpuset_can_attach()
>      -> percpu_down_write()
>        -> rcu_sync_enter()
>          -> synchronize_rcu()
>    -> now move tasks to the new cgroup.
>  -> cgroup_migrate_finish()
> 
> <snip>
>          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
>     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
>    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> <snip>
> 
> "Boosting a task" depends on synchronize_rcu() latency:
> 
> - first trace shows a completion of synchronize_rcu();
> - second shows attaching a task to a new group;
> - last shows a final step when migration occurs.
> 
> 3. To address this drawback, maintain a separate track that consists
> of synchronize_rcu() callers only. After completion of a grace period
> users are deferred to a dedicated worker to process requests.
> 
> 4. This patch reduces the latency of synchronize_rcu() approximately
> by ~30-40% on synthetic tests. The real test case, camera launch time,
> shows(time is in milliseconds):
> 
> 1-run 542 vs 489 improvement 9%
> 2-run 540 vs 466 improvement 13%
> 3-run 518 vs 468 improvement 9%
> 4-run 531 vs 457 improvement 13%
> 5-run 548 vs 475 improvement 13%
> 6-run 509 vs 484 improvement 4%
> 
> Synthetic test(no "noise" from other callbacks):
> Hardware: x86_64 64 CPUs, 64GB of memory
> Linux-6.6
> 
> - 10K tasks(simultaneous);
> - each task does(1000 loops)
>      synchronize_rcu();
>      kfree(p);
> 
> default: CONFIG_RCU_NOCB_CPU: takes 54 seconds to complete all users;
> patch: CONFIG_RCU_NOCB_CPU: takes 35 seconds to complete all users.
> 
> Running 60K gives approximately same results on my setup. Please note
> it is without any interaction with another type of callbacks, otherwise
> it will impact a lot a default case.
> 
> 5. By default it is disabled. To enable this perform one of the
> below sequence:
> 
> echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  14 +
>  kernel/rcu/tree.c                             | 331 +++++++++++++++++-
>  kernel/rcu/tree_exp.h                         |   2 +-
>  3 files changed, 345 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2244aa0a013b..7ca84cf7b4f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5059,6 +5059,20 @@
>  			delay, memory pressure or callback list growing too
>  			big.
>  
> +	rcutree.rcu_normal_wake_from_gp= [KNL]
> +			Reduces a latency of synchronize_rcu() call. This approach
> +			maintains its own track of synchronize_rcu() callers, so it
> +			does not interact with regular callbacks because it does not
> +			use a call_rcu[_hurry]() path. Please note, this is for a
> +			normal grace period.
> +
> +			How to enable it:
> +
> +			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> +
> +			Default is 0.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c8980d76f402..1328da63c3cd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -75,6 +75,7 @@
>  #define MODULE_PARAM_PREFIX "rcutree."
>  
>  /* Data structures. */
> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.gpwrap = true,
> @@ -93,6 +94,8 @@ static struct rcu_state rcu_state = {
>  	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>  	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> +	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> +		rcu_sr_normal_gp_cleanup_work),
>  };
>  
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -1422,6 +1425,282 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
[..]
> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> +{
> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> +}
> +

I'm a bit concerned from a memory order PoV about this llist_add() happening
possibly on a different CPU than the GP thread, and different than the kworker
thread. Basically we can have 3 CPUs simultaneously modifying and reading the
list, but only 2 CPUs have the acq-rel pair AFAICS.

Consider the following situation:

synchronize_rcu() user
----------------------
llist_add the user U - update srs_next list

rcu_gp_init() and rcu_gp_cleanup (SAME THREAD)
--------------------
insert dummy node in front of U, call it S
update wait_tail to U

and then cleanup:
read wait_tail to W
set wait_tail to NULL
set done_tail to W (RELEASE) -- this release ensures U and S are seen by worker.

workqueue handler
-----------------
read done_tail (ACQUIRE)
disconnect rest of list -- disconnected list guaranteed to have U and S,
                           if done_tail read was W.
---------------------------------

So llist_add() does this (assume new_first and new_last are same):

	struct llist_node *first = READ_ONCE(head->first);

	do {
		new_last->next = first;
	} while (!try_cmpxchg(&head->first, &first, new_first));

	return !first;
---

It reads head->first, then writes the new_last->next (call it new_first->next)
to the old first, then sets head->first to the new_first if head->first did not
change in the meanwhile.

The problem I guess happens if the update the head->first is seen *after* the
update to the new_first->next.

This potentially means a corrupted list is seen in the workqueue handler..
because the "U" node is not yet seen pointing to the rest of the list
(previously added nodes), but is already seen the head of the list.

I am not sure if this can happen, but AFAIK try_cmpxchg() doesn't imply ordering
per-se. Maybe that try_cmpxchg() should be a try_cmpxchg_release() in llist_add() ?

thanks,

 - Joel

