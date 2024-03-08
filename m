Return-Path: <linux-kernel+bounces-96692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D167187600D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A11F25E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670841C61;
	Fri,  8 Mar 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga+YW3FZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E07225CF;
	Fri,  8 Mar 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887643; cv=none; b=cVkSzRxWVtnxwEtSAK5PZAK17QzvMVij8LY4dPAblEaeYCAQ8kpwOiA9GO48EHSZ1FO7EmieKKsEbSV2CWBVkIsXijbDZhCDm90V56J5Nm40aYR7uaJ70UvAEQZYOGe2q9Ic5mVXepK5uVIiO9OWDvusBn5Qe67ent9lPcYKyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887643; c=relaxed/simple;
	bh=aeb8PZlUw50cJ5aX9INdjSxk1w+NVxoIBAWF8tbcDro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtBFhxmyjxjFwpXjIxBDKonlXoMGrnb5vGxmaOhu2mWnaWtx2aA8GJQhgRUfIvNHkpYbnb5RRu7zN2jt0bLYQeDs0DSyCGM/m2oOEJJW/jSKMFCuSmhCTIfv1gFoVxG8r0UPxCJLfhQDsUrlBH3UsHuKPKYlzDgvgHfkAATacCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga+YW3FZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709887642; x=1741423642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aeb8PZlUw50cJ5aX9INdjSxk1w+NVxoIBAWF8tbcDro=;
  b=Ga+YW3FZVVdwkcOPbNB8KcG563Dh63FFXvkinx6V8bZN1RLtb89ijNsa
   GnmqH+Kai+ztSkK2WMiWHKlCKoJUJKh9BVeuf3ZdFFD0vHBNmBWD4f3k+
   9GsMrQ64eUrfQmA2gDJSFdcxtH2aKQZnnkRyJuGBPT00odygso4VATLbI
   kdmWkbtY54+i9PLWQrsDHcR3uGcAA0pJvm2y3piAMECbct67mrjt8LFkS
   18vInUwiuEyWfoS4/wlJgx+JkDi5JW4+yAaBRpqEQ2Cj/p5TnVIQScaSV
   BNNLLsKOSAiiXbMoLt4lomOkqcYWER9C91P6CcnX4gr9miEnTr9xZrvHM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15166236"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15166236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="14887455"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.63])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:47:19 -0800
Message-ID: <1aa03185-126e-4984-b9d9-79c355945160@intel.com>
Date: Fri, 8 Mar 2024 10:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-sprd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Wenchao Chen
 <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/03/24 13:45, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bed57a1c64b5..685b1c648901 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -13,7 +13,6 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>


