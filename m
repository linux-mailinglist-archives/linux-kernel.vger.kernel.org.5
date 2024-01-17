Return-Path: <linux-kernel+bounces-29153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAB8309B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F46E1C21AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1522327;
	Wed, 17 Jan 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ejyni71h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1E2231D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505206; cv=none; b=XPwCW+w6oMei9p1BSy8Bt4UeMP8MGah73uQfOuvsMB42bcb/m/+4dAhyoSUJLa/bQYJ+bGxVIPE/6H4NYjBhZJ/b50QXIgZI8/l+ShoPM+9xD/UR4tp1cWlpDyHb3QF3vbj5XeBbK1rBDBKHLPta69KAEHDz4AzcOC9zyOc8UBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505206; c=relaxed/simple;
	bh=uol4Wkl6bT4uLERdk8KIHsyvO2BIE5KygFwHXUQrR3w=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=kCxPtb9RCrj2ek20mM8MxnyRiPT+NNNB8W0R6rj/QFTLsaQ363CK1AWSy9tc3Blzy6msbyeUbVJ+1HY8tJRMHP6eXp/vsmUwApDPerBGsVojmTe1jQlarIt4rqkxBrmUg1CMv5OxMwwXV0In5oNUJ6+7WZdQWu0ODcE3WnztrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ejyni71h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705505203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3igXpz0jLYNpd2wAR8zuEeppoJCF74coEtZektTXQ8=;
	b=Ejyni71h1teKSxaSBDnwrmjTunCJKUWCv/xM22ULYyXSKt+CWROijveg9261ATeYgIdLFB
	ZyhoH5I3m5rIXNY7qysXar5QbuT2ysOV+CHXObZMn16YDNbQ7W0XYQwKe2ekXfDciO5CrX
	7YuOvvRO0iUvRN7EfFx9HbAZNeOEyjw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-xy0M_y_hOgGUfY0eOWQx0Q-1; Wed, 17 Jan 2024 10:26:40 -0500
X-MC-Unique: xy0M_y_hOgGUfY0eOWQx0Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a29bb25df84so426649166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705505199; x=1706109999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3igXpz0jLYNpd2wAR8zuEeppoJCF74coEtZektTXQ8=;
        b=toDkC4S9H0gAOW1BOEW6c8VYcvmyuky+CwWx/H7PKG5xyrymi2QaKqRB12d8oWGMdg
         2Jm+FedZ+GMPYpvt82AUrx/CPXY3z+wETazOkZOB32t4rlxlIxPBbpc8K7vs/Dy9pDhu
         WF73kxaY5Uhxhppd8/1taWd+ylP2HZMoNjri4o9aN3jXlibEqPN+NQ/FKAY2whBPL0ij
         jDI3qo2mrdWojtIMVG83dHTWh8dFUQpa/Sldqt75/9XczkfbKLMGroXssh446xmMWys/
         CJJ0/k3BfSx8/1KfELBD8zC1l9OScJ9XMeyq651bC/d8BDBLXcO4nrQ2kZIBHDBYySOj
         FL4Q==
X-Gm-Message-State: AOJu0Yz8lFbxd5z4QmaqOa4VqsxNtNxztxwpLBnWy8fOBrzuBoDI1XSi
	rY3WdvGOUK2Zoz+ByLKh8Vf1k6S9RFFS3eKeQOIuSyvhFW48vnlwBmJAWmaBm6Ib+pkCQw1Pfjs
	kpzZzqcG45mvoBiFjJbPNrS0lHEnmaR+m
X-Received: by 2002:a17:906:4756:b0:a1f:a0f1:ec60 with SMTP id j22-20020a170906475600b00a1fa0f1ec60mr4657351ejs.14.1705505199161;
        Wed, 17 Jan 2024 07:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzGC4HE1nk4PyXljKqlVraEewSzZEQUd0rZqD6w/i823EW7w1nYdsR7qSI/BGtJg49PIweYg==
X-Received: by 2002:a17:906:4756:b0:a1f:a0f1:ec60 with SMTP id j22-20020a170906475600b00a1fa0f1ec60mr4657338ejs.14.1705505198728;
        Wed, 17 Jan 2024 07:26:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906c18600b00a2a9ddd15b8sm8023610ejz.173.2024.01.17.07.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:26:38 -0800 (PST)
