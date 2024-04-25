Return-Path: <linux-kernel+bounces-158994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62BD8B27E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CD71F219FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5114EC71;
	Thu, 25 Apr 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6XUY3s/"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695C14EC41
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068511; cv=none; b=GjDIjylXYyu9o0PvrfFfScCjHxiBDrTbjOq5Gy3NcmtYFAfpKUJ+3R1R2ZeMvou0eZ8jpTOK57CV1ZvosET8JKhsaVrs+Acc0UP4mNrm7qUbZmCBf4S9E3rzXSZzyfpkfqDGd9Tx9dd5wbO+rlDVY2XhYNJ9kMz/fNR5+fBssIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068511; c=relaxed/simple;
	bh=dNk5QdHnDIyLORxtgN+YesJMvggVqKa3+rnupN3D+I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI2r2r9udqbN35MU/c342jPeKq0eIvQihRPxRX4wzi3p6S9iIEb5g2isGcjs7Sdx2En8DeIi078qnNDCOrjrmfsunQlTXSqXTgj+eE740oFAABbJJbMHtKZ/7vVzcQowWZ12xHBUQ0LiYslT7u05WZEyHBBF8g6RH+8fC0is8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V6XUY3s/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714068507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWLZbxE4pquTcFK2sC6uHz/6X8LbxFLR+lPzPVowoAE=;
	b=V6XUY3s/yowyYrBdecWJcBBkXnUn9+9vpFbwK551wN0+SOKm7Ff2XWsn51YCUPrf/rvTp8
	XV+KCTJFl8kG4+enR5m5IrjJWtqxw3bhA6oldYM7RLoHR533pmt+TyCqldHz1i9anb39Dk
	NxlgmjdC29r1KEjl3IkSDTm6grqK3sc=
Date: Fri, 26 Apr 2024 02:08:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/25 22:26, Andy Shevchenko wrote:
> It seems driver missed the point of proper use of device property APIs.
> Correct this by updating headers and calls respectively.

You are using the 'seems' here exactly saying that you are not 100% sure.

Please allow me to tell you the truth: This patch again has ZERO effect.
It fix nothing. And this patch is has the risks to be wrong.

Simple because the "ili9341_probe() ---> ili9341_dbi_prob()" code path
is DT dependent.

First of all, the devm_of_find_backlight() is called in ili9341_dbi_probe()
under *non-DT* environment, devm_of_find_backlight() is just a just a
no-op and will return NULL. NULL is not an error code, so ili9341_dbi_probe()
won't rage quit. But the several side effect is that the backlight will
NOT works at all.

It is actually considered as fatal bug for *panels* if the backlight of
it is not light up, at least the brightness of *won't* be able to adjust.
What's worse, if there is no sane platform setup code at the firmware
or boot loader stage to set a proper initial state. The screen is complete
dark. Even though the itself panel is refreshing framebuffers, it can not
be seen by human's eye. Simple because of no backlight.
   
Second, the ili9341_dbi_probe() requires additional device properties to
be able to works very well on the rotation screen case. See the calling
of "device_property_read_u32(dev, "rotation", &rotation)" in
ili9341_dbi_probe() function.

Combine with those two factors, it is actually can conclude that the
panel-ilitek-ili9394 driver has the *implicit* dependency on 'OF'.
Removing the 'OF' dependency from its Kconfig just trigger the
leakage of such risks.
  
My software node related patches can help to reduce part of the potential
risks, but it still need some extra work. And it is not landed yet.


> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                | 2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index e54f6f5604ed..2d4515555820 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -177,7 +177,7 @@ config DRM_PANEL_ILITEK_IL9322
>   
>   config DRM_PANEL_ILITEK_ILI9341
>   	tristate "Ilitek ILI9341 240x320 QVGA panels"
> -	depends on OF && SPI
> +	depends on SPI
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
>   	depends on BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 3574681891e8..7584ddb0e441 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -22,8 +22,9 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/spi/spi.h>
>   
> @@ -691,7 +692,7 @@ static int ili9341_dpi_probe(struct spi_device *spi, struct gpio_desc *dc,
>   	 * Every new incarnation of this display must have a unique
>   	 * data entry for the system in this driver.
>   	 */
> -	ili->conf = of_device_get_match_data(dev);
> +	ili->conf = device_get_match_data(dev);
>   	if (!ili->conf) {
>   		dev_err(dev, "missing device configuration\n");
>   		return -ENODEV;

-- 
Best regards,
Sui


