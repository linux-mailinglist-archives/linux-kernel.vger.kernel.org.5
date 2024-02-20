Return-Path: <linux-kernel+bounces-73025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4863385BC41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD453B259DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C16997C;
	Tue, 20 Feb 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXLiwpgW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85369941
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432370; cv=none; b=Bqu8TgQJWyO2xoetjS7WNwOJiR2skyFASpGj1TZzLaZT3ftAasvgSYU01WDn0YT+yqoyro/dSSoK8foHCLKB6PbYqnkPuwWzEQsv/iMQ2R22guT7/pMqdQMo/xSStFbRirMEu0uSbvzjcwkHj+lhP9F3ik61HB13bMx8zkH3+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432370; c=relaxed/simple;
	bh=cFxAPeixrrkBcvkFKM9uK9ciH82I1tyfkh8gtrX7CMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7FJapD6K0qa5d7N4Ug6FUEzlwSe94dxa3TWVSJuyVeN13Hg9rS9Nx+CbACzNfiCUOJhGc9aLAVcS91GtecEfNU6DKfwWi6V0abpsqLgH11rdYDRX4J0PilZosmT9IvUw917uYVGK7zgd/dCXun9cgLPlx4sh8fbxQRxUxo0Arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXLiwpgW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708432368; x=1739968368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cFxAPeixrrkBcvkFKM9uK9ciH82I1tyfkh8gtrX7CMc=;
  b=aXLiwpgW04wnbvJSpjC8LQk1GcQBgdmaNMhkYPgr8HzSnVi11hKmZf46
   i8S39DSdiarrJx46j/GoQgcAhcsmIObMbsqzib1O8W3Awo9TZjKX4LFe/
   6iUoCjtW0TVsTBE4aMkheiUmJNDduQ1PDBbVqm25VtXw4b8/g/XAQIaqf
   Nxo8DLfJEaSYM5RPdiaJq4wiWErErwNdKDERbbKqFoR0LJPwDUztizs9g
   ttWjKs3i/MV9PVcgndESzsOD4dQX5dEF9cJqpBKLFbFXZeht1W7ckI0u/
   kpAb99r5NHDvy3YAKLCUC38q3/gjVwkR1uNAyTdEV0ZJpVLD36vDiyFlI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13942899"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13942899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35528286"
