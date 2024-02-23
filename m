Return-Path: <linux-kernel+bounces-77559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE5860779
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF86B2262E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCC399;
	Fri, 23 Feb 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAIzIKoZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386B7F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647240; cv=none; b=UAIIdRKVNj2Wg0kufMY9hVwA5LZ4IUyRTSCV5tKAleUdVsv8iYTUQM//F5jXO0XueJjuEB1e609WASnWpqJxAiPAQUrXV/vCyTSGnIFsJV4yTaUnQVbzPnePl2uw9rFXsUWK2JDcmDcA3b0j4fqjo67UCMsqeS8UgYpdcrM5qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647240; c=relaxed/simple;
	bh=4EONJpHLKVvplBQ1JdsOvXRqsXqzysjuQvWLs1B0/2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyISCFxL6aw6j8YfEvdQ1UTR4CUJ0il+EBL481oDOp2lEe8oZO1bsptGgttwRYwjr3hn1gvtVanVWOl2p+eU+gP6IhnXT4nhv5WtOngXLEk9w1P8JzetXVX9euy8uwb3K2zR86lUJWj1eUjDZKvTJ/m99wLmjNCizn7HudIz42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAIzIKoZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708647239; x=1740183239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4EONJpHLKVvplBQ1JdsOvXRqsXqzysjuQvWLs1B0/2M=;
  b=KAIzIKoZR8tpTXEPCbXnU+81SBdtzyvrIUHrIvNCm0ZW0q2gCzpl0BaT
   LjWXrCRBBq/46cHPR3l6Xqn0DVlJwcY4n0l7IX1O5Ti4LRXkB7k87nks9
   i92w0wx2+0UWZBDtnetdP8uzA49cbE2zFuHSdz+cYvQn3OQ5+0FE76CRq
   ScMD17q8Ley8vkYyowbHN6i3m7jAFzfWBlxN0dMTPicy9aMIrw84U3/qY
   yp8UhBK2EtAtGiYNeyYQDVNIb7F9it7m2ZQbZxEBe5WQvR5uB/CrysabA
   LTRhL2N8nK8vVL+SWdsMXYZDUyiGxC5Alm7BFjQCXz42l0M7bwI0wFmMZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13497023"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13497023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10363862"
Received: from smsalasl-mobl.amr.corp.intel.com (HELO [10.246.128.93]) ([10.246.128.93])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:13:55 -0800
Message-ID: <10f53a13-a0ff-40f9-b089-f5baacdb76b6@linux.intel.com>
Date: Thu, 22 Feb 2024 19:13:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec driver
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 bard.liao@intel.com, mengdong.lin@intel.com,
 yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
 tiwai@suse.de, soyer@irl.hu
References: <20240222074000.659-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240222074000.659-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 2:40 AM, Shenghao Ding wrote:
> The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
> interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces designed
> for portable applications. An on-chip DSP supports Texas Instruments
> SmartAmp speaker protection algorithm. The integrated speaker voltage and
> current sense provides for real-time monitoring of lodspeakers.

loudspeakers.


> +static void tas2783_apply_calib(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	u8 *cali_start;
> +	u16 offset;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	offset = tas_dev->sdw_peripheral->id.unique_id -
> +		TAS2783_UNIQUE_ID_BASE;
> +	if (offset >= TAS2783_MAX_DEV_NUM) {
> +		dev_err(tas_dev->dev, "%s: offset(%u) is out of range.\n",
> +			 __func__, offset);
> +		return;
> +	}

I think we are at the 4th iteration where I have to repeat myself...

In the SoundWire spec, the unique_id is *LINK SPECIFIC*, and only used 
at the bus level within the context of a link to help avoid enumeration 
conflicts

If you are using the unique_id as a SYSTEM-UNIQUE value to lookup EFI 
data, this is a TI-specific requirement that needs to be documented. 
That also means you need to double-check for errors so make sure there 
are no board configurations where the same unique_id is used in multiple 
links, or by devices other than tas2783.




