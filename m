Return-Path: <linux-kernel+bounces-117713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E888AEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F346325BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C156740;
	Mon, 25 Mar 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpaoez9N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACD129A95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391451; cv=none; b=lGrWBXheO9rFW6DreZMlYWNyPbqVn6DAVhyOi2JCL0IDvAeWSsMeW6uee43yDw/KNS79vhgwfcZQUIg3YDTTvdjr1I0KvcZSLBSY/nb6iaiuJ95V1zPdsUk2k72bu2MVsy+RiQzb2O6WslUsWEL633Cug6aVGEbw5IhINWTqsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391451; c=relaxed/simple;
	bh=/qDr5CfYRfXblCGhvxJhUm6s87seYNx14MvQ9EkP4hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRG5BulpUzVKKilQ0GEFkK0uOXsASRnJ8nfoYSsD7Kx5/LV2ZcycMKOmTzygP8pQpS8IAmqkALWrU/+PjZLq7o9ggADqJwKLFSOA8YyLQKqnmrCToXgGqmDrhdKoaxht4uIy6TKot6QpQo2GRQ1NNEyivDhEttdTE+A9yu3JUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpaoez9N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711391448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV/QRJVNAzreC0RxpMt2De/fAsHXJzRLwlye2Tm9sLU=;
	b=gpaoez9Ndf1E5Q+X7BPbUpurdff5DvaUcEyWsMTxbyp6ulH94VeKQsfDQdUr/2DBDqwm+j
	OwPsDlRRAUwZQMtsWMKLltkshhdEZ0pKWF6b2iARijojGl2LemiyT7p7qrgv8NYf3lDqQJ
	ibGyCiqIy7PzUluZ7rAvG/CxxIVpg6I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-5E_GZ0i0P-Wom61OnGOLlA-1; Mon, 25 Mar 2024 14:30:47 -0400
X-MC-Unique: 5E_GZ0i0P-Wom61OnGOLlA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a46d59152c9so357607566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391446; x=1711996246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FV/QRJVNAzreC0RxpMt2De/fAsHXJzRLwlye2Tm9sLU=;
        b=PiLtbhUUCQ85cjjBMj2Z9bTJN5ces0yQWLkdcHKyMeFUx0fy2808hS0Awi5DyjFpyE
         jUQg80JpdIje51O2pIodHew84D5L2wA4clcOxV9xHQXWa7fym7NTUIL9jH6aE9+mXou7
         jAS0JhWfh2NJAz42CnPUwuj557qYA8Yi0Jw1eB04C9eGaeIPXe1NGwEt3W39bJxFDDNk
         rTJvolm45acHBjzKaD77L7qJM8SAYQHce8J4FoXyV5lEvXYgFbxN9GyrXX/wUxuQjhkV
         7UOl/pO+p+WJ9QWg04sVUov6k/SDP40yIY0hrg06J7uTO7HRWzt91JGzpUtd7C3C1gJ9
         L1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OhpzARwZiyF8sbCz7cFr2pKgL8za4glpEhde+3MTJ1QuZ+Tct/5Dnqua2WwGwEEklt4cH2Sw0bhocR9TbWqId9dHij5hVly0JhKf
X-Gm-Message-State: AOJu0YzdpXc0UB2ff4DxSKA/ALYqB/tzULLohMePvp/SSIbXtlyZUt1s
	rIZwBqTaylsNMPDguqUuroaUREGOFQX9WVKzl773EgYg7SsA3lYsnS32Z6Unex+ZB3STuiDPs3a
	56Z83RmUFe1xIyD0C/iMeZP94qyjyZhBIcmtoZiibjsCHjiS9hsJYu0Jng4LVrg==
X-Received: by 2002:a17:906:944:b0:a46:f538:4009 with SMTP id j4-20020a170906094400b00a46f5384009mr5006151ejd.66.1711391446123;
        Mon, 25 Mar 2024 11:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELog0XHhcgjlEZwBAqYwQIVc82WxJPI+KaVvOgMDU/eRDOYf4op7y4OZu/xq+Ri6SUkNi0FQ==
