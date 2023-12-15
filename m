Return-Path: <linux-kernel+bounces-1437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E72814F10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FC11F25317
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0182EF8;
	Fri, 15 Dec 2023 17:42:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114282ED4;
	Fri, 15 Dec 2023 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E005C15;
	Fri, 15 Dec 2023 09:43:38 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3404A3F5A1;
	Fri, 15 Dec 2023 09:42:51 -0800 (PST)
Message-ID: <d335905e-38bb-1994-57f6-533852b7a560@arm.com>
Date: Fri, 15 Dec 2023 17:42:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] arm: perf: Fix ARCH=arm build with GCC in
 armv8pmu_write_evtype()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-next@vger.kernel.org, will@kernel.org, u.kleine-koenig@pengutronix.de,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20231215150040.3342183-1-james.clark@arm.com>
 <20231215150040.3342183-2-james.clark@arm.com>
 <ZXx9GW1onSy4eBEB@FVFF77S0Q05N>
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZXx9GW1onSy4eBEB@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/12/2023 16:21, Mark Rutland wrote:
> On Fri, Dec 15, 2023 at 03:00:38PM +0000, James Clark wrote:
>> LLVM ignores everything inside the if statement and doesn't generate
>> errors, but GCC doesn't ignore it, resulting in the following error:
>>
>>   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_write_evtype':
>>   include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
>>   	34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
>>
>> Fix it by changing the if to #if.
> 
> I reckon it'd be cleaner to use GENMASK_ULL for the TH and TC fields, in
> include/linux/perf/arm_pmu.h have:
> 
> | /*
> |  * PMXEVTYPER: Event selection reg
> |  */
> | #define ARMV8_PMU_EVTYPE_EVENT GENMASK(15, 0)          /* Mask for EVENT bits */
> | #define ARMV8_PMU_EVTYPE_TH    GENMASK_ULL(43, 32)     /* arm64 only */
> | #define ARMV8_PMU_EVTYPE_TC    GENMASK_ULL(63, 61)     /* arm64 only */
> 
> IIUC that should silence this warning, and it'd remove the need for the
> ifdeffery and other changes in patch 2.
> 
> Does that work, or am I missing something?
> 
> Thanks,
> Mark.
> 

You're right that does work. For some reason I thought there was some
component of writing it to the mask that was the issue as well.

I'll send another version with that fix instead.

Thanks
James

>>
>> Fixes: 3115ee021bfb ("arm64: perf: Include threshold control fields in PMEVTYPER mask")
>> Reported-by: Uwe Kleine-K"onig <u.kleine-koenig@pengutronix.de>
>> Closes: https://lore.kernel.org/linux-arm-kernel/20231215120817.h2f3akgv72zhrtqo@pengutronix.de/
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  drivers/perf/arm_pmuv3.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 23fa6c5da82c..3ed2086cefc3 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -631,8 +631,9 @@ static void armv8pmu_write_evtype(int idx, unsigned long val)
>>  			     ARMV8_PMU_EXCLUDE_EL0 |
>>  			     ARMV8_PMU_EXCLUDE_EL1;
>>  
>> -	if (IS_ENABLED(CONFIG_ARM64))
>> -		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
>> +#if IS_ENABLED(CONFIG_ARM64)
>> +	mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
>> +#endif
>>  
>>  	val &= mask;
>>  	write_pmevtypern(counter, val);
>> -- 
>> 2.34.1
>>

