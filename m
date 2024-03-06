Return-Path: <linux-kernel+bounces-93526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E599873101
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184DA1F21FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900A5D75D;
	Wed,  6 Mar 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwI3f5Ip"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC81426B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714608; cv=none; b=Xy0KpwvOrvapRB/ZSh/w8ckgsnsiacrd7K9DDNykU33zPJrJg3S1oj3v6apaRBvkFXmben595Qm+ctGWwb/lfifCekyspC0wjFkmRpkTUCRj3bg2wn7L7GELelvA67uQf0l4/JQ25sfM3hkqQkqyq3uzkop2yBVRBthLGVlNVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714608; c=relaxed/simple;
	bh=o1f+IK+oob/TNW+G6c9s3CJ0ykrpd884VVhiFMZV1rU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JyRWGWBmxU+ZmDWDIgs9cTRBQJJB7IIu0eQiee9HkOVxOja/m68pcc1ISFk9sMoERn8428f8W1HAe09tazVYmkFki2GutRum36WqExydHOG8G1SsIhrNqZGXMtLZ1xrLrum1/k3Pv+Wm34eEBZINg9KQwH9/P+6VfVhklcwgmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwI3f5Ip; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709714606; x=1741250606;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o1f+IK+oob/TNW+G6c9s3CJ0ykrpd884VVhiFMZV1rU=;
  b=MwI3f5Ipf9bsp7eszovlDUEVgA0xcJ5aQEIYu+ZLf7xH7wk5iTlp8hHS
   5H+6E2uzZ8E84h9R9gOC0l+4aCqUqCKBpuBOqOC+YBSrVHXNXF1JV9Bru
   xtHR+D+JI+Y9lbH08JYRfjJEt90RCabd8EdY0vDBeVSXneHWD6QFJQmyH
   KeevP5qYzmxziiLpYqPx3vlD4mAke9qvmzMvvWZI33Llbd3mmUh2yO7g2
   1A8QKuv68Id0mMKtYCiYOUJcY1xVfJ35szMdexz5kujLL31sYxF3mHOQI
   f+GPL3lvvRDOO1xP+7xrozjmdfkbtb6fAaPuutxq3Uo4pRNjI86lWMDgn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15726250"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="15726250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9556791"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.33.211])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:43:16 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] drm_edid: Add a function to get EDID base block
In-Reply-To: <20240306004347.974304-2-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306004347.974304-1-hsinyi@chromium.org>
 <20240306004347.974304-2-hsinyi@chromium.org>
