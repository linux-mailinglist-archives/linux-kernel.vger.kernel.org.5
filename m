Return-Path: <linux-kernel+bounces-55051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3384B6E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27121F25A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA64131E51;
	Tue,  6 Feb 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/KvPBe3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EA131E4D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227478; cv=none; b=h+0sxxMfSnnaht3ObPv/QcE5Cv9zL+qBIveVx9I1AKLpu7/9NI6fQJDeHrHUBdIHd4ZtX1fdj+MUhbxc/aIXbZnmkt264zVW2yNWkYLXXi553gvzQkxEOk2tlHigKoJXqZ1ZwLVxwK2+CqgdbAayPxatbe0CSKPnVBwhFKgqFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227478; c=relaxed/simple;
	bh=3buTS3x0WMqsueK4/cOWr+YARxIx3ihbmGSj47Au+Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K8EBKFsCx1/LdAXwFWNKac/v/V/8Jvxt6cSL1zAQys9rLHgMXXVqo5SWx6ngYwd+Cm+zbrJVHko+Wi39BCQiExv/xK+OCNKKWi5BwfINJJ1k4OS2t34FM2cXSp9rjCMdkwmQQnD3ziDnwCNOQp1NtQMurPHKE3PVGHonfpmJU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/KvPBe3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707227474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkfoqLfzF7vK/gZE2YKlXCSfKtNqFNg1ApnwzVkTJKA=;
	b=D/KvPBe3waOurCzWuPPZ/q2qw9c0EKXZoIvCaxHAWZDaJFL8x4adUwrUZvaYQa7COppA5t
	WtBoY6M2Xb4FKntGVXMjfL9CyuQg2OoIJLktwH7YA/4+Do9OLsCU4q38NRAWp9XqrcAsfF
	jUEFe4ZGKrqrSu3Tcr6vN8FjAgOwC24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ZQdKd96JNkGj_z3wcw4P1w-1; Tue, 06 Feb 2024 08:51:13 -0500
X-MC-Unique: ZQdKd96JNkGj_z3wcw4P1w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b14a51893so2493123f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227472; x=1707832272;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkfoqLfzF7vK/gZE2YKlXCSfKtNqFNg1ApnwzVkTJKA=;
        b=qo1uzO8Lh4ch/76ReEtbHTNTRH82FxE1GVVhqEnPZzte7+tAy7zW6xVaVHVSxiBddC
         xscsRaRxGh5kOkgFz1utXEMzoCVnk843a8Bh+BVHO3fSQIzFq68MNqh5I+XfD0fXJWxC
         2e773O8S2Rf4O9NL00ms3OR0dyXMwaPwX7va6SqpUvyNTJhN537eizYS/gF2TsNva2J1
         WWQandnrXDtm0Q2P4o+TH1gT8kr/TxGlZO8Su99C83dGjB5nQ2qHe+WiiucdgQTA4Gy5
         WtyLqW9q/4LRURfaQyydoTUhOofjk9Ze31+/h3CHG6FbNkm3zYM7sipSkA39hoo805EN
         qdVw==
X-Gm-Message-State: AOJu0Yw3bNEw3N/wWK2zVls3MtQU36oJxm8hU395IT8znDOVoEdffr5B
	hM1wpvLxq7tErYhM3waWuJqT61JpQBjDw2CPb0hdlyHteGEbD4zF+YaMQ2ve2IfKdNuDTPOBSAm
	XylOBD+1X3uxvywymMwtE5UKendjnc9a4lSolg7Wb1+dBwnil2i/UPKTdQ3A7IqUbrn1dDQ==
X-Received: by 2002:a5d:6dae:0:b0:33b:3040:df03 with SMTP id u14-20020a5d6dae000000b0033b3040df03mr1709972wrs.46.1707227471686;
        Tue, 06 Feb 2024 05:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmpZadPLKyny+UC5ApM3JvQcujp/xyiMsSaDgPfqOOTl1ukEuwHOjmaHSYYxhbfvUtaHQBrQ==
