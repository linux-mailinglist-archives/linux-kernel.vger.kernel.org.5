Return-Path: <linux-kernel+bounces-126692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B78893B98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40341F220DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDB3FBAA;
	Mon,  1 Apr 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSLL/3yv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA403F8F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979429; cv=none; b=rRHc1TSYOBojT3YBFqWMEDO0wyIWY99h0enPAJ1onh5mRTWEYqD3JBZycGQgCK+6RFsnMwtWlTNmIK8LI+32NUon2txmjNPLuaN2uWN9DpzBnaesu/wP+0yDmqR6wy+hYtz1XzvVlcjMj04phGrkzkUJvNhKGp8DCaJhl31u4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979429; c=relaxed/simple;
	bh=24GpNitRdLxcpU9jAh6COt2T6RMVSkeQ4bQuoCoY/hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKFuK0pnFPun9tZ5GH40hvc2YLzMGEuyMdWDrbRKm5Bq3nD+uJCtf/3I/IkE6YJThd2arMqJBxGfGw0/0CwdGJLm2fYJLNuuZQzP5KAudPWftz9Wc1s4unceYe+RPW2jaebDVxfLbdFFr1CWyBbOUzhkBuz6jVFdvbQWt8mmvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSLL/3yv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711979428; x=1743515428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=24GpNitRdLxcpU9jAh6COt2T6RMVSkeQ4bQuoCoY/hA=;
  b=eSLL/3yveK6DQ9oOvPkRvywIShc6pPkpn7N1vMa6oAr3LT4+8JHw2Jdy
   UQ4YMUPrMauegQT506/Ypq4xFvXvhEhpSztsM+qa7sdD8Fhd87obb9WnN
   KfkNm8f8X1GxP8cdG20qbKkbSwuggNX/XPSsBMaMIjHztO/K2P63lslOp
   HvWD4FjxSuhsyuzH/TUdw144aIYuP5nMm0jxgJT2uFiRp06r24+NpKRiN
   7nC0F4a7MSh4DmtXOpMPm6WY0/+k6rAxZeRysA6Fpp7ACnuS0OEEQu0j4
   Bq1qO7FcfrKQvkTE6x1MRg65t1T/NvS+/SfSqPiaCCFHt2eIfiqnbQdDD
   A==;
X-CSE-ConnectionGUID: cHet1/6QReOsDI+b1zdakw==
X-CSE-MsgGUID: CJzfNgNmRVWJrs/ONNexMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="6961910"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="6961910"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 06:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55191337"
Received: from anahar-mobl.amr.corp.intel.com (HELO [10.212.2.239]) ([10.212.2.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 06:50:26 -0700
Message-ID: <df80758b-f3d6-4456-8600-1a19fab75407@linux.intel.com>
Date: Mon, 1 Apr 2024 08:50:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] ASoc: tas2783: Add tas2783 codec driver
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 bard.liao@intel.com, yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
 tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com,
 navada@ti.com, v-po@ti.com
References: <20240331021458.1418-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240331021458.1418-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for the update, I only have a couple of nit-picks and a set of
questions on when firmware is supposed to be downloaded. See below.
Regards,
-Pierre

> +static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tasdevice_priv *tas_priv =
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_config stream_config = {0};
> +	struct sdw_port_config port_config = {0};
> +	struct sdw_stream_runtime *sdw_stream;
> +	int ret;
> +
> +	dev_dbg(dai->dev, "%s: dai_name %s", __func__, dai->name);

nit-pick: do you really need this sort of logs?

> +	sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!sdw_stream)
> +		return -EINVAL;
> +
> +	if (!tas_priv->sdw_peripheral)
> +		return -EINVAL;
> +
> +	/* SoundWire specific configuration */
> +	snd_sdw_params_to_config(substream, params,
> +		&stream_config, &port_config);
> +
> +	/* port 1 for playback */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		port_config.num = 1;
> +	else
> +		port_config.num = 2;
> +
> +	ret = sdw_stream_add_slave(tas_priv->sdw_peripheral,
> +		&stream_config, &port_config, 1, sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: Unable to configure port\n", __func__);
> +		return ret;
> +	}
> +
> +	dev_dbg(dai->dev, "%s: format: %i rate: %i\n", __func__,
> +		params_format(params), params_rate(params));
> +
> +	return 0;
> +}

> +static int tasdevice_playback(struct tasdevice_priv *tas_dev, int mute)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	int ret;
> +
> +	if (mute) {
> +		/* FU23 mute (0x40400108) */
> +		ret = regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23,
> +			TAS2783_SDCA_CTL_FU_MUTE, 0), 1);
> +		if (ret) {
> +			dev_err(tas_dev->dev, "%s: FU23 mute failed.\n",
> +				__func__);
> +			goto out;
> +		}
> +
> +		ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +			TAS2783_REG_PWR_MODE_MASK |
> +			TAS2783_REG_AEF_MASK,
> +			TAS2783_REG_PWR_MODE_ACTIVE |
> +			TAS2783_REG_PWR_MODE_SW_PWD);
> +		if (ret) {
> +			dev_err(tas_dev->dev, "%s: shutdown failed.\n",

nit-pick: is this really a shutdown or a "PWR Mute" for symmetry with...

> +				__func__);
> +		}
> +	} else {
> +		/* FU23 Unmute, 0x40400108. */
> +		ret = regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23,
> +			TAS2783_SDCA_CTL_FU_MUTE, 0), 0);
> +		if (ret) {
> +			dev_err(tas_dev->dev,
> +				"%s: FU23 Unmute failed.\n", __func__);
> +			goto out;
> +		}
> +		ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +			TAS2783_REG_PWR_MODE_MASK,
> +			TAS2783_REG_PWR_MODE_ACTIVE);
> +		if (ret) {
> +			dev_err(tas_dev->dev,
> +				"%s: PWR Unmute failed.\n", __func__);

.. this log?

> +		}
> +	}
> +out:
> +	return ret;
> +}

> +static int tasdevice_comp_probe(struct snd_soc_component *comp)
> +{
> +	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(comp);
> +	unsigned char dspfw_binaryname[TAS2783_DSPFW_FILENAME_LEN];
> +	acpi_handle handle = ACPI_HANDLE(tas_dev->dev);
> +	const struct firmware *fw_entry = NULL;
> +	const char *sub = NULL;
> +	int ret;
> +
> +	if (handle) {
> +		sub = acpi_get_subsystem_id(handle);
> +		if (IS_ERR(sub))
> +			sub = NULL;
> +	}
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
> +		scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
> +			"%s-tas2783.bin", comp->name_prefix);
> +	} else {
> +		/* Compatible with the previous naming rule */
> +		if (sub) {
> +			/*
> +			 * subsys_id-link_id[0,1,...,N]-unique_id
> +			 * [0x8,...,0xf].bin stores the dsp firmware including
> +			 * speaker protection algorithm, audio acoustic
> +			 * algorithm, speaker characters and algorithm params,
> +			 * it must be copied into firmware folder.
> +			 */
> +			scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
> +				"%s-%d-0x%x.bin", sub,
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->id.unique_id);
> +		} else {
> +			/*
> +			 * tas2783-link_id[0,1,...,N]-unique_id
> +			 * [0x8,...,0xf].bin stores the dsp firmware including
> +			 * speaker protection algorithm, audio acoustic
> +			 * algorithm, speaker characters and algorithm params,
> +			 * it must be copied into firmware folder.
> +			 */
> +			scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
> +				"tas2783-%d-0x%x.bin",
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->id.unique_id);
> +		}
> +	}
> +
> +	ret = request_firmware(&fw_entry, dspfw_binaryname, tas_dev->dev);
> +	if (ret) {
> +		dev_err(tas_dev->dev,
> +			"%s: request_firmware %x open status: %d.\n", __func__,
> +			tas_dev->sdw_peripheral->id.unique_id, ret);
> +		goto out;
> +	}
> +
> +	tasdevice_dspfw_ready(fw_entry, tas_dev);

Question: is there a specific reason why all this functionality needs to
be done in a component probe instead of when the device reports as ATTACHED?

Since you have an interaction with userspace for the firmware, and
firmware download takes time, you would want to do this as early as
possible.

Usually the component probe is part of the card creation, so you could
add card-related or control related things. Downloading firmware does
not strike me as a card-related activity?

Another question is whether the firmware needs to be downloaded again
during system/pm_runtime resume? That may depend on how power is managed
at the hardware level, but in theory an SDCA device should report to the
host whether the firmware is still valid or needs to be downloaded.


> +
> +out:
> +	if (fw_entry)
> +		release_firmware(fw_entry);
> +	return 0;
> +}

