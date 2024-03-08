Return-Path: <linux-kernel+bounces-96790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F2876182
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E75A1F23235
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D553E02;
	Fri,  8 Mar 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I56ql9kM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566E2CCB3;
	Fri,  8 Mar 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892446; cv=none; b=ffLZgiPZ6OmkSTgOrOIR+DS7OuYLRiP6zteVsAgpbuCEkIbMGuZG/hNc95fqms6ICVsHVlqKHJAFwrzlQY8guXX+y6IdHhOPijVLuHylPcY2c1vb4wdSdG/D2IPPx2lwl/mO1o5ffiw9aBQ0HMKuVwXmgEmOpwlkIcys50cSbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892446; c=relaxed/simple;
	bh=V1BBMS6T0U4ls/Hu0yrD/F2rxen773TYR60p6qa01+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaoGOQiwsDVNiGQ0YN+cbEy/O3dQTo+0hEwjIaquxWntZhaD0JlpuqOEbN2YMiJu5X6GmCZahqA1A9EDNTFXaqQkQtVfHg9UZPwAxR2oANyb83Qr7cU90EBqh9oFUoXcytOmOR5M6TerM15Ca7UnYIxOI1G1FxFzYgFCjkzI0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I56ql9kM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709892444; x=1741428444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1BBMS6T0U4ls/Hu0yrD/F2rxen773TYR60p6qa01+I=;
  b=I56ql9kMzl+jKvVSCOfv3QTtl4+CTN57FpO/IEXdJcLzw5L9NjrDkumA
   1ODY0rNvvG4vGeq+VJTqTitfNzWM1xplcWw8abKpzietYw53L5elXYl2e
   yImAbTMWtCVii6AjKsMbZrJVIPNS2DURuARw+YRWNvgdo32OjYV3jG5Jd
   JJj34FC3nZ2ZdQEPEjj+A3ws6FXSJF7iJCNuGrhivId0zLRLOqcnk/jI4
   Yoy/qyLBNCtk9k7k6NoPXGGU3mrGDi1NIDG1oTwaqGraPjVwEFw3KrSah
   INjim8ZBtxKIP43uoQ38aROeia+Cb998PppdtHlEKE+LlyxFLbpBbkPJu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15747564"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15747564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15087025"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.63])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:07:21 -0800
Message-ID: <0522aa51-6141-4fd2-b312-f89b0f58d5d7@intel.com>
Date: Fri, 8 Mar 2024 12:07:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-s3c: Replace deprecated
 of_get_named_gpio()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
References: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/03/24 14:19, Andy Shevchenko wrote:
> It seems the of_get_named_gpio() is solely used to check
> if the GPIO is present in DT as the function can return 0
> if and only if it's present and it becomes in the global
> number space 0. But this quite likely shows that the code
> wasn't ever been tested on the systems when no GPIO is provided.
> In any case, the proper test is just to call of_property_present()
> without any attempts in requesting GPIO (as we haven't saved the
> number or descriptor anywhere in the code).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks to me like pdata->cd_type is zero either way, so it makes no
difference, unless of_get_named_gpio() has some side-effects.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-s3c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0e8a8ac14e56..6493b0edba34 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -17,10 +17,8 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -446,7 +444,7 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>  		return 0;
>  	}
>  
> -	if (of_get_named_gpio(node, "cd-gpios", 0))
> +	if (of_property_present(node, "cd-gpios"))
>  		return 0;
>  
>  	/* assuming internal card detect that will be configured by pinctrl */


