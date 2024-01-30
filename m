Return-Path: <linux-kernel+bounces-44906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0878428E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576B51F2AFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C51272AF;
	Tue, 30 Jan 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cy/SV3Ri"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BE86AD8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631092; cv=none; b=V4BYuoNld6ea9V2COrvHMcLztznQuW2bzyHyxolOEXt0C8QFMGmDTiWMlYdIttx8FoydnxDybj4Xyo7Ay3JZGuZt+MvDUTcK9G0yqUvEHosBwLmyUeygO53F93ofN3z/SEkjs+r3EhNvoGtu9noKoSGn0sqkXw6X+4R9w6HYRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631092; c=relaxed/simple;
	bh=sYWsCKIWnBM4AENxDQMd45ylfzFl6TepGmycJDjJUG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iYZRl5qP52fmLVHD5CAbWyh1VQOA/foE6ngLtXI2qvWBAqPFhHwl1QIXtCHOFyGHZiLLyS0QYP2h4MfbAktYGlpui7dPJj5pCSGeQFYOBQAsyXVt9E+wi2irYnXb3MhYkmFYFX0p9BjDE6Syt6Zr0uL7Ly3kLGosOcvGTOfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cy/SV3Ri; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c00128de31so56812339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706631090; x=1707235890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bycNLFVVPkFg+rgPX8u0j7Km8vshueoEwQ1p4ROc4C8=;
        b=Cy/SV3RiyoPPMsmVaZXxEHPO34JAkE/pIPClbSvwgwEMMpH2pD8NOiB6FzTJrGNlgO
         vf8DHoSLKJM7TOeTjXBdzaU7oKMfpXJCIh3K2xSvNaQWjIzCPdhtLUY3AYgxY0dx85VM
         hLc0O4O58mPqULm5omiC7o4MdwJ9xUcRl3YFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631090; x=1707235890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bycNLFVVPkFg+rgPX8u0j7Km8vshueoEwQ1p4ROc4C8=;
        b=xUNLbKPqlvmovaEzmApH54UNM1PzRQANsWsRy2NNoxTVfgrIRA5fXiHcV1sIuFEyUr
         S+5BmN3j8QnwkTyrUYh1X6bbaaYCYjTjJ7UJCw9bmp2wiAqDd5pEsvi/MlUF1DSWJUCa
         HLIbKHKmIlhr8F0F65aSwutNh7NSm1c2GUJX6n1/ZIUeb8kivkQpXVBbq0FsaubXIK2t
         2XkOIkCmfpmOri2trpxbabm52GArk32dK7qSRHccZGbcG6zERrBAiKrZzLQmwBk889jL
         oTz9ah0xAJovztVUaNe7AyRshfLvjo8qEvlwVwl4BkGjNmq5dIQfo2HvjYPCOqRnZr3t
         5o2w==
X-Gm-Message-State: AOJu0Yzwhf/+qHNngujG5YH6N3P+3qygvi8BQyCxNXJaYLQ3y4/KuYZ9
	zaaV4U0LPP+F2SOmtGcm1OENQmt8F5fV5Ohi0kpsbulNOi8K/aoOhXIbAvKxCQ==
X-Google-Smtp-Source: AGHT+IG5sSkp5z9PUe5cWJUnvBDvMkF79YkCb7M0iKqqHEhgc5zAuPWw8mr3XF3mNKLQkDLYuCx6Uw==
X-Received: by 2002:a05:6602:2d89:b0:7bf:b56c:ac25 with SMTP id k9-20020a0566022d8900b007bfb56cac25mr15008085iow.0.1706631090289;
        Tue, 30 Jan 2024 08:11:30 -0800 (PST)
Received: from localhost (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with UTF8SMTPSA id p5-20020a02b385000000b0046ebddc03fbsm2312569jan.33.2024.01.30.08.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:11:29 -0800 (PST)
Date: Tue, 30 Jan 2024 16:11:29 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: misc: onboard_hub: add support for XMOS XVF3500
Message-ID: <ZbkfsVr-1pOTa1ic@google.com>
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-2-51b5398406cb@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130-onboard_xvf3500-v1-2-51b5398406cb@wolfvision.net>

Hi Javier,

I understand your motivation for using the onboard_usb_hub driver
for powering up a non-hub device, it feels a bit hacky to use it
as is though. Re-using the driver might be the right thing to do,
but then it should probably be renamed to onboard_usb_dev (or
similar) and do the hub specific bits as special case.

Greg, do you have any thoughts on this?

Also there is an implication that might not matter for the
XVF3500, but could for other non-hub devices with wakeup support:
by default the driver powers the hub/device down during suspend,
unless (in case of a hub) wakeup capable devices are connected.
This behavior can be changed through sysfs, but the default
would still be unexpected. In hindsight I think the default
should have been to keep the hub powered. Not sure if it's an
option to change the default at this point, since folks might
rely on it (I know systems that do, but those could be adapted).
We could possibly change the behavior for non-hub devices and
keep the device powered if wakeup is supported and enabled

m.

On Tue, Jan 30, 2024 at 01:26:57PM +0100, Javier Carrasco wrote:
> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.
> 
> This device requires a specific power sequence, which consists of
> enabling the regulators that control the 3V3 and 1V0 device supplies,
> and a reset de-assertion after a delay of at least 100ns. Such power
> sequence is already supported by the onboard_hub driver, and it can be
> reused for non-hub USB devices as well.
> 
> Once in normal operation, the XVF3500 registers itself as a USB device,
> and it does not require any device-specific operations in the driver.
> 
> [1] https://www.xmos.com/xvf3500/
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 2 ++
>  drivers/usb/misc/onboard_usb_hub.h | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 0dd2b032c90b..f16ea3053f84 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -366,6 +366,7 @@ static struct platform_driver onboard_hub_driver = {
>  #define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_TI		0x0451
>  #define VENDOR_ID_VIA		0x2109
> +#define VENDOR_ID_XMOS		0x20B1
>  
>  /*
>   * Returns the onboard_hub platform device that is associated with the USB
> @@ -458,6 +459,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_XMOS, 0x0013) }, /* XMOS XVF3500 */
>  	{}
>  };
>  MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index f360d5cf8d8a..1809c0923b98 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -56,6 +56,11 @@ static const struct onboard_hub_pdata vialab_vl817_data = {
>  	.num_supplies = 1,
>  };
>  
> +static const struct onboard_hub_pdata xmos_xvf3500_data = {
> +	.reset_us = 1,
> +	.num_supplies = 2,
> +};
> +
>  static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
>  	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
> @@ -77,6 +82,7 @@ static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usb2109,817", .data = &vialab_vl817_data, },
>  	{ .compatible = "usb2109,2817", .data = &vialab_vl817_data, },
> +	{ .compatible = "usb20b1,0013", .data = &xmos_xvf3500_data, },
>  	{}
>  };
>  
> 
> -- 
> 2.39.2
> 

