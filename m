Return-Path: <linux-kernel+bounces-45020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB3842A88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60381C22238
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271712839E;
	Tue, 30 Jan 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5tsN6ju"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAD86ADC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634645; cv=none; b=VSQccM+XTBItKVzpzbpWpN2LizWx1JjiqilQB0/FtUiEbcm/3e2Li+RaFuD564XaazikX0z8Hc5QUxI9QO2fw/HjMsZ5Xu0QRKC5V0UCkxvllXJXHAa+6pv/3Wilo9sdxL11x2/RVAW1aqHTLCz02u+F9hq8hmKcotPwVk/TJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634645; c=relaxed/simple;
	bh=JLxYrutuVKpYNJ/n5oKzq7SWN+K1NQlYqv9quS1tWjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEk72RUT5kRN7gN5Shs3JsL54Ch/xqXB4Y/hOuV4tao+pZEKIoBm7RyP9oyWQHqC1OCB08sC9nWmxFpZ9fQXsusmm+xliAx7tYXsUvk7WjDJBCcIGCwXz0o7InNDMdVDKBpu2EJlsnjUeQZKulRIEP5vB9r/CymYaZARh/URO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5tsN6ju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706634642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7mnjhDDFAF+47P6CQfnYXjaFDffSDVoorOUT8O3Ne4=;
	b=e5tsN6juknBdiBXP2xzXlxFbtaQIiojORCFI7SXuRl3pjZssUWX6Iut8DchHZ8ozb4fbfj
	KoudspU2s5qRimBQ5HFRbqCy2bcqAF9UpUyks/S/DnD3I3lomxblSIvffjLF+77KYoj8xR
	1N49Y4Og/irKquf4/whLXqU7jqGxX9Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-avExrxgENsOWItKPk897yg-1; Tue, 30 Jan 2024 12:10:40 -0500
X-MC-Unique: avExrxgENsOWItKPk897yg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3120029877so574386066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634639; x=1707239439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7mnjhDDFAF+47P6CQfnYXjaFDffSDVoorOUT8O3Ne4=;
        b=GeXiFBTalDXshBR9rJ6LmGKmhy+3xeL0WhUv22ESnqucXak3jZpu1Mz3v+av5qL737
         Rb/1ecUK3TU0IWwF2fcV4gKdUbjia1BUBTgl5LvufhkJf1naTz4ov4tDL4aYzNRNQtLw
         lhtxqA0QwVpXdagpAG0iG2tZ/v7SkBtmiq4ln3AOSTfsao56FtZXaiBxG5CT0SyrTodN
         o/W66Cb5lCSDA8sdakOf5WXV39c4dAXY/4xHGVveejTK7vrVEXVLZ3yPKjmCD5Eg/h+i
         HyvqW5JZRYMLfk3KQST/JjJFDqlp6hxEMiKGw59+wbI7tj4OLYV6yYdzDaoNXj3bfqJo
         Py7A==
X-Gm-Message-State: AOJu0YwdCe4G2w/hiJKUpDUjXkonaLGu2snHLh27wekzbAEGe7ZRCXiw
	fKhOwjMTtkhYxgPxFHtcXMaElHoQYHnk4e70Z3a3aQHzJp6UjSPcLV8VqclWYx0LueY0x/i/nT7
	86q/3KWA5kKhKNlh0rH8i5+uS8UkRIWqiRnceYBKXaW5u66q/wTDmmF1oaTlJfg==
X-Received: by 2002:a17:907:8b9b:b0:a35:ae23:1588 with SMTP id tb27-20020a1709078b9b00b00a35ae231588mr2611302ejc.9.1706634639060;
        Tue, 30 Jan 2024 09:10:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPsEH8mqBeEqehY5GgAfPbwcwHYXjfVAwvoseEDJEt8zMb+fpWwFQYyadRjiPByrxOv/XYPA==
X-Received: by 2002:a17:907:8b9b:b0:a35:ae23:1588 with SMTP id tb27-20020a1709078b9b00b00a35ae231588mr2611276ejc.9.1706634638732;
        Tue, 30 Jan 2024 09:10:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gy14-20020a170906f24e00b00a28f51adc39sm5284013ejb.61.2024.01.30.09.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:10:38 -0800 (PST)
Message-ID: <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
Date: Tue, 30 Jan 2024 18:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US, nl
To: Werner Sembach <wse@tuxedocomputers.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Werner,

On 1/30/24 12:12, Werner Sembach wrote:
> Hi Hans,
> 
> Am 29.01.24 um 14:24 schrieb Hans de Goede:

<snip>

