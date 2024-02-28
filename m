Return-Path: <linux-kernel+bounces-85371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FE86B507
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F348B1F2327C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3656A208DA;
	Wed, 28 Feb 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sJzbh4ef"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433801CAAB;
	Wed, 28 Feb 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137917; cv=none; b=XYogkTU77MNzWjgPwKc3DkAQXnqqAw6xUQ1gZJq1WePEJkIS15KKo23N4gcnICNegAKWJH55BvDd5pOPzDVvdNNAez1/MGVAJ3VVwcqhQUCGOV3G6T92oNqcBsVRFdbKL6B5tTDrWhXPwJqPAz99AqfRiyGu/rDBF3XdOIv3rgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137917; c=relaxed/simple;
	bh=Ld3prT7ShGpEOrPCyeYTPU4C15FK30+hWNzqk5w4tzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M36kXw5VIAu1+PQ7T0PKY/cJXTmDVpev/r03RGj2Sx7wLDZGsUd6257DTqNaCdpnEfV5jeotgD3/Watfj3KrNCWlgTMAu4rK26GlQF5g23fgWihZSDtuPatvGoqZmGjSBAjoQlJD0dYfG9P0UzUSdqJpFZefExwpthxUbKczmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sJzbh4ef; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2FAF6B3;
	Wed, 28 Feb 2024 17:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709137899;
	bh=Ld3prT7ShGpEOrPCyeYTPU4C15FK30+hWNzqk5w4tzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJzbh4efxJVI5Wp8EXN+EO7gy5mPR5BrZn2eFX95SDBjruAiHd+hNBrBNd6FlTW8d
	 Aa745wLSXZA4mERHHtlje70Kh40pKUOMRD/6mLBHz1KVwScw20bp1anIiOr/3OA+Cw
	 Yk/f+VdjveJdz5UwfrEZopWkk0g7yojG8O3V0d30=
Date: Wed, 28 Feb 2024 18:31:53 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	aford@beaconembedded.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: adv7511:  Allow IRQ to share GPIO pins
Message-ID: <20240228163153.GH9863@pendragon.ideasonboard.com>
References: <20240228113737.43434-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228113737.43434-1-aford173@gmail.com>

Hi Adam,

Thank you for the patch.

On Wed, Feb 28, 2024 at 05:37:35AM -0600, Adam Ford wrote:
> The IRQ registration currently assumes that the GPIO is
> dedicated to it, but that may not necessarily be the case.
> If the board has another device sharing the IRQ, it won't be
> registered and the hot-plug detect fails.  This is easily
> fixed by add the IRQF_SHARED flag.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index b5518ff97165..21f08b2ae265 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1318,7 +1318,8 @@ static int adv7511_probe(struct i2c_client *i2c)
>  
>  		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
>  						adv7511_irq_handler,
> -						IRQF_ONESHOT, dev_name(dev),
> +						IRQF_ONESHOT | IRQF_SHARED,
> +						dev_name(dev),

This looks fine, but the IRQ handler doesn't.

static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
{
	unsigned int irq0, irq1;
	int ret;

	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
	if (ret < 0)
		return ret;

	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
	if (ret < 0)
		return ret;

	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);

	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder)
		schedule_work(&adv7511->hpd_work);

	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
		adv7511->edid_read = true;

		if (adv7511->i2c_main->irq)
			wake_up_all(&adv7511->wq);
	}

#ifdef CONFIG_DRM_I2C_ADV7511_CEC
	adv7511_cec_irq_process(adv7511, irq1);
#endif

	return 0;
}

static irqreturn_t adv7511_irq_handler(int irq, void *devid)
{
	struct adv7511 *adv7511 = devid;
	int ret;

	ret = adv7511_irq_process(adv7511, true);
	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
}

The function will return IRQ_HANDLED as long as the registers can be
read, even if they don't report any interrupt.

>  						adv7511);
>  		if (ret)
>  			goto err_unregister_audio;

-- 
Regards,

Laurent Pinchart

