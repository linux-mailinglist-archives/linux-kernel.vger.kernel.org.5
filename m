Return-Path: <linux-kernel+bounces-162120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99E8B5638
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6810B2361A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A43F8F4;
	Mon, 29 Apr 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYX0iCqD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8033DB8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389206; cv=none; b=ahbCREYcC3eOT/Ch47FFXjSGS4cUJ5v2iILhY9xHUwLbOMHsDmHtUQGlKqLII6Fiwwvdn4Xit/uMKmLzczvtvmkoOKOeOnvBwrsbWxdelh7/Pq3xwapdg6FYpzG4x+WYVOScfadXD/RvgDbhSaSj1nX0cDmr11Qb1T7tg3j424k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389206; c=relaxed/simple;
	bh=T/crSH9DSA8ylB7Et4pCh0oc+2zAxyiMJFqQVdttaQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=frmCJpDlUG3ZexlkJ1M3MQGOth0AYyIksXj1brfBloWai6lvpYIYsVzvbKJOToVEgVltRRWHSaVKJYVBUnNiJPHX/GBEnkYSbblVHemHz5B6xI1GSqKe6sKLau4DeRHxwR6DB+W2tHUvfNggki5jSyrXFCUF5BE0ZCWT6SS2ZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYX0iCqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714389203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sJML5s0biiGbCVOwrO3DXEz4jiznSmREmBT1P/exaw=;
	b=KYX0iCqD3rllL7xcpZWR9F9k5Z4AuSKf1xOPD3bIwNoP8fSdMn+AH6qPkATfDh07p8LR1Q
	nSUm8O+PtnuZ/bJ/+SGaKx2OxLQyS123LL50QeXDWlWGC1Usegl0aUzZT+3E2fJxBiVCae
	eJWKJgdHqDinJLrVG3NFKmXST5Ry+r4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-KTjS55DKPSGs9msMhCM-2Q-1; Mon, 29 Apr 2024 07:13:22 -0400
X-MC-Unique: KTjS55DKPSGs9msMhCM-2Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51bd015c476so3486397e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389201; x=1714994001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sJML5s0biiGbCVOwrO3DXEz4jiznSmREmBT1P/exaw=;
        b=o/cCRZT/IpOQ4VrQdMpvB2fn9NhaCX3HsQiCHN1rTQheBuj9bCt0huiX7D3/svxhBJ
         uwP+PZtDWSNqDLOOOj5NXof5QlX04CdvQm+QFWno1vf3K8UHhmMKPixm0u+vn5uj3L4e
         IcVHxxQjPCETBzToG87PxJ1uVlAQw/C10MhKLgJXjH4XGcwBpG2KF3sLOLEq64YVDkUY
         p3YdCIo4UegKTDYtGbnas9Qax3mx60Y1vCW/g85KsF8xU9o9/wbmP5/6Yoe9vaa49oPX
         knKqDXBoow+QVEqyc9tV3jKDpylesuDeoS4KJVjrlOZ0yCnSRtXcOmU17anxEyomzf7L
         kvBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrED9OA6yWpH3Q9zU/hjr59IUvBokcMNSFNHO5eIhZ3w1QBY9ibzlc1BGFQWx19myXvfAlmDPeft1pkpLM2/Gr/gu818aJQwa3TL2W
X-Gm-Message-State: AOJu0YzvALhteolRNr/wNIJbftlwwL7z9KGuSgz64vIYYleiDLQB5aUW
	bxVkdBTAGZa6FsiEEInNH9T/HzgSho9aAtF4vHYg/S0T3boBxdwZIsOacGUq0ihRNa38aRSX+tH
	5NxcvKyn9HHEZvHhsNvTYGKsd6iTt4CD/xcpwxDF0S3DbKeYa5aKL0MyfT6ne1Q==
X-Received: by 2002:ac2:4e03:0:b0:516:cf0a:9799 with SMTP id e3-20020ac24e03000000b00516cf0a9799mr7129200lfr.64.1714389200939;
        Mon, 29 Apr 2024 04:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg7WXBOz5A0aLSEx3ARFvToHVEBe47VUDofaiUeVucK5VTQ3/DUfw1ow8m393Bc5sqQ2amPw==