Message-ID: <8d77246d-ec1f-4106-8a33-b6e93bdbab45@redhat.com>
Date: Wed, 17 Jan 2024 16:26:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US, nl
To: Werner Sembach <wse@tuxedocomputers.com>, Pavel Machek <pavel@ucw.cz>,
 Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lee Jones
 <lee@kernel.org>, linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
 <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Werner,

Once again, sorry for the very slow response here.

On 11/27/23 11:59, Werner Sembach wrote:
> Hi Hans,
> 
> Am 22.11.23 um 19:34 schrieb Hans de Goede:
>> Hi Werner,
> [snip]
>>>>> Another idea I want to throw in the mix:
>>>>>
>>>>> Maybe the kernel is not the right place to implement this at all. RGB stuff is not at all standardized and every vendor is doing completely different interfaces, which does not fit the kernel userpsace apis desire to be uniformal and fixed. e.g. Auxdisplay might fit static setting of RGB values, but it does not fit the snake-effect mode, or the raindrops mode, or the 4-different-colors-in-the-edges-breathing-and-color-cycling mode.
>>>>>
>>>>> So my current idea: Implement these keyboards as a single zone RGB kbd_backlight in the leds interface to have something functional out of the box, but make it runtime disable-able if something like https://gitlab.com/CalcProgrammer1/OpenRGB wants to take over more fine granular control from userspace via hidraw.
>>>> That sounds like a good approach to me. We are seeing the same with game controllers where steam and wine/proton also sometimes use hidraw mode to get access to all the crazy^W interesting features.
>>>>
>>>> That would mean that all we need to standardize and the kernel <-> userspace API level is adding a standard way to disable the single zone RGB kbd_backlight support in the kernel.
>>> I would suggest a simple "enable" entry. Default is 1. When set to 0 the kernel driver no longer does anything.
>> I'm not in favor of using "enable" as sysfs attribute for this,
>> I would like to see a more descriptive name, how about:
>>
>> "disable_kernel_kbd_backlight_support"
>>
>> And then maybe also have the driver actually unregister
>> the LED class device ?
>>
>> Or just make the support inactive when writing 1 to
>> this and allow re-enabling it by writing 0?
> 
> Unregistering would mean that it can't be reenabled without module reload/reboot?

Yes.

> I would prefer that the userspace driver could easily give back control to the leds interface.

Hmm, the problem here is that leaving a non-working LED class device
behind may confuse things like upower.

So maybe the disable_kbd_backlight_support sysfs attr should
not sit under /sys/class/leds/foobar::kbd_backlight, but rather
it should sit under the sysfs dir of the parent-device ?

So if we are talking [USB|I2C]-HID keyboards and userspace
using hidraw to takeover kbd_backlight control through,
then have "disable_kbd_backlight_support" sit under
/sys/bus/hid/devices/0003:xxxx:xxxx.xxxx/disable_kbd_backlight_support

and then re-register the LED class device for the keyboard
when 0 gets written to disable_kbd_backlight_support ?

That seems better to me then leaving a non-working LED
class device behind and this will not require any changes
to the LED subsystem.


>>> Questions:
>>>
>>> - Should the driver try to reset the settings to boot default? Or just leave the device in the current state? With the former I could see issues that they keyboard is flashing when changing from kernelspace control to userspace control. With the later the burden on bringing the device to a know state lies with the userspace driver.
>> My vote would go to leave the state as is. Even if the hw
>> does not support state readback, then the userspace code
>> can readback the state before writing 1 to
>> "disable_kernel_kbd_backlight_support"
> ack
>>
>>> - Should this be a optional entry that only shows up on drivers supporting it, or could this implemented in a generic way affecting all current led entries?
>> IMHO this should be optional. If we go with the variant
>> where writing 1 to "disable_kernel_kbd_backlight_support"
>> just disables support and 0 re-enables it then I guess
>> we could have support for this in the LED-core, enabled
>> by a flag set by the driver.
>>
>> If we go with unregistering the led class device,
>> then this needs to be mostly handled in the driver.
>>
>> Either way the kernel driver should know about this even
>> if it is mostly handled in the LED core so that e.g.
>> it does not try to restore settings on resume from suspend.
> 
> So a generic implementation would still require all current led drivers to be touched?
> 
> For the sake of simplicity I would then prefer the optional variant.

See above, I think we need to put the sysfs-attr to disable
the kernel's builtin kbd-backlight support in the parents
sysfs-dir and then actually unregister the LED class device,
this way we don't need any LED subsytem changes at all.