Received: from pjayasek-mobl.amr.corp.intel.com (HELO [10.246.112.112]) ([10.246.112.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:32:45 -0800
Message-ID: <ae5b3c49-308e-465c-8bc6-c0e1ac79f19f@linux.intel.com>
Date: Tue, 20 Feb 2024 07:32:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] ASoc: tas2783: Add tas2783 codec driver
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 bard.liao@intel.com, mengdong.lin@intel.com,
 yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
 tiwai@suse.de, soyer@irl.hu
References: <20240219022153.553-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240219022153.553-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It's starting to look good, but the use of the dev_num is conceptually 
broken. The only way to reliably identify a device is the combination of 
link_id and unique_id. The information is present for both ACPI and DT 
systems. See comments below.
-Pierre

> +static void tas2783_apply_calib(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	u8 *cali_start;
> +	u16 dev_num;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	dev_num = clamp(tas_dev->sdw_peripheral->dev_num, 1, 4) - 1;

Not following what restrictions you are trying to enforce on the device 
number. That's a value selected by the manager. You absolutely cannot 
assume the value is between 1 and 4, the max value is 11.

> +	/*
> +	 * The area saving tas2783 calibrated data is specified by its
> +	 * dev_num. cali_start is the first address of current tas2783's
> +	 * calibrated data.
> +	 */
> +	cali_start = (u8 *)(cali_data + dev_num * sizeof(tas2783_cali_reg));
> +	for (int i = 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret = regmap_bulk_write(map, tas2783_cali_reg[i],
> +			&cali_start[4 * i], 4);
> +		if (ret) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +				tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * Load the calibration data, including speaker impedance, f0, etc.
> + * Calibration is done by the manufacturer in the factory. The calibration
> + * data are used by the algorithm for calculating the speaker temperature,
> + * speaker membrane excursion and f0 in real time during playback.
> + * The DSP will work with default data values if calibrated data are
> + * missing or are invalid.
> + * Layout of calibrated Data in UEFI:
> + *	Calibrated Data of Dev 0 (20 bytes)
> + *	Calibrated Data of Dev 1 (20 bytes)
> + *	Calibrated Data of Dev 2 (20 bytes)
> + *	Calibrated Data of Dev 3 (20 bytes)

You will have a hard-time matching those device indices with the 
dev_num, which depends on the enumeration order and the bus allocation.

The only stable board-specific value is to use a combination of link_id 
and unique_id (possibly controller id as well).


> + *	CRC (4 bytes)
> + */

> +static int tasdevice_comp_probe(struct snd_soc_component *comp)
> +{
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(comp);
> +	acpi_handle handle = ACPI_HANDLE(tas_dev->dev);
> +	const struct firmware *fw_entry = NULL;
> +	const char *sub = NULL;
> +	int ret, value_sdw;
> +
> +	if (handle) {
> +		sub = acpi_get_subsystem_id(handle);
> +		if (IS_ERR(sub))
> +			sub = NULL;
> +	}
> +
> +	tas_dev->component = comp;
> +
> +	/*
> +	 * Each tas2783 in the system has its own dspfw.
> +	 */
> +	if (comp->name_prefix) {
> +		/*
> +		 * name_prefix.bin stores the dsp firmware including speaker
> +		 * protection algorithm, audio acoustic algorithm, speaker
> +		 * characters and algorithm params, it must be copied into
> +		 * firmware folder.
> +		 */
> +		scnprintf(tas_dev->dspfw_binaryname,
> +			TAS2783_DSPFW_FILENAME_LEN, "%s-tas2783.bin",
> +			comp->name_prefix);
> +	} else {
> +		/* Compatible with the previous naming rule */
> +		if (sub) {
> +		/*
> +		 * subsystem_id-link_id[0,1,...,N]-dev_num[1,...,4].bin stores
> +		 * the dsp firmware including speaker protection algorithm,
> +		 * audio acoustic algorithm, speaker characters and algorithm
> +		 * params, it must be copied into firmware folder.

no the dev_num cannot be used. It's only used for host-device 
communication and cannot be used to identify a device position.

The link_id+unique_unique is the only way to go.

But in addition you want want to consider a platform-specific prefix 
which contains the OEM name or device SKU.

> +		 */
> +			scnprintf(tas_dev->dspfw_binaryname,
> +				TAS2783_DSPFW_FILENAME_LEN,
> +				"%s-%d-%d.bin", sub,
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->dev_num);
> +		} else {
> +		/*
> +		 * tas2783-link_id[0,1,...,N]-dev_num[1,...,4].bin stores
> +		 * the dsp firmware including speaker protection algorithm,
> +		 * audio acoustic algorithm, speaker characters and algorithm
> +		 * params, it must be copied into firmware folder.
> +		 */
> +			scnprintf(tas_dev->dspfw_binaryname,
> +				TAS2783_DSPFW_FILENAME_LEN,
> +				"tas2783-%d-%d.bin",
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->dev_num);
> +		}
> +	}
> +
> +	ret = request_firmware(&fw_entry, tas_dev->dspfw_binaryname,
> +		tas_dev->dev);
> +	if (ret) {
> +		dev_err(tas_dev->dev,
> +			"%s: request_firmware %x open status: %d.\n", __func__,
> +			tas_dev->sdw_peripheral->id.unique_id, ret);
> +		goto out;
> +	}
> +
> +	tasdevice_dspfw_ready(fw_entry, tas_dev);
> +
> +	/* Select left/right channel based on device number. */
> +	value_sdw = 0x1a;
> +	value_sdw |= (tas_dev->sdw_peripheral->dev_num & BIT(0)) << 4;
> +	dev_dbg(tas_dev->dev, "%s: dev_num = %u", __func__,
> +		tas_dev->sdw_peripheral->dev_num);
> +	regmap_write(tas_dev->regmap, TAS2783_REG_TDM_RX_CFG, value_sdw);
> +	if (ret != 0)
> +		dev_warn(tas_dev->dev, "%s: L/R setting failed: %d.\n",
> +			__func__, ret);
> +
> +out:
> +	if (fw_entry)
> +		release_firmware(fw_entry);
> +	return 0;
> +}

> +static int tasdevice_io_init(struct device *dev,
> +	struct sdw_slave *slave)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	regcache_cache_only(tas_priv->regmap, false);
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, true);
> +	} else {
> +	/*
> +	 * PM runtime is only enabled when a Slave reports as Attached
> +	 * Update count of parent 'active' children
> +	 */

weird indentation for comments in multiple places.

> +		pm_runtime_set_active(&slave->dev);
> +	}
> +
> +	/* sw reset */
> +	ret = regmap_write(tas_priv->regmap, TAS2873_REG_SWRESET,
> +		TAS2873_REG_SWRESET_RESET);
> +	if (ret) {
> +		dev_err(tas_priv->dev, "Reset failed.\n");
> +		goto out;
> +	}
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, false);
> +		regcache_mark_dirty(tas_priv->regmap);
> +	}
> +
> +	tas_priv->first_hw_init = true;
> +	tas_priv->hw_init = true;
> +
> +out:
> +	return ret;
> +}



