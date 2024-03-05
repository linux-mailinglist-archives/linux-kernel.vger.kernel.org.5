Return-Path: <linux-kernel+bounces-92587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DA0872286
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D071C21763
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17B1272B2;
	Tue,  5 Mar 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LucUjNmI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971A126F11
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651831; cv=none; b=g52dbNWn9AYrK+liwLjjWkw91NXpvFT7iV8mQoxIlPb0/aXTEyedjhr4d9aGWhF8Vwkwhi1AuC/LHGxoCPSYVJnAn5zPIaDtop3tcAUAtUtWY3JvpRb/wDe8cEDzfXvBXc98MopgVJMvpTzgA0r79CXBwToA2VgOVaZBNjHto4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651831; c=relaxed/simple;
	bh=UBEdaobsAJ/RjTCc0B7vnfs+RuHFw5jINJSSUXaUtmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvl8B5VEcJtihahdtp3wxN8pLP6wvGrO/4+Mztiup02LI++9VYnTIuanASR5X6n1D26iuraAZslZzdldWxfi/10ddPCbAVCmBJFYDbpl14GjyehQDvyhaCYMO19OlUu/h7GYp5J0JjiASJcaXQzqhpH39BUe1JTrMqJ77YL7+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LucUjNmI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EBB7D8D0;
	Tue,  5 Mar 2024 16:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709651811;
	bh=UBEdaobsAJ/RjTCc0B7vnfs+RuHFw5jINJSSUXaUtmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LucUjNmIuv35SolmEs0QX4TdFDr5H5g3XVJFI6j989OzK68FYIcUcdQwdRkuFXQQ7
	 Bkknjmd5TvR/o0wm1MYdl7Qh4x9Xny/hvs7mhp2H0ZW6niFdJmlCWqapmyaqmC6LAO
	 4XX5CIVsPUi37PD0Sc3P/pYnxuCmGIUFEtVOguvY=
Date: Tue, 5 Mar 2024 17:17:09 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH v3 1/2] drm/bridge: adv7511: rearrange hotplug work code
Message-ID: <20240305151709.GF12482@pendragon.ideasonboard.com>
References: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
 <20240219-adv7511-cec-edid-v3-1-445aed2f1cd7@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219-adv7511-cec-edid-v3-1-445aed2f1cd7@bang-olufsen.dk>

Hi Alvin,

Thank you for the patch.

On Mon, Feb 19, 2024 at 09:12:58PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> In preparation for calling EDID helpers from the hotplug work, move the
> hotplug work below the EDID helper section. No functional change.
> 
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 120 ++++++++++++++-------------
>  1 file changed, 62 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 8be235144f6d..5ffc5904bd59 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -406,64 +406,6 @@ static void adv7511_power_off(struct adv7511 *adv7511)
>   * Interrupt and hotplug detection
>   */
>  
> -static bool adv7511_hpd(struct adv7511 *adv7511)
> -{
> -	unsigned int irq0;
> -	int ret;
> -
> -	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
> -	if (ret < 0)
> -		return false;
> -
> -	if (irq0 & ADV7511_INT0_HPD) {
> -		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> -			     ADV7511_INT0_HPD);
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static void adv7511_hpd_work(struct work_struct *work)
> -{
> -	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
> -	enum drm_connector_status status;
> -	unsigned int val;
> -	int ret;
> -
> -	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
> -	if (ret < 0)
> -		status = connector_status_disconnected;
> -	else if (val & ADV7511_STATUS_HPD)
> -		status = connector_status_connected;
> -	else
> -		status = connector_status_disconnected;
> -
> -	/*
> -	 * The bridge resets its registers on unplug. So when we get a plug
> -	 * event and we're already supposed to be powered, cycle the bridge to
> -	 * restore its state.
> -	 */
> -	if (status == connector_status_connected &&
> -	    adv7511->connector.status == connector_status_disconnected &&
> -	    adv7511->powered) {
> -		regcache_mark_dirty(adv7511->regmap);
> -		adv7511_power_on(adv7511);
> -	}
> -
> -	if (adv7511->connector.status != status) {
> -		adv7511->connector.status = status;
> -
> -		if (adv7511->connector.dev) {
> -			if (status == connector_status_disconnected)
> -				cec_phys_addr_invalidate(adv7511->cec_adap);
> -			drm_kms_helper_hotplug_event(adv7511->connector.dev);
> -		} else {
> -			drm_bridge_hpd_notify(&adv7511->bridge, status);
> -		}
> -	}
> -}
> -
>  static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>  {
>  	unsigned int irq0, irq1;
> @@ -600,6 +542,68 @@ static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
>  	return 0;
>  }
>  
> +/* -----------------------------------------------------------------------------
> + * Hotplug handling
> + */
> +
> +static bool adv7511_hpd(struct adv7511 *adv7511)
> +{
> +	unsigned int irq0;
> +	int ret;
> +
> +	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
> +	if (ret < 0)
> +		return false;
> +
> +	if (irq0 & ADV7511_INT0_HPD) {
> +		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> +			     ADV7511_INT0_HPD);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void adv7511_hpd_work(struct work_struct *work)
> +{
> +	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
> +	enum drm_connector_status status;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
> +	if (ret < 0)
> +		status = connector_status_disconnected;
> +	else if (val & ADV7511_STATUS_HPD)
> +		status = connector_status_connected;
> +	else
> +		status = connector_status_disconnected;
> +
> +	/*
> +	 * The bridge resets its registers on unplug. So when we get a plug
> +	 * event and we're already supposed to be powered, cycle the bridge to
> +	 * restore its state.
> +	 */
> +	if (status == connector_status_connected &&
> +	    adv7511->connector.status == connector_status_disconnected &&
> +	    adv7511->powered) {
> +		regcache_mark_dirty(adv7511->regmap);
> +		adv7511_power_on(adv7511);
> +	}
> +
> +	if (adv7511->connector.status != status) {
> +		adv7511->connector.status = status;
> +
> +		if (adv7511->connector.dev) {
> +			if (status == connector_status_disconnected)
> +				cec_phys_addr_invalidate(adv7511->cec_adap);
> +			drm_kms_helper_hotplug_event(adv7511->connector.dev);
> +		} else {
> +			drm_bridge_hpd_notify(&adv7511->bridge, status);
> +		}
> +	}
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * ADV75xx helpers
>   */

-- 
Regards,

Laurent Pinchart

