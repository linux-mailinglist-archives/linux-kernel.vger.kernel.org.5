Return-Path: <linux-kernel+bounces-69034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38D858399
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF901C23698
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3C132C3C;
	Fri, 16 Feb 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0ZI5t28"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F913246E;
	Fri, 16 Feb 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103392; cv=none; b=e4y8AvKtA9PezyWoBi7jrWoR59OV+7xCOXR/6BLCjHqELUy9C8XfdhIn33o/ekMGWfk3kv8Fu6ZgKIvy9yJmSmz875HbCURaz8jQci14NjrR4jee6Y6sXDKHPoEZdU6fh1NZYjVXklLNFiWH+eFKqzYKkUoRS8xkY+daprMeXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103392; c=relaxed/simple;
	bh=NFtIKJgXUhcNHMnobwGwF72UKNXBeAQlrFHdq+8dpbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqXn+j2uezz0nazpDvVOhB+0//0+XbfFhyvYo9fjaAnEM7SCSsQ/jrk6k3sVzG8sorOzqB/v4GcTccN8sRgDpL+NWzdZUzAF+cW2AHTUBpo56GHo50s54Q1S3aDXcWFk7t7Uq6yvKS57yq1p7sUN5wxdH/yojsbR96wtrnF7ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0ZI5t28; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708103391; x=1739639391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NFtIKJgXUhcNHMnobwGwF72UKNXBeAQlrFHdq+8dpbc=;
  b=B0ZI5t28CmDG0yMtzLn4qNB9nZjAcFCAXQyFTGQqlSaheYEa8XciXXNr
   Izz5VBMoph++AxIyT5EydqkrEFbYY71yCYvCTPNsBBwq7mdSL/Q2FVJx0
   ICLzZ0ceTOM3QsIzl7Kg3S7Z0t9nWuXNf4tNGJE5GNgqB8AFfNsMsr22Q
   U/83VLZdPdtf4uFCtnrunhxXa4dyYeH/UQKMV12mhXifOhlVekzZEUoyP
   ljgAMLrUY6FsOBzAGeMzZZhKw/bMiEKP31EhKoAZYiTVzLibzLqD8RUjN
   zNxW1z8mRk4u8bWn07NZi4HCeZrIsW9RbVggNGbzJAOxRDzt4P6XiFZuO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6065379"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6065379"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8578414"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:09:47 -0800
Message-ID: <82463a28-822b-4612-aed5-1be21c13acf4@intel.com>
Date: Fri, 16 Feb 2024 19:09:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240207011520.3128382-3-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/02/24 03:15, Judith Mendez wrote:
> For DDR52 timing, DLL is enabled but tuning is not carried
> out, therefore the ITAPDLY value in PHY CTRL 4 register is
> not correct. Fix this by writing ITAPDLY after enabling DLL.
> 
> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")

Note that the Fixes tags make a different ordering
than the patch order i.e.

Patch	Fixes		in version
1 	13ebeae68ac9 	v5.10-rc1
2 	a161c45f2979 	v5.7-rc1
3 	8ee5fc0e0b3b 	v5.7-rc1
4 	8ee5fc0e0b3b 	v5.7-rc1
4 	a0a62497f6aa 	v5.10-rc1
5 	fe52e2fbc6ef 	v5.9-rc1
6 	1accbced1c32 	v5.3-rc1
7 	a161c45f2979 	v5.7-rc1

That might make backporting these patches more challenging.

> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changelog:
> v1->v2:
> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>  instead of sdhci_am654_setup_dll()
> ---
>  drivers/mmc/host/sdhci_am654.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 2c66a965c225..b50db5d4a452 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>  		sdhci_am654_setup_dll(host, clock);
> +		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>  		sdhci_am654->dll_enable = true;
>  	} else {
>  		sdhci_am654_setup_delay_chain(sdhci_am654, timing);


