Return-Path: <linux-kernel+bounces-75814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8F85EF61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9754B23468
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DB14F75;
	Thu, 22 Feb 2024 03:00:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612D14296
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570849; cv=none; b=H8KPVf94/dLFcCvPPt69LvJoL0RJGVy4LMjo5Xv7AlmtlaAa0AG1xG6iVmdIYxC8YN2NaZhxXug6R2OLxHVV7xInrYiY+B6dadW0iCBHzi3T0fWC1scFKQVUSzu3DjVFugciFPrYU5xBSDZ1sA5/DLO3Um02EPY3map+3UfS+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570849; c=relaxed/simple;
	bh=616jFScVP4GMXLqtmGKWYqcPAkBoWZIGY0vG7QqeQHA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bj7sARcOWsayK1X5FvIaRQ91hBO5M51Ii1nB977wUVOhOq1IF1QaSN9mTA4+K1HrylSc8WzF6xfwST540GW3JYZLOPQ8UlE8Ot/d0JUHJ+7oxSzSeLQMzZsV0nKed2I3b5DGWf/lHZ/vI5jWku75KTopb/YwS+g13ueM9GS6cY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TgHsh43HmzWv1j;
	Thu, 22 Feb 2024 10:59:04 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 07A5618005D;
	Thu, 22 Feb 2024 11:00:45 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:00:44 +0800
Subject: Re: Re: [PATCH 6/7] drivers/perf: hisi_pcie: Merge
 find_related_event() and get_event_idx()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Yicong Yang
	<yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
 <20240204074527.47110-7-yangyicong@huawei.com>
 <20240208123946.00006618@Huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <1c14d50d-fc51-cc34-aa97-358466c19fe6@huawei.com>
Date: Thu, 22 Feb 2024 11:00:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208123946.00006618@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)

Hi, Jonathan


On 2024/2/8 20:39, Jonathan Cameron wrote:
> On Sun, 4 Feb 2024 15:45:26 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
>
>> From: Junhao He <hejunhao3@huawei.com>
>>
>> The function xxx_find_related_event() scan all working events to find
>> related events. During this process, we also can find the idle counters.
>> If not found related events, return the first idle counter to simplify
>> the code.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> A suggestion inline to avoid the magic HISI_PCIE_MAX_COUNTER value
> being used outside of the function.

Thanks for the comments, will fix in next version.

>
>> ---
>>   drivers/perf/hisilicon/hisi_pcie_pmu.c | 55 ++++++++++----------------
>>   1 file changed, 21 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> index 1b45aeb82859..2edde66675e7 100644
>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> @@ -397,16 +397,24 @@ static u64 hisi_pcie_pmu_read_counter(struct perf_event *event)
>>   	return hisi_pcie_pmu_readq(pcie_pmu, event->hw.event_base, idx);
>>   }
>>   
>> -static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
>> -					    struct perf_event *event)
>> +/*
>> + * Check all work events, if a relevant event is found then we return it
>> + * first, otherwise return the first idle counter (need to reset).
>> + */
>> +static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu,
>> +					struct perf_event *event)
>>   {
>> +	int first_idle = HISI_PCIE_MAX_COUNTERS;
> 	int first_idle = -EAGAIN;

Yes, I will do that.

>>   	struct perf_event *sibling;
>>   	int idx;
>>   
>>   	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
>>   		sibling = pcie_pmu->hw_events[idx];
>> -		if (!sibling)
>> +		if (!sibling) {
>> +			if (first_idle == HISI_PCIE_MAX_COUNTERS)
> if (first_idle == -EAGAIN)

Ok, will fix it.

>
>> +				first_idle = idx;
>>   			continue;
>> +		}
>>   
>>   		/* Related events must be used in group */
>>   		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
>> @@ -414,19 +422,7 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
>>   			return idx;
>>   	}
>>   
>> -	return idx;
>> -}
>> -
>> -static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
>> -{
>> -	int idx;
>> -
>> -	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
>> -		if (!pcie_pmu->hw_events[idx])
>> -			return idx;
>> -	}
>> -
>> -	return -EINVAL;
>> +	return first_idle;
> Then this will return -EAGAIN;

Okay

>>   }
>>   
>>   static void hisi_pcie_pmu_event_update(struct perf_event *event)
>> @@ -552,27 +548,18 @@ static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
>>   
>>   	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>>   
>> -	/* Check all working events to find a related event. */
>> -	idx = hisi_pcie_pmu_find_related_event(pcie_pmu, event);
>> -	if (idx < 0)
>> -		return idx;
>> -
>> -	/* Current event shares an enabled counter with the related event */
>> -	if (idx < HISI_PCIE_MAX_COUNTERS) {
>> -		hwc->idx = idx;
>> -		goto start_count;
>> -	}
>> -
>> -	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
>> -	if (idx < 0)
>> -		return idx;
>> +	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu, event);
>> +	if (idx == HISI_PCIE_MAX_COUNTERS)
>> +		return -EAGAIN;
> Perhaps simpler to handle first_idle == HISI_PCIE_MAX_COUNTERS as
> an error return in hisi_pcie_pmu_get_event_idx - see above.
>
>   	if (idx < 0)
> 		return idx;

Sure.

>
>>   
>>   	hwc->idx = idx;
>> -	pcie_pmu->hw_events[idx] = event;
>> -	/* Reset Counter to avoid previous statistic interference. */
>> -	hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
>>   
>> -start_count:
>> +	/* No enabled counter found with related event, reset it */
>> +	if (!pcie_pmu->hw_events[idx]) {
>> +		hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
>> +		pcie_pmu->hw_events[idx] = event;
>> +	}
>> +
>>   	if (flags & PERF_EF_START)
>>   		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
>>   
>


