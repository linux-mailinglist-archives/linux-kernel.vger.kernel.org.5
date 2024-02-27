Return-Path: <linux-kernel+bounces-83910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0DB86A001
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1764E1C23AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748E51C40;
	Tue, 27 Feb 2024 19:17:55 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173751009
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061475; cv=none; b=e60LomqpiJMV9O/cXbX8R7WFA9W7QEHPgBc6kp3xH7H73yXBCkkbinLOFjQkEQfLhNCxQvDzjEmqOf3tuXZyhSnRxxv+adBiHWZxE1nO3/OnFIbAmhOJdZh3wnG6bDjAck1wSp+pAm3bKEWOdMgYP8MtiNzqUC6Nr2N8nRVZ5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061475; c=relaxed/simple;
	bh=u8WtCmjfQ0za7kMnrIDIbj7vD1dahCbikgS+z+/vAF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scOf4pl7bIaV3oTbTZTSPul31du2Sv75MHeQC08Ql6t09BIjJEXIZgEdV7e84yRjYv9ct7Gc5goPLIQg9TFeLArfMMtO5YxakKIETB9MfIsHO4YdUQSon+gouMjJCMks9YCDNKTPXC2kAouxIuqaasq27hj6Htmc9QtixzNrti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45012E0008;
	Tue, 27 Feb 2024 19:17:45 +0000 (UTC)
Message-ID: <e0ed5873-fd41-49f2-be7f-a6cff42f2023@ghiti.fr>
Date: Tue, 27 Feb 2024 20:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,RESEND 2/2] drivers: perf: ctr_get_width function for
 legacy is not defined
Content-Language: en-US
To: Vadim Shakirov <vadim.shakirov@syntacore.com>,
 linux-riscv@lists.infradead.org
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
References: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
 <20240227170002.188671-3-vadim.shakirov@syntacore.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240227170002.188671-3-vadim.shakirov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Vadim,

On 27/02/2024 18:00, Vadim Shakirov wrote:
> With parameters CONFIG_RISCV_PMU_LEGACY=y and CONFIG_RISCV_PMU_SBI=n
> linux kernel crashes when you try perf record:
>
> $ perf record ls
> [ 46.749286] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [ 46.750199] Oops [#1]
> [ 46.750342] Modules linked in:
> [ 46.750608] CPU: 0 PID: 107 Comm: perf-exec Not tainted 6.6.0 #2
> [ 46.750906] Hardware name: riscv-virtio,qemu (DT)
> [ 46.751184] epc : 0x0
> [ 46.751430] ra : arch_perf_update_userpage+0x54/0x13e
> [ 46.751680] epc : 0000000000000000 ra : ffffffff8072ee52 sp : ff2000000022b8f0
> [ 46.751958] gp : ffffffff81505988 tp : ff6000000290d400 t0 : ff2000000022b9c0
> [ 46.752229] t1 : 0000000000000001 t2 : 0000000000000003 s0 : ff2000000022b930
> [ 46.752451] s1 : ff600000028fb000 a0 : 0000000000000000 a1 : ff600000028fb000
> [ 46.752673] a2 : 0000000ae2751268 a3 : 00000000004fb708 a4 : 0000000000000004
> [ 46.752895] a5 : 0000000000000000 a6 : 000000000017ffe3 a7 : 00000000000000d2
> [ 46.753117] s2 : ff600000028fb000 s3 : 0000000ae2751268 s4 : 0000000000000000
> [ 46.753338] s5 : ffffffff8153e290 s6 : ff600000863b9000 s7 : ff60000002961078
> [ 46.753562] s8 : ff60000002961048 s9 : ff60000002961058 s10: 0000000000000001
> [ 46.753783] s11: 0000000000000018 t3 : ffffffffffffffff t4 : ffffffffffffffff
> [ 46.754005] t5 : ff6000000292270c t6 : ff2000000022bb30
> [ 46.754179] status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000000000c
> [ 46.754653] Code: Unable to access instruction at 0xffffffffffffffec.
> [ 46.754939] ---[ end trace 0000000000000000 ]---
> [ 46.755131] note: perf-exec[107] exited with irqs disabled
> [ 46.755546] note: perf-exec[107] exited with preempt_count 4
>
> This happens because in the legacy case the ctr_get_width function was not
> defined, but it is used in arch_perf_update_userpage.
>
> Also remove extra check in riscv_pmu_ctr_get_width_mask
>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> ---
>   drivers/perf/riscv_pmu.c        | 18 +++++-------------
>   drivers/perf/riscv_pmu_legacy.c |  8 +++++++-
>   2 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 0dda70e1ef90..c78a6fd6c57f 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -150,19 +150,11 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
>   	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
>   	struct hw_perf_event *hwc = &event->hw;
>   
> -	if (!rvpmu->ctr_get_width)
> -	/**
> -	 * If the pmu driver doesn't support counter width, set it to default
> -	 * maximum allowed by the specification.
> -	 */
> -		cwidth = 63;
> -	else {
> -		if (hwc->idx == -1)
> -			/* Handle init case where idx is not initialized yet */
> -			cwidth = rvpmu->ctr_get_width(0);
> -		else
> -			cwidth = rvpmu->ctr_get_width(hwc->idx);
> -	}
> +	if (hwc->idx == -1)
> +		/* Handle init case where idx is not initialized yet */
> +		cwidth = rvpmu->ctr_get_width(0);
> +	else
> +		cwidth = rvpmu->ctr_get_width(hwc->idx);
>   
>   	return GENMASK_ULL(cwidth, 0);
>   }
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index a85fc9a15f03..fa0bccf4edf2 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -37,6 +37,12 @@ static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
>   	return pmu_legacy_ctr_get_idx(event);
>   }
>   
> +/* cycle & instret are always 64 bit, one bit less according to SBI spec */
> +static int pmu_legacy_ctr_get_width(int idx)
> +{
> +	return 63;
> +}
> +
>   static u64 pmu_legacy_read_ctr(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> @@ -111,7 +117,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>   	pmu->ctr_stop = NULL;
>   	pmu->event_map = pmu_legacy_event_map;
>   	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
> -	pmu->ctr_get_width = NULL;
> +	pmu->ctr_get_width = pmu_legacy_ctr_get_width;
>   	pmu->ctr_clear_idx = NULL;
>   	pmu->ctr_read = pmu_legacy_read_ctr;
>   	pmu->event_mapped = pmu_legacy_event_mapped;


Thanks for the resend, this one slipped through...

Let's add the fixes tag:

Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support 
in the SBI backend")

Thanks again,

Alex


