Return-Path: <linux-kernel+bounces-150240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE78A9C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400322876BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBAE1635B2;
	Thu, 18 Apr 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfEWmQ1x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38906165FAF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449005; cv=none; b=Kbt9FX1Ngm8xpsRowgfkM7+XO0D/GHr3V9ADm6dbtoztWnJ2l0VixZ/NURFHRIRVbVkEpRRvPOi5pqX11FoN/UiqWviMXzTchINz7gZmohYQfKIXN6mJo3LBUtYCD8pN+VqwnXpMUP0LOqEYDSsZ9f5aNQrSTRVtfk2K2NU+g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449005; c=relaxed/simple;
	bh=yXH9ZC5uZwf6Li9hqU2okU2Y0WKBNOwH6GMx6bQzJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKZQO1LRWFWfgvqsjDrkg9VVE8RI79UgF1Q8kvFt4EgFElRL1Wl9F5oTHTfdpFPVoztgKAFmeEhwp41mpf8/4XXb5DYij0E8TAWWHXAMWjgfQwi4HPIhmaqrkAf5ZOLifBULxDV1Xui2EO+mWDBTp9YPZR1lfcWJjzdgcvzTtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfEWmQ1x; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449003; x=1744985003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXH9ZC5uZwf6Li9hqU2okU2Y0WKBNOwH6GMx6bQzJXA=;
  b=bfEWmQ1xwVIoTxoW7HRQjptfhabDJEpTZZ7jtjMIYHKHIA41lhwa72+y
   6ZO0BFqmIr5M7nmNdrLgxQ9MlR3xeTTYRncgBCGzFst7vYYXgR7HGRGs0
   kBJNrCB9oYHlu05eCHKaFXEtESKnkPYp4Mk2xetX9ahKQRA0EW/1cbZJx
   L7xPFOAgqZ7nFWn80gPCDDr2xo5AOiNx7v3slxt54+Abc7FhS6q55x6qw
   wtV4KtAMULGk5B6mk9G721FBLt+Y3CDqfhorTp+stw7mKDhJNRpGOLtU1
   GWMEJlUk6Elxsanyl6N+DB6mDrCoTXJcwTXkQczHdxRcuhlgZDR5sGai4
   w==;
X-CSE-ConnectionGUID: b9I0At9DR5WypS9EZGGjFA==
X-CSE-MsgGUID: 0IO+p2xETCWW8Dn9/yOlaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19556176"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19556176"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:03:23 -0700
X-CSE-ConnectionGUID: zNL8Nw1YTwSoK0Cqge9fZw==
X-CSE-MsgGUID: UmeuNqZdT3qiKrdAZCWX2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="53932081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:03:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSM7-00000000LUk-0dAN;
	Thu, 18 Apr 2024 17:03:15 +0300
Date: Thu, 18 Apr 2024 17:03:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-po@ti.com, niranjan.hy@ti.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v3 2/3] ALSA: hda/tas2781: Main code of tas2781 driver
 for SPI
Message-ID: <ZiEoInH7W3Hfkynh@smile.fi.intel.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-3-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418040240.2337-3-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 12:02:38PM +0800, Baojun Xu wrote:
> Main source code for tas2781 driver for SPI.

..

> +#ifndef __TAS2781_SPI_H__
> +#define __TAS2781_SPI_H__

> +#include <sound/tas2781-dsp.h>

You have the missing inclusions like

+ types.h // for bool and so on

You missed a lot of forward declarations this header better to have.
I think I pointed this out already.

..

> +/*PAGE Control Register (available in page0 of each book) */

Missing space.

..

> +#define TASDEVICE_BOOKCTL_REG		127
> +#define TASDEVICE_BOOK_ID(reg)		(reg / (256 * 128))
> +#define TASDEVICE_PAGE_ID(reg)		((reg % (256 * 128)) / 128)
> +#define TASDEVICE_PAGE_REG(reg)		((reg % (256 * 128)) % 128)
> +#define TASDEVICE_PGRG(reg)		(reg % (256 * 128))
> +#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
> +					(page * 128)) + reg)
> +
> +#define TASDEVICE_MAX_BOOK_NUM		256
> +#define TASDEVICE_MAX_PAGE		128

So, shouldn't the above use these definitions as well?

..

> +/*Software Reset */

Missing spaces. Please, fix all problems like this in the entire series.

..

> +#define TAS2781_SPI_MAX_FREQ		4000000

