Return-Path: <linux-kernel+bounces-65332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DE854B57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE6A1F24F93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344C55E44;
	Wed, 14 Feb 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLdWMLLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0C55C0B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920621; cv=none; b=ri5dZP238w+7N30kr+oT89lH/qBPq1SkOb9OowE8h+n0grDL1IOt69k7blI18XQ1fHalrLRddAfvswBuqHBTlW4X1aIbg+9a9hvYPx4bMrGX7TJXO5LWTefL0AogBXXAqmtqmp2Ik35aLJq0QydQMqMtZACBJTO/t/iuZnVWbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920621; c=relaxed/simple;
	bh=QUtqKoQM0XD8W0yp0rYh69IGkcbpWjeYiG8tLSkhjPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6apS2Hx0bPP908N9FLU8SJhOtqTY44/6dn5xnNCZyblrpXEIwskhh0SbvSvNQXizx44jh3RA9N81L4nU030wdhoHNUste1y9tmN+IS5BVSoPv6xYWxHfjt3VyowIkbTVFG3AuVB68rcyblpDr26a39Y79Lhhv1IH7xDUN/onCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLdWMLLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AB6C433C7;
	Wed, 14 Feb 2024 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707920621;
	bh=QUtqKoQM0XD8W0yp0rYh69IGkcbpWjeYiG8tLSkhjPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SLdWMLLh+fxJfGn8rbVS5zwCXNZZrqrY3tVJ9WeOApJEMr1OqcHLYlntMCv42pnQf
	 IwPC5n9eMZpiZm4VIjJcxaZ96shecDzSiBGPmTYFrGZJAjWDexTaNvWxC/TBc43IhK
	 IHc392VKdPuehVA/Rdc0QkLoqww9/V4SNdo5cvYgLV0ykn/7T3DxwFILyfzbBztb8g
	 NonMDuDHOu8Ed6rf8v76jHwsnaq2UTdEMl640rk7c+YkTdyzjIjoR0v6c21ncKne02
	 QeNky69MyOFL5ZxhirvsxNIl1cIF0ht3VLx4/PepJPwCX5OJoQT84u5lGiarWHx+ux
	 +Cvhxd7jEPBBw==
Message-ID: <091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org>
Date: Wed, 14 Feb 2024 15:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US, pt-BR, it-IT
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
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 03:13, Joel Fernandes wrote:
> 
> 
> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>
>>  - fair_server_runtime: set runtime in ns
>>  - fair_server_period: set period in ns
>>  - fair_server_defer: on/off for the defer mechanism
> 
> Btw Daniel, there is an interesting side-effect of this interface having runtime
> and period in 2 separate files :)
> 
> Say I want to set a CPU to 5ms / 10ms.
> 
> I cannot set either period or runtime to 5ms or 10ms directly.
> 
> I have to first set period to 100ms, then set runtime to 50ms, then set period
> to 50ms, then set runtime to 5ms, then finally set period to 10ms.

Hummm yeah I could reproduce that, it seems that it is not even a problem of having
two files, but a bug in the logic, I will have a look.

> The reason seems to be because otherwise runtime / period will not be
> accomodated and will cause dl_overflow issues.
> 
> I'd suggest providing both runtime and period in the same interface to make it
> more easier to use. However, for the testing I am going with what we have.
> 
> Also a request:
> 
> I was wondering if a new version of the last 3 patches could be posted to
> LKML or shared in a tree somewhere. I am trying to sync to mainline and
> rebase our latest fixes on top of that, however it is difficult to do because
> these 3 patches are in bit of a flux (example the discussion between you and
> Peter about update_curr()). What's the best way to move forward with rebasing
> our fix contributions?

Juri and I chat about, and we think it is a good thing to re-send this patch set,
including a fix I have to it (to avoid regression wrt rt throttling), explaining
these things in the mailing list so peter will be able to follow the discussion.

I still need to finish testing, and to make a proper cover page with all updates, the
latest thing is here (tm):

https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/log/?h=dl_server_v6

It is based on peter's sched/more. I will probably re-send it today or tomorrow,
but at least you can have a look at it.

Another reason to send it is to get the regression test machinery running....

 I am going with the sched/more in Peter's queue.git
> unless you/Peter prefer something else. And I added your update_curr()
> suggestion onto that, let me know if you disagree with it:
> 
> @@ -1173,6 +1171,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
> 
>         if (entity_is_task(curr))
>                 update_curr_task(task_of(curr), delta_exec);
> +       else
> +               dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);
> 
>         account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }

That part of the code was optimized by peter during the last round of discussions.

It is like this now:

------------ %< -----------
-       if (entity_is_task(curr))
-               update_curr_task(task_of(curr), delta_exec);
+       if (entity_is_task(curr)) {
+               struct task_struct *p = task_of(curr);
+               update_curr_task(p, delta_exec);
+               /*
+                * Any fair task that runs outside of fair_server should
+                * account against fair_server such that it can account for
+                * this time and possibly avoid running this period.
+                */
+               if (p->dl_server != &rq->fair_server)
+                       dl_server_update(&rq->fair_server, delta_exec);
+       }
------------ >% -----------

It is not straightforward to understand... but the ideia is:

if it is a task, and the server is ! of the fair server, discount time
directly from the fair server. This also means that if dl_server is NULL
(the server is not enabled) it will discount time from the fair server.

-- Daniel


> thanks,
> 
>  - Joel


