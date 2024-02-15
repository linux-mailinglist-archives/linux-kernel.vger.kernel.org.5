Return-Path: <linux-kernel+bounces-67406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A174B856AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B2C1F2364C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB32136999;
	Thu, 15 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGGUEZm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843DA1339B2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018028; cv=none; b=Ywn96O0gWyHCLkyA4itgv3SpdwDiN8LkI1g9PJ0yNSQV/sR0Ves4hQ3lI/GNkFBMkW2xxyQwme0j5QdNzxjRKq9Msxt9wgzOE1Z2Sru2kVa+h48hOPayqD1X3uY2J5QzndaFH0gUdhSFeOWCspzciJzO/2bPSePRTY+PNGVqA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018028; c=relaxed/simple;
	bh=EMy9vHXPRVYRkvfEc2t9TGg9kcp00MbjTREDclJqF4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2Qq0QmjQ0TqvXsVjVXZDTyxnUSkMC5bry20x5nYD89CX+s7hKe16xQxtOOkyYO80pUq1QIsZ7CrConRsvKL2wkfD+RKcM6nMv2VRFGwcrnK1TSRNyBu0LmEyaKe1XXTJ9GgXA2CoI+TyXsdStW8V6UeolR4g+qrnmzp0Z4Fom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGGUEZm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075DFC433C7;
	Thu, 15 Feb 2024 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708018028;
	bh=EMy9vHXPRVYRkvfEc2t9TGg9kcp00MbjTREDclJqF4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JGGUEZm7GYfmxmptLWCmSibS1aKQFSscR52HVIlzRe8K54tczrWfO/0C4yf+5kQfX
	 bnATmIkyZcMUaGDvNc4+1NsNJ4vaN8APIRgLJVXg3U6ZbJGBqv8p+nl8kHfSLtYjeS
	 6JKqtIuRf5AP87pybZoskcLHcyKMF0cIKQi8R1TWqXTWcok1GcfMMZOs5GUNoQitK8
	 oEWUmLYtE1F/0rbEO7PiB/QuPOoaIlVfUp1xY5iSu6IHRJUqtlF98l0S/wDtMo7gI8
	 pol7JQvzgCHx6E+Wd2sNwLMbILpnjukQxdydzuKuY4hBn8Sfa4WowKxhbBFj6INnaW
	 f9hoYPJSMTu7Q==
Message-ID: <07b1844a-a9d4-47fb-aea0-c0722b2a8001@kernel.org>
Date: Thu, 15 Feb 2024 18:27:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
To: Joel Fernandes <joel@joelfernandes.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, youssefesmat@google.com
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
 <091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org>
 <a4af4bac-92bd-44e9-93d2-dc22dc9a81ad@joelfernandes.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <a4af4bac-92bd-44e9-93d2-dc22dc9a81ad@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/24 14:57, Joel Fernandes wrote:
> Hello, Daniel,
> 
> On 2/14/2024 9:23 AM, Daniel Bristot de Oliveira wrote:
>> On 2/13/24 03:13, Joel Fernandes wrote:
>>>
>>>
>>> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>>>> Add an interface for fair server setup on debugfs.
>>>>
>>>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>>>
>>>>  - fair_server_runtime: set runtime in ns
>>>>  - fair_server_period: set period in ns
>>>>  - fair_server_defer: on/off for the defer mechanism
>>>
>>> Btw Daniel, there is an interesting side-effect of this interface having runtime
>>> and period in 2 separate files :)
>>>
>>> Say I want to set a CPU to 5ms / 10ms.
>>>
>>> I cannot set either period or runtime to 5ms or 10ms directly.
>>>
>>> I have to first set period to 100ms, then set runtime to 50ms, then set period
>>> to 50ms, then set runtime to 5ms, then finally set period to 10ms.
>>
>> Hummm yeah I could reproduce that, it seems that it is not even a problem of having
>> two files, but a bug in the logic, I will have a look.
> 
> Thanks for taking a look. My colleague Suleiman hit the issue too. He's able to
> not set 45ms/50ms for instance.

I isolated the problem. It is not an interface problem.

Long story short, the servers are initialized at the defrootdomain, but
the dl_bw info is not being carried over to the new domain because the
servers are not a task.

I am discussing this with Valentin (topology) & Juri. We will try to find a
solution, or at least an presentable XXX: solution... in the next days.

You can work around it by disabling the admission control via:

# sysctl kernel.sched_rt_runtime_us=-1

the the values will be accepted. For the best of my knowledge, you guys are
only using SCHED_RR/FIFO so the admission control for DL is not an issue.

>> I still need to finish testing, and to make a proper cover page with all updates, the
>> latest thing is here (tm):
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/log/?h=dl_server_v6
>>
>> It is based on peter's sched/more. I will probably re-send it today or tomorrow,
>> but at least you can have a look at it.
>>> Another reason to send it is to get the regression test machinery running....
> 
> Sure, looking forward to it. I rebased on above tree and it applied cleanly.
> What I'll do is I will send our patches today (not those in sched/more) after a
> bit more testing and tweaks.
> 
> There are 2 reasons for this:
> 1. Can get the build robot do its thing.
> 2. Our internal system checks whether patches backported were posted upstream to
> list.
> 
> Hope that sounds good to you and we can start reviewing as well.

If it helps downstream for you guys, it is not a problem for me. Still, peter is
the person that has more comments to give so...

-- Daniel

