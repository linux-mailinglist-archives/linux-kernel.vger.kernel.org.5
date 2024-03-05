Return-Path: <linux-kernel+bounces-92655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0598723B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E3F1F24991
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852612BEA3;
	Tue,  5 Mar 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZcORD3o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64002126F22
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654843; cv=none; b=pIeZhxPD6I/HM1Cl41V+kfBiCy5Azgw0TtxdJlMpPaEM0onlNKinj/L84OXzymoCfo7KNxtsDmToB0emF2AujPsUqVEorStW18Yw4sJkGDeKRk4vv0GX9K0mugrTJhZ6eZYqyzNuZM8jkqEICqrwKiCc2KmE+Ii22qFilQupA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654843; c=relaxed/simple;
	bh=yVAMvk1AjN2Q8IOg8WhIMYAju/KTCFz1RxW4IWB0f7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1wq4T2eQOZF27w5zXnZlevk8xKapYVbydApU92M7f/V65aXjl8kbHqCB/T0UV/bshPlAM5sm47vTgihETdGy8rjIiuTmJX3TPw7Vg62aMh+rFmNLJV1HFL6f1bfwnqLTvGzEQVRD5+O4celD8B/GiBy/H4YmBdpnNApThgZhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZcORD3o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709654842; x=1741190842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yVAMvk1AjN2Q8IOg8WhIMYAju/KTCFz1RxW4IWB0f7Y=;
  b=EZcORD3oh8fNvMDTYLmlF0uzbJ3nSyLAF1FGqgDc0G2OgP0pc6wAEsie
   nAct+6joqvuBNptC05w+knG9h/Npi+S7le5z67tRHR9G8UPjqGdUpne16
   Mny5Yb0NfrlfK6z7SwFNbf3NFQYy55na2WF8nvnghC60PEvB8Zzl2uONc
   ChuqiUPw8hP0j92Ac0QKmk4cMG6njHVNJ2oVguKoghuW0H/ba+xmG8DSx
   wbncKFWxfboYfJUmdGw4DGgzjubfZ/0KzqPAEApFaSJhlPC09fL6zkrIU
   wszpIQWVJTfINsHDDZX5rR7v6ok0eYugU2Muwok2SjZCJHCbFukGzNR+8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4384289"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4384289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="32599823"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:05:00 -0800
Message-ID: <2efb5250-25f3-465e-81fc-cb885027b481@linux.intel.com>
Date: Tue, 5 Mar 2024 17:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec driver
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, bard.liao@intel.com, mengdong.lin@intel.com,
 yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, tiwai@suse.de,
 soyer@irl.hu, Baojun.Xu@fpt.com, navada@ti.com
References: <20240305132646.638-1-shenghao-ding@ti.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240305132646.638-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2024 2:26 PM, Shenghao Ding wrote:
> The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
> interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces designed
> for portable applications. An on-chip DSP supports Texas Instruments
> SmartAmp speaker protection algorithm. The integrated speaker voltage and
> current sense provides for real-time monitoring of loudspeakers.
> 
> The ASoC component provides the majority of the functionality of the
> device, all the audio functions.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---

..

> +
> +static void tas2783_apply_calibv2(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	const unsigned int arr_size = ARRAY_SIZE(tas2783_cali_reg);
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned int dev_sum = cali_data[1], i, j, k;
> +	u8 *cali_start;
> +	u16 dev_info;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	dev_info = tas_dev->sdw_peripheral->bus->link_id |
> +		tas_dev->sdw_peripheral->id.unique_id << 16;
> +
> +	/*
> +	 * The area saving tas2783 calibrated data is specified by its
> +	 * unique_id offset. cali_start is the first address of current
> +	 * tas2783's calibrated data.
> +	 */
> +	cali_start = (u8 *)&cali_data[3];
> +	for (i = 0; i < dev_sum; i++) {
> +		k = i * (arr_size + 1) + 3;
> +		if (dev_info != cali_data[k]) {
> +			for (j = 0; j < arr_size; j++) {
> +				k = 4 * (k + 1 + j);
> +				ret = regmap_bulk_write(map,
> +					tas2783_cali_reg[j],
> +					&cali_start[k], 4);
> +				if (ret) {
> +					dev_err(tas_dev->dev,
> +						"Cali failed %x:%d\n",
> +						tas2783_cali_reg[j], ret);
> +					break;
> +				}
> +			}
> +			break;
> +		}
> +	}

This seems a bit hard to read, any chance to do some reordering to make 
it more readable?

> +}
> +

..

