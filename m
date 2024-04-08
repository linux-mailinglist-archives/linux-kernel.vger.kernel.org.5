Return-Path: <linux-kernel+bounces-135418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2589C198
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E5CB23446
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4E7FBCE;
	Mon,  8 Apr 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXP7Fm4E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41B7FBB5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581992; cv=none; b=Zk24F/JWXt4T/bGkHV7Sp0NBpwKXjFuruFiU8JkSYocpB6i8dU+M6f6MadCQTbfEKQRTV19k7UA0AMKGbZgxqtCFdyrq0eyfkA4e/GaT7CG7VhWv0kVfcIFX1W3imuZFhCLAABPjCAsmHnWYJggYV5pDhlFmu9sUfsnLSE9yAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581992; c=relaxed/simple;
	bh=cws8BVNEPRn5vqjkb25rCS0YNKXfJAj1B9nMxiEmNto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwxTH1lqg+tJ7+ySZBdnjZFPwB6uImg0GTrnvVOBl0HeKezlBc5VcUv+QCzkmErhcLfuMXJ0cLrYLy4lkmRXvHAHKd+2tr6yCEpJ2iatu8qynhGg4fO0zk3VAQ+VvcckVPuOwYsbYocnnj1jwqWQzBen8D/Sqb6U5mkzCeA4N74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXP7Fm4E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ck6h7oGqY5cwfuLDZYTXRLzHj6mfJjTZhLoQldbd3c=;
	b=dXP7Fm4EVnnj6wLFF4IktP47reD9TWMKB0UYyKLkJJjydydrHpAY+afSQUANpaLEYn1GcV
	9GpB8gYFdem0e06004NhAkAU8VQjmOTkIQobpduwx+sHCyYpD3IaLoslH2wakvanwE8eNK
	4PL8NM47THeokW5JuyPo0SluVcKhnjM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-y0bwKuZENQ622z9JGrGW7g-1; Mon, 08 Apr 2024 09:13:08 -0400
X-MC-Unique: y0bwKuZENQ622z9JGrGW7g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78a6dd7a9e7so556341585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712581988; x=1713186788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ck6h7oGqY5cwfuLDZYTXRLzHj6mfJjTZhLoQldbd3c=;
        b=VZssNK1nNKiAaxwbZs7FyQdGatugTtq2Qf/WCB7OXKvuT0Z3j11KrFNj9/pqy0yo5w
         KJmLdU/OCuKmHsjXypT3y37IYhpaFAEOwzZfe2uuVHgkiqsR3po9QkP67EHYCa8r7yfu
         RjdYl2SLZA7BI0UgAjrzah4DyT3eSQiwk6Hid8x9kilTXDUB9tn4JI3F/l8EsdPVOSFJ
         zO71NlHVA9p9k3oF/e3SFXvU7DzQ1IvmtlPnc2L0rAq1FTgZHUO8SqAU2v5G/jGw2RbY
         tCcFp5eOtbKW+5RfOjDyEb6DqPzfxK5zkPBjuAbi/3cOgfXGvYFR8QDs3LsmLUgvRp02
         /lTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUu6Agebp0AlILe8tWG9JA4u/QCUmv9NnvoIYd3SJSxzUAVsWrNsehyMxoU5I0JJzyaNlFLzpb9elzmql47ZGMgp0unW/Nz/d/C5Yb
X-Gm-Message-State: AOJu0YzwPY9mephZ524NdDLE41RtZuXjziKW+1yM+40+nkzEz6+68bTQ
	x91mW9gPY8n4zeLSyToUZ+VxbBPz9lODafKMuLJqYA4VsQJpO2bu5Lrs6VUa+3+4BVleyAiobBl
	xAgm4mD+xzdWAgyZ/vP1MmFVd+R1KC1MQrmnlRoArJPK+oJUaGr1zbpi1ElsHxA==
X-Received: by 2002:a05:620a:4d14:b0:78d:6b3d:9a34 with SMTP id wa20-20020a05620a4d1400b0078d6b3d9a34mr314380qkn.43.1712581987912;
        Mon, 08 Apr 2024 06:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaaNdf0+aehQaiEaOUOB91zwM2iwnImBi5etNoZRMALgRd/jitUy/yEBySE/LqXxJmVF3lrQ==
