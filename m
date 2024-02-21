Return-Path: <linux-kernel+bounces-75457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F485E8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE5EB215F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6928663A;
	Wed, 21 Feb 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nH1No7aR"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434686130
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547119; cv=none; b=nVDCBCJtUzniRsYH7eKPIkpI4EecgLLQKfl/UIOYmGc9CNhgMZeRl61Haw+Q8Ypx1wFMWR15Pn7jfz5l4s1cd3m7WNoVs6dAH3VtxUGWkwNyjP24adMWo8h7Is81DNLHH7000w5uXbO0ufLTw6DyODkov5DfkKmXVnJTdWECmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547119; c=relaxed/simple;
	bh=4ZjH8dxUFZOI1zVzMUB0DO2W/+qELnvAjGzj7eUOXkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohpRcj+xzVnLS62OQOMA8xpTCMV4LEB6UaKRBUbKh7EkZWskKAosKNiGlfpEyIe3RVcfrDizrs/aq7f/6pYmhy/HvagMWFhvXAEb2m9Ljb4+UMV365UxJCRLkJcQPq2OKHAPTRFEBnLYT6VLDxKyH1mG68nv9YvhftJsjanL5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nH1No7aR; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so305125839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708547117; x=1709151917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wkgeRh9IF6PLJzH5c/hW4z1k21RwGIOmpMXRCu5Jsc=;
        b=nH1No7aRx5mIpcSh/u+QOuiKABSKvW+RaL+U4Wdx5PJQ62e83+VABPP8fZHlhL1VEv
         E00tjqIEhvj83yCUREo2wnDZ8+386GVXahNb2igRCMIMbAmtjldNtc2s6wibcUUfRcU/
         7lGUgXnMoxAb9FGwbk0LSo9zjKdJXm9sDU2sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547117; x=1709151917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wkgeRh9IF6PLJzH5c/hW4z1k21RwGIOmpMXRCu5Jsc=;
        b=PK8Dc3E/2XyBqYaNI5FqWI0VlWHcXlJc/8t+hlf6FfPzgf4a/avVAoqfbC3PgZN/iR
         uJVzhu3xMVHnD81xmYCLF51mqiOKuut5cQ9682R6ddL2Pej5Qr+CpEXH0EOqOqJ1ccOE
         /RTTliRN3HWsoV4q7pr/Y/an9OBgYIpc15/UQBblsMOs0UD63T7EQ22nj9EyOZrx3dO6
         5BuuzDOWiCH6kgx2K0gOTuPM7/ePjkPha/4rE8gl8awUfK0Kgv5+i/kVr4tmhzcblo51
         MNLptIGklVUc4K1e4MMUazRUkab+tuFW3g89iaW0WdIA44qwFQRjWOEn2mKkn2urh9TA
         Gwlw==
X-Forwarded-Encrypted: i=1; AJvYcCX8J+eJRpx2YPqBsfqs5DQcYYpV2h2xJK34mCfT6aFdKzPM/9nn3njMr+VkZU0Xjl2BecQfyetV2HU0A+iH/HFWNyKWv+T/ZYU382Vb
X-Gm-Message-State: AOJu0YxyS22vRG28adltIyEUV3VQXQRnVfUUqZaeGx639aBfhl6Opb75
	0gFsJdepKWZTANdrlWdweAYahEN83wHdS58cnmRI0pEa8SsXj1ZhwfGraynXqg==
