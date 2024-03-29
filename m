Return-Path: <linux-kernel+bounces-125078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B9891FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B4828AA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7B146A83;
	Fri, 29 Mar 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a194rbvV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471E81752;
	Fri, 29 Mar 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720480; cv=none; b=GFeWmWhQUaSf2izv8WQD01lLDluSFiDsluRFBc9Wrb2nfLXUxHb3V2O+Vdelhg+1TkzOhyfRttFAQYoDv2ggScV0JZR01pKppRAsk7h/da4HojhgQT/nhwQFWTAQ6+IYnku/N2mTQ57dXUJPc0RYeJ1u1Lk1jFW6TOwjP0IAtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720480; c=relaxed/simple;
	bh=DR6fYLE1VuU2SIl4xQACIKrKEyqsZVKZkrKOVqjp9Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPB0BXO1IsYSKiqAvG2YCGv2xII5/sB2HF7DiU6bAIEQN0shuCmTzs8++CO8Nicfwbu3lGfWz/CSK792nhmEn0tC8VLT+T7TRowLN/YktXaPSPYNM1FFiX3RkzdG0desN6L/5lkkeYLupN/DqI4Dig+b3T3GzjEOjgroNYhM5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a194rbvV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d717269fso2278930e87.0;
        Fri, 29 Mar 2024 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711720476; x=1712325276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHaouYTaJxshuIVZXd/Pid1l+kG8/ihpEvSCsFXgEIU=;
        b=a194rbvVmj4JdeLURcvLLx+MnZ3iCi1croduiC3P5wLrgW5WQwtlgwYSsM2i8sF/EU
         kXkv6tUzW5HIMj2Y/ToG21S5g+NgUGAotI6m/pKPMvqkTr+StE3GTE7g/G3CEaasIvwh
         MSvHtWpSxQRzA7S/gfCxBQRXiKESusS9npti9b4dqZhAmOe5I/l4+TlFBrFbBCw36HtW
         UlJGzbgwepQSJJk9OWClr51z8pMCNqYLY8PsR+277VnAiFY44/zvWhru8FZerkPKkS19
         Hnbit7BxNM7u4WGRS+WjtDQiFUd7aD3iK9tA2KuJLcPcRhvBd1jDemoqKxUru6ArMaSE
         URRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720476; x=1712325276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHaouYTaJxshuIVZXd/Pid1l+kG8/ihpEvSCsFXgEIU=;
        b=N7sJYcZhYgeBnzNf6E+XFLI3oMPibzXNI8wi+Wr05+XQA8boNzDGFmyHsEVQBFPqMx
         fEL5qMsVi8s7XSvNEffOKQY7vfr+A0epr4y1V/YpNaLoWmYcRU3AeEaXsMq/V2DMDzo2
         SVhk7MmoH5V2crLHKf8Zkt/lKBoEqrog3ninelTV/p/1NUhXz82KrVzBriTe9tCi139Z
         6lOKx0Q2b0RADObfFVriZ21z9MycDcIbX6hEuIsY1WAAFTbndSHfzafjo/E18joHE5B9
         fvcwwtUd5P94IwGqodJDda1gnslzvy+xS2hkLfeq9gwfi2nYogQl/P9P8oe3fvCXTjB7
         V+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVXinWhl4WBPnxBGiYLuSdS1LGJrwZmyRMKGKazBf2BCWzc+JHrWdmwzetTjIfUCqfO8vUKi/SeI0X80/RQXEq+54aGCeDpWBJNEfTdcyDFS0KGsRowbcoXKmXhMZcDN542GSgNz+w=
X-Gm-Message-State: AOJu0YxabkrFo6ANl1a5jphdtgjP4j6Xa2o7fc6+C74EncNNIOb8+39d
	qcDW5KPFACDnaRWmrU9ahRxU9B+puiHYYc/o/28x/z1p/EYhFzle
