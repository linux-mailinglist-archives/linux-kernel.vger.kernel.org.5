Return-Path: <linux-kernel+bounces-70126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C58593BD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A351281F45
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B666A34;
	Sun, 18 Feb 2024 00:55:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DD36E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217701; cv=none; b=d4B4gYeKpgak0sDYGTV9qBI3Te6HcFpWcG5hoBj+mlU106GFUtCOHDXXgDk1FIp2FALnXuPZWJpGjalWY+N5kIxvbNOLrkOtoXq+NzZpW+eMZR+vUwRuLSuTaaH99VSBYUATq9n++qKUEHx5TTjbZgJhZrjmNJNQll9Uokds5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217701; c=relaxed/simple;
	bh=r2CPKbgVAG+OkQiwRepCBmmOjtywISiSS/RsLdr87LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/HBKXkxpOCTkU09TYhUNoePvrMqJPkQKiyhuBZ8Ib+RrozApYHWZ4Xmp7oan1Pjvmyr0msc8t+dq0eB4wO/MZtpYdAI+6LIQ39BWZRA23qFLAp4Gs2Xq6n1OA3z2xLFKQloi8vL8UnXEgPnpWixU50EnOPUAirb4nMe992FEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 875ABDA7;
	Sat, 17 Feb 2024 16:55:39 -0800 (PST)
Received: from [10.163.45.155] (unknown [10.163.45.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5365B3F694;
	Sat, 17 Feb 2024 16:54:57 -0800 (PST)
Message-ID: <05487b0c-207f-48c4-9094-6180c948783e@arm.com>
Date: Sun, 18 Feb 2024 06:24:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64DFR0_EL1 and ID_DFR0_EL1
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240215055159.2440898-1-anshuman.khandual@arm.com>
 <b103244b-7776-48fb-8055-5c003d773087@sirena.org.uk>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b103244b-7776-48fb-8055-5c003d773087@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 18:30, Mark Brown wrote:
> On Thu, Feb 15, 2024 at 11:21:59AM +0530, Anshuman Khandual wrote:
> 
>> This just updates ID_DFR0_EL1.CopDbg and ID_AA64DFR0_EL1.DebugVer register
>> fields as per the definitions based on DDI0601 2023-12.
> 
> Just as a general note for non-trival registers it's easier to review if
> we change one register per patch, it avoids having to re-review the same
> registers repeatedly and for incremental changes like this it helps with
> the fact that diff does badly at offering context.

Agreed, and noted.

> 
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -231,6 +231,7 @@ Enum	3:0	CopDbg
>>  	0b1000	Debugv8p2
>>  	0b1001	Debugv8p4
>>  	0b1010	Debugv8p8
>> +	0b1011	Debugv8p9
>>  EndEnum
>>  EndSysreg
> 
> This is ID_AA64DFR0_EL1 and is missing at least an update to PMSVer.
> 
>>  
>> @@ -1247,6 +1248,7 @@ UnsignedEnum	3:0	DebugVer
>>  	0b1000	V8P2
>>  	0b1001	V8P4
>>  	0b1010	V8P8
>> +	0b1011	V8P9
>>  EndEnum
>>  EndSysreg
> 
> This is ID_DFR0_EL1 and is missing an update to at least PerfMon.

Will fold in the following changes i.e for ID_DFR0_EL1 and for
ID_AA64DFR0_EL1 respectively and then split the patch into two
- one for each register.

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index cc2914d6ebdc..508224a0e078 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -200,6 +200,7 @@ UnsignedEnum        27:24   PerfMon
        0b0110  PMUv3p5
        0b0111  PMUv3p7
        0b1000  PMUv3p8
+       0b1001  PMUv3p9
        0b1111  IMPDEF
 EndEnum
 Enum   23:20   MProfDbg
@@ -1222,6 +1223,7 @@ UnsignedEnum      35:32   PMSVer
        0b0010  V1P1
        0b0011  V1P2
        0b0100  V1P3
+       0b0101  V1P4
 EndEnum
 Field  31:28   CTX_CMPs
 Res0   27:24

