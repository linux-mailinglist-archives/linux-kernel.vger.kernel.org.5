Return-Path: <linux-kernel+bounces-83941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2882486A057
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC83A1F2C569
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1246A010;
	Tue, 27 Feb 2024 19:38:48 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55120524CF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062728; cv=none; b=G2bmTfTLcAF1PGWOd4gK76az22YlzzPyfP0E005UYVANa+3I7Gol+sZxZeVjlAhKJdOWyA6NrsclJn1fHpuvWuBQ49rnSrc9fqeWRL30TILGIe7FqIKf4kEBTYGGwdW+IAs56n7H1IfRMz1O9ZrnCZLoAPOQXGA9Q323t8XwqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062728; c=relaxed/simple;
	bh=RDreJQoMpwk05ss0YoyrFEnP7lI9JQ3wxRPl9qk573s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bQqIK00ORt7fIayqyiUzkXFrpn5yRlx5jptFbwLqArh8URLCwvCjh70elIMkEDZ5JIGh39SlhQHLDWfTfjITU+3I96s9uKF1M3KRs0GHB9l7itJqogUvSUzDTMj6++42z3pFqTe6EEhcXgWXM5oCtfsjSm+nI8FfwW2yRPVd6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D074FF805;
	Tue, 27 Feb 2024 19:38:40 +0000 (UTC)
Message-ID: <1860a754-5cca-4411-904b-ecbe838efa77@ghiti.fr>
Date: Tue, 27 Feb 2024 20:38:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,RESEND 1/2] drivers: perf: added capabilities for
 legacy PMU
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>,
 linux-riscv@lists.infradead.org
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>
References: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
 <20240227170002.188671-2-vadim.shakirov@syntacore.com>
 <6ad96656-3cf4-4e22-8a18-cfde5c31cfc1@ghiti.fr>
In-Reply-To: <6ad96656-3cf4-4e22-8a18-cfde5c31cfc1@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr


On 27/02/2024 20:26, Alexandre Ghiti wrote:
> On 27/02/2024 18:00, Vadim Shakirov wrote:
>> Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
>> does not provide sampling capabilities
>>
>> Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
>> does not provide the ability to disable counter incrementation in
>> different privilege modes
>>
>> Suggested-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
>> ---
>>   drivers/perf/riscv_pmu_legacy.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/perf/riscv_pmu_legacy.c 
>> b/drivers/perf/riscv_pmu_legacy.c
>> index 79fdd667922e..a85fc9a15f03 100644
>> --- a/drivers/perf/riscv_pmu_legacy.c
>> +++ b/drivers/perf/riscv_pmu_legacy.c
>> @@ -117,6 +117,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>>       pmu->event_mapped = pmu_legacy_event_mapped;
>>       pmu->event_unmapped = pmu_legacy_event_unmapped;
>>       pmu->csr_index = pmu_legacy_csr_index;
>> +    pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>> +    pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
>>         perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>>   }
>
>
> I see here that Atish added its RB: 
> https://lore.kernel.org/linux-riscv/CAOnJCUJ-eE+zbXH0yBX_QBK2ep779q=wNCSrc+BJfzUb+zBCaw@mail.gmail.com/
>
> So I add it here (hopefully b4 won't complain, I don't know):


FTR, b4 indeed complains:

NOTE: some trailers ignored due to from/email mismatches:
     ! Trailer: Reviewed-by: Atish Patra <atishp@rivosinc.com>
      Msg From: Alexandre Ghiti <alex@ghiti.fr>


>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
> And I'd say the fixes tag for this one is:
>
> Fixes: 9b3e150e310e ("RISC-V: Add a simple platform driver for RISC-V 
> legacy perf")
>
> Thanks,
>
> Alex
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