Date: Wed, 06 Mar 2024 10:43:09 +0200
Message-ID: <87v85zzr6q.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> It's found that some panels have variants that they share the same panel id
> although their EDID and names are different. Besides panel id, now we need
> more information from the EDID base block to distinguish these panel
> variants.
>
> Add drm_edid_read_base_block() to return the EDID base block, which is
> wrapped in struct drm_edid.
>
> Caller can further use it to get panel id or check if the block contains
> certain strings, such as panel name.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v3->v4: change drm_edid_read_base_block return type to drm_edid.
> ---
>  drivers/gpu/drm/drm_edid.c        | 63 +++++++++++++++++++------------
>  drivers/gpu/drm/panel/panel-edp.c |  8 +++-
>  include/drm/drm_edid.h            |  3 +-
>  3 files changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 923c4423151c..f9e09f327f81 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2770,58 +2770,71 @@ static u32 edid_extract_panel_id(const struct edid *edid)
>  }
>  
>  /**
> - * drm_edid_get_panel_id - Get a panel's ID through DDC
> - * @adapter: I2C adapter to use for DDC
> + * drm_edid_get_panel_id - Get a panel's ID from EDID
> + * @drm_edid: EDID that contains panel ID.
>   *
> - * This function reads the first block of the EDID of a panel and (assuming
> + * This function uses the first block of the EDID of a panel and (assuming
>   * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit value
>   * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that's
>   * supposed to be different for each different modem of panel.
>   *
> + * Return: A 32-bit ID that should be different for each make/model of panel.
> + *         See the functions drm_edid_encode_panel_id() and
> + *         drm_edid_decode_panel_id() for some details on the structure of this
> + *         ID.
> + */
> +u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
> +{
> +	return edid_extract_panel_id(drm_edid->edid);
> +}
> +EXPORT_SYMBOL(drm_edid_get_panel_id);
> +
> +/**
> + * drm_edid_read_base_block - Get a panel's EDID base block
> + * @adapter: I2C adapter to use for DDC
> + *
> + * This function returns the drm_edid containing the first block of the EDID of
> + * a panel.
> + *
>   * This function is intended to be used during early probing on devices where
>   * more than one panel might be present. Because of its intended use it must
> - * assume that the EDID of the panel is correct, at least as far as the ID
> - * is concerned (in other words, we don't process any overrides here).
> + * assume that the EDID of the panel is correct, at least as far as the base
> + * block is concerned (in other words, we don't process any overrides here).
> + *
> + * Caller should call drm_edid_free() after use.
>   *
>   * NOTE: it's expected that this function and drm_do_get_edid() will both
>   * be read the EDID, but there is no caching between them. Since we're only
>   * reading the first block, hopefully this extra overhead won't be too big.
>   *
> - * Return: A 32-bit ID that should be different for each make/model of panel.
> - *         See the functions drm_edid_encode_panel_id() and
> - *         drm_edid_decode_panel_id() for some details on the structure of this
> - *         ID.
> + * WARNING: Only use this function when the connector is unknown. For example,
> + * during the early probe of panel. The EDID read from the function is temporary
> + * and should be replaced by the full EDID returned from other drm_edid_read.
> + *
> + * Return: Pointer to allocated EDID base block, or NULL on any failure.
>   */
> -
> -u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
> +const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter)
>  {
>  	enum edid_block_status status;
>  	void *base_block;
> -	u32 panel_id = 0;
> -
> -	/*
> -	 * There are no manufacturer IDs of 0, so if there is a problem reading
> -	 * the EDID then we'll just return 0.
> -	 */
>  
>  	base_block = kzalloc(EDID_LENGTH, GFP_KERNEL);
>  	if (!base_block)
> -		return 0;
> +		return NULL;
>  
>  	status = edid_block_read(base_block, 0, drm_do_probe_ddc_edid, adapter);
>  
>  	edid_block_status_print(status, base_block, 0);
>  
> -	if (edid_block_status_valid(status, edid_block_tag(base_block)))
> -		panel_id = edid_extract_panel_id(base_block);
> -	else
> +	if (!edid_block_status_valid(status, edid_block_tag(base_block))) {
>  		edid_block_dump(KERN_NOTICE, base_block, 0);
> +		kfree(base_block);
> +		return NULL;
> +	}
>  
> -	kfree(base_block);
> -
> -	return panel_id;
> +	return drm_edid_alloc(base_block, EDID_LENGTH);

This leaks base_block. Please use _drm_edid_alloc() (with underscore) to
only allocate the container without kmemduping the data.

Otherwise LGTM.

BR,
Jani.



>  }
> -EXPORT_SYMBOL(drm_edid_get_panel_id);
> +EXPORT_SYMBOL(drm_edid_read_base_block);
>  
>  /**
>   * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 745f3e48f02a..d094cfc43da8 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -766,6 +766,7 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
>  static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  {
>  	struct panel_desc *desc;
> +	const struct drm_edid *base_block;
>  	u32 panel_id;
>  	char vend[4];
>  	u16 product_id;
> @@ -795,8 +796,11 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  		goto exit;
>  	}
>  
> -	panel_id = drm_edid_get_panel_id(panel->ddc);
> -	if (!panel_id) {
> +	base_block = drm_edid_read_base_block(panel->ddc);
> +	if (base_block) {
> +		panel_id = drm_edid_get_panel_id(base_block);
> +		drm_edid_free(base_block);
> +	} else {
>  		dev_err(dev, "Couldn't identify panel via EDID\n");
>  		ret = -EIO;
>  		goto exit;
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 7923bc00dc7a..9686a7cee6a6 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -410,7 +410,8 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
>  	void *data);
>  struct edid *drm_get_edid(struct drm_connector *connector,
>  			  struct i2c_adapter *adapter);
> -u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
> +const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter);
> +u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
>  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>  				     struct i2c_adapter *adapter);
>  struct edid *drm_edid_duplicate(const struct edid *edid);

-- 
Jani Nikula, Intel

