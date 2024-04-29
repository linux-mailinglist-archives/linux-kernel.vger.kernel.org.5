Return-Path: <linux-kernel+bounces-162110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93588B5606
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269151C20AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE23D546;
	Mon, 29 Apr 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmrymyUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1983C482
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388907; cv=none; b=FT4IkyXmEPWQILzs1r0A7sQk7hUJlgUAQXHy1dzA9b3C9YIUZGXbU9Xm7CVdHzVj8lZ9nGOvETNr5bAvFlMHKZiMRw/N7JiwbfnmicO4De3GhES0/sG1FwwHLocxVpQMakUeDbqYeldib7syxtq/noKJFfi/vnEwx2lxIO5RZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388907; c=relaxed/simple;
	bh=rp6+hKC+ad+mgkEi98DBJjCqcJINH+IEzxTI1mkGLxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OZzcQw20geZHqsASEDH2BovWq4ZUAkC/bOWfK450U27Ey4j6bSCOrAqooMug2Ozd0iKY6UChI9TpbO45GysmB//Tyvx9bMUFg9DrPNiEVL36zYtG/xvxNIywkc0jlezBsGpVwXQOXVIHTqqI2APMPr0d/IM9r5E5WsL27lRU3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmrymyUv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714388904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi9Ww5WN0UHN0lPfAwwVKTm5WIJO8LV9mSzNDaozAKk=;
	b=PmrymyUv785GtFKpK2H0ldClJjFfmPkJ6h896xVdfSK6BnxCk+R2ZXdbY+7iPYNhccdgGh
	eB2yWNHLu39xAwa7iedjn8Gm47mVkH9HJA4yRkonWCtBtmhC4/+MspPll18aWwxTc3W9Vp
	LP+lOyID8ABvgGW5TgLysbCFik8welI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-ZkLd8nfjOHi7tkARMYkCbQ-1; Mon, 29 Apr 2024 07:08:22 -0400
X-MC-Unique: ZkLd8nfjOHi7tkARMYkCbQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51acf60fd95so2945543e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714388901; x=1714993701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi9Ww5WN0UHN0lPfAwwVKTm5WIJO8LV9mSzNDaozAKk=;
        b=iQ+JO47wwJ4vkXsWfHQcZC31MfGoiG9VzcQv2K2X13tZYVkq/5W4Xhy/2qN+LBo4DL
         /yv5yW9aiXRZehTKKyaOliBOV5IzyPejkB9JnPe9jCjru645WRPXS9NUJCBED8ZalT8B
         j1k4QjHRPMDgB108MI/BIOehxI7Tt4f1vg2a0txD4GAp5yvd6UuZz6zBHrdLBg9Nha7j
         psXsdCwMzp8THIfnsDGAvlvgkeVW68nHmVM6TPeWtMjPWdv1XG12JovNTXtj69Mzcw41
         RKI7cKdrHptILSoPrCvTfxTKxCgbWqJQuVxpJr80NLzsQj5eliP0IGtYZJ7QLUpQMvnO
         Qg2g==
X-Forwarded-Encrypted: i=1; AJvYcCVP+xesn1WYbh16srVjVew86bfHPwVwkBQb+KVl2xE5G6glT4d2tGj1v6JJcw/I+wlyYtj9tpPTqPZDgzuCiy32LuEQ/MMJSgCXRW18
X-Gm-Message-State: AOJu0Yz8z6Dqnkumas7TOJui2fZP+Dyxke4qHFcrPbKiFIhLsjbUmtvb
	pqJDLREjNcE0idMP5rfFZsrr4xJIC0Tt1JB2Ch9i8sal9EGxwzPa4x+Am+JVWi/Dn44oo9cO86H
	szlIxcGljJlE4/ljlwEgLxfuGPc/fbLe8tHLFGoG+a0oGQMy9b5UsSIPKMVMcwQ==
X-Received: by 2002:ac2:58e4:0:b0:51a:c8ba:d908 with SMTP id v4-20020ac258e4000000b0051ac8bad908mr4900886lfo.62.1714388901466;
        Mon, 29 Apr 2024 04:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8/9kepMq4qGDA0SgBLzUsoTj90wfyKWPp2nBHN74LvVd8ORCf32skRlaD0gI0fxbnFiZi7g==
X-Received: by 2002:ac2:58e4:0:b0:51a:c8ba:d908 with SMTP id v4-20020ac258e4000000b0051ac8bad908mr4900881lfo.62.1714388901138;
        Mon, 29 Apr 2024 04:08:21 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y20-20020a056402271400b00572300f0768sm5885853edd.79.2024.04.29.04.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:08:19 -0700 (PDT)
Message-ID: <3e103075-c170-42e3-928b-41d3bb11e6e8@redhat.com>
Date: Mon, 29 Apr 2024 13:08:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026
 and 2027
To: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20240424065212.263784-1-hpa@redhat.com>
 <20240424065212.263784-3-hpa@redhat.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240424065212.263784-3-hpa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/24/24 8:52 AM, Kate Hsuan wrote:

Maybe start the commit message with:

Add an i2c_device_id id_table to match manually instantiated
(non device-tree / ACPI instantiated) KTD202x controllers as
found on some x86 boards.

?

> This table shows the maximum support LED channel for KTD2026 and KTD-2027.
> The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
> 4-channel LED controller KTD2027 controls R/G/B and flashing LEDs.

Other then that this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Datasheet: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/leds/rgb/leds-ktd202x.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
> index f1c810c415a4..60ca6ec34336 100644
> --- a/drivers/leds/rgb/leds-ktd202x.c
> +++ b/drivers/leds/rgb/leds-ktd202x.c
> @@ -606,6 +606,13 @@ static void ktd202x_shutdown(struct i2c_client *client)
>  	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
>  }
>  
> +static const struct i2c_device_id ktd202x_id[] = {
> +	{"ktd2026", KTD2026_NUM_LEDS},
> +	{"ktd2027", KTD2027_NUM_LEDS},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ktd202x_id);
> +
>  static const struct of_device_id ktd202x_match_table[] = {
>  	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
>  	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
> @@ -621,6 +628,7 @@ static struct i2c_driver ktd202x_driver = {
>  	.probe = ktd202x_probe,
>  	.remove = ktd202x_remove,
>  	.shutdown = ktd202x_shutdown,
> +	.id_table = ktd202x_id,
>  };
>  module_i2c_driver(ktd202x_driver);
>  


