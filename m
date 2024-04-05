Return-Path: <linux-kernel+bounces-133169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FF899FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614CFB2141D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8216F27E;
	Fri,  5 Apr 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+huNApY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505F16C85B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327758; cv=none; b=i5JMxQgf/2Cdmd3EkCbOCH9G+CE2F6Z/k+IbYR13dQ/jbF81M8ccxMzdc07J9emwfCWqjOGv3nFoOPd9g49qJIHovlvlf5olOwWGIhdx47/KfwbcH6vlXtQ/SXHt+JeEtpMljmSttvjicfsCICNk4yOtFhjEw3J3yrKKfAdfCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327758; c=relaxed/simple;
	bh=/Q6/Db3ZiTTuakq2h3fU0MPS7/hvz1fWZrCOtEBhxts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv2h4wYFhRuzpqnu2R5b8qgi9mG1uwXkbcoVZ+4Pv6X9hpk8FAZFteEnxzhZ+ud30XGnpCVlqxTXjoe9qBBzUCPnyg7NeGUZU4hLj0hQ1QQyOONgO3OuXPdiDRYEdp3UB3IlLP+p5h0+nEOEm1qBgvHKfhXGw0CW/gEeESQC9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+huNApY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712327755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TcNgQvg4OdCvuf7bqaBP0tV40sfjrpulm0TeJndVxI=;
	b=V+huNApYYVvrEEywi4BNP762QJ9E0yOT2rjsFn7HM4BtMu5u9vWKtPmZkCiGbpotDxHP6T
	chaORG5VKZBKRJ5WRbEIRC3RB2TQQSUw6xSwB/AGIXWhfM8K0HrlwCFBBgvVoF7TaBYZOs
	tjjGqD/9WP7mzD/5y+FxfKLPN4tciFo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-VX5mfxgAM56dtTpPeI1z1A-1; Fri, 05 Apr 2024 10:35:54 -0400
X-MC-Unique: VX5mfxgAM56dtTpPeI1z1A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51a6691238so52234966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327752; x=1712932552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TcNgQvg4OdCvuf7bqaBP0tV40sfjrpulm0TeJndVxI=;
        b=lHNdBZkHCSJoFG1kZujEL2VFJ9UAL2OfGQtRqKeuAFbLAZMCFoe3K71vx+S9JONHai
         csI7YOfH8h98nXvD2XwYw8yYQBO++ts1za3yd9bFyxpB45oyXoCd2RbjJ93BiFanbuUk
         RO+DVXg7qAP2inHRi0E5OjSr8Pe0ntNjtNigRgZlFmeX64qGuLPpPkEmWiG0l9LxXQBn
         KTpP2PN13MQ30/5Df8gy6XRGvVP5u+AusjDce4jYGgkIlV8jU9Oe/DN5FNCT2Ypqebu1
         /EZeydqXaCxNnXMttZJIAhA36rbHsz5okQl7RccwcerD+LC+fObVyCrY1TRYED/WAMvR
         oIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVqmE2nRpTrOwiDmb+hJUi7Y/6qC5fNiTgVRR4IZ5eJmylo/bnt02O34bmLcrD6wdntpKumovCHWV/JflGoxugdLbryJ/EFpouIteUJ
X-Gm-Message-State: AOJu0YzYKMRlrVQctJfgCtuwqnqe/cjPBj3aoOvROugkX+MLHknwBT5n
	8Gk6XbO7FSKbzG3/zswHDZAXgr6GKdMDVNTGB/ZUZ1v6XQ9LUPAkoRCgI5CMtuK1ktC1gcObicC
	dulblKOVv6lFU/6MJgbjV6a+F8Axgyf9LzseF28hO6iaVDfHebL4WDhB0IxmEDgKwHhvbPnj1
X-Received: by 2002:a17:906:e20d:b0:a47:527a:dad0 with SMTP id gf13-20020a170906e20d00b00a47527adad0mr1156885ejb.56.1712327752139;
        Fri, 05 Apr 2024 07:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9WPmRqfNejdXevZ9XmoKgst6E8PHJfmXUScux7HhZkO2DbiQy+VDtLkME0haK5ReiQUSIDQ==
X-Received: by 2002:a17:906:e20d:b0:a47:527a:dad0 with SMTP id gf13-20020a170906e20d00b00a47527adad0mr1156869ejb.56.1712327751721;
        Fri, 05 Apr 2024 07:35:51 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709067cd600b00a4739efd7cesm899902ejp.60.2024.04.05.07.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:35:51 -0700 (PDT)
Message-ID: <b5e0dbb8-3aab-4316-85bb-6b7ac3134e07@redhat.com>
Date: Fri, 5 Apr 2024 16:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To: Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
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
 <bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>> There will always be a person reading these emails and echoing the wrong things...
>> using 0-lax/0-laxity term here is a lose-lose.
> 
> Agreed, so why not update your patch changelog to correct that (or post a new
> revision)?

That v6 is the repo was a partial update, that I sent there to sync our work. The v6 that I will
send already removed that.