>>> - I guess UPower integration for the userspace driver could be archived with https://www.kernel.org/doc/html/latest/leds/uleds.html however this limited to brightness atm, so when accent colors actually come to UPower this would also need some expansion to be able to pass a preferred color to the userspace driver (regardless of what that driver is then doing with that information).
>> Using uleds is an interesting suggestion, but upower atm
>> does not support LED class kbd_backlight devices getting
>> hot-plugged. It only scans for them once at boot.
>>
>> Jelle van der Waa (a colleague of mine, added to the Cc)
>> has indicated he is interested in maybe working on fixing
>> this upower short-coming as a side project, once his
>> current side-projects are finished.
> Nice to hear.
>>
>>> On a different note: This approach does currently not cover the older EC controlled 3 zone keyboards from clevo. Here only the kernel has access access to the device so the kernel driver has to expose all functionality somehow. Should this be done by an arbitrarily designed platform device?
>> Interesting question, this reminds there was a discussion
>> about how to handle zoned keyboards using plain LED class
>> APIs here:
>>
>> https://lore.kernel.org/linux-leds/544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com/
>>
>> Basically the idea discussed there is to create
>> separate multi-color LED sysfs devices for each zone,
>> using :rgb:kbd_zoned_backlight-xxx as postfix, e.g. :
>>
>>   :rgb:kbd_zoned_backlight-left
>>   :rgb:kbd_zoned_backlight-middle
>>   :rgb:kbd_zoned_backlight-right
>>   :rgb:kbd_zoned_backlight-wasd
>>
>> As postfixes for the 4 per zone LED class devices
>> and then teach upower to just treat this as
>> a single kbd-backlight for the existing upower
>> DBUS API and maybe later extend the DBUS API.
>>
>> Would something like this work for the Clevo
>> case you are describing?
> 
> Not entirely as some concept for the special modes would still be required.

Right, that can be done with some custom sysfs attr added
to the LED class device, like how dell-laptop.c sets
the .groups member of the "dell::kbd_backlight"
"struct led_classdev kbd_led" to add some extra
sysfs_attr to configure the timeout after which
the kbd_backlight automatically turns off when
no keys are pressed.

> Also it would be nice to be able to set the whole keyboard with a singular file access so that the keyboard changes at once and not zone by zone.

That is an interesting point. This could be implemented
by adding an "enable_atomic_commit" sysfs attr to
all 4:

   :rgb:kbd_zoned_backlight-left
   :rgb:kbd_zoned_backlight-middle
   :rgb:kbd_zoned_backlight-right
   :rgb:kbd_zoned_backlight-wasd

LED class devices, which is backed by only
1 variable in the kernel (so changing it
in one place changes it everywhere) and
then also have a "commit" sysfs attr and
writing say "1" to that will then commit
all changes at once.

So normally changes are still applied directly
(for compatibility with the usual sysfs API),
but then when "enable_atomic_commit" is set to 1,
writes only update in kernel variables and then
once "commit" is written all changes are send
out in 1 go.

I think we had the same issue where there was
a single WMI call to change all zones at once
(and having some sort of atomic API was desirable)
the last time the suggestion to use 4 LED class
devices for zoned kbds:

   :rgb:kbd_zoned_backlight-left
   :rgb:kbd_zoned_backlight-middle
   :rgb:kbd_zoned_backlight-right
   :rgb:kbd_zoned_backlight-wasd

came up, so we could start a new:

Documentation/ABI/testing/sysfs-class-led-zoned-kbd-backlight

document extending the standard:

Documentation/ABI/testing/sysfs-class-led

which documents both using the:

   :rgb:kbd_zoned_backlight-left
   :rgb:kbd_zoned_backlight-middle
   :rgb:kbd_zoned_backlight-right
   :rgb:kbd_zoned_backlight-wasd

suffixes there, as well as document some sort
of atomically change all 4 zones at once API.

Werner, if this sounds like something which would
work for you, then it would probably be best to
first submit a RFC patch introducing a:

Documentation/ABI/testing/sysfs-class-led-zoned-kbd-backlight

and then first discuss that with the LED subsys
maintainers, so that we have buy-in from the LED
subsys maintainers before you start actually
implementing this.

I'll reply to your "I also stumbled across a new Problem"
in another reply as it seems best to start a separate
thread for this.

Regards,

Hans



