Return-Path: <linux-kernel+bounces-138308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BA89EF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26122285091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF3158210;
	Wed, 10 Apr 2024 10:08:53 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D661156C74
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743733; cv=none; b=o141ixQnpSqDxak26wsxHHCFL6Ke00zxqMfkZJk6ThgP3Gh3ynU/MD4tM7OMdvoZ3ZULfWtJq6nHAAdNaqlWaoS3geZ/0Yd/OGPYD4Jd639gBeYg1bST868K6AWS6rnS6xTeCN2tToudaM5oP9tPF+rXriCIdM4+bhO924TwFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743733; c=relaxed/simple;
	bh=/qghVTLfrf8HPy/M0jrfUmQd5I0uDEoyupkpfqvkVHE=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p8CCFCfqy51vLQmbckf71e52c0GTutyf3etgIgNj08+N6VXrZJhSpXaeany5kDqBFl+yxu1++h613Tun6B+9pqwJeIPhia5lU4cXu+x5C0GpvYeSt0jIaiftalOIGps7gta6Dwl5sMC5+fgvKsCCSouSMgCsVOpNp8S/rLv64dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDz6K4H9Bz21kdn;
	Wed, 10 Apr 2024 18:07:53 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0819114037E;
	Wed, 10 Apr 2024 18:08:49 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 18:08:48 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<catalin.marinas@arm.com>, <broonie@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH] arm64: arm_pmuv3: Correctly extract and check the PMUVer
To: Will Deacon <will@kernel.org>
References: <20240408081158.15291-1-yangyicong@huawei.com>
 <20240409160915.GA24004@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <19b6e749-15d7-e522-95ad-b1ae42f032df@huawei.com>
Date: Wed, 10 Apr 2024 18:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240409160915.GA24004@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/4/10 0:09, Will Deacon wrote:
> On Mon, Apr 08, 2024 at 04:11:58PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently we're using "sbfx" to extract the PMUVer from ID_AA64DFR0_EL1
>> and skip the init/reset if no PMU present when the extracted PMUVer is
>> negative or is zero. However for PMUv3p8 the PMUVer will be 0b1000 and
>> PMUVer extracted by "sbfx" will always be negative and we'll skip the
>> init/reset in __init_el2_debug/reset_pmuserenr_el0 unexpectedly.
>>
>> So this patch use "ubfx" instead of "sbfx" to extract the PMUVer. If
>> the PMUVer is implementation defined (0b1111) then reset it to zero
>> and skip the reset/init. Previously we'll also skip the init/reset
>> if the PMUVer is higher than the version we known (currently PMUv3p9),
>> with this patch we'll only skip if the PMU is not implemented or
>> implementation defined. This keeps consistence with how we probe
>> the PMU in the driver with pmuv3_implemented().
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  arch/arm64/include/asm/assembler.h | 5 ++++-
>>  arch/arm64/include/asm/el2_setup.h | 5 ++++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index ab8b396428da..3b7373d6c565 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -480,7 +480,10 @@ alternative_endif
>>   */
>>  	.macro	reset_pmuserenr_el0, tmpreg
>>  	mrs	\tmpreg, id_aa64dfr0_el1
>> -	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
>> +	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
>> +	cmp	\tmpreg, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
>> +	csel	\tmpreg, xzr, \tmpreg, eq	// If PMU's IMP_DEF, regard it
>> +						// as not implemented and skip
>>  	cmp	\tmpreg, #1			// Skip if no PMU present
>>  	b.lt	9000f
>>  	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
> 
> I think the cmp/csel/cmp/b.lt sequence might be a little tidier if you
> reworked it to use ccmp. For example, something like (totally untested):
> 
> 	cmp	\tmpreg, ID_AA64DFR0_EL1_PMUVer_NI
> 	ccmp	\tmpreg, ID_AA64DFR0_EL1_PMUVer_IMP_DEF, #4, ne
> 
> would then, I think, mean we could just b.eq 9000f. But please check
> this because encoding nzcv as an immediate always catches me out.
> 

ok. will have a test on my boards. Wrote a small demo for checking all the available
versions with suggested code and seems work fine.

>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index b7afaa026842..2438e12b60c5 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -59,7 +59,10 @@
>>  
>>  .macro __init_el2_debug
>>  	mrs	x1, id_aa64dfr0_el1
>> -	sbfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
>> +	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
>> +	cmp	x0, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
>> +	csel	x0, xzr, x0, eq			// If PMU's IMP_DEF, regard it
>> +						// as not implemented and skip
>>  	cmp	x0, #1
>>  	b.lt	.Lskip_pmu_\@			// Skip if no PMU present
>>  	mrs	x0, pmcr_el0			// Disable debug access traps
> 
> Similar sort of thing here.

will also need to change the cond after the .Lskip_pmu_\@ like below:

 .macro __init_el2_debug
        mrs     x1, id_aa64dfr0_el1
-       sbfx    x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
-       cmp     x0, #1
-       b.lt    .Lskip_pmu_\@                   // Skip if no PMU present
+       ubfx    x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+       cmp     x0, #ID_AA64DFR0_EL1_PMUVer_NI
+       ccmp    x0, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF, #4, ne
+       b.eq    .Lskip_pmu_\@                   // Skip if no PMU present or IMP_DEF
        mrs     x0, pmcr_el0                    // Disable debug access traps
        ubfx    x0, x0, #11, #5                 // to EL2 and allow access to
 .Lskip_pmu_\@:
-       csel    x2, xzr, x0, lt                 // all PMU counters from EL1
+       csel    x2, xzr, x0, eq                 // all PMU counters from EL1

Will respin a v2 after tests.

Thanks.


