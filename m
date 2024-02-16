Return-Path: <linux-kernel+bounces-69043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF878583B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED18282383
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502A130E3D;
	Fri, 16 Feb 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5E1wsjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84647130E47;
	Fri, 16 Feb 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103479; cv=none; b=CZB0okVoIsWWdLVOCKSbn9QhouilMwGAswPyxbMDmZK+h62Wja2hP5rakm1yBZNHH/8zqi4CImJF85c4gUuk3UWGg+9P8KwwwU+Xgop5ZNhcfOggQvLtjOhYlka/PSygRpFixknWCBaym8pGiSgnVPKAWa+qndsxNLeKlbIe8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103479; c=relaxed/simple;
	bh=GSgTFwyNiagskDBs45s6/5y6DLVNsBfxyXq4czsO+Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cao3dQVpZniRWDRZJIyMlGMh6OtEpIjQD5VD907bjr6FaZv8/diduOoxglTrk7ucRQV3Oe9L59dmCt0H50zrrJ73Xv8dEaxZCUOJKHzDOeBYYqJA85gwHULagqVbD9SJUWkREKULYkPyqEkjSK0ELly6Vrpq2kly2W2Au6CgkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5E1wsjM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708103478; x=1739639478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSgTFwyNiagskDBs45s6/5y6DLVNsBfxyXq4czsO+Gc=;
  b=H5E1wsjMOb56EGfH3a1Yc2JhVMBipIJzvA44JXFtg2XbfP5kpm2/ZsuS
   F/Ei/XIEnPbzyhB/tQs6qZUsP3126M56C9YFkdnkDhoYl+tHbGfrQsIv+
   hT+MEDlYYrqEqdJY4VkWVeSv4mZuXRoNAGGx4ehut+hEz2PxTbH1HbhkB
   5nNdG0PIOrD3dxzNHSipy2kOqGQYG6q62Rhc8aya8GBDUO/Vu9Q0eBt1q
   S2DS9O0zMCp0qa9vo61bWWUn5W0F08XSkf4coQx3AC3n7i8k4zn4Ss7E0
   /m38w/oxHJvrPPtxmSkmGzGII2NdDgPsKkea19DvOQ9660bwl1eslUjR+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6065592"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6065592"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8578683"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:11:14 -0800
Message-ID: <d1247dbd-0672-443b-9719-3d6d52833c37@intel.com>
Date: Fri, 16 Feb 2024 19:11:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mmc: sdhci_am654: Update comments in
 sdhci_am654_set_clock
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-6-jm@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240207011520.3128382-6-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/02/24 03:15, Judith Mendez wrote:
> The sdhci_am654_set_clock function is also used to enable
> delay chain, therefore fix comments to be more generic in
> case we are not enabling DLL.
> 
> Fixes: fe52e2fbc6ef ("mmc: sdhci_am654: Fix conditions for enabling dll")

Similar to patch 4, Fixes tag is probably not warranted.

> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 35ba7d921690..3755a015f328 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -279,7 +279,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	sdhci_set_clock(host, clock);
>  
> -	/* Setup DLL Output TAP delay */
> +	/* Setup Output TAP delay */
>  	otap_del_sel = sdhci_am654->otap_del_sel[timing];
>  
>  	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> @@ -322,7 +322,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	u32 itap_del_ena;
>  	u32 mask, val;
>  
> -	/* Setup DLL Output TAP delay */
> +	/* Setup Output TAP delay */
>  	otap_del_sel = sdhci_am654->otap_del_sel[timing];
>  
>  	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;


