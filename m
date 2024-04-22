Return-Path: <linux-kernel+bounces-153225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34A8ACB23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE42829FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AE145FE8;
	Mon, 22 Apr 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLTRTpWe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E31448E5;
	Mon, 22 Apr 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782684; cv=none; b=Gjsr/5xPgfBP4CgZ83QpuyiYE5ZJdsBuGIvT+PKSIl2Fnd7QlP9mPfaXIh6UvV4b0fxDnsPo3i/WllbksKkjQ7MauZ9xrKCueI8nxv0NlkY/UTtKBwP0r2EpLRfK8lYltYd8/PCLRJ3qZaS88yPwedK+2y/+++q/x2Up0tvy8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782684; c=relaxed/simple;
	bh=des0NWLn+6FveNqXXCBGPPrBjU5248e4NUzNOpnlZA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p9WWPSzvp8iLkFDdoI9WZA0qB2Ydr83hB6xlhWyxvgwWdGXPzx6RkzVEkWY+ZONTHX0e4BAT83Z0N4rY6FuLfuRlt4lV5yn/xZW7Nr9sUXM3Fbp+XaH4JBJwCSbh9AXU0pvWK9OGkIrtZ7eZ43QDLJAHytSQFPvGOpElfS0U2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLTRTpWe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713782682; x=1745318682;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=des0NWLn+6FveNqXXCBGPPrBjU5248e4NUzNOpnlZA4=;
  b=nLTRTpWenFVeKLTeXu3Ak6Az/CeJESxib95rSSnSf55s8lv2bZsEfrYf
   bbN/tZA6tb1Phvjj5itrIgFC4hS4oPc4DvBXsaB2MoKkx9WTfTO2jJx7E
   v0hvgtiX49ZMptyJ+NRTkKxxz9WefEdMiippntgsUYUiBQz89azWhozTm
   GO+ojKcMbzjb9lsnPHZXeqoD7N7rtf8KLIbveL6heCoXwe11+2IWlY0AM
   0bBHGps4bkvU+Km+enStAZ1DXCRdS0QiH2dCcmH6Tia2TsamN2qgKy3zi
   mHG1wU0NPhKshgOd3oZDDd+sPAcahxCSgGSrIEXYU1BmdEgOY+57kTZ5+
   Q==;
X-CSE-ConnectionGUID: R1BoQzNbQsKsEjzi7qtRSA==
X-CSE-MsgGUID: RjJ+dXwSTTev91ATTIg01A==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="31805099"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="31805099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 03:44:42 -0700
X-CSE-ConnectionGUID: tIgN3klHTU+sqNk5aVOrkw==
X-CSE-MsgGUID: hxbLBlsATFC8Q6tiDAT3ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24491113"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.217.50])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 03:44:38 -0700
Message-ID: <d39ab4b9-ad43-4d4a-9fc6-3133d761c79b@intel.com>
Date: Mon, 22 Apr 2024 13:44:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] mmc: sdhci-of-dwcmshc: enhance framework
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com
References: <cover.1713257181.git.unicorn_wang@outlook.com>
 <MA0P287MB28226B9C954F3DBD9B5E29A5FE122@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <MA0P287MB28226B9C954F3DBD9B5E29A5FE122@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/04/24 12:01, Chen Wang wrote:
> hi， any comments on this patch?
> 
> Another patch [1] has dependency on this one, so I would hope someone can review and comment this one first, thanks.

Does not apply.  Please re-base on mmc 'next' branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

> 
> Link：https://lore.kernel.org/linux-riscv/cover.1713258948.git.unicorn_wang@outlook.com/ [1]
> 
> On 2024/4/16 17:43, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
>> existing driver code could be optimized to facilitate expansion for
>> the new soc.
>>
>> Thanks,
>> Chen
>>
>> ---
>>
>> Chen Wang (1):
>>    mmc: sdhci-of-dwcmshc: add callback framework for expansion
>>
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 185 ++++++++++++++++------------
>>   1 file changed, 107 insertions(+), 78 deletions(-)
>>
>>
>> base-commit: 4cece764965020c22cff7665b18a012006359095


