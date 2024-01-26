Return-Path: <linux-kernel+bounces-40307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40383DE28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D94282DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC41D55C;
	Fri, 26 Jan 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xflxem+E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7A1D545
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284725; cv=none; b=fXrmHLP7DkPOiSN/UdDJeNXBTg+JdhrwGeCxD8prYivX5ARjlXd3fl7mX9gUYRkip4itgGXtoGZtf60zBfy3YNoZeLawCbs3SDlUHkKrGAw4Ed6LzggDIV5c255LRDHXBacw1gV3U/dmWSE9EMZfToJAAB46EoNw2zMyfoyVOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284725; c=relaxed/simple;
	bh=xmeqY/uRenAS2GypxtpTf0hMTK+WOwrfcQ7a4WIXI0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T+c9mVr3otzHV7KRzO/mm5cb83/+fjF20UYTPp4DXp8O2+mtVdQkVvMyIaSgXc3SRBIW3dP88qbcjmML9Hf9D33zPbaGVg5P9IGe5IkWdwqupZSlhPUKOsTPfHU6aPzfFkM65E5S5f6fs3pATT5h8GhubzA9wh/x+DCN0mhG9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xflxem+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706284722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzZZ8m/08RO+tzVflGT5FAmEqtYtLJ/5p2mW8NHoYDQ=;
	b=Xflxem+ELpiufUn/9/d8u8hnHTXZ483Js32wHNQMICGno3rUxq+cN6G3adfqlKsBI19zuq
	qsmTkvxNsSN46dbTE6R3YCBfsVXIDXj09MI8G0mxH8t/KxNWULiMc1P1UZ5tzIsfMOnN4W
	4pFsfVoGPpO8tJSv5DeyeR8JYjXs1Dk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-j5stNBddMw61b4Cxwh51aw-1; Fri, 26 Jan 2024 10:58:40 -0500
X-MC-Unique: j5stNBddMw61b4Cxwh51aw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e7ddf4dacso465022e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284719; x=1706889519;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzZZ8m/08RO+tzVflGT5FAmEqtYtLJ/5p2mW8NHoYDQ=;
        b=W4cjDn0EX0EXcy4N2kmcH4vepJN57wcZ+F++NxKcyjcn0kU6l36oe14W/SWURcQ/UJ
         IobPcgwLFvM/33my2fJKGiV/KMeQMYAUbcm91Ow/bLV7ddqo4lPBj2MynoBU4COyPkEl
         1iVbgsdBmICycTwsB8pJlhAP6wnN/vZS7AIbcsyM5JDW64nsF6Hx+9F4Ci0KGEZyuK6I
         xR+op2ff3N1RamRC7Z/VtZgj7lyF4OrHyCPzIbTJISAu1NCrmM6t1z6GPHtq1DlVFcJr
         FmQXozzyq+PgQK9fy+YOMd+tWbrziBqHvKMSj33KRFD04MIK1IGFuJcg7ej5kNT8SUWt
         POiA==
X-Gm-Message-State: AOJu0Yx4dry4frypPQslxsExNhVx9m9tK3dwKwyc8FgJjLnKggjy4b6E
	9uQxukjapfNzw1HDnU7gkDB9CwWU6SVORpPvWvUT0w2SqX13arVjPtJDoMqbu6VXmC2wnOtXfTR
	VoIqAMxQarGHYpd4wRnBVMq824SsIx7ewxlQezUp467YHuWkTUB1bRWIYg7573Q==
X-Received: by 2002:a19:ac02:0:b0:510:1bbe:d700 with SMTP id g2-20020a19ac02000000b005101bbed700mr820098lfc.47.1706284719336;
        Fri, 26 Jan 2024 07:58:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF+A7xm2TL6olI8YFG9H72bDgfb9AKC0TXQ24V14RvZm6Ic85Z17zoO8VYpJER7mNE/L7LfA==
X-Received: by 2002:a19:ac02:0:b0:510:1bbe:d700 with SMTP id g2-20020a19ac02000000b005101bbed700mr820092lfc.47.1706284718955;
        Fri, 26 Jan 2024 07:58:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wb8-20020a170907d50800b00a2fe4463711sm777867ejc.0.2024.01.26.07.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:58:38 -0800 (PST)
Message-ID: <92ba6f97-a579-47d6-9eb7-a97b566c7c6c@redhat.com>
Date: Fri, 26 Jan 2024 16:58:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
 <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>
 <dde1bdfe-7877-41bd-b233-03bcdba0e2de@redhat.com>
 <f07333d2-ebb0-4531-a396-8fb3d1daa2c3@molgen.mpg.de>
 <5f70a174-7f18-43c0-b3a3-b72544a2631b@redhat.com>
In-Reply-To: <5f70a174-7f18-43c0-b3a3-b72544a2631b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

On 1/26/24 14:32, Hans de Goede wrote:
> Hi Paul,
> 
> On 1/26/24 08:03, Paul Menzel wrote:
>> Dear Hans,
>>
>>
>> Thank you for your reply, and sorry for the delay on my side. I needed to set up an environment to easily build the Linux kernel.
> 
> No problem thank you for testing this.
> 
>> Am 22.01.24 um 14:43 schrieb Hans de Goede:
>>
>>> On 1/21/24 15:26, Paul Menzel wrote:
>>
>> […]
>>
>>>> Am 20.01.24 um 21:26 schrieb Hans de Goede:
>>>>
>>>>> On 1/18/24 13:57, Paul Menzel wrote:
>>>>>> #regzbot introduced v6.6.11..v6.7
>>>>
>>>>>> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
>>>>>>
>>>>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>>>>
>>>>>> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.
>>>>>
>>>>> Thank you for reporting this.
>>>>>
>>>>> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
>>>>>
>>>>> This should at least lead to the device not disappearing from
>>>>>
>>>>> "sudo libinput list-devices"
>>>>>
>>>>> The next question is if the keyboard will still actually
>>>>> work after suspend/resume with "i8042.dumbkbd=1". If it
>>>>> stays in the list, but no longer works then there is
>>>>> a problem with the i8042 controller; or interrupt
>>>>> delivery to the i8042 controller.
>>>>>
>>>>> If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
>>>>> my atkbd driver fix for other laptop keyboards is somehow
>>>>> causing issues for yours.
>>>>
>>>> Just a quick feedback, that booting with `i8042.dumbkbd=1` seems to fix the issue.
>>>>
>>>>> If "i8042.dumbkbd=1" fully fixes things, can you try building
>>>>> your own 6.7.0 kernel with commit 936e4d49ecbc:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39
>>>>>
>>>>> reverted?
>>>>
>>>> I am going to try that as soon as possible.
>>>
>>> Assuming this was not some one time glitch with 6.7.0,
>>> I have prepared a patch hopefully fixing this (1) as well
>>> as a follow up fix to address another potential issue which
>>> I have noticed.
>>
>> Unfortunately, it wasn’t just a glitch.
>>
>>> Can you please give a 6.7.0 (2) kernel with the 2 attached
>>> patches added a try ?
>>>
>>> I know building kernels can be a bit of work / takes time,
>>> sorry. If you are short on time I would prefer testing these 2
>>> patches and see if they fix things over trying a plain revert.
>>
>> Applying both patches on v6.7.1
>>
>>     $ git log --oneline -3
>>     053fa44c0de1 (HEAD -> v6.7.1) Input: atkbd - Do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID
>>     0e0fa0113c7a Input: atkbd - Skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID
>>     a91fdae50a6d (tag: v6.7.1, stable/linux-6.7.y, origin/linux-6.7.y) Linux 6.7.1
>>
>> I am unable to reproduce the problem in eight ACPI S3 suspend/resume cycles. The DMAR errors [3] are also gone:
> 
> Thanks.
> 
> So thinking more about this I think the DMAR errors are actually the real cause of the issue here, specifically if we replace: f0 with 00 (I guess DMAR uses the high bits for its own purposes) in
> 
> `[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`
> 
> then the device ID is 00:1f.0 which is the ISA bridge and [INTR-REMAP] errors are known to disable interrupts. The PS/2 controller (which sits behind the ISA bridge) interrupt getting disabled would explain the suspend/resume keyboard issue better then the atkbd.c changes I have been focusing on.
> 
> So then the question becomes why does the 6.7.1 kernel not show the DMAR errors. I don't see anything between 6.7.0 and 6.7.1 which explains this. But maybe your local build is using a different configuration which explains this.
> 
> Can you try your local 6.7.1 build without my 2 patches? The quickest way to do that would be to run: "git reset --hard HEAD~2" and then re-run the make commandos, this will re-use your previous build so it should be pretty quick.
> 
> If things still work after that then the problem is not with the atkbd code.

Never mind I just became aware of a bunch of other reports which don't have
the DMAR errors on resume, so I'm submitting the 2 fixes for this upstream
now.

Regards,

Hans



