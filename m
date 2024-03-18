Return-Path: <linux-kernel+bounces-105851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15487E577
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A788A281243
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67352D044;
	Mon, 18 Mar 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9nYg4DJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439F2D022
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753167; cv=none; b=TjJE5OCejSLHfzToHZ3lAbP/VOfQCWGdSyhp4NHxEBNzURwxU4POc185OA7FWRoJxMPOoApZHHK+Cs5vWqepWuW0TEyY12KsEU3Zil0jBkj1k4wU8sjkVAWsvF9SYZFp/81B+C0ztmeIIbaCGLhU0hza4aZ3gtMO2Ka3IFIX85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753167; c=relaxed/simple;
	bh=g8C3AW8Pp9g1XGrLlgppqk+fTtxc6q/BL7/maZ9K/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK6xa3kolhXEKMSaLbUes8ihNbWcMcuRG6rCTzwOKntqrjV7IX0G01K84SoGhjMpW9Jott36j3aaqqDBbqa58BY5kgbIjb96JGjaz0YgfefedzshXE1KssTaeWpm0Yas0DmqInL0o5dD0oWVncgw4TbxHdIW68U+VeasL6S0wSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9nYg4DJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710753165; x=1742289165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g8C3AW8Pp9g1XGrLlgppqk+fTtxc6q/BL7/maZ9K/aU=;
  b=b9nYg4DJE6TlbE4aybMmPNBxcmFjc4VlNsj+4lNgQNkNRiueW5cTRrfR
   N61V64XacRAqwWMZue253W/1C16KbyE9LjhXEqXUICCc/ACVJsO+3CXdB
   cAVhUpWVbF9Umf3OYqAd1V/EuwzmSWu7xgIJCdZYbv0CCSzVkCieKHDqu
   WRs5tUFWyvn28IQnSV6hWQofMRZ9aFbEnxHhYh1td6Cw1w8/fCUO4qK8A
   /6BIPMkVZobfEhEKplGS4gJ0R+jnQ1/5vnpq1Ujbm1V2orOypGCajNF04
   glOsH2nMhkldpBPodlNNyauWDD/crn1uDdn6+29n6/45Nauq10VUTU9Ro
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5680037"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5680037"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 02:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13510543"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 02:12:40 -0700
Message-ID: <89231582-bc4e-4729-8dc1-bac190c28e00@linux.intel.com>
Date: Mon, 18 Mar 2024 10:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
 driver
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "bard.liao@intel.com" <bard.liao@intel.com>,
 "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "Lu, Kevin" <kevin-lu@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "soyer@irl.hu" <soyer@irl.hu>, "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>
References: <20240305132646.638-1-shenghao-ding@ti.com>
 <2efb5250-25f3-465e-81fc-cb885027b481@linux.intel.com>
 <4e2006ff96a446978dd1996eeaa42099@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <4e2006ff96a446978dd1996eeaa42099@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/2024 1:44 PM, Ding, Shenghao wrote:
> Thanks for your comments. Kindly see the feedback
> 
>> -----Original Message-----
>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> Sent: Wednesday, March 6, 2024 12:05 AM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; broonie@kernel.org
>> Cc: andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com;
>> perex@perex.cz; pierre-louis.bossart@linux.intel.com;
>> 13916275206@139.com; alsa-devel@alsa-project.org; linux-
>> kernel@vger.kernel.org; liam.r.girdwood@intel.com; bard.liao@intel.com;
>> mengdong.lin@intel.com; yung-chuan.liao@linux.intel.com; Lu, Kevin
>> <kevin-lu@ti.com>; tiwai@suse.de; soyer@irl.hu; Baojun.Xu@fpt.com;
>> Navada Kanyana, Mukund <navada@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
>> driver
>>
>> On 3/5/2024 2:26 PM, Shenghao Ding wrote:
>>> The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
>>> interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces
>>> designed for portable applications. An on-chip DSP supports Texas
>>> Instruments SmartAmp speaker protection algorithm. The integrated
>>> speaker voltage and current sense provides for real-time monitoring of
>> loudspeakers.
>>>
>>> The ASoC component provides the majority of the functionality of the
>>> device, all the audio functions.
>>>
>>> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>>>
>>> ---
>>
>> ...
> ...
>>> +struct tasdevice_priv {
>>> +	struct snd_soc_component *component;
>>
>> Apart from being assigned this field seems to be unused.
> This field can help to get the point to "struct tasdevice_priv" in tasdevice_sdw_pcm_hw_free,
> tasdevice_sdw_hw_params, tasdevice_mute
> 

This field is unused in those functions, in all of them you get 
component from dai, via dai->component, and tas_priv from this component 
via snd_soc_component_get_drvdata, which is wrapper around 
dev_get_drvdata, which just returns dev->driver_data.