>> That sounds workable OTOH combined with your remarks about also supporting
>> lightbars. I'm starting to think that we need to just punt this to userspace.
>>
>> So basically change things from trying to present a standardized address
>> space where say the 'Q' key is always in the same place just model
>> a keyboard as a string of LEDs (1 dimensional / so an array) and leave
>> mapping which address in the array is which key to userspace, then userspace
>> can have json or whatever files for this per keyboard.
>>
>> This keeps the kernel interface much more KISS which I think is what
>> we need to strive for.
>>
>> So instead of having /dev/rgbkbd we get a /dev/rgbledstring and then
>> that can be used for rbb-kbds and also your lightbar example as well
>> as actual RGB LED strings, which depending on the controller may
>> also have zones / effects, etc. just like the keyboards.

<snip>

>> Right, so see above I think we need to push all these complications
>> into userspace. And simple come up for a kernel interface
>> for RGB LED strings with zones / effects / possibly individual
>> addressable LEDs.
>>
>> Also we should really only use whatever kernel interface we come up
>> with for devices which cannot be supported directly from userspace
>> through e.g. hidraw access. Looking at keyboards then the openrgb project:
>>
>> https://openrgb.org/devices_0.9.html
>>
>> Currently already supports 398 keyboard modes, we really do not want
>> to be adding support for all those to the kernel.

> I think that are mostly external keyboards, so in theory a possible cut could also between built-in and external devices.

IMHO it would be better to limit /dev/rgbledstring use to only
cases where direct userspace control is not possible and thus
have the cut be based on whether direct userspace control
(e.g. /dev/hidraw access) is possible or not.


>> Further down in the thread you mention Mice with RGB LEDs,
>> Mice are almost always HID devices and already have extensive support,
>> including for their LEDs in userspace through libratbag and the piper UI,
>> see the screenshots here (click on the camera icon):
>> https://linux.softpedia.com/get/Utilities/Piper-libratbag-104168.shtml
>>
>> Again we really don't want to be re-doing all this work in the kernel
>> only to end up conflicting with the existing userspace support.
>>
>> <snip>
>>
>>>> 5. A set_effect ioctl which takes a struct with the following members:
>>>>
>>>> {
>>>> long size; /* Size of passed in struct including the size member itself */
>>>> int effect_nr; /* enum value of the effect to enable, 0 for disable effect */
>>>> int zone;  /* zone to apply the effect to */
>>> Don't know if this is necessary, the keyboards I have seen so far apply firmware effects globally.
>>>> int speed; /* cycle speed of the effect in milli-hz */
>>> I would split this into speed and speed_max and don't specify an actual unit. The firmwares effects I have seen so far: If they have a speed value, it's some low number interpreted as a proportional x/n * the max speed of this effect, with n being some low number like 8 or 10.
>>>
>>> But i don't know if such clearly named properties are even sensefull, see below.
>>>
>>>> char color1[3]; /* effect dependend may be unused. */
>>>> char color2[3]; /* effect dependend may be unused. */
>>>> }
>>> We can not predetermine how many colors we might need in the future.
>>>
>>> Firmware effects can vary vastly in complexity, e.g. breathing can be a single bit switch that just varies the brightness of whatever color setting is currently applied. It could have an optional speed argument. It could have nth additional color arguments to cycle through, it could have an optional randomize bit that either randomizes the order of the defined colors or means that it is picking completely random color ignoring the color settings if set.
>>>
>>> Like this we could have a very fast explosion of the effects enum e.g.: breathing, breathing_2_colors, breathing_3_colors, ... breathing_n_colors, breathing_speed_controlled, breathing_speed_controlled_2_colors, ... breathing_speed_controlled_n_colors_random_bit, etc.
>>>
>>> Or we give up on generic names and just make something like: tongfang_breathing_1, tongfang_scan_1, tongfang_breathing_2, clevo_breathing_1
>>>
>>> Each with an own struct defined in a big .h file.
>>>
>>> Otherwise I think the config struct needs to be dynamically created out of information the driver gives to userspace.
>> Given that as mentioned above I believe that we should only use a kernel
>> driver where direct userspace access is impossible I believe that having
>> things like tongfang_breathing_1, tongfang_scan_1, tongfang_breathing_2,
>> clevo_breathing_1, etc. for the hopefully small set of devices which
>> needs an actual kernel driver to be reasonable.

> So also no basic driver? Or still the concept from before with a basic 1 zone only driver via leds subsystem to have something working, but it is unregistered by userspace, if open rgb wants to take over for fine granular support?

Ah good point, no I think that a basic driver just for kbd backlight
brightness support which works with the standard desktop environment
controls for this makes sense.

Combined with some mechanism for e.g. openrgb to fully take over
control as discussed. It is probably a good idea to file a separate
issue with the openrgb project to discuss the takeover API.

>> Talking about existing RGB LED support I believe that we should also
>> reach out to and get feedback on (or even an ack for) the new rgbledstring
>> API from the OpenRGB folks: https://openrgb.org
>>
>> Maybe they already have a nice abstraction to deal with different
>> kind of effects which we can copy for the kernel API ?
> I opened an issue regarding this: https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916

Great, thank you.

Regards,

Hans




