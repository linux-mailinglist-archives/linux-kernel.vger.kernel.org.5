Return-Path: <linux-kernel+bounces-85272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730486B349
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C304F281E44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910C15DBA1;
	Wed, 28 Feb 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OxBB1/41"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56814D44E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134640; cv=none; b=MkihTJY64L/yIYqmxaikkNo/9ZR6X26nbI85gB8fBureWcRwQldBvFpSeNXCVIpEkgwdh1Q6TKUJzmQvwDpMw79OzI+8gdXkYKrLsuzLymPzApJatfVk+DnTqXjg0Hv2gtxr1trQv9QGHAiq+LUAcGbuW7RjAF66RQTj+2akhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134640; c=relaxed/simple;
	bh=YrTM7NclhRirvO5ov26nYLcb/cIPqgB149/aYYtK3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IayKjCB3tx4QYb5ZH75k7Rd2Xtxp5DQryoC7hC32hOvOOpWKF25xE9VssEjwDqtncAw3Z075WKeMkNKYVblZ522JY2PpmKn7CN48UB9flQaFqxRszOM3aH4HKSQq27B/zuLcpHhRbkXxV8AIP/A4ZLKY8tOSZ1PLYOlmKV7w/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OxBB1/41; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36523b9fa11so19514885ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709134637; x=1709739437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svD1W1a7QFf9Gza+G3SPXvK0VpFKMCR1+Xi0Z1FWhGs=;
        b=OxBB1/41F8A5SVmH7WKmwol1l9JkBUCE2aZRvp0MoMgt14h5YhBEKDK08u/e6MCRz8
         T3+mQ3gcFNwIx+dA5Jcvhew9h9HqHpI7b/oxrD1SYn5MHEea71e2NRaCgi8lzXD2Gzru
         fjPLs/8qPvLxHxrf1LNf3uxIUgFwv91YrC15U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134637; x=1709739437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svD1W1a7QFf9Gza+G3SPXvK0VpFKMCR1+Xi0Z1FWhGs=;
        b=P3uMeoxW7RlKGAE7BXodFWyUdW4nOhZgOWrBdf4+Mw0H04NjmrD2mDQ+yO8LjKduPC
         PfYvaCeUcQradgIZ45xAmFvtTU+CfFUqpxjGGrugyI+SJETYKP8vAjdXQuNp6blpat9h
         DbPs7E5Y5hLnwODGpqMQAbmaph2lUnG4V43Ft61EBz1o5CsPls+pZjOWUTQf6w68cLIW
         4Lh3Omjymu8zZoY1w800KTlaN0u25PRDrQr2sjjFnObTOd13+VOeASm0/7weDE5wTThp
         rdzQtwpZY8pS/FKb336FAN8Agy/vSzBJoLPfBwS+zAC2gKmCD4OUQJquFSOxwWWZPl6/
         75aA==
X-Forwarded-Encrypted: i=1; AJvYcCWzUalwA3wt610mgqA6O5IjWPGHqpL9Z6/hp2arcKR7I5q1G7q5Nd5YRMcIOyP06v2cd4O88w3weuz1ooYJDizMrZ+YIrxsV7lJUvcj
X-Gm-Message-State: AOJu0YyQeyBN/v/6pygX3QtP3ThcvQy8gaSHoRvMkt4NNKYDCQiZ2Bxa
	jXzMnocGIQg7cJI2MWPVYv20BIku3j3pdS9aw3OVVLDLPAcUmXjqcpv+tfxnzQ==
X-Google-Smtp-Source: AGHT+IFwnHar0bSnDcMYJo9D3FZDjlUk0s+GVf8S+gT0uUdrPI6XVBO5n/eqspfTGLxTLggHdT93YQ==
X-Received: by 2002:a92:de43:0:b0:365:1e8f:1519 with SMTP id e3-20020a92de43000000b003651e8f1519mr13223206ilr.27.1709134637291;
        Wed, 28 Feb 2024 07:37:17 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a056e021b0600b00363ce0ac359sm2766041ilv.47.2024.02.28.07.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:37:16 -0800 (PST)
