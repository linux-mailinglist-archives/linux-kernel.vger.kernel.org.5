Return-Path: <linux-kernel+bounces-110323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91086885D31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E9B1C215E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0112C531;
	Thu, 21 Mar 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aQDxRae6"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE4A934
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037768; cv=none; b=T5phRJ8shGV6dllBveOuMLMK6CkAiAxYGiyEixHkKeOVlUjdRkKjXbTYz1eQFCCe0HyPlobVv+Q914NcVrCuIgy/A8lRT6Yok52QcychbRKaVGXBVikeXk5cdE3X4Fk4QDjU7MjzvPdfcxhba5ucB7/FwMiuzojxws3EWF3hdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037768; c=relaxed/simple;
	bh=gzKWe0fDwVy3DvStX+pjLheYABTasvlCpOK72ep0LVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjYE62fklcdl3ix7DeEo3hU2Ysu7sp1rJ9bikev6dv7xQJxOBhtWCKt75lZwYFBbbSBcmXOPjK9bqWQFkHMrqlcsCscRXU+21zVrEd4IBFX/m1dJgDpcmKWhXrGISZpFPKc8Iyws85NsaTjyhCOsoLJmNMula3syXex3Jrm5wCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=aQDxRae6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789f00aba19so85416285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711037764; x=1711642564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woRy/QzbG+dMWdN8Z726Chns32cJkL3RG44ODCTJqvM=;
        b=aQDxRae6MO/jg3KT/Hx2ZlXBxyHCXNffMSSXDESLFc+mX73Xvl2gaIP1yq8EjVmnfd
         wFrTw6Yo9WGIU4NaomPrc08ORk7TyUJDmJZzqRen4VkC4hsA5fUiKQneu3sqrpwpzbYv
         TKLNLfKZqWsFziYjsnUMwpS9qmwr4kcxldym0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037764; x=1711642564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woRy/QzbG+dMWdN8Z726Chns32cJkL3RG44ODCTJqvM=;
        b=TvUhskgfgH8mjjXOtUfvUZeQWvy+dbntb+jg43pDkhWSVd8Alwzuhor1EReP7FtFNT
         u+3aFNDChNeO37vhZX5vQEmjiM0NyE+3o/ScAdm1fHu5HR2h9krUjkRhq3/RwoEOReZm
         ZDlQpQLaGNHLoc3cxUSiQdroedIrx6NSxjmytJAM1UuV69Zdj3+EXx4YOQ/uscbWRHy+
         TM3MvJRqqq+xgGDg9MnoLkydQzXlQplUrsSCrZ/dBC6kGeM2swXvrw/3aIzrgu9NGYpV
         GWrkknXeHZ/A8tN82pejbSWWBkwYiKr/HRN6AyORLVZniIlD0vm7WNHSe2JPdAzQDhga
         +E0w==
X-Forwarded-Encrypted: i=1; AJvYcCXEujGXfc6zm3vpClKfeG9paALIlhOEXuVxyork61hiTqPnasG30jvj11Xf9oLZr5yMrCcdFjnICgLsRpBeW7wm8GdD1Qmj58BL0Nwq
X-Gm-Message-State: AOJu0YzmPqXj4iN7LvJlq61DowVus9rPM5A5zFXmcBihj3Aw5GeU7hAM
	IBnvZhuofP9V1yt6Z9iDuuhSTl6l87huPpYCsnIVJmniKy4E2HpaaD8JeRuzo2Y=
X-Google-Smtp-Source: AGHT+IHsaJ5QxWR4K0rXMIiudN1td8qDwW+uFHfiYTsVLDo6RqisxbVucN0am0QY8UolKMawizB3qg==
X-Received: by 2002:a05:620a:9d5:b0:78a:2d1d:7611 with SMTP id y21-20020a05620a09d500b0078a2d1d7611mr2218994qky.52.1711037763797;
        Thu, 21 Mar 2024 09:16:03 -0700 (PDT)
