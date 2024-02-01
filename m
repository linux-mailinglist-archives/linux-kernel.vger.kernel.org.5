Return-Path: <linux-kernel+bounces-48339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7068845A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A6628D3C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570853360;
	Thu,  1 Feb 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrW1QLUa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225894D9F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799015; cv=none; b=gIBq2lThqcjUbFJ2qlQIznMDyxIP+jDB/aDilCc3hKAVcx4UAWR5PTfnmZToYC5qd9a/Mjtq5zpFByob+UxoNWC57n1piAR1oQjN1S231nsskDF4l+mxFqWKvsBk1v5TeAHAahfwpMSgT/f16PwK/ikF15i465LJfGxN/RS95WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799015; c=relaxed/simple;
	bh=ZPuglH0u9AuOiA1rE4QZNiI+4bT/1jf147EKYA6StjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFokDblA0t74f5OD7tUX4HwkKBnMPAw6sCJX/vSrQskgcn5MC113oef1kCdeoqsCTg5O3+RT+4pgYX9MTrR0X9O8NMmd8G/ZJ57xB1pUtF65+YRfD6Njbb/OAmZVMUtmD9611LNoV8ZO+2/vV3qc5C7/GgOmAYq8wDuWSkufONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrW1QLUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706799013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pp4TjeyNCbdquwZX0zbYYJTeh59vjIymyWLqxYgaVJw=;
	b=WrW1QLUapy8TRAU9e/SSE1T+4Kmg3g1ZqFCFv02wbG38gkt4oWbVvqrNRDYfb+umkmbPua
	kLdeMLJIbMG0ioZUHUqQl9B5RtpnvOPyZvREiYO5pNjf6ECslcYRn1eOj9Fvym/OHOFTzw
	yXrUGzVOqaHAW1ffgAM+OhyuqqkQop0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-MvUYjrv7Ol-xjEh099q2ew-1; Thu, 01 Feb 2024 09:50:11 -0500
X-MC-Unique: MvUYjrv7Ol-xjEh099q2ew-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a27eddc1c27so60263866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799010; x=1707403810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp4TjeyNCbdquwZX0zbYYJTeh59vjIymyWLqxYgaVJw=;
        b=K2cpkRvI7NgHMAduNcYUsg3xVSlta1XBSe62UKA55CxO+lDy2W0nx3iyodgdhIjRVw
         754MQ7JuckUKktr8F7m5RiL+zb8sZQUiuWCIfCQI1C6JDmfsLoRm5E1+NM4k1j3yEtts
         hVQ+2FsRyO/lFEvgvoy1x48KYuce5h9d6KOtlL+K2TkPAsexQSuyz30zbTcw8n+yaDoP
         Dqe99Vl7Wv/bnVwJCzBEtN6Jcg4Q1WG/7kBwprFsOQcQif4R0QMxfYPU5coTnEeOvPHn
         i2epkQGRnyXvnRLDlDRqe4V9VfmBxiJh+qPMZ+7R6F69RvZKk031VUE6bTy0FdmClCUE
         l1/g==
X-Gm-Message-State: AOJu0Yw1ojleEMi3P7UNGmxLYfRTBZIRKmusNVUN2N5ax1qfpg34O0Pa
	e1bSaoo5U5ewnanOHdQZINDEDxfjOeBC7D34kRCjgRW+oRm+uKVaJEK+4d9N9g4jf0ZI5y+31MW
	ALS6PnagV1Bx11rV/mE2Yig+6B7oZGwRav0bWR0cZ1rQCJiPCe8hlpqdy6uJpdw==
X-Received: by 2002:a17:906:b58:b0:a36:c8d4:1a40 with SMTP id v24-20020a1709060b5800b00a36c8d41a40mr1288130ejg.59.1706799009511;
        Thu, 01 Feb 2024 06:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgdU3CeH9gax7vPWxX+FCwsIxhz6hXIGhVm+rYSD1mvB8QG3ZeVS8Y5ImtDrb/HjU2FycAgg==
