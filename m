Return-Path: <linux-kernel+bounces-81863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B62867B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D71F2AC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D012C528;
	Mon, 26 Feb 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgAzLgtY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680E12BEBD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963571; cv=none; b=QVnNT2fH0/FyXBL67k7KUsCtM5QmnEUAA6WsOCts0ls3Cauau3zwqIMlN+7Uao4EQSKlYV+x8dqfJqdRCBYaY0OD/IXJXnHhbfgWz6cEfE6YQ5y6dhBwBIbL+ugJ31CqxcFcEi+fc2G1jdhkdmWu0BSnZICwHzCyQqOrJZU12qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963571; c=relaxed/simple;
	bh=b3xl9FmNk6hu+KL8YOmLHkCKnjghMPXBxrgh3d+k4SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kr7IE6OHzU7INex6TxFgHL5TgvwIqdkHlk0pusap+e1W7v5rjA9RArPNuZglLgrTC5LdYH41lCBqhTQTgpkTdPFJY+vF2ftxvgca+o92meP6C1ldbM95JQlzbeVWnSm9ETHMKoFa8ab1LNu+r86J7gdUrIqSalT1p+wsLDp1XtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgAzLgtY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708963570; x=1740499570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b3xl9FmNk6hu+KL8YOmLHkCKnjghMPXBxrgh3d+k4SM=;
  b=SgAzLgtYFI3LMPKjWPsmtzzQYRNYJ8ZfkujxsHDq3gZ0ohW/I5i9Jz/Z
   rCvpUmOT+SWu8qX071D0+j00h0erNBFELMzR4bYc1h+qXguaDndjSp4Qw
   OutqIfv8NQOI1hcd0+wfvoqiFAzl+AlK3jGET5wQiz5yQHSbq1yOaShNi
   eukRzmahVEMwQCsKKAFpRXAMIrx7VqxZGbxGM+k2ov/0gt4d51XO7MFwg
   evSpTqYDW934JjnKkFWzRoQvutWhnmV2Qy+ZF1lhaIgYPblaU0VaCC4Og
   /Vbr8MDE4x94bQZqJPXkXIHxXsB9T1BlhMJvxkuoBMemg9bNVm74giQzq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3129125"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3129125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11343492"
Received: from tankuang-mobl.gar.corp.intel.com (HELO [10.246.128.202]) ([10.246.128.202])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:06:06 -0800
Message-ID: <2c7e33e5-6904-467d-9912-417bab95e517@linux.intel.com>
Date: Mon, 26 Feb 2024 10:56:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec driver
To: Mark Brown <broonie@kernel.org>, "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>, "13916275206@139.com" <13916275206@139.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "bard.liao@intel.com" <bard.liao@intel.com>,
 "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "Xu, Baojun" <baojun.xu@ti.com>, "Lu, Kevin" <kevin-lu@ti.com>,
 "tiwai@suse.de" <tiwai@suse.de>, "soyer@irl.hu" <soyer@irl.hu>
References: <20240222074000.659-1-shenghao-ding@ti.com>
 <10f53a13-a0ff-40f9-b089-f5baacdb76b6@linux.intel.com>
 <5c7127256bf54fcd921fc1ec83f3e527@ti.com>
 <ZdjTyccCDoD9QYpi@finisterre.sirena.org.uk>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZdjTyccCDoD9QYpi@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 12:20 PM, Mark Brown wrote:
> On Fri, Feb 23, 2024 at 10:12:49AM +0000, Ding, Shenghao wrote:
>> Hi Pierre-Louis
>>
>>> In the SoundWire spec, the unique_id is *LINK SPECIFIC*, and only used at
>>> the bus level within the context of a link to help avoid enumeration
>>> conflicts
> 
>>> If you are using the unique_id as a SYSTEM-UNIQUE value to lookup EFI
>>> data, this is a TI-specific requirement that needs to be documented.
>>> That also means you need to double-check for errors so make sure there
>>> are no board configurations where the same unique_id is used in multiple
>>> links, or by devices other than tas2783.
> 
>> This code only covers the tas2783s sitting in the same bus link. As to cases of the
>> different SWD links, customer will be required to have the secondary development
>> on current code. I'm sure my customers have much knowledge to handle this.

PC OEMs don't usually have a Linux team capable of handling this sort of 
low-level plumbing, so the burden of this "secondary development" will 
come back at you...

> As Pierre says I think we really should have some sort of defensive
> programming here, even if you're going to leave multi-link systems to
> future work people will still have older versions in distributions or
> whtaever.  While I'm not sure the consequences of getting things wrong
> are likely to be that bad (I'm expecting bad quality audio) it's also
> going to be kind of hard to figure out if we just silently pick the
> wrong calibration, especially if it's actually a valid calibration for
> another device in the system.  Other vendors (eg, Cirrus) seem to have
> figured out a scheme here?

Leaving multi-link aside has to be seen as as temporary step, there are 
a number of electrical issues that will prevent more than 4 amps to be 
placed on the same link. And indeed this "secondary development" has to 
be backwards compatible with initial calibration schemes.

