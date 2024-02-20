Return-Path: <linux-kernel+bounces-72564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F485B549
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852D1287F52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7195D48B;
	Tue, 20 Feb 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="likzK4RU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A55CDF3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417923; cv=none; b=Kmfd7eEBqVr0hczsLFIknxh8t+e0mi2z02O7ElQYP6avpBy1TWmrdt1Qcmz6249ayBxbmXW7aCKttLmrmytKWy6TKP2mwKCQMS4E64uwdcFHDbCGDN1tFhclXyADVBHdkCltOSLf6ogurJzTNHj+Gt3jZAVHJZ/jiPDiwhTzvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417923; c=relaxed/simple;
	bh=b7CM9peUzLf3RI4hFbHqm2TZd4AMJDxnd+rVS6Fz1ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKGjGaiCAkuWtSuCdDHx5g3WQ+ZYEhaNr4XgPbaoidVxIVUPt+aFO265AWlNAs4Tel41GeZySJjEXNMEnDnJzhBaLvXYoyyoYtM7mr2jHsEIk+lfoXuovHSViIRE9XXT6HM3bnpkNTzWCjTEFTZdja09WOwjyC7XKjBvIO3Q/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=likzK4RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01751C433C7;
	Tue, 20 Feb 2024 08:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417923;
	bh=b7CM9peUzLf3RI4hFbHqm2TZd4AMJDxnd+rVS6Fz1ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=likzK4RUF7yq8G9RQ9lGuCZLdPTTO0BiDX12fr36kIYxdjIQ4ownAc1HkQZqnn3ct
	 6HU+9A+egZmj2zORm4bly+g9G0ka2W4jhD1cp1/EKkBcY9BaGVvEQPcD/VxjqeAljr
	 6jvExzkz7VS38g6/iwl0SO9WXkzFVWnAxbu1SBXjVXeblGQSyLHxCjxZ2b2TKabQDw
	 JmFwV1cD/FP4FXNlKr9Zr0DdDwhwsOMW6G5TmK03CEQ1hwhNy0362HDwYhi2ora1Pw
	 1A2xfvGa6t2/2xdG2i3n1SppihwNWAU5wSNV2uPXhakgXD+MwnNBjdox2tzgiYDWy6
	 yKh16wbeqRz+Q==
Message-ID: <b859f20b-5df7-403d-8078-06d747ec6b75@kernel.org>
Date: Tue, 20 Feb 2024 09:31:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Aaron Lu <aaron.lu@intel.com>, Kairui Song <kasong@tencent.com>,
 Guo Ziliang <guo.ziliang@zte.com.cn>
References: <cover.1699095159.git.bristot@kernel.org>
 <8734tosyb9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <23b87c48-c4b8-4b85-822a-33cffaf6f779@kernel.org>
 <878r3freza.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <878r3freza.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 04:28, Huang, Ying wrote:
> Daniel Bristot de Oliveira <bristot@kernel.org> writes:
> 
>> Hi
>>
>> On 2/19/24 08:33, Huang, Ying wrote:
>>> Hi, Daniel,
>>>
>>> Thanks a lot for your great patchset!
>>>
>>> We have a similar starvation issue in mm subsystem too.  Details are in
>>> the patch description of the below commit.  In short, task A is busy
>>> looping on some event, while task B will signal the event after some
>>> work.  If the priority of task A is higher than that of task B, task B
>>> may be starved.
>>
>> ok...
>>
>>>
>>> IIUC, if task A is RT task while task B is fair task, then your patchset
>>> will solve the issue.
>>
>> This patch set will not solve the issue. It will mitigate the effect of the
>> problem. Still the system will perform very poorly...
> 
> I don't think that it's common (or even reasonable) for real-time tasks
> to use swap.  So, IMHO, performance isn't very important here.  But, we
> need to avoid live-lock anyway.  I think that your patchset solves the
> live-lock issue.

I mean, if for you this is solving your user problem, be happy :-) Play with parameters...
find a way to tune your system as a user... use it :)

But your problem is also "solved" with RT throttling without RT_RUNTIME_SHARE (the
default since... two years ago, I think). So there is not much news here.

IMHO, it is not a solution. As a developer, there is a synchronization problem
in swap code, and pushing a workaround to the scheduling side is not the way to go...

> 
>>> If both task A and task B is RT tasks, is there
>>> some way to solve the issue?
>>
>> I would say reworking the swap algorithm, as it is not meant to be used when
>> real-time tasks are in place.
>>
>> As an exercise, let's say that we add a server per priority on FIFO, with a default
>> 50ms/1s runtime period. Your "real-time" workload would suffer a 950ms latency,
>> busy loop in vain.
> 
> If the target is only the live-lock avoidance, is it possible to run
> lower priority runnable tasks for a short while if we run long enough in
> the busy loop?

If you do it in the algorithm side (instead of relying on scheduling), it could be a
thing.

I think NAPI still uses something like this: Busy-loop for two jiffies in the softirq
context (a priority higher than all threads on the !rt kernel), then move to thread
the thread context to avoid starvation. In the swap case, it could run for two jiffies
and then go to sleep for a while. How well will swap people receive this as a solution...
I do not know :) I would first try something better than this using synchronization
primitives.

This patch set is for things outside of kernel control. For example, people running
poll mode DPDK in user-space with FIFO priority; FIFO tasks in user-space for too long...
with a better design than rt throttling.

Will this patch help in misbehaving kernel activities: yes. Is it a reason not to
fix kernel problems? I do not think so, and I bet many other people do not believe as
well.

-- Daniel

