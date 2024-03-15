Return-Path: <linux-kernel+bounces-104399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05B087CD49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C6283C04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8EE241E3;
	Fri, 15 Mar 2024 12:31:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187418E2A;
	Fri, 15 Mar 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505880; cv=none; b=Jgs6JxY8hpY+b46WWrzJWqg3lnS30DyCDRpvMA53cW9ymJdsTl0gw5Ulj+MMMsEvmJb7ShUPzUPjWARG2n4KV/mIn4q9812ueath0TN1IiCXnGGncgfK395404ntvBZjb64bRl29ZaDhWoMS+qkFt0IG0/Ie18UNcN53E5I1ExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505880; c=relaxed/simple;
	bh=JTSXdyneMUtKsAMMlrMN88s36RTjQQq2KAmbHZDa4x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUTou/Rg1es85I82N2d40743/gHvgScYMx3LZt6Ld0Lef8MGwPeqgU531tV4joyO8p2cD8vuWunzNK0ZAYlOl8PJfK0YIYDoBcwNWa68DKV0MPfELSzSveefdWQli+NEksyJl9AHb0rSPL+KIoad2Lvat5YDw5MpFgq1oMqyu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 023F1C15;
	Fri, 15 Mar 2024 05:31:53 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E1F3F73F;
	Fri, 15 Mar 2024 05:31:14 -0700 (PDT)
Message-ID: <5bb38524-fd13-477f-adde-0a9ac01bfeae@arm.com>
Date: Fri, 15 Mar 2024 13:31:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] sched/fair: Use CFS util_avg_uclamp for
 utilization and frequency
Content-Language: en-US
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>,
 linux-pm@vger.kernel.org
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <4f755ae12895bbc74a74bac56bf2ef0f30413a32.1706792708.git.hongyan.xia2@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <4f755ae12895bbc74a74bac56bf2ef0f30413a32.1706792708.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 14:12, Hongyan Xia wrote:

[...]

> @@ -7685,11 +7697,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  static unsigned long
>  cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  {
> -	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> -	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> +	struct rq *rq = cpu_rq(cpu);
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	unsigned long util = root_cfs_util(rq);
> +	bool capped = uclamp_rq_is_capped(rq);

I try to rerun your tests in your 2 ipynbs (cover letter) but this let's
the sum aggr stack go sideways ...

if 'sched_uclamp_used' then uclamp_rq_is_capped() will call
cpu_util_cfs()->cpu_util() which then calls uclamp_rq_is_capped()
recursively resulting in a stack overflow.

Do you have a fix for that you can share? For the time I remove the call
to uclamp_rq_is_capped() in cpu_util().

[...]

