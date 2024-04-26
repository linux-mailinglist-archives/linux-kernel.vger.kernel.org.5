Return-Path: <linux-kernel+bounces-159858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4A8B3530
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE097B23ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833514388F;
	Fri, 26 Apr 2024 10:19:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339713F44F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126751; cv=none; b=LRVNalUlfikSTBzp+PcVBg8CNnUWg06qrMV7pZK/Xbqdt7bLeNqIJUBtwzp+Ue2KM2wBvgdcLYPf6tBoxZAL8pbKe9/rNbqmDhkMj/2PA213W/mbtGZ33KixTPrRrcNHmkwhuf/nnz+xABoASmn1e/RiqQi9xFWv3qUrDPi79fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126751; c=relaxed/simple;
	bh=PvlqjU87/D+2kbb2605lAsy6oLHguWugqQjh+UKPNnQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uoKv9VbIMQElX1mt97tTLxccmTwfaTeY1PBBgYx9tw4fcaSTWLFuNBldmO6BFFjSUOfHf85sdAEsGBuzEXc90ZE3+uByB+9eQpcMiNKcxKgBt810nJnhf4fIkUKi0ceQR4usJ/dU+mVhttFgWqgj1CqVr/C9wZy4Gn5gnmc1h10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQpZf0pp7zcZxR;
	Fri, 26 Apr 2024 18:18:02 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ABDA180073;
	Fri, 26 Apr 2024 18:19:07 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:19:06 +0800
Message-ID: <b53fd5c9-616f-4fab-a667-0deb64edd11b@huawei.com>
Date: Fri, 26 Apr 2024 18:19:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <chenhao418@huawei.com>
Subject: Re: [PATCH 2/3] drivers/perf: hisi: hns3: Fix out-of-bound access
 when valid event group
To: Junhao He <hejunhao3@huawei.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
 <20240425124627.13764-3-hejunhao3@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240425124627.13764-3-hejunhao3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/4/25 20:46, Junhao He wrote:
> The perf tool allows users to create event groups through following
> cmd [1], but the driver does not check whether the array index is out
> of bounds when writing data to the event_group array. If the number of
> events in an event_group is greater than HNS3_PMU_MAX_HW_EVENTS, the
> memory write overflow of event_group array occurs.
>
> Add array index check to fix the possible array out of bounds violation,
> and return directly when write new events are written to array bounds.
>
> There are 9 different events in an event_group.
> [1] perf stat -e '{pmu/event1/, ... ,pmu/event9/}
>
> Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> ---
>   drivers/perf/hisilicon/hns3_pmu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index 16869bf5bf4c..cbdd53b0a034 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -1085,15 +1085,27 @@ static bool hns3_pmu_validate_event_group(struct perf_event *event)
>   			return false;
>   
>   		for (num = 0; num < counters; num++) {
> +			/*
> +			 * If we find a related event, then it's a valid group
> +			 * since we don't need to allocate a new counter for it.
> +			 */
>   			if (hns3_pmu_cmp_event(event_group[num], sibling))
>   				break;
>   		}
>   
> +		/*
> +		 * Otherwise it's a new event but if there's no available counter,
> +		 * fail the check since we cannot schedule all the events in
> +		 * the group simultaneously.
> +		 */
> +		if (num == HNS3_PMU_MAX_HW_EVENTS)
> +			return false;
> +
>   		if (num == counters)
>   			event_group[counters++] = sibling;
>   	}
>   
> -	return counters <= HNS3_PMU_MAX_HW_EVENTS;
> +	return true;
>   }
>   
>   static u32 hns3_pmu_get_filter_condition(struct perf_event *event)

