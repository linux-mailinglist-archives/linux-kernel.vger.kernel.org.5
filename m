Return-Path: <linux-kernel+bounces-57787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021884DD70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5050A1C2502D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F336BFCD;
	Thu,  8 Feb 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrMazt4N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EE6A8A1;
	Thu,  8 Feb 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386242; cv=none; b=prp0JelMl2+a7C3Dj3Q3qsCNcVpEdhXQCbZ6kgbvUTcB/1ysKHFTQjno4SvGJ731bTcdc/3bIMubidbgyWW3RJEqMRL/wm9lmPEABvFZ61K+aUBZsxqhK9vNA2trBXR6VJehTjZvdg1tt7fcQNL8KE0Qhe4IISkmX16nM3V+ENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386242; c=relaxed/simple;
	bh=HRn9JBFXL0AcaL15UpPEuHqSF/Q9gIFidqcgHAOPWQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQDSWuoWX5Y+jDdtmSGoYfOFBMsGqOcxH55qbkY6TJg0I0h9H6BWnha+eeFKRRQmjNvCGrAKOHYK8QlRy7ex+Z+iwdu6MsX9MbRTnQ9seHtaF+ZojHczf57xcFRqt6Mz+OaNU3bzbL/sahonddAmSQvOg5fv2jHtOL38NHLfThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrMazt4N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707386240; x=1738922240;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HRn9JBFXL0AcaL15UpPEuHqSF/Q9gIFidqcgHAOPWQc=;
  b=jrMazt4N+kKTER3Bns87XllX2QqQIbLqT2NUFK2fq3lVLTPAUUkbbOOf
   2OVec4DqM1jSOlNEF/sVg6YDXtCSCVdMtxYka2KidxxMCdr3k42v8eT0f
   SS98jpIR+srCHEsFbTozf+NPpC+mQzOm7TpmI8Wy/VW4Nl/7lfMRj5gH6
   ylK0cSu+KmAoChiNLB8nh/NbD0wvM2eUttN769EGw7IUZxZvL7a8SfYFn
   trUD+8HplCO2S7Utk8sTko9mpy3w5lprt9WBaSVrP7Y5RZT7wBj0GMThU
   dWt8whvAzx0u89DIpoTq6rypGVLS9akxENi4zAEaRHdlIMcgMf67NpP+x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1068834"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1068834"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="24858667"
Received: from aavzirov-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.13])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:57:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Melissa Wen <mwen@igalia.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Dave Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v4 1/3] drm: Add drm_get_acpi_edid() helper
In-Reply-To: <20240207224429.104625-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240207224429.104625-1-mario.limonciello@amd.com>
 <20240207224429.104625-2-mario.limonciello@amd.com>
Date: Thu, 08 Feb 2024 11:57:11 +0200
Message-ID: <87y1bvb7ns.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 07 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> Some manufacturers have intentionally put an EDID that differs from
> the EDID on the internal panel on laptops.  Drivers can call this
> helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/Kconfig    |  5 +++
>  drivers/gpu/drm/drm_edid.c | 77 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  1 +
>  3 files changed, 83 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 6ec33d36f3a4..ec2bb71e8b36 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -21,6 +21,11 @@ menuconfig DRM
>  	select KCMP
>  	select VIDEO_CMDLINE
>  	select VIDEO_NOMODESET
> +	select ACPI_VIDEO if ACPI
> +	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select INPUT if ACPI
> +	select X86_PLATFORM_DEVICES if ACPI && X86
> +	select ACPI_WMI if ACPI && X86

I think I'll defer to drm maintainers on whether this is okay or
something to be avoided.


>  	help
>  	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>  	  introduced in XFree86 4.0. If you say Y here, you need to select
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 923c4423151c..c649b4f9fd8e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -28,6 +28,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <acpi/video.h>
>  #include <linux/bitfield.h>
>  #include <linux/cec.h>
>  #include <linux/hdmi.h>
> @@ -2188,6 +2189,49 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
>  	return ret == xfers ? 0 : -1;
>  }
>  
> +/**
> + * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
> + * @data: struct drm_device
> + * @buf: EDID data buffer to be filled
> + * @block: 128 byte EDID block to start fetching from
> + * @len: EDID data buffer length to fetch
> + *
> + * Try to fetch EDID information by calling acpi_video_get_edid() function.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int
> +drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
> +{
> +	struct drm_device *ddev = data;
> +	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
> +	unsigned char start = block * EDID_LENGTH;
> +	void *edid;
> +	int r;
> +
> +	if (!acpidev)
> +		return -ENODEV;
> +
> +	/* fetch the entire edid from BIOS */
> +	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> +	if (r < 0) {
> +		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
> +		return -EINVAL;
> +	}
> +	if (len > r || start > r || start + len > r) {
> +		r = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	memcpy(buf, edid + start, len);
> +	r = 0;
> +
> +cleanup:
> +	kfree(edid);
> +
> +	return r;
> +}
> +
>  static void connector_bad_edid(struct drm_connector *connector,
>  			       const struct edid *edid, int num_blocks)
>  {
> @@ -2643,6 +2687,39 @@ struct edid *drm_get_edid(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_get_edid);
>  
> +/**
> + * drm_get_acpi_edid - get EDID data, if available

I'd prefer all the new EDID API to be named drm_edid_*. Makes a clean
break from the old API, and is more consistent.

So perhaps drm_edid_read_acpi() to be in line with all the other struct
drm_edid based EDID reading functions.

> + * @connector: connector we're probing
> + *
> + * Use the BIOS to attempt to grab EDID data if possible.
> + *
> + * The returned pointer must be freed using drm_edid_free().
> + *
> + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> + */
> +const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector)
> +{
> +	const struct drm_edid *drm_edid;
> +
> +	switch (connector->connector_type) {
> +	case DRM_MODE_CONNECTOR_LVDS:
> +	case DRM_MODE_CONNECTOR_eDP:
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	if (connector->force == DRM_FORCE_OFF)
> +		return NULL;
> +
> +	drm_edid = drm_edid_read_custom(connector, drm_do_probe_acpi_edid, connector->dev);
> +
> +	/* Note: Do *not* call connector updates here. */
> +
> +	return drm_edid;
> +}
> +EXPORT_SYMBOL(drm_get_acpi_edid);
> +
>  /**
>   * drm_edid_read_custom - Read EDID data using given EDID block read function
>   * @connector: Connector to use
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 7923bc00dc7a..ca41be289fc6 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -410,6 +410,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
>  	void *data);
>  struct edid *drm_get_edid(struct drm_connector *connector,
>  			  struct i2c_adapter *adapter);
> +const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector);

There's a comment

/* Interface based on struct drm_edid */

towards the end of the file, gathering all the new API under it.

Other than that, LGTM,

BR,
Jani.

>  u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>  				     struct i2c_adapter *adapter);

-- 
Jani Nikula, Intel

