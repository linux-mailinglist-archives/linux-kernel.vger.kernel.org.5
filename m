Return-Path: <linux-kernel+bounces-139211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48D89FFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6661C2374F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546765CB5;
	Wed, 10 Apr 2024 18:35:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B164D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774107; cv=none; b=mqK4kfQC75htdY5o6Yt2BRI6ZhAe+37mLvDMprP75naVAYx2/6+zWWIPngrxfh8k2fWA4Hu1rEbCkHtAvU7ehe/d4deACBITDBY+wQSa3VMVess9vXRVCrWNGuFyg5wACt3KuLEPz3YbVMTGFwu/nb+vxSznCQ8gYvp2XUoUS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774107; c=relaxed/simple;
	bh=+UKrVdwHI3g8Q3DxlpmYzbo99aLvRQUj5s+7qGKz2gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLtaC0d55HO9NMtqHo3WEnlYZa1rsZKkpTyLzrlnF0YbAgNJi98YukTb/kKHemyCIvWgWhL/mQxE28o5yfZ1ynbnQ4JEYX9JkjjbVFZEZKRPv2u4Aq6sykLiFEAB1kgq/jgtbunRDo+7Fi2vOhce5kx8/JoYGT6eQd0+15w21us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53DD1480;
	Wed, 10 Apr 2024 11:35:34 -0700 (PDT)
Received: from [10.57.53.164] (unknown [10.57.53.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD933F6C4;
	Wed, 10 Apr 2024 11:35:03 -0700 (PDT)
Message-ID: <8ca29fcd-20f1-494d-ae51-1c096d131a60@arm.com>
Date: Wed, 10 Apr 2024 19:35:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Set PMU device parent
Content-Language: en-GB
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
 <20240410180403.00004cff@Huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240410180403.00004cff@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-10 6:04 pm, Jonathan Cameron wrote:
> On Tue,  9 Apr 2024 18:15:17 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> Now that perf supports giving the PMU device a parent, we can use our
>> platform device to make the relationship between CMN instances and PMU
>> IDs trivially discoverable, from either nominal direction:
>>
>> root@crazy-taxi:~# ls /sys/devices/platform/ARMHC600:00 | grep cmn
>> arm_cmn_0
>> root@crazy-taxi:~# realpath /sys/bus/event_source/devices/arm_cmn_0/..
>> /sys/devices/platform/ARMHC600:00
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Nice.  I'd forgotten all about this :(

Yeah, I hadn't realised the core change actually got merged until I 
stumbled across it by chance yesterday, otherwise I'd have followed up 
far sooner... If only your series had been a day or two later, I'd have 
posted the original device_move() version of this one back then, and it 
might even have looked reasonable for a moment :)

Cheers,
Robin.

> https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
> still has a bunch of these + there were many I never looked into.
> 
> Guess I should respin that series though probably 50% at least still apply.
> 
> J
> 
> 
>> ---
>>   drivers/perf/arm-cmn.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 7ef9c7e4836b..b2c607cf3ad7 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2482,6 +2482,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
>>   	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
>>   	cmn->pmu = (struct pmu) {
>>   		.module = THIS_MODULE,
>> +		.parent = cmn->dev,
>>   		.attr_groups = arm_cmn_attr_groups,
>>   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>   		.task_ctx_nr = perf_invalid_context,
> 