X-Received: by 2002:a5d:6dae:0:b0:33b:3040:df03 with SMTP id u14-20020a5d6dae000000b0033b3040df03mr1709950wrs.46.1707227471286;
        Tue, 06 Feb 2024 05:51:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWw7ZdrY1f0I+g1ocN0UgfGP0yCCOjUDRT8OWX7RaLOsE2gJ0X0xdAdyKzmuqYXimxSlPqXZmL9AHVRacnQ+nLfIpHR1Lr6DINAWEXvSm8gR8YeHaQiD03YFKViOW+q1PlQKSGaTEwDLjrhR7IzTLCjI+zxEQ62IXF3AUYbP/MbNjk=
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe850000000b0033aeb0afa8fsm2167051wrn.39.2024.02.06.05.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:51:10 -0800 (PST)
Message-ID: <9624b6b2-16b1-43a0-90ec-a9e8d40464d1@redhat.com>
Date: Tue, 6 Feb 2024 14:51:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Flush the cache to improve latency
Content-Language: en-US, fr
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231019135655.313759-1-jfalempe@redhat.com>
 <660c0260-0e22-4e9c-ab13-157adaa0b14d@suse.de>
 <74b367bd-ac80-478b-8f82-e98cb6e40475@redhat.com>
 <f19a2cb4-57b6-427c-b69c-47a848420530@redhat.com>
 <e64f641d-44b7-4019-866d-1050277ef885@redhat.com>
 <ZcI1R7s10Fs8GSk8@phenom.ffwll.local>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZcI1R7s10Fs8GSk8@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 14:33, Daniel Vetter wrote:
> On Mon, Dec 11, 2023 at 10:31:28AM +0100, Jocelyn Falempe wrote:
>> On 06/11/2023 11:46, Jocelyn Falempe wrote:
>>> On 23/10/2023 10:30, Jocelyn Falempe wrote:
>>>> On 20/10/2023 14:06, Thomas Zimmermann wrote:
>>>>> (cc'ing lkml for feedback)
>>>>>
>>>>> Hi Jocelyn
>>>>>
>>>>> Am 19.10.23 um 15:55 schrieb Jocelyn Falempe:
>>>>>> We found a regression in v5.10 on real-time server, using the
>>>>>> rt-kernel and the mgag200 driver. It's some really specialized
>>>>>> workload, with <10us latency expectation on isolated core.
>>>>>> After the v5.10, the real time tasks missed their <10us latency
>>>>>> when something prints on the screen (fbcon or printk)
>>>>>
>>>>> I'd like to hear the opinion of the RT-devs on this patch.
>>>>> Because AFAIK we never did such a workaround in other drivers.
>>>>> And AFAIK printk is a PITA anyway.
>>>>
>>>> Most other drivers uses DMA, which means this workaround can't apply
>>>> to them.
>>>>
>>>>>
>>>>> IMHO if that RT system cannot handle differences in framebuffer
>>>>> caching, it's under-powered. It's just a matter of time until
>>>>> something else changes and the problem returns. And (honest
>>>>> question) as it's an x86-64, how do they handle System
>>>>> Management Mode?
>>>>
>>>> I think it's not a big news, that the Matrox G200 from 1999 is
>>>> under-powered.
>>>> I was also a bit surprised that flushing the cache would have such
>>>> effect on latency. The tests we are doing can run 24h with the
>>>> workaround, without any interrupt taking more than 10us. Without the
>>>> workaround, every ~30s the interrupt failed its 10us target.
>>>>
>>>>>
>>>>>>
>>>>>> The regression has been bisected to 2 commits:
>>>>>> 0b34d58b6c32 ("drm/mgag200: Enable caching for SHMEM pages")
>>>>>> 4862ffaec523 ("drm/mgag200: Move vmap out of commit tail")
>>>>>>
>>>>>> The first one changed the system memory framebuffer from Write-Combine
>>>>>> to the default caching.
>>>>>> Before the second commit, the mgag200 driver used to unmap the
>>>>>> framebuffer after each frame, which implicitly does a cache flush.
>>>>>> Both regressions are fixed by the following patch, which forces a
>>>>>> cache flush after each frame, reverting to almost v5.9 behavior.
>>>>>
>>>>> With that second commit, we essentially never unmap an active
>>>>> framebuffer console. But with commit
>>>>>
>>>>> 359c6649cd9a ("drm/gem: Implement shadow-plane {begin,
>>>>> end}_fb_access with vmap")
>>>>>
>>>>> we now again unmap the console framebuffer after the pageflip happened.
>>>>>
>>>>> So how does the latest kernel behave wrt to the problem?
>>>>
>>>> The regression was found when upgrading the server from v5.4 to
>>>> v5.14, so we didn't test with later kernels.
>>>> We will test with v6.3 (which should have 359c6649cd9a ) and see
>>>> what it gives.
>>>
>>> I don't have a clear explanation, but testing with v6.3, and forcing the
>>> Write Combine, doesn't fix the latency issue. So forcing the cache flush
>>> is still needed.
>>>
>>> Also, on some systems, they use "isolated cpu" to handle RT task, but
>>> with a standard kernel (so without the CONFIG_PREEMPT_RT).
>>> So I'm wondering if we can use a kernel module parameter for this,
>>> so that users that wants to achieve low latency, can opt-in ?
>>>
>>> something like mgag200.force_cache_flush=1 or mgag200.low_latency=1 ?
>>
>> Hi,
>>
>> I have now access to a server that reproduce the issue, and I was able to
>> test different workarounds.
>>
>> So it is definitely related to the "Write Combine" mode of the mga internal
>> RAM. If I comment the two lines to enable wc: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/mgag200/mgag200_drv.c#L150,
>> then the latency is <10us (but the performances are worse, from 20ms to 87ms
>> to draw a full frame).
> 
> Ok this is very strange, but at least it starts to make sense. Apparently
> if we stream a _lot_ of writes from wb to wc memory on a cpu that results
> in high latencies on other cpus. And the only way to fix that is by
> artificially making the wb source suffer from cache misses by flushing
> them out.
> 
>> I also tried to flush the vram using:
>> drm_clflush_virt_range(mdev->vram + clip->y1 * fb->pitches[0],
>> drm_rect_height(clip) * fb->pitches[0]);
>> And that lower the latency to ~20us, but it's not enough.
>>
>> I tried "sfence" which I though would flush the WC buffers of the CPU, but
>> that has no effect in practice.
>>
>> I think I can send a new patch, to not map the VRAM as Write Combine, either
>> if CONFIG_PREEMPT_RT is set or if a module parameter is set.
>> What do you think is the best approach ?
> 
> I think an mgag200 module option like Dave suggested is best.
> 
> Plus the entire above debug story in the commit message, especially the
> things you've figured out in your latest testing (apologies for missing
> your mail from Dec, pls ping again if things get dropped like that) kinda
> explains what's going on.
> 
> Still doesn't make much sense that a cpu doing a lot of wb->wc transfers
> can hurt other cores like this, but at least that seems technically
> plausible.
> 
> Also please link to this thread for all the details on test setup, I think
> the above is enough as a summary for the commit message. But if you want
> you can include all the details below too.

