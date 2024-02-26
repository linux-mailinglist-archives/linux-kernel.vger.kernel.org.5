Return-Path: <linux-kernel+bounces-82170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06386802E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5373928EB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086612F39C;
	Mon, 26 Feb 2024 18:57:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACA1E866
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973843; cv=none; b=dl8joq2jNnBXosqLL1IsTGRc9/omGjQEpacQqlWH/anASwXXwMaFr+0QTGQxifdfU901MpLXmXj6y7k2KKRf9TNfsu3akGOBAnDmfXjQz/RODr3ZJdYA8B2sdiaDVDVIaZ8YABOCAr6znw3o6QmqdrxgpsIOzXmkyhF4VcpMZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973843; c=relaxed/simple;
	bh=wGCEUZ39JaYRkIMVJPzal7yVtinDsyfrhwemWznJ1wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJzcLnu2tCBoZoIKCEDdIW/vi+Ni97ciqIibmYJkSqtShAn+zUFMJhGDigMsbW0eDclxFYpSChsph2atrZPO5s+3ZWlylmGzyPDNOT/MXcrp1OrLT79ZtFcv+AORzPLrzOiCdWWnSrH2tIltvTRZq52W07a7ABmGhxiZzDkbwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A8C4DA7;
	Mon, 26 Feb 2024 10:57:58 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A963F762;
	Mon, 26 Feb 2024 10:57:18 -0800 (PST)
Message-ID: <f50a219b-81da-4301-aea0-7a1e3e759c37@arm.com>
Date: Mon, 26 Feb 2024 18:57:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm_smmuv3: Omit the two judgements which done in
 framework
Content-Language: en-GB
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, shenghui.qu@shingroup.cn,
 ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231221093802.20612-1-jialong.yang@shingroup.cn>
 <20240209160905.GA24565@willie-the-truck>
 <a455e5db-676a-4cf8-8669-8a10e900361c@arm.com>
 <840C2556C7DDB57C+c4575f04-5d1b-44a5-8f7b-3a2ba1fd61c4@shingroup.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <840C2556C7DDB57C+c4575f04-5d1b-44a5-8f7b-3a2ba1fd61c4@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 6:37 am, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/2/10 0:32, Robin Murphy 写道:
>> On 2024-02-09 4:09 pm, Will Deacon wrote:
>>> On Thu, Dec 21, 2023 at 05:38:01PM +0800, JiaLong.Yang wrote:
>>>> 'event->attr.type != event->pmu->type' has been done in
>>>> core.c::perf_init_event() ,core.c::perf_event_modify_attr(), etc.
>>>>
>>>> This PMU is an uncore one. The core framework has disallowed
>>>> uncore-task events. So the judgement to event->cpu < 0 is no mean.
>>>
>>> It would be great to refer to the changes which added those checks to
>>> the perf core code. From reading the code myself, I can't convince 
>>> myself
>>> that perf_try_init_event() won't call into the driver.
>>>
>>>>
>>>> The two judgements have been done in kernel/events/core.c
>>>>
>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>> ---
>>>>   drivers/perf/arm_smmuv3_pmu.c | 8 --------
>>>>   1 file changed, 8 deletions(-)
>>>
>>> It looks like _many_ perf drivers have these checks, so if they really
>>> aren't needed, we can clean this up bveyond SMMU. However, as I said
>>> above, I'm not quite convinced we can drop them.
>>
>> Right, I think the logic prevents events with a specific PMU type 
>> being offered to other PMUs, but as far as I'm aware doesn't apply the 
>> other way round to stop generic events (PERF_TYPE_HARDWARE etc.) being 
>> offered to all PMUs, so it's those that system PMUs need to reject. >
>> It's been on my wishlist for a long time to have a capability flag to 
>> say "I don't handle generic events, please only ever give me events of 
>> my exact type" so we *can* truly factor this into the core.
> 
> 
> It's core framework's responsible to differ generic events and others, 
> or uncore pmu and core pmu.
> Here we have flag PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE, 
> PERF_PMU_CAP_EXTENDED_HW_TYPE doing this.
> 
> again:
>          rcu_read_lock();
>          pmu = idr_find(&pmu_idr, type);
>          rcu_read_unlock();
>          if (pmu) {
>                  if (event->attr.type != type && type != PERF_TYPE_RAW &&
>                      !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
>                          goto fail; /* generic event with no ability pmu */
> This can avoid driver code (event->attr.type != event->pmu->type).

Now consider the other case below that, where "type" has not matched 
anything registered, so "pmu" is NULL, and the event is then offered to 
*every* registered PMU to see if anyone accepts it. Note that even CPU 
PMUs don't always register as PERF_TYPE_RAW, and in particular arm_pmu 
doesn't.

Thanks,
Robin.