> +
> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
> +	int direction)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct regmap *map = tas_dev->regmap;
> +	int ret;
> +
> +	dev_dbg(tas_dev->dev, "%s: %d.\n", __func__, mute);
> +
> +	if (mute) {
> +		if (direction == SNDRV_PCM_STREAM_CAPTURE) {
> +			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_AEF_MASK,
> +				TAS2783_REG_AEF_INACTIVE);
> +			if (ret)
> +				dev_err(tas_dev->dev,
> +					"%s: Disable AEF failed.\n", __func__);
> +		} else {
> +			/* FU23 mute (0x40400108) */
> +			ret = regmap_write(map,
> +				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +				TAS2783_SDCA_ENT_FU23,
> +				TAS2783_SDCA_CTL_FU_MUTE, 0), 1);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: FU23 mute failed.\n", __func__);
> +				goto out;
> +			}
> +			/*
> +			 * Both playback and echo data will be shutdown in
> +			 * playback stream.
> +			 */
> +			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_PWR_MODE_MASK |
> +				TAS2783_REG_AEF_MASK,
> +				TAS2783_REG_PWR_MODE_ACTIVE |
> +				TAS2783_REG_PWR_MODE_SW_PWD);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: PWR&AEF shutdown failed.\n",
> +					__func__);
> +				goto out;
> +			}
> +			tas_dev->pstream = false;
> +		}
> +	} else {
> +		/* FU23 Unmute, 0x40400108. */
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +			ret = regmap_write(map,
> +				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +				TAS2783_SDCA_ENT_FU23,
> +				TAS2783_SDCA_CTL_FU_MUTE, 0), 0);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: FU23 Unmute failed.\n", __func__);
> +				goto out;
> +			}
> +			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_PWR_MODE_MASK,
> +				TAS2783_REG_PWR_MODE_ACTIVE);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: PWR Unmute failed.\n", __func__);
> +				goto out;
> +			}
> +			tas_dev->pstream = true;
> +		} else {
> +			/* Capture stream is the echo ref data for voice.
> +			 * Without playback, it can't be active.
> +			 */
> +			if (tas_dev->pstream == true) {
> +				ret = regmap_update_bits(map,
> +					TAS2873_REG_PWR_CTRL,
> +					TAS2783_REG_AEF_MASK,
> +					TAS2783_REG_AEF_ACTIVE);
> +				if (ret) {
> +					dev_err(tas_dev->dev,
> +						"%s: AEF enable failed.\n",
> +						__func__);
> +					goto out;
> +				}
> +			} else {
> +				dev_err(tas_dev->dev,
> +					"%s: No playback, no AEF!", __func__);
> +				ret = -EINVAL;
> +			}
> +		}
> +	}
> +out:
> +	if (ret)
> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
> +			mute, ret);
> +
> +	return ret;
> +}

Above function seem to be bit long, which also causes a lot of 
indentation, perhaps split it into mute and unmute helpers?

..

> +
> +static int tasdevice_read_prop(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop = &slave->prop;
> +	struct sdw_dpn_prop *dpn;
> +	unsigned long addr;
> +	int nval, i, j;
> +	u32 bit;
> +
> +	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> +
> +	prop->paging_support = true;
> +
> +	/* first we need to allocate memory for set bits in port lists */
> +	prop->source_ports = BIT(2); /* BITMAP: 00000100 */
> +	prop->sink_ports = BIT(1); /* BITMAP:  00000010 */
> +
> +	nval = hweight32(prop->source_ports);
> +	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
> +	if (!prop->src_dpn_prop)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	dpn = prop->src_dpn_prop;
> +	addr = prop->source_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[i].num = bit;
> +		dpn[i].type = SDW_DPN_FULL;
> +		dpn[i].simple_ch_prep_sm = true;
> +		dpn[i].ch_prep_timeout = 10;
> +		i++;
> +	}
> +
> +	/* do this again for sink now */
> +	nval = hweight32(prop->sink_ports);
> +	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
> +	if (!prop->sink_dpn_prop)
> +		return -ENOMEM;
> +
> +	j = 0;

No need for separate j variable, you can reuse i here.

> +	dpn = prop->sink_dpn_prop;
> +	addr = prop->sink_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[j].num = bit;
> +		dpn[j].type = SDW_DPN_FULL;
> +		dpn[j].simple_ch_prep_sm = true;
> +		dpn[j].ch_prep_timeout = 10;
> +		j++;
> +	}
> +
> +	/* set the timeout values */
> +	prop->clk_stop_timeout = 20;
> +
> +	return 0;
> +}
> +

..

> +
> +struct tasdevice_priv {
> +	struct snd_soc_component *component;

Apart from being assigned this field seems to be unused.

> +	struct sdw_slave *sdw_peripheral;
> +	enum sdw_slave_status status;

This one seems to be only used in tasdevice_update_status()? Does it 
really need to be kept in struct?

> +	struct sdw_bus_params params;

Unused?

> +	struct regmap *regmap;
> +	struct device *dev;
> +	unsigned char dspfw_binaryname[TAS2783_DSPFW_FILENAME_LEN];

This one also seems weird, it is mainly needed when loading FW and could 
be local to tasdevice_comp_probe(), although there is one dev_warn which 
uses it outside of it, but pretty sure it could be dropped.

> +	unsigned char dev_name[32];

Another unused field.

> +	unsigned int chip_id;

Another one that only seems to be assigned.

> +	bool pstream;
> +	bool hw_init;
> +	bool first_hw_init;
> +};
> +
> +#endif /*__TAS2783_H__ */