(4 * HZ_PER_MHZ) ?
Will need units.h IIRC for this.

> +#include <linux/acpi.h>

+ array_size.h

> +#include <linux/bits.h>
> +#include <linux/crc8.h>
> +#include <linux/crc32.h>
> +#include <linux/efi.h>
> +#include <linux/firmware.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

..

> +		.range_max = TASDEVICE_MAX_BOOK_NUM * TASDEVICE_MAX_PAGE,
> +		.selector_reg = TASDEVICE_PAGE_SELECT,
> +		.selector_mask = 0xff,

GENMASK() ?

> +		.selector_shift = 0,
> +		.window_start = 0,
> +		.window_len = 128,

Shouldn't these 0xff and 128 be applied thry previously defined constants?
I mean are they have a relation to _BOOK_NUM and _MAX_PAGE?

..

> +static int tasdevice_spi_switch_book(struct tasdevice_priv *tas_priv, int book)
> +{
> +	struct tasdevice *tasdev = &tas_priv->tasdevice;
> +	struct regmap *map = tas_priv->regmap;

> +	int ret = 0;

Redundant assignment, see below

> +	if (tasdev->cur_book != book) {

	if (tasdev->cur_book == book)
		return 0;

> +		/* Change to page 0 before book change. */
> +		ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
> +		if (ret < 0) {
> +			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
> +			return ret;
> +		}
> +		ret = regmap_write(map, TASDEVICE_BOOKCTL_REG, book);
> +		if (ret < 0) {
> +			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
> +			return ret;
> +		}
> +		tasdev->cur_book = book;
> +	}
> +
> +	return ret;

	return 0;

> +}

..

> +		ret = regmap_bulk_read(map, TASDEVICE_PGRG(reg),
> +			buf, len + 1);

THis can be one line.

..

> +	if (tas_dev->reset) {
> +		gpiod_set_value_cansleep(tas_dev->reset, 0);
> +		usleep_range(500, 1000);

fsleep()

> +		gpiod_set_value_cansleep(tas_dev->reset, 1);
> +	} else {
> +		ret = tasdevice_spi_dev_write(tas_dev,
> +			TAS2781_REG_SWRESET, TAS2781_REG_SWRESET_RESET);

Indentation is broken and seems you have a room for one parameter above.

> +		if (ret < 0)
> +			dev_err(tas_dev->dev, "dev sw-reset fail, %d\n", ret);
> +	}
> +	usleep_range(1000, 1050);

fsleep()

,,,

> +{
> +	int ret = 0;

Redundant assignment.

> +	/*
> +	 * Codec Lock Hold to ensure that codec_probe and firmware parsing and
> +	 * loading do not simultaneously execute.
> +	 */
> +	mutex_lock(&tas_priv->codec_lock);
> +
> +	scnprintf(tas_priv->rca_binaryname, 64, "%sRCA%d.bin",

Why 'c' variant as you don't check the return value anyway.
And shouldn't it be sizeof() in the second parameter?

> +		tas_priv->dev_name, tas_priv->index);
> +	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
> +	tas_priv->codec = codec;
> +	ret = request_firmware_nowait(module, FW_ACTION_UEVENT,
> +		tas_priv->rca_binaryname, tas_priv->dev, GFP_KERNEL, tas_priv,
> +		cont);
> +	if (ret)
> +		dev_err(tas_priv->dev, "request_firmware_nowait err:0x%08x\n",
> +			ret);
> +
> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_priv->codec_lock);

Why not using cleanup.h, i.e. guard() and scoped_guard(), from day 1?

> +	return ret;
> +}

..

> +static int tasdevice_clamp(int val, int max, unsigned int invert)
> +{
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +
> +	return val;

Wouldn't below be the same?

	return clamp(invert ? max - val : val, 0, max);

(if max can be negative the above won't work, but an original code
 would also give a surprising values AFAICS.)

> +}

..

> +	mask = (1 << fls(max)) - 1;

Use respective roundup/down_pow_of_two().
Same in other similar cases.

..

> +	ret = device_property_count_u32(physdev, property);
> +	if (ret <= 0)

So, when 0 you return 0. Is it expected?

> +		goto err;

..

> +	p->index = 0xFF;

Why capital? Shouldn't it be rather U8_MAX or something like this?

