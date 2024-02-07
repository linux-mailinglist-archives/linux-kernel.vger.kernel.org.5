Return-Path: <linux-kernel+bounces-56524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9584CB37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BDB1C2656D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84877F23;
	Wed,  7 Feb 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2c2f9HZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789CB76C91;
	Wed,  7 Feb 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311473; cv=none; b=cPUQqjOJiFCkU078mYLC/KYUXMX852VNz+QruC23BUZxvDTvl1Y5QQaWegL7ChwLLga1S+ZcBAo7gHPVtYUb3e54QERqzunFEBhA4CqsBDvCnJRT9Hj+r1a9K3apDv8XZueqlRuLk8TbTr20zpJZhz1PyIVE3+bWC98Jwon5TRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311473; c=relaxed/simple;
	bh=t41HZtbLAbN8FbfjnSV14y7bGHJBVeKGJ3oMcdSDM1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clPDaoOXcbr5b57LGVCbtlWDRZjPJ/pym1HBQ8rZQY2Q2nG+yjMP52ueX3yTWP6vahf596K1JtRj9g5q90BC40cSBnZ1G5t0gwnK6zrgTxJhPYhzTQJnEkiUzmn525q3dvxmhZCxtycLyiWca6knrOEz9XM8nzdcNleYcOp6AqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2c2f9HZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707311472; x=1738847472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t41HZtbLAbN8FbfjnSV14y7bGHJBVeKGJ3oMcdSDM1k=;
  b=C2c2f9HZY3x3+uFEJIm2+UHDhYFubsCzIVVP3IxxLIJWtxAzhT2tXL8E
   274XnaybNTo5Sx/nlf6hCgadUU3O9SkK7zjIQeS+Js2Ia1Xb6BIunknmJ
   35X67sj2hZnNtGFxmZGDogBF7l8h7uVnlDku+By8lIiZTpy+sCJJTQdfj
   aCqhT4vS4oPBUH9P55N9L3TcxGbPdwHUG3o/F/KhmNMduh/+XBwJwcHSN
   zLfxDRMiWN/VtZM2DUzs0dDVI7mr87ZTL5TPIz8/MzqBOh1nAQTSpJdw2
   X4F5128hqmyrzWD3OYkEQLyl39dCPa/Kb24Maszp+UCLn+nHbPcOB19Sm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1118065"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1118065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="824495463"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="824495463"
Received: from marquiz-s-2.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2024 05:11:08 -0800
Message-ID: <27323df7-7cb2-4cde-a6fc-8aef04370ead@linux.intel.com>
Date: Wed, 7 Feb 2024 15:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel Elkhart
 Lake
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, mika.westerberg@linux.intel.com,
 lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
 <ZbZqZDvdw-_D3hyb@smile.fi.intel.com> <ZbjPv_-S-6CQsaja@black.fi.intel.com>
 <Zbt__WmU74vmLpPR@smile.fi.intel.com> <Zbxo2b_TuCoSyhav@black.fi.intel.com>
 <ZcNt83zD4H3hsCgc@black.fi.intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <ZcNt83zD4H3hsCgc@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 13:48, Raag Jadav wrote:
> On Fri, Feb 02, 2024 at 06:02:46AM +0200, Raag Jadav wrote:
>> On Thu, Feb 01, 2024 at 01:26:53PM +0200, Andy Shevchenko wrote:
>>> On Tue, Jan 30, 2024 at 12:30:23PM +0200, Raag Jadav wrote:
>>>> On Sun, Jan 28, 2024 at 04:53:24PM +0200, Andy Shevchenko wrote:
>>>>> On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
>>>>>> Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
>>>>>> function with 8 channels each. Add support for the remaining channels.
>>>
>>> ...
>>>
>>>>> First option: Always provide driver data (info is never NULL).
>>>>
>>>> Allowing empty driver_data would save us from adding dummy info
>>>> for single instance devices in the future.
>>>
>>> Which may be too premature "optimisation". Why? Because if we ever have
>>> something like pci_dev_get_match_data(), the empty will mean NULL, and
>>> we may not get difference between empty and missing one.
>>
>> Not sure if I'm able to find such a helper as of now, but fair.
>> I can change it in v2 if Jarkko is okay with it.
> 
> Hi Jarkko,
> 
> If you agree with Andy's comments, please let me know.
> Will send out a v2 accordingly.
> 
Ah, sorry, I didn't have opinion.

