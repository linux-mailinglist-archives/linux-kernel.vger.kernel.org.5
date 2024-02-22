Return-Path: <linux-kernel+bounces-75764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E685EE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB551F2196C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4512E40;
	Thu, 22 Feb 2024 01:21:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684611C83
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564906; cv=none; b=frI5sJOoqtWe4KiW3Xj3fHUL7dgnfUddHn/2E86IJ/I4OdwbRPNwdFsXXdbheCu6SDYuIWYSrGfnwMFDesbUyybDbDJt76LM/eXDvNP2EZ4+/MjdmilzUAXQ5pUmoalsRfeI9yZNpGESWZpZZYRl3IBGHtfLvWQEdims7S6Qf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564906; c=relaxed/simple;
	bh=HRAHwhX8PJueaGfqb12BtadbG0pG6AKdOViQmQMlQl4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KbbaTXB3O7tS22aIAKvn/csySDFrk9JZjK0B5oY4oEfpR7a4U0XZkTJ0KsN8Ry6/M79rJOAleklDyixZFdPDrwX2Sk2v99Rct/vdolFgjv54QOe3lBMBUuusd88qQ3JBq9a555bh/bYv2AnAreLkePkDxp+COE8pXupiTl5e5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TgFgj1Djxz1xnp6;
	Thu, 22 Feb 2024 09:20:17 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F3EF14013B;
	Thu, 22 Feb 2024 09:21:40 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:21:40 +0800
Subject: Re: Re: [PATCH 4/7] drivers/perf: hisi_pcie: Check the target filter
 properly
To: Yicong Yang <yangyicong@huawei.com>, Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
 <20240204074527.47110-5-yangyicong@huawei.com>
 <20240208122902.0000768f@Huawei.com>
 <03acfe6b-bcde-8a11-ea6d-add1998d5bd1@huawei.com>
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <0ab7dae0-e132-2b8a-5a6c-1e517c92aa01@huawei.com>
Date: Thu, 22 Feb 2024 09:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <03acfe6b-bcde-8a11-ea6d-add1998d5bd1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)


On 2024/2/21 17:46, Yicong Yang wrote:
> On 2024/2/8 20:29, Jonathan Cameron wrote:
>> On Sun, 4 Feb 2024 15:45:24 +0800
>> Yicong Yang <yangyicong@huawei.com> wrote:
>>
>>> From: Junhao He <hejunhao3@huawei.com>
>>>
>>> The PMU can monitor traffic of certain target Root Port or downstream
>>> target Endpoint. User can specify the target filter by the "port" or
>>> "bdf" option respectively. The PMU can only monitor the Root Port or
>>> Endpoint on the same PCIe core so the value of "port" or "bdf" should
>>> be valid and will be checked by the driver.
>>>
>>> Currently at least and only one of "port" and "bdf" option must be set.
>>> If "port" filter is not set or is set explicitly to zero (default),
>>> driver will regard the user specifies a "bdf" option since "port" option
>>> is a bitmask of the target Root Ports and zero is not a valid
>>> value.
>>>
>>> If user not explicitly set "port" or "bdf" filter, the driver uses "bdf"
>>> default value (zero) to set target filter, but driver will skip the
>>> check of bdf=0, although it's a valid value (meaning 0000:000:00.0).
>>> Then the user just gets zero.
>>>
>>> Therefore, we need to check if both "port" and "bdf" are invalid, then
>>> return failure and report warning.
>>>
>>> Testing:
>>> before the patch:
>>>                     0      hisi_pcie0_core1/rx_mrd_flux/
>>>                     0      hisi_pcie0_core1/rx_mrd_flux,port=0/
>>>                24,124      hisi_pcie0_core1/rx_mrd_flux,port=1/
>>>                     0      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
>>>       <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
>> Nice to include an example that works for bdf
>> 			    hisi_pcie0_core1/rx_mrd_flux,bdf=1,port=0
>> or something like that?
>>> after the patch:
>>>       <not supported>      hisi_pcie0_core1/rx_mrd_flux/
>>>       <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0/
>>>                24,153      hisi_pcie0_core1/rx_mrd_flux,port=1/
>>>       <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
>>>       <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
>>>
>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Clearly the current situation is wrong, but perhaps we can
>> have a more intuitive scheme (could be added as a follow up patch)
>> and have the driver figure out which port the bdf lies below?
>>
>> Maybe that's a job for userspace tooling rather than the driver, but
>> the driver already has verification code and it wouldn't be hard
>> to not just check the rp is ours, but also set the filter to specify
>> that rp, or maybe just set the mask to include them all?
>>
> To do a check should be simple, we can decode the bdf and find the target
> endpoint and related root port for doing the check.

The function hisi_pcie_pmu_valid_requester_id() already does this.
It can get the RP of the bdf, then check whether the RP is within
the RP range of the PCIe PMU.

> Another example is what we've done in hisi_ptt that we maintian a list of
> supported root ports and endpoints, but that will be a bit more complex.
>
>> Jonathan
>>
>>
>>> ---
>>>   drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> index 83be3390686c..b91f03c02c57 100644
>>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>>> @@ -306,10 +306,10 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
>>>   	if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
>>>   		return false;
>>>   
>>> -	if (requester_id) {
>>> -		if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
>>> -			return false;
>>> -	}
>>> +	/* Need to explicitly set filter of "port" or "bdf" */
>>> +	if (!hisi_pcie_get_port(event) &&
>>> +	    !hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
>>> +		return false;
>>>   
>>>   	return true;
>>>   }
>> .
>>


