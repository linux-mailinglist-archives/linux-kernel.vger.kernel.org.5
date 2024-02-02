Return-Path: <linux-kernel+bounces-49674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70722846DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C951C2386E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC67CF03;
	Fri,  2 Feb 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc2n1tTn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2A42AA0;
	Fri,  2 Feb 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869794; cv=none; b=htgPO+S6y5c1aka59zWi0yL4K9zWboXkDnSTFm3KadN62jM/dSFABFNR2tXcOcGo2IbguQNhAKGGe2SFj2o98fBDPdYSGiOXXpn38C+kax1Ift31xDlHob+vFZihjE9Dwg4M3CUSu0PkRgcqoO18lT0as32GJLlmHcySMQjPSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869794; c=relaxed/simple;
	bh=h4TFBQqxGzZUFtP/Vmen1pxw3+bNKf4+pE9E/5QUd84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLRoljYWO7l+wa15YbLXPUkNJePjGrjlVk0VUFKckbTVTk7CQzut3b+vsyBA0pou1NUz6qmlA8BR9Tv+5KPo6b6ox5A1aQuD4ozlsp94zd7g3SKZ8LfPwyQJNiycM6z+U1dYFCs9Lyd/MH0W2XB3W6QrRg+UYQjgMmXiDPUt5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc2n1tTn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706869793; x=1738405793;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=h4TFBQqxGzZUFtP/Vmen1pxw3+bNKf4+pE9E/5QUd84=;
  b=Bc2n1tTnOn8MWSQDMJ0SOM8hechjQH+FROFteE6/XT9WK6Z8/KIztXWR
   wfFTcEt1aMF9QlKT1mKk25SyRRKnZcTFCp2/BmYptPdA79N3sAH8hdEGm
   w/+fklDB6BPjokikTBefHbgdqaQ+zbD5JG6Q7+Zc9En+0o1Od0OjJhqGy
   5bRg/1BOibixeOVf/DbmeIs60mxoPh6GDZTbRio/ttozg9WKC9MXp2j6F
   /+ZkFLDq7gi/EX12OhM8mPSpy5GYqYUpZq8r366v/NoFS7fN00oTRK5xk
   wZGAUCv0tO99jxEUaoB78OFoOom2rHLMYsh8Ge1/ENA19nXHdcGSjvw2Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10873615"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10873615"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4664969"
Received: from mistoan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.140])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:29:47 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/5] drm: Add drm_get_acpi_edid() helper
In-Reply-To: <20240201221119.42564-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240201221119.42564-1-mario.limonciello@amd.com>
 <20240201221119.42564-3-mario.limonciello@amd.com>
Date: Fri, 02 Feb 2024 12:29:42 +0200
Message-ID: <878r43f9bd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> Some manufacturers have intentionally put an EDID that differs from
> the EDID on the internal panel on laptops.  Drivers can call this
> helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.

I'm really not happy about adding new struct edid based APIs to
drm_edid.[ch]. Everything new should be struct drm_edid based. All
drivers should be converting towards struct drm_edid, instead of adding
more legacy to rip out later.

BR,
Jani.

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Split code from previous amdgpu specific helper to generic drm helper.
> v2->v3:
>  * Add an extra select to fix a variety of randconfig errors found from
>    LKP robot.
> ---
>  drivers/gpu/drm/Kconfig    |  5 +++
>  drivers/gpu/drm/drm_edid.c | 73 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  1 +
>  3 files changed, 79 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 2520db0b776e..14df907c96c8 100644
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
>  	help
>  	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>  	  introduced in XFree86 4.0. If you say Y here, you need to select
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 69c68804023f..1fbbeaa664b2 100644
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
> @@ -2188,6 +2189,47 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
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
> +		r = EINVAL;
> +		goto cleanup;
> +	}
> +
> +	memcpy(buf, edid + start, len);
> +	r = 0;
> +cleanup:
> +	kfree(edid);
> +	return r;
> +}
> +
>  static void connector_bad_edid(struct drm_connector *connector,
>  			       const struct edid *edid, int num_blocks)
>  {
> @@ -2643,6 +2685,37 @@ struct edid *drm_get_edid(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_get_edid);
>  
> +/**
> + * drm_get_acpi_edid - get EDID data, if available
> + * @connector: connector we're probing
> + *
> + * Use the BIOS to attempt to grab EDID data if possible.  If found,
> + * attach it to the connector.
> + *
> + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> + */
> +struct edid *drm_get_acpi_edid(struct drm_connector *connector)
> +{
> +	struct edid *edid = NULL;
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
> +	edid = _drm_do_get_edid(connector, drm_do_probe_acpi_edid, connector->dev, NULL);
> +
> +	drm_connector_update_edid_property(connector, edid);
> +	return edid;
> +}
> +EXPORT_SYMBOL(drm_get_acpi_edid);
> +
>  /**
>   * drm_edid_read_custom - Read EDID data using given EDID block read function
>   * @connector: Connector to use
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 518d1b8106c7..60fbdc06badc 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -412,6 +412,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
>  	void *data);
>  struct edid *drm_get_edid(struct drm_connector *connector,
>  			  struct i2c_adapter *adapter);
> +struct edid *drm_get_acpi_edid(struct drm_connector *connector);
>  u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>  				     struct i2c_adapter *adapter);

-- 
Jani Nikula, Intel

