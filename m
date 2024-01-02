Return-Path: <linux-kernel+bounces-14316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF73821B41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C061283290
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8AEADE;
	Tue,  2 Jan 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO6RRRvS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE0EAC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704196478; x=1735732478;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=glvg9dPtXAYe+M8HNBkKr2u3U7gFuFfEanHMRIrcRoE=;
  b=VO6RRRvSKjIlWJjDWurK/f/7gLqfxm29p5Tb8QoFDWUKVFlJ93UR882b
   8J2GYh3df1UGl+on1n1bEXJxqitN6XE32kLPaC2CxV80HiKoU3irNA7T2
   8DlgFUwoSaqzf81MiUIh+4g77qPUa13AGtd+bucwor9ERluLuUUEcZIdp
   pDwjunpCJk8HFz5TvbzuM1CpuTq21x95aZj1R9VwqRnM28WVu83ZEIXQ2
   xUdai6rQ0UM3ByG8hIcJog2CMgBwV6X96usO9oINEgPKQilSX50R8Wt3e
   D+WfB5sjcDvluhsndkfKckhmcJb6QYUgbS4Xbz3UtmBoWGiOEqgLlqQdG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="10480577"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10480577"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 03:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="21458198"
Received: from dmaryin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.224])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 03:54:33 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas
 <javierm@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm: Move drm_set_preferred_mode() helper from drm_edid
 to drm_modes
In-Reply-To: <20240102111921.3057255-1-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240102111921.3057255-1-javierm@redhat.com>
Date: Tue, 02 Jan 2024 13:54:22 +0200
Message-ID: <87y1d80x3l.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 02 Jan 2024, Javier Martinez Canillas <javierm@redhat.com> wrote:
> The helper is generic and doesn't use the opaque EDID type struct drm_edid
> and is also used by drivers that only support non-probeable displays, such
> as fixed panels.
>
> These drivers add a list of modes using drm_mode_probed_add() and then set
> a preferred mode using the drm_set_preferred_mode() helper.
>
> It seems more logical to have the helper definition in drm_modes.o instead
> of drm_edid.o, since the former contains modes helper while the latter has
> helpers to manage the EDID information.
>
> Since both drm_edid.o and drm_modes.o object files are built-in the drm.o
> object, there are no functional changes. But besides being a more logical
> place for this helper, it could also allow to eventually make drm_edid.o
> optional and not included in drm.o if only fixed panels must be supported
> in a given system.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/gpu/drm/drm_edid.c  | 23 +----------------------
>  drivers/gpu/drm/drm_modes.c | 22 ++++++++++++++++++++++
>  include/drm/drm_edid.h      |  2 --
>  include/drm/drm_modes.h     |  2 ++
>  4 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index cb4031d5dcbb..48dd2a0a0395 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -43,6 +43,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_eld.h>
>  #include <drm/drm_encoder.h>
> +#include <drm/drm_modes.h>

Unnecessary.

Other than that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


>  #include <drm/drm_print.h>
>  
>  #include "drm_crtc_internal.h"
> @@ -6989,28 +6990,6 @@ int drm_add_modes_noedid(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_add_modes_noedid);
>  
> -/**
> - * drm_set_preferred_mode - Sets the preferred mode of a connector
> - * @connector: connector whose mode list should be processed
> - * @hpref: horizontal resolution of preferred mode
> - * @vpref: vertical resolution of preferred mode
> - *
> - * Marks a mode as preferred if it matches the resolution specified by @hpref
> - * and @vpref.
> - */
> -void drm_set_preferred_mode(struct drm_connector *connector,
> -			   int hpref, int vpref)
> -{
> -	struct drm_display_mode *mode;
> -
> -	list_for_each_entry(mode, &connector->probed_modes, head) {
> -		if (mode->hdisplay == hpref &&
> -		    mode->vdisplay == vpref)
> -			mode->type |= DRM_MODE_TYPE_PREFERRED;
> -	}
> -}
> -EXPORT_SYMBOL(drm_set_preferred_mode);
> -
>  static bool is_hdmi2_sink(const struct drm_connector *connector)
>  {
>  	/*
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index ac9a406250c5..01aa44e87534 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2754,3 +2754,25 @@ bool drm_mode_is_420(const struct drm_display_info *display,
>  		drm_mode_is_420_also(display, mode);
>  }
>  EXPORT_SYMBOL(drm_mode_is_420);
> +
> +/**
> + * drm_set_preferred_mode - Sets the preferred mode of a connector
> + * @connector: connector whose mode list should be processed
> + * @hpref: horizontal resolution of preferred mode
> + * @vpref: vertical resolution of preferred mode
> + *
> + * Marks a mode as preferred if it matches the resolution specified by @hpref
> + * and @vpref.
> + */
> +void drm_set_preferred_mode(struct drm_connector *connector,
> +			   int hpref, int vpref)
> +{
> +	struct drm_display_mode *mode;
> +
> +	list_for_each_entry(mode, &connector->probed_modes, head) {
> +		if (mode->hdisplay == hpref &&
> +		    mode->vdisplay == vpref)
> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> +	}
> +}
> +EXPORT_SYMBOL(drm_set_preferred_mode);
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 54cc6f04a708..5bd6b6eb6c57 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -426,8 +426,6 @@ enum hdmi_quantization_range
>  drm_default_rgb_quant_range(const struct drm_display_mode *mode);
>  int drm_add_modes_noedid(struct drm_connector *connector,
>  			 int hdisplay, int vdisplay);
> -void drm_set_preferred_mode(struct drm_connector *connector,
> -			    int hpref, int vpref);
>  
>  int drm_edid_header_is_valid(const void *edid);
>  bool drm_edid_block_valid(u8 *raw_edid, int block, bool print_bad_edid,
> diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> index c613f0abe9dc..b9bb92e4b029 100644
> --- a/include/drm/drm_modes.h
> +++ b/include/drm/drm_modes.h
> @@ -467,6 +467,8 @@ bool drm_mode_is_420_also(const struct drm_display_info *display,
>  			  const struct drm_display_mode *mode);
>  bool drm_mode_is_420(const struct drm_display_info *display,
>  		     const struct drm_display_mode *mode);
> +void drm_set_preferred_mode(struct drm_connector *connector,
> +			    int hpref, int vpref);
>  
>  struct drm_display_mode *drm_analog_tv_mode(struct drm_device *dev,
>  					    enum drm_connector_tv_mode mode,

-- 
Jani Nikula, Intel

