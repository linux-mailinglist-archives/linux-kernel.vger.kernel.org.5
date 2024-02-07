Return-Path: <linux-kernel+bounces-56634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65D84CD03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17DB2894F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CB7F465;
	Wed,  7 Feb 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaujFH/D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF25179B1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316849; cv=none; b=VeR/o1GjJ3jE/LgGN/Pz5x/GcEAqOkhGkWkasK4nRlUnzS9+kSoG3H84FpOHymls4yb36K7gL7JzLPUyftXzr1BjtU/IKK8nL88wUZV/jsNnKdGpQfURPfSXDWuMW8y/12orhEZJ8vn1reqYNVFgG53zDZM0xie9kP/uaghIfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316849; c=relaxed/simple;
	bh=jpQMKikXRFTP5gQGlKg5x/X3bPGQ1hHiDiklvQdwK5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOvBYm6GQKlTRLvaFNFsKuTwbtsJ0t+GMGPQINT+I3/f/lBsVacxX+vSnpn+ZIVRgoJBfEntSDYUMpGRMw1DtMGqr2YKe4OkdWksPQR6lu1FwsdPFpMenX4Mie+0tUXg4S6aeZghCPdDRQmiUoWi9y/Ziu0lBLpymGmaa0ImAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaujFH/D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707316847; x=1738852847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpQMKikXRFTP5gQGlKg5x/X3bPGQ1hHiDiklvQdwK5U=;
  b=SaujFH/DpGnEKicWDxRfKqp5dTTg6odAUprg02GOQfryguWB9bJ6Kijc
   Q3VE3fEF7ifQR8dOJtNWttbjBzkxfIsoZXfu+OGYnseG5V/o3kQ0DehkH
   bsqfHmQdQm4FMlFE5T7SqQePTjkaJX9+dfQ3vz+8UguMQgZ/fbDQ4nIHm
   cs91HzxflhjhNc4wP/Q7aQQcy2WyLuAdb2UoV95+8qhMuTra9vDkoM0Ln
   Ko5v+Wb6jLBYD93FkfKOYxYZq03Wnupe+iwM/JgrOv1l1ZFTqf5h0/ftV
   bw0CwwfTtN3vyXe3F1zfqTTO3wL0mAu7jFSR1TGFYSrkSx2HgGn61esJ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4865341"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4865341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="910008652"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910008652"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:40:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXj6N-00000002d9v-02Uz;
	Wed, 07 Feb 2024 16:40:39 +0200
Date: Wed, 7 Feb 2024 16:40:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	mengdong.lin@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, kevin-lu@ti.com, navada@ti.com, tiwai@suse.de,
	soyer@irl.hu
Subject: Re: [PATCH v7] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <ZcOWZlXu1fL_haFU@smile.fi.intel.com>
References: <20240207054743.1504-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207054743.1504-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 01:47:42PM +0800, Shenghao Ding wrote:
> The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
> interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces designed
> for portable applications. An on-chip DSP supports Texas Instruments
> SmartAmp speaker protection algorithm. The integrated speaker voltage and
> current sense provides for real-time monitoring of lodspeakers.
> 
> The ASoC component provides the majority of the functionality of the
> device, all the audio functions.

..

> +#include <linux/crc32.h>
> +#include <linux/efi.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/init.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Unused header. Maybe you use it as a "proxy"? Don't do this, include what you
use directly (with some exceptions when we know that one header guarantees to
include another).

> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include <sound/pcm_params.h>
> +#include <sound/sdw.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>

+ Blank line?

> +#include <sound/tas2781-tlv.h>
> +
> +#include "tas2783.h"

..

> +		/* Only reset register was volatiled.
> +		 * Software reset. Bit is self clearing.
> +		 * 0b = Don't reset
> +		 * 1b = reset
> +		 */

/*
 * The above style of the multi-line comment is used
 * solely by net subsystem. Please, fix all comments
 * in your driver accordingly.
 */

..

> +static const struct regmap_config tasdevice_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.readable_reg = tas2783_readable_register,
> +	.volatile_reg = tas2783_volatile_register,

> +	.max_register = 0x44ffffff,

I'm always wondering how this can work in debugfs when one tries to dump all
registers...

> +	.reg_defaults = tas2783_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_defaults),
> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};

..

> +static int tasdevice_clamp(int val, int max, unsigned int invert)
> +{
> +	/* Keep in valid area, out of range value don't care. */
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +	return val;

Can it be as simple as

	val = clamp(val, 0, max);
	if (invert)
		return max - val;
	return val;

?

> +}

..

> +		dev_err(tas_dev->dev, "%s, wrong parameter.\n", __func__);

Usually using __func__ in error messages signals about them being poorly
written.

..

> +		dev_err(tas_dev->dev, "%s, get digital vol error %x.\n",
> +			__func__, ret);

Like here, you repeat __func__ contents in the message itself.

..

> +	mask = (1 << fls(mc->max)) - 1;

Wouldn't roundup_pow_of_two() or roundown_pow_of_two() abe more explicit?

..

> +	mask = (1 << fls(mc->max)) - 1;

Ditto.

..

