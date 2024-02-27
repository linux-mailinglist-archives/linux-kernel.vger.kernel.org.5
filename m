Return-Path: <linux-kernel+bounces-83786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061B869E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810241F29A74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938101468F4;
	Tue, 27 Feb 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVO7+eVq"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992147A7D;
	Tue, 27 Feb 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056633; cv=none; b=s5AESyYtwic2okJbtwVy593txJO4U3T1L/W9mUMXC9fr68sD2tHwFfPsGjkVZ64wPJvbiEBugKSod79b77oVnWR1/7Z50i0PDYUj3j1RucXewm5gwRrnN4KqFY0JIxzWdLRDpS1jx91ur8oiyk+BtR7Ipwujx9g4hAYuknD62Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056633; c=relaxed/simple;
	bh=MCV2xfyzVsZTimxMp1nsJm3TnteiwzapMqfslGtknNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEntb3hHV7iK6plALTH2ArugTA4f9TbmRAhFotQ+aZWcFBUI7PjSptKDLG4/ZsZDwhiemdcegLuk0m5Fx0L4tw39AsrBnCk/KkNgNte5gRhxv1j4MZPcg4SHIlMyqALMraZTqWZUzVLrdwjZkGoxinM7I7hmjd0PhKzmLEjmo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVO7+eVq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21e9589d4ffso2834746fac.1;
        Tue, 27 Feb 2024 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056631; x=1709661431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rvZtLZAsJQqV2EI/YljUxB6c8BBNJcwxJ+IMwUn94I=;
        b=BVO7+eVq6zI07L3H1rM9b/tBAYjlSp5dcD/R/wfhKHcU8rfuD1ri8KXdMkmWjq5Yfx
         yfwhnRwiFK35Ip1x0IVVPe7d5zo7zChMU1Au9Y4u4bD0cvWEEnSPeAa+xob1On4cFJeD
         tYfd5z0o+5NnFadeEGcbcH/kIISy3G/pHMV0df76jgkVq4l/+Kkn4JeVtrHZ6XBqC7DV
         oMxNCX4ledSno73kC/KpWKoZKCQ+z5Ji1QePCvUbBafTZirH16dVSPtSj5l5B1CALrx7
         Wn3ZoT8x4BUYjMq/4pT7Myvgadh6WcYUML/50q1OXdmapBq+fZ41+mn6ueETezn6M630
         9haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056631; x=1709661431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rvZtLZAsJQqV2EI/YljUxB6c8BBNJcwxJ+IMwUn94I=;
        b=eLNflhP+KdvWDojd3QfBmNlCr6qk2I6xCwq5czfhK6W+gPQc7DwALgDmmAyyCmeAXo
         B6nXer0H4rlrT9JKo7/gPUGRxKaShuJ6kwK6uNXVan8rOkXAiVQ5+Yo3iPgteGYBIJB/
         fXru7LU/gfjqqfRBukIkbrYrIYoms1mVqi3SlOrn1d+u1D/cTuuFZMj06LgUZyC/HjBv
         0gaVoc2xv49SqO/B9pOci4KNGMaEHH14GcNjkzgVdeNFqomDGXBJxWxgKVhQkxT098gz
         mMf/vQd2fFWIjHMLehMv22nYTsEyq1Ft+rEFS+AU2OhvxbdilPMEoNRGhVOEN152KP5o
         CE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoxmcCQTn5KsGcWHWEx21icY4/u4+ap6DysJB71E4UsCmNoCnJcp9cCVeXxhDAGzi16aZ8l4//yH9IMx/UBDauYe+In5520dGtXDaxO/68F3hanSobtbh357LjuVy2iRz0vENpLog=
X-Gm-Message-State: AOJu0Yy7Y8KMIGprMCu+ls3no9p84CNI4X/gzXzfI4vT6ZLry+doR/ox
	2dMiY5ywMt8gKAbKcDYJqmURRlKqLkyrFG93ofyb3W8Uw8rJmPIRxDFar80xIDo=
X-Google-Smtp-Source: AGHT+IFGPd6I2/K6HlI1TytR7mWgfa8jok7atWE5+pWx/yt+JF49ojwwLtAkLyTTuVdMPe1wvNEoWQ==
X-Received: by 2002:a05:6871:793:b0:21e:a63c:658d with SMTP id o19-20020a056871079300b0021ea63c658dmr9980599oap.21.1709056630836;
        Tue, 27 Feb 2024 09:57:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bj25-20020a05620a191900b007873306737fsm3807919qkb.87.2024.02.27.09.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 09:57:10 -0800 (PST)
