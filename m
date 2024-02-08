Return-Path: <linux-kernel+bounces-58069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C850684E0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A041F23570
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931776045;
	Thu,  8 Feb 2024 12:39:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3176028
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395994; cv=none; b=PJrvxSqjC2jbk5c8cJJK2IeOVPbcCSGsKVTofm4Ho1wWbVgXFpIkhzPj6jgDu+jBQEf+oYULTMVWLEvKmYti7s+OvCSGTFDasBwI3YCzwSJCqqirUpeK+1M4pSOcOe3HAu7cL7WFhA4sl+ChDPqOrpOvG0hFxquZyc5754H5Hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395994; c=relaxed/simple;
	bh=0hbCarOtP5u95JGe8C90Cgaf3YAyJNnkarhl9gvl9NE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4I90tOAHJ/GoEqgYfhcG8ct/O+y2Gb4xLhAz/rmMocPOY1ioWLWddzxwUYT3RLyCCMji14rZYakj4wK27yF5DWYlBjM1YiPR9rvUQieLN6f/LNISgRpbuHnCiJ8eHsk+VZKrAPFVAPYKzrxr4ecXqygsCda4V5zp6qib/3pYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVxLL487Tz6K5pX;
	Thu,  8 Feb 2024 20:36:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29D9E140D1A;
	Thu,  8 Feb 2024 20:39:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:39:47 +0000
Date: Thu, 8 Feb 2024 12:39:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 6/7] drivers/perf: hisi_pcie: Merge find_related_event()
 and get_event_idx()
Message-ID: <20240208123946.00006618@Huawei.com>
In-Reply-To: <20240204074527.47110-7-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
	<20240204074527.47110-7-yangyicong@huawei.com>
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

On Sun, 4 Feb 2024 15:45:26 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> The function xxx_find_related_event() scan all working events to find
> related events. During this process, we also can find the idle counters.
> If not found related events, return the first idle counter to simplify
> the code.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

A suggestion inline to avoid the magic HISI_PCIE_MAX_COUNTER value
being used outside of the function. 

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 55 ++++++++++----------------
>  1 file changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 1b45aeb82859..2edde66675e7 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -397,16 +397,24 @@ static u64 hisi_pcie_pmu_read_counter(struct perf_event *event)
>  	return hisi_pcie_pmu_readq(pcie_pmu, event->hw.event_base, idx);
>  }
>  
> -static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
> -					    struct perf_event *event)
> +/*
> + * Check all work events, if a relevant event is found then we return it
> + * first, otherwise return the first idle counter (need to reset).
> + */
> +static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu,
> +					struct perf_event *event)
>  {
> +	int first_idle = HISI_PCIE_MAX_COUNTERS;
	int first_idle = -EAGAIN;
>  	struct perf_event *sibling;
>  	int idx;
>  
>  	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
>  		sibling = pcie_pmu->hw_events[idx];
> -		if (!sibling)
> +		if (!sibling) {
> +			if (first_idle == HISI_PCIE_MAX_COUNTERS)
if (first_idle == -EAGAIN)

> +				first_idle = idx;
>  			continue;
> +		}
>  
>  		/* Related events must be used in group */
>  		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
> @@ -414,19 +422,7 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
>  			return idx;
>  	}
>  
> -	return idx;
> -}
> -
> -static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
> -{
> -	int idx;
> -
> -	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
> -		if (!pcie_pmu->hw_events[idx])
> -			return idx;
> -	}
> -
> -	return -EINVAL;
> +	return first_idle;
Then this will return -EAGAIN;
>  }
>  
>  static void hisi_pcie_pmu_event_update(struct perf_event *event)
> @@ -552,27 +548,18 @@ static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
>  
>  	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>  
> -	/* Check all working events to find a related event. */
> -	idx = hisi_pcie_pmu_find_related_event(pcie_pmu, event);
> -	if (idx < 0)
> -		return idx;
> -
> -	/* Current event shares an enabled counter with the related event */
> -	if (idx < HISI_PCIE_MAX_COUNTERS) {
> -		hwc->idx = idx;
> -		goto start_count;
> -	}
> -
> -	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
> -	if (idx < 0)
> -		return idx;
> +	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu, event);
> +	if (idx == HISI_PCIE_MAX_COUNTERS)
> +		return -EAGAIN;

Perhaps simpler to handle first_idle == HISI_PCIE_MAX_COUNTERS as
an error return in hisi_pcie_pmu_get_event_idx - see above.

 	if (idx < 0)
		return idx;


>  
>  	hwc->idx = idx;
> -	pcie_pmu->hw_events[idx] = event;
> -	/* Reset Counter to avoid previous statistic interference. */
> -	hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
>  
> -start_count:
> +	/* No enabled counter found with related event, reset it */
> +	if (!pcie_pmu->hw_events[idx]) {
> +		hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
> +		pcie_pmu->hw_events[idx] = event;
> +	}
> +
>  	if (flags & PERF_EF_START)
>  		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
>  


