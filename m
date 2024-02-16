Return-Path: <linux-kernel+bounces-68236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8912A8577AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEAE1C209FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC54617C76;
	Fri, 16 Feb 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4T6HANt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB017BC4;
	Fri, 16 Feb 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072117; cv=none; b=AWResvZ+Z7S9LHnSleHxhCf85Ws6MQc7yK7FtROKbTmIvI3RNknJmJJMVB/0szIXfGV0SCI6PSP08wbsOI8ua+LyUEInXELa5mLcHPsAF/O3scG9z50QkgFJ2dOdZA1CVPYpqFW0IbRELq82hZGxVG9M6vh21N31qqfql/Wg390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072117; c=relaxed/simple;
	bh=3dRzrnpFg8YfYOSvDA85fQuaVmzQ9vV/C38TKb1GY0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhCGIpvaPBk9C8QjuAkKVrIiw8v9C/7B43+XcVTwk7kFjAOKs6tV+NJvvcQ1MOVRt6eBjR8N1tW5TnbMkdS2ci+q4UQfSMfVF4ayBa4Tl/IBzOzSgcytksXWhwA4B2zVnXhSAhS3SojQ3TXlNyIIACH88iJXOU0vJ1NoA/QUjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4T6HANt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072115; x=1739608115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3dRzrnpFg8YfYOSvDA85fQuaVmzQ9vV/C38TKb1GY0k=;
  b=L4T6HANtSsno1ALN71APWI0fB4a/vpds4/l5tGZryk5K6Lb1Zr7DUj/6
   rPCO5R0EAfthCQGy5LrjZvEv1uSni5yg7kTOwldLvQu+9WiQ4zkBFt2Nu
   E8POJR8Uukgfl74mO3RTbFeFDfPZr+LwDS7wO/QTAGB8KD3tLY+eviWNw
   lrXa3DKlq6C8CGPIVRY5bmAfas/90y1VOyL1TIDEZuj+WC8UI6fmoEdBm
   gQt2CZmFA+qi7hAhwNi8V5ZJCETOBLiFt7r0RF2je1YJljNFAsWuyY01L
   6d9lZzgwNLr8UQrQiloSGlbisgs2C9x0ivYlYgiZMbZ43kJ8yvIWDd9of
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="24658491"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="24658491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912324991"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912324991"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:28:31 -0800
Message-ID: <36f99696-d7ca-4390-a263-dbb72d5c9ae6@intel.com>
Date: Fri, 16 Feb 2024 10:28:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v2 0/2] Fix PHY init timeout issues
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "huziji@marvell.com" <huziji@marvell.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240215161613.1736051-1-enachman@marvell.com>
 <CAPDyKFpNL_zFgzSNgaSRqaH8tDNjwB16ZD1YGwqM64vcQ2oxtA@mail.gmail.com>
 <BN9PR18MB4251FD4F9BD9915477823316DB4D2@BN9PR18MB4251.namprd18.prod.outlook.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <BN9PR18MB4251FD4F9BD9915477823316DB4D2@BN9PR18MB4251.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/24 19:01, Elad Nachman wrote:
> 
> 
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: Thursday, February 15, 2024 6:51 PM
>> To: Elad Nachman <enachman@marvell.com>
>> Cc: huziji@marvell.com; adrian.hunter@intel.com; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH v2 0/2] Fix PHY init timeout issues
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On Thu, 15 Feb 2024 at 17:16, Elad Nachman <enachman@marvell.com>
>> wrote:
>>>
>>> From: Elad Nachman <enachman@marvell.com>
>>>
>>> Fix PHY init timeout issues:
>>>
>>> 1. Clock Stability issue causing PHY timeout
>>>
>>> 2. Timeout taking longer than needed on AC5X.
>>>    Solve by constantly testing the PHY init bit
>>>    until it toggles, but up to 100X timeout factor.
>>>
>>> v2:
>>>     1) convert polling loop to read_poll_timeout()
>>>        for both patches.
>>>
>>> Elad Nachman (2):
>>>   mmc: xenon: fix PHY init clock stability
>>>   mmc: xenon: add timeout for PHY init complete
>>>
>>>  drivers/mmc/host/sdhci-xenon-phy.c | 48
>>> ++++++++++++++++++++++++------
>>>  1 file changed, 39 insertions(+), 9 deletions(-)
>>>
>>
>> The series looks good to me. Although, I assume we should tag this for stable
>> kernels too and possibly add a fixes tag?
> 
> No problem.

Presumably:

Fixes: 06c8b667ff5b ("mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC")

FWIW:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>>
>> Moreover, it would be nice to get an ack from Hu Ziji.
> 
> He does not longer work with Marvell, so this email is invalid, I tried also to send an e-mail manually as well and got:
> huziji@marvell.com
> Remote Server returned '550 5.1.1 RESOLVER.ADR.RecipNotFound; not found'
> 
> Could not locate him via google search either.
> 
>>
>> Kind regards
>> Uffe


