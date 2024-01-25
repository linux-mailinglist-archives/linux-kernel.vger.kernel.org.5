Return-Path: <linux-kernel+bounces-38399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAEC83BF05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519D6B29789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC372C68E;
	Thu, 25 Jan 2024 10:36:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141B2C1A5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178965; cv=none; b=fTCE1XGb87kQGZNJQF/be4mJRTzZys79m00DYp0aKWW7qyEcDekx8XFP5+Md7vihhJCacVsDFFSsvtPAR5DfGOk5608WFSf3yux+ItJsXbTlUfbohfq1njtXmkqQROBKbnaz3AKna7Ghgw86L6Gp2J7gGL44VQE/FcSZp9ToamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178965; c=relaxed/simple;
	bh=QunludCpWOczG06nUPPbdxRjHN2eZEK3fcZ/1ZhK8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQqAwOX4RdXrvBUZI6qYhgiXBjLaflZFuoxYK2r+tT+7d2QRQQuDGqQXZwp1x8fyEYPNT/4jp/yDgyb5ci/o+afFOY8WrlcvuXQOn6O0uKLPZHNBnvk4aAR+3IvEHvJI21ueZ2WbVjUfawDihA8helLMtwRIvdCIgajXwnYtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E39E1FB;
	Thu, 25 Jan 2024 02:36:41 -0800 (PST)
Received: from [10.43.7.55] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46883F73F;
	Thu, 25 Jan 2024 02:35:55 -0800 (PST)
Message-ID: <08334d9d-8a0a-468f-a1db-ce6c19e491f7@arm.com>
Date: Thu, 25 Jan 2024 10:35:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <20240122180212.67csjrnsbs7vq57i@airbuntu>
 <ece7ce3f-17f3-42a5-90d7-d0410235059d@arm.com>
 <20240124224321.vn4tuwj53wfk6iyk@airbuntu>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240124224321.vn4tuwj53wfk6iyk@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 22:43, Qais Yousef wrote:
> On 01/23/24 18:07, Dietmar Eggemann wrote:
>> On 22/01/2024 19:02, Qais Yousef wrote:
>>> On 01/22/24 09:59, Dietmar Eggemann wrote:
>>>> On 05/01/2024 23:20, Qais Yousef wrote:
>>>>> From: Qais Yousef <qais.yousef@arm.com>

[...]

>>>> What happen when we hotplug out all CPUs of one CPU capacity value?
>>>> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
>>>> (partition_sched_domains_locked()).
>>>
>>> Right. I missed that. We can add another intersection check against
>>> cpu_active_mask.
>>>
>>> I am assuming the skipping was done by design, not a bug that needs fixing?
>>> I see for suspend (cpuhp_tasks_frozen) the domains are rebuilt, but not for
>>> hotplug.
>>
>> IMHO, it's by design. We setup asym_cap_list only when new_topology is
>> set (update_topology_flags_workfn() from init_cpu_capacity_callback() or
>> topology_init_cpu_capacity_cppc()). I.e. when the (max) CPU capacity can
>> change.
>> In all the other !new_topology cases we check `has_asym |= sd->flags &
>> SD_ASYM_CPUCAPACITY` and set sched_asym_cpucapacity accordingly in
>> build_sched_domains(). Before we always reset sched_asym_cpucapacity in
>> detach_destroy_domains().
>> But now we would have to keep asym_cap_list in sync with the active CPUs
>> I guess.
> 
> Okay, so you suggest we need to update the code to keep it in sync. Let's see
> first if Vincent is satisfied with this list traversal or we need to go another
> way :-)

Yes, if preventing the 'increase of balance_interval' will cure this
issue as well, then this will be definitely the less invasive fix.

Can you not easily do a 'perf bench sched messaging -g X -l Y' test on
you M1 to get some numbers behind this additional list traversal in
pick_next_task_fair()?

> I think it is worth having this asym_capacity list available. It seemed several
> times we needed it and just a little work is required to make it available for
> potential future users. Even if we don't merge immediately.

I agree. It would give us this ordered (by max CPU capacity) list of
CPUs to iterate over.

[...]

