Return-Path: <linux-kernel+bounces-93622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0DC87327A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5101C24251
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B105DF2E;
	Wed,  6 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zhv+RRBJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EE5DF16
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717028; cv=none; b=UEZfmBxfEH8PBC0+FRi8lR4+vKB3FBbnGD08eNiDuoo4zFVyZjS36k/n4NvrvOLC1b4ckGvj33atF9k8BQlw67xwRSeq7ndMAwQZKRWogoIkcO6maElFF5x8BRDTHprNNe9759uEUWZJumFtr3Eo4ulmS3XN/noeYrZBjetEsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717028; c=relaxed/simple;
	bh=8azOrkKOqGN52FwT3QPVf8+BwT58YaCcbX8PIF4gYek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IAFgCN7HLiTVEgr1yegXSQFFyZoJxxxy7y0R3feoQ8PemSc551oAngvOGZVuDQpHw55RrqPQ5cmqhdnqCJqZHY+QAIo5zRKyDqHnYipOJo66zpZLdlgaNtOu6MKtRoLdtveBfx38vrv3hn2vBRuhu4Fo0TkN2yMj1ERaZkt0mF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zhv+RRBJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709717028; x=1741253028;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8azOrkKOqGN52FwT3QPVf8+BwT58YaCcbX8PIF4gYek=;
  b=Zhv+RRBJ++jFZCskWTbxZGrjbVFzJg05q/jXT0l0ZdFMkMO3U+h3P2XX
   1YIGL2HL+pJ6U2RlqhtQlrAiZ8fDEl4kQGSz4MpACDiQX97sw3mrvFssD
   NGAVUkL0tetdVkX/SKm/Er+juVq0eV/ps34ko3wxsYaoemV+n/V0zgkx7
   azBcAaeBJTtY5fhvjfEXHtZbwpqaE9QNTn1gjFpM9rCwAM+2UxMKMHRJu
   sc4QokcQ0Ng02Fc/62FUgXMovMzc3wuV1dkxmNFVTuWUdL+FaGyASMy80
   oPkqOCQkabBqVYUnfvyuCb20le1a34aKuTb/L4tZc9ZN1RtcMwZWaGSuY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8135416"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="8135416"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9635982"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.33.211])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:23:41 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] drm/panel-edp: Match edp_panels with panel identity
In-Reply-To: <20240306004347.974304-5-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306004347.974304-1-hsinyi@chromium.org>
 <20240306004347.974304-5-hsinyi@chromium.org>
Date: Wed, 06 Mar 2024 11:23:37 +0200
Message-ID: <87msrbzpba.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> It's found that some panels have variants that they share the same panel id
> although their EDID and names are different. When matching generic edp
> panels, we should first match with both panel identity, which contains both
> panel id and panel name. If not found, match with panel id only.

Do you want to start matching also with name, for all panels? That's
totally up to you, but that's the big functional change here.

BR,
Jani.

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v3->v4: combine name and id to identity.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 45 ++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index d094cfc43da8..fb70e97a2e71 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -210,15 +210,12 @@ struct panel_desc {
>   * struct edp_panel_entry - Maps panel ID to delay / panel name.
>   */
>  struct edp_panel_entry {
> -	/** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_panel_id(). */
> -	u32 panel_id;
> +	/** @ident: edid identity used for panel matching. */
> +	const struct drm_edid_ident ident;
>  
>  	/** @delay: The power sequencing delays needed for this panel. */
>  	const struct panel_delay *delay;
>  
> -	/** @name: Name of this panel (for printing to logs). */
> -	const char *name;
> -
>  	/** @override_edid_mode: Override the mode obtained by edid. */
>  	const struct drm_display_mode *override_edid_mode;
>  };
> @@ -691,7 +688,7 @@ static int detected_panel_show(struct seq_file *s, void *data)
>  	else if (!p->detected_panel)
>  		seq_puts(s, "HARDCODED\n");
>  	else
> -		seq_printf(s, "%s\n", p->detected_panel->name);
> +		seq_printf(s, "%s\n", p->detected_panel->ident.name);
>  
>  	return 0;
>  }
> @@ -761,7 +758,7 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
>  		dev_err(dev, "Reject override mode: No display_timing found\n");
>  }
>  
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const struct drm_edid *edid);
>  
>  static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  {
> @@ -799,7 +796,6 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  	base_block = drm_edid_read_base_block(panel->ddc);
>  	if (base_block) {
>  		panel_id = drm_edid_get_panel_id(base_block);
> -		drm_edid_free(base_block);
>  	} else {
>  		dev_err(dev, "Couldn't identify panel via EDID\n");
>  		ret = -EIO;
> @@ -807,7 +803,9 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  	}
>  	drm_edid_decode_panel_id(panel_id, vend, &product_id);
>  
> -	panel->detected_panel = find_edp_panel(panel_id);
> +	panel->detected_panel = find_edp_panel(panel_id, base_block);
> +
> +	drm_edid_free(base_block);
>  
>  	/*
>  	 * We're using non-optimized timings and want it really obvious that
> @@ -840,7 +838,7 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  		panel->detected_panel = ERR_PTR(-EINVAL);
>  	} else {
>  		dev_info(dev, "Detected %s %s (%#06x)\n",
> -			 vend, panel->detected_panel->name, product_id);
> +			 vend, panel->detected_panel->ident.name, product_id);
>  
>  		/* Update the delay; everything else comes from EDID */
>  		desc->delay = *panel->detected_panel->delay;
> @@ -1930,17 +1928,21 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
>  
>  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
>  { \
> -	.name = _name, \
> -	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> -					     product_id), \
> +	.ident = { \
> +		.name = _name, \
> +		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> +						     product_id), \
> +	}, \
>  	.delay = _delay \
>  }
>  
>  #define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
>  { \
> -	.name = _name, \
> -	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> -					     product_id), \
> +	.ident = { \
> +		.name = _name, \
> +		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> +						     product_id), \
> +	}, \
>  	.delay = _delay, \
>  	.override_edid_mode = _mode \
>  }
> @@ -2087,15 +2089,16 @@ static const struct edp_panel_entry edp_panels[] = {
>  	{ /* sentinal */ }
>  };
>  
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const struct drm_edid *edid)
>  {
>  	const struct edp_panel_entry *panel;
>  
> -	if (!panel_id)
> -		return NULL;
> +	for (panel = edp_panels; panel->ident.panel_id; panel++)
> +		if (drm_edid_match_identity(edid, &panel->ident))
> +			return panel;
>  
> -	for (panel = edp_panels; panel->panel_id; panel++)
> -		if (panel->panel_id == panel_id)
> +	for (panel = edp_panels; panel->ident.panel_id; panel++)
> +		if (panel->ident.panel_id == panel_id)
>  			return panel;
>  
>  	return NULL;

-- 
Jani Nikula, Intel