Date: Wed, 28 Feb 2024 15:37:16 +0000
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
Subject: Re: [PATCH v5 1/8] usb: misc: onboard_hub: use device supply names
Message-ID: <Zd9TLL0IM08Wh63i@google.com>
References: <20240228-onboard_xvf3500-v5-0-76b805fd3fe6@wolfvision.net>
 <20240228-onboard_xvf3500-v5-1-76b805fd3fe6@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228-onboard_xvf3500-v5-1-76b805fd3fe6@wolfvision.net>

Hi Javier,

Thanks for moving this patch to the front of the series!

A few more comments inline.

On Wed, Feb 28, 2024 at 02:51:28PM +0100, Javier Carrasco wrote:
> The current implementation uses generic names for the power supplies,
> which conflicts with proper name definitions in the device bindings.
> 
> Add a per-device property to include real supply names and keep generic
> names for existing devices to keep backward compatibility.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 49 ++++++++++++++++++++------------------
>  drivers/usb/misc/onboard_usb_hub.h | 12 ++++++++++
>  2 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 0dd2b032c90b..3755f6cc1eda 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -29,17 +29,6 @@
>  
>  #include "onboard_usb_hub.h"
>  
> -/*
> - * Use generic names, as the actual names might differ between hubs. If a new
> - * hub requires more than the currently supported supplies, add a new one here.
> - */
> -static const char * const supply_names[] = {
> -	"vdd",
> -	"vdd2",
> -};
> -
> -#define MAX_SUPPLIES ARRAY_SIZE(supply_names)
> -
>  static void onboard_hub_attach_usb_driver(struct work_struct *work);
>  
>  static struct usb_device_driver onboard_hub_usbdev_driver;
> @@ -65,6 +54,30 @@ struct onboard_hub {
>  	struct clk *clk;
>  };
>  
> +static int onboard_hub_get_regulator_bulk(struct device *dev,
> +					  struct onboard_hub *onboard_hub)

Let's call this onboard_hub_get_regulators(), it's an implementation detail
that regulator_bulk_get() is used for getting them.

no need to pass 'dev', there is onboard_hub->dev

>  static int onboard_hub_power_on(struct onboard_hub *hub)
>  {
>  	int err;
> @@ -253,7 +266,6 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct onboard_hub *hub;
> -	unsigned int i;
>  	int err;
>  
>  	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> @@ -264,18 +276,9 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  	if (!hub->pdata)
>  		return -EINVAL;
>  
> -	if (hub->pdata->num_supplies > MAX_SUPPLIES)
> -		return dev_err_probe(dev, -EINVAL, "max %zu supplies supported!\n",
> -				     MAX_SUPPLIES);
> -
> -	for (i = 0; i < hub->pdata->num_supplies; i++)
> -		hub->supplies[i].supply = supply_names[i];
> -
> -	err = devm_regulator_bulk_get(dev, hub->pdata->num_supplies, hub->supplies);
> -	if (err) {
> -		dev_err(dev, "Failed to get regulator supplies: %pe\n", ERR_PTR(err));
> +	err = onboard_hub_get_regulator_bulk(dev, onboard_hub);

The local variable is called 'hub', not 'onboard_hub'.

> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index f360d5cf8d8a..ea24bd6790f0 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -6,54 +6,66 @@
>  #ifndef _USB_MISC_ONBOARD_USB_HUB_H
>  #define _USB_MISC_ONBOARD_USB_HUB_H
>  
> +#define MAX_SUPPLIES 2
> +
>  struct onboard_hub_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
>  	unsigned int num_supplies;	/* number of supplies */
> +	const char * const supply_names[MAX_SUPPLIES]; /* use the real names */

The comment isn't particularly useful or accurate. Not in all cases
real names are used and outside of the context of this change the
comment is hard to understand.

I'd say just omit it, the name of the field is self-documenting enough,
there is no need to repeat the same in a comment (as for 'num_supplies'
..)

