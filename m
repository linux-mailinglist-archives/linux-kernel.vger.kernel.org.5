Return-Path: <linux-kernel+bounces-106045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36687E84E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AB0B233C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6D374F5;
	Mon, 18 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlmdLOVi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E4374CC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760306; cv=none; b=lgh7U4R6z7uLCdCBSaDYIYWa8bbzaYPAlFmHyIdRIb8sb1tFqo2pvf+nEiyccieMD1PXjkalJXWBJsAHSuAVWC8zkggyUMrNKFOZkGgwpyaRhuDeIReQ8PUBzzW9yxLWL+NsJIJKduPHkjxWAFe8+SQYH4r+lnpohwlgOKiYWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760306; c=relaxed/simple;
	bh=vpxP2TC2qbkVtFFP21jKsCrf2Cm91PVj9H+H8hFENmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAzdHtgxZvP8G6cX8wgmYVIz41264oka7kjOKJ+QXvPUcLcGBMWo2xMHX/f22ERVUvJRJIWxwP1HuaziNYypHmY/jdpy691nqsbDTxPUC3chED7s3c5g3DI09VCZ12CevHqq+jRGKmaJccouwkg3QztIbrWkLTTorhnjeoTcfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlmdLOVi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710760303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCRrLRgzcFtsj04jmn2kcF48w7FCWYzPNjCCNXWwhN8=;
	b=hlmdLOViuolPGWd/IsZNI5nzakY4Fi3Y2G+b6SaUceH75tR5wurCCV+choVAGk2kY3q4Vy
	PYljugOfsrMBbfrj6S6+/s6S90tOIZ4x2vWFqRtPAytyMQJ+yRQc8ldSyK6wG9BVFw+uCP
	GnhGj0REFXbI/bxvFiRj7zJZFj16Vqo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-0gvp2ng9MFq8fmyfAwYZSw-1; Mon, 18 Mar 2024 07:11:42 -0400
X-MC-Unique: 0gvp2ng9MFq8fmyfAwYZSw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46cedd9689so23376366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760301; x=1711365101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCRrLRgzcFtsj04jmn2kcF48w7FCWYzPNjCCNXWwhN8=;
        b=L+XokCsEAADq42VwU6NAkdDw98SQ7NA+I6SZRKfO2TOI4P5zS0OZ4vw120IAnn0zUN
         MtnU8F3vLPLdwgPKVMCrchGxkWZYaBWyuE6t15tEQZpuRO7/MnevSnEGJCq6Mv9b3d+3
         d/+GFLCMQXIVwwSdJb55qN0pUq3oJeCdvnvDcG/1SMEUd+RZeB6V6bjBdBqvaCD6c+TY
         EeXGWVJ9lbC1JipczSD85fluB+SOCj9QbUfdP7njrhm2qofEuXYLQBVPU0voZ4Lj2jIb
         LmF6v4I2LHpyBJpaSVDYeWTQ1SPwHHA5AOthJXWzF/FYOAsqCA9+VSA4d0pM1ptiSu8t
         wPHA==
X-Forwarded-Encrypted: i=1; AJvYcCXLWthjDo7FD4a+bcR2XhQB6JOh4cAMZQTgBMfGuxLzuzUD3LDl6OU4Uv5xnxmX6tx/AFV7sSw+NVh/9bN0QZB1ht+RaeiyfVLChTtE
X-Gm-Message-State: AOJu0YxdnZXOEcKVppN73jxbTMepqzwmbuqyDTuDA0wyFMfvi9wh4jP/
	uA6+/hjO2hsdSf07sM4CicysSGDzTmFB+vC4YwPN8HegUxgsRqlpLM7TxKPwyrWwHOnGYsZQ2Sc
	VUa92kFctVHJx21+ybzlcjRdyQ76rhUBz6bUfhGz3GmachhwtYn/Hx7ruQEbglw==
X-Received: by 2002:a17:906:ddb:b0:a46:a1f7:156d with SMTP id p27-20020a1709060ddb00b00a46a1f7156dmr4019171eji.2.1710760301094;
        Mon, 18 Mar 2024 04:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEknhYpk/UoBbIXiSyWkooZJA3/ywR9QXOka5TQQi9XFr2kwrDhiLCZltxYyDrNnVlq8/TlEA==
