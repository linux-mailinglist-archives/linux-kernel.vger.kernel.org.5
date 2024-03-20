Return-Path: <linux-kernel+bounces-109053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96A881400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854B81C22EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5EE4C631;
	Wed, 20 Mar 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOfPP05O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AE4C61C;
	Wed, 20 Mar 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946835; cv=none; b=ALs3QTeT5XPnHzGIkD7uduOKUj0EmickfAUVMqoPXPfOzQHSc9YEYaPR+uvIjxKDgl3eUXeNA6f8Vkfxz+SYEGaMdFNIjLI0WgF4v+SOCuPXfkaty8xisT2txorTVqw7qeiuOriyf1LKvPsEhF7dcRCODkK6Ln2n/BoyZ15yOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946835; c=relaxed/simple;
	bh=cybB2ILQSWkP+qDem/ecrGvZQ4vNRh+GU9RLJyFVt50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqFsOp/x2PqvNiaT1+0WDYy19tEAi57+vD/HDrGM8B47js8/HTx6xtdA9Mvm04Bj5WYr0NDX7EouBZ71ub1UMnQCvSlaJFAWwYBKXE+VsuiLIzwOEcsXaWLIx4488+m6W+1DcN8TM+6lmcHVHeBVFrGgfLUIQBjGItBAvNo+/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOfPP05O; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710946833; x=1742482833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cybB2ILQSWkP+qDem/ecrGvZQ4vNRh+GU9RLJyFVt50=;
  b=aOfPP05O/g9yQGDSmBm7Xp4nLeNKhGA0+lC6dSzVd9Fj6mnkhblkmCJg
   lg1Bvnu/O/a21z65OrmWrSDdefVOfDYoHQ6GRCX5vlNtRCCRTfKwcDtYy
   VzZ7aLbtov7RrM/Yu+U66S1ahT2kiL4ozGG4x8sYfYpr5dX7Gdy5P7kNC
   R8QFb28erZGgfFhrVHFWJWsQldxpGRWz5uAOAB4Tk1v/A8XZrFnK9BD6M
   mfMSlcF3ytgoufo9Psdn39i50aHUd0MGEmM8xLJKeFMQTm+tsz8wMIYez
   ZeQCu0tEv+7BXKP5uBXdOymMVjX/9JrlOrwcBPO8UgIqrKknZFEj5bZbj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16416020"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="16416020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14831504"
