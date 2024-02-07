Return-Path: <linux-kernel+bounces-56793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D400484CF3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A5AB2829D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28340823A1;
	Wed,  7 Feb 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW5WC5TR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1C81ADB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324467; cv=none; b=AHfzyt3l2PJOlhod4SKtO7MH9uuoNRbchXcyZ2lSZe9vRM9v0kq/AqBDScaf+HnXFNH19OHLu4HBZBOAR/aO8XWGQOMpn3r/FuMbX9z3x4pdhBgA+OmSh4gOmbN4LP/cOYuPpZiNwkhHvmKUOdN1BA29UkbZdJeXKqZK4qVf2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324467; c=relaxed/simple;
	bh=O8TFoIddkKyvAT0AdWOOk8Cu0gey2ydHbGJH/Xhc9Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzYLH6a+9ISn0gpRpa5W4wUZNNpMszL3vuy4K0IFUX/RA50Q0AqWRuiJioL2pZYHLlPk5cbX3flLuHfUlyEb7SjOjCvcQiT9dC+RBO6VG1AMs7tyXqluP3Rkg3IU7Ew5x+aPDDOVQElUz1Ehu788/s+UQy+Qx+ShI3oLDNVl8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW5WC5TR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707324465; x=1738860465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O8TFoIddkKyvAT0AdWOOk8Cu0gey2ydHbGJH/Xhc9Jg=;
  b=PW5WC5TRl0sbcfR3si3f/iBynZCRn4qyIr2g1aV6wfkI7aFmdf/mrdoT
   4CKJ8lG2+1GGBZN2b9Y2N68XkGr7sIemzW7CCFStQFqXG77qZ2N9WRypK
   V8PbQCk+no6xwhAVHaMQ8oFrz53GVAMVOYfOI1N/UtZquczXQEYjcLJDm
   MbUW6G5bSMZDuNOPxbRe5/84T+PW+FXIhODU5VIysIYvTLpNGloTAp2f2
   lu2TqA+v5wguUtbxaNZq3qVVf0z8c7aVcrl3VJUWals6hfvPMPd0+ldEw
   2BhtTanTrec+Iz0Qp1PnP2lN3T+OdqOYSqS4jRQ2xGooCoQKujshisf0m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1172947"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1172947"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="32457830"
Received: from ndarceda-mobl1.amr.corp.intel.com (HELO [10.212.81.33]) ([10.212.81.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:47:37 -0800
Message-ID: <b864e6d7-1e37-4901-b934-1e074d3c0b6c@linux.intel.com>
Date: Wed, 7 Feb 2024 10:45:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ASoc: tas2783: Add tas2783 codec driver
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 bard.liao@intel.com, mengdong.lin@intel.com,
 yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
 navada@ti.com, tiwai@suse.de, soyer@irl.hu
References: <20240207054743.1504-1-shenghao-ding@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240207054743.1504-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Much better than previous versions but still questions on pm_runtime and
a big undocumented part on the unique_id use. see comments below
-Pierre


> +config SND_SOC_TAS2783
> +	tristate "Texas Instruments TAS2783 speaker amplifier (sdw)"
> +	depends on SOUNDWIRE
> +	depends on EFI
> +	select REGMAP
> +	select REGMAP_SOUNDWIRE

nit-pick: should have 'select CRC32'...

> +	select CRC32_SARWATE

before selecting the CRC32 implementation. It's also not clear if this
is needed, the help says

 "Only choose this option if you know what you are doing."

> +static void tas2783_apply_calib(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	u8 *reg_start;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s, slaver doesn't exist.\n",

"peripheral does not exist"

> +			__func__);
> +		return;
> +	}
> +	if ((tas_dev->sdw_peripheral->id.unique_id < TAS2783_ID_MIN) ||
> +		(tas_dev->sdw_peripheral->id.unique_id > TAS2783_ID_MAX)) {

Where does this unique_id requirement come from?

I see this in the header files, and that means only half of the bits are
supported?

+/* Unique id start */
+#define TAS2783_ID_MIN			0x08
+/* Unique id end */
+#define TAS2783_ID_MAX			0x0f

the unique_id is only meant to allow identical devices to work
concurrently on the same link, specifically it enables the enumeration
of identical devices with the hardware arbitration. The device with the
highest unique_id is enumerated first in case of conflicts.

The unique_id is usually set at the board level. I don't know how the
codec driver can enforce a specific value.

This needs more explanations....

> +		dev_err(tas_dev->dev, "%s, error unique_id.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	reg_start = (u8 *)(cali_data + (tas_dev->sdw_peripheral->id.unique_id
> +		- TAS2783_ID_MIN) * sizeof(tas2783_cali_reg));
> +	for (int i = 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret = regmap_bulk_write(map, tas2783_cali_reg[i],
> +			&reg_start[4 * i], 4);
> +		if (ret) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +				tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}
> +}

