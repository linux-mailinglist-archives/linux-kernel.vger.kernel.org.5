Return-Path: <linux-kernel+bounces-29239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EB830B78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A191F21512
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8D224E7;
	Wed, 17 Jan 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZVZV7jZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B50219F0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510260; cv=none; b=kJDsQqsmy2hS+m45l2VX775qbzTn9THc/ISCleWrPUHgPf7kja5X5u/7YPGl5bJzbKZYpDC1mQRPQ+99RoERu+Vaqk4qAILcw8O6EpNWfbN1E7JbBWUkpFF/Nc62WSEQfqoraz8PGlhHb7E67aX2qaI1O5CN6V/CI4EVab9mnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510260; c=relaxed/simple;
	bh=bj/hs96SoSD6M7wdLl2YH/DmMdRpKQy3s5ii6iFbQ0o=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=GFtxfF7jOi98hup6gCvX1HB6feZCXJzFkEJfGtEtlquHS1oZNEVPsXWetK/RzwKyPvvnZ6ZILg08DPY/2b970qEAGFXAvokfcyYm07BXcsoAezB1fIxaV89vbOU2DYhJQuNoG8SfuAmBjG+fodKlqc00MW1vkJ1H7lLmoM3GmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZVZV7jZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705510257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnc6dQVA3dNi3pJUCdpIqw7wvP4lwyFls8kLU3/xDnc=;
	b=IZVZV7jZvnKcTXBLqtNcf8A+tkFsBXe+LjxN3wekComU+jC+xyGPzAYt8PzHwXWmDga67n
	0dSBoDttdOZVbci6rZ9/cN24sYVFj+XoCfSUPCfD0tlpLPPi70N/6utF9SKj6+/GAsK91w
	WBbrSX2EvWFL3LNmxE4SRcHeRPsmubE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-KbnZzC_LMkmGcODp2BD6gg-1; Wed, 17 Jan 2024 11:50:55 -0500
X-MC-Unique: KbnZzC_LMkmGcODp2BD6gg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2e52ff6952so98922866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705510254; x=1706115054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnc6dQVA3dNi3pJUCdpIqw7wvP4lwyFls8kLU3/xDnc=;
        b=lu7TjpqrPxh14rirnpCDVShg1p77/sKkkc3rCBhH1bH2bI5Bw+Y1x45sqK6P9DpRyi
         q8tp9ZfZVr3gUQxalF5gOO3pd8iNoyHC2DYi24eyTF+gm2qh5El+jcjMuQMB8kUfAJgq
         mrvK4FjKimmOzylys0HbwsOvq81zm9JlA3QJfE8k1PhgBW5W0Qg4PcxtvpmfEjzeGoNS
         q0OWIw3AqL1WJKG8fDbW3E3mS8Wmas3wxStJkOK84pt9Bx+2MuqZUYPcV2Mcqeeu9I2d
         3cYaWKd966WLsiceOIGmTT6yi6zvJFVCse61jvM+Ry+5wNX9yB3NbP3egFRFWTOmYuLM
         q1iQ==
X-Gm-Message-State: AOJu0YyVWFKXTokf5XCOsZk9DC9tY8CMgiD9L+Ske7v3jxjl72U+RSDd
	Lge9ev1iW5EBDbAoD3a2b9jBkzLxit6Tv+Bvc7l36iIpGPTZSxfl4I2R3UAKkQMS5IDbOfzWIBt
	o7ZnNmNdv7dtuALfb8tIUvpePXCIw9iJP
X-Received: by 2002:a17:907:c307:b0:a2d:d128:fbb8 with SMTP id tl7-20020a170907c30700b00a2dd128fbb8mr3755972ejc.124.1705510253799;
        Wed, 17 Jan 2024 08:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeQWD5jgD8PYE8L0xWO+esoquWgfev7sv2x2VEZdl70xPLAE5sWQx6nUbFSZipIQNLmXnyPw==
X-Received: by 2002:a17:907:c307:b0:a2d:d128:fbb8 with SMTP id tl7-20020a170907c30700b00a2dd128fbb8mr3755959ejc.124.1705510253429;
        Wed, 17 Jan 2024 08:50:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kq10-20020a170906abca00b00a2e98f4c687sm1737550ejb.164.2024.01.17.08.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 08:50:52 -0800 (PST)
Message-ID: <3040290f-9b26-4fd3-8e64-a03ec59921d6@redhat.com>
Date: Wed, 17 Jan 2024 17:50:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Userspace API for per key backlight for non HID (no hidraw)
 keyboards
Content-Language: en-US, nl
To: Werner Sembach <wse@tuxedocomputers.com>, Pavel Machek <pavel@ucw.cz>,
 Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>, Armin Wolf <W_Armin@gmx.de>
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

Hi All,

On 11/27/23 11:59, Werner Sembach wrote:

<snip>

