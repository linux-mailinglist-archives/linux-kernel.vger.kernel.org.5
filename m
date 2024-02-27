Return-Path: <linux-kernel+bounces-83925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD586A027
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C92E28F3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAA145FE6;
	Tue, 27 Feb 2024 19:26:27 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7A51C39
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061986; cv=none; b=G4SV+i4PVh1lfO6Fcd7bbQu9s17MXs95JVaIE1GM74zY/FUqMQ/rWT5eUPuDonOWSVXwrDNx/a44f6DVO6kADaeNMoIosBulwYpxDlb9kCUHJSAPj8x9RkjeT/585dUkqXjYZVg7XjU9bvnHXE+dEL7TY5c0mwoTDPgHi7lwRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061986; c=relaxed/simple;
	bh=Y7Y/Eiw2mvsSNuBGTBYBtsyJF48ih4wqxvZpHIXyRlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAPR+fXqLKS4/hG9t3IHouFPe79vFJ1LeThpTF6+efpnejh8NZhy79CA4IVTc4r9p6S/Ft4HDtFUAFuwtwIVrovUo2CUuF472MnNEJuqNkKXquBrwbM/0kIGZ3Q1pICE+M06tg7lM82Df0rafp7Vmecnm+uo50nyuPi7SYGVH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B920E1BF209;
	Tue, 27 Feb 2024 19:26:20 +0000 (UTC)
Message-ID: <6ad96656-3cf4-4e22-8a18-cfde5c31cfc1@ghiti.fr>
Date: Tue, 27 Feb 2024 20:26:20 +0100
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
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240227170002.188671-2-vadim.shakirov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 27/02/2024 18:00, Vadim Shakirov wrote:
> Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
> does not provide sampling capabilities
>
> Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
> does not provide the ability to disable counter incrementation in
> different privilege modes
>
> Suggested-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>   drivers/perf/riscv_pmu_legacy.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index 79fdd667922e..a85fc9a15f03 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -117,6 +117,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>   	pmu->event_mapped = pmu_legacy_event_mapped;
>   	pmu->event_unmapped = pmu_legacy_event_unmapped;
>   	pmu->csr_index = pmu_legacy_csr_index;
> +	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
> +	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
>   
>   	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>   }


I see here that Atish added its RB: 
https://lore.kernel.org/linux-riscv/CAOnJCUJ-eE+zbXH0yBX_QBK2ep779q=wNCSrc+BJfzUb+zBCaw@mail.gmail.com/

So I add it here (hopefully b4 won't complain, I don't know):

Reviewed-by: Atish Patra <atishp@rivosinc.com>

And I'd say the fixes tag for this one is:

Fixes: 9b3e150e310e ("RISC-V: Add a simple platform driver for RISC-V 
legacy perf")

Thanks,

Alex


