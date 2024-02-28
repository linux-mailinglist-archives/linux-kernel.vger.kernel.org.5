Return-Path: <linux-kernel+bounces-85328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71EF86B448
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CE9B276DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26515DBA2;
	Wed, 28 Feb 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejSSTthZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6B15E5A4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136654; cv=none; b=hgUUJ0hesMB2TAO3od/5OpLNZsTaBBVwEVHnowNkbqKMfwVrRSjfujMIdMasZQMuRpWC1vKSj13uhVeE5ORjw/wqdtr8Jp1fOjM/AwQLAIuMNEfGaYBXpIQF5w/LQy4OkUrL4cExz1sN2+ecVasWSzFSmvpjRgqdSY3BfqxrK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136654; c=relaxed/simple;
	bh=tUfJQor4830kH9UmzvNPWn4hGPtuR5l4LZ1wkT5hAec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzeuXVGEcALRLGstXS/L0EPNpjhdBCsTKAGem0Wzz4RDhVozbLPcTS0Ffyzirxd5MtVc8LdMFRVBk5Pketz/0qVa5fkGzXGU51IUbdHQDTasbhmtJRDzzfKX3Cs9oYlt9WPkxoUY+Dfu9V7MYkUFEiyBk0ivb2ZSWO6YaxdB3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejSSTthZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udhaGW9sxAsIHOXwgUwbVd2Skw/h1rnJJQepqWMaXzM=;
	b=ejSSTthZVVlrqmNAuIoE1Nhkt9xFTv8YoA8lQqVyLIjYtD7EBk9LfwKk2IZvqyCWjEfrO9
	RDjj5WcpU7SgW6/ZvHuVdo6tVtEK6oCEUComxqp4AruX1J+uWEBAUkS5YEmsNQKG7FRyHY
	w1h/1YUX49cxUsP7DOSCFFyJepDQ+nU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-RNobaYjiNI-Ej_Z-YUhjrw-1; Wed, 28 Feb 2024 11:10:46 -0500
X-MC-Unique: RNobaYjiNI-Ej_Z-YUhjrw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-564753be3deso2998498a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136645; x=1709741445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udhaGW9sxAsIHOXwgUwbVd2Skw/h1rnJJQepqWMaXzM=;
        b=QCXpoxWfYWJTV9dwE21gE02J3eE1KMQcTFSlX1ifzW4AIqpvSTi4u7jhoF6Akz7FU4
         fcwoHIdybNMn/ov1Al1JrTMAAmq2O+JAaw0mg55IFREHLH/BSYOuIfDSVwk9Ehqd6VKh
         A8zJ9EMolaPxP5axxu5mLjCwiR1ly8CSRM1HmoP+Re/ZQXvWVkf9JCrK1DjmVw8bp3iE
         0inzA/4ErwxvqVrKk1NwzoheDi5vhiEBUAvnuvfPoiBkyfSJFdWIkp/tcZmzVfxf4fgS
         wnQjGWNkjpBKsdvLtqovVvlaa2EEJe4oKN4A4F/V4pe3f2msskWJw8GMWaGq7gtbHuXa
         vbCg==
X-Forwarded-Encrypted: i=1; AJvYcCVn3J9GU1ug5Vi7aHHlhss3cOzouhz5PCb4Cq7pIEx85pN6iORxsxeZy+IGIIcKwv0flFzJPuFory81G1RDVP6U5+POzICWHNGucHjm
X-Gm-Message-State: AOJu0YxwS5nI9JZGmZ6V35fFfaKOLe4Lmw0Sc1cGt6OOz5ZHeRpJKls6
	DmM2CIPOSscK5abh/MY41cF3UGaeRVlEuvz3SdFmopWPdhc7tKtfH7fbzHKrf2Wo5ZcFaMetNin
	zR0qp6ZScckH/ZyIZwBOMtoRKvjll5JZqQD71bTMA/P2bDUBx1ksk9iiksTa0+w==
X-Received: by 2002:aa7:c643:0:b0:566:51fa:3640 with SMTP id z3-20020aa7c643000000b0056651fa3640mr2544691edr.6.1709136645219;
        Wed, 28 Feb 2024 08:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwsLQbE8k7pl3GPAi+qUVw53CxKpuM6+Z0a8HCacvxILM4aFwXL+GIxWbkN8im8wD9VNSenQ==