Received: from manikgoy-mobl1.amr.corp.intel.com (HELO [10.212.106.67]) ([10.212.106.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:00:26 -0700
Message-ID: <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
Date: Wed, 20 Mar 2024 10:00:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel
 I2S Controller
Content-Language: en-US
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240320090239.168743-3-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> diff --git a/sound/soc/cdns/Kconfig b/sound/soc/cdns/Kconfig
> new file mode 100644
> index 000000000000..61ef718ebfe7
> --- /dev/null
> +++ b/sound/soc/cdns/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SND_SOC_CADENCE_I2S_MC
> +        tristate "Cadence I2S Multi-Channel Controller Device Driver"
> +	depends on HAVE_CLK

indentation is off

> +        select SND_SOC_GENERIC_DMAENGINE_PCM
> +        help
> +         Say Y or M if you want to add support for I2S driver for the
> +         Cadence Multi-Channel I2S Controller device. The device supports
> +         up to a maximum of 8 channels each for play and record.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence Multi-Channel I2S controller PCM driver
> + *
> + * Copyright (c) 2022-2023 StarFive Technology Co., Ltd.

2024?

> + */
> +
> +#include <linux/io.h>
> +#include <linux/rcupdate.h>
> +#include <sound/pcm_params.h>
> +#include "cdns-i2s-mc.h"
> +
> +#define PERIOD_BYTES_MIN	4096
> +#define BUFFER_BYTES_MAX	(3 * 2 * 8 * PERIOD_BYTES_MIN)

what are those 3 and 2 and 8 factors? a comment or the use of macros
would help.

> +#define PERIODS_MIN		2
> +
> +static unsigned int cdns_i2s_pcm_tx(struct cdns_i2s_dev *dev,
> +				    struct snd_pcm_runtime *runtime,
> +				    unsigned int tx_ptr, bool *period_elapsed,
> +				    snd_pcm_format_t format)
> +{
> +	unsigned int period_pos = tx_ptr % runtime->period_size;

not following what the modulo is for, usually it's modulo the buffer size?

> +	const u16 (*p16)[2] = (void *)runtime->dma_area;
> +	const u32 (*p32)[2] = (void *)runtime->dma_area;
> +	u32 data[2];
> +	int i;
> +
> +	for (i = 0; i < CDNS_I2S_FIFO_DEPTH; i++) {
> +		if (format == SNDRV_PCM_FORMAT_S16_LE) {
> +			data[0] = p16[tx_ptr][0];
> +			data[1] = p16[tx_ptr][1];
> +		} else if (format == SNDRV_PCM_FORMAT_S32_LE) {
> +			data[0] = p32[tx_ptr][0];
> +			data[1] = p32[tx_ptr][1];
> +		}

what about other formats implied by the use of 'else if' ?
> +
> +		iowrite32(data[0], dev->base + CDNS_FIFO_MEM);
> +		iowrite32(data[1], dev->base + CDNS_FIFO_MEM);
> +		period_pos++;
> +		if (++tx_ptr >= runtime->buffer_size)
> +			tx_ptr = 0;
> +	}
> +
> +	*period_elapsed = period_pos >= runtime->period_size;
> +	return tx_ptr;
> +}

> +static void cdns_i2s_pcm_transfer(struct cdns_i2s_dev *dev, bool push)

'push' really means 'tx' so what not use a simpler naming?

> +{
> +	struct snd_pcm_substream *substream;
> +	bool active, period_elapsed;
> +
> +	rcu_read_lock();
> +	if (push)
> +		substream = rcu_dereference(dev->tx_substream);
> +	else
> +		substream = rcu_dereference(dev->rx_substream);
> +
> +	active = substream && snd_pcm_running(substream);
> +	if (active) {
> +		unsigned int ptr;
> +		unsigned int new_ptr;
> +
> +		if (push) {
> +			ptr = READ_ONCE(dev->tx_ptr);
> +			new_ptr = dev->tx_fn(dev, substream->runtime, ptr,
> +					     &period_elapsed, dev->format);
> +			cmpxchg(&dev->tx_ptr, ptr, new_ptr);
> +		} else {
> +			ptr = READ_ONCE(dev->rx_ptr);
> +			new_ptr = dev->rx_fn(dev, substream->runtime, ptr,
> +					     &period_elapsed, dev->format);
> +			cmpxchg(&dev->rx_ptr, ptr, new_ptr);
> +		}
> +
> +		if (period_elapsed)
> +			snd_pcm_period_elapsed(substream);
> +	}
> +	rcu_read_unlock();
> +}
> +
> +void cdns_i2s_pcm_push_tx(struct cdns_i2s_dev *dev)
> +{
> +	cdns_i2s_pcm_transfer(dev, true);
> +}
> +
> +void cdns_i2s_pcm_pop_rx(struct cdns_i2s_dev *dev)
> +{
> +	cdns_i2s_pcm_transfer(dev, false);
> +}
> +
> +static int cdns_i2s_pcm_open(struct snd_soc_component *component,
> +			     struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
> +	struct cdns_i2s_dev *dev = snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
> +
> +	snd_soc_set_runtime_hwparams(substream, &cdns_i2s_pcm_hardware);
> +	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> +	runtime->private_data = dev;
> +
> +	return 0;
> +}
> +
> +static int cdns_i2s_pcm_close(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream)
> +{
> +	synchronize_rcu();
> +	return 0;

runtime->private_data = NULL?

> +}
> +
> +static int cdns_i2s_pcm_hw_params(struct snd_soc_component *component,
> +				  struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *hw_params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct cdns_i2s_dev *dev = runtime->private_data;
> +
> +	dev->format = params_format(hw_params);

don't you need to test if the formats are supported?

> +	dev->tx_fn = cdns_i2s_pcm_tx;
> +	dev->rx_fn = cdns_i2s_pcm_rx;
> +
> +	return 0;
> +}

> +static int cdns_i2s_start(struct cdns_i2s_dev *i2s,
> +			  struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	unsigned char max_ch = i2s->max_channels;
> +	unsigned char i2s_ch;
> +	int i;
> +
> +	/* Each channel is stereo */
> +	i2s_ch = runtime->channels / 2;
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		if ((i2s_ch + i2s->tx_using_channels) > max_ch) {
> +			dev_err(i2s->dev,
> +				"Max %d channels: using %d for TX, do not support %d for RX\n",
> +				max_ch, i2s->tx_using_channels, i2s_ch);
> +			return -ENOMEM;

ENOMEM is for memory allocation, that looks more like EINVAL?

> +		}
> +
> +		i2s->rx_using_channels = i2s_ch;
> +		/* Enable channels from 0 to 'max_ch' as tx */
> +		for (i = 0; i < i2s_ch; i++)
> +			cdns_i2s_channel_start(i2s, CDNS_I2S_CM_0 << i,
> +					       CDNS_I2S_TC_RECEIVER);
> +
> +	} else {
> +		if ((i2s_ch + i2s->rx_using_channels) > max_ch) {
> +			dev_err(i2s->dev,
> +				"Max %d channels: using %d for RX, do not support %d for TX\n",
> +				max_ch, i2s->rx_using_channels, i2s_ch);
> +			return -ENOMEM;
> +		}
> +
> +		i2s->tx_using_channels = i2s_ch;
> +		/* Enable channels from 'max_ch' to 0 as rx */
> +		for (i = (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
> +			if (i < 0)
> +				return -EINVAL;

that is a test you can probably factor out of the loop before doing
anything that's inconsistent.

> +
> +			cdns_i2s_channel_start(i2s, CDNS_I2S_CM_0 << i,
> +					       CDNS_I2S_TC_TRANSMITTER);
> +		}
> +	}
> +	cdns_i2s_enable_clock(i2s, substream->stream);
> +
> +	if (i2s->irq >= 0)
> +		cdns_i2s_set_all_irq_mask(i2s, false);
> +
> +	cdns_i2s_clear_int(i2s);
> +
> +	return 0;
> +}
> +
> +static int cdns_i2s_stop(struct cdns_i2s_dev *i2s,
> +			 struct snd_pcm_substream *substream)
> +{
> +	unsigned char i2s_ch;
> +	int i;
> +
> +	cdns_i2s_clear_int(i2s);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		i2s_ch = i2s->rx_using_channels;
> +		for (i = 0; i < i2s_ch; i++)
> +			cdns_i2s_channel_stop(i2s, (CDNS_I2S_CM_0 << i));
> +
> +		i2s->rx_using_channels = 0;
> +	} else {
> +		unsigned char max_ch = i2s->max_channels;
> +
> +		i2s_ch = i2s->tx_using_channels;
> +		for (i = (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
> +			if (i < 0)
> +				return -EINVAL;

same here, first test if the channel maps are valid, then do the loop?

> +
> +			cdns_i2s_channel_stop(i2s, (CDNS_I2S_CM_0 << i));
> +		}
> +
> +		i2s->tx_using_channels = 0;
> +	}
> +
> +	if (i2s->irq >= 0 && !i2s->tx_using_channels && !i2s->rx_using_channels)
> +		cdns_i2s_set_all_irq_mask(i2s, true);
> +
> +	return 0;
> +}

> +static int cdns_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
> +			    unsigned int fmt)
> +{
> +	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(cpu_dai);
> +	int ret = 0;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		i2s->tx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
> +		i2s->rx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
> +		cdns_i2s_set_ms_mode(i2s);
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		i2s->tx_sync_ms_mode = CDNS_I2S_SLAVE_MODE;
> +		i2s->rx_sync_ms_mode = CDNS_I2S_SLAVE_MODE;
> +		cdns_i2s_set_ms_mode(i2s);
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFM:

that's the old stuff, use CBP/CBC macros please.

> +		ret = -EINVAL;
> +		break;
> +	default:
> +		dev_dbg(i2s->dev, "Invalid master/slave format\n");
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}

> +#ifdef CONFIG_PM

Do we need this or just rely on __unused?

> +static int cdns_i2s_runtime_suspend(struct device *dev)
> +{
> +	struct cdns_i2s_dev *i2s = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(i2s->clks[1].clk); /* ICG clock */
> +	return 0;
> +}
> +
> +static int cdns_i2s_runtime_resume(struct device *dev)
> +{
> +	struct cdns_i2s_dev *i2s = dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
> +}
> +#endif

> +static int cdns_i2s_probe(struct platform_device *pdev)
> +{
> +	struct cdns_i2s_dev *i2s;
> +	struct resource *res;
> +	int ret;
> +
> +	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> +	if (!i2s) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	platform_set_drvdata(pdev, i2s);
> +
> +	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(i2s->base)) {
> +		ret = PTR_ERR(i2s->base);
> +		goto err;
> +	}
> +
> +	i2s->dev = &pdev->dev;
> +	i2s->phybase = res->start;
> +
> +	ret = cdns_i2s_init(i2s);
> +	if (ret)
> +		goto err;
> +
> +	i2s->irq = platform_get_irq(pdev, 0);
> +	if (i2s->irq >= 0) {
> +		ret = devm_request_irq(&pdev->dev, i2s->irq, cdns_i2s_irq_handler,
> +				       0, pdev->name, i2s);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "request_irq failed\n");
> +			goto err;
> +		}
> +	}
> +
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      &cdns_i2s_component,
> +					      &cdns_i2s_dai, 1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "couldn't register component\n");
> +		goto err;
> +	}
> +
> +	if (i2s->irq >= 0)
> +		ret = cdns_i2s_pcm_register(pdev);
> +	else
> +		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
> +		goto err;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	if (pm_runtime_enabled(&pdev->dev))
> +		cdns_i2s_runtime_suspend(&pdev->dev);

that sequence looks suspicious.... Why would you suspend immediately
during the probe? You're probably missing all the autosuspend stuff?

> +
> +	dev_dbg(&pdev->dev, "I2S supports %d stereo channels with %s.\n",
> +		i2s->max_channels, ((i2s->irq < 0) ? "dma" : "interrupt"));
> +
> +	return 0;
> +
> +err:
> +	return ret;
> +}
> +
> +static int cdns_i2s_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		cdns_i2s_runtime_suspend(&pdev->dev);

.. and this one too. Once you've disabled pm_runtime, checking the
status is irrelevant...

> +
> +	return 0;
> +}
> +

