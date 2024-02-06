Return-Path: <linux-kernel+bounces-55464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE32E84BD03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF722B2459F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AE134D2;
	Tue,  6 Feb 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DPsh6ovd"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F520134C1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244862; cv=none; b=P93TV0IHdeMSwOPaQ8WmrI2vjG6CU4XKCy6ODRxudgnX9LyCWCIE+9L1FVDgjHuC7cT4K0ttpLz/ytEn4S0th+hjy7hSeKIviNw585CMUkkgUCNDaynT2UhMb5fZXvkLAFAaSwpdVbpb9n23jN/SzadrMykeV26MmoYi5roWnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244862; c=relaxed/simple;
	bh=4iMUCDRK0tbwCoq9ax96HYxDL0mnKXeCT6CGUsUHlLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4hNrOkYw0eakmn1I4EYrbe6NPh61dfEMSeNKdmpWlPSyPy4w8aVy4UA4gftA+LkU6yXxKyzP5W63OseVRNKrDM50t0HLnahFa35Lb2h5OZ1u0sNdpn4SO1/850PZtOmmoWwarGuvNYQcXkyWIBxLneJXtmdKAUVdPYrFExS8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DPsh6ovd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363ca193a7eso3576805ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707244859; x=1707849659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xv9kD5QhjTCn8Q0pWh79kSOAjDdZQG/rInb+Rd12sQ=;
        b=DPsh6ovd0cSK3rj11e7ONTc9yz4uuL4plAcyRNbUMiqMVKxKvyoTCkcn8eft79qa5n
         E5Ej7nCko1mRC8nRJD0d9KbAaJ0swKBgccCdwXXQe94PGxgWjNayxEJDXRCvnLiF72Lb
         VX3PPsAlCLzAeL78dYMIlvMKjrTUdDn4fOhzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244859; x=1707849659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Xv9kD5QhjTCn8Q0pWh79kSOAjDdZQG/rInb+Rd12sQ=;
        b=v32Y1p3NqLR09z6aKamhWvV8c93wC1L3ZHb4PuUey1C+c8GziIz9sUzsvbnLgtBgFz
         mmWhqb4uBJjMxj4yPhIrUorFzr8rFcbvdOc93q2NT/gQa9Cd9Gx94M2QXCrSxHLaX/8N
         +73+OMLmt7NpK6hEqrGNKLfEEM0ghLULJN7nsPZmrLSyuB4wrtJgFovSFDYv/RcNsYTJ
         t6eUfBSF9mh2YNedNuyqgKUb0K7VKMhwZ1cN0oiIC4QeLlztR8COSP0+uvARD1VUXSmH
         S1LF2FWbj6pwrtGVbVn2rabI7CAIR/czlzdpbLY3nTP48vOznENTuXP3BCVreiciZu67
         SnhA==
X-Gm-Message-State: AOJu0YxXr1qL+1IelELsFgGHLQQPxGhuzCoGhUZ2k+khg4fcKntbgvHv
	aBLGK/K5BLKZXjd8vjfllz+vDyEiteoVQlq3SsMDcPgNHuGNJRaEIhA6gwgLsQ==
