Return-Path: <linux-kernel+bounces-67034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DA85651C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571391C2202C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F427131E3E;
	Thu, 15 Feb 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VlzMJtt8"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44513175C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005440; cv=none; b=mhlKtLivZRsioR4yMXpZOGx1RVhi1g2cpDO+AW8Kb40WTLIWHDEFB43v4yeBYL/CyvEXly/sAXRp05QC97agc7+t5kqSOytfdAimTKwDNbQOcqcmogVFDx6wSzq1I+fyll9VNwbyXEHxO3BdJOIKKaGWSyJJEgSHwQar6digntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005440; c=relaxed/simple;
	bh=cBtmqHRHLfJ55d7DD1hlgS82aPApGnLYkIhy9UF1NQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdokfwKyxd1MJNtV8GVqYNbIUqZylQ13g22V6I8EBN/cLROnUVRAiPil6USyswhRyBiLENLA2LAT0aZyKGpL6Xz0CteW+13ebeQcM1aEtlXxPtfhjWEqp4O5ZIGhuWlAllC6GMSueN2TlhshtaZgu9Wf4aLHjyS52edaZVFufuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=VlzMJtt8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607e41efcf1so2779837b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708005437; x=1708610237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf5WqbNzEbfrcfj8g1I4nTfQzbJLBIAfJQonRhJ/M7o=;
        b=VlzMJtt8MRzHs6LlvPiN6AvcjqbqX7CwH5rs3G1NfsRGDy3AWLtJwEzzIS3eXIV7sx
         amMzw/khJgYtE06dM6MiQYnsLYwj1PKxNwphDM+TKoyHq2a3amKdSJ7jMcRNXO42yfD9
         PfPGH31YODPnJQ1KAgDd8RwlbPrn0764bo4Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005437; x=1708610237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf5WqbNzEbfrcfj8g1I4nTfQzbJLBIAfJQonRhJ/M7o=;
        b=d3gPnMzGU2X0cwPqEHjWtO3Kt0BDLZ68mxygHlx4SwLY18olUhpJXmQLdQESVDFvse
         4m8ejF64BvYImmqpKMWLV0yjqt/fzt8FU+cFGj1c/aNmEGEQwp0n/UYi59YTV7uRRJTe
         ib9HVnvhC7uHGelbiGiqPrzK3zhXYQCklnxk1j3kVj0A6rn9KsvcGUZUrmR/ak2npSjN
         U9uY9uwPYbwkX/E+FK6mXVnjdAjKeHcPdseXOkIfNMV7DsHqSYjgHxCc29QfhR+2VFwl
         zlhEJp1iJyihgZi4PgmZvDApAGOZkXo6eXc8woWwr1kXmRBoH42RVznfDlauAiAqDjt9
         I37Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBxAjkErI5skJskJqon8LPurbJi1j6iTrf4k+T8nosLzv5OmmWDpibI5hOHJ8LxLwf4+88srYBKquoDtSGRoN/RWWJvzG079ax7E0J
X-Gm-Message-State: AOJu0YxpLTgKvfH9NqH4IG8fWas23NgykI4+H9cUMd9T6mKBeHFra7vZ
	OuAzs3MLgbAl0qLZ1DMX/BElikGaTgugDOXHztkiW5W4vDBbZZS+NMkOWp0iEJk=
X-Google-Smtp-Source: AGHT+IHLgnz1jx/7YsrS7Im+igUwKgPzl+HXYNbNglK+XA03l837AkX4QDumI/yZZATbMJfsaGJhcA==
X-Received: by 2002:a81:4c07:0:b0:607:9f5b:6a53 with SMTP id z7-20020a814c07000000b006079f5b6a53mr1545334ywa.6.1708005437217;
        Thu, 15 Feb 2024 05:57:17 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a248400b0078722793b6csm611134qkn.48.2024.02.15.05.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:57:16 -0800 (PST)
Message-ID: <a4af4bac-92bd-44e9-93d2-dc22dc9a81ad@joelfernandes.org>
Date: Thu, 15 Feb 2024 08:57:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
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
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Daniel,