X-Received: by 2002:aa7:c643:0:b0:566:51fa:3640 with SMTP id z3-20020aa7c643000000b0056651fa3640mr2544674edr.6.1709136644902;
        Wed, 28 Feb 2024 08:10:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402510b00b0056686744752sm102392edd.37.2024.02.28.08.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:10:44 -0800 (PST)
Message-ID: <3e96a963-5596-4ea6-9a72-450d0b1221cd@redhat.com>
Date: Wed, 28 Feb 2024 17:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
Content-Language: en-US, nl
To: Nikita Travkin <nikita@trvn.ru>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
 <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
 <edec3bee-8604-49a9-8e2f-6c21e852ef6c@redhat.com>
 <c6d3d9841fe5a754e78adaf95522b434@trvn.ru>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c6d3d9841fe5a754e78adaf95522b434@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nikita,

On 2/28/24 16:49, Nikita Travkin wrote:
> Hans de Goede писал(а) 26.02.2024 15:59:
>> Hi,
>>
>> +Ilpo (fellow pdx86 maintainer)
>>
>> On 2/23/24 15:32, Nikita Travkin wrote:
>>> Sebastian Reichel писал(а) 22.02.2024 04:41:
>>>> Hi,
>>>>
>>>> On Tue, Feb 20, 2024 at 04:57:13PM +0500, Nikita Travkin wrote:
>>>>> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
>>>>> controller to control the charging and battery management, as well as to
>>>>> perform a set of misc functions.
>>>>>
>>>>> Unfortunately, while all this functionality is implemented in ACPI, it's
>>>>> currently not possible to use ACPI to boot Linux on such Qualcomm
>>>>> devices. To allow Linux to still support the features provided by EC,
>>>>> this driver reimplments the relevant ACPI parts. This allows us to boot
>>>>> the laptop with Device Tree and retain all the features.
>>>>>
>>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>>> ---
>>>>>  drivers/power/supply/Kconfig           |  14 +
>>>>>  drivers/power/supply/Makefile          |   1 +
>>>>>  drivers/power/supply/acer-aspire1-ec.c | 453 +++++++++++++++++++++++++++++++++
>>>>
>>>> I think this belongs into drivers/platform, as it handles all bits of
>>>> the EC.
>>>>
>>>
>>> Hm, I initially submitted it to power/supply following the c630 driver,
>>> but I think you're right... Though I'm not sure where in platform/ I'd
>>> put this driver... (+CC Hans)
>>>
>>> Seems like most of the things live in platform/x86 but there is no i.e.
>>> platform/arm64...
>>>
>>> Hans, (as a maintainer for most things in platform/) what do you think
>>> would be the best place to put this (and at least two more I'd expect)
>>> driver in inside platform/? And can we handle it through the
>>> platform-driver-x86 list?
>>
>> I guess that adding a drivers/platform/aarch64 map for this makes
>> sense, with some comments in the Makefile and in the Kconfig
>> help explaining that this is for PC/laptop style EC drivers,
>> which combine multiple logical functions in one, only!
>>
>> Assuming that we are only going to use this for such EC drivers,
>> using the platform-driver-x86 mailinglist for this makes sense
>> since that is where are the people are with knowledge of e.g.
>> userspace APIs for various typical EC functionalities.
>>
>> It might even make sense to also use:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>>
>> As git tree for this and send pull-reqs to Linus for this
>> together with the other pdx86 for the same reasons.
>>
>> I would be open to that as long as this is strictly limited to
>> EC (like) drivers.
> 
> Yes, I believe the EC are the only "board-specific" drivers we need for
> the Windows-on-Arm devices as of today. I expect at least two more EC
> drivers to be added later.
> 
> Then I will re-target this series to platform-driver-x86:
> 
> - Will add a new drivers/platform/aarch64/ dir with a Makefile and Kconfig
>   that would explicitly note it's only for EC-like drivers. Will update
>   the "X86 PLATFORM DRIVERS" entry in MAINTAINERS. (Or should I add a new
>   entry?)

Please add a new entry (you can simply copy most of the "X86 PLATFORM DRIVERS"
entry), putting this under the "X86 PLATFORM DRIVERS" entry feels weird.

> - Will add this driver there, also updating per the last Sebastian's
>   comments.

This sounds good.

> - Will also move the dt binding to a new bindings/platform/ dir.

Please consult with the DT binding maintainers about this bit.

Regards,

Hans



