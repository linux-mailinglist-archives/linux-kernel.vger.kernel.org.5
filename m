Return-Path: <linux-kernel+bounces-74422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6085D3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA73B22497
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FF3D546;
	Wed, 21 Feb 2024 09:40:25 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97913D3B1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508424; cv=none; b=D38xQyKIFtV1eQP7+CuQ0TxdlDci7WOokfqlIqUgu9TecdoVxzTkO3sNn9hQ+3iBi5ndRiSFJfu+TMZKYk3cOy0P0A0exMwOdPqz6vRPLOaxEJ/Gj9usR1igtKIn5H+tN2yImyGxv6WGG9ZUINVc6KHx850/HV4Z15X5TWbCDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508424; c=relaxed/simple;
	bh=Oy5E/HNDZF5wCVxixr/Zuuk7jVIjUehgBfPYwJ5cO2c=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h/NiWkqRuMMxIrSWLQFF3d+iF8T6Hm7C2p1i78AgfO/M/WDkLkiq2vVuwHLkWDEypsaYG/IhJedwuZt2SoBH+vNMPmd5uLjpjTf+0YH2dW7vmh3GzsyDGNRJI0ET10uSwUubShr3AXnLFKGfZvQbx/cOfarB505Ial2N0vh/pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tfrmh3M8TzvVtn;
	Wed, 21 Feb 2024 17:38:12 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE32140114;
	Wed, 21 Feb 2024 17:40:14 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:40:14 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 3/7] drivers/perf: hisi_pcie: Add more events for counting
 TLP bandwidth
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
 <20240204074527.47110-4-yangyicong@huawei.com>
 <20240208122029.000005e1@Huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <9c033974-aa73-2b1d-c997-e3c38e38a859@huawei.com>
Date: Wed, 21 Feb 2024 17:40:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208122029.000005e1@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/8 20:20, Jonathan Cameron wrote:
> On Sun, 4 Feb 2024 15:45:23 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> A typical PCIe transaction is consisted of various TLP packets in both
>> direction. For counting bandwidth only memory read events are exported
>> currently. Add memory write and completion counting events of both
>> direction to complementation.
> 
> complementation?
> 

sorry for the typo. will fix.

>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> 
>> ---
>>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> index 9623bed93876..83be3390686c 100644
>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> @@ -726,10 +726,18 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
>>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
>>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
>>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_flux, 0x0104),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_time, 0x10104),
>>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x0804),
>>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x10804),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_flux, 0x2004),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_time, 0x12004),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_flux, 0x0105),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_time, 0x10105),
>>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x0405),
>>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x10405),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_flux, 0x1005),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_time, 0x11005),
>>  	NULL
>>  };
>>  
> 
> .
> 