On 2/14/2024 9:23 AM, Daniel Bristot de Oliveira wrote:
> On 2/13/24 03:13, Joel Fernandes wrote:
>>
>>
>> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>>> Add an interface for fair server setup on debugfs.
>>>
>>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>>
>>>  - fair_server_runtime: set runtime in ns
>>>  - fair_server_period: set period in ns
>>>  - fair_server_defer: on/off for the defer mechanism
>>
>> Btw Daniel, there is an interesting side-effect of this interface having runtime
>> and period in 2 separate files :)
>>
>> Say I want to set a CPU to 5ms / 10ms.
>>
>> I cannot set either period or runtime to 5ms or 10ms directly.
>>
>> I have to first set period to 100ms, then set runtime to 50ms, then set period
>> to 50ms, then set runtime to 5ms, then finally set period to 10ms.
> 
> Hummm yeah I could reproduce that, it seems that it is not even a problem of having
> two files, but a bug in the logic, I will have a look.

Thanks for taking a look. My colleague Suleiman hit the issue too. He's able to
not set 45ms/50ms for instance.

Also just want to mention, if you could please CC my colleagues Suleiman and
Youssef on the patches who are also working on / reviewing these:

Suleiman Souhlal <suleiman@google.com>
Youssef Esmat <youssefesmat@google.com>

>> The reason seems to be because otherwise runtime / period will not be
>> accomodated and will cause dl_overflow issues.
>>
>> I'd suggest providing both runtime and period in the same interface to make it
>> more easier to use. However, for the testing I am going with what we have.
>>
>> Also a request:
>>
>> I was wondering if a new version of the last 3 patches could be posted to
>> LKML or shared in a tree somewhere. I am trying to sync to mainline and
>> rebase our latest fixes on top of that, however it is difficult to do because
>> these 3 patches are in bit of a flux (example the discussion between you and
>> Peter about update_curr()). What's the best way to move forward with rebasing
>> our fix contributions?
> 
> Juri and I chat about, and we think it is a good thing to re-send this patch set,
> including a fix I have to it (to avoid regression wrt rt throttling), explaining
> these things in the mailing list so peter will be able to follow the discussion.
> 
> I still need to finish testing, and to make a proper cover page with all updates, the
> latest thing is here (tm):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/log/?h=dl_server_v6
> 
> It is based on peter's sched/more. I will probably re-send it today or tomorrow,
> but at least you can have a look at it.
>> Another reason to send it is to get the regression test machinery running....

Sure, looking forward to it. I rebased on above tree and it applied cleanly.
What I'll do is I will send our patches today (not those in sched/more) after a
bit more testing and tweaks.

There are 2 reasons for this:
1. Can get the build robot do its thing.
2. Our internal system checks whether patches backported were posted upstream to
list.

Hope that sounds good to you and we can start reviewing as well.

>  I am going with the sched/more in Peter's queue.git
>> unless you/Peter prefer something else. And I added your update_curr()
>> suggestion onto that, let me know if you disagree with it:
>>
>> @@ -1173,6 +1171,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>
>>         if (entity_is_task(curr))
>>                 update_curr_task(task_of(curr), delta_exec);
>> +       else
>> +               dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);
>>
>>         account_cfs_rq_runtime(cfs_rq, delta_exec);
>>  }
> 
> That part of the code was optimized by peter during the last round of discussions.
> 
> It is like this now:
> 
> ------------ %< -----------
> -       if (entity_is_task(curr))
> -               update_curr_task(task_of(curr), delta_exec);
> +       if (entity_is_task(curr)) {
> +               struct task_struct *p = task_of(curr);
> +               update_curr_task(p, delta_exec);
> +               /*
> +                * Any fair task that runs outside of fair_server should
> +                * account against fair_server such that it can account for
> +                * this time and possibly avoid running this period.
> +                */
> +               if (p->dl_server != &rq->fair_server)
> +                       dl_server_update(&rq->fair_server, delta_exec);
> +       }
> ------------ >% -----------
> 
> It is not straightforward to understand... but the ideia is:
> 
> if it is a task, and the server is ! of the fair server, discount time
> directly from the fair server. This also means that if dl_server is NULL
> (the server is not enabled) it will discount time from the fair server.

Yes, that makes sense. We certainly want to debit from the server even when DL
is not picking the task indirectly. I guess Peter's optimization also handles
the case where multiple servers are in play. That will help us when/if we make
RT as a server as well, right?

thanks,

 - Joel


