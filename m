Return-Path: <linux-kernel+bounces-31488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2F832EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB861F2276F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362F56454;
	Fri, 19 Jan 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVng7ozE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF656455
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688772; cv=none; b=C8u/Wif8AA21qHmN2HdEzBoZCC1V+iA2DSTlDf3NYk7tSI7L/G7aXi34PcUjwcXbFoN9x7liaGOH8PP02pspkRg4z3isZ6x1Lcx9NXHzl3WJ5CUS0mEOrG9GBvi2bE+Jphi8/P5FQ9rOmUxQ+1mfNKjNdSEqhwn1Faz4qwlPWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688772; c=relaxed/simple;
	bh=yOxHF7ZU+mK9du0Tdf/ZFieHEX1hu7B8QVkJ8YihwNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFssT0G0vZlVZbMYxGolaMkfA8cwiaxbnRSDucadMLROZidYMzjaGa2MeMlTX0Ks/2b35hI05HayaVBgaEP1za9EKY2jKxTWH83TZsAfP0zH9Sec/dr7VMZ3PXdYbC+SFVP/onzI7fftIm8oKKzvK6YPo0/zssGV9+rvHMvZA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVng7ozE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705688770; x=1737224770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yOxHF7ZU+mK9du0Tdf/ZFieHEX1hu7B8QVkJ8YihwNk=;
  b=nVng7ozERr7Go/KQO0UG5L2G2BUPvwV+Fw79nCG+XPTfUm15L0d4wRNH
   an1uFT5HDCev1oMXrrSnz5T6OOUgthTaIgrqpnoVDTSmK8aTV8NE/E4Cx
   ZwgJe/h20MmigWHHZQOKFqottDf50r4tPvpynMQuMBfXNw59CGwldby0P
   YYj2LAwT7AIpnF5NLAXjl5JcUiJ2FvQcu/wEw2fiWciv5ljHIB52eLcuD
   mEpRWf3dsjZ4/gUiRDXzeB/AUdWp/hW9hAXP3tpFeGKrj+Z+oi0zBlltF
   wt8mu13XjYpuUMsIXaf9prZjnUiBd3gFUu+Ug501mTNk55oExyHmVl11F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="14330735"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="14330735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778039172"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778039172"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 19 Jan 2024 10:25:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 19 Jan 2024 20:25:51 +0200
Date: Fri, 19 Jan 2024 20:25:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Implement check_async_props for planes
Message-ID: <Zaq-r7UZpEy7_Rrn@intel.com>
References: <20240119181235.255060-1-andrealmeid@igalia.com>
 <20240119181235.255060-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119181235.255060-3-andrealmeid@igalia.com>
X-Patchwork-Hint: comment

On Fri, Jan 19, 2024 at 03:12:35PM -0300, André Almeida wrote:
> AMD GPUs can do async flips with changes on more properties than just
> the FB ID, so implement a custom check_async_props for AMD planes.
> 
> Allow amdgpu to do async flips with IN_FENCE_ID and FB_DAMAGE_CLIPS
> properties. For userspace to check if a driver support this two
> properties, the strategy for now is to use TEST_ONLY commits.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v2: Drop overlay plane option for now
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 116121e647ca..7afe8c1b62d4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -25,6 +25,7 @@
>   */
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_blend.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> @@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
>  	drm_atomic_helper_plane_destroy_state(plane, state);
>  }
>  
> +static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
> +					  struct drm_plane *plane,
> +					  struct drm_plane_state *plane_state,
> +					  struct drm_mode_object *obj,
> +					  u64 prop_value, u64 old_val)
> +{
> +	struct drm_mode_config *config = &plane->dev->mode_config;
> +	int ret;
> +
> +	if (prop != config->prop_fb_id &&
> +	    prop != config->prop_in_fence_fd &&

IN_FENCE should just be allowed always.

> +	    prop != config->prop_fb_damage_clips) {

This seems a bit dubious to me. How is amdgpu using the damage
information during async flips?

> +		ret = drm_atomic_plane_get_property(plane, plane_state,
> +						    prop, &old_val);
> +		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> +	}
> +
> +	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
> +		drm_dbg_atomic(prop->dev,
> +			       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
> +			       obj->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct drm_plane_funcs dm_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
> @@ -1438,6 +1466,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
>  	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
>  	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
>  	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
> +	.check_async_props = amdgpu_dm_plane_check_async_props,
>  };
>  
>  int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