X-Received: by 2002:a05:620a:4d14:b0:78d:6b3d:9a34 with SMTP id wa20-20020a05620a4d1400b0078d6b3d9a34mr314361qkn.43.1712581987632;
        Mon, 08 Apr 2024 06:13:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b0078d623428c5sm1471784qky.88.2024.04.08.06.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:13:07 -0700 (PDT)
Message-ID: <3f49d41e-649d-4a07-9a1a-301a2f52613c@redhat.com>
Date: Mon, 8 Apr 2024 15:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] platform/x86: thinkpad_acpi: Support hotkey to
 disable trackpoint doubletap
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br, dmitry.torokhov@gmail.com,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 njoshi1@lenovo.com, vsankar@lenovo.com, peter.hutterer@redhat.com
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-5-mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240324210817.192033-5-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/24/24 10:08 PM, Mark Pearson wrote:
> The hotkey combination FN+G can be used to disable the trackpoint
> doubletap feature on Windows.
> Add matching functionality for Linux.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 854ce971bde2..21756aa3d28d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -167,6 +167,7 @@ enum tpacpi_hkey_event_t {
>  	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
>  	TP_HKEY_EV_PRIVACYGUARD_TOGGLE	= 0x130f, /* Toggle priv.guard on/off */
>  	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
> +	TP_HKEY_EV_DOUBLETAP_TOGGLE	= 0x131c, /* Toggle trackpoint doubletap on/off */
>  	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile */
>  
>  	/* Reasons for waking up from S3/S4 */
> @@ -354,6 +355,7 @@ static struct {
>  	u32 hotkey_poll_active:1;
>  	u32 has_adaptive_kbd:1;
>  	u32 kbd_lang:1;
> +	u32 trackpoint_doubletap:1;
>  	struct quirk_entry *quirks;
>  } tp_features;
>  
> @@ -3598,6 +3600,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  
>  	hotkey_poll_setup_safe(true);
>  
> +	/* Enable doubletap by default */
> +	tp_features.trackpoint_doubletap = 1;
> +
>  	return 0;
>  }
>  
> @@ -3739,6 +3744,7 @@ static bool hotkey_notify_extended_hotkey(const u32 hkey)
>  	case TP_HKEY_EV_PRIVACYGUARD_TOGGLE:
>  	case TP_HKEY_EV_AMT_TOGGLE:
>  	case TP_HKEY_EV_PROFILE_TOGGLE:
> +	case TP_HKEY_EV_DOUBLETAP_TOGGLE:
>  		tpacpi_driver_event(hkey);
>  		return true;
>  	}
> @@ -4092,13 +4098,15 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  				send_acpi_ev = true;
>  				ignore_acpi_ev = false;
>  				known_ev = true;
> -				/* Send to user space */
> -				mutex_lock(&tpacpi_inputdev_send_mutex);
> -				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
> -				input_sync(tpacpi_inputdev);
> -				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
> -				input_sync(tpacpi_inputdev);
> -				mutex_unlock(&tpacpi_inputdev_send_mutex);
> +				if (tp_features.trackpoint_doubletap) {
> +					/* Send to user space */
> +					mutex_lock(&tpacpi_inputdev_send_mutex);
> +					input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
> +					input_sync(tpacpi_inputdev);
> +					input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
> +					input_sync(tpacpi_inputdev);
> +					mutex_unlock(&tpacpi_inputdev_send_mutex);
> +				}
>  				break;
>  			}
>  			fallthrough;	/* to default */

This chunk will need to change after incorporating my review comments into
patch 2/4. With that said this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> @@ -11228,6 +11236,8 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
>  		/* Notify user space the profile changed */
>  		platform_profile_notify();
>  	}
> +	if (hkey_event == TP_HKEY_EV_DOUBLETAP_TOGGLE)
> +		tp_features.trackpoint_doubletap = !tp_features.trackpoint_doubletap;
>  }
>  
>  static void hotkey_driver_event(const unsigned int scancode)