>>> So, Vineeth and me came up with a patch below to "max cap" the DL server 0-lax
>>> time (max cap is default off keeping the regular behavior). This is needed to
>>> guarantee bandwidth for periodic CFS runners/sleepers.
>>
>> Another point... "guarantee bandwidth"... the bandwith is provided under certain conditions.
>> If the conditions are not respected, the guarantee a dl reservation will provide is that
>> the task will not put a utilization higher than the one requested, so yes, a dl reservation
>> can and will enforce a lower utilization if the task does not respect the conditions.
>> Also, if the reservation is ready, but no task is ready...
> 
> Please clarify what conditions you mean? The conditions I am looking for are
> those given by RT throttling (see below). i.e., if RT takes up all of the CPU in
> a certain amount of time, then there is a certain amount reserved for CFS.
> 
>>> The example usecase is:
>>>
>>> Consider DL server params 25ms / 50ms.
>>>
>>> Consider CFS task with duty cycle of 25ms / 76ms (run 25ms sleep 51ms).
>>
>> define duty... like, runtime 25, period 76? sleeps for 51 relative to a starting time
>> or not?
> 
> There is no starting time. The CFS task in the quoted example only does run +
> sleep. Run for 25ms and sleep for 51ms, then run again for 25ms, etc.
> 
>>
>> there are some holes in your explanation, it is tricky to reply inline for these cases...
>> I am continuing but....
>>
>>>
>>>          run 25ms                    run 25ms
>>>          _______                     _______
>>>         |       | sleep 51          |       |  sleep 51
>>> -|------|-------|---------|---------|-------|----------|--------|------> t
>>>  0     25      50       101        126      151       202      227
>>>                           \ 0-lax /                    \ 0-lax /
> 
> So before going into the discussion below, I just want to mention that if the
> DL-server cannot provide the same bandwidth that the RT throttling provided,
> then its broken by definition.  And the breakage comes specifically because of
> this patch and nothing else. There are many breakages with this patch and I will
> go over some of them with unit tests below. Basically, in my view -- if a test
> case shows it works with RT throttling, but not with the DL-server, then its
> broken. Period. And most of those functional "breakages" come about because of
> this patch (6/7) and not the initial series actually.
> 
> Here are some cases to shed some light:
> 
> Case 1. Consider a CFS task with runtime 15ms and period 50ms. With the
> parameters set to 25ms runtime and 50ms period.
> 
> The test fails with DL server (because of 6/7), and passes with RT throttling.
> See results below. For this test's code, see: https://shorturl.at/rwW07

A reproducer always helps. So, your task there is not a periodic task... it is
a sporadic task because it sleeps for a fixed amount of time after the runtime.

A periodic task with period 76 would wake at 0, 76, 152 - like cyclictest...
so consuming at a fixed time rate if the scheduler allows it.

In the case of a fixed sleep time at the end of the execution, it will end up
"throwing away bandwidth" if the runtime is not given at the beginning of the
period because it will run slower... accumulating error. But that was not the
main point here...

The problem here was more like: if a fair task goes to sleep in the middle of
the server activation (for a lock?), and then wakes up again, the code in v5 is
forcing it to defer... again. Thus, it is getting less bandwidth... notice that
it does not even need to be at the start of the period. It is the middle of the
execution.

Intuitively, reducing the deferred time would help there. But the best thing to do is:

If the fair task waited for the defer, and the real-time tasks are still using all
CPU time, do not defer the activation again, and keep the defer mechanism disabled
until the real-time tasks allow the fair scheduler to run in the background. So,
making the defer mode equivalent to the non-defer mode until the RT tasks start
to behave again.

For that, in the v6, there is a variable (dl_defer_running), once the dl_server
is enqueued after the defer time, the variable dl_defer_running is set.

If the fair task sleeps in the middle of the period, that variable do not change.

If the fair task wakes up and the dl_defer_running is still set, do not defer.
Keep running until you consume the reservation.

The variable dl_defer_running is set to 0 only after the fair tasks consume
its runtime without being in a dl_server... IOW, when the RT tasks start to
behave.

No interface change.

With that in place, your reproducers are working. I have a periodic version
of your reproducer, also improving how the task consumes the runtime,.. I
will send it to you so you can have a look.

> 
> Specifically, it breaks because of this patch (6/7). If you revert the patch,
> the issue goes away.
> 
> With the patch 6/7:
> # ./dlserver_test
> # Runtime of PID 85 is 0.430000 seconds
> Bail out! Runtime of PID 85 is not within 10% of expected runtime 0.900000
> 
> Without the patch 6/7:
> # ./dlserver_test
> # Runtime of PID 87 is 0.900000 seconds
> ok 1 PASS
> 
> So basically, because of defer (or whatever you want to call it ;)), it gives
> less than 50% of the bandwidth that it gave without the defer.

There was a problem with the non-defer mode as well, the dl_server_start() was
missing a set need resched. Fixed that in v6.

> Further, my impression is this patch (6/7) does not even solve all the issue it
> intended. For example, consider that a CFS task is in the boosted phase, and now
> an RT task wakes up. That RT task *will wait* for possibly the whole runtime
> granted to CFS, so it might not always help. Contrasting that with RT
> throttling, if an RT task is very well behaved (well behaved defined as not
> running to the limit that RT throttling should kick in), and it wakes up, it
> will run right away without any wait time, regardless of what CFS was or was not
> doing.


I fixed that as well.

The problem happens when a DL server has a large runtime (>=~ 50%).
Let's say 25 ms runtime, 50 ms period.

At time 0, the defer timer will be set at 25 ms (50 - 25).

From 0 to 25, the RT task would consume, for instance, only 2 ms... so
it is behaving...

At time 25, the defer timer fires... and as the fair task ran for 23 ms
(25 - 2 ms taken by RT) it still has 2 ms runtime to run... so the server
is activated... it is not correct.

The change I made in v6 is:

Same case...

At time 25, the defer timer fires...
	Then, the timer will re-compute the defer time:
		If the RT tasks are behaving, forward the timer for the
		new (deadline - runtime).
		return;

For instance, in the previous case, the new defer timer would be: 50 ms - 2 ms.

CFS will continue working, consuming runtime and resetting the period to avoid
activating the dl server.

The idea of forwarding the timer was taken from the cfs period timer. It is also
possible to forward the timer on other points... if necessary...

I did more testing, with different task sets, including tasks that goes to sleep...
it is working as expected.

-- Daniel


> thanks,
> 
>  - Joel
> 


