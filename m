Return-Path: <linux-kernel+bounces-139967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4908A09BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DE6282B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F813E026;
	Thu, 11 Apr 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7MuGdwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF013D258
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820490; cv=none; b=mDJ1cHl6HFDtiJyRQIOILIifrLlIax+BPGbIl5+0JyRRaX1S8DoUO8iy5gR0xOtmSNj55Uw1IardJD04ulsBUed+Ktr50zpEBlRhIDlpDBEvcDBijUtJtxzsQVUYY6mCcPvTKXJDxyUCtk3+Mo39VgdtZ9hI0xwfDIrJ6Cx3PPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820490; c=relaxed/simple;
	bh=nJ9e82oM4BnyJLrP/ege9wPr9McFFMBjRzqcj53itJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6OeYXmCoqwFBhSnL8b0vkkMRHPI5P+tIH6lHnci6hvHAE12smiek1aPPRd2yeExB7qECM3XXR8f4zXclDUtP+berXybuzIhDuU7oW/qqerLTqc7H02Fnag5G5n5mD5I6a5ecjDWJ90igAQHg+O8ugp1mf3dtGwjP1FpJ89KhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7MuGdwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ADAC433C7;
	Thu, 11 Apr 2024 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712820490;
	bh=nJ9e82oM4BnyJLrP/ege9wPr9McFFMBjRzqcj53itJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7MuGdwYhBo/xPrK3+whmdA+xFQAagWPAbLVnC10x3bPGGEWbGjpwzFixR5aFVCA/
	 IYUe1teVKkBaXxvYO9oicOC7QCslJq/FYQiuOCsnNOe8jDzhqt+YXOxK8Iu4B+4P9O
	 nF0VDd6WTEUk2B7MvsNI1RmUXeJZjd2W76dr3ms+qZS8Hmd+ZZ145GzS9ec2NXWVdz
	 rjnB/paQ3uTMIWN1F0QgMM5EXICITSicZY1IzpIpyAVeAfoQYFJWt5pG6Gz2AgTiKb
	 O8bd2sXBUsqgplwGIzdAxnxmi5l+h770PKRZBl56a2yECvMp/aZuDfnqLiK6OyrEZ0
	 LLnugoB+0g6pw==
Message-ID: <6db95fce-842e-4b99-bc6c-059fe655905f@kernel.org>
Date: Thu, 11 Apr 2024 09:28:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/6] sched/fair: Add trivial fair server
Content-Language: en-US, pt-BR, it-IT
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1712337227.git.bristot@kernel.org>
 <d1e02419599172f4045a4711b9ff78081f568bb8.1712337227.git.bristot@kernel.org>
 <20240410172423.GB30852@noisy.programming.kicks-ass.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240410172423.GB30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 19:24, Peter Zijlstra wrote:
> On Fri, Apr 05, 2024 at 07:28:00PM +0200, Daniel Bristot de Oliveira wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> Use deadline servers to service fair tasks.
>>
>> This patch adds a fair_server deadline entity which acts as a container
>> for fair entities and can be used to fix starvation when higher priority
>> (wrt fair) tasks are monopolizing CPU(s).
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  kernel/sched/core.c     | 24 ++++++++++++++++--------
>>  kernel/sched/deadline.c | 23 +++++++++++++++++++++++
>>  kernel/sched/fair.c     | 25 +++++++++++++++++++++++++
>>  kernel/sched/sched.h    |  4 ++++
>>  4 files changed, 68 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 7019a40457a6..04e2270487b7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6007,6 +6007,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>>  #endif
>>  
>>  	put_prev_task(rq, prev);
>> +
>> +	/*
>> +	 * We've updated @prev and no longer need the server link, clear it.
>> +	 * Must be done before ->pick_next_task() because that can (re)set
>> +	 * ->dl_server.
>> +	 */
>> +	if (prev->dl_server)
>> +		prev->dl_server = NULL;
>>  }
>>  
>>  /*
>> @@ -6037,6 +6045,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>  			p = pick_next_task_idle(rq);
>>  		}
>>  
>> +		/*
>> +		 * This is a normal CFS pick, but the previous could be a DL pick.
>> +		 * Clear it as previous is no longer picked.
>> +		 */
>> +		if (prev->dl_server)
>> +			prev->dl_server = NULL;
>> +
>>  		/*
>>  		 * This is the fast path; it cannot be a DL server pick;
>>  		 * therefore even if @p == @prev, ->dl_server must be NULL.
>> @@ -6050,14 +6065,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>  restart:
>>  	put_prev_task_balance(rq, prev, rf);
>>  
>> -	/*
>> -	 * We've updated @prev and no longer need the server link, clear it.
>> -	 * Must be done before ->pick_next_task() because that can (re)set
>> -	 * ->dl_server.
>> -	 */
>> -	if (prev->dl_server)
>> -		prev->dl_server = NULL;
>> -
>>  	for_each_class(class) {
>>  		p = class->pick_next_task(rq);
>>  		if (p)
> 
> This bit seems like a fix for 63ba8422f876 ("sched/deadline: Introduce
> deadline servers"), should it be a separate patch?

It was actually reported in a separated patch as a pre-review of this series. So I
think you can pick them as fixes already from there, and add the fixes tag?

https://lore.kernel.org/lkml/20240313012451.1693807-2-joel@joelfernandes.org/
https://lore.kernel.org/lkml/20240313012451.1693807-3-joel@joelfernandes.org/

Also add the Reviewed-by me...

-- Daniel

