Return-Path: <linux-kernel+bounces-149130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E68A8C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F48281B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEA2C859;
	Wed, 17 Apr 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4NiMgSy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266538F82
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382801; cv=none; b=iPkGrOl18JbE+LwfJZBbPTzj4VQ5RhxxfhlDWYeqK4k4IcNQWw5obBnTdIFyTC/3rF/pYOFhweDpgywEHuSJjQH3fdDV+ezURuoeks8PgJfPlqayAoVSIdfxwRIW2qmMRWugpdbunW6+6bNRSdjLW1EPaqJ9XbUBuQWi6/4HVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382801; c=relaxed/simple;
	bh=G83eVykAi/efryWX4uKBrbjPsKiRpPqTMa2UvUGOP9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekYuuvfgtlN+lVnj24UqjNbhXOMbLS5bUyjjbA1RpjpcRbypAsgJ9vN0NJXB7/DQD8QXJEGXpOnn6YvrfhTFxGIFqwfWIZxnWV4b0v7jKod+PqhJ+UVXm+OV2J1/GBNO2OH46R3/Gw2dm5FXLPLrpstGy7FzXIAurA3nDArBakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4NiMgSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713382799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHsW1ltpsGcr7bHagE1y1YeI6tL7m/bl+evkY3i/aDw=;
	b=R4NiMgSyTi4r1OpbM9vQi/AtWyNSkG4pImvkLJ2/QE02LNkxeftDZ8BfJgrAqk8c4Zxs6/
	Dqs6VQ/2+RuzqtVl9RbPn3Rjn2cceGxV8ImExm/aROe9eaPJzqmmdvidogKuwpSHYDRCRA
	/PFlNgU/wOvrcUv7TNb5fRLwfyCaESw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-IpjG3JI3N_uz1Eh46eoiYg-1; Wed, 17 Apr 2024 15:39:57 -0400
X-MC-Unique: IpjG3JI3N_uz1Eh46eoiYg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-519696567f4so23712e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713382796; x=1713987596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHsW1ltpsGcr7bHagE1y1YeI6tL7m/bl+evkY3i/aDw=;
        b=s5YzB3SNWg5J8ZG9cz9/X0nXPTFwurqEwHXd0a9kGda1aS1HPm0X6prBTaj5F16PeC
         pkpnOohDV5b8IDecCHrCMN9rrAtfFr12Nt/Yr3/emVEAsUhbyeaFs/sP8BWHDKmbKulA
         +GqHrF7FScVhJFuuub0SEsSmvXVXX2rrRSUV25izGqeq9xGFHtvxmbO9oVmfo5Kz84CN
         5A6SUYyRf3b+TFHciGOT8Kb4+4GrB3upyh/H+oNcQiDeg2kck9z6j8HVeHVcP8aVZbrj
         tSAMJMg9nYKGl1qmqaMFFhAa394R0BEn4qsMk1CHEKEXrK2UAucjhCWhwIv/ZiN/Ujeh
         rOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/dgbaFGHus+ahEioC9E7qXrifuu/dzKhjkLrp10HGpEcc6EK49xBzMzlC32IpxAa6k7XZHRhazSiYlIdbRluFmdlW1+pEaiBtuej9
X-Gm-Message-State: AOJu0YwKqm72gxcluquzXMPH6mOIloy7S+KVFxKsMBT7WcU8fUay1LS/
	gzJlGZvWQ654A9fiyh2BqHd3jp2ORNPOgChiDn/yMLBOyNOp8GDeBFlljSo7OJUNRqLazM5j6IQ
	swoe7JMWW7B4Z+nyGMkTj5mKGapgsCsgWznZJ5IzkZ0Fi9r3pAS4mAwu55mXZLA==
X-Received: by 2002:a05:6512:238f:b0:519:63c1:6f2b with SMTP id c15-20020a056512238f00b0051963c16f2bmr217338lfv.54.1713382796131;
        Wed, 17 Apr 2024 12:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQOr0vOl/amoQkG2c8TZZIA3fB3oHHu4NtMOLSJDUVCY8ogv8Z13fBBq9LV7wYICMDiPchjQ==
X-Received: by 2002:a05:6512:238f:b0:519:63c1:6f2b with SMTP id c15-20020a056512238f00b0051963c16f2bmr217322lfv.54.1713382795766;
        Wed, 17 Apr 2024 12:39:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id he38-20020a1709073da600b00a51fa9f6d92sm8372953ejc.38.2024.04.17.12.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 12:39:55 -0700 (PDT)
Message-ID: <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
Date: Wed, 17 Apr 2024 21:39:54 +0200
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
Cc: ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, njoshi1@lenovo.com, vsankar@lenovo.com,
 peter.hutterer@redhat.com, Vishnu Sankar <vishnuocv@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
 <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

Thank you for the new version of this series, overall this looks good,
one small remark below.

On 4/17/24 7:31 PM, Mark Pearson wrote:
> Lenovo trackpoints are adding the ability to generate a doubletap event.
> This handles the doubletap event and sends the KEY_PROG1 event to
> userspace.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
> Changes in v2:
>  - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
>    want new un-specific key codes added.
>  - Add doubletap to hotkey scan code table and use existing hotkey
>    functionality.
>  - Tested using evtest, and then gnome settings to configure a custom shortcut
>    to launch an application.
> 
>  drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 3b48d893280f..6d04d45e8d45 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
>  
>  	/* Misc */
>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
> +
> +	/* Misc2 */
> +	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
>  };
>  
>  /****************************************************************************
> @@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,

I understand why you've done this but I think this needs a comment,
something like:

        /*
         * For TP_HKEY_EV_TRACK_DOUBLETAP, unlike the codes above which map to:
         * (hkey_event - 0x1300) + TP_ACPI_HOTKEYSCAN_EXTENDED_START, this is
         * hardcoded for TP_HKEY_EV_TRACK_DOUBLETAP handling. Therefor this must
         * always be the last entry (after any 0x1300-0x13ff entries).
         */
+	TP_ACPI_HOTKEYSCAN_DOUBLETAP,

I see you got adding the new 0x13xx related hkeyscancodes right in the next
patch in this series but I think such a comment as above will be helpful
for future patches.

If you agree with adding this comment I can add this while merging, no need
to send a new version just for this.

Regards,

Hans





>  	/* Hotkey keymap size */
>  	TPACPI_HOTKEY_MAP_LEN
> @@ -3336,6 +3340,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  		KEY_NOTIFICATION_CENTER,	/* Notification Center */
>  		KEY_PICKUP_PHONE,		/* Answer incoming call */
>  		KEY_HANGUP_PHONE,		/* Decline incoming call */
> +		KEY_PROG1,                      /* Trackpoint doubletap */
>  		},
>  	};
>  
> @@ -3996,6 +4001,15 @@ static bool hotkey_notify_6xxx(const u32 hkey,
>  	return true;
>  }
>  
> +static bool hotkey_notify_8xxx(const u32 hkey)
> +{
> +	if (hkey == TP_HKEY_EV_TRACK_DOUBLETAP) {
> +		tpacpi_input_send_key(TP_ACPI_HOTKEYSCAN_DOUBLETAP);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  {
>  	u32 hkey;
> @@ -4079,6 +4093,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  				known_ev = true;
>  			}
>  			break;
> +		case 8:
> +			/* 0x8000-0x8FFF: misc2 */
> +			known_ev = hotkey_notify_8xxx(hkey);
> +			break;
>  		}
>  		if (!known_ev) {
>  			pr_notice("unhandled HKEY event 0x%04x\n", hkey);


