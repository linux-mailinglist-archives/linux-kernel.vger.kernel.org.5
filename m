Return-Path: <linux-kernel+bounces-59607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD484F9A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FC0B265AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011806996B;
	Fri,  9 Feb 2024 16:32:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C485221
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496325; cv=none; b=sxd37Ck8tLJc4w1nollUnnLMVJPZgqUGfRK3trjvSEX8xr0phOA4wuiwBUZ8+kF8TQV5yMdx8NyA7SWVcbPybqkHLUGiza3gSy22w7l/7TCBXBCerZ81gaqtKKmJteQ6dIL9j+lbc/TOi+6Yg+39cHNss+wDRN7B6qe0Oq2jhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496325; c=relaxed/simple;
	bh=GS1JvHViUXwToGjn+4dF2502dOYIGWp1Karb3Lg3yYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKNp9sOtequGx99L3IwzxwjQHNBE+znbahwrC/U6mEMIkrfBVMGK5b6ZBxTl8wX1g5DAz7SH10ahdYhYDHpI0yJ6U1C6+hpv8UODtXAMcopQpnP3Mb/sHFpDJnQ7JXMqW3uEf84fbc2auMr1Cbrk21fceSMHCYNdV0+wLz80mVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DD24DA7;
	Fri,  9 Feb 2024 08:32:44 -0800 (PST)
Received: from [10.57.47.119] (unknown [10.57.47.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC313F5A1;
	Fri,  9 Feb 2024 08:32:01 -0800 (PST)
Message-ID: <a455e5db-676a-4cf8-8669-8a10e900361c@arm.com>
Date: Fri, 9 Feb 2024 16:32:00 +0000
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
To: Will Deacon <will@kernel.org>, "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Mark Rutland <mark.rutland@arm.com>, shenghui.qu@shingroup.cn,
 ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231221093802.20612-1-jialong.yang@shingroup.cn>
 <20240209160905.GA24565@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240209160905.GA24565@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-09 4:09 pm, Will Deacon wrote:
> On Thu, Dec 21, 2023 at 05:38:01PM +0800, JiaLong.Yang wrote:
>> 'event->attr.type != event->pmu->type' has been done in
>> core.c::perf_init_event() ,core.c::perf_event_modify_attr(), etc.
>>
>> This PMU is an uncore one. The core framework has disallowed
>> uncore-task events. So the judgement to event->cpu < 0 is no mean.
> 
> It would be great to refer to the changes which added those checks to
> the perf core code. From reading the code myself, I can't convince myself
> that perf_try_init_event() won't call into the driver.
> 
>>
>> The two judgements have been done in kernel/events/core.c
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>>   drivers/perf/arm_smmuv3_pmu.c | 8 --------
>>   1 file changed, 8 deletions(-)
> 
> It looks like _many_ perf drivers have these checks, so if they really
> aren't needed, we can clean this up bveyond SMMU. However, as I said
> above, I'm not quite convinced we can drop them.

Right, I think the logic prevents events with a specific PMU type being 
offered to other PMUs, but as far as I'm aware doesn't apply the other 
way round to stop generic events (PERF_TYPE_HARDWARE etc.) being offered 
to all PMUs, so it's those that system PMUs need to reject.

It's been on my wishlist for a long time to have a capability flag to 
say "I don't handle generic events, please only ever give me events of 
my exact type" so we *can* truly factor this into the core.

Thanks,
Robin.