X-Received: by 2002:a17:906:ddb:b0:a46:a1f7:156d with SMTP id p27-20020a1709060ddb00b00a46a1f7156dmr4019152eji.2.1710760300703;
        Mon, 18 Mar 2024 04:11:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id sd9-20020a170906ce2900b00a4628cacad4sm4722437ejb.195.2024.03.18.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 04:11:40 -0700 (PDT)
Message-ID: <281f9b71-a565-4ff3-8343-ca36d604584d@redhat.com>
Date: Mon, 18 Mar 2024 12:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v3
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Werner,

Sorry for the late reply.

On 2/22/24 2:14 PM, Werner Sembach wrote:
> Hi,
> 
> Thanks everyone for the exhaustive feedback. And at least this thread is a good comprehesive reference for the future ^^.
> 
> To recap the hopefully final UAPI for complex RGB lighting devices:
> 
> - By default there is a singular /sys/class/leds/* entry that treats the device as if it was a single zone RGB keyboard backlight with no special effects.

Ack this sounds good.

> 
> - There is an accompanying misc device with the sysfs attributes "name", "device_type",  "firmware_version_string", "serial_number" for device identification and "use_leds_uapi" that defaults to 1.

You don't need a char misc device here, you can just make this sysfs attributes on the LED class device's parent device by using device_driver.dev_groups. Please don't use a char misc device just to attach sysfs attributes to it.

Also I'm a bit unsure about most of these attributes, "use_leds_uapi" was discussed before
and makes sense. But at least for HID devices the rest of this info is already available
in sysfs attributes on the HID devices (things like vendor and product id) and since the
userspace code needs per device code to drive the kbd anyways it can also have device
specific code to retrieve all this info, so the other sysfs attributes just feel like
duplicating information. Also there already are a ton of existing hidraw userspace rgbkbd
drivers which already get this info from other places.

>     - If set to 0 the /sys/class/leds/* entry disappears. The driver should keep the last state the backlight was in active if possible.
> 
>     - If set 1 it appears again. The driver should bring it back to a static 1 zone setting while avoiding flicker if possible.

Ack, if this finds it way into some documentation (which it should) please make it
clear that this is about the "use_leds_uapi" sysfs attribute.

> - If the device is not controllable by for example hidraw, the misc device might also implement additional ioctls or sysfs attributes to allow a more complex low level control for the keyboard backlight. This is will be a highly vendor specific UAPI.

IMHO this is the only case where actually using a misc device makes sense, so that
you have a chardev to do the ioctls on. misc-device-s should really only be used
when you need a chardev under /dev . Since you don't need the chardev for the e.g.
hidraw case you should not use a miscdev there IMHO.

> 
>     - The actual logic interacting with this low level UAPI is implemented by a userspace driver
> 
> Implementation wise: For the creation of the misc device with the use_leds_uapi switch a helper function/macro might be useful? Wonder if it should go into leds.h, led-class-multicolor.h, or a new header file?

See above, I don't think we want the misc device for the hidraw case, at which
point I think the helper becomes unnecessary since just a single sysfs write
callback is necessary.

Also for adding new sysfs attributes it is strongly encouraged to use
device_driver.dev_groups so that the device core handled registering /
unregistering the sysfs attributes which fixes a bunch of races; and
using device_driver.dev_groups does not mix well with a helper as you've
suggested.

> 
> - Out of my head it would look something like this:
> 
> led_classdev_add_optional_misc_control(
>     struct led_classdev *led_cdev,
>     char* name,
>     char* device_type,
>     char* firmware_version_string,
>     char* serial_number,
>     void (*deregister_led)(struct led_classdev *led_cdev),
>     void (*reregister_led)(struct led_classdev *led_cdev))
> 
> Let me know your thoughts and hopefully I can start implementing it soon for one of our devices.

I think overall the plan sounds good, with my main suggested change
being to not use an unnecessary misc device for the hid-raw case.

Regards,

Hans



