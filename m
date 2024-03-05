Return-Path: <linux-kernel+bounces-92594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90234872295
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C41C2113B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DD1272BF;
	Tue,  5 Mar 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QTlTby0d"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A04683
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652176; cv=none; b=ILdhqc95O+MWcWYyvCZHPu129ZPcWFayttkiSu/YE13fM8O3JPDR4nqECDBfZpEYad/ywitmySCrkoRgOP5aBNxVYk4DzPbWAXWjoAr7/c+zNPURkN7Qupa+fXYHsW/rN45ZrhC54jjesapkVytCAa8Dz3/Ah3TBvPiDFhFdldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652176; c=relaxed/simple;
	bh=rVZIw01LOeMGt6xMQN9MnpOFeHTaZK+0KRQTlu0h68w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r06341VRlXLTDLc5UTGENkt2DmCGfKpO7jX6bIc64k7ONa3F8WOxw/Sp4Yq/EZqSC7S/Fs83kpwUukdfBxkX6ONnt9QS/CLvJ/DFgsXiTlGjvB/W1NZdLP1e4j1y2O1KiUErPs/zX2rmY5ZOhhHeCb0Ifxq+tzimWd/elj4QBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QTlTby0d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 429AD8D0;
	Tue,  5 Mar 2024 16:22:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709652155;
	bh=rVZIw01LOeMGt6xMQN9MnpOFeHTaZK+0KRQTlu0h68w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTlTby0dJCFtukvZ2n1ugxY2crRs+OzKheEa8qYt9faZXxRjcaXmz4vwhbQtf/dwC
	 R1+3R58EM2hP1/nxpTlBYpDP7WC0/mCQFgmC8vZzX3ntxb0gl28MLsPFGkL21lGru8
	 zbbQSHlCuI/I+1jcYhJp21zgLoAoKmMKng3+asVQ=
Date: Tue, 5 Mar 2024 17:22:54 +0200
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
Subject: Re: [PATCH v3 2/2] drm/bridge: adv7511: get edid in hpd_work to
 update CEC phys address
Message-ID: <20240305152254.GG12482@pendragon.ideasonboard.com>
References: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
 <20240219-adv7511-cec-edid-v3-2-445aed2f1cd7@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219-adv7511-cec-edid-v3-2-445aed2f1cd7@bang-olufsen.dk>

Hello Alvin,

Thank you for the patch.

On Mon, Feb 19, 2024 at 09:12:59PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The adv7511 driver is solely responsible for setting the physical
> address of its CEC adapter. To do this, it must read the EDID. However,
> EDID is only read when either the drm_bridge_funcs :: get_edid or
> drm_connector_helper_funcs :: get_modes ops are called. Without loss of
> generality, it cannot be assumed that these ops are called when a sink
> gets attached.

I wonder if that should be fixed, but it would likely be a quite big
rework of the DRM core. I've been thinking for several years now that
hotplug handling could do with more love.

> Therefore there exist scenarios in which the CEC physical
> address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.
> 
> Address this problem by always fetching the EDID in the HPD work when we
> detect a connection. The CEC physical address is set in the process.
> This is done by moving the EDID DRM helper into an internal helper
> function so that it can be cleanly called from an earlier section of
> the code. The EDID getter has not changed in practice.
> 
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 73 ++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 5ffc5904bd59..d823b372ff43 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -542,6 +542,36 @@ static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
>  	return 0;
>  }
>  
> +static struct edid *__adv7511_get_edid(struct adv7511 *adv7511,
> +				       struct drm_connector *connector)
> +{
> +	struct edid *edid;
> +
> +	/* Reading the EDID only works if the device is powered */
> +	if (!adv7511->powered) {
> +		unsigned int edid_i2c_addr =
> +					(adv7511->i2c_edid->addr << 1);
> +
> +		__adv7511_power_on(adv7511);
> +
> +		/* Reset the EDID_I2C_ADDR register as it might be cleared */
> +		regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR,
> +			     edid_i2c_addr);
> +	}
> +
> +	edid = drm_do_get_edid(connector, adv7511_get_edid_block, adv7511);
> +
> +	if (!adv7511->powered)
> +		__adv7511_power_off(adv7511);
> +
> +	adv7511_set_config_csc(adv7511, connector, adv7511->rgb,
> +			       drm_detect_hdmi_monitor(edid));
> +
> +	cec_s_phys_addr_from_edid(adv7511->cec_adap, edid);
> +
> +	return edid;
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * Hotplug handling
>   */
> @@ -595,8 +625,23 @@ static void adv7511_hpd_work(struct work_struct *work)
>  		adv7511->connector.status = status;
>  
>  		if (adv7511->connector.dev) {
> -			if (status == connector_status_disconnected)
> +			if (status == connector_status_disconnected) {
>  				cec_phys_addr_invalidate(adv7511->cec_adap);
> +			} else {
> +				struct edid *edid;
> +
> +				/*
> +				 * Get the updated EDID so that the CEC
> +				 * subsystem gets informed of any change in CEC
> +				 * address. The helper returns a newly allocated
> +				 * edid structure, so free it to prevent
> +				 * leakage.
> +				 */
> +				edid = __adv7511_get_edid(adv7511,
> +							  &adv7511->connector);
> +				kfree(edid);

This means that we will, in most case, fetch EDID twice when a monitor
is plugged in: once here, and once when the DRM core will call the
get_edid() operation. I wonder, would it make sense to cache the EDID
here, and return the cache version from adv7511_get_edid() ?

> +			}
> +
>  			drm_kms_helper_hotplug_event(adv7511->connector.dev);
>  		} else {
>  			drm_bridge_hpd_notify(&adv7511->bridge, status);
> @@ -611,31 +656,7 @@ static void adv7511_hpd_work(struct work_struct *work)
>  static struct edid *adv7511_get_edid(struct adv7511 *adv7511,
>  				     struct drm_connector *connector)
>  {
> -	struct edid *edid;
> -
> -	/* Reading the EDID only works if the device is powered */
> -	if (!adv7511->powered) {
> -		unsigned int edid_i2c_addr =
> -					(adv7511->i2c_edid->addr << 1);
> -
> -		__adv7511_power_on(adv7511);
> -
> -		/* Reset the EDID_I2C_ADDR register as it might be cleared */
> -		regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR,
> -			     edid_i2c_addr);
> -	}
> -
> -	edid = drm_do_get_edid(connector, adv7511_get_edid_block, adv7511);
> -
> -	if (!adv7511->powered)
> -		__adv7511_power_off(adv7511);
> -
> -	adv7511_set_config_csc(adv7511, connector, adv7511->rgb,
> -			       drm_detect_hdmi_monitor(edid));
> -
> -	cec_s_phys_addr_from_edid(adv7511->cec_adap, edid);
> -
> -	return edid;
> +	return __adv7511_get_edid(adv7511, connector);
>  }
>  
>  static int adv7511_get_modes(struct adv7511 *adv7511,
> 

-- 
Regards,

Laurent Pinchart