> +	for (i = 0; i < nval; i++) {
> +		if (values[i] == id) {
> +			p->index = i;
> +			break;
> +		}
> +	}
> +	if (p->index == 0xFF) {

Ditto.

> +		dev_dbg(p->dev, "No index found in %s\n", property);
> +		ret = -ENODEV;
> +		goto err;
> +	}

..

> +	p->reset = devm_gpiod_get_index_optional(physdev,
> +		"reset", p->index, GPIOD_OUT_LOW);

Broken indentation. You have plenty of lines like this, please fix them all.

> +	if (IS_ERR(p->reset)) {
> +		ret = PTR_ERR(p->reset);
> +
> +		/*
> +		 * If RESET is shared the first amp to probe will grab the
> +		 * reset line and reset all the amps
> +		 */
> +		if (ret != -EBUSY) {
> +			dev_err_probe(p->dev, ret,
> +				"Failed to get reset GPIO\n");
> +			goto err;
> +		}
> +		dev_info(p->dev, "Reset GPIO busy, assume shared reset\n");
> +		p->reset = NULL;
> +	}

Why can't this use reset framework which supports shared / exclusive resets?


..

> +	 * Manually set the Chip Select for the second amp <cs_gpio_index>
> +	 * in the node.
> +	 * This is only supported for systems with 2 amps, since we cannot
> +	 * expand the default number of chip selects without using cs-gpios

Missing period at the end.

Btw, SPI has multi-CS support, would it help here?

> +	 * The CS GPIO must be set high prior to communicating with the
> +	 * first amp (which uses a native chip select), to ensure the second
> +	 * amp does not clash with the first.

> +	if (IS_ENABLED(CONFIG_SPI)) {

I would rather prefer to see in spi.h

#if IS_ENABLED(CONFIG_SPI)
#define dev_is_spi(d)	((d)->bus == &spi_bus_type)
#else
#define dev_is_spi(d)	false
#endif

and here

	if (dev_is_spi(...)) {

> +		spi = to_spi_device(p->dev);
> +
> +		/*
> +		 * This is obtained using driver_gpios, since only one GPIO
> +		 * for CS exists, this can be obtained using index 0.
> +		 */
> +		cs_gpiod = devm_gpiod_get_index_optional(physdev, "cs",
> +			p->index, GPIOD_OUT_LOW);
> +		if (IS_ERR(cs_gpiod)) {
> +			dev_err(p->dev, "Unable to get CS GPIO descriptor\n");
> +			ret = PTR_ERR(cs_gpiod);
> +			goto err;
> +		}
> +		if (id == 1) {
> +			spi_set_csgpiod(spi, 0, cs_gpiod);
> +			p->chipselect = cs_gpiod;
> +		} else {
> +			gpiod_set_value_cansleep(cs_gpiod, true);

> +			gpiod_put(cs_gpiod);

How can this be correct in conjunction with devm?

> +		}
> +		spi_setup(spi);
> +	}

..

> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
> +	int max = tas_priv->rcabin.ncfgs - 1;
> +	int val, ret = 0;

Redundant assignment and even entire ret is not needed.

> +	val = clamp(ucontrol->value.integer.value[0], 0, max);

> +

Redundant blank line.

> +	if (tas_priv->rcabin.profile_cfg_id != val) {

	if (tas_priv->rcabin.profile_cfg_id == val)
		return 0;

> +		tas_priv->rcabin.profile_cfg_id = val;
> +		ret = 1;
> +	}
> +
> +	return ret;

	return 1;

> +}

..

> +static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)

As per above function comments.

..

> +static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)

Ditto.

..

> +/*

Why not marking it as kernel doc?

> + * tas2781_digital_getvol - get the volum control
> + * @kcontrol: control pointer
> + * @ucontrol: User data

+ blank line.

> + * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
> + * depends on internal regmap mechanism.
> + * tas2781 contains book and page two-level register map, especially
> + * book switching will set the register BXXP00R7F, after switching to the
> + * correct book, then leverage the mechanism for paging to access the
> + * register.

+ blank line.

+ Return: section.

> + */

..

> +	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
> +		tas_priv->force_fwload_status ? "ON" : "OFF");

str_on_off() from string_choices.h

..

> +	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
> +		tas_priv->force_fwload_status ? "ON" : "OFF");

Ditto.

..