Message-ID: <7292dc5c-dff0-45f0-99b1-f1687451b23f@gmail.com>
Date: Tue, 27 Feb 2024 09:57:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Content-Language: en-US
To: Guan-Yu Lin <guanyulin@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org,
 james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
 <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
 <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/24 00:56, Guan-Yu Lin wrote:
> On Tue, Feb 27, 2024 at 2:40 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 2/26/24 02:28, Guan-Yu Lin wrote:
>>> On Sat, Feb 24, 2024 at 2:20 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> On 2/23/24 06:38, Guan-Yu Lin wrote:
>>>>> In systems with a main processor and a co-processor, asynchronous
>>>>> controller management can lead to conflicts.  One example is the main
>>>>> processor attempting to suspend a device while the co-processor is
>>>>> actively using it. To address this, we introduce a new sysfs entry
>>>>> called "conditional_skip". This entry allows the system to selectively
>>>>> skip certain device power management state transitions. To use this
>>>>> feature, set the value in "conditional_skip" to indicate the type of
>>>>> state transition you want to avoid.  Please review /Documentation/ABI/
>>>>> testing/sysfs-devices-power for more detailed information.
>>>>
>>>> This looks like a poor way of dealing with a lack of adequate resource
>>>> tracking from Linux on behalf of the co-processor(s) and I really do not
>>>> understand how someone is supposed to use that in a way that works.
>>>>
>>>> Cannot you use a HW maintained spinlock between your host processor and
>>>> the co-processor such that they can each claim exclusive access to the
>>>> hardware and you can busy-wait until one or the other is done using the
>>>> device? How is your partitioning between host processor owned blocks and
>>>> co-processor(s) owned blocks? Is it static or is it dynamic?
>>>> --
>>>> Florian
>>>>
>>>
>>> This patch enables devices to selectively participate in system power
>>> transitions. This is crucial when multiple processors, managed by
>>> different operating system kernels, share the same controller. One
>>> processor shouldn't enforce the same power transition procedures on
>>> the controller – another processor might be using it at that moment.
>>> While a spinlock is necessary for synchronizing controller access, we
>>> still need to add the flexibility to dynamically customize power
>>> transition behavior for each device. And that's what this patch is
>>> trying to do.
>>> In our use case, the host processor and co-processor are managed by
>>> separate operating system kernels. This arrangement is static.
>>
>> OK, so now the question is whether the peripheral is entirely visible to
>> Linux, or is it entirely owned by the co-processor, or is there a
>> combination of both and the usage of the said device driver is dynamic
>> between Linux and your co-processor?
>>
>> A sysfs entry does not seem like the appropriate way to described which
>> states need to be skipped and which ones can remain under control of
>> Linux, you would have to use your firmware's description for that (ACPI,
>> Device Tree, etc.) such that you have a more comprehensive solution that
>> can span a bigger scope.
>> --
>> Florian
>>
> 
> We anticipate that control of the peripheral (e.g., controller) will
> be shared between operating system kernels. Each kernel will need its
> own driver for peripheral communication. To accommodate different
> tasks, the operating system managing the peripheral can change
> dynamically at runtime.

OK, that seems like this ought to be resolved at various layer other 
than just user-space, starting possibly with an 
overarching/reconciliation layer between the various operating systems?

> 
> We dynamically select the operating system kernel controlling the
> target peripheral based on the task at hand, which looks more like a
> software behavior rather than hardware behavior to me. I agree that we
> might need a firmware description for "whether another operating
> system exists for this peripheral", but we also need to store the
> information about "whether another operating system is actively using
> this peripheral". To me, the latter one looks more like a sysfs entry
> rather than a firmware description as it's not determined statically.

I can understand why moving this sort of decisions to user-space might 
sound appealing, but it also seems like if the peripheral is going to be 
"stolen" away from Linux, then maybe Linux should not be managing it at 
all, e.g.: unbind the device from its driver, and then rebind it when 
Linux needs to use it. You would have to write your drivers such that 
they can skip the peripheral's initialization if you need to preserve 
state from the previous agent after an ownership change for instance?

I do not think you are painting a full picture of your use case, 
hopefully not intentionally but at first glance it sounds like you need 
a combination of kernel-level changes to your drivers, and possibly more.

Seems like more details need to be provided about the overall intended 
use cases such that people can guide you with a fuller picture of the 
use cases.
-- 
Florian


