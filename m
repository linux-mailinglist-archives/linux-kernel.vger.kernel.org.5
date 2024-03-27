Return-Path: <linux-kernel+bounces-120736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115788DC55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249FC1C28874
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264DC58137;
	Wed, 27 Mar 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aisG4n7F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC258224
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538315; cv=none; b=Kx0Sw1QDu7jG1Vyygp2neDUNyBP23l9nIOEsbyzJAEcqXYzpIhF7nZWAT7CHs3xB4+hbveDUdzlsEudmRzqjZ/czgD2VoIBNX99bm+XWHk4ND1ZwEMRuINw/kZzgP69PXtuxgIA4Jxh2rB8mbW0ED9ZR4MP5FQfAleNwo9fJyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538315; c=relaxed/simple;
	bh=PV6iBV3NTtZSk+xti3mU4j4ZRMotMMn3ZMUL9aGb8Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXVcMK0LUWhKopgX8ojDbjVpyX0IclGylPtkplk7+2xQLyf6n2awCi9wMlGtLndl33GgJ1zQddZ/kpJ+Da+KIN0gBzL0XXaq6XV1c7+pV4HD9iyxr0oqMDqtak0+8Affaf4pKld2tS2/JqKXO/qGs9ttYaTgiPn8TtRMVjgO80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aisG4n7F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711538312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hjUO3X0f8evhTpl93uFd1JpuHN37SYWADTl9Dfh7Ok=;
	b=aisG4n7FOM6W0rLDsDYf4f/tRJK2jqYmfm1PbMiv5MVAo+IHETX3sgUwqHtZziCRGNPpa9
	1y3Yhry4wNeblAbxwRWAqRkKhpjIgcjxVOoKbyhIa0f33zAPEcgJygq+vj012xqQ3DWeqp
	1TYG0Vj2tn4aDzsdrE/jHsRgIr608QI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-htCa_uaxNdy0TvGFu0DeqA-1; Wed, 27 Mar 2024 07:18:30 -0400
X-MC-Unique: htCa_uaxNdy0TvGFu0DeqA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4943e972d1so84205866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711538309; x=1712143109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hjUO3X0f8evhTpl93uFd1JpuHN37SYWADTl9Dfh7Ok=;
        b=XB1wVBOnWsvGU5MNMZBLnkErWYD3vWTCNGtrUSGTQYpZHEF4RAALOiIXmyqEN1UT8a
         hzar+/f01bhdMITkAtu3oSyl16mDnYeCCaTXHmoHSk40fkiuMvR9nrR0bCjzhlA66djW
         wjB7djgOxyhZITiyOe8Lr4bUhPNT4geMa9wrXceZ6hwB4gBf3iC6QduPt4EIsWpljmfL
         wbhTXPa0Y7HNlNn/v0J9+sG4gNtWRr+TRKy+mykjDvO0H4kBJXbuQX8d4nhLR8NWWoH2
         9y7sJCjR/asZ+QvHzN1mF4Pz76Gx78Zf/4YqWhVr/6vv4NZVmvahBBoKygtHMAkcdK2J
         5JXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/T9XoXz+JLM+lDQipZbaoJ9zqiPFErjUg8j3sDlA0rhBjNQGPj/wBPo51tSCY6AUWz3kF35GwgdKWXMcWZNmVc2pkhqrrFNw/OE7R
X-Gm-Message-State: AOJu0YzaPOSKIvO4YAKAnnZKVQMfVmrzKUkBtTVASXu3w51d8TEaEQ4Z
	Yi36rk4bU7jOcsKjxqEUnVbvnXYV9LvAMJEI5rwd45MEfbnN0BXYGNjfEP0Wj29eLZG03VckdFw
	wjGarXOo7A4oyCIXJCGznb/ialiVVyoGzxMpkNEnfEcziWXVczuk9f8BbTcD5Tw==
X-Received: by 2002:a17:906:5653:b0:a4a:36e4:c3f9 with SMTP id v19-20020a170906565300b00a4a36e4c3f9mr3461647ejr.7.1711538309515;
        Wed, 27 Mar 2024 04:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtL/LG14IkjrkAPVGdxcDdBbYWLCeTwDrzk3UV7Eh20ITH+X8xI4DGbIz8pRK7fB9NmOxylQ==
X-Received: by 2002:a17:906:5653:b0:a4a:36e4:c3f9 with SMTP id v19-20020a170906565300b00a4a36e4c3f9mr3461632ejr.7.1711538309182;
        Wed, 27 Mar 2024 04:18:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090663d100b00a468bcde79bsm5349484ejk.109.2024.03.27.04.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:18:28 -0700 (PDT)
Message-ID: <58014ecc-4353-494d-acfb-767e9c977abe@redhat.com>
Date: Wed, 27 Mar 2024 12:18:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
Content-Language: en-US, nl
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240324150107.976025-1-hpa@redhat.com>
 <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
 <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
 <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 12:05 PM, Andy Shevchenko wrote:
> On Wed, Mar 27, 2024 at 9:58 AM Kate Hsuan <hpa@redhat.com> wrote:
>> On Mon, Mar 25, 2024 at 3:30 AM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sun, Mar 24, 2024 at 5:02 PM Kate Hsuan <hpa@redhat.com> wrote:
> 
> ...
> 
>>>> +/* main fwnode for ktd2026 */
>>>> +static const struct software_node ktd2026_node = {
>>>> +       .name = "ktd2026"
>>>
>>> Leave a comma, this is not a terminator.
>>>
>>>> +};
>>>
>>> When I asked about the name I relied on the fact that you have an idea
>>> how it works. So, assuming my understanding is correct, this platform
>>> may not have more than a single LED of this type. Dunno if we need a
>>> comment about this.
>>
>> I'll make a comment to describe the configuration.
>> This LED controller can be configured to an RGB LED like this. Also,
>> it can be configured as three single-color (RGB) LEDs to show red,
>> green, and blue only.
>> I think the name can be "ktd2026-multi-color". Is it good for you?
> 
> My point here is that the name is static and if you have more than one
> LED in the system, the second one won't be registered due to sysfs
> name collisions. Question here is how many of these types of LEDs are
> possible on the platform? If more than one, the name has to be
> dropped. Writing this I think a comment would be good to have in any
> case.
> 
> ...
> 
>>>> +static int __init xiaomi_mipad2_init(void)
>>>> +{
>>>> +       return software_node_register_node_group(ktd2026_node_group);
>>>> +}
>>>> +
>>>> +static void xiaomi_mipad2_exit(void)
>>>
>>> __exit ?
>> No need.
>> x86-andriod-tablet is based on platform_driver and platform_device so
>> it doesn't need __exit.
>>
>> I put __exit and the compiler complained about the warning.
>> ===
>> WARNING: modpost:
>> drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
>> mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
>> -> xiaomi_mipad2_exit (section: .exit.text)
>> ===
> 
> This is interesting. Why then do we call them symmetrically?
> 
> Hans, do we need to have anything here been amended?

No this is all as expected.

The platform driver's probe() function can be __init because
the platform device is registered with the special:
platform_create_bundle() function which takes a probe() function
and the actual "struct platform_driver" does not have .probe
set at all.

Since we need to do manual cleanup on remove() however we need
a remove() callback and that does sit in the struct platform_driver
and since remove() can normally also be called on manual unbind
of the driver through sysfs it cannot be in the __exit section.

I say normally because IIRC platform_create_bundle() disables
manual unbinding but the section checking code does not know this,
all it sees is that the "struct platform_driver" is not __exit
and that it references the remove() callback and therefor the
remove() callback itself cannot be __exit.

Regards,

Hans


