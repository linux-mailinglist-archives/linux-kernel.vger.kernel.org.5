Return-Path: <linux-kernel+bounces-145286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6078A5216
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AB41F23B71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FD7350C;
	Mon, 15 Apr 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMhoCE87"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BAF7316F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188717; cv=none; b=X6oRy8xNlG7XL4BZVX5dHvDTuJuHhauVy/QicbD2xP4hq5AWhPsGNyqPwIOOYx7Eg4SBssVMmoJbcXRSTkajdUGWkKyhs3vFHn9/hDLvU2Kat51fgb1sEzVMh6ayOqmy2rbg0V1CbnpVaZGZOuYPJPEacru9rm0eNRM4nUF3leo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188717; c=relaxed/simple;
	bh=H+B3pQuhxCA59NKCu+q5vitH+TN6tJ22oaJoMn3xZ/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvfXANIIsjBgFGe8IMm6ybN0VnIhUK1M5IsqrFPmA65k31oHOFUjMKJMcBrNsQ9+ZZ/mLlwevaH1e1pPjiis2n3kY8X9d5jX25zAMzcMKnS4f098ekNfsKw55awgCBfOkqVNHF8kfAKk2QV6siP/QEklJhKv1JDZTjTI9pNxmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMhoCE87; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713188714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wqce/9raECD4n9z1gyCEXu+9q/G8QA4dWvqni2YgFJ8=;
	b=OMhoCE87pk3ZtVpgzODO5h9WzOggvSet/FdYrjJV3ABj7ofsU8zSGc+AfArY5dNcpZvUeF
	/D9iI/0bmJBvTfbaBW9ZZxqh0xPdhaAV1IZUuf27MUC/Yd7focUVwluOVaaKnst9Tb2Ume
	fbEs05O8+bYyyuNoht34xkn5IAxhF3g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-wpQ-VDfJMP-tchCzk53ang-1; Mon, 15 Apr 2024 09:45:12 -0400
X-MC-Unique: wpQ-VDfJMP-tchCzk53ang-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5532902a78so38480466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188711; x=1713793511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqce/9raECD4n9z1gyCEXu+9q/G8QA4dWvqni2YgFJ8=;
        b=tdZmDqCuLik7WXWnbn0eqWLerA14wzORlhidYyBzPUFJMBiTH45JrSBB2GpD6oJNpZ
         9KGjeCTbXbey93BbYeI6UCp7GugLJ7coy8goDll02Y1UFVko4Me8oMeEHM/Veed2m4HX
         Zp9fT0HzaCsFORJRwcWHjG9oTjUQcpejM7sGb+UxMGSjE3gWObx4ZpVBzoSxvxy9EcDf
         QYl85cHV4GaN6PLOTd669yUwHqy5+3Zw2cJ6+9bxY7t7roCux10ky3pnEejQxWdSUcIi
         5mjauU9tt8C8geHId5IrUxlxPq9wCJ6QKvGnLE95r3UGPGkXIAhRp265Tu+GrFcSwgAn
         q8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqLzDzYkoT2SVWE+PONa+302ddO2c0N2N4XpKCgTez7hI4bRsAK5sC7FNgixIvcW3NcCbtcyL2y6u5Qor9eXKb1XdXhwwWSwMPQnbq
X-Gm-Message-State: AOJu0YyvYAyHOgy+oAPa3Em9RGicg3aFaLZtBwnfAAr9noI82r0ulsYO
	uBaVeDRZ98M0/DhKNCERWJzYgunfY5TIfc/PTWNbLOqU0nHEOYJzieq5n9N5ZupMvd9FyansJpB
	rVQHNISwec45xtYC11ncRRyHGBA7xhj4q5eyogJefsOXM35+d5ABJt0CyhcNihw==
X-Received: by 2002:a17:906:ae8c:b0:a52:6fca:eb57 with SMTP id md12-20020a170906ae8c00b00a526fcaeb57mr1733609ejb.45.1713188711216;
        Mon, 15 Apr 2024 06:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESSJzHoNootY7yTStSalob24MtrnXEF6BFFSwuhXN7Wy3qvNO5UaWy+uXLPG1CLzmr3h4+Ww==
X-Received: by 2002:a17:906:ae8c:b0:a52:6fca:eb57 with SMTP id md12-20020a170906ae8c00b00a526fcaeb57mr1733593ejb.45.1713188710851;
        Mon, 15 Apr 2024 06:45:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qf30-20020a1709077f1e00b00a46a27794f6sm5443325ejc.123.2024.04.15.06.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:45:10 -0700 (PDT)
Message-ID: <e6cf5488-8c80-49db-b67a-0effd4c3e782@redhat.com>
Date: Mon, 15 Apr 2024 15:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86: android-tablets: Use GPIO_LOOKUP()
 macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240408153749.119394-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240408153749.119394-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/8/24 5:37 PM, Andy Shevchenko wrote:
> Use GPIO_LOOKUP() macro which provides a compound literal
> and can be used with dynamic data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/x86-android-tablets/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> index a3415f1c0b5f..3f56a9dcba52 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -52,10 +52,8 @@ int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
>  		return -ENOMEM;
>  
>  	lookup->dev_id = KBUILD_MODNAME;
> -	lookup->table[0].key = chip;
> -	lookup->table[0].chip_hwnum = pin;
> -	lookup->table[0].con_id = con_id;
> -	lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
> +	lookup->table[0] =
> +		GPIO_LOOKUP(chip, pin, con_id, active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH);
>  
>  	gpiod_add_lookup_table(lookup);
>  	gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);


