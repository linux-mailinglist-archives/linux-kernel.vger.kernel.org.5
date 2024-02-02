Return-Path: <linux-kernel+bounces-50529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B890847A47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1A728859C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8280636;
	Fri,  2 Feb 2024 20:11:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9A80628
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904714; cv=none; b=rEpZ3YrRsac6k1JJnUzW1BnRWmwW6hV+uRW4Dgs5ozspO6QPnZm6Wrjf74bS6o547wjbsDk3qMSdREQkTx6KbAQ6wUkwPj4y4GsCPD0udO3BftAQ7ynVc2IqjdDc6pOW1sG4x7N64CRbVy0hx+RbmyJ1Lp48m8ftP9Mo4jPgCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904714; c=relaxed/simple;
	bh=Xp+cXwBxLIMQaaSXBPRQsEff4Ytd4GiPuQVCw9IpX6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVz+5JZAq46TwutFLab+UA3Y9A6XGdxcZVvfDngaBJWHLQOkrSfFmf+j64mGhxUdCPI7unAxCVsywC1FXM384yF9vtOwCvv5lasejU5MUIbyicEO3mTPbnRMxtTm1957+Nxy75UDj4ZcOzHFhJXwqF8NLZ0BjD07hIue3ObQyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54FAEDA7;
	Fri,  2 Feb 2024 12:12:33 -0800 (PST)
Received: from [10.57.47.158] (unknown [10.57.47.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846773F762;
	Fri,  2 Feb 2024 12:11:49 -0800 (PST)
Message-ID: <8daf740f-f16b-49af-8da9-7c7750092539@arm.com>
Date: Fri, 2 Feb 2024 20:11:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-GB
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <fe3e97c0-f641-48d6-9941-837e73ae3cfe@arm.com>
 <7C9733413A0F8F60+0214f04d-173d-4513-ac1e-681c2f2a8de4@shingroup.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7C9733413A0F8F60+0214f04d-173d-4513-ac1e-681c2f2a8de4@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-01 2:40 am, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/2/1 0:50, Robin Murphy 写道:
>> On 31/01/2024 7:08 am, JiaLong.Yang wrote:
>>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>>> One ni-700 can have many clock domains. Each of them has only one PMU.
>>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>>> different PMU in one NI-700. If only one NI-700 found in NI-700, name 
>>> will
>>> be ni_pmu_N.
>>> Node interface event name will be xxni_N_eventname, such as
>>> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>>> domain. Also means that there are many kinds of that in one PMU. So we
>>> distinguish them by xxni string. Besides, maybe there are many nodes
>>> have same type. So we have number N in event name.
>>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>>> Example1: perf stat -a -e 
>>> ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>
>> Oh! I've had a driver for this thing sat around for ages waiting to 
>> find someone with an interest in testing it. Given that from a quick 
>> skim of this patch I'd also have several concerns with this 
>> implementation, may I ask that you have a look at my branch and see if 
>> it works for you?
> 
> If permission I will test.

Thanks! I see you've also tried to support having the IRQs combined 
together - does your platform need that right away? That's another thing 
I've been anticipating but haven't got round to wiring up yet (it's a 
bit more fiddly than just IRQF_SHARED since perf has some expectations 
around affinity to event->cpu), but I can have a go at getting it done.

>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/ni-dev?ref_type=heads
>>
>> In particular, after the pain of maintaining event aliases in arm-cmn 
>> I'd really like to get away from doing that again and instead move 
>> over to jevents this time (especially now that system PMU support is a 
>> bit more developed there) - I just haven't yet got round to hooking up 
>> the identifier and writing the JSON files, since it hasn't seemed like 
>> much of a priority before I know whether the code even works.
>>
> 
> It's a useful way.
> Uncore PMU is increasing. Not only CPU event can be writen in jevents.
> I have not considered it when writing code in a low version.
> 
> Finally, I have opened a case in arm suppport for linux ni pmu driver.
> They tell me no driver.

Oh dear, sorry about that - I'd have hoped that a question about a Linux 
PMU driver might have found its way to our team, even if they weren't 
aware that NI-700 has already been a specific item on our roadmap for 
some time :(

Thanks,
Robin.

