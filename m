Return-Path: <linux-kernel+bounces-41667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE083F61D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B646283DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C525776;
	Sun, 28 Jan 2024 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUvs9tGT"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28022D61B;
	Sun, 28 Jan 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455671; cv=none; b=uKnWrGCdEvKn9rCay7Todwku01YSw88M8PVuGFhrBPAWv7jCd3ZWeTulYqKtTZjbB+mQz08LwtO67MUj+3ArcuSSlkgMBI0957oGu8Zy9A1t5SaTXEYW9hw8xh7ta630u0+gVZrEhWVsVfH9gdbcNohOGVyaBwroRCftbYnH2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455671; c=relaxed/simple;
	bh=JAN47VwN1SePpdyAoHFsl6vnWsIXfB8fiYqRy73CAS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmeodD34v2HTzHUNexPSSb+jWAW2ukIvGugn1iN4u9fJksQJbg4RX8WVsFBYdklQ2gB+yDTJMZ8l68RrhS/PULqtWLyGZNgZNpmEJ/W/IcLngDb1cbTi2o77tTyxR33ZhWWVNAWkHZUTU3ftPR13453AH5iCqw6TvQlzQdI2JsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUvs9tGT; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706455670; x=1737991670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JAN47VwN1SePpdyAoHFsl6vnWsIXfB8fiYqRy73CAS4=;
  b=OUvs9tGT6sWcQSw7gk+ikGV67PwTrkMNmKoAv8hmI9ZoC8ahZnKtsda+
   x57/qcVKdReX7BoAqEqnuQ0Laxvk5ne5nRVcrQoDjzr1DIY/XZo2hpsIK
   9kehEREWI/3tx+cHiYApwunfdQiNOLIVtCms1CcbVpSbVD72HEtDM7700
   BZllTGB5ljMliA/8d3P3VU52kBojnZq/PHtm2m8VcX2PFlAoTsYYc0G0d
   GiyVekNgA84W3zadooKNsZjfPuYbSdkWglhb/W+zuF9FwZjtIAgdfNTS4
   IiAbwuhMZV9pLNlHctASbHlwySvlV5SYnv+awIqBh+IoJpiNHO/v/k8uJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="433945030"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433945030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737145749"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="737145749"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6oc-0000000HUFn-3Zl7;
	Sun, 28 Jan 2024 17:11:22 +0200
Date: Sun, 28 Jan 2024 17:11:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, jkhuang3@ti.com,
	tiwai@suse.de, pdjuandi@ti.com, j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v1 1/4] ASoc: pcm6240: Create pcm6240 codec driver code
Message-ID: <ZbZumnfISSojuA80@smile.fi.intel.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123111411.850-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 23, 2024 at 07:14:07PM +0800, Shenghao Ding wrote:
> PCM6240 driver implements a flexible and configurable setting for register
> and filter coefficients, to one, two or even multiple PCM6240 Family Audio
> chips.

..

> +#include <linux/of_gpio.h>


No new code is supposed to use this header.
Also the header inclusion here is a mess, please use IWYU principle
(Include What You Use).

..

> +static struct pcmdevice_mixer_control adc5120_analog_gain_ctl[] = {
> +	{
> +		.shift = 1,
> +		.reg = ADC5120_REG_CH1_ANALOG_GAIN,
> +		.max = 0x54,
> +		.invert = 0,

Strictly speaking assignments to 0, false, NULL are unnecessary for static
variables, but I'm not against this as it might make cleaner to see what's
going on here. Btw, shouldn't these global variables be const?

> +	},
> +	{
> +		.shift = 1,
> +		.reg = ADC5120_REG_CH2_ANALOG_GAIN,
> +		.max = 0x54,
> +		.invert = 0,
> +	}
> +};

..

> +static int pcmdev_change_dev(struct pcmdevice_priv *pcm_priv,
> +	unsigned short dev_no)
> +{
> +	struct i2c_client *client = (struct i2c_client *)pcm_priv->client;

Why do you need casting? Is that variable is not void *?

> +	struct regmap *map = pcm_priv->regmap;

> +	int ret = 0;

Unneeded assignment, just return 0 directly.

> +
> +	if (client->addr != pcm_priv->addr[dev_no]) {
> +		client->addr = pcm_priv->addr[dev_no];
> +		/* All pcmdevices share the same regmap, clear the page
> +		 * inside regmap once switching to another pcmdevice.
> +		 * Register 0 at any pages inside pcmdevice is the same
> +		 * one for page-switching.
> +		 */
> +		ret = regmap_write(map, PCMDEVICE_PAGE_SELECT, 0);
> +		if (ret < 0)
> +			dev_err(pcm_priv->dev, "%s, E=%d\n", __func__, ret);
> +	}
> +
> +	return ret;
> +}

..

> +static int pcmdev_dev_read(struct pcmdevice_priv *pcm_dev,
> +	unsigned int dev_no, unsigned int reg, unsigned int *val)
> +{

> +	int ret = -EINVAL;

Unneeded assignment, use this value directly.

> +	if (dev_no < pcm_dev->ndev) {
> +		struct regmap *map = pcm_dev->regmap;
> +
> +		ret = pcmdev_change_dev(pcm_dev, dev_no);
> +		if (ret < 0) {
> +			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
> +			goto out;
> +		}
> +
> +		ret = regmap_read(map, reg, val);
> +		if (ret < 0)
> +			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
> +	} else

Besides broken style, this 'else' becomes redundant after proposed changes.

> +		dev_err(pcm_dev->dev, "%s, no such channel(%d)\n", __func__,
> +			dev_no);
> +
> +
> +out:

Useless label.

> +	return ret;
> +}

I believe you may reduce code size by ~2-3% just by refactoring it in a better
way. (Some examples are given above)

..

> +static int pcmdev_dev_bulk_write(struct pcmdevice_priv *pcm_dev,
> +	unsigned int dev_no, unsigned int reg, unsigned char *data,
> +	unsigned int len)

Ditto and so on!

..

> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);

= on the previous line, but you may just put all on one line.

..

> +	struct pcmdevice_priv *pcm_dev =
> +		snd_soc_component_get_drvdata(codec);

Ditto, and so on...


> +	ucontrol->value.integer.value[0] = pcm_dev->cur_conf;
> +
> +	return 0;
> +}

..

> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct pcmdevice_priv *pcm_dev =
> +		snd_soc_component_get_drvdata(codec);

> +	int ret = 0;

Useless variable, return number directly.

> +
> +	if (pcm_dev->cur_conf != ucontrol->value.integer.value[0]) {
> +		pcm_dev->cur_conf = ucontrol->value.integer.value[0];
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}

..

> +	unsigned int mask = (1 << fls(max)) - 1;

BIT() ?

..

> +	mutex_lock(&pcm_dev->codec_lock);

Why not using cleanup.h?

> +	rc = pcmdev_dev_read(pcm_dev, dev_no, reg, &val);
> +	if (rc) {
> +		dev_err(pcm_dev->dev, "%s:read, ERROR, E=%d\n",
> +			__func__, rc);
> +		goto out;
> +	}
> +
> +	val = (val >> shift) & mask;
> +	val = (val > max) ? max : val;
> +	val = mc->invert ? max - val : val;
> +	ucontrol->value.integer.value[0] = val;

> +out:
> +	mutex_unlock(&pcm_dev->codec_lock);

With cleanup.h becomes redundant.

> +	return rc;

Be consistent with name, ret, rc, what else?

..

> +};
> +

Unnecessary blank line.

> +module_i2c_driver(pcmdevice_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko



