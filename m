Return-Path: <linux-kernel+bounces-81775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EF8679FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EFD1C28546
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111EA12FB0B;
	Mon, 26 Feb 2024 15:14:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92E12F5B7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960488; cv=none; b=E4JnkeRfx/oNadq9osdvXEiQ+ogj8Pau7AkFSNXGHBD+7aa2dN48IL0G0K5SOrh6lQFgSpNgiVsfchbprfj7HnU0UehHRFul6x9yvXwCVb2Dy3266VcE/x/BphttQuoQNSNb2rGqQefAjK4n0HBQuwLJhGn42LEa8PFOREjFboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960488; c=relaxed/simple;
	bh=DEayiuRzdhUcz3LRQm/YN+9uHbsskirhIQEUIfOJ5xg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFra82D3X8oAAc1GLAZbkL8lWeTs6KXKTAGq9aKbUvdBRmeuT8st6Qs/MlIa3RptZUdCdxjAh6gHCmGbz2i9E+LlakNRF/06sfBLogOGRnT2rM2Pg1VoW3KXKDxWBW0LHUEvAjoGUwj/hXcX40a9PtM95FeWVot/gRRzjoC9SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk3vh6zfXz6K6jq;
	Mon, 26 Feb 2024 23:10:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D97E7140CB9;
	Mon, 26 Feb 2024 23:14:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:14:43 +0000
Date: Mon, 26 Feb 2024 15:14:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 5/8] drivers/perf: hisi_pcie: Check the target filter
 properly
Message-ID: <20240226151442.000053ad@Huawei.com>
In-Reply-To: <20240223103359.18669-6-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-6-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 18:33:56 +0800
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
>                    0      hisi_pcie0_core1/rx_mrd_flux,port=0x800/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
>               24,132      hisi_pcie0_core1/rx_mrd_flux,bdf=0x1700/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x0/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1/
>               24,138      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1700/
>               24,126      hisi_pcie0_core1/rx_mrd_flux,port=0x1,bdf=0x0/
> 
> after the patch:
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0/
>               24,153      hisi_pcie0_core1/rx_mrd_flux,port=1/
>                    0      hisi_pcie0_core1/rx_mrd_flux,port=0x800/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
>               24,117      hisi_pcie0_core1/rx_mrd_flux,bdf=0x1700/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x0/
>      <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1/
>               24,120      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1700/
>               24,123      hisi_pcie0_core1/rx_mrd_flux,port=0x1,bdf=0x0/
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Thanks for explanation on v1. I'm fine with this now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 6f39cb82661e..b2dde7559639 100644
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