X-Google-Smtp-Source: AGHT+IH/hHo4kYBuL5vCw54nvX8pPrZtO2JH3Q3ZlUbStO7TCJYcZnDxXL5gfiQUMQeIheFecJGkuw==
X-Received: by 2002:a92:cd83:0:b0:363:bc81:47f8 with SMTP id r3-20020a92cd83000000b00363bc8147f8mr4910691ilb.21.1707244859728;
        Tue, 06 Feb 2024 10:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVr5FtOxk/NPujxjkxVAGBIFYTCd68ni8q4C1vR0Wa9BaHegqYv6Q/GEOczSL0kI7ZNx6NBqpgs/wUd+QwVY/bt2uow70wn0cCw60Ehlx08PSO77hd2EZVpWqo4AapEYw3YL4eqqbIbPqWQvR9Vt9O/5t6PDaYGIr6qV9Wo+TcT2yRmiwA05PSd2BW/A89Jy5THeLi8iOxte+gFCo/IFA90t0CNAvJJioD9eBrRbpV5AncwkM3WxgE2x00ewnfaOKO586M2Yl7Qqd7ZjwbfjLgVhi4450iNxIsjGrTDiEyFnWfNuVRNSlm5cPa4vc6uuER8wO0H2XAkA5IJrM7V/CkTgUi6u6hHVcMi1hWrzGjYQF5tV2O5tZJxKLpEVsa4UbBs1Dpa2gEoJfTnLFc=
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id t5-20020a05663801e500b00471476d36a1sm234311jaq.116.2024.02.06.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:40:59 -0800 (PST)
Date: Tue, 6 Feb 2024 18:40:58 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/7] usb: misc: onboard_dev: add support for non-hub
 devices
Message-ID: <ZcJ9OnYOtUVMu2Yk@google.com>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-2-f85b04116688@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206-onboard_xvf3500-v3-2-f85b04116688@wolfvision.net>

On Tue, Feb 06, 2024 at 02:59:30PM +0100, Javier Carrasco wrote:
> Most of the functionality this driver provides can be used by non-hub
> devices as well.
> 
> To account for the hub-specific code, add a flag to the device data
> structure and check its value for hub-specific code.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/misc/onboard_usb_dev.c |  3 +++
>  drivers/usb/misc/onboard_usb_dev.h | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index e2e1e1e30c1e..3ac21ec38ac0 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -123,6 +123,9 @@ static int __maybe_unused onboard_dev_suspend(struct device *dev)
>  	if (onboard_dev->always_powered_in_suspend)
>  		return 0;
>  
> +	if (!onboard_dev->pdata->is_hub)
> +		return onboard_dev_power_off(onboard_dev);

Why turn the device always off when it isn't a hub? It could be a device
with wakeup support.

I really regret making 'off in suspend' the default :(

> +
>  	mutex_lock(&onboard_dev->lock);
>  
>  	list_for_each_entry(node, &onboard_dev->udev_list, list) {
> diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
> index f13d11a84371..ebe83e19d818 100644
> --- a/drivers/usb/misc/onboard_usb_dev.h
> +++ b/drivers/usb/misc/onboard_usb_dev.h
> @@ -9,51 +9,61 @@
>  struct onboard_dev_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
>  	unsigned int num_supplies;	/* number of supplies */
> +	bool is_hub;
>  };
>  
>  static const struct onboard_dev_pdata microchip_usb424_data = {
>  	.reset_us = 1,
>  	.num_supplies = 1,
> +	.is_hub = true,

Depending on when 'is_hub' is checked it could be an option to initialize
it at runtime (depending on USB_CLASS_HUB), e.g. in onboard_dev_add_usbdev().
Might not be worth the hassle tough if more than the current check(s) get
added.

>  };
>  
>  static const struct onboard_dev_pdata microchip_usb5744_data = {
>  	.reset_us = 0,
>  	.num_supplies = 2,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata realtek_rts5411_data = {
>  	.reset_us = 0,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata ti_tusb8041_data = {
>  	.reset_us = 3000,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata cypress_hx3_data = {
>  	.reset_us = 10000,
>  	.num_supplies = 2,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata cypress_hx2vl_data = {
>  	.reset_us = 1,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata genesys_gl850g_data = {
>  	.reset_us = 3,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata genesys_gl852g_data = {
>  	.reset_us = 50,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct onboard_dev_pdata vialab_vl817_data = {
>  	.reset_us = 10,
>  	.num_supplies = 1,
> +	.is_hub = true,
>  };
>  
>  static const struct of_device_id onboard_dev_match[] = {
> 
> -- 
> 2.40.1
> 

