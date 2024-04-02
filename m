Return-Path: <linux-kernel+bounces-129736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96514896F48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9492842AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668CD146D54;
	Wed,  3 Apr 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkvbsMi0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE444C97;
	Wed,  3 Apr 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148624; cv=none; b=sLa1yWhwy7W8BRLKqeyj9IVoNAPljOpY+EwjZmQVRM6v0qHkHI9xlseSsUMWhdPCfwVQyt2N9JFxXhY9YXAbY1pDgB3CnXqHBEbNCVR8pCnJodpg2MArKxnur1nwfwYSay5yXMTspbVJKPhw64L7EkROFryn7ZN/Mq6jcNPaqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148624; c=relaxed/simple;
	bh=rhp7e6puQyVUMErtQ1wrKsDuOwsFw8HjdJrVLLq+GRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPgI8W444QcA7qWQ38FKyiIMojUHDDAjaGcexJE2/46Dwb/u462DS15nDGAGx39Uqa8FkWzcWXMnzZizzX5s4mHLWPRYK0hCW0j8EQ59QjucFP+c3tBnF/i+NWHqc82uXabD5NDlorIExDEn2iyckO/CPnU/LC8lPKLucRknB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkvbsMi0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712148623; x=1743684623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rhp7e6puQyVUMErtQ1wrKsDuOwsFw8HjdJrVLLq+GRo=;
  b=KkvbsMi0a3GwZQH6OS4qDkK6GKzMItf+9mMJQrlpnAi+meTSbsOpwtnP
   FrSQJtA+D8R+fGZLlKi413OBM0d2wxX2d0lcMbdI3Xcf3x3UHIzwKGWMa
   7QyqBahdXupDHXm+T9LRIA6BxqfPBAkL//QX8cuYRQRKr2Lc79jNTlGWM
   7fCDKhToPD8wPp5EcPOImuBBgtO7EvHAd007FxI6BdVsZAeMU5U+AQ0f6
   +o+PUOxWUIZCKnQtKtR4WYBmQWOfW7i/EC+Dklt+O0XhTn8fv+NXQIaeJ
   8j1Ycl9ci1pAUy3adZT1gwjFLO+U4HDJWY2SQlWTpmT7Q9Xvh5Bdy3zPM
   g==;
X-CSE-ConnectionGUID: v9EQG/HkTBuqCVkMznfwog==
X-CSE-MsgGUID: tsE9gVh+SEKW4sMbKWWVYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7539277"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7539277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 05:50:23 -0700
X-CSE-ConnectionGUID: 1/2JH2STQ7WDV9dzV2GDbw==
X-CSE-MsgGUID: R5MUllpuTCKa7NQ8b3XutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18343201"
Received: from makulkar-mobl1.amr.corp.intel.com (HELO [10.212.52.18]) ([10.212.52.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 05:50:21 -0700
Message-ID: <ef510647-c409-4da6-9cd4-ff4e54cbee74@linux.intel.com>
Date: Tue, 2 Apr 2024 08:57:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDIvMl0gQVNvQzogY2RuczogQWRk?=
 =?UTF-8?Q?_drivers_of_Cadence_Multi-Channel_I2S_Controller?=
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
 <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
 <NTZPR01MB0956BFADB4B3DA507D938F669F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <NTZPR01MB0956BFADB4B3DA507D938F669F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>
>>> +#define PERIODS_MIN		2
>>> +
>>> +static unsigned int cdns_i2s_pcm_tx(struct cdns_i2s_dev *dev,
>>> +				    struct snd_pcm_runtime *runtime,
>>> +				    unsigned int tx_ptr, bool *period_elapsed,
>>> +				    snd_pcm_format_t format)
>>> +{
>>> +	unsigned int period_pos = tx_ptr % runtime->period_size;
>>
>> not following what the modulo is for, usually it's modulo the buffer size?
> 
> This is to see if the new data is divisible by period_size and to determine whether
> it is enough for a period_size in the later loop.

That didn't answer to my question, the position is usually between
0..buffer_size.1.

Doing increments on a modulo value then comparisons as done below seems
rather questionable.
	
>>> +
>>> +		iowrite32(data[0], dev->base + CDNS_FIFO_MEM);
>>> +		iowrite32(data[1], dev->base + CDNS_FIFO_MEM);
>>> +		period_pos++;
>>> +		if (++tx_ptr >= runtime->buffer_size)
>>> +			tx_ptr = 0;
>>> +	}
>>> +
>>> +	*period_elapsed = period_pos >= runtime->period_size;
>>> +	return tx_ptr;
>>> +}

>>> +	pm_runtime_enable(&pdev->dev);
>>> +	if (pm_runtime_enabled(&pdev->dev))
>>> +		cdns_i2s_runtime_suspend(&pdev->dev);
>>
>> that sequence looks suspicious.... Why would you suspend immediately during the
>> probe? You're probably missing all the autosuspend stuff?
> 
> Since I have enabled clocks before, and the device is in the suspend state after
> pm_runtime_enable(), I need to disable clocks in cdns_i2s_runtime_suspend()
> to match the suspend state.

That is very odd on two counts
a) if you haven't enabled the clocks, why do you need to disbale them?
b) if you do a pm_runtime_enable(), then the branch if
(pm_runtime_enabled) is always true.


> 
>>
>>> +
>>> +	dev_dbg(&pdev->dev, "I2S supports %d stereo channels with %s.\n",
>>> +		i2s->max_channels, ((i2s->irq < 0) ? "dma" : "interrupt"));
>>> +
>>> +	return 0;
>>> +
>>> +err:
>>> +	return ret;
>>> +}
>>> +
>>> +static int cdns_i2s_remove(struct platform_device *pdev) {
>>> +	pm_runtime_disable(&pdev->dev);
>>> +	if (!pm_runtime_status_suspended(&pdev->dev))
>>> +		cdns_i2s_runtime_suspend(&pdev->dev);
>>
>> ... and this one too. Once you've disabled pm_runtime, checking the status is
>> irrelevant...
> 
> I think the clocks need to be always enabled after probe if disable pm_runtime,
> and should be disabled when remove. This will do that.

if you are disabling pm_runtime, then the pm_runtime state becames invalid.
When pm_runtime_disable() is added in remove operations, it's mainly to
prevent the device from suspending.