X-Received: by 2002:ac2:4e03:0:b0:516:cf0a:9799 with SMTP id e3-20020ac24e03000000b00516cf0a9799mr7129152lfr.64.1714389200211;
        Mon, 29 Apr 2024 04:13:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ah2-20020a1709069ac200b00a4e393b6349sm13686361ejc.5.2024.04.29.04.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:13:19 -0700 (PDT)
Message-ID: <32d7fbec-1b62-4e61-a078-ef7549bc8947@redhat.com>
Date: Mon, 29 Apr 2024 13:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
To: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20240424065212.263784-1-hpa@redhat.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 4/24/24 8:52 AM, Kate Hsuan wrote:
> This patch added the support for Xiaomi Pad2 indicator LED. This work
> included:
> 1. Added the KTD2026 swnode description to describe the LED controller.
> 2. Migrated the original driver to fwnode to support x86 platform.
> 3. Support for multi-color LED trigger event.
> 4. The LED shows orange  when charging and the LED shows green when the
>    battery is full.
> 
> Moreover, the LED trigger is set to the new trigger, called
> "bq27520-0-charging-orange-full-green" for Xiaomi Pad2 so the LED shows
> orange when charging and the LED shows green when the battery is full.

Lee, I believe this series is ready for merging now ?  I've reviewed
patches 1-2 + 5 and Jacek has reviewed patches 3 + 4.

Patch 5 also has an Acked-by from Sebastian for merging it together
with the rest of the series.

Can you merge patches 1-5 ?

Patch 6 just changes the value of a device-property (the default-trigger
string) and I can merge that through the pdx86 tree independent of
patches 1-5.

Regards,

Hans





> 
> --
> Changes in v7:
> 1. Platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
>    indicator LED was included in Hans' branch.
> 2. Included the tags from the previous version in the commit message.
> 3. Fixed the comma issue for the structure initialiser.
> 
> Changes in v6:
> 1. The I2C ID table was moved to a separate patch.
> 2. The LED shows orange when charging.
> 3. The trigger name was renamed to charging-orange-full-green.
> 4. The default trigger of Xiaomi Pad2 is
>    "bq27520-0-charging-orange-full-green".
> 
> Changes in v5:
> 1. Fix swnode LED color settings.
> 2. Improve the driver based on the comments.
> 3. Introduce a LED new API- led_mc_trigger_event() to make the LED
>    color can be changed according to the trigger.
> 4. Introduced a new trigger "charging-red-full-green". The LED will be
>    red when charging and the the LED will be green when the battery is
>    full.
> 5. Set the default trigger to "bq27520-0-charging-red-full-green" for
>    Xiaomi Pad2.
> 
> Changes in v4:
> 1. Fix double casting.
> 2. Since force casting a pointer value to int will trigger a compiler
>    warning, the type of num_leds was changed to unsigned long.
> 
> Changes in v3:
> 1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
>    pad2"
> 
> Changes in v2:
> 1. Typo and style fixes.
> 2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
>    KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
>    sleep can be removed when removing the module.
> 
> 
> Hans de Goede (2):
>   leds: core: Add led_mc_set_brightness() function
>   leds: trigger: Add led_mc_trigger_event() function
> 
> Kate Hsuan (4):
>   leds: rgb: leds-ktd202x: Get device properties through fwnode to
>     support ACPI
>   leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
>   power: supply: power-supply-leds: Add charging_orange_full_green
>     trigger for RGB LED
>   platform: x86-android-tablets: others: Set the LED trigger to
>     charging_orange_full_green for Xiaomi pad2
> 
>  drivers/leds/led-class-multicolor.c           |  1 +
>  drivers/leds/led-core.c                       | 31 ++++++++
>  drivers/leds/led-triggers.c                   | 20 ++++++
>  drivers/leds/rgb/Kconfig                      |  1 -
>  drivers/leds/rgb/leds-ktd202x.c               | 72 +++++++++++--------
>  .../platform/x86/x86-android-tablets/other.c  |  2 +-
>  drivers/power/supply/power_supply_leds.c      | 26 +++++++
>  include/linux/leds.h                          | 26 +++++++
>  include/linux/power_supply.h                  |  2 +
>  9 files changed, 149 insertions(+), 32 deletions(-)
> 