X-Google-Smtp-Source: AGHT+IHHf/4LjAJjVkP9U0N3B1K1orn7osgB11jKx5iI8zxropaoPlYRW14hh4HVSps9PWMjT6jAMg==
X-Received: by 2002:a05:6602:3408:b0:7c4:8a72:d17b with SMTP id n8-20020a056602340800b007c48a72d17bmr24641170ioz.13.1708547117013;
        Wed, 21 Feb 2024 12:25:17 -0800 (PST)
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id b99-20020a0295ec000000b004742c0fafb5sm1724032jai.15.2024.02.21.12.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 12:25:16 -0800 (PST)
Date: Wed, 21 Feb 2024 20:25:16 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/8] usb: misc: onboard_dev: use device supply names
Message-ID: <ZdZcLOlSc3FScjLK@google.com>
References: <20240220-onboard_xvf3500-v4-0-dc1617cc5dd4@wolfvision.net>
 <20240220-onboard_xvf3500-v4-6-dc1617cc5dd4@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220-onboard_xvf3500-v4-6-dc1617cc5dd4@wolfvision.net>

On Tue, Feb 20, 2024 at 03:05:50PM +0100, Javier Carrasco wrote:
> The current mechanism uses generic names for the power supplies, which
> conflicts with proper name definitions in the device bindings.
> 
> Add a per-device property to include real supply names and keep generic
> names as a fallback mechanism for backward compatibility.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/misc/onboard_usb_dev.c | 54 ++++++++++++++++++++------------------
>  drivers/usb/misc/onboard_usb_dev.h | 23 ++++++++++++++++
>  2 files changed, 52 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index f43130a6786f..e66fcac93006 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -29,18 +29,6 @@
>  
>  #include "onboard_usb_dev.h"
>  
> -/*
> - * Use generic names, as the actual names might differ between devices. If a new
> - * device requires more than the currently supported supplies, add a new one
> - * here.
> - */
> -static const char * const supply_names[] = {
> -	"vdd",
> -	"vdd2",
> -};
> -
> -#define MAX_SUPPLIES ARRAY_SIZE(supply_names)
> -
>  static void onboard_dev_attach_usb_driver(struct work_struct *work);
>  
>  static struct usb_device_driver onboard_dev_usbdev_driver;
> @@ -66,6 +54,33 @@ struct onboard_dev {
>  	struct clk *clk;
>  };
>  
> +static int onboard_dev_get_regulator_bulk(struct device *dev,
> +					  struct onboard_dev *onboard_dev)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	const char * const *supply_names = onboard_dev->pdata->supply_names;
> +
> +	if (onboard_dev->pdata->num_supplies > MAX_SUPPLIES)
> +		return dev_err_probe(dev, -EINVAL, "max %zu supplies supported!\n",
> +				     MAX_SUPPLIES);
> +
> +	if (!supply_names[0])
> +		supply_names = generic_supply_names;

Please change to 'if (!supply_names)' and omit the initialization of
supply_names for devices that use the generic supply names.

> diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
> index ebe83e19d818..59dced6bd339 100644
> --- a/drivers/usb/misc/onboard_usb_dev.h
> +++ b/drivers/usb/misc/onboard_usb_dev.h
> @@ -6,63 +6,86 @@
>  #ifndef _USB_MISC_ONBOARD_USB_DEV_H
>  #define _USB_MISC_ONBOARD_USB_DEV_H
>  
> +/*
> + * Fallback supply names for backwards compatibility. If the device requires
> + * more than the currently supported supplies, add a new one here, and if
> + * possible, the real name supplies to the device-specific data.
> + */
> +static const char * const generic_supply_names[] = {
> +	"vdd",
> +	"vdd2",
> +};
> +
> +#define MAX_SUPPLIES ARRAY_SIZE(generic_supply_names)

This will have to change when support for a device with more than 2 non-generic
supply names gets added. Please use a literal value for MAX_SUPPLIES instead of
ARRAY_SIZE. If the literal is 2 it would still need to change for future devices
with more supplies, but that change would be more straighforward.

> +
>  struct onboard_dev_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
>  	unsigned int num_supplies;	/* number of supplies */
>  	bool is_hub;
> +	const char * const supply_names[MAX_SUPPLIES];
> +
>  };
>  
>  static const struct onboard_dev_pdata microchip_usb424_data = {
>  	.reset_us = 1,
>  	.num_supplies = 1,
> +	.supply_names = { NULL },
>  	.is_hub = true,
>  };
>
> ...