X-Google-Smtp-Source: AGHT+IFFpaKKru6K8hJn9wQjB/u6vPOdJ6Z8Ga23dF2L4AkyuBzLohb4VdUPm/fOdwSj3dTcijH1hg==
X-Received: by 2002:a05:6512:2024:b0:513:e9cf:34ca with SMTP id s4-20020a056512202400b00513e9cf34camr1508919lfs.46.1711720476013;
        Fri, 29 Mar 2024 06:54:36 -0700 (PDT)
Received: from [192.168.100.20] ([31.162.18.37])
        by smtp.gmail.com with ESMTPSA id d26-20020ac24c9a000000b005114a0c56afsm635315lfl.279.2024.03.29.06.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 06:54:35 -0700 (PDT)
Message-ID: <1467af1e-cdeb-4fe0-ad42-407de96dcf01@gmail.com>
Date: Fri, 29 Mar 2024 18:54:33 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Allow binding without
 cooling devices
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, nikita@trvn.ru
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
 <CAJZ5v0jAq=iMKzYBz-Ni6Zqpbgxp3_0UYpPiAoSLcfGNJ8ruhQ@mail.gmail.com>
 <1bfcb1cf-fc08-404b-be36-b5e1863f7c59@arm.com>
 <3df783db-3243-4484-a429-4d3e64b9dbae@arm.com>
Content-Language: en-US
From: Nikita Travkin <nikitos.tr@gmail.com>
In-Reply-To: <3df783db-3243-4484-a429-4d3e64b9dbae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukasz, Rafael!

First of all, it seems like outlook mail server that serves @arm.com refuses
to communicate with mine so I can't send anything to it and it refuses to
send anything to me either...

I'm sorry for any inconvenience this may cause and I will deal with it 
somehow...

28.03.2024 14:50, Lukasz Luba пишет:
>
>
> On 3/28/24 09:12, Lukasz Luba wrote:
>> Hi Rafael,
>>
>> On 3/27/24 15:25, Rafael J. Wysocki wrote:
>>> On Thu, Mar 21, 2024 at 3:44 PM Nikita Travkin <nikita@trvn.ru> wrote:
>>>>
>>>> Commit e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>>> points earlier")
>>>> added a check that would fail binding the governer if there is no
>>>> cooling devices bound to the thermal zone. Unfortunately this causes
>>>> issues in cases when the TZ is bound to the governer before the 
>>>> cooling
>>>> devices are attached to it. (I.e. when the tz is registered using
>>>> thermal_zone_device_register_with_trips().)
>>>>
>>>> Additionally, the documentation across gov_power_allocator suggests 
>>>> it's
>>>> intended to allow it to be bound to thermal zones without cooling
>>>> devices (and thus without passive/active trip points), however the 
>>>> same
>>>> change added a check for the trip point to be present, causing 
>>>> those TZ
>>>> to fail probing. 
>
> This patch description is mixing trips and cooling devices and refers to
> a commit which is only for guarding the trip points number to be
> not less than 2. In IPA we require 2 trip points.

I'm sorry, I probably worded this poorly. I meant that there may be
a TZ that has no trip points because it's not meant to be used with
any cooling device.

