Return-Path: <linux-kernel+bounces-59565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B381684F8FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C14928F2FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37976046;
	Fri,  9 Feb 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1EpISaC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E16BFD6;
	Fri,  9 Feb 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494221; cv=none; b=DjdWUUDUzl8ss03MgKRpLJZk/KMCDuq9IbcqfqyujMc8uIHuf3n685KrvyDheU/W755HepGIns3YPNggGRu4M9aub4la68Gyz99VwBFsZxXV9/4MO999jp3AwjIyYDLmfezpbNwkaKukYB+VeXsT/kFKwtWXw+diiEDeXeSLMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494221; c=relaxed/simple;
	bh=1Py4UFKVG/mP2yurJX7hEGwtHJpXMmiQ6Q1WRDmX8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSTPzruh8WXMlEvY7xQHK99a3QN+oY+ziIgN6pKY4SPgmHaCh6h17Qy1jciEKNiJxEYq6RKkIiNsyuzX9kpLutfD3uyXtFMW1z+ZfKpWy/XPvCrCbKZp6TLgYSIccw806q22BAdVJ+GrGwUU//yNMUIQgetfpIja/osGy7fT4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1EpISaC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707494220; x=1739030220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Py4UFKVG/mP2yurJX7hEGwtHJpXMmiQ6Q1WRDmX8xc=;
  b=Y1EpISaCrQrk6iXtsa8lnM6Hd0aUxwyGY43YlK2gCVB2fpd8gAtUH3qk
   44Un1m4TRKGVYIWGELuJj+rJYzY0oCU3Sfihl4qglVOTVh2irolrDmfI2
   5lkYXDrTYBYdpJb+xCfQaFJW9ndU57gpFZIgZukHoBtCNN2We22hkmYG2
   llaIQ4Vn7sfjOeInHnW1rz2yW9fZaGeTXoebPaFRI3JVZYbpfdFsTq2t3
   qDfw20V5CdEJddC+Heaqo0KgXyQob819r70bL51owP/1o7NPqvTFZSKUo
   j9px1I2KBPovPmAZokVVJRVM1f8MMKpatJ9xr2F5hZ7/p7GCdRKKKQYpT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12823531"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12823531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1956636"
Received: from csromei-mobl1.amr.corp.intel.com (HELO [10.212.93.94]) ([10.212.93.94])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:56:56 -0800
Message-ID: <d65cf9f4-1617-2962-2786-bcaf7907dd67@linux.intel.com>
Date: Fri, 9 Feb 2024 09:44:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
 "P O, Vijeth" <v-po@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
 "perex@perex.cz" <perex@perex.cz>, "McPherson, Jeff" <j-mcpherson@ti.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
 "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "Djuandi, Peter" <pdjuandi@ti.com>, "Agrawal, Manisha"
 <manisha.agrawal@ti.com>, "Hari, Raj" <s-hari@ti.com>,
 "Yashar, Avi" <aviel@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>
References: <20240208095255.1508-1-shenghao-ding@ti.com>
 <160173b0-098e-493f-93b1-8b831838e0a0@linux.intel.com>
 <0ac563b32399400897b8f3adce6195c3@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <0ac563b32399400897b8f3adce6195c3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> +static const char *const pcmdev_ctrl_name[] = {
>>> +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
>>> +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
>>> +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
>>> +};
>>
>> Controls are exposed to user-space, and it helps if it's easy to identify which
>> device is which.
>>
>> But below you are using the I2C address, is this 'stable' enough so that
>> userspace can still identify the controls and set them accordingly with amixer
>> or UCM?
>>
> So far, I have no good way to handle the devices with multiple pcmdevices sitting in different i2c buses.
> As you know, the gain value highly depends on both the mic-phone position and the mic-phone's own
>   characters. All these controls have to be open to the product developer or manufacturer. They might
> rename them per their products if they want.
> As to the stable, my customers and I had developed many productors on arm-based paltforms. At least,
> the i2c number is same as the one defined in dts.

IIRC there is a codec prefix that can be used to uniquify controls, 
that's what we used when we have identical amplifier devices in the same 
system. Using this prefix would avoid this sort of hard-coding of the 
control names proper, in other words let the ASoC framework add a prefix 
if needed.

>>> +static int pcmdevice_codec_probe(struct snd_soc_component *codec) {
>>> +	struct pcmdevice_priv *pcm_dev =
>> snd_soc_component_get_drvdata(codec);
>>> +	struct i2c_adapter *adap = pcm_dev->client->adapter;
>>> +	int ret, i, j;
>>> +
>>> +	mutex_lock(&pcm_dev->codec_lock);
>>> +	pcm_dev->component = codec;
>>> +	pcm_dev->fw_state = PCMDEVICE_FW_LOAD_OK;
>>> +
>>> +	for (i = 0; i < pcm_dev->ndev; i++) {
>>> +		for (j = 0; j < 2; j++) {
>>> +			ret = pcmdev_gain_ctrl_add(pcm_dev, i, j);
>>> +			if (ret < 0)
>>> +				goto out;
>>> +		}
>>> +	}
>>> +
>>> +	/* device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
>>> +	 * sum[1,2,...,4]dev-reg.bin stores the firmware including register
>>> +	 * setting and params for different filters inside chips, it must be
>>> +	 * copied into firmware folder. The same types of pcmdevices sitting
>>> +	 * on the same i2c bus will be aggregated as one single codec,
>>> +	 * all of them share the same bin file.
>>> +	 */
>>> +	scnprintf(pcm_dev->regbin_name,
>> PCMDEVICE_REGBIN_FILENAME_LEN,
>>> +		"%s-i2c-%d-%udev-reg.bin", pcm_dev->dev_name, adap->nr,
>>> +		pcm_dev->ndev);
>>> +
>>> +	ret = request_firmware_nowait(THIS_MODULE,
>> FW_ACTION_UEVENT,
>>> +		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL,
>> pcm_dev,
>>> +		pcmdev_regbin_ready);
>>
>> I already had a question early on whether these addresses are 'stable', but
>> here the device address is used to fetch firmware, and there is no prefix or
>> directory to identify platform-specific settings.
>>
>> I don't know how this might work for a distribution. There needs to be a way
>> to detect what system this is at run-time, and make sure we don't use
>> settings for platform XYZ on platform ABC.
>>
> In PC, hwid, subsysid and vendorid can help to identify the platform.
>   But it seemed difficult to get platform id on non-PC system. More often,
> different productors from different customers might use the same platform.
> In my view, the products developer or manufacturer might rename the firmware
>   per their products if they want, not limited to the platform.

It's not "might rename", it's "are required to rename".

Your solution works if everything is build and configured for ONE board. 
That's pretty limiting, even for your own CI and tests.

Could we not add a prefix for the firmware path that either either set 
with a subsys_id or vendor_id, and if it doesn't exist with a kernel 
parameter or a quirk?

Renaming firmware files is a never-ending source of problems IMHO.


