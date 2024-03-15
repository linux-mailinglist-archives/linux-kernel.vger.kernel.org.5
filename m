Return-Path: <linux-kernel+bounces-104158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BA87C9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B416D1F22855
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63F175BF;
	Fri, 15 Mar 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3qWw58p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA91758B;
	Fri, 15 Mar 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490935; cv=none; b=hxPACYn3LoRjs2hjKoofoRRFuz9tnRyIlWk+Pt5SlT2y2xPe5OMbm/JPMFUzRNG3xRGqCuYMlEMpYxRnC8iABkTjX8XQTU4dZk9UiMzWvz+2XYR+dIfmAzP3unTSYFEhjfMlxv5DBJ0z0U18i39VCNE42dVfS3vup5rSp0W3pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490935; c=relaxed/simple;
	bh=nVn3aX7+3f9iTQBAed2ZqWdElNcvvfVXItbazWoBUAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmLb0UbxSImFA4z+yWmMBon+g/yguXlLmG7fwPyMFAsSJSj2shUcLlW/usDyO7c03XsE0dgNngMDT/SVafQ5q98GAV0k0xN3j+yYfD3TIaxzOns3eT02HCdsJ1OzuHGVlfsLVvhpW945/N1H1y/NWNZd2c7ew1+me3KJylPeN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3qWw58p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710490934; x=1742026934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nVn3aX7+3f9iTQBAed2ZqWdElNcvvfVXItbazWoBUAw=;
  b=j3qWw58pJJcdVH2ppabA8hzJCRtjBBxxjyYFa4k8gD3j2yUEqm2XvDT5
   abqAjIuhPJYgU/Tn9NyfIFaAMxjuFSWGYtzdvgC9pAuMx1ZtgeHYdcXnz
   s5ZGtcs5BgwfWYNF7aBz9q+jxEmAEXE6aogeV/dTVItgIietpcPdRfM9k
   R3KG0k5vBGJ4joFhat0T6uPVUL9i+UmFyMQkN0CxK1XiWUNpyN+xW0/GD
   0ebepdO2e4hpEVAiFmDEXuT1MMvBFJK4Fkt/bJ8JqHfXUgSu1ST5mDiDt
   PWS5ykM3WYPzCXuOUaRVmMAU1lYppwX8DbiVDp3N2+W/nX+ricUsUDGMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5534228"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5534228"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="827780535"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="827780535"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 15 Mar 2024 01:22:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 15 Mar 2024 10:22:05 +0200
Date: Fri, 15 Mar 2024 10:22:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v9 20/27] drm/connector: hdmi: Add Infoframes generation
Message-ID: <ZfQFLR2xO6vUpAJ9@intel.com>
References: <20240311-kms-hdmi-connector-state-v9-0-d45890323344@kernel.org>
 <20240311-kms-hdmi-connector-state-v9-20-d45890323344@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311-kms-hdmi-connector-state-v9-20-d45890323344@kernel.org>
X-Patchwork-Hint: comment

