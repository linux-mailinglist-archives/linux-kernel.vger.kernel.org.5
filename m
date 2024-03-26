Return-Path: <linux-kernel+bounces-119285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4188C699
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B27B307C46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027413C9A0;
	Tue, 26 Mar 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIIfsmuR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756613C823
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466112; cv=none; b=TnoIc/6DDS0TN+2AcCnVble1K3RGDZPfLJFAC4mmcEvhMVuoYpD3rEmvVXvIQcYeMFw66MiFjDivP51S9WoA8gowiGlIQdaVDznYh/xsPXc0DFL44h4H/DzA2domZ4N5uiCPBVeZcsQf2+HGusdvv+ZzX/14f8KQhcLyuM5ni2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466112; c=relaxed/simple;
	bh=IXO2Ah9koWHS0go21qzTnPnEoE9lxBreFqClDNUhmqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI7ZA2yCyT+rnCFKCGcpga9+Ay5LKOsGdUw7wbR9YEerLckJyqi8ZUBO+0ePRyMa5HhP2UIrBTbyVrE4ktiNWQmEOaVGaj6B7Zflcr2EqbnXd/d2Tskx6UjxwDVZZK9BWtdesrZeFWyVm2IB7kuwtCo+/lV59oWi/h1hXPM5OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIIfsmuR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466112; x=1743002112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXO2Ah9koWHS0go21qzTnPnEoE9lxBreFqClDNUhmqY=;
  b=oIIfsmuRAR+RBxijb4+G0L6m1H/ot6IX87GmRBHkhto/n+cfjUu62ll6
   AaU4QEZtwsUz8G6YccrZgczuGKg2QheIQCbSAR4RlTGeMISnyPcf56hZ5
   joBAVphwnH7ZESuLSdo1bme77po36nAK/rimDbCByzgIqvYkZvu3lfaPE
   WA61Tn9R0Hw3zebIgXnM8RvqN2MTnDnKIKU8uNaDxNzZeIdAx/FoADyf6
   nyim+BykrZSFwYjht0t7JwtQJmNtFQ/aP8X2YvfOV75Z6069XYDoC1ob/
   1bK+5AB4GN1O3R0Ox8RWMKQwRcZFbwrVk2oAqzUDmQ66gvP8azzIu6F99
   Q==;
X-CSE-ConnectionGUID: DKXgMIr5SpmMSQb132XWZw==
X-CSE-MsgGUID: vXUY9TQxSwSoq8trI2G+rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6418685"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6418685"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914883002"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914883002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:15:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8Vz-0000000GKtR-3fxl;
	Tue, 26 Mar 2024 17:15:03 +0200
Date: Tue, 26 Mar 2024 17:15:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 7/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLmd64URUOJ0pB9@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-7-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326010905.2147-7-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:09:04AM +0800, Baojun Xu wrote:
> Firmware binary load lib code for tas2781 spi driver.

..

> +// tas2781_spi_fwlib.c -- TASDEVICE firmware support

Please, remove file names from the files. This is just a burden: in case the
file gets renamed, often people forgot to update its contents.

Same applies to all such cases.

..

> +#define ERROR_PRAM_CRCCHK			0x0000000
> +#define ERROR_YRAM_CRCCHK			0x0000001
> +#define	PPC_DRIVER_CRCCHK			0x00000200

Stray TAB after define.

..

> +	/* In most projects are many audio cases, such as music, handfree,
> +	 * receiver, games, audio-to-haptics, PMIC record, bypass mode,
> +	 * portrait, landscape, etc. Even in multiple audios, one or
> +	 * two of the chips will work for the special case, such as
> +	 * ultrasonic application. In order to support these variable-numbers
> +	 * of audio cases, flexible configs have been introduced in the
> +	 * dsp firmware.

DSP

> +	 */

/*
 * The correct style of the multi-line comments
 * outside of net subsystem is depicted here. Please,
 * follow and update all the comments accordingly.
 */

..

> +	cfg_info = kzalloc(sizeof(struct tasdevice_config_info), GFP_KERNEL);

sizeof(*cfg_info)
Same applies to all similar cases.


> +	if (!cfg_info) {
> +		*status = -ENOMEM;
> +		goto out;
> +	}

..

> +	if (tas_priv->rcabin.fw_hdr.binary_version_num >= 0x105) {
> +		if (config_offset + 64 > (int)config_size) {

Explicit casting and to signed (sic!) is prone to mistakes. Can you refactor
to get rid of the casting?

> +			*status = -EINVAL;
> +			dev_err(tas_priv->dev, "add conf: Out of boundary\n");
> +			goto out;
> +		}
> +		config_offset += 64;
> +	}

..

> +	if (config_offset + 4 > (int)config_size) {

Ditto.

> +		*status = -EINVAL;
> +		dev_err(tas_priv->dev, "add config: Out of boundary\n");
> +		goto out;
> +	}

..

> +	/* convert data[offset], data[offset + 1], data[offset + 2] and
> +	 * data[offset + 3] into host
> +	 */

See above about comment style.

..

> +	cfg_info->nblocks =
> +		be32_to_cpup((__be32 *)&config_data[config_offset]);

Castings to bitwise types is something that should not happen.
So, this looks like homegrown version of get_unaligned_be32().

..

> +	bk_da = cfg_info->blk_data = kcalloc(cfg_info->nblocks,
> +		sizeof(struct tasdev_blk_data *), GFP_KERNEL);

sizeof(*bk_da) ?

> +	if (!bk_da) {
> +		*status = -ENOMEM;
> +		goto out;
> +	}

..

> +		if (bk_da[i]->block_type == TASDEVICE_BIN_BLK_PRE_POWER_UP) {
> +			if (bk_da[i]->dev_idx == 0)
> +				cfg_info->active_dev =
> +					(1 << tas_priv->ndev) - 1;
> +			else
> +				cfg_info->active_dev |= 1 <<
> +					(bk_da[i]->dev_idx - 1);

Use BIT()

> +

Stray blank line.

> +		}

..

> +		bk_da[i]->yram_checksum =
> +			be16_to_cpup((__be16 *)&config_data[config_offset]);
> +		config_offset += 2;
> +		bk_da[i]->block_size =
> +			be32_to_cpup((__be32 *)&config_data[config_offset]);
> +		config_offset += 4;
> +
> +		bk_da[i]->n_subblks =
> +			be32_to_cpup((__be32 *)&config_data[config_offset]);

get_unaligned_beXX() in all cases, beyond and above.

..

> +out:

Useless label, return directly.

> +	return cfg_info;

This also applies to many places in the code.

..

So, I have stopped here as I believe you have already enough material to rework
the series. I believe with my comments addressed you may shrink the code base
by ~5%.

Also next version probably needs a cover letter to explain a bit
what is this for and why you split patches in the unusual way and how you
suggested to get them working in between (to pass bisectability test).

-- 
With Best Regards,
Andy Shevchenko