X-Received: by 2002:a17:906:b58:b0:a36:c8d4:1a40 with SMTP id v24-20020a1709060b5800b00a36c8d41a40mr1288111ejg.59.1706799009127;
        Thu, 01 Feb 2024 06:50:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOellkWRXNqxlbewgFw7Ks3bBzNz3XaWqwOUQYbB86AIdH48WR8dB5/o5UF86oMCAGw2xRDfb7N1Zebcw+lFMD/i9finAfIRT1tKWERiPOI5RLSHPIPn4EtMT7TtiKB2RhusG8Qh5FNspAlMJXrrZMdqCYOkBGe6v17NOhM4r+9BFhy52hz+dV7Yyrpx7FaTGJrGGdXoQlFUZ/XwofnA5t7IVJbkGR09Q6RadmsrsDxu8JRJzrxTk1gASe24VyFxGACiEICt74Gw==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090668d400b00a36c4ce1bdcsm566269ejr.14.2024.02.01.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:50:08 -0800 (PST)
Message-ID: <fb66b037-eeba-45d6-be41-215478cf3ba9@redhat.com>
Date: Thu, 1 Feb 2024 15:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Content-Language: en-US, nl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com,
 LKML <linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>,
 platform-driver-x86@vger.kernel.org
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
 <2024020135-sly-theft-0594@gregkh>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2024020135-sly-theft-0594@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 2/1/24 15:47, Greg Kroah-Hartman wrote:
> On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
>> On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
>>
>>> On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
>>>> On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
>>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> + Cc Suma Hegde.
>>>>>
>>>>> On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
>>>>>
>>>>>> The use of devm_*() functions works properly for when the device
>>>>>> structure itself is dynamic, but the hsmp driver is attempting to have a
>>>>>> local, static, struct device and then calls devm_() functions attaching
>>>>>> memory to the device that will never be freed.
>>>>>>
>>>>>> The logic of having a static struct device is almost never a wise
>>>>>> choice, but for now, just remove the use of devm_device_add_groups() in
>>>>>> this driver as it obviously is not needed.
>>>>
>>>> Hi Greg,
>>>>
>>>> Could you please hold on merging this patch for a week? I will push a patch
>>>> for converting platform specific structure's memory allocation from static
>>>> to a dynamic
>>>>
>>>> allocation.
>>>
>>> Push it where?  Ususally we do "first patch wins" type stuff, why not
>>> just do your work on top of mine?
>>>
>>> Also, when you do make the needed changes, please remove the explicit
>>> call to create sysfs groups and use the default groups pointer instead,
>>> that will make things much simpler and avoid races in the code.
>>
>> Hi Greg,
>>
>> Well, if you really want to "win" :-), please provide an updated version 
>> which considers the changes already made in the for-next branch (the 
>> current one won't apply).
> 
> Fair enough, I don't want to "win", I just want to squash any "hold off
> and don't make any changes to this file because I was going to plan on
> doing something else here in the future" type of stuff, as that is what
> has been documented to take down many projects in the past.
> 
> That's why we almost always take patches that people have submitted
> today, instead of ignoring them for potential future changes, unless of
> course, they are not acceptable.
> 
> I'll rebase on linux-next, rejecting it for that reason is totally valid :)

I checked the code in linux-next and the dev passed to devm_device_add_groups()
now is &amd_hsmp_platdev->dev and amd_hsmp_platdev gets properly removed
from hsmp_plt_exit(), so I believe that keeping the devm_... call is
the right thing to do.

With that said this driver really could use some modernization
(even though it is not a very old driver):

1. The sysfs attribute registration should really switch to using
amd_hsmp_driver.driver.dev_groups rather then manually
calling devm_device_add_groups().

2. Ideally amd_hsmp_platdev should be the only global static variable
and plat_dev should simply be drvdata of the platform_device.

Suma, can you take a look at maybe fixing these, especially 1. ?

Regards,

Hans





