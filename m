Return-Path: <linux-kernel+bounces-119279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5B88C68A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC49B2312D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0513C82D;
	Tue, 26 Mar 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW0xCTa9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FE13C811
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466013; cv=none; b=kS2lT6/VSS21HcLPy7VPl91iumadgxsvWCmDu+2NS96Dgr+BKEcDtJ1KLttQdW8lOmMXqMU9wqDEldkqmm65DR2FlVVbk6kSI+IgfuZsXF1wWzwf/TKHlKUv2vEJqOzhVdwebH3ziYV1cDDmnb6xgYcMfBefY+KFhSKYdS2GjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466013; c=relaxed/simple;
	bh=N5vpAX5ok4BXjms0T9fuLUBgLvF4hsCxME6vnFJ3oyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6XzwQfHiSDIwMcZiuuU2vkix6rkBOUt5NW0pRslN+dwHIPxHqYST2sGENgf9ctujk6+iXdSsVpg9ka0hQN7/gVQ/UblrWQFwx4CTA5jMQljmF0FWhKHiaICZeD+2dRONcYgopMEkVMXGSXgDxeIoyjaTF7TtGxl+xSDWLmBsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW0xCTa9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466012; x=1743002012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N5vpAX5ok4BXjms0T9fuLUBgLvF4hsCxME6vnFJ3oyc=;
  b=NW0xCTa90WLQffrqb5Hy/0aHU8PCUWayor3idBn+TYym/8S1DsyciqHp
   Ur/VKalRRvacL/1xVoIlfFebd5Cm64GRTLKhyYeztLM5QGCAKCK69yXwe
   G/8zpclcIug091stbKScYx/Z8ezzTjj1UlTzy2dRAbEZKRe2yVFTk/zcw
   6GOHt328tUSMD2xO12YYISNcS17JnXSW9D43PPtnxrQHs6XGrGnPFZyTw
   qi0CIFBJ6jDemregvFX+7ofQWYe39j8U5bixLdzb/VDpz/Wh2Bf3ECNno
   d09gIoUeYIrTAfcKAGOGxtbGMe6n3w68oQ9TLjHw2JrMLF6eKKOS+hiFv
   Q==;
X-CSE-ConnectionGUID: h5r9l6YbQnW5wv1TPfUt6A==
X-CSE-MsgGUID: YTNmLPqAT+C3KW47nbJKHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9489024"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="9489024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15862590"
Received: from bhubbert-mobl.amr.corp.intel.com (HELO [10.212.65.108]) ([10.212.65.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:13:28 -0700
Message-ID: <bc8d97e2-6742-4ca3-bd6a-143fe88f617b@linux.intel.com>
Date: Tue, 26 Mar 2024 10:00:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
 driver
Content-Language: en-US
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>, "13916275206@139.com" <13916275206@139.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "bard.liao@intel.com" <bard.liao@intel.com>,
 "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "Lu, Kevin" <kevin-lu@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
 "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>
References: <20240319135811.186-1-shenghao-ding@ti.com>
 <34f404cd-a12d-4ffa-9398-72de3be244b3@linux.intel.com>
 <51a81ac8aace456aae7d07634912367c@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <51a81ac8aace456aae7d07634912367c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>> +
>>> +	/* Check Calibrated Data V2 */
>>> +	if (tmp_val[0] == 2783) {
>>> +		const struct calibdatav2_info calib_info = {
>>> +			.number_of_devices = tmp_val[1],
>>> +			.crc32_indx = 3 + tmp_val[1] * 6,
>>> +			.byt_sz = 12 + tmp_val[1] * 24,
>>> +			.cali_data = &tmp_val[3]
>>> +		};
>>> +
>>> +		if (calib_info.number_of_devices >
>> TAS2783_MAX_DEV_NUM ||
>>> +			calib_info.number_of_devices == 0) {
>>> +			dev_dbg(tas_dev->dev, "No dev in calibrated data
>> V2.");
>>
>> the log is not aligned with the first condition where you have too many
>> devices.
>>
>> It's not clear why it's not an error.
> playback still work without calibrated data stored in UEFI, for example bypass mode.
> Even if in case of bypass mode, algo can still work with default calibrated data.
> So, not an error.

I would use a dev_info with a clearer message that defaults are used,
e.g. along the lines of

dev_info(tas_dev->dev, "using default calibration data, no device found
in EFI data v2").

dev_warn would work as well if this is really not expected.