> +	reg_start = (u8 *)(cali_data + (tas_dev->sdw_peripheral->id.unique_id
> +		- TAS2783_ID_MIN) * sizeof(tas2783_cali_reg));

Strange indentation.

> +	for (int i = 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret = regmap_bulk_write(map, tas2783_cali_reg[i],
> +			&reg_start[4 * i], 4);

Ditto.

> +		if (ret) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +				tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}

..

> +	if (status != 0) {

if (status)

> +		/* Failed got calibration data from EFI. */
> +		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
> +		return 0;
> +	}

..

> +		/* Date and time of calibration was done. */
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_dev->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);

Use respective %pt

..

> +	img_sz = le32_to_cpup((__le32 *)&buf[offset]);

Potentially broken alignment. In any case this code is bad.
Use get_unaligned_le32() instead.

..

> +		dev_err(tas_dev->dev, "Size not matching, %d %u",
> +			(int)fmw->size, img_sz);

No castings in printf(). It's rarely when you need one. Here is just an
indication of mistype.

..

> +		if (ret != 0) {

		if (ret)

> +			dev_dbg(tas_dev->dev, "Load FW fail: %d.\n", ret);
> +			goto out;
> +		}
> +		offset += sizeof(unsigned int)*5 + p->length;

Missing spaces around '*'. And why magic number? What is it meaning?

..

> +	value_sdw |= ((tas_dev->sdw_peripheral->dev_num & 1) << 4);

Outer parentheses are not needed, perhaps BIT(0) instead of 1 will
be better to understand?

> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
> +		0, 0),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC")

Leave trailing comma as it's not a terminator.

> +};
> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
> +	{"OUT", NULL, "ASI"},
> +	{"ASI OUT", NULL, "DMIC"}

Ditto.

> +};

..

> +	dev_dbg(dai->dev, "%s %s", __func__, dai->name);

__func__ in dev_dbg() makes a little sense as we may enable it dynamically
(when Dynamic Debug is on). Generally speaking no debug messages should use
__LINE__, __FILE__, or __func__ in the modern kernel code.

..

> +	scnprintf(tas_dev->rca_binaryname, 64, "tas2783-%d-%x.bin",

sizeof() ?

> +		tas_dev->sdw_peripheral->bus->link_id,
> +		tas_dev->sdw_peripheral->id.unique_id);

..

> +out:

Useless label, you can return directly.

> +	return ret;

..

> +out:
> +	return ret;

Ditto.

..

> +	struct  tasdevice_priv *tas_priv = dev_get_drvdata(&slave->dev);

Too many spaces.

..

> +	tas_dev->regmap = devm_regmap_init_sdw(peripheral,
> +		&tasdevice_regmap);

One line?

> +	if (IS_ERR(tas_dev->regmap)) {
> +		ret = PTR_ERR(tas_dev->regmap);
> +		dev_err(dev, "Failed %d of devm_regmap_init_sdw.", ret);
> +	} else
> +		ret = tasdevice_init(tas_dev);
> +
> +	return ret;

	if (IS_ERR(tas_dev->regmap))
		return dev_err_probe(dev, PTR_ERR(tas_dev->regmap),
				     "Failed devm_regmap_init_sdw.");

	return tasdevice_init(tas_dev);

..


> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev = dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev->first_hw_init)
> +		pm_runtime_disable(tas_dev->dev);
> +
> +	pm_runtime_put_noidle(tas_dev->dev);
> +	return 0;

Are you sure this is correct order of calls as we have a lot of cleaning up
happening here?

> +}

..

> +static const struct sdw_device_id tasdevice_sdw_id[] = {
> +	SDW_SLAVE_ENTRY(0x0102, 0x0000, 0),
> +	{},

No comma for the terminator line.

> +};

> +

Unneeded blank line.

> +MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);

..

> +#define TAS2783_PROBE_TIMEOUT 5000

Missing units suffix (_US? _MS?)

> +static int __maybe_unused tas2783_sdca_dev_resume(struct device *dev)

No new code should use __maybe_unused for PM callbacks. Use pm_ptr() and
respective new PM macros.

..

> +static const struct dev_pm_ops tas2783_sdca_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume)
> +	SET_RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume, NULL)
> +};

Use new PM macros.

> +static struct sdw_driver tasdevice_sdw_driver = {
> +	.driver = {
> +		.name = "slave-tas2783",
> +		.pm = &tas2783_sdca_pm,
> +	},
> +	.probe = tasdevice_sdw_probe,
> +	.remove = tasdevice_sdw_remove,
> +	.ops = &tasdevice_sdw_ops,
> +	.id_table = tasdevice_sdw_id,
> +};

> +

Unneeded blank line.

> +module_sdw_driver(tasdevice_sdw_driver);

..

> +#ifndef __TAS2783_H__
> +#define __TAS2783_H__

+ linux/bits.h
+ linux/time.h
+ linux/types.h

+ sound/pcm.h

and so on, use IWYU (include what you use) principle.

Note, for the pointers you may use forward declarations, like

struct device;
struct regmap;

struct snd_soc_component;

-- 
With Best Regards,
Andy Shevchenko



