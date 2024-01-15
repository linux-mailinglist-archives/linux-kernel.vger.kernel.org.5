Return-Path: <linux-kernel+bounces-25940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBFB82D896
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F31E1F224BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2C2C68E;
	Mon, 15 Jan 2024 11:52:55 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1A2C683
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e78238db9so8079925e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 03:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705319571; x=1705924371;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSOwFelbGnrjjv46VNX24pXgS91dqLFaNUYjiJbSarc=;
        b=vGYheT/rgjDF9O9U4qKtmDHpqOMuKc84U+gTWd6XZzZBhp6aozuzsPBKkTNNU/kgj8
         lS5Shvm54rw7+3iyXGGxIQPKvkNWQMXGTT9t3RxPfipdA509uZdvYD4PYTdH/MMgo49U
         U9NyzXhjawVYHvbTxolH0slrZ1SaGNWI+b5YMV9+gQ4PrlcfsWI8DM+bxp4fD0QZbffo
         VCyAqqWgd5Yze92Ru3H4LtQPHJmx0sraR9IojxxIL+53yxQx2bTwRKTTgV8lZhQ07ImS
         vHVntFzK4CD3FZImF0BeObo/Tg4dA4Afz558rLl9ZbJPIh4J7zDGpWfThJAVck1YmogS
         J5hg==
X-Gm-Message-State: AOJu0YyWGmSVKKwcVqIaKhphKy0Gn9llkl5Eirp+uLR+YHOBsLcuoG/R
	2+G1dBiTzl4gO/PhkafHtbc=
X-Google-Smtp-Source: AGHT+IG4CW6HUo/nGwUGJyCqD9HFBP41b+rrPN2fudUlxbpp1Ye5jtN7ZhQrlCyCroAn6bRipXs6fg==
X-Received: by 2002:a05:600c:32af:b0:40e:5459:5864 with SMTP id t47-20020a05600c32af00b0040e54595864mr3018715wmp.184.1705319571182;
        Mon, 15 Jan 2024 03:52:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm15536537wmq.12.2024.01.15.03.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:52:50 -0800 (PST)
Message-ID: <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
Date: Mon, 15 Jan 2024 12:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
 bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
 juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net> <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15. 01. 24, 12:40, Jiri Slaby wrote:
> On 15. 09. 23, 17:19, Peter Zijlstra wrote:
>> On Fri, Sep 15, 2023 at 02:58:35PM +0200, Thomas Gleixner wrote:
>>
>>> I spent quite some time to convince myself that this is correct. I was
>>> not able to poke a hole into it. So that really should be safe to
>>> do. Famous last words ...
>>
>> IKR :-/
>>
>> Something like so then...
>>
>> ---
>> Subject: futex/pi: Fix recursive rt_mutex waiter state
> 
> So this breaks some random test in APR:
> 
>  From 
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:Staging:G/apr/standard/x86_64:
> testprocmutex       :  Line 122: child did not terminate with success
> 
> The child in fact terminates on 
> https://github.com/apache/apr/blob/trunk/test/testprocmutex.c#L93:
>                  while ((rv = apr_proc_mutex_timedlock(proc_lock, 1))) {
>                      if (!APR_STATUS_IS_TIMEUP(rv))
>                          exit(1); <----- here
> 
> The test creates 6 children and does some 
> pthread_mutex_timedlock/unlock() repeatedly (200 times) in parallel 
> while sleeping 1 us inside the lock. The timeout is 1 us above. And the 
> test expects all them to fail (to time out). But the time out does not 
> always happen in 6.7 (it's racy, so the failure is semi-random: like 1 
> of 1000 attempts is bad).

This is not precise as I misinterpreted. The test is: either it succeeds 
or times out.

But since the commit, futex() yields 22/EINVAL, i.e. fails.

> If I revert this patch (commit fbeb558b0dd0d), the test works.
> 
> I know, the test could be broken too, but I have no idea, really. The 
> testsuite is sort of hairy and I could not come up with a simple repro.
> 
> Note APR sets up PTHREAD_PROCESS_SHARED, _ROBUST, and _PRIO_INHERIT 
> attrs for the mutex.
> 
> Anyway:
> downstream report: https://bugzilla.suse.com/show_bug.cgi?id=1218801
> APR report: https://bz.apache.org/bugzilla/show_bug.cgi?id=68481
> 
> Any idea if this patch should cause the above (or even is a desired 
> behavior)?
> 
> Thanks.



-- 
js


