Return-Path: <linux-kernel+bounces-67060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E785658C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F091F2ABFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7E13247E;
	Thu, 15 Feb 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYYFyqNY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51313173E;
	Thu, 15 Feb 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006185; cv=none; b=BMz3RDxz4EfnvxTi53GK7KlPL2V/Z7QrYG/3QtGzS3mG7EZZYXAlLPGtl8OJl6hbAPMrp24UftvmSsBP/h8mpOCCz8WoPpuThbYB/y3F2mue+BLGllTVQsVxuCemrE4OXlICUcynVKqEKLp7utY78d5tur0R1TwaCcx1bBHuRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006185; c=relaxed/simple;
	bh=ZK2umLioglf89yU9tmbEroOx64HCpi4rqovNuj54BBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmqRDzPIFbwifO+rgo+UakyqwOtqvyh6QiOQUighFknjLV+IJrRksrmE0qDK7VftTa2Hch2/DDhsqrAvrFOczCRL3kOwEYHYcTpveBo+uo7OaQK7dByzF4Kg33vtNdS0x0wkozjigdsFIAqlXOTUQazuG2r9S3L5+xKrckWlc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYYFyqNY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708006182; x=1739542182;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZK2umLioglf89yU9tmbEroOx64HCpi4rqovNuj54BBE=;
  b=fYYFyqNYcy/dvE2wayy0FXaAqRDDp2oPB4s+4Jy0QBEtZlF5k6DeiHcO
   ZoGuxNQwpUh7ZzuIOdCJxBQufDUfLDn1gwF9i+zb0ai0DwbNfHG2Jhw2p
   3f4GbRLefy6WSq/48WWNxj7lqsrlS+gIvxeX/NAVjkKTbCcFyLAXgjVS8
   f/LfgHozhyB7mCiVlbZF9L2Ah8xkMcNnxFwvCYZuawuE+kV+yRufnWtF9
   N2DGQZHsWXrQ57lX3K1N9pG7um/IIi6v6aGfTUSrSlIHPN+fEtNe22IUe
   RMLtXazBkdp4S6XaYeVMQX6eKB/oqOhx8s52Jd/fAYdww2u9sxgOMbXa7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2218642"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2218642"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8175597"
Received: from kraszkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.13])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:09:36 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Daniel Vetter
 <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>
Cc: amd-gfx@lists.freedesktop.org, "open list:USB SUBSYSTEM"
 <linux-usb@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Melissa Wen <mwen@igalia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 3/5] drm: Add support to get EDID from ACPI
In-Reply-To: <20240214215756.6530-4-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240214215756.6530-1-mario.limonciello@amd.com>
 <20240214215756.6530-4-mario.limonciello@amd.com>
Date: Thu, 15 Feb 2024 16:09:33 +0200
Message-ID: <87a5o16cpu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 14 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> Some manufacturers have intentionally put an EDID that differs from
> the EDID on the internal panel on laptops.  Drivers that prefer to
> fetch this EDID can set a bit on the drm_connector to indicate that
> the DRM EDID helpers should try to fetch it and it is preferred if
> it's present.

I just replied to a previous version of the patch [1]. Looks like all
the comments there still hold.

BR,
Jani.


[1] https://lore.kernel.org/r/87eddd6d41.fsf@intel.com