On Mon, Mar 11, 2024 at 03:49:48PM +0100, Maxime Ripard wrote:
> Infoframes in KMS is usually handled by a bunch of low-level helpers
> that require quite some boilerplate for drivers. This leads to
> discrepancies with how drivers generate them, and which are actually
> sent.
> 
> Now that we have everything needed to generate them in the HDMI
> connector state, we can generate them in our common logic so that
> drivers can simply reuse what we precomputed.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig                            |   1 +
>  drivers/gpu/drm/drm_atomic_state_helper.c          | 323 +++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c                    |  14 +
>  .../gpu/drm/tests/drm_atomic_state_helper_test.c   |   1 +
>  drivers/gpu/drm/tests/drm_connector_test.c         |  12 +
>  include/drm/drm_atomic_state_helper.h              |   8 +
>  include/drm/drm_connector.h                        | 133 +++++++++
>  7 files changed, 492 insertions(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 872edb47bb53..ad9c467e20ce 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -97,10 +97,11 @@ config DRM_KUNIT_TEST
>  	  If in doubt, say "N".
>  
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_DISPLAY_HDMI_HELPER
>  	help
>  	  CRTC helpers for KMS drivers.
>  
>  config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>          bool "Enable refcount backtrace history in the DP MST helpers"
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index e66272c0d006..2bf53666fc9d 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -36,10 +36,12 @@
>  #include <drm/drm_plane.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_writeback.h>
>  
> +#include <drm/display/drm_hdmi_helper.h>
> +
>  #include <linux/slab.h>
>  #include <linux/dma-fence.h>
>  
>  /**
>   * DOC: atomic state reset and initialization
> @@ -912,10 +914,143 @@ hdmi_compute_config(const struct drm_connector *connector,
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
> +				       struct drm_connector_state *state)
> +{
> +	const struct drm_display_mode *mode =
> +		connector_state_get_mode(state);
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&state->hdmi.infoframes.avi;
> +	struct hdmi_avi_infoframe *frame =
> +		&infoframe->data.avi;
> +	bool is_full_range = state->hdmi.is_full_range;
> +	enum hdmi_quantization_range rgb_quant_range =
> +		is_full_range ? HDMI_QUANTIZATION_RANGE_FULL : HDMI_QUANTIZATION_RANGE_LIMITED;
> +	int ret;
> +
> +	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
> +	if (ret)
> +		return ret;
> +
> +	frame->colorspace = state->hdmi.output_format;
> +
> +	drm_hdmi_avi_infoframe_quant_range(frame, connector, mode, rgb_quant_range);

drm_hdmi_avi_infoframe_quant_range() doesn't handle YCbCr currently.

> +	drm_hdmi_avi_infoframe_colorimetry(frame, state);
> +	drm_hdmi_avi_infoframe_bars(frame, state);
> +
> +	infoframe->set = true;
> +
> +	return 0;
> +}
> +
<snip>
> +
> +#define UPDATE_INFOFRAME(c, os, ns, i)				\
> +	write_or_clear_infoframe(c,				\
> +				 &(c)->hdmi.infoframes.i,	\
> +				 &(os)->hdmi.infoframes.i,	\
> +				 &(ns)->hdmi.infoframes.i)

This macro feels like pointless obfuscation to me.

<snip>
> @@ -1984,20 +2063,73 @@ struct drm_connector {
>  
>  	/**
>  	 * @hdmi: HDMI-related variable and properties.
>  	 */
>  	struct {
> +#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
> +		/**
> +		 * @vendor: HDMI Controller Vendor Name
> +		 */
> +		unsigned char vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] __nonstring;
> +
> +#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
> +		/**
> +		 * @product: HDMI Controller Product Name
> +		 */
> +		unsigned char product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] __nonstring;
> +
>  		/**
>  		 * @supported_formats: Bitmask of @hdmi_colorspace
>  		 * supported by the controller.
>  		 */
>  		unsigned long supported_formats;
>  
>  		/**
>  		 * @funcs: HDMI connector Control Functions
>  		 */
>  		const struct drm_connector_hdmi_funcs *funcs;
> +
> +		/**
> +		 * @infoframes: Current Infoframes output by the connector
> +		 */
> +		struct {
> +			/**
> +			 * @lock: Mutex protecting against concurrent access to
> +			 * the infoframes, most notably between KMS and ALSA.
> +			 */
> +			struct mutex lock;
> +
> +			/**
> +			 * @audio: Current Audio Infoframes structure. Protected
> +			 * by @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe audio;
> +
> +			/**
> +			 * @avi: Current AVI Infoframes structure. Protected by
> +			 * @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe avi;
> +
> +			/**
> +			 * @hdr_drm: Current DRM (Dynamic Range and Mastering)
> +			 * Infoframes structure. Protected by @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe hdr_drm;
> +
> +			/**
> +			 * @spd: Current SPD Infoframes structure. Protected by
> +			 * @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe spd;
> +
> +			/**
> +			 * @vendor: Current HDMI Vendor Infoframes structure.
> +			 * Protected by @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe hdmi;
> +		} infoframes;
>  	} hdmi;

What's the deal with this bloat? These are already tracked in the
connector's state so this looks entirely redundant.

>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)
>  
> @@ -2015,10 +2147,11 @@ int drmm_connector_init(struct drm_device *dev,
>  			const struct drm_connector_funcs *funcs,
>  			int connector_type,
>  			struct i2c_adapter *ddc);
>  int drmm_connector_hdmi_init(struct drm_device *dev,
>  			     struct drm_connector *connector,
> +			     const char *vendor, const char *product,
>  			     const struct drm_connector_funcs *funcs,
>  			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
>  			     int connector_type,
>  			     struct i2c_adapter *ddc,
>  			     unsigned long supported_formats,
> 
> -- 
> 2.43.2

-- 
Ville Syrjälä
Intel

