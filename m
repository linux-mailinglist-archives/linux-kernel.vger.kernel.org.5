Return-Path: <linux-kernel+bounces-135412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C389C103
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F992850B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9CE7D08A;
	Mon,  8 Apr 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+dzEral"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB477C0BE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581907; cv=none; b=HAdF52lftSqmfojMvYO1B3u9E89Dssy5qyG7acCtB0BW5u2kDI8gwKWzGFTaAkALljr4/WfrHYh9uUxdkcEN7kYUaE51wLVIv3zv6crWEjoyMoB5Z6OQ4VmiVWWSIqvg770EAyqqRsTvzhKpFYfSl5FhlB6/bSzCnAsBQwh6v6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581907; c=relaxed/simple;
	bh=jKN09l4ME8jxncm6SMzselLBpL1cK/PeEvCvqJYEKzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qzy9No01h8pjRdzbKna/+cvN3xCoor0fj7Rstb6+8tF0bRzxVz5HlUmmfA59YmBgrVzCcr9FPnRBebMA9OkiLWVsvnE99yyXfDg6DCUgOD/JZiG+MSyVnUUzl5TKLzRI+JS2G4/P+L92qsBuz/yiEWfixFYGQU2fPuKneVL59OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+dzEral; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QN/ohcVcXOcV74lBRkbnJ3+BIy7aYkesL60FOW5d0Y=;
	b=Q+dzEralDFDkJjpGBDMCy51I64bNo2VVlMHgu4m1kyOGZ2rnhXVKQpXdBCnvIXGrLF1enW
	ZBGLCjaBPzIiamBhNNk488qM+O2y8TrWBRBmtgeaA0bw2h9enxKZs0vb8Kh7xAqG6fum9U
	Y7ifVXztpYbcD2+qMUGt5jqevIU7ENI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-9gI5FIx7OjW_bncoIdKfrA-1; Mon, 08 Apr 2024 09:11:42 -0400
X-MC-Unique: 9gI5FIx7OjW_bncoIdKfrA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a51aec8eb93so160594566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712581901; x=1713186701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QN/ohcVcXOcV74lBRkbnJ3+BIy7aYkesL60FOW5d0Y=;
        b=vymNeaaZbpcIadh6KWsttoiWVrg/bt/104Rem0L4p74O+qbwsHhUfwtAiKwM2HraOX
         lXjsSsvEf6UNxc07j1wpkD/ptjP3VoN+JTouK3IslM3JXOB91DBDvPbcYuhzq8i7jMAF
         3yd+Wld6L/yM+k1ODlmVnEp81XQpbpSmfH4bxgIc9VOFshD0WFTQ+cBfKSdbmg6fayWm
         cJGKuRTeA/EPebNdbK9lS4azlxsOZ38hnAhZfmMgaOO0zBTVVPTZIsmPpLwNS00g9z7T
         r3OzzCVNYpY36vwUCUDjyE5V4aKzyDD/3JXVPVwHJkEifI64yZKeHRfnRXLwvw+2rJ0K
         ELdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzgZm2NQ2qFUFCpP6v36Y7Yhpa8C/++HPTgzHP50v2yI8DLQApGf5nxOPeiajJxadQRSWddKewV2rChDZRj4zWtGXjnJSGY2ZS2aok
X-Gm-Message-State: AOJu0YzDfeJOxarq7/oHf+difW0zM9VpkyhSaxA5D7KH26g/ZDB8TR7P
	RKvzImbVQ3nkH+ZKBsbMFWtNvyYUQB04NVyiWh7k9U5M469X6v5yif5TH2MQorHRXOAIWS/oh6v
	nVpjMcXJr1bZlNmXQ/enl7923boa4gUP8xmbD8d9nQQeHBS1T9Xv3nR1kQ6atNg==
X-Received: by 2002:a17:906:cb8c:b0:a51:a2ee:fab8 with SMTP id mf12-20020a170906cb8c00b00a51a2eefab8mr5351211ejb.36.1712581901311;
        Mon, 08 Apr 2024 06:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAbKJqhdIPQIyF0+AzW160f/4+tnJqeUF0J5A/eVZBJC9/Yp9ippvZKKTeSJyd/D6okdouDQ==
X-Received: by 2002:a17:906:cb8c:b0:a51:a2ee:fab8 with SMTP id mf12-20020a170906cb8c00b00a51a2eefab8mr5351197ejb.36.1712581900988;
        Mon, 08 Apr 2024 06:11:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bv4-20020a170907934400b00a51ce4710c5sm2010686ejc.19.2024.04.08.06.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:11:40 -0700 (PDT)
Message-ID: <a2237f76-dae6-4198-b393-7d0c18224205@redhat.com>
Date: Mon, 8 Apr 2024 15:11:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] platform/x86: thinkpad_acpi: Support for system debug
 info hotkey
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br, dmitry.torokhov@gmail.com,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 njoshi1@lenovo.com, vsankar@lenovo.com, peter.hutterer@redhat.com
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-4-mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240324210817.192033-4-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/24/24 10:08 PM, Mark Pearson wrote:
> New Lenovo platforms are adding the FN+N key to generate system debug
> details that support can use for collecting important details on any
> customer cases for Windows.
> Add the infrastructure so we can do the same on Linux by generating a
> SYS_DEBUG_INFO keycode to userspace.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 2bbb32c898e9..854ce971bde2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1787,6 +1787,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
> +	TP_ACPI_HOTKEYSCAN_SYS_DEBUG_INFO = 81,
>  
>  	/* Hotkey keymap size */
>  	TPACPI_HOTKEY_MAP_LEN
> @@ -3337,6 +3338,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  		KEY_NOTIFICATION_CENTER,	/* Notification Center */
>  		KEY_PICKUP_PHONE,		/* Answer incoming call */
>  		KEY_HANGUP_PHONE,		/* Decline incoming call */
> +		KEY_UNKNOWN,			/* AMT Toggle (event), 0x31A */
> +		KEY_UNKNOWN, KEY_UNKNOWN,
> +		KEY_SYS_DEBUG_INFO,             /* System debug info, 0x31D */
>  		},
>  	};
>  

Looking at the next patch 0x131c is TP_HKEY_EV_DOUBLETAP_TOGGLE and 0x131a is
TP_HKEY_EV_AMT_TOGGLE based on this please change this to:

  		KEY_NOTIFICATION_CENTER,	/* Notification Center */
  		KEY_PICKUP_PHONE,		/* Answer incoming call */
  		KEY_HANGUP_PHONE,		/* Decline incoming call */
		KEY_UNKNOWN,			/* TP_HKEY_EV_AMT_TOGGLE handled in driver, 0x31a */
		KEY_UNKNOWN,			/* ?, 0X31b */
		KEY_UNKNOWN,			/* TP_HKEY_EV_DOUBLETAP_TOGGLE handled in driver, 0x31c */
		KEY_SYS_DEBUG_INFO,             /* System debug info, 0x31d */
		},

Regards,

Hans




