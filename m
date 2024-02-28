Return-Path: <linux-kernel+bounces-85589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB9786B810
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071141C2181C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E57443B;
	Wed, 28 Feb 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GS7ODvLr"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2997440E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148141; cv=none; b=H+BQZ2ZRjiW8h4fBXVURMl/NYHbST7JtiftNQlDJnEheFuHoRpxasG6V1m+Y2kt+TyDL5/o+EaCv+OQjS2wB6IJUAvXqbj2JKMstxwWy81gjSDr8KKBGOug72gb2U8Oh4foI4VVYv3edTXjwYK8Iu1dW6oKKdagvxRDFJV7Rxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148141; c=relaxed/simple;
	bh=Ys3XowIf0bm7jRKzuc3PtxqeRx99FE+WClNAKD56B0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5KzamsKKq6gIMPXog49BlbbyW/iPo+VRIoZWW9r/dpaKRmQRCxAOK82YaI6lhCVIzgZfrwRtMJFQoH8f+4An3M0odyhdEf/OzR0MXaZxdgDN8bP9TkqdyAdr80r8K3eOHVT2DkcRz8PG6ElUVVco0yszbFOPcFiiAtEU/vpcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GS7ODvLr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36519980c04so538565ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709148139; x=1709752939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWZCONUO1eBq93ur5BQyYMDhfKl8EM5yFU5z78+cztc=;
        b=GS7ODvLrZ4WkXb2ylj9Rf3E1euju9QWLterM4AEx2bYAGFy2rrORH9vfuC9tFZO0By
         cLddsajAj9eDh5NVIrUGEeLVOZJjMerOWUP9cDdxZjRvW/5+BGnr1znbzLtdjsIJx6Xl
         WAJJBUyZKOCDN4elNbpazW6tcVnWpWhgfZHYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148139; x=1709752939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWZCONUO1eBq93ur5BQyYMDhfKl8EM5yFU5z78+cztc=;
        b=NAhqcxFjwl5ZSbQStJ2s0GPImacbQS/Ghk6e0zofxuU4poDX2eqgF6SGgnnMJZPo/S
         yXeD0JivTgjaf0EN7jVc8Y+SZtTQl20D9yYjSPzi8AUM8K+U1rwguhL6Ri6F1fOFSqgz
         KRKaEUWI3PRsY3Xdu3LpwLJxJoUiZiuA79q6D5EMs5OBdPBH59xuKTINNiT7ow31QPMH
         gYPhYJuBD9rmwdrzgEC9cXcc9qBSMPuWeUAH0Wi3M+OrclBeSaIwOz5IzbIJS/hNnuTR
         +pXaCErSiljM+G9HGmzACGgysKPvFYfWXZgwkhwuAdDLIc0/vLyNuxuJL4zHpWvgizLJ
         4bRg==
X-Forwarded-Encrypted: i=1; AJvYcCVd08Y9uZQ6M3NwSS3u6NGrhBP1oZodkGSeO++Lng/FO+OxM0XmgpNjp29n39rlcbY8BdVdi59S8vZx1Ij8d8Y1dDEt+hSrdsrTnahT
X-Gm-Message-State: AOJu0YwHt6majYHKDG+htgOOuYOGydCPAQg7eJNG3m5KjYsq9qhHL4dv
	LGTTLrIWJnwhqQCPkqZrpAXXzjtQhqgsXoyfi92++osYMxWfznW28tIpbvz6xA==
X-Google-Smtp-Source: AGHT+IFqbcv66YZt2FKNF964iMhI6GTiYtKK3x/4hGk7YfuhA2JWmeUUh4jB5yMEezmNt7X9tFEO2w==
X-Received: by 2002:a92:c5a9:0:b0:365:a9fd:1a7a with SMTP id r9-20020a92c5a9000000b00365a9fd1a7amr178874ilt.26.1709148139247;
        Wed, 28 Feb 2024 11:22:19 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id x3-20020a92d643000000b003638f9a9debsm10233ilp.75.2024.02.28.11.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:22:18 -0800 (PST)
Date: Wed, 28 Feb 2024 19:22:18 +0000
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
Subject: Re: [PATCH v5 8/8] usb: misc: onboard_hub: add support for XMOS
 XVF3500
Message-ID: <Zd-H6hVPv1poXoa1@google.com>
References: <20240228-onboard_xvf3500-v5-0-76b805fd3fe6@wolfvision.net>
 <20240228-onboard_xvf3500-v5-8-76b805fd3fe6@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228-onboard_xvf3500-v5-8-76b805fd3fe6@wolfvision.net>

On Wed, Feb 28, 2024 at 02:51:35PM +0100, Javier Carrasco wrote:
> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.
> 
> This device requires a specific power sequence, which consists of
> enabling the regulators that control the 3V3 and 1V0 device supplies,
> and a reset de-assertion after a delay of at least 100ns. Such power
> sequence is already supported by the onboard_hub driver, and it can be
> reused for non-hub USB devices as well.

Please update the commit message, the onboard_hub driver no longer
exists as such with the other patches of this series.

> Once in normal operation, the XVF3500 registers itself as a USB device,
> and it does not require any device-specific operations in the driver.
> 
> [1] https://www.xmos.com/xvf3500/
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

> ---
>  drivers/usb/misc/onboard_usb_dev.c | 2 ++
>  drivers/usb/misc/onboard_usb_dev.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index df0ed172c7ec..50f84c5278a2 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -405,6 +405,7 @@ static struct platform_driver onboard_dev_driver = {
>  #define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_TI		0x0451
>  #define VENDOR_ID_VIA		0x2109
> +#define VENDOR_ID_XMOS		0x20B1
>  
>  /*
>   * Returns the onboard_dev platform device that is associated with the USB
> @@ -497,6 +498,7 @@ static const struct usb_device_id onboard_dev_id_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_XMOS, 0x0013) }, /* XVF3500 */

nit: be a bit more specific? e.g. XVF3500 Voice Processor, or XMOS XVF3500

The other entries were implicitly hubs since this was the 'onboard_hub'
driver. It wouldn't be a bad idea to add 'hub' to these entries in the
patch that 'renames' the driver.