> I also stumbled across a new Problem:
> 
> We have an upcoming device that has a per-key keyboard backlight, but does the control completely via a wmi/acpi interface. So no usable hidraw here for a potential userspace driver implementation ...
> 
> So a quick summary for the ideas floating in this thread so far:
> 
> 1. Expand leds interface allowing arbitrary modes with semi arbitrary optional attributes:
> 
>     - Pro:
> 
>         - Still offers all default attributes for use with UPower
> 
>         - Fairly simple to implement from the preexisting codebase
> 
>         - Could be implemented for all (to me) known internal keyboard backlights
> 
>     - Con:
> 
>         - Violates the simplicity paradigm of the leds interface (e.g. with this one leds entry controls possible multiple leds)

So what you are suggesting here is having some way (a-z + other sysfs attr?)
to use a single LED class device and then extend that to allow setting all
keys ?

This does not seem like a good idea to me and this will also cause issues
when doing animations in software, since this API will likely be slow.

And if the API is not slow, then it will likely involve some sort
of binary sysfs file for setting multiple keys rather then 1
file per key which would break the normal 1 file per setting sysfs
paradigm.

> 2. Implement per-key keyboards as auxdisplay
> 
>     - Pro:
> 
>         - Already has a concept for led positions

With a "concept" you mean simple x,y positioning or is
there something more advanced here that I'm aware of ?

>         - Is conceptually closer to "multiple leds forming a singular entity"
> 
>     - Con:
> 
>         - No preexisting UPower support
> 
>         - No concept for special hardware lightning modes
> 
>         - No support for arbitrary led outlines yet (e.g. ISO style enter-key)

Hmm, so there is very little documentation on this and what
docs there is: Documentation/admin-guide/auxdisplay/cfag12864b.rst
as well as the example program how to uses this suggests that
this is using the old /dev/fb# interface which we are sorta
trying to retire.


> 3. Implement in input subsystem
> 
>     - Pro:
> 
>         - Preexisting concept for keys and key purpose
> 
>     - Con:
> 
>         - Not in scope for subsystem
> 
>         - No other preexisting light infrastructure

Dmitry actually recently nacked the addition of
a LED_MIC_MUTE define to include/uapi/linux/input-event-codes.h
which was intended to be able to allow the input LED support
with standard HID mic-mute leds (spk-mute is already supported
this way).

Dmitry was very clear that no new LEDs must be added and
that any new LED support should be done through the LED
subsytem, so I do not think that something like this
is going to fly.


> 4. Implement a simple leds driver only supporting a small subset of the capabilities and make it disable-able for a userspace driver to take over
> 
>     - Pro:
> 
>         - Most simple to implement basic support
> 
>         - In scope for led subsystem simplicity paradigm
> 
>     - Con:
> 
>         - Not all built in keyboard backlights can be implemented in a userspace only driver

Right, so this is basically what we have been discussing in the other
part of the thread with the:

/sys/bus/hid/devices/0003:xxxx:xxxx.xxxx/disable_kbd_backlight_support

proposal to unregister the kernel's LED class device and then
allow userspace to do whatever it wants through /dev/hidraw
without the kernel also trying to access the backlight
functionality at the same time.

AFAIK there already is a bunch of userspace support for
per key addressable kbd RGB backlights using hidraw support,
so this way we can use the momentum / code of these existing
projects, at least for existing hidraw keyboards and adding
support for:

/sys/bus/hid/devices/0003:xxxx:xxxx.xxxx/disable_kbd_backlight_support

to these existing projects should be simple.

Yet this will not work for your mentioned "control completely
via a wmi/acpi interface". Still I think we should go the same
route for those adding a misc-char device or something like
that to allow making WMI calls from userspace (like Windows
can do). Maybe with an allow list per GUID to only allow
specific calls, so that we can avoid possible dangerous calls.

Armin Wolf recently became the WMI bus maintainer.

Armin, we are discussing how to deal with (laptop) keyboards
which have a separate RGB LED per key and how to control
those LEDs.

So far per key addressable keyboard backlighting has always
been HID based, so any existing support is just userspace
based using /dev/hidraw. In my experience the problem with
supporting gaming peripherals is that there is interest in it,
but not really enough interest to keep a sustained momentum
behind projects, especially not when it comes to taking code
from a fun weekend hack to upstreaming them into bigger
projects like the kernel.

So I would like to offer some sort of easy accessible
API to userspace for accessing this, basically allowing
userspace drivers for the LED part of the keyboard which
in some cases will involve making WMI calls from userspace.

So, Armin, what do you think about a way of allowing
(filtered) WMI calls from userspace through say
a misc-char device + ioctls or something like that?

Werner atm I personally do think that option 4. from
your list is the way to go. Mainly because designing
a generic kernel API for all bells and whistles of gaming
hw is very tricky and would require a large ongoing
effort which I just don't see happening (based on
past experience).

Regards,

Hans