>>>>
>>>> Those changes cause all thermal zones to fail on some devices (such as
>>>> sc7180-acer-aspire1) and prevent the kernel from controlling the 
>>>> cpu/gpu
>>>> frequency based on the temperature, as well as losing all the other
>>>> "informational" thermal zones if power_allocator is set as default.
>>>>
>>>> This commit partially reverts the referenced one by dropping the trip
>>>> point check and by allowing the TZ to probe even if no actor buffer 
>>>> was
>>>> allocated to allow those TZ to probe again.
>>>>
>>>> Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>>> points earlier") 
>
> Not that commit.
>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>> ---
>>>> I've noticed that all thermal zones fail probing with -EINVAL on my
>>>> sc7180 based Acer Aspire 1 since 6.8. This commit allows me to bring
>>>> them back. 
>>>
>>> Łukasz, any comments? 
>>
>> Let me check this today.
>>>> ---
>>>>   drivers/thermal/gov_power_allocator.c | 14 +++++---------
>>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/gov_power_allocator.c 
>>>> b/drivers/thermal/gov_power_allocator.c
>>>> index 1b17dc4c219c..4f2d7f3b7508 100644
>>>> --- a/drivers/thermal/gov_power_allocator.c
>>>> +++ b/drivers/thermal/gov_power_allocator.c
>>>> @@ -679,11 +679,6 @@ static int power_allocator_bind(struct 
>>>> thermal_zone_device *tz)
>>>>                  return -ENOMEM;
>>>>
>>>>          get_governor_trips(tz, params);
>>>> -       if (!params->trip_max) {
>>>> -               dev_warn(&tz->device, "power_allocator: missing 
>>>> trip_max\n"); 
>
> This if() guards the binding of TZ with less than 2 trip points,
> not the cooling devices.
>>>> - kfree(params);
>>>> -               return -EINVAL;
>>>> -       }
>>>>
>>>>          ret = check_power_actors(tz, params);
>>>>          if (ret < 0) {
>>>> @@ -693,7 +688,7 @@ static int power_allocator_bind(struct 
>>>> thermal_zone_device *tz)
>>>>          }
>>>>
>>>>          ret = allocate_actors_buffer(params, ret);
>>>> -       if (ret) { 
>
> This if() is from different commit.

Hm you're right, I misread the commit I think and on a second thought
this patch combines two different issues. I will split it up into two.

>>>> +       if (ret && ret != -EINVAL) { 
>
> This is about 0 cooling devices in the thermal zone, but IPA won't work
> so why to even fake and forward binding?
>
> Rafael should we support binding with 0 cooling devices? 

As I understand it, cooling devices can attach to existing thermal zones
so it's possible that TZ is registered before any cooling devices has
attached to it. This is exactly what happens in my case: first the
IPA is probed for the TZ and after that the cooling device is attached.

check_power_actors() kerneldoc in IPA says:

> * If all of the cooling  devices currently attached to @tz implement the power
> * actor API, return the  number of them (which may be 0, because some cooling
> * devices may be  attached later). Otherwise, return -EINVAL.

and afaiu this is exactly how it's used by 
thermal_zone_device_register_with_trips():

     result = thermal_set_governor(tz, governor);
     if (result) {
mutex_unlock(&thermal_governor_lock);
         goto unregister;
     }
     (...)
     /* Bind cooling devices for this zone */
     bind_tz(tz);

>>>> dev_warn(&tz->device, "power_allocator: allocation failed\n");
>>>>                  kfree(params);
>>>>                  return ret;
>>>> @@ -714,9 +709,10 @@ static int power_allocator_bind(struct 
>>>> thermal_zone_device *tz)
>>>>          else
>>>>                  params->sustainable_power = 
>>>> tz->tzp->sustainable_power;
>>>>
>>>> -       estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>>> -                              params->trip_switch_on,
>>>> - params->trip_max->temperature);
>>>> +       if (params->trip_max) 
>
> This is not supported, we need those 2 trip points.

Yes, I understand that IPA is useless without trip points and/or cooling
devices. However from the snippet above the TZ won't be registered if
the governor fails to probe. This means that if one has IPA set as the
default, thermal core will try to probe it for TZ without trip points and,
when it fails, will fail to probe the whole TZ.

get_governor_trips() kerneldoc in IPA says:

 > * on.  If there are no passive or active trip points, then the
 > * governor won't do anything.  In fact, its throttle function
 > * won't be called at all.

Which suggests to me that being bound to such TZ is expected.

Unless you have any thoughts on how to solve this better, I will split
this into two commits and resubmit in a few days:

  - Allow binding without cooling devices (allow -EINVAL after allocate)
  - Allow binding without trip points (Rest of this patch)

Nikita


>>>> + estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>>> + params->trip_switch_on,
>>>> + params->trip_max->temperature);
>>>>
>>>>          reset_pid_controller(params);
>>>>
>>>>
>>>> ---
>>>> base-commit: e7528c088874326d3060a46f572252be43755a86
>>>> change-id: 20240321-gpa-no-cooling-devs-c79ee3288325
>>>>
>>>> Best regards,
>>>> -- 
>>>> Nikita Travkin <nikita@trvn.ru>

