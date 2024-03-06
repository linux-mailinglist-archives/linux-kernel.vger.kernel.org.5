Return-Path: <linux-kernel+bounces-93754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4AE87346A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5339EB309C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F25660DC9;
	Wed,  6 Mar 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQUJ6b0X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160660B9E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720740; cv=none; b=B/xoxSW1MZak3WVjJr59BOcUxxuq5s8uDLYPSXDtQKwVXYnNNvBI2THDIHI2eQoG/GAqIUitoL88Iu8uJ9U0zgsAJQ7CEXgrpu5XopoQomyuUsm5t9W6BHU/KIx3MTQYXlP7pwfYN8PNyvRCalVXkvbjzwmy14+AsvKcq1CVzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720740; c=relaxed/simple;
	bh=El+OOs5pi7lzmVrizlMxTEsWscK7ZxT9Eu6oAzyd4V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dviEIJ7vDWRXzyMPY5GLV06ZupdyPWEwB+su7LNtGcOsl4cKAGdjGWUn8xLxvzc2PEmrpSfq7xq2g1Od2HwuFKN618HWARp6XFoI38fCYj0qcp9vPTT3B5ci4qTLPBVSxeTl+d8jrvtW0P3/NZUsE+RH7TVLECc0ytr6iYFD+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQUJ6b0X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709720738; x=1741256738;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=El+OOs5pi7lzmVrizlMxTEsWscK7ZxT9Eu6oAzyd4V4=;
  b=DQUJ6b0XCYSs1v9ehONBqixV7N3fprq+YbZxeM9C58Qb4flDl7ToFfTx
   z0AaJVpHKlG2L7Ylxm8GAWACnSEO0sBD8lyYhiL8hly09KUHQMK7YG6i9
   fYfxazXIDAZxsFB0DQZ3AX/wtHk8r19hnTQl5KQkb1ENpcmBRjt4AUSVX
   WE/4vLHmhz5NZH8p2Jk2Z5U5+oZuX2xxE+n+qJnTNlZKfAc+AlskrFrEo
   O5O5aCypsKQD83L/AthZHmpNHoXlja/m0v3ZndgnIi9sAAzJV23uuy2rW
   61cTuC5Ky4jDkmhBx+A5vPgTTrzQa7eJ8ch0U3i7i6UsHhq0fJw+emaSf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21778852"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="21778852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9587507"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.33.211])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:25:33 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Hsin-Te
 Yuan <yuanhsinte@chromium.org>
Subject: Re: [PATCH v3] drm/bridge: anx7625: Update audio status while
 detecting
In-Reply-To: <20240306-anx7625-v3-1-9034263bf530@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306-anx7625-v3-1-9034263bf530@chromium.org>
Date: Wed, 06 Mar 2024 12:25:30 +0200
Message-ID: <87frx3zmg5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 06 Mar 2024, Hsin-Te Yuan <yuanhsinte@chromium.org> wrote:
> Previously, the audio status was not updated during detection, leading
> to a persistent audio despite hot plugging events. To resolve this
> issue, update the audio status during detection.
>
> Fixes: 566fef1226c1 ("drm/bridge: anx7625: add HDMI audio function")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v3:
> - Add Fixes tag. 

You don't need to send another version just to update commit message
trailers. They can either be added while applying, or when you need to
update the patch anyway.

Or, if b4 is used to apply the patches, it can automagically pick up the
trailers from replies to the patch with the Fixes: trailer.

> - Link to v2: https://lore.kernel.org/r/20240306-anx7625-v2-1-7138e00b25bf@chromium.org
>
> Changes in v2:
> - Add a space after the colons in the subject line.
> - Link to v1: https://lore.kernel.org/r/20240305-anx7625-v1-1-83ed3ccfa64c@chromium.org
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 29d91493b101a..9f0d0c5b8ebf5 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2481,15 +2481,22 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
>  	mutex_unlock(&ctx->aux_lock);
>  }
>  
> +static void
> +anx7625_audio_update_connector_status(struct anx7625_data *ctx,
> +				      enum drm_connector_status status);
> +
>  static enum drm_connector_status
>  anx7625_bridge_detect(struct drm_bridge *bridge)
>  {
>  	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>  	struct device *dev = ctx->dev;
> +	enum drm_connector_status status;
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");
>  
> -	return anx7625_sink_detect(ctx);
> +	status = anx7625_sink_detect(ctx);
> +	anx7625_audio_update_connector_status(ctx, status);
> +	return status;
>  }
>  
>  static struct edid *anx7625_bridge_get_edid(struct drm_bridge *bridge,

I guess this could be applied with less context (-C 2) but the baseline
is old. In drm-misc-next, all of drm/bridge has moved on to struct
drm_edid.

BR,
Jani.


>
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240305-anx7625-fe16d3a9d37d
>
> Best regards,

-- 
Jani Nikula, Intel