Thanks,

Let me send a new patch, with this change.

For the module parameter, I propose to name it "writecombine" and 
default to 1, so if you want low latency, you need to add 
mgag200.writecombine=0 to the kernel command line.

Best regards,

-- 

Jocelyn

> 
> Cheers, Sima
> 
>> My tests setup:
>>
>> I either flood the console with "cat /dev/urandom | base64" from the BMC, or
>> write to fb0 with "while true; do dd if=/dev/urandom of=/dev/fb0 ; done"
>>
>> then I run:
>>
>> cd /sys/kernel/debug/tracing
>> echo 0 > tracing_on
>> echo 950000 > hwlat_detector/width
>> echo hwlat > current_tracer
>> echo 10 > tracing_thresh
>> echo 1 > tracing_on
>> sleep 300
>> cat trace
>> echo 0 > tracing_on
>> echo nop > current_tracer
>>
>>
>> Test Results:
>>
>> V6.6 (~40us latency)
>>
>> # tracer: hwlat
>> #
>> # entries-in-buffer/entries-written: 6/6   #P:56
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>             <...>-8795    [001] dn...   613.749741: #1 inner/outer(us):
>> 41/41    ts:1702045267.016266287 count:9976
>>             <...>-8804    [000] dn...   675.201727: #2 inner/outer(us):
>> 40/40    ts:1702045328.469859973 count:6506
>>             <...>-8804    [000] dn...   731.435258: #3 inner/outer(us):
>> 40/41    ts:1702045384.704861049 count:9578
>>             <...>-8804    [000] d....   787.684533: #4 inner/outer(us):
>> 41/41    ts:1702045440.955603974 count:22591
>>             <...>-8804    [000] d....   844.303041: #5 inner/outer(us):
>> 41/41    ts:1702045497.575594006 count:33324
>>             <...>-8804    [000] d....   900.494844: #6 inner/outer(us):
>> 40/40    ts:1702045553.768864888 count:1924
>>
>>
>> V6.6 + clfush mdev->vram (~20us latency)
>>
>> # tracer: hwlat
>> #
>> # entries-in-buffer/entries-written: 3/3   #P:56
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>             <...>-8983    [001] d....   534.595415: #1 inner/outer(us):
>> 21/20    ts:1702024432.844243126 count:3018
>>             <...>-8983    [000] dn...   758.560453: #2 inner/outer(us):
>> 21/21    ts:1702024656.824367474 count:22238
>>             <...>-8983    [000] dn...   815.117057: #3 inner/outer(us):
>> 21/21    ts:1702024713.373220580 count:26455
>>
>>
>> V6.6 + no Write Combine for VRAM (<10us latency)
>>
>> # tracer: hwlat
>> #
>> # entries-in-buffer/entries-written: 0/0   #P:56
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>
>>
>> Best regards,
>>
>> -- 
>>
>> Jocelyn
>>
> 


