Return-Path: <linux-kernel+bounces-149975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8B8A98A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68133284DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884215F308;
	Thu, 18 Apr 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGRHoOys"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955C15E804
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440089; cv=none; b=nEhdOEp5vKUzmlrGjzCsrn1hsl2sSWyKWxl4MtmUq6xIF/4T1Su5QFp+RlwM8tGnB2eoDErg9ThqVRRCFuG8gKHxs9fYZjKOyOthtssskcroJ5Y3fZI5xJO3e0k+zM0lIHyiLdkFBfXVAqAiUVtyP509Sk7+6HYrL+M/rh8WeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440089; c=relaxed/simple;
	bh=hHqENnGF5QmlzfYc/zlCjNf5/wf36TEQzNVQDbuhNz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tn3OvVkvadLU8sjmaEyhpdumA4SrA66kfdI0p9W79j8nJyEo/1Vs6EalTN5i1ICex/SLyhdTukc/9HrKy3QtB9okl+ILDb/SAzAkX+m8+Y67ZMeqg2bqlAnut9apwMhrP5PkASybTTQ41f8E17i5uip3NJHR9XzRAA+z0IaEaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGRHoOys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713440085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxee1bwLiGmeojh/o1lDYTW0rtf42vjkZkESyKbCvc4=;
	b=cGRHoOyslFngPu5GWbIt5HZPxU1ymZKv694K+Y7rtopKUnRlkH/OywDtqAX1Pclx8+Q+63
	bbaMT9Rggj9I5OmQmcY+F6GEG7/lD/MjPvw3+42p5OFutPCkerPLfzQeEmKJimBjmxUhBZ
	Zheb+KE4MI38UgRPwgEXtS7hQcAhAJI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-nPuuliPvMd2NJ3FB6NcvGQ-1; Thu, 18 Apr 2024 07:34:43 -0400
X-MC-Unique: nPuuliPvMd2NJ3FB6NcvGQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5564a2e3a5so49740266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440082; x=1714044882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxee1bwLiGmeojh/o1lDYTW0rtf42vjkZkESyKbCvc4=;
        b=EFYEscJrUsv2SjbdxiVIRQHjUhGhOU5pJuSB0AZn8FirIbKGees04X038S9izaj6L3
         r85e02X0xTA6IL0IPAzDPdlcDcLyIBaB5ClFOMS+2gnHT6bHBpkFZTe4fhVS3Mlyg6+w
         VWaqYcA8QXLyOfEYz+y8/FrFmoZSnJK66TFOCpNqhlKJkpYolgL9TzqhUf2QIwjXkLSR
         kx309vNHsGtD6LcZq8Pel19aavLkvY+NeVFrAi4XuPJ3lN2++JAulLJ+MrWr6w2Xhmsu
         S9qNCOcOsBxiByNtnwyR3i/oGKyJxb1f/sG1JRAFjdDiThX8lnbNwjyZxQd1fNwkPVEC
         v1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUn9MMF5WjHUHugTfI7Ex6XJpbyodm2qi0q4aSUIyXDtjCkD5SL+WTpjR5ilMq+vGV4+N443t2r3c0CDYudO6tJ7ATjnKaQFYKEU7Iz
X-Gm-Message-State: AOJu0YyqHiZsYNh7d4AziVa0NAUAA0ozLgK1lkwVdu3RRKUz63RpHAUP
	ElDL50tvof5Sl4XBHqS3ftqJIjpO0m29jr/USeIsP0kzdJjWYcxRwX5KOMPMi1Mi7Wu1Nsi9W8+
	pEHiID4rCfhMa+VXlSHKaDXvnC9/ctOwcpGq8uVtJFVdNR6+cx671e0fpDKyK7YFwNabOuA==
X-Received: by 2002:a17:906:1e07:b0:a55:67b9:dadc with SMTP id g7-20020a1709061e0700b00a5567b9dadcmr1474936ejj.73.1713440082447;
        Thu, 18 Apr 2024 04:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7rx4TILRxr4Gn9I0O7SjoE9LCwDvo3Xt0PfzcannkK2g3ls6y2EAszGA/8YJzhO3HTPqwZA==
X-Received: by 2002:a17:906:1e07:b0:a55:67b9:dadc with SMTP id g7-20020a1709061e0700b00a5567b9dadcmr1474922ejj.73.1713440082069;
        Thu, 18 Apr 2024 04:34:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709065f9800b00a526fcac8aesm763366eju.208.2024.04.18.04.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:34:41 -0700 (PDT)
Message-ID: <76d92fdc-ad0a-40a2-9e1b-d550f8e07267@redhat.com>
Date: Thu, 18 Apr 2024 13:34:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] platform/x86: thinkpad_acpi: Support for
 trackpoint doubletap
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
 Vishnu Sankar <vsankar@lenovo.com>,
 Peter Hutterer <peter.hutterer@redhat.com>,
 Vishnu Sankar <vishnuocv@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
 <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
 <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
 <55ded7c3-fbc5-4fa5-8b63-da4d7aa4966c@redhat.com>
 <a7f7d94a-f1c8-4d6a-9c65-b5de59b9f7c0@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a7f7d94a-f1c8-4d6a-9c65-b5de59b9f7c0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 4/18/24 1:57 AM, Mark Pearson wrote:
> Hi Hans,
> 
> On Wed, Apr 17, 2024, at 4:06 PM, Hans de Goede wrote:
>> Hi Mark,
>>
>> On 4/17/24 9:39 PM, Hans de Goede wrote:
>>> Hi Mark,
>>>
>>> Thank you for the new version of this series, overall this looks good,
>>> one small remark below.
>>>
>>> On 4/17/24 7:31 PM, Mark Pearson wrote:
>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>>> This handles the doubletap event and sends the KEY_PROG1 event to
>>>> userspace.
>>>>
>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>  - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
>>>>    want new un-specific key codes added.
>>>>  - Add doubletap to hotkey scan code table and use existing hotkey
>>>>    functionality.
>>>>  - Tested using evtest, and then gnome settings to configure a custom shortcut
>>>>    to launch an application.
>>>>
>>>>  drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>>> index 3b48d893280f..6d04d45e8d45 100644
>>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>>> @@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
>>>>  
>>>>  	/* Misc */
>>>>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
>>>> +
>>>> +	/* Misc2 */
>>>> +	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
>>>>  };
>>>>  
>>>>  /****************************************************************************
>>>> @@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>>>>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>>>>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>>>>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
>>>
>>> I understand why you've done this but I think this needs a comment,
>>> something like:
>>>
>>>         /*
>>>          * For TP_HKEY_EV_TRACK_DOUBLETAP, unlike the codes above which map to:
>>>          * (hkey_event - 0x1300) + TP_ACPI_HOTKEYSCAN_EXTENDED_START, this is
>>>          * hardcoded for TP_HKEY_EV_TRACK_DOUBLETAP handling. Therefor this must
>>>          * always be the last entry (after any 0x1300-0x13ff entries).
>>>          */
>>> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>>
>> Ugh, actually this will not work becuuse we want hotkeyscancodes to be stable
>> because these are userspace API since they can be remapped using hwdb so we
>> cannot have the hotkeyscancode changing when new 0x1300-0x13ff range entries
>> get added.
>>
>> So we need to either grow the table a lot and reserve a whole bunch of space
>> for future 0x13xx - 0x13ff codes or maybe something like this:
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index 771aaa7ae4cf..af3279889ecc 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -1742,7 +1742,12 @@ enum {	/* hot key scan codes (derived from ACPI 
>> DSDT) */
>>  	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
>>  	TP_ACPI_HOTKEYSCAN_MUTE,
>>  	TP_ACPI_HOTKEYSCAN_THINKPAD,
>> -	TP_ACPI_HOTKEYSCAN_UNK1,
>> +	/*
>> +	 * Note this gets send both on 0x1019 and on 
>> TP_HKEY_EV_TRACK_DOUBLETAP
>> +	 * hotkey-events. 0x1019 events have never been seen on any actual hw
>> +	 * and a scancode is needed for the special 0x8036 doubletap 
>> hotkey-event.
>> +	 */
>> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>>  	TP_ACPI_HOTKEYSCAN_UNK2,
>>  	TP_ACPI_HOTKEYSCAN_UNK3,
>>  	TP_ACPI_HOTKEYSCAN_UNK4,
>>
>> or just hardcode KEY_PROG1 like your previous patch does, but I'm not
>> a fan of that because of loosing hwdb remapping functionality for this
>> "key" then.
>>
>> Note I'm open to other suggestions.
>>
> Oh...I hadn't thought of that impact. That's not great :(
> 
> I have an idea, but want to prototype it to see if it works out or not. Will update once I've had a chance to play with it.

Thinking more about this I just realized that the input subsystem
already has a mechanism for dealing with scancode ranges with
(big) holes in them in the form of linux/input/sparse-keymap.h .

I think that what needs to be done is convert the existing code
to use sparse-keymap, keeping the mapping of the "MHKP"
returned hkey codes to internal TP_ACPI_HOTKEYSCAN_* values
for currently supported "MHKP" hkey codes for compatibility
and then for new codes just directly map them in the sparse map
aka the struct key_entry table. After converting the existing code
to use sparse-keymap, then for the new events we would simply add:


	{ KE_KEY, 0x131d, { KEY_VENDOR} }, /* Fn + N, system debug info */
	{ KE_KEY, 0x8036, { KEY_PROG1 } }, /* Trackpoint doubletap */

entries to the table without needing to define intermediate
TP_ACPI_HOTKEYSCAN_* values for these.

I already have somewhat of a design for this in my head and I really
believe this is the way forward as it uses existing kernel infra
and it will avoid hitting this problem again when some other new
"MHKP" hkey codes show up.

I plan to start working on implementing conversion of the existing
code to use sparse-keymap, which should result in a nice cleanup
after lunch and I hope to have something for you to test no later
then next Tuesday.

Regards,

Hans



