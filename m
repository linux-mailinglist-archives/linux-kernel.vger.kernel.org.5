Return-Path: <linux-kernel+bounces-3188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF58168B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51329B2278B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98510976;
	Mon, 18 Dec 2023 08:52:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC111CA5;
	Mon, 18 Dec 2023 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 596031FB;
	Mon, 18 Dec 2023 00:52:44 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC6D3F5A1;
	Mon, 18 Dec 2023 00:51:57 -0800 (PST)
Message-ID: <212396c7-8c36-4850-8871-ea4c757a9324@arm.com>
Date: Mon, 18 Dec 2023 09:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
 Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
 Hongyan Xia <hongyan.xia2@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 02:52, Qais Yousef wrote:
> Due to the way code is structured, it makes a lot of sense to trigger
> cpufreq_update_util() from update_load_avg(). But this is too aggressive
> as in most cases we are iterating through entities in a loop to
> update_load_avg() in the hierarchy. So we end up sending too many
> request in an loop as we're updating the hierarchy.
> 
> Combine this with the rate limit in schedutil, we could end up
> prematurely send up a wrong frequency update before we have actually
> updated all entities appropriately.
> 
> Be smarter about it by limiting the trigger to perform frequency updates
> after all accounting logic has done. This ended up being in the

What are the boundaries of the 'accounting logic' here? Is this related
to the update of all sched_entities and cfs_rq's involved when a task is
attached/detached (or enqueued/dequeued)?

I can't see that there are any premature cfs_rq_util_change() in the
current code when we consider this.

And avoiding updates for a smaller task to make sure updates for a
bigger task go through is IMHO not feasible.

I wonder how much influence does this patch has on the test results
presented the patch header?

> following points:
> 
> 1. enqueue/dequeue_task_fair()
> 2. throttle/unthrottle_cfs_rq()
> 3. attach/detach_task_cfs_rq()
> 4. task_tick_fair()
> 5. __sched_group_set_shares()
> 
> This is not 100% ideal still due to other limitations that might be
> a bit harder to handle. Namely we can end up with premature update
> request in the following situations:
> 
> a. Simultaneous task enqueue on the CPU where 2nd task is bigger and
>    requires higher freq. The trigger to cpufreq_update_util() by the
>    first task will lead to dropping the 2nd request until tick. Or
>    another CPU in the same policy trigger a freq update.
> 
> b. CPUs sharing a policy can end up with the same race in a but the
>    simultaneous enqueue happens on different CPUs in the same policy.
> 
> The above though are limitations in the governor/hardware, and from
> scheduler point of view at least that's the best we can do. The
> governor might consider smarter logic to aggregate near simultaneous
> request and honour the higher one.

[...]