> +static void tasdevice_rca_ready(const struct firmware *fmw,
> +	void *context)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) context;
> +	struct tas2783_firmware_node *p;
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char *buf = NULL;
> +	int offset = 0, img_sz;
> +	int ret, value_sdw;
> +
> +	if (!fmw || !fmw->data) {
> +		/* No firmware binary, devices will work in ROM mode. */
> +		dev_err(tas_dev->dev,
> +			"Failed to read %s, no side-effect on driver\n",
> +			tas_dev->rca_binaryname);
> +		ret = -EINVAL;

If this is not an error, it should be dev_info or dev_warn?

> +		goto out;
> +	}
> +	buf = (unsigned char *)fmw->data;
> +
> +	img_sz = le32_to_cpup((__le32 *)&buf[offset]);
> +	offset  += sizeof(img_sz);
> +	if (img_sz != fmw->size) {
> +		dev_err(tas_dev->dev, "Size not matching, %d %u",
> +			(int)fmw->size, img_sz);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	while (offset < img_sz) {
> +		p = (struct tas2783_firmware_node *)(buf + offset);
> +		if (p->length > 1) {
> +			ret = regmap_bulk_write(map, p->download_addr,
> +			buf + offset + sizeof(unsigned int)*5, p->length);
> +		} else
> +			ret = regmap_write(map, p->download_addr,
> +				*(buf + offset + sizeof(unsigned int) * 5));
> +
> +		if (ret != 0) {
> +			dev_dbg(tas_dev->dev, "Load FW fail: %d.\n", ret);
> +			goto out;
> +		}
> +		offset += sizeof(unsigned int)*5 + p->length;
> +	}
> +	/* Select left/right channel based on unique id. */
> +	value_sdw = 0x1a;
> +	value_sdw |= ((tas_dev->sdw_peripheral->dev_num & 1) << 4);

This is a very odd sequence, please add commments on what those bits
mean. It looks like this is confusing unique id and device number. Not
the same thing at all! The unique_id is set at the board level and used
during enumeration only, the dev_num is used as a logical value for
command/control. The dev_num is assigned in drivers/soundwire/bus.c and
depends on multiple things (order of attachment, allocation policy on
this host, etc). The codec driver cannot assume any specific value for
dev_num.

> +	dev_dbg(tas_dev->dev, "%s dev_num = %u", __func__,
> +		tas_dev->sdw_peripheral->dev_num);
> +	regmap_write(map, TAS2783_REG_TDM_RX_CFG, value_sdw);
> +
> +	tas2783_calibration(tas_dev);
> +
> +out:
> +	if (fmw)
> +		release_firmware(fmw);
> +}

> +static int tasdevice_init(struct tasdevice_priv *tas_dev)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(tas_dev->dev, tas_dev);
> +
> +	ret = devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
> +			__func__, ret);
> +		goto out;
> +	}
> +
> +	/* tas2783-link_id[0,1,...,N]-unique_id[8,9,...,f].bin stores the dsp
> +	 * firmware including speaker protection algorithm, audio acoustic
> +	 * algorithm, speaker characters and algorithm params, it must be
> +	 * copied into firmware folder. Each tas2783 has its own bin file.
> +	 */
> +	scnprintf(tas_dev->rca_binaryname, 64, "tas2783-%d-%x.bin",
> +		tas_dev->sdw_peripheral->bus->link_id,
> +		tas_dev->sdw_peripheral->id.unique_id);

Goodness, again this unique_id usage.

This is really problematic, how would this work for a Linux
distribution? Fetching the firmware ONLY on the basis of a unique_id
means possible collisions between platformA from OEM_X and platformB
from OEM_Y.

> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	if (ret) {
> +		dev_err(tas_dev->dev,
> +			"%s: request_firmware %x open status: %d.\n",
> +			__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
> +		goto out;
> +	}
> +
> +	/* set autosuspend parameters */
> +	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_dev->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(tas_dev->dev);
> +	pm_runtime_get_noresume(tas_dev->dev);

why are you increasing the refcount here? No other SoundWire codec
driver does this.

> +	pm_runtime_enable(tas_dev->dev);
> +
> +out:
> +	return ret;
> +}

> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev = dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev->first_hw_init)
> +		pm_runtime_disable(tas_dev->dev);
> +
> +	pm_runtime_put_noidle(tas_dev->dev);

that should be removed as well, this and the previous get_no_resume()
guarantee that pm_runtime suspend *NEVER* happens...

> +	return 0;
> +}

> +/* Unique id start */
> +#define TAS2783_ID_MIN			0x08
> +/* Unique id end */
> +#define TAS2783_ID_MAX			0x0f

this needs a lot more documentation, there's really nothing in the
SoundWire spec that allows for the unique_id to be restricted...

