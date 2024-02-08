Return-Path: <linux-kernel+bounces-58872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9AD84EDED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E41F2255B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A965465D;
	Thu,  8 Feb 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5NgCWMa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789675675D;
	Thu,  8 Feb 2024 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435333; cv=none; b=qNw6SVwcNF9wKbLD/XCFN3WzgibdHFRLLsV5BfPa1xTlgmKr4wrcIqK+o4dB1c/Qh/uzTJi0HCa64adFDCCihvvBjtQzmQslfgdWgIqq1OfZnllP3f9Yh4Jra8pLZmIDn8xdHkoNalXkeAPGj+eJSlzx7NMJGR6SaFIBYVbNv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435333; c=relaxed/simple;
	bh=J0Twd02hQUbsBBInLg7jm3H07srkKxEwwTBstUiRQMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpshfDseCyMTzZxkGRKNkmTzb1/4X2fdz3fhqWRb3DdPcfpoYdHuzFfbxKUUpcwhynamlmsqvbtNjuX2sPICYlovDcnm+FsTm073eHlbM0TYTmtrNf4Y+CPHwflhFH5e1uQgyPy14EV7wXUXuCqRmyBPmfs1COi85FdZMG7Puek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5NgCWMa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707435331; x=1738971331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J0Twd02hQUbsBBInLg7jm3H07srkKxEwwTBstUiRQMQ=;
  b=E5NgCWMa52VkuLIhxaibgfcsBlk+q+nD7p8UGJC47TX92gjL1oIYPOG1
   wAWirt2UQIvd+sl+/+KgEyWLNhUg+UUwCEWVg3tS2mIZmj0qdv2A4P8oZ
   Z214KPLRD7n3IR9v22FueQP+d78+5oyWzEplREKKLgu07YkKiMAqQnjTc
   GElg6HxhlncFJxXaxEEowwhnrQljp0CB3O1u8u1aaWlCPeI1vYllht6T3
   sirYZqO25MCAXcdqwmR54orTvSawcvZbbL0MZudNqslekFTXyb9cAGzUr
   BpPgPD9iwp/PjY20mx3KdIwB3+dMZaPnUUX8tkIf7mfzQ8Zi04/30k3HW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1482247"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1482247"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 15:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824989337"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="824989337"
Received: from leonzhen-mobl1.amr.corp.intel.com (HELO [10.212.78.190]) ([10.212.78.190])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 15:35:27 -0800
Message-ID: <160173b0-098e-493f-93b1-8b831838e0a0@linux.intel.com>
Date: Thu, 8 Feb 2024 08:38:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-sound@vger.kernel.org,
 liam.r.girdwood@intel.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Cc: kevin-lu@ti.com, baojun.xu@ti.com, v-po@ti.com, navada@ti.com,
 perex@perex.cz, j-mcpherson@ti.com, 13916275206@139.com,
 mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
 pdjuandi@ti.com, manisha.agrawal@ti.com, s-hari@ti.com, aviel@ti.com,
 hnagalla@ti.com, praneeth@ti.com
References: <20240208095255.1508-1-shenghao-ding@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240208095255.1508-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




> +static const char *const pcmdev_ctrl_name[] = {
> +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> +};

Controls are exposed to user-space, and it helps if it's easy to
identify which device is which.

But below you are using the I2C address, is this 'stable' enough so that
userspace can still identify the controls and set them accordingly with
amixer or UCM?


> +	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg, val_mask, val);
> +	if (err)
> +		dev_err(pcm_dev->dev, "%s:update_bits, ERROR, E=%d\n",
> +			__func__, err);

generic comment for this patch: you may want to follow the same
convention for error log, sometimes it's %s, or %s: or no %s


> +static int pcmdevice_codec_probe(struct snd_soc_component *codec)
> +{
> +	struct pcmdevice_priv *pcm_dev = snd_soc_component_get_drvdata(codec);
> +	struct i2c_adapter *adap = pcm_dev->client->adapter;
> +	int ret, i, j;
> +
> +	mutex_lock(&pcm_dev->codec_lock);
> +	pcm_dev->component = codec;
> +	pcm_dev->fw_state = PCMDEVICE_FW_LOAD_OK;
> +
> +	for (i = 0; i < pcm_dev->ndev; i++) {
> +		for (j = 0; j < 2; j++) {
> +			ret = pcmdev_gain_ctrl_add(pcm_dev, i, j);
> +			if (ret < 0)
> +				goto out;
> +		}
> +	}
> +
> +	/* device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
> +	 * sum[1,2,...,4]dev-reg.bin stores the firmware including register
> +	 * setting and params for different filters inside chips, it must be
> +	 * copied into firmware folder. The same types of pcmdevices sitting
> +	 * on the same i2c bus will be aggregated as one single codec,
> +	 * all of them share the same bin file.
> +	 */
> +	scnprintf(pcm_dev->regbin_name, PCMDEVICE_REGBIN_FILENAME_LEN,
> +		"%s-i2c-%d-%udev-reg.bin", pcm_dev->dev_name, adap->nr,
> +		pcm_dev->ndev);
> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL, pcm_dev,
> +		pcmdev_regbin_ready);

I already had a question early on whether these addresses are 'stable',
but here the device address is used to fetch firmware, and there is no
prefix or directory to identify platform-specific settings.

I don't know how this might work for a distribution. There needs to be a
way to detect what system this is at run-time, and make sure we don't
use settings for platform XYZ on platform ABC.


> +static int pcmdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +	int clk_id, unsigned int freq, int dir)
> +{
> +	struct pcmdevice_priv *pcm_dev = snd_soc_dai_get_drvdata(codec_dai);
> +
> +	pcm_dev->sysclk = freq;

check clock values?

> +
> +	return 0;
> +}


