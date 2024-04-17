Return-Path: <linux-kernel+bounces-149162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B28A8CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE262282B40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415893FE55;
	Wed, 17 Apr 2024 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0y4b5s8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636E3FBAF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384377; cv=none; b=csfNQrfzOqwu9cuXPGDzP5AVhYst7t3ypLayn+r4YhgazK7ibjhGWpSeIj9x/OFVRZzVDepWlhSiOg9uDB5FV7Qdk/7fI48zFT3A644GJXyvrHz8mePlcs75ZBBSwUnt/JLix52pxq698lZYnaXvOTbI5wDkhGglmE8vFqWv+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384377; c=relaxed/simple;
	bh=NuYuCsJ3PhQkLg4kz9zkUTohJpldEtXDncdK/m/5Flw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FEZuJjP84cAZgi/Sve6v3nyvHdpq2kTEXxsHRV6sc9L/EEDWOHG7sT0KEqaVrcsbv2G2RrE/c031WucYcUOJQ/XI2EnCYOKMxB45vRpHDYkJPMTwwwvyeL3p9PPV2zIwoPL8xZj8qlPn3lfVSxI2C8fbKj6mZ5NHOjAogEliZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0y4b5s8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713384374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXng1P4bGBgQBCNw4yKgKmJCzOVQRzHuuBNEdqSXyZs=;
	b=i0y4b5s8keDNBtVxANe6pkcoEfTazN/GVuI6f/nfrnEVR+jb5HHu0DjIZLP82MKHv14CgN
	TFaDcqKWaarbPg5GRt3nCM41ALXUX1r/mUejVl2OZQVZNVurJKoj3Gf8HBYyUPXSVqC6+m
	pBrlBuQUajotSRCg1TWyPW4JL0nrBxE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wesQc4e1Mrq1PNGH_9BNJQ-1; Wed, 17 Apr 2024 16:06:11 -0400
X-MC-Unique: wesQc4e1Mrq1PNGH_9BNJQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51cb1feb23so701066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384370; x=1713989170;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXng1P4bGBgQBCNw4yKgKmJCzOVQRzHuuBNEdqSXyZs=;
        b=wO2cCqwUd823gChwmxK+eU0y6lmtvdkhG7MmgnEHzUqAesR+aWrl9+k3vldXzJ2nzQ
         Y1TlHo5WvdqC2H/fUqkPLU9TgLNj7gdzC1SHWX1negYgb99DU2huQS4ZepBgL7CVpyvz
         KCE1XkYwpuOcFUs6tNhpCa5bOEmC9FOXqUbtCpsku7z6HUJSV5v3KwSDSuSvtOnV2M51
         4TN+2lA9BiDKMiS7v8F7705U/fkxsIF9/zU62NcmlcDZZhyUr4lYHbYAgRLTHmWwoelj
         HRxbzRyf3UhNqMPDendVZIhVumcKYGxqwLWl94/3890hzgsx3/2wn1FjVfP2qcCDbKDf
         R2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXgJE5yIwZ5OxAPTKdzfumkz1NPeqEwIBKopZ8t+bSF8zOq3feIUTOoYAaxfeARadolushPeji+yVddvDuJssq8iur69E2NlTVXK7l1
X-Gm-Message-State: AOJu0YwyA3cUqbZTr7wzkH/eJ1AVfu7vQ0wN23jMeSfhZPLbSRrRyRUP
	yRTXHTFeijxA804uJ7zzSxZ7cIQTz22X01gN+wakEUsWKaTaDxHcbRzX+lS9LnFn6lgz39aCie2
	RL5ZGwci7x8Rv4WdMZg0A0o5ekr218P9c5wax4sOOyHkzxiiHoeZlXCAVII3Ajg==
X-Received: by 2002:a17:906:3298:b0:a52:66f3:a9ee with SMTP id 24-20020a170906329800b00a5266f3a9eemr335001ejw.41.1713384370556;
        Wed, 17 Apr 2024 13:06:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvyR41sBORHp+SltZycGx/GPdfz2ryUpFV8uyoatC7LGB+sWjez9bqHxgJY63/bO+W/uL8Rg==
X-Received: by 2002:a17:906:3298:b0:a52:66f3:a9ee with SMTP id 24-20020a170906329800b00a5266f3a9eemr334991ejw.41.1713384370191;
        Wed, 17 Apr 2024 13:06:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qf41-20020a1709077f2900b00a522a073a64sm7973310ejc.187.2024.04.17.13.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:06:09 -0700 (PDT)
Message-ID: <55ded7c3-fbc5-4fa5-8b63-da4d7aa4966c@redhat.com>
Date: Wed, 17 Apr 2024 22:06:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] platform/x86: thinkpad_acpi: Support for
 trackpoint doubletap
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, njoshi1@lenovo.com, vsankar@lenovo.com,
 peter.hutterer@redhat.com, Vishnu Sankar <vishnuocv@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
 <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
 <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 4/17/24 9:39 PM, Hans de Goede wrote:
> Hi Mark,
> 
> Thank you for the new version of this series, overall this looks good,
> one small remark below.
> 
> On 4/17/24 7:31 PM, Mark Pearson wrote:
>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>> This handles the doubletap event and sends the KEY_PROG1 event to
>> userspace.
>>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>> ---
>> Changes in v2:
>>  - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
>>    want new un-specific key codes added.
>>  - Add doubletap to hotkey scan code table and use existing hotkey
>>    functionality.
>>  - Tested using evtest, and then gnome settings to configure a custom shortcut
>>    to launch an application.
>>
>>  drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 3b48d893280f..6d04d45e8d45 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
>>  
>>  	/* Misc */
>>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
>> +
>> +	/* Misc2 */
>> +	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
>>  };
>>  
>>  /****************************************************************************
>> @@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
> 
> I understand why you've done this but I think this needs a comment,
> something like:
> 
>         /*
>          * For TP_HKEY_EV_TRACK_DOUBLETAP, unlike the codes above which map to:
>          * (hkey_event - 0x1300) + TP_ACPI_HOTKEYSCAN_EXTENDED_START, this is
>          * hardcoded for TP_HKEY_EV_TRACK_DOUBLETAP handling. Therefor this must
>          * always be the last entry (after any 0x1300-0x13ff entries).
>          */
> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,

Ugh, actually this will not work becuuse we want hotkeyscancodes to be stable
because these are userspace API since they can be remapped using hwdb so we
cannot have the hotkeyscancode changing when new 0x1300-0x13ff range entries
get added.

So we need to either grow the table a lot and reserve a whole bunch of space
for future 0x13xx - 0x13ff codes or maybe something like this:

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 771aaa7ae4cf..af3279889ecc 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1742,7 +1742,12 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
 	TP_ACPI_HOTKEYSCAN_MUTE,
 	TP_ACPI_HOTKEYSCAN_THINKPAD,
-	TP_ACPI_HOTKEYSCAN_UNK1,
+	/*
+	 * Note this gets send both on 0x1019 and on TP_HKEY_EV_TRACK_DOUBLETAP
+	 * hotkey-events. 0x1019 events have never been seen on any actual hw
+	 * and a scancode is needed for the special 0x8036 doubletap hotkey-event.
+	 */
+	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
 	TP_ACPI_HOTKEYSCAN_UNK2,
 	TP_ACPI_HOTKEYSCAN_UNK3,
 	TP_ACPI_HOTKEYSCAN_UNK4,

or just hardcode KEY_PROG1 like your previous patch does, but I'm not
a fan of that because of loosing hwdb remapping functionality for this
"key" then.

Note I'm open to other suggestions.

Regards,

Hans


