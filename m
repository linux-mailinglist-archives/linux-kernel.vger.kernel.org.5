Return-Path: <linux-kernel+bounces-27059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBB82E9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04A8284114
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B111118A;
	Tue, 16 Jan 2024 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umg9vc2p"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943B11181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705389339; x=1736925339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=677zo72GhiNfg33o/lJ5avDqp4IGWnVQ/Y+4/rVlINI=;
  b=Umg9vc2pey7xEuWsXjQBpjkhxXYdvIvHEyBi7zGcUfX5l5H0qS3huBqZ
   k1S+NovuB8ywVvvAtt/z+a3l6K/TnqvubYWMm6PN7d/aDW5AKHI5EviKa
   uqy3xCh44EtRDLgPTqE60Urs678KsNDMTZ6GSAlJ5yy5ELrhNNB05iu3D
   EQGqrtPCqou3OeAwyBYgyyHSCugoBoqGHVh3NLd/O/NunMei8OKEUJU4U
   JwcZMl7d8Z7emTk1bWK16PvqY7lM4CDdD0CTB+NYYZeh6vOmvU2t8a92k
   S+rvhQXjBgq4KdULkfhF4Y7z65//5faEvRNMr1nS4zTm/ECvgT5g09G9M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="390228393"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="390228393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="927356257"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="927356257"
Received: from igranath-mobl.ger.corp.intel.com (HELO [10.249.38.184]) ([10.249.38.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:15:34 -0800
Message-ID: <5b3d2dcc-1300-49cf-8946-28ad0394cb51@linux.intel.com>
Date: Mon, 15 Jan 2024 10:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoc: tas2783: Add tas2783 codec driver
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 mengdong.lin@intel.com, yung-chuan.liao@linux.intel.com, baojun.xu@ti.com,
 kevin-lu@ti.com, peeyush@ti.com, navada@ti.com, tiwai@suse.de
References: <20240113114944.1043-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240113114944.1043-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This version is much better than previous ones, but can be improved
further, specifically on the identification of firmware based on the
unique_id and pm_runtime. See additional nit-picks and suggestions below.


> ---
> Change in v5:
>  - simplify tasdevice_set_sdw_stream
>  - fixed some Linux coding style
>  - fixed the spelling mistakes
>  - Select left/right channel based on unique id
>  - a longer description has been added
>  - remove unused crc8 in KCONFIG

Don't you need a 'select CRC32' though? ...

Maybe it's already set by other Kconfigs.


> +/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
> + * Calibrate data is done by manufacturer in the factory. These data are used
> + * by Algo for calucating the speaker temperature, speaker membrance excursion
> + * and f0 in real time during playback.
> + * In case of no or valid calibrated data, dsp will still works with default
> + * calibrated data inside algo.

suggested edits:

Load the calibration data, including speaker impedance, f0, etc.
Calibration is done by the manufacturer in the factory. The calibration
data are used by the algorithm  for calculating the speaker temperature,
speaker membrance excursion and f0 in real time during playback.
The DSP will work with default data values if calibrated data are
missing or are invalid.


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
> +	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
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
> +		dev_err(dai->dev, "Unable to configure port\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(dai->dev, "%s fomrat: %i rate: %i\n", __func__,

typo: format

> +		params_format(params), params_rate(params));
> +
> +	return 0;
> +}
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
> +	dev_dbg(tas_dev->dev, "Mute or unmute %d.\n", mute);
> +
> +	if (mute) {
> +		/* Echo channel can't be shutdown while tas2783 must keep
> +		 * working state while playback is on.

Consider rewording that comment, two 'while' in the same sentence make
it hard to parse.

> +		 */
> +		if (direction == SNDRV_PCM_STREAM_CAPTURE
> +			&& tas_dev->pstream == true)
> +			return 0;
> +		/* FU23 mute (0x40400108) */
> +		ret = regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23, TAS2783_SDCA_CTL_FU_MUTE, 0),
> +			1);
> +		ret |= regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x1a);

ORin error codecs is not quite right

> +		tas_dev->pstream = false;
> +	} else {
> +		/* FU23 Unmute, 0x40400108. */
> +		ret = regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23, TAS2783_SDCA_CTL_FU_MUTE, 0),
> +			0);
> +		ret |= regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x0);
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			tas_dev->pstream = true;
> +	}
> +
> +	if (ret)
> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
> +			mute, ret);
> +
> +	return ret;
> +}
> +

> +static int tasdevice_init(struct tasdevice_priv *tas_dev)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(tas_dev->dev, tas_dev);
> +
> +	mutex_init(&tas_dev->codec_lock);
> +	ret = devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
> +			__func__, ret);
> +	}
> +
> +	tas2783_reset(tas_dev);
> +	/* tas2783-8[9,...,f].bin was copied into /lib/firmware/ */

You need to add a comment to explain what those files contain, it's not
clear at all if they are just 'firmware' or if they contain tables.

> +	scnprintf(tas_dev->rca_binaryname, 64, "tas2783-%01x.bin",
> +		tas_dev->sdw_peripheral->id.unique_id);

And more specifically the use of the unique_id is problematic since it's
only relevant in the context of one link. If you have two amps on
separate links, the unique_id is irrelevant.

> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	if (ret) {
> +		dev_dbg(tas_dev->dev,
> +		"%s: request_firmware %x open status: %d.\n",
> +		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
> +	}
> +
> +	/* set autosuspend parameters */
> +	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_dev->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(tas_dev->dev);
> +
> +	pm_runtime_enable(tas_dev->dev);

You are handling pm_runtime here...

> +
> +	dev_dbg(tas_dev->dev, "%s was called for TAS2783.\n",  __func__);
> +
> +	return ret;
> +}
> +
> +static int tasdevice_read_prop(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop = &slave->prop;
> +	int nval;
> +	int i, j;
> +	u32 bit;
> +	unsigned long addr;
> +	struct sdw_dpn_prop *dpn;
> +
> +	prop->scp_int1_mask =
> +		SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
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
> +static int tasdevice_io_init(struct device *dev, struct sdw_slave *slave)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +
> +	if (tas_priv->hw_init)
> +		return 0;
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_only(tas_priv->regmap, false);
> +		regcache_cache_bypass(tas_priv->regmap, true);
> +	} else {
> +		/*
> +		 * PM runtime is only enabled when a Slave reports as Attached
> +		 */
> +
> +		/* set autosuspend parameters */
> +		pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
> +		pm_runtime_use_autosuspend(&slave->dev);
> +
> +		/* update count of parent 'active' children */
> +		pm_runtime_set_active(&slave->dev);
> +
> +		/* make sure the device does not suspend immediately */
> +		pm_runtime_mark_last_busy(&slave->dev);
> +
> +		pm_runtime_enable(&slave->dev);

.. and here.

This isn't quite right, you should only use set_active() here and move
all other parts in the probe.

> +	}
> +
> +	pm_runtime_get_noresume(&slave->dev);
> +
> +	/* sw reset */
> +	regmap_write(tas_priv->regmap, 0x8001, 0x01);
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, false);
> +		regcache_mark_dirty(tas_priv->regmap);
> +	} else
> +		tas_priv->first_hw_init = true;
> +	/* Mark Slave initialization complete */
> +	tas_priv->hw_init = true;

if you do a get_noresume() you've got to do a put_noidle() here for
symmetry.

> +
> +	return 0;
> +}
> +

