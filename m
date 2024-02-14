Return-Path: <linux-kernel+bounces-65230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D608549C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57B11F279E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331752F94;
	Wed, 14 Feb 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP0fB7+5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42B524DE;
	Wed, 14 Feb 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915315; cv=none; b=SSLkrxwi0Q/hgYqKQNgnMpFehv54Of+LTRi2kB9wqd7kWot+QljGUEOLZf5oKfQhcBl7AQUfyUvzkOAIevzITZzEPCEkf8Xi6xpJ/GGPZ7v9zwEKVxD6Zp0P0plI9lMNYrGr9CnjWUqF5jDbvbX1vyvC7Pk9AvDk/To8Tykf9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915315; c=relaxed/simple;
	bh=iDdbWiwEPcFY3BALcgE9v1lv2ENjOuGM5iSt5eVJd/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNcy2QO3c/5drQnZKd3v2G6uHf2BFRhIIVPFBFZXyzaoz1aKHjz6UrZI4PF8y/T84YDRp2sQFog197TbcWRvckXR94OXcS4YEIBd65HwwSGhAFsN/C3bmtCC57atw8mCtDF/9QBIft7NEQ1D02rwl95XHIUG8SpAG/yd2mvAQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP0fB7+5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915314; x=1739451314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDdbWiwEPcFY3BALcgE9v1lv2ENjOuGM5iSt5eVJd/k=;
  b=LP0fB7+5STmDVuM77dP2GjjnjQGjDKpxnWkkSZgbPsIPlljWChnlgkyO
   TKpQnuW0LH1RFpOY4whbGKdjUVOJiPRBYy87daJ+jq2H1c+PYFnphzA8o
   q5sqkkAYt6KkK3qw2SNrE5c8JgG/1EmylmE4U0xCrRdRxMnxhQEoy5krb
   3HVKKJ8pSD9YUw3uQL2/Rh/z8jA2Sz1t+NViOEtcO/hEU8224PKyFz67o
   +r16D+hKdJIqRE6L6lBssgfhybVf2DBHZD86rUV+XAb40Q9V0o/+ElDjR
   /Blj/vgksE1z4M06Qz22Ox+QcH710kUp6ja0v+tSbDMLiuVBcQouEFg0l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24428263"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="24428263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3245478"
Received: from jhogande-desk.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orviesa010.jf.intel.com with ESMTP; 14 Feb 2024 04:55:11 -0800
Message-ID: <8a580aad-001c-4e88-8f56-271f1835e581@linux.intel.com>
Date: Wed, 14 Feb 2024 14:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] DesignWare PWM improvements
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, u.kleine-koenig@pengutronix.de,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212130247.9985-1-raag.jadav@intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240212130247.9985-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 15:02, Raag Jadav wrote:
> This series implements 16 channel PWM support for Intel Elkhart Lake
> along with minor cleanups for DesignWare PWM driver.
> 
> Changes since v2:
> - Remove error code duplication from dev_err_probe()
> - Update tags
> 
> Changes since v1:
> - Drop redundant error check
> - Provide dwc_pwm_init_one() to initialize one PWM instance
> - Use dev_get_drvdata() instead of pci_get_drvdata()
> - Use pm_sleep_ptr() instead of use pm_ptr()
> 
> Raag Jadav (5):
>    pwm: dwc: use pm_sleep_ptr() macro
>    pwm: dwc: drop redundant error check
>    pwm: dwc: Add 16 channel support for Intel Elkhart Lake
>    pwm: dwc: simplify error handling
>    pwm: dwc: access driver_data using dev_get_drvdata()
> 
>   drivers/pwm/pwm-dwc.c | 59 ++++++++++++++++++++++++-------------------
>   drivers/pwm/pwm-dwc.h |  5 ++++
>   2 files changed, 38 insertions(+), 26 deletions(-)
> 
I tested on Elkhart lake this patchset and it adds another 8 channel PWM 
instance and the PCI device continue switching between D0 and D3 power 
states depending is some channel enabled or all idle.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>


