Return-Path: <linux-kernel+bounces-58053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EA84E0A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8703C1F23697
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0E73164;
	Thu,  8 Feb 2024 12:29:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF071B42
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395354; cv=none; b=up/U4HAgHBr0DeIoJrQfwpA9/M9vISEFSPOW5YpORTpBR9XD2OU/o08KOFetcen7sz7Zvk+sih6NVGtfI7T63mBf2slreVbEQyklNvZ2euq88K49i73yk0sq+O50lGIjS/suLAeRiJTWGALCMadulUKkTRn3IKu0DIgBvrsn28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395354; c=relaxed/simple;
	bh=/T5gwMhLhg9+ijzK45R5rq+3HpzHEmkJtwlkUz9BCFc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5Y4CGDOY7w38EmDekJwBubQQUWg6z5MzRfDeNiVMvq+d52QcWSf3LdT2QQzWbk9bGtk5Fr2lagk33T4GDpCXWt3Pto2GEscpWRdCaz+TYFV+0t6S6GaARO73cSMsAl+IZgzZAJdhUA2Dz0nhHjrVVSLRmsSm6WRS3o0H4nT07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVx614rwNz6K98T;
	Thu,  8 Feb 2024 20:25:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A3D611400D9;
	Thu,  8 Feb 2024 20:29:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:29:03 +0000
Date: Thu, 8 Feb 2024 12:29:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 4/7] drivers/perf: hisi_pcie: Check the target filter
 properly
Message-ID: <20240208122902.0000768f@Huawei.com>
In-Reply-To: <20240204074527.47110-5-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
	<20240204074527.47110-5-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Feb 2024 15:45:24 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> The PMU can monitor traffic of certain target Root Port or downstream
> target Endpoint. User can specify the target filter by the "port" or
> "bdf" option respectively. The PMU can only monitor the Root Port or
> Endpoint on the same PCIe core so the value of "port" or "bdf" should
> be valid and will be checked by the driver.
> 
> Currently at least and only one of "port" and "bdf" option must be set.
> If "port" filter is not set or is set explicitly to zero (default),
> driver will regard the user specifies a "bdf" option since "port" option
> is a bitmask of the target Root Ports and zero is not a valid
> value.
> 
> If user not explicitly set "port" or "bdf" filter, the driver uses "bdf"
> default value (zero) to set target filter, but driver will skip the
> check of bdf=0, although it's a valid value (meaning 0000:000:00.0).
> Then the user just gets zero.
> 
> Therefore, we need to check if both "port" and "bdf" are invalid, then
> return failure and report warning.
> 
> Testing:
> before the patch:
>                    0      hisi_pcie0_core1/rx_mrd_flux/
>                    0      hisi_pcie0_core1/rx_mrd_flux,port=0/
>               24,124      hisi_pcie0_core1/rx_mrd_flux,port=1/
>                    0      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/

Nice to include an example that works for bdf
			    hisi_pcie0_core1/rx_mrd_flux,bdf=1,port=0 
or something like that?
> 
> after the patch:
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0/
>               24,153      hisi_pcie0_core1/rx_mrd_flux,port=1/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Clearly the current situation is wrong, but perhaps we can
have a more intuitive scheme (could be added as a follow up patch)
and have the driver figure out which port the bdf lies below?

Maybe that's a job for userspace tooling rather than the driver, but
the driver already has verification code and it wouldn't be hard
to not just check the rp is ours, but also set the filter to specify
that rp, or maybe just set the mask to include them all?

Jonathan


> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 83be3390686c..b91f03c02c57 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -306,10 +306,10 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
>  	if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
>  		return false;
>  
> -	if (requester_id) {
> -		if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
> -			return false;
> -	}
> +	/* Need to explicitly set filter of "port" or "bdf" */
> +	if (!hisi_pcie_get_port(event) &&
> +	    !hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
> +		return false;
>  
>  	return true;
>  }


