Return-Path: <linux-kernel+bounces-160314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1478B3BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DAA287ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC777149C44;
	Fri, 26 Apr 2024 15:40:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9918C1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146030; cv=none; b=Wt4SYbfdEk5NnYNxiiyrIEpwBWQxags5f10rt8xmStgL5arTkVjU2a6utHARAdakRmMQ6OvKGXsHrJgt0yDVSOjjwrNHCkSZxTlO80YF1klQxtCC+2mIFmXxq+dUtwSrWvGPdHJPVAUNiG7V21BzB4X7Xtd1mnibI+BXr1j2UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146030; c=relaxed/simple;
	bh=+j5dYm4zOwVyCAzMEhO4zgKNYoBBQrAEMaiytKgHRFw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOPLskHdmcScrohS6SApzvbzxTpV40cQ6+1EyYrxYOnD9HW43GrDaf5JXSgxvwhLstxOelPN2ZHnRFgsGmatxyooJJSMe4SHKQhm+4kKrFKaZmXQpVN5pPdWF+5UIPKauvIuEX3M+GWSl/IEJB+zLMw4bQNqH7wSCDLlB+ZecGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQxgk38drz6F97p;
	Fri, 26 Apr 2024 23:37:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48CF1140A36;
	Fri, 26 Apr 2024 23:40:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 16:40:22 +0100
Date: Fri, 26 Apr 2024 16:40:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Junhao He <hejunhao3@huawei.com>
CC: <will@kernel.org>, <yangyicong@huawei.com>, <shaojijie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <chenhao418@huawei.com>
Subject: Re: [PATCH 1/3] drivers/perf: hisi_pcie: Fix out-of-bound access
 when valid event group
Message-ID: <20240426164021.00006f4c@Huawei.com>
In-Reply-To: <20240425124627.13764-2-hejunhao3@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
	<20240425124627.13764-2-hejunhao3@huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 20:46:25 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> The perf tool allows users to create event groups through following
> cmd [1], but the driver does not check whether the array index is out of
> bounds when writing data to the event_group array. If the number of events
> in an event_group is greater than HISI_PCIE_MAX_COUNTERS, the memory write
> overflow of event_group array occurs.
> 
> Add array index check to fix the possible array out of bounds violation,
> and return directly when write new events are written to array bounds.
> 
> There are 9 different events in an event_group.
> [1] perf stat -e '{pmu/event1/, ... ,pmu/event9/}'
> 
> Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 5d1f0e9fdb08..dba399125658 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -350,15 +350,27 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
>  			return false;
>  
>  		for (num = 0; num < counters; num++) {
> +			/*
> +			 * If we find a related event, then it's a valid group
> +			 * since we don't need to allocate a new counter for it.
> +			 */
>  			if (hisi_pcie_pmu_cmp_event(event_group[num], sibling))
>  				break;
>  		}
>  
> +		/*
> +		 * Otherwise it's a new event but if there's no available counter,
> +		 * fail the check since we cannot schedule all the events in
> +		 * the group simultaneously.
> +		 */
> +		if (num == HISI_PCIE_MAX_COUNTERS)
> +			return false;
> +
>  		if (num == counters)
>  			event_group[counters++] = sibling;
>  	}
>  
> -	return counters <= HISI_PCIE_MAX_COUNTERS;
> +	return true;
>  }
>  
>  static int hisi_pcie_pmu_event_init(struct perf_event *event)


