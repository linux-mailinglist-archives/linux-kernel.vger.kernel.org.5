Return-Path: <linux-kernel+bounces-136665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42789D6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A4A1C2135A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3C85649;
	Tue,  9 Apr 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4XIOmbT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0A81ABA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657771; cv=none; b=UYQ4dtjFXLUdyoHS9iY1x5NAtdcSMGcnDgbBEl2hMYUrO6hEn25RdVPRcFcYFLz4lN9Fu7qg6/hyKP55TbNX0UQ7z15uZwdqPbHCvOQDAaXdpFnTNIGeY7VcxePo+O91gjt2Xm7wvoVwycJbgfdcCgF8asO69m4vn3+TUSbjL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657771; c=relaxed/simple;
	bh=SBYSZeuDuqQ415H7h7fcMx9tUPGz1q1BRTWKuCD0r00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwgPjOaPx6UXtgbJ7HgmpYt7EJFaFIxyApzRssazO/A+Aoez9uij70ajQR3742aCkThK0K+dEwxY8ChlDG65hatHocK2Lcjh07NB+/YgHClaUy/yycq++A5Hd6F2ni8iV85ZiaW0nK0cj4Q+V4fQEqh2EdN16woCPjUcbilkUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4XIOmbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712657768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMeePPemknPpIlqp3R4BbTMH+iMIzQbR2BJB446CC8o=;
	b=Q4XIOmbThfheYW++kc+F06kcjrNGC8tP3rPxSAy1Jnjm96OM3TftClT511J1tuHS120RxF
	3OjZ7umHEIlvIikhdAl9w2oJJN3+6bK4V8n2nWUN8roey9fIowdhvfg4GXgDVsI695uX14
	+52kyPCSO4Lo7pLemSNcpWDZUaqvNGM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-CiforiR5PK6WC5J7Vk355g-1; Tue, 09 Apr 2024 06:16:07 -0400
X-MC-Unique: CiforiR5PK6WC5J7Vk355g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b00fc137so226746566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657766; x=1713262566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMeePPemknPpIlqp3R4BbTMH+iMIzQbR2BJB446CC8o=;
        b=rS06hWPRXreFHjgrmr1UoU37exXLyJLAG5ohpCtJkMRqxNrMykPmPFhdTJJERLz/pI
         O9BMglGDPEoRPXoXyvgFHXUFv1O+faEAop6HOJW0xcn6/e7y+Xq6UQ9S9NESm37RafaQ
         fGVAoA52FUk/2gXwYnqJuh2nDMciE9L3oYFvNz5eEnsWB2/MBvlfNkAT0KXe6zUryzme
         AfxXN9ABvWVI1QLPgUulJ5iYm2sgcXYZUNmyfHuRQYdPG38uZ7CGF2FTMGvgQ6u4zblq
         ILqxYHNURZrS41FlORk+8ZL0z42nf6ZiLnYa3l0PFEQUMSKGhqaRk0cLjdGTliu20kUD
         HPDw==
X-Forwarded-Encrypted: i=1; AJvYcCV0uTswXaqoGG+i8GOeXv39175EGIgPulDZfLCNeFvoCtmeaK4MyfF1lxQIx37+wxKqHpIJf9Bll1zdfv2y7bJ/MJ9GgMpkfYTwLijD
X-Gm-Message-State: AOJu0Yw5Q1XfntqEIL5xXOvf6CA4KJfrNWahUc3u+CgvKyqYitpRSeh/
	6+JPgeIpeokuqDptFSZGzPC3haATnzQCY1OyU3NdCD1e9JzPY/SsNplhw2ermY34Z3Cw6G5NUq7
	XyX8ptwQU9mR3HnBOjygxk7l8fOqgLBdUKHIzGVCODLnEmm3qWxq+JlRLPvvtmw==
X-Received: by 2002:a17:907:980c:b0:a4e:e61:b5fa with SMTP id ji12-20020a170907980c00b00a4e0e61b5famr10411689ejc.15.1712657766194;
        Tue, 09 Apr 2024 03:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNC0SM3GLkJe2l6pl8yMpUjris79RVE1HgtJTa1aHHLO8ip+nVXtFxc8Q0SGPPZICM3onLkQ==
X-Received: by 2002:a17:907:980c:b0:a4e:e61:b5fa with SMTP id ji12-20020a170907980c00b00a4e0e61b5famr10411673ejc.15.1712657765872;
        Tue, 09 Apr 2024 03:16:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lg11-20020a170906f88b00b00a4e2db8ffdcsm5493019ejb.111.2024.04.09.03.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 03:16:05 -0700 (PDT)
Message-ID: <dded171e-4cb4-47cc-aece-d5afd229060a@redhat.com>
Date: Tue, 9 Apr 2024 12:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info
 keycodes
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nitin Joshi1 <njoshi1@lenovo.com>, Vishnu Sankar <vsankar@lenovo.com>,
 Peter Hutterer <peter.hutterer@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <c6427b27-3c9d-4aa4-abfa-c3588b5d9a42@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c6427b27-3c9d-4aa4-abfa-c3588b5d9a42@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 4/9/24 2:00 AM, Mark Pearson wrote:
> Hi Dmitry
> 
> On Mon, Apr 8, 2024, at 7:31 PM, Dmitry Torokhov wrote:
>> Hi Mark,
>>
>> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>>> Add support for new input events on Lenovo laptops that need exporting to
>>> user space.
>>>
>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>> Add a new keycode to allow this to be used by userspace.
>>
>> What is the intended meaning of this keycode? How does it differ from
>> the driver sending BTN_LEFT press/release twice?
> 
> Double tapping on the trackpoint is a unique event - it's not the same as BTN_LEFT twice. The BIOS will send a new ACPI event for it and it's not meant to be the same as mouse button clicks.

To extend a bit on this, this double-tap event is not reported through
the PS/2 trackpoint interface at all. Instead it is reported to
the OS by the ACPI hotkey notifier, which is used to report various
multi-media hotkeys and things like that, this is handled by
the thinkpad_apci driver which sofar only reports key-presses.

So there is no BTN_LEFT to report twice and if we add a BTN_LEFT
then we end up with an input_device which has a bunch of KEYs
+ BTN_LEFT but no abs/rel axis which will just confuse userspace.

We could add a second input_device which looks like a mouse
but only ever reports BTN_LEFT double-clicks I guess, but as
Mark said the intention is for this double-tap to work more
like a hotkey then a double click. Also note that regular
taps on the trackstick do nothing. Clicking the mouse buttons
of the stick involves pressing separate physical buttons between
the trackpad and the keyboard and those are reported over
the same PS/2 port as the relative motion events from the stick.

Regards,

Hans