X-Received: by 2002:a17:906:944:b0:a46:f538:4009 with SMTP id j4-20020a170906094400b00a46f5384009mr5006128ejd.66.1711391445737;
        Mon, 25 Mar 2024 11:30:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00a47a33b3aa2sm1785445eja.157.2024.03.25.11.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:30:45 -0700 (PDT)
Message-ID: <fcf4dd53-f461-4c2e-8fbe-50b50e4e6797@redhat.com>
Date: Mon, 25 Mar 2024 19:30:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: In kernel virtual HID devices (was Future handling of complex RGB
 devices on Linux v3)
To: Werner Sembach <wse@tuxedocomputers.com>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
References: <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com>
 <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
 <siebkhaauocqkuox73q2e5p2mbsyc7j4gvpzfvt4c3gvncdpap@oxh5pp4gxpuo>
 <870cca8a-1a1b-4d17-874e-a26c30aca2bf@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <870cca8a-1a1b-4d17-874e-a26c30aca2bf@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Werner,

On 3/25/24 5:48 PM, Werner Sembach wrote:
> Hi Benjamin,
> 
> Am 25.03.24 um 16:56 schrieb Benjamin Tissoires:
>> On Mar 25 2024, Hans de Goede wrote:
>>> +Cc: Bentiss, Jiri
>>>
>>> Hi Werner,
>>>
>>> On 3/20/24 12:16 PM, Werner Sembach wrote:
>>>> Hi Hans and the others,
>>>>
>>>> Am 22.02.24 um 14:14 schrieb Werner Sembach:
>>>>> Hi,
>>>>>
>>>>> Thanks everyone for the exhaustive feedback. And at least this thread is a good comprehesive reference for the future ^^.
>>>>>
>>>>> To recap the hopefully final UAPI for complex RGB lighting devices:
>>>>>
>>>>> - By default there is a singular /sys/class/leds/* entry that treats the device as if it was a single zone RGB keyboard backlight with no special effects.
>>>>>
>>>>> - There is an accompanying misc device with the sysfs attributes "name", "device_type",  "firmware_version_string", "serial_number" for device identification and "use_leds_uapi" that defaults to 1.
>>>>>
>>>>>      - If set to 0 the /sys/class/leds/* entry disappears. The driver should keep the last state the backlight was in active if possible.
>>>>>
>>>>>      - If set 1 it appears again. The driver should bring it back to a static 1 zone setting while avoiding flicker if possible.
>>>>>
>>>>> - If the device is not controllable by for example hidraw, the misc device might also implement additional ioctls or sysfs attributes to allow a more complex low level control for the keyboard backlight. This is will be a highly vendor specific UAPI.
>>>> So in the OpenRGB issue thread https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/dynamic-lighting-devices aka HID LampArray was mentioned. I did dismiss it because I thought that is only relevant for firmware, but I now stumbled upon the Virtual HID Framework (VHF) https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/virtual-hid-framework--vhf- and now I wonder if an equivalent exists for Linux? A quick search did not yield any results for me.
>>> Oh, interesting. I did not know about the HID LampArray API.
>>>
>>> About your question about virtual HID devices, there is uHID,
>>> but as the name suggests this allows userspace to emulate a HID
>>> device.
>>>
>>> In your case you want to do the emulation in kernel so that you
>>> can translate the proprietary WMI calls to something HID LampArray
>>> compatible.
>>>
>>> I guess you could do this by defining your own HID transport driver,
>>> like how e.g. the i2c-hid code defines 1 i2c-hid parent + 1 HID
>>> "client" for each device which talks HID over i2c in the machine.
>>>
>>> Bentiss, Jiri, do you have any input on this. Would something like
>>> that be acceptable to you (just based on the concept at least) ?
>> I just read the thread, and I think I now understand a little bit what
>> this request is :)
>>
>> IMO working with the HID LampArray is the way forward. So I would
>> suggest to convert any non-HID RGB "LED display" that we are talking
>> about as a HID LampArray device through `hid_allocate_device()` in the
>> kernel. Basically what you are suggesting Hans. It's just that you don't
>> need a formal transport layer, just a child device that happens to be
>> HID.
>>
>> The next question IMO is: do we want the kernel to handle such
>> machinery? Wouldn't it be simpler to just export the HID device and let
>> userspace talk to it through hidraw, like what OpenRGB does?
> 
> That's already part of my plan: The kernels main goal is to give devices a LampArray interface that don't have one already (e.g. because they are no HID devices to begin with).
> 
> The actual handling of LampArray will happen in userspace.
> 
> Exception is that maybe it could be useful to implement a small subset of LampArray in a generic leds-subsystem driver for backwards compatibility to userspace applications that only implement that (e.g. UPower). It would treat the whole keyboard as a single led.
> 
>>
>> If the kernel already handles the custom protocol into generic HID, the
>> work for userspace is not too hard because they can deal with a known
>> protocol and can be cross-platform in their implementation.
>>
>> I'm mentioning that cross-platform because SDL used to rely on the
>> input, LEDs, and other Linux peculiarities and eventually fell back on
>> using hidraw only because it's way more easier that way.
>>
>> The other advantage of LampArray is that according to Microsoft's
>> document, new devices are going to support it out of the box, so they'll
>> be supported out of the box directly.
>>
>> Most of the time my stance is "do not add new kernel API, you'll regret
>> it later". So in that case, given that we have a formally approved
>> standard, I would suggest to use it, and consider it your API.
> 
> The only new UAPI would be the use_leds_uapi switch to turn on/off the backwards compatibility.

Actually we don't even need that. Typically there is a single HID
driver handling both keys and the backlight, so userspace cannot
just unbind the HID driver since then the keys stop working.

But with a virtual LampArray HID device the only functionality
for an in kernel HID driver would be to export a basic keyboard
backlight control interface for simple non per key backlight control
to integrate nicely with e.g. GNOME's backlight control.

And then when OpenRGB wants to take over it can just unbind the HID
driver from the HID device using existing mechanisms for that.

Hmm, I wonder if that will not also kill hidraw support though ...
I guess getting hidraw support back might require then also manually
binding the default HID input driver.  Bentiss any input on this?

Background info: as discussed earlier in the thread Werner would like
to have a basic driver registering a /sys/class/leds/foo::kbd_backlight/
device, since those are automatically supported by GNOME (and others)
and will give basic kbd backlight brightness control in the desktop
environment. This could be a simple HID driver for
the hid_allocate_device()-ed virtual HID device, but userspace needs
to be able to move that out of the way when it wants to take over
full control of the per key lighting.

Regards,

Hans







> 
> The control flow for the whole system would look something like this:
> 
> - System boots
> 
>     - Kernel driver initializes keyboard (maybe stops rainbowpuke boot effects, sets brightness to a default value, or initializes a solid color)
> 
>     - systemd-backlight restores last keyboard backlight brightness
> 
>     - UPower sees sysfs leds entry and exposes it to DBus for DEs to do keyboard brightness handling
> 
> - If the user wants more control they (auto-)start OpenRGB
> 
>     - OpenRGB disables sysfs leds entry via use_leds_uapi to prevent double control of the same device by UPower
> 
>     - OpenRGB directly interacts with hidraw device via LampArray API to give fine granular control of the backlight
> 
>     - When OpenRGB closes it should reenable the sysfs leds entry
> 
> - System shutdown
> 
>     - Since OpenRGB reenables the sysfs leds entry, systemd-backlight can correctly store a brightness value for next boot
> 
> Regards,
> 
> Werner
> 
>>
>> Side note to self: I really need to resurrect the hidraw revoke series
>> so we could export those hidraw node to userspace with uaccess through
>> logind...
>>
>> Cheers,
>> Benjamin
> 


