Return-Path: <linux-kernel+bounces-4693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ABA8180AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A88F1F24984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355EF79F0;
	Tue, 19 Dec 2023 04:45:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAC79C2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.253])
	by sina.com (172.16.235.25) with ESMTP
	id 65811F4F000065A6; Tue, 19 Dec 2023 12:42:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 62226334210294
X-SMAIL-UIID: 94D3518CDBBD49DC8BA30D3158000DA7-20231219-124257-1
From: Hillf Danton <hdanton@sina.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Date: Tue, 19 Dec 2023 12:42:47 +0800
Message-Id: <20231219044247.1708-1-hdanton@sina.com>
In-Reply-To: <20231218231916.11719-3-frederic@kernel.org>
References: <20231218231916.11719-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 00:19:15 +0100 Frederic Weisbecker <frederic@kernel.org>
> +static void swake_up_one_online(struct swait_queue_head *wqh)
> +{
> +	int cpu = get_cpu();
> +
> +	/*
> +	 * If called from rcutree_report_cpu_starting(), wake up
> +	 * is dangerous that late in the CPU-down hotplug process. The
> +	 * scheduler might queue an ignored hrtimer. Defer the wake up
> +	 * to an online CPU instead.
> +	 */

But why is scheduler having any interest selecting a dying CPU for
adding a hrtimer on at the first place?

> +	if (unlikely(cpu_is_offline(cpu))) {
> +		int target;
> +
> +		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
> +					 cpu_online_mask);
> +
> +		smp_call_function_single(target, swake_up_one_online_ipi,
> +					 wqh, 0);
> +		put_cpu();
> +	} else {
> +		put_cpu();
> +		swake_up_one(wqh);
> +	}
> +}

