Return-Path: <linux-kernel+bounces-135385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B189C010
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881611C212B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A607C6C9;
	Mon,  8 Apr 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4F/VKth"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2D7C6C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581469; cv=none; b=pcFlhO3RGStG7l+FFS2kPEKOxn0Ru7mKgYGJb8q0wFqI/ClW2Iq2Rs5RiBmdcXUY8FkzISpnVrpxuFHtO2dqZt/0i2puwx0aOmd+bn2xXGTkDxLJy05831t/DSFkgl6kIwSThop8y6gD3wCyB8q0jMvRvkKm+wmuFeyWqvAKjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581469; c=relaxed/simple;
	bh=yMYg0GAX8ig5QTjA2q7Q+0ralBaGGpY5ED1olsise54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erekjSGjhFQeyh2ucVdP/lWEcy7LBR3EgXZJq7IC3jZDGot5Pdt7JoZtBg2Ft/Jq2YgqCxoGyGQyXTAIOFoV9j5LOFwQAKlt9kAUKjCILnSEHuOqkJf7QHjKLMIgCf63yB1Du6/jjDKQwroQn73U+lmIRn1ZkNXorWCu/sW/ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4F/VKth; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYsEbh/lFBGC7LmhffRxYV+mBnuUn8I4RfVy+AtiIJ0=;
	b=e4F/VKth0B3f2BA4XCcymNSYwPgNZonVsfBurjauLjFdepwFBE2yaI7slejy3s13GiTFEe
	Sy48NxnZn1mn4esdm0TvV77Eny/Xo3t1m1lcVvBHQvGQQkxgtI7WhPueQX4rcT3WvKdSqM
	eH1aB/NLIxJ70DkLfzpoc7Tc7bdXcl0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-tzjOB3O-PhKlsUYCTVtPRQ-1; Mon, 08 Apr 2024 09:04:24 -0400
X-MC-Unique: tzjOB3O-PhKlsUYCTVtPRQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516ddd6d66fso1459473e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712581463; x=1713186263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYsEbh/lFBGC7LmhffRxYV+mBnuUn8I4RfVy+AtiIJ0=;
        b=qjYoYIVpeAvmtjf9vH5xONFUq+wCdP4966PZQ2ITyMsLaetN79zNKCdZPp0OCeRpFI
         PJHERDo5Txo2TbyRHiKj9MBK+LaD4F9UQ1uSKsE4YooR2g+GCP/LPwWdqAatMVgv9XBX
         RwCY81d0jAN3vE4OoQuUWQv9wZu2QY4/sCLqSQ+nFPbrxvTdPc5LGhKyOHE34AiTMofM
         EhNbX4xM9+fIq621mDiGY9w220Ba+vc2t17YUXjvvcIswsfHAa/1dT2kFEBYP0mnbJFY
         e4aITlFpubgNUGXzmYi4ZiPZjQn5l4DBpmdWf9VFq/ODWYbMvZwAm396swqp6FqEWjdI
         JzDw==
X-Forwarded-Encrypted: i=1; AJvYcCUZztir37Ms8moSlM0OFf0U15oXfpxcaQWKGq6/T0/bI0hKNI9UQx8PqgHjmXCEE/pUGX5iP4Gh745kSDNjayN23q8rQLMlSL8cOU0U
X-Gm-Message-State: AOJu0Yx+M+Cibw/nA63XbEhVbRTlEfqs8DwZOghicn60zR0/3RsWH2+f
	1Mai6zAOCMy9PGl7o1wYC2ZoNoT6gwKiXaNArSBOwxp3RG4QHNzyGOBEhNF8/Hde2ddFvrelzB0
	vLy+qQz8n52x8RzrvuGaOLQ2iloBrRiwnxB2UgDaCRlPGOPP/oj4yOZMKoU873w==
X-Received: by 2002:a05:6512:285:b0:516:d18b:eaea with SMTP id j5-20020a056512028500b00516d18beaeamr5852668lfp.33.1712581463103;
        Mon, 08 Apr 2024 06:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVbN23MbRWpoFmVMF8qzJBUpAHXZlNsgr5ChUftbP9Us3ZW5wqEVHzzpFcU5atACDir8I7+g==
X-Received: by 2002:a05:6512:285:b0:516:d18b:eaea with SMTP id j5-20020a056512028500b00516d18beaeamr5852651lfp.33.1712581462739;
        Mon, 08 Apr 2024 06:04:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id di19-20020a056402319300b0056b7ed75a46sm4178873edb.27.2024.04.08.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:04:16 -0700 (PDT)
Message-ID: <e1ccf281-5c77-4447-a6c7-5b0b008c7c56@redhat.com>
Date: Mon, 8 Apr 2024 15:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: thinkpad_acpi: Support for trackpoint
 doubletap
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br, dmitry.torokhov@gmail.com,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 njoshi1@lenovo.com, vsankar@lenovo.com, peter.hutterer@redhat.com
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-3-mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240324210817.192033-3-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 3/24/24 10:07 PM, Mark Pearson wrote:
> Lenovo trackpoints are adding the ability to generate a doubletap event.
> This handles the doubletap event and sends the KEY_DOUBLECLICK event to
> userspace.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 82429e59999d..2bbb32c898e9 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -232,6 +232,7 @@ enum tpacpi_hkey_event_t {
>  
>  	/* Misc */
>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
> +	TP_HKEY_EV_TRACKPOINT_DOUBLETAP = 0x8036, /* doubletap on Trackpoint*/
>  };
>  
>  /****************************************************************************
> @@ -4081,6 +4082,22 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  				break;
>  			}
>  			fallthrough;	/* to default */

This now no longer fallsthrough to default. IMHO the best thing to do
here is add a new preparation patch which initializes known_ev to false
inside the while before the switch-case (together with the send_acpi_ev
and ignore_acpi_ev init). and then change this fallthrough to a break
in the preparation patch. You can then also remove the default case
altogether in this prep patch.

> +		case 8:
> +			/* 0x8036: Trackpoint doubletaps */
> +			if (hkey == TP_HKEY_EV_TRACKPOINT_DOUBLETAP) {
> +				send_acpi_ev = true;
> +				ignore_acpi_ev = false;

These 2 values are set as the default above the switch-case, please
drop these 2 lines.

> +				known_ev = true;
> +				/* Send to user space */
> +				mutex_lock(&tpacpi_inputdev_send_mutex);
> +				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
> +				input_sync(tpacpi_inputdev);
> +				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
> +				input_sync(tpacpi_inputdev);
> +				mutex_unlock(&tpacpi_inputdev_send_mutex);

This code duplicates tpacpi_input_send_key(), what you want to do here
is define a hotkey_keycode_map scancode range for new 0x8xxx codes like how this
was done when extended scancodes where added to deal with the new 0x13xx hotkey
event codes for the 2017+ models.

See commit 696c6523ec8f ("platform/x86: thinkpad_acpi: add mapping for new hotkeys")

Despite re-using tpacpi_input_send_key() there are 2 reasons why we want
scancodes for these new "keys".

1. By adding the keys to the hotkey_keycode_map they automatically
also get input_set_capability(tpacpi_inputdev, EV_KEY, hotkey_keycode_map[i]);
called on them advertising to userspace that tpacpi_inputdev can actually
generate these keypresses. Something which is currently lacking from your
patch. Related to this did you test this with evtest? I think that the input
core will suppress the events when you do not set the capability ?

2. This allows remapping scancodes to different KEY_foo values with hwdb
entries.

Regards,

Hans








> +				break;
> +			}
> +			fallthrough;	/* to default */
>  		default:
>  			known_ev = false;
>  		}


