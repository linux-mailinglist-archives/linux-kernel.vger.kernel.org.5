Return-Path: <linux-kernel+bounces-74421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A571485D3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B07D1F25584
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFD3D3A7;
	Wed, 21 Feb 2024 09:39:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24173C496
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508363; cv=none; b=niROAcMoKV06nlIu9eGUmX1HqlZPcvO9DB6ZSSj5O6RuPEygmBWgUr4rGsXg3ip1cmOXcgTeeS31geYnytj/8xCIZ4eHn8BfJuFTxebQ3z/GpOIdcTHdbuV678F84XV0Fz+5IJEO/A5gm158pGBocN5skav4LUIIDpPoeyF2JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508363; c=relaxed/simple;
	bh=wqv71yyakWWdzpHYlH9OK4dYiSB5s5d3x+wzGlkqaFg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HcxoM5TF/RterFQdpI9LReW1kjt6W3QfVNSo50nJsVHrBZejW1cE50M2utpMzUg9nsjQdaglhCxhkUToBWESjXIpIlJbatq6J05caQuvS8PlbEoEEURBfwRiIQH/M4K3GuR+tEakTrO6nmdT8iBZtU/k7D/FqKvlisr816ZjfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tfrlw2zf3z1Q8sM;
	Wed, 21 Feb 2024 17:37:32 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id BD029140427;
	Wed, 21 Feb 2024 17:39:11 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:39:11 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/7] drivers/perf: hisi_pcie: Introduce
 hisi_pcie_pmu_get_filter()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
 <20240204074527.47110-2-yangyicong@huawei.com>
 <20240208120643.000042fa@Huawei.com> <20240208121800.000057a2@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <68d4382d-7b1a-f23e-3b33-c2fca708deaf@huawei.com>
Date: Wed, 21 Feb 2024 17:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208121800.000057a2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/8 20:18, Jonathan Cameron wrote:
> On Thu, 8 Feb 2024 12:06:43 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Sun, 4 Feb 2024 15:45:21 +0800
>> Yicong Yang <yangyicong@huawei.com> wrote:
>>
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> Factor out retrieving of the register value for the
>>> corresponding event from hisi_pcie_config_filter() into a
>>> new function hisi_pcie_pmu_get_filter() allowing future reuse.
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> On second thoughts, this might benefit from a clearer name.
> Perhaps just call it exactly what it is
> hisi_pcie_pmu_get_ctrl_reg_val_to_set()
> 
> It incorporates the event code as well as the filter.
> Maybe we want to rename pmu_config_filter() as well to
> pmu_config_counter() which I think is the real meaning?
> 

make sense to me. we can simply use the reg name as the suffix,
it'll be more clearer:

hisi_pcie_pmu_get_event_ctrl_val()
hisi_pcie_pmu_config_event_ctrl()

> 
>>
>>> ---
>>>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> index b90ba8aca3fa..11a819cd07f2 100644
>>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> @@ -216,10 +216,8 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
>>>  	writeq_relaxed(val, pcie_pmu->base + offset);
>>>  }
>>>  
>>> -static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>>> +static u64 hisi_pcie_pmu_get_filter(struct perf_event *event)
>>>  {
>>> -	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> -	struct hw_perf_event *hwc = &event->hw;
>>>  	u64 port, trig_len, thr_len, len_mode;
>>>  	u64 reg = HISI_PCIE_INIT_SET;
>>>  
>>> @@ -256,6 +254,15 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>>>  	else
>>>  		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
>>>  
>>> +	return reg;
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>>> +{
>>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +	u64 reg = hisi_pcie_pmu_get_filter(event);
>>> +
>>>  	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
>>>  }
>>>    
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 

