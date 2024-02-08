Return-Path: <linux-kernel+bounces-58040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A384E08C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3891C25860
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0671B4F;
	Thu,  8 Feb 2024 12:19:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8771B30
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394758; cv=none; b=AsCEqDhV3ivJiOtDvBDGElcc0WrQVOvvRNF4W/S+xAq/S7BW4swBtXZp6sKaubTwutiSvjUch3T6BN4nmwrw1KXlKn9HVZDkj4UABcJ3fHnAHHFt6kgKbtSye8C56C1st/KusFKU880y2zI2REfpFdFumSTtEd941uiCwmr4158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394758; c=relaxed/simple;
	bh=RSoYju6jhoejnA/9NGmI8rc3Aj7wlru6fJ0M6DLzgRw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9r/8FF5PG6bUaPBfUgAqpCa+2A2+0Ts9eS+2bVMGkHm7JsNxtDznsla1ylq+iIVjJgxkNhILETh8JiKWxtLUgrvZlrL27F+0Fw80IDPyJzyCLq3Z691DEK/KBsnWJIMhQGsXrBgqIO6uodxxYR0klk12MCvK2HcrryRdfLe8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVwtc1yxbz6K64G;
	Thu,  8 Feb 2024 20:15:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C9E59140136;
	Thu,  8 Feb 2024 20:19:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:19:13 +0000
Date: Thu, 8 Feb 2024 12:19:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 2/7] drivers/perf: hisi_pcie: Fix incorrect counting
 under metric mode
Message-ID: <20240208121912.00001fd7@Huawei.com>
In-Reply-To: <20240204074527.47110-3-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
	<20240204074527.47110-3-yangyicong@huawei.com>
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

On Sun, 4 Feb 2024 15:45:22 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The metric counting shows incorrect results if the events in the
> metric group using the same event but different filter options.
> This is because we only judge the event code to decide whether
> the event in the metric group should share the same hardware
> counter, but ignore the settings of the filter.
> 
> For example, on a platform of 2 ports 0x1 and 0x2 but only port
> 0x1 has a downstream PCIe NVME device. The metric counting
> shows both ports have the same counts because we misassign these
> two events to one same hardware counter:
> [root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'
> 
>  Performance counter stats for 'system wide':
> 
>         7907484924      hisi_pcie0_core1/event=0x0104,port=0x2/
>         7907484924      hisi_pcie0_core1/event=0x0104,port=0x1/
> 
>       10.153863691 seconds time elapsed
> 
> Fix this by using the whole config rather than the event only
> to judge whether two events are the same and should share the
> same hardware counter. With this patch, the metric counting in
> the above case tends to be corrected:
> 
> [root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'
> 
>  Performance counter stats for 'system wide':
> 
>                  0      hisi_pcie0_core1/event=0x0104,port=0x2/
>         8123122077      hisi_pcie0_core1/event=0x0104,port=0x1/
> 
>       10.152875631 seconds time elapsed
> 
> Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 11a819cd07f2..9623bed93876 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -314,10 +314,15 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
>  	return true;
>  }
>  
> +/*
> + * Check Whether two events share the same config. The same config means not
> + * only the event code, but also the filter settings of the two events are
> + * the same.
> + */
>  static bool hisi_pcie_pmu_cmp_event(struct perf_event *target,
>  					struct perf_event *event)
>  {
> -	return hisi_pcie_get_real_event(target) == hisi_pcie_get_real_event(event);
> +	return hisi_pcie_pmu_get_filter(target) == hisi_pcie_pmu_get_filter(event);

This is why I looked more closely at what get_filter() was doing in previous patch.
Not obvious from the naming here that this compares the event + filters rather than
now just comparing the filters.

>  }
>  
>  static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)