Received: from [10.5.0.2] ([185.195.59.198])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a000f00b00789e94cf424sm11943qki.108.2024.03.21.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 09:16:02 -0700 (PDT)
Message-ID: <bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
Date: Thu, 21 Mar 2024 12:15:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
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
 David Vernet <void@manifault.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
 <d7d8540e-c417-41fa-aea9-acb80541a30d@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <d7d8540e-c417-41fa-aea9-acb80541a30d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Daniel,
Thank you for the reply and I replied below.

On 3/20/2024 3:24 PM, Daniel Bristot de Oliveira wrote:
> On 3/20/24 01:03, Joel Fernandes wrote:
>>
>>
>> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>>> Among the motivations for the DL servers is the real-time throttling
>>> mechanism. This mechanism works by throttling the rt_rq after
>>> running for a long period without leaving space for fair tasks.
>>>
>>> The base dl server avoids this problem by boosting fair tasks instead
>>> of throttling the rt_rq. The point is that it boosts without waiting
>>> for potential starvation, causing some non-intuitive cases.
>>>
>>> For example, an IRQ dispatches two tasks on an idle system, a fair
>>> and an RT. The DL server will be activated, running the fair task
>>> before the RT one. This problem can be avoided by deferring the
>>> dl server activation.
>>>
>>> By setting the zerolax option, the dl_server will dispatch an
>>> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>>>
>>> The dl_timer will be set for (period - runtime) ns from start time.
>>> Thus boosting the fair rq on its 0-laxity time with respect to 

Note your patch changelog. --- (1)

>>> rt_rq.
>>>
>>> If the fair scheduler has the opportunity to run while waiting
>>> for zerolax time, the dl server runtime will be consumed. If
>>> the runtime is completely consumed before the zerolax time, the

Note your patch changelog. --- (2)

>>> server will be replenished while still in a throttled state. Then,
>>> the dl_timer will be reset to the new zerolax time
>>>
>>> If the fair server reaches the zerolax time without consuming
>>> its runtime, the server will be boosted, following CBS rules
>>> (thus without breaking SCHED_DEADLINE).
> 
> notice: at this point in history, the term zero-laxity was removed from
> the latest code we have, the term was moved to defer server... I will
> remove from the long in the next time I send it.

I am confused because your change log in your v5 (and the v6 in kernel.org)
mentions "zero-laxity" all over the place (example see above for (1) and (2)).
Further, the terminology is the least of the problems unfortunately (more
below). Call it defer or whatever but it has to work. :)

>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>>
>> Hi, Daniel,
>> We have one additional patch (other than the 15 I just sent).
> 
> Those 15 are the next thing I will review... I was working in the merge window.

Me too ;-) It has been a fun merge window.

> Since I have just
>> 3 more working days for the next 3 weeks, I thought I might as well reply inline
>> here since it might be unnecessary to resend all 15 patches so soon just for the
>> one new addition below. I am replying to this patch here, because the new patch
>> is related (to 0-laxity).  But once I am back from holiday, I can resend it with
>> the set I have unless you've applied it.
> 
> before starting... in three weeks, we will be very far still from any attempt to
> ping Peter & ingo to ask if they could think about putting us into a queue.

I wasn't really expecting an imminent "ping for merge" to be honest. My main
motivation with posting it before my 3 week off time was to trigger some review
and discussion here (which we desperately need more off IMO ;)). I am not in a
hurry to request for a merge without it working correctly either.

> Have fun :-)

Thanks!

> as I explained at LPC.. and in chat... there is no "0-laxity", and repeating it
> only creates more confusion.

We can stick to defer but could you please update your changelog as well. I
don't think you posted an update to the patch since November either so maybe you
should do that as well, with the patches adjusted with the bugs we found. I do
agree that using zero-laxity creates a source of confusion and prefer "defer".

> Let's use a deferred server... a regular deadline
> reservation with deferred starting time at (now + period - runtime), and at that point
> il will receive a new deadline one period away - (not one runtime away).
> 
> There will always be a person reading these emails and echoing the wrong things...
> using 0-lax/0-laxity term here is a lose-lose.

Agreed, so why not update your patch changelog to correct that (or post a new
revision)?