>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/Kconfig     |   1 +
>  drivers/gpu/drm/drm_edid.c  | 109 +++++++++++++++++++++++++++++++++---
>  include/drm/drm_connector.h |   6 ++
>  include/drm/drm_edid.h      |   1 +
>  4 files changed, 109 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 872edb47bb53..3db89e6af01d 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -8,6 +8,7 @@
>  menuconfig DRM
>  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
>  	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
> +	depends on (ACPI_VIDEO || ACPI_VIDEO=n)
>  	select DRM_PANEL_ORIENTATION_QUIRKS
>  	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>  	select FB_CORE if DRM_FBDEV_EMULATION
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 923c4423151c..cdc30c6d05d5 100644
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
> @@ -2188,6 +2189,58 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
>  	return ret == xfers ? 0 : -1;
>  }
>  
> +/**
> + * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
> + * @data: struct drm_connector
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
> +	struct drm_connector *connector = data;
> +	struct drm_device *ddev = connector->dev;
> +	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
> +	unsigned char start = block * EDID_LENGTH;
> +	void *edid;
> +	int r;
> +
> +	if (!acpidev)
> +		return -ENODEV;
> +
> +	switch (connector->connector_type) {
> +	case DRM_MODE_CONNECTOR_LVDS:
> +	case DRM_MODE_CONNECTOR_eDP:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* fetch the entire edid from BIOS */
> +	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> +	if (r < 0) {
> +		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
> +		return r;
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
> @@ -2621,7 +2674,8 @@ EXPORT_SYMBOL(drm_probe_ddc);
>   * @connector: connector we're probing
>   * @adapter: I2C adapter to use for DDC
>   *
> - * Poke the given I2C channel to grab EDID data if possible.  If found,
> + * If the connector allows it, try to fetch EDID data using ACPI. If not found
> + * poke the given I2C channel to grab EDID data if possible.  If found,
>   * attach it to the connector.
>   *
>   * Return: Pointer to valid EDID or NULL if we couldn't find any.
> @@ -2629,20 +2683,50 @@ EXPORT_SYMBOL(drm_probe_ddc);
>  struct edid *drm_get_edid(struct drm_connector *connector,
>  			  struct i2c_adapter *adapter)
>  {
> -	struct edid *edid;
> +	struct edid *edid = NULL;
>  
>  	if (connector->force == DRM_FORCE_OFF)
>  		return NULL;
>  
> -	if (connector->force == DRM_FORCE_UNSPECIFIED && !drm_probe_ddc(adapter))
> -		return NULL;
> +	if (connector->acpi_edid_allowed)
> +		edid = _drm_do_get_edid(connector, drm_do_probe_acpi_edid, connector, NULL);
> +
> +	if (!edid) {
> +		if (connector->force == DRM_FORCE_UNSPECIFIED && !drm_probe_ddc(adapter))
> +			return NULL;
> +		edid = _drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter, NULL);
> +	}
>  
> -	edid = _drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter, NULL);
>  	drm_connector_update_edid_property(connector, edid);
>  	return edid;
>  }
>  EXPORT_SYMBOL(drm_get_edid);
>  
> +/**
> + * drm_edid_read_acpi - get EDID data, if available
> + * @connector: connector we're probing
> + *
> + * Use the BIOS to attempt to grab EDID data if possible.
> + *
> + * The returned pointer must be freed using drm_edid_free().
> + *
> + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> + */
> +const struct drm_edid *drm_edid_read_acpi(struct drm_connector *connector)
> +{
> +	const struct drm_edid *drm_edid;
> +
> +	if (connector->force == DRM_FORCE_OFF)
> +		return NULL;
> +
> +	drm_edid = drm_edid_read_custom(connector, drm_do_probe_acpi_edid, connector);
> +
> +	/* Note: Do *not* call connector updates here. */
> +
> +	return drm_edid;
> +}
> +EXPORT_SYMBOL(drm_edid_read_acpi);
> +
>  /**
>   * drm_edid_read_custom - Read EDID data using given EDID block read function
>   * @connector: Connector to use
> @@ -2727,10 +2811,11 @@ const struct drm_edid *drm_edid_read_ddc(struct drm_connector *connector,
>  EXPORT_SYMBOL(drm_edid_read_ddc);
>  
>  /**
> - * drm_edid_read - Read EDID data using connector's I2C adapter
> + * drm_edid_read - Read EDID data using BIOS or connector's I2C adapter
>   * @connector: Connector to use
>   *
> - * Read EDID using the connector's I2C adapter.
> + * Read EDID from BIOS if allowed by connector or by using the connector's
> + * I2C adapter.
>   *
>   * The EDID may be overridden using debugfs override_edid or firmware EDID
>   * (drm_edid_load_firmware() and drm.edid_firmware parameter), in this priority
> @@ -2742,10 +2827,18 @@ EXPORT_SYMBOL(drm_edid_read_ddc);
>   */
>  const struct drm_edid *drm_edid_read(struct drm_connector *connector)
>  {
> +	const struct drm_edid *drm_edid = NULL;
> +
>  	if (drm_WARN_ON(connector->dev, !connector->ddc))
>  		return NULL;
>  
> -	return drm_edid_read_ddc(connector, connector->ddc);
> +	if (connector->acpi_edid_allowed)
> +		drm_edid = drm_edid_read_acpi(connector);
> +
> +	if (!drm_edid)
> +		drm_edid = drm_edid_read_ddc(connector, connector->ddc);
> +
> +	return drm_edid;
>  }
>  EXPORT_SYMBOL(drm_edid_read);
>  
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index fe88d7fc6b8f..74ed47f37a69 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1886,6 +1886,12 @@ struct drm_connector {
>  
>  	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
>  	struct hdr_sink_metadata hdr_sink_metadata;
> +
> +	/**
> +	 * @acpi_edid_allowed: Get the EDID from the BIOS, if available.
> +	 * This is only applicable to eDP and LVDS displays.
> +	 */
> +	bool acpi_edid_allowed;
>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 7923bc00dc7a..1c1ee927de9c 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -459,5 +459,6 @@ bool drm_edid_is_digital(const struct drm_edid *drm_edid);
>  
>  const u8 *drm_find_edid_extension(const struct drm_edid *drm_edid,
>  				  int ext_id, int *ext_index);
> +const struct drm_edid *drm_edid_read_acpi(struct drm_connector *connector);
>  
>  #endif /* __DRM_EDID_H__ */

-- 
Jani Nikula, Intel

