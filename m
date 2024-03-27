Return-Path: <linux-kernel+bounces-121370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCE88E700
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792A41C2709B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58644159576;
	Wed, 27 Mar 2024 13:35:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FAC12E1C9;
	Wed, 27 Mar 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546507; cv=none; b=SXCcqpovZAsilJF0mTm3FW5MIxKpqKKgyN0+9DCxvY+8oGJdPHdbyBG+2px8dACcWpvmDsmMBqj+sUIp1a5zOy+unt0VRoXDXFOHXBLUsL5zh5LZj6pbRWc1XNJMOkodAsD5ytjriUIwfSjN5Q6vNMEneEhHHirgWAlnGpv9q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546507; c=relaxed/simple;
	bh=ooKZ6O9tR9+QN4moCAzd2mBAdIEUT5709FoWcHHdLnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIphwFNRtYRBK6mNSaBz5HdFc0/muB19hym7+tcaY0b1Fz1w/bdpwRpHY8MTuFM5iL1oo5CTZSWnik57sWdqusz84NMOcVSftTK2UHAfSecG9hNWroBN91M+/Y7dUTsltYkL2/mCkYU++/NacAk2cQclRizWWXhiejxJVCsnV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 792FE2F4;
	Wed, 27 Mar 2024 06:35:39 -0700 (PDT)
Received: from [10.57.53.95] (unknown [10.57.53.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D365E3F7BD;
	Wed, 27 Mar 2024 06:35:02 -0700 (PDT)
Message-ID: <bd7f537a-87a5-43e6-bde1-acb82dd4ec1e@arm.com>
Date: Wed, 27 Mar 2024 13:35:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240324020139.1032473-1-qyousef@layalina.io>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240324020139.1032473-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2024 02:01, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.
> 
> At the moment we send them when load is updated for CFS, bandwidth for
> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> sent in a short period of time and potentially be ignored at a critical
> moment due to the rate_limit_us in schedutil.
> 
> For example, simultaneous task enqueue on the CPU where 2nd task is
> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> the first task will lead to dropping the 2nd request until tick. Or
> another CPU in the same policy triggers a freq update shortly after.
> 
> Updates at enqueue for RT are not strictly required. Though they do help
> to reduce the delay for switching the frequency and the potential
> observation of lower frequency during this delay. But current logic
> doesn't intentionally (at least to my understanding) try to speed up the
> request.
> 
> To help reduce the amount of cpufreq updates and make them more
> purposeful, consolidate them into these locations:
> 
> 1. context_switch()
> 2. task_tick_fair()
> 3. {attach, detach}_entity_load_avg()
> 4. update_blocked_averages()
> 
> The update at context switch should help guarantee that DL and RT get
> the right frequency straightaway when they're RUNNING. As mentioned
> though the update will happen slightly after enqueue_task(); though in
> an ideal world these tasks should be RUNNING ASAP and this additional
> delay should be negligible. For fair tasks we need to make sure we send
> a single update for every decay for the root cfs_rq. Any changes to the
> rq will be deferred until the next task is ready to run, or we hit TICK.
> But we are guaranteed the task is running at a level that meets its
> requirements after enqueue.
> 
> To guarantee RT and DL tasks updates are never missed, we add a new
> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> already running at the right freq, the governor will end up doing
> nothing, but we eliminate the risk of the task ending up accidentally
> running at the wrong freq due to rate_limit_us.

There may be two things in this patch:

1. Have well-defined, centralized places where we update CPU frequency.
2. The FORCE_UPDATE flag.

I agree that at the moment, frequency updates inside the scheduler are 
scattered around in many places, and they can be called consecutively in 
a short period of time. Defining those places explicitly instead of 
triggering frequency updates here and there sounds like a good idea, so 
I definitely support 1.

Not sure about 2. I think rate limit is there for a reason, although I 
don't have that many platforms to test on to know whether forcing the 
update is a problem.

> 
> [...] 