>> So, Vineeth and me came up with a patch below to "max cap" the DL server 0-lax
>> time (max cap is default off keeping the regular behavior). This is needed to
>> guarantee bandwidth for periodic CFS runners/sleepers.
> 
> Another point... "guarantee bandwidth"... the bandwith is provided under certain conditions.
> If the conditions are not respected, the guarantee a dl reservation will provide is that
> the task will not put a utilization higher than the one requested, so yes, a dl reservation
> can and will enforce a lower utilization if the task does not respect the conditions.
> Also, if the reservation is ready, but no task is ready...

Please clarify what conditions you mean? The conditions I am looking for are
those given by RT throttling (see below). i.e., if RT takes up all of the CPU in
a certain amount of time, then there is a certain amount reserved for CFS.

>> The example usecase is:
>>
>> Consider DL server params 25ms / 50ms.
>>
>> Consider CFS task with duty cycle of 25ms / 76ms (run 25ms sleep 51ms).
> 
> define duty... like, runtime 25, period 76? sleeps for 51 relative to a starting time
> or not?

There is no starting time. The CFS task in the quoted example only does run +
sleep. Run for 25ms and sleep for 51ms, then run again for 25ms, etc.

> 
> there are some holes in your explanation, it is tricky to reply inline for these cases...
> I am continuing but....
> 
>>
>>          run 25ms                    run 25ms
>>          _______                     _______
>>         |       | sleep 51          |       |  sleep 51
>> -|------|-------|---------|---------|-------|----------|--------|------> t
>>  0     25      50       101        126      151       202      227
>>                           \ 0-lax /                    \ 0-lax /

So before going into the discussion below, I just want to mention that if the
DL-server cannot provide the same bandwidth that the RT throttling provided,
then its broken by definition.  And the breakage comes specifically because of
this patch and nothing else. There are many breakages with this patch and I will
go over some of them with unit tests below. Basically, in my view -- if a test
case shows it works with RT throttling, but not with the DL-server, then its
broken. Period. And most of those functional "breakages" come about because of
this patch (6/7) and not the initial series actually.

Here are some cases to shed some light:

Case 1. Consider a CFS task with runtime 15ms and period 50ms. With the
parameters set to 25ms runtime and 50ms period.

The test fails with DL server (because of 6/7), and passes with RT throttling.
See results below. For this test's code, see: https://shorturl.at/rwW07

Specifically, it breaks because of this patch (6/7). If you revert the patch,
the issue goes away.

With the patch 6/7:
# ./dlserver_test
# Runtime of PID 85 is 0.430000 seconds
Bail out! Runtime of PID 85 is not within 10% of expected runtime 0.900000

Without the patch 6/7:
# ./dlserver_test
# Runtime of PID 87 is 0.900000 seconds
ok 1 PASS

So basically, because of defer (or whatever you want to call it ;)), it gives
less than 50% of the bandwidth that it gave without the defer.

And here it is with vanilla RT throttling:
# ./dlserver_test
[   44.968900] sched: RT throttling activated
# Runtime of PID 87 is 0.880000 seconds

Vineeth's patch I shared fixes the issue.

Case 2:
For this case, please run the core scheduling test I provided with
CONFIG_SCHED_CORE=y. It is basically like Case 1 but with some slightly changes.

You will see that because of patch 6/7, that test also breaks and gets lesser
bandwidth. And it happens of the negative runtime stuff you added to
update_curr_dl_se(). Deleting that fixes this, but is indication of yet another
problem with this patch.

The patch fixing this issue (by deleting that block) is also included in the set
of 15 I posted earlier.
-------

Further, my impression is this patch (6/7) does not even solve all the issue it
intended. For example, consider that a CFS task is in the boosted phase, and now
an RT task wakes up. That RT task *will wait* for possibly the whole runtime
granted to CFS, so it might not always help. Contrasting that with RT
throttling, if an RT task is very well behaved (well behaved defined as not
running to the limit that RT throttling should kick in), and it wakes up, it
will run right away without any wait time, regardless of what CFS was or was not
doing.

thanks,

 - Joel

