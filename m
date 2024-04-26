Return-Path: <linux-kernel+bounces-159859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F218B3531
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8841F22CED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5114430D;
	Fri, 26 Apr 2024 10:19:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962C142E64
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126786; cv=none; b=XO+Q6xmU5Dz6vZk9rT1hVP6xDmT4lqlCUEzBnhXknjVYPQiy5RpdebH89+Sa2lgIw2xh/v59QrebKy6FF5Y7tEwXxWShHChMquv4PJLFriym365xJsMsXuM8J/J85weFoXKIpeWk172RvH6xRsSBygIl5FiuOdcxj9eVc9E5huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126786; c=relaxed/simple;
	bh=UAxxECnbYC3eWIpdi9AkC/VdzIgX+WSNOuGazRYhHRI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PlHN8Z6oCNizGBFbWGCqOLEDNJx4z8c4kXoQ+TlP7KBveUu74upQAGrPxrL25RC3QGoHdhHIcH3ZImSFkhkps6Naal+IAEu4r4zy6W4obPg9DWXauQ4jNbOJiW4q/UsBTe8bZVUECHl3+0gIXPZ8umGibtAksHaF7ZW905ZjemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQpbK2fKyzcb4b;
	Fri, 26 Apr 2024 18:18:37 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id D907618005C;
	Fri, 26 Apr 2024 18:19:42 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:19:42 +0800
Message-ID: <cdeb2fe2-9e97-478b-9834-96a8d39701a8@huawei.com>
Date: Fri, 26 Apr 2024 18:19:42 +0800
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
Subject: Re: [PATCH 1/3] drivers/perf: hisi_pcie: Fix out-of-bound access when
 valid event group
To: Junhao He <hejunhao3@huawei.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
 <20240425124627.13764-2-hejunhao3@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240425124627.13764-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/4/25 20:46, Junhao He wrote:
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
> ---
>   drivers/perf/hisilicon/hisi_pcie_pmu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 5d1f0e9fdb08..dba399125658 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -350,15 +350,27 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
>   			return false;
>   
>   		for (num = 0; num < counters; num++) {
> +			/*
> +			 * If we find a related event, then it's a valid group
> +			 * since we don't need to allocate a new counter for it.
> +			 */
>   			if (hisi_pcie_pmu_cmp_event(event_group[num], sibling))
>   				break;
>   		}
>   
> +		/*
> +		 * Otherwise it's a new event but if there's no available counter,
> +		 * fail the check since we cannot schedule all the events in
> +		 * the group simultaneously.
> +		 */
> +		if (num == HISI_PCIE_MAX_COUNTERS)
> +			return false;
> +
>   		if (num == counters)
>   			event_group[counters++] = sibling;
>   	}
>   
> -	return counters <= HISI_PCIE_MAX_COUNTERS;
> +	return true;
>   }
>   
>   static int hisi_pcie_pmu_event_init(struct perf_event *event)