> +	for (j = 0; j < CALIB_MAX; j++) {
> +		rc = tasdevice_spi_dev_bulk_write(tas_priv,
> +			TASDEVICE_REG(0, page_array[j], rgno_array[j]),
> +			(unsigned char *)&tas_priv->calibration_data[j], 4);
> +		if (rc < 0)
> +			dev_err(tas_priv->dev,
> +				"chn %d calib %d bulk_wr err = %d\n",
> +				tas_priv->index, j, rc);

Non-fatal? How it will work then?

> +	}
> +}

..

> +	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
> +		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);

Make it look more standard as three line assignment:

	efi_guid_t efi_guid =
		EFI_GUID(0x02f9af02, 0x7734, 0x4233,
			 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);

Also add a comment that will have this GUID in human-readable format suitable
for googling.

..

> +	if (status == EFI_BUFFER_TOO_SMALL) {
> +		/* Allocate data buffer of data_size bytes */
> +		data = devm_kzalloc(tas_priv->dev, total_sz, GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +		/* Get variable contents into buffer */
> +		status = efi.get_variable(efi_name, &efi_guid, &attr,
> +			&total_sz, data);
> +	}
> +	if (status != EFI_SUCCESS) {
> +		kfree(data);

Really you should read and understand what devm means and what is the scope
when you can use it. The code is full of double-free bugs.

> +		return -EINVAL;
> +	}

..

> +		if (crc == tmp_val[3+tmp_val[0]*6]) {

> +			time64_to_tm(tmp_val[2], 0, tm);
> +			dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +				tm->tm_year, tm->tm_mon, tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec);

No, use respective %pt.

> +			for (int i = 0; i < CALIB_MAX; i++)
> +				tas_priv->calibration_data[i] =
> +					tmp_val[3 + tas_priv->index * 6 + i];
> +			tas_priv->apply_calibration(tas_priv);
> +		} else {
> +			total_sz = 0;
> +		}

..

> +		if (crc == tmp_val[21]) {
> +			time64_to_tm(tmp_val[20], 0, tm);
> +			dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +				tm->tm_year, tm->tm_mon, tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec);

Ditto.

> +			for (int i = 0; i < CALIB_MAX; i++)
> +				tas_priv->calibration_data[i] =
> +					tmp_val[tas_priv->index * 5 + i];
> +			tas_priv->apply_calibration(tas_priv);
> +		}

> +	kfree(data);

KABOOM!

> +
> +	return 0;
> +}

..

> +	for (int i = ARRAY_SIZE(tas_hda->snd_ctls) - 1; i >= 0; i--)
> +		if (tas_hda->snd_ctls[i])
> +			snd_ctl_remove(codec->card, tas_hda->snd_ctls[i]);

Cleanup loops are better in a while (i--) form.


	unsigned int i = ARRAY_SIZE(tas_hda->snd_ctls);

	while (i--) {
		if (tas_hda->snd_ctls[i])
			snd_ctl_remove(codec->card, tas_hda->snd_ctls[i]);
	}

BUT, if not yet, just add a support of NULL into snd_ctl_remove(), so it
becomes a NULL-aware one. With that you will have

	while (i--)
		snd_ctl_remove(codec->card, tas_hda->snd_ctls[i]);

as a traditional pattern for many things in Linux kernel.

.

> +static const struct dev_pm_ops tas2781_hda_pm_ops = {
> +	RUNTIME_PM_OPS(tas2781_runtime_suspend, tas2781_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(tas2781_system_suspend, tas2781_system_resume)
> +};
> +
> +static const struct spi_device_id tas2781_hda_spi_id[] = {
> +	{ "tas2781-hda", 0 },

', 0' part is redundant.

> +	{}
> +};
> +
> +static const struct acpi_device_id tas2781_acpi_hda_match[] = {
> +	{"TXNW2781", 0 },

Ditto.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
> +
> +static struct spi_driver tas2781_hda_spi_driver = {
> +	.driver = {
> +		.name		= "tas2781-hda",
> +		.acpi_match_table = tas2781_acpi_hda_match,

> +		.pm		= &tas2781_hda_pm_ops,

Use proper pm_*() macro here.

> +	},
> +	.id_table	= tas2781_hda_spi_id,
> +	.probe		= tas2781_hda_spi_probe,
> +	.remove		= tas2781_hda_spi_remove,
> +};

..

I stop here, you need much more cleaning work on these patches. Also, with
cleanup.h and other things in mind you can easily shrink the code by 10%
or so, I will expect -300 LoCs in the next version.

-- 
With Best Regards,
Andy Shevchenko



