Return-Path: <linux-kernel+bounces-45116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CD842BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DC6B2345B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661578B4F;
	Tue, 30 Jan 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IV1A8e7l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD378B42
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639730; cv=none; b=jVQDWv9BWbb+499aeC9daMrXb1qm2Nna4wIvo9/s5CgJH9xWhP7F20Bv9/3zG7g5OqQ+be7VkFksovqML1JH0LAv/NQWoSLeQLx9NzCI6k7VoUHi0EamReWMBC1Q5JG0zjJwwZg14wXiOo6AFAvD8OQYxmSVEvtYKVi3mUInlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639730; c=relaxed/simple;
	bh=L+aLgJvaj3T4etR2vnjdTfpWxiYKCUhJ3FdQIpZAMho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LafzbFM9p6jm7gM+Gzk71uvVVtEsyiEI92zpY9Ta2chTThvW4dLxBqbzYaRPFKDGVWJ6ZXmcx4KsEwTA2JWu9mZzuUa0gWl8ybxLG7dyMZmxGFmoGHtWHFeQB5rq9FmYSF4Bt/CaqZvji0cIWSpbJL3Mouyx8R2Zkarf/SimiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IV1A8e7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706639727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOdYfwIYC5N4y+doDXlGO/PH5vC47bZ8gY5CXDn+WTw=;
	b=IV1A8e7lta+V+Fibzja2y2xdYEWsh0PNZ8uayBYlkOUBHDldkZWbyclk4gZLElqEgH7tpn
	i9He1UAdmG41C4LTijsNqgQrSKxIjo7qcpYP0qp7LEpcGQP569KYmhIsw9BBLdRgy4ssTp
	Oxtuu4IH8zPzPIxYHI+NfcbAA34ksLg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-I0iOX9uoMKaGVyUUV90DuA-1; Tue, 30 Jan 2024 13:35:26 -0500
X-MC-Unique: I0iOX9uoMKaGVyUUV90DuA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5101e12059aso3552935e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639724; x=1707244524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOdYfwIYC5N4y+doDXlGO/PH5vC47bZ8gY5CXDn+WTw=;
        b=psR/DsteptHuH2/XtrGHYNbjIyfLCrg8Sdgk5UGWTmBmhH79ZMXnfD1PrSeKZRv2NN
         7Jk/nQD/Ya7Ufu9+SXLWDBn5X0GiE6sYIXOxik8j1FKYm4B3VVMs5oYTbetg+U03Aesr
         MMoJVh5i0llH7k9fesEdpyECBuTP0Nfpww0h1JEZxeTcJeq7mTaP/8rDYhlbgamwZK9j
         38Penebi9mYm4K2CqFCS8vpxOpvxQj6VN+6mdGiLKOH4vOCi5gzzF9pPQ0O8r6nQCk/v
         h85f8Knc2EyG8bJMoKl80i7wU+jsCfFURK3/dqtnbJRsMgsZpB3CRKWMAdfeVnWJBB26
         KdQA==
X-Gm-Message-State: AOJu0YwdVVqzKftO/hZoCZGY2FsaESp2c0ErVJvPRyRAKLO0fPnEjGty
	rxSGQIkIcebqSYqimWagemU7+whUM1LVtXex6FCqscocjsAVhg8lGX1WiAleQxHSxAjA562sUEc
	Enhu/n16+H1gZ2bbOKGvm9TPFLtiKXF5Nb2tZgjuG6UFJiK/pNWhyPX1fk3BwIwhlLuwG+A==
X-Received: by 2002:a05:6512:3118:b0:50e:937e:b00e with SMTP id n24-20020a056512311800b0050e937eb00emr6754055lfb.46.1706639724462;
        Tue, 30 Jan 2024 10:35:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0lPG90dR+JaL7x5rEP1i/zj5JCA86gd1b2bt/YA8OReAEDomZA4lkHoV4BguYPqMnadNhaQ==
X-Received: by 2002:a05:6512:3118:b0:50e:937e:b00e with SMTP id n24-20020a056512311800b0050e937eb00emr6754042lfb.46.1706639723972;
        Tue, 30 Jan 2024 10:35:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id md5-20020a170906ae8500b00a318d32ac79sm5433103ejb.146.2024.01.30.10.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 10:35:22 -0800 (PST)
Message-ID: <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
Date: Tue, 30 Jan 2024 19:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
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
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/30/24 19:09, Werner Sembach wrote:
> Hi Hans,
> 
> resend because Thunderbird htmlified the mail :/

I use thunderbird too. If you right click on the server name
and then go to "Settings" -> "Composition & Addressing"
and then uncheck "Compose messages in HTML format"
I think that should do the trick.

> Am 30.01.24 um 18:10 schrieb Hans de Goede:
>> Hi Werner,
>>
>> On 1/30/24 12:12, Werner Sembach wrote:
>>> Hi Hans,
>>>
>>> Am 29.01.24 um 14:24 schrieb Hans de Goede:
> <snip>
>>> I think that are mostly external keyboards, so in theory a possible cut could also between built-in and external devices.
>> IMHO it would be better to limit /dev/rgbledstring use to only
>> cases where direct userspace control is not possible and thus
>> have the cut be based on whether direct userspace control
>> (e.g. /dev/hidraw access) is possible or not.
> 
> Ack
> 
> <snip>
> 
>>> So also no basic driver? Or still the concept from before with a basic 1 zone only driver via leds subsystem to have something working, but it is unregistered by userspace, if open rgb wants to take over for fine granular support?
>> Ah good point, no I think that a basic driver just for kbd backlight
>> brightness support which works with the standard desktop environment
>> controls for this makes sense.
>>
>> Combined with some mechanism for e.g. openrgb to fully take over
>> control as discussed. It is probably a good idea to file a separate
>> issue with the openrgb project to discuss the takeover API.
> 
> I think the OpenRGB maintainers are pretty flexible at that point, after all it's similar to enable commands a lot of rgb devices need anyway. I would include it in a full api proposal.

Ack.

> On this note: Any particular reason you suggested an ioctl interface instead of a sysfs one? (Open question as, for example, I have no idea what performance implications both have)

sysfs APIs typically have a one file per setting approach,
so for effects with speed and multiple-color settings you
would need a whole bunch of different files and then you
would either need to immediately apply every setting,
needing multiple writes to the hw for a single effect
update, or have some sort of "commit" sysfs attribute.

With ioctls you can simply provide all the settings
in one call, which is why I suggested using ioctls.

Regards,

Hans




