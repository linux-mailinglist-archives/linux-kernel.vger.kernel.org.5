Return-Path: <linux-kernel+bounces-83042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B9868DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC811F20F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36E138497;
	Tue, 27 Feb 2024 10:36:25 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D11DFF0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030185; cv=none; b=TQthU3tsptni/wwR4zNSJNQeJXjrVEFSkjUynL3gN1R+JmTRwnFAo5tHGuHFSfucGyLCrxIb0ux0FNazCWBh6citMLJQj5JE8HJl6zeharfLEvbA7lvGON/tI6yGKCTRN6h+I4jwYO61NWyW1rZfpMuiBAAFkTBsqGPmT8zVsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030185; c=relaxed/simple;
	bh=9Bpp2Gd+7XHS00/UjCwPlkxD2VRPK1P6HYvdF543+d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hmc/PNMB+wiWWVGTNCSrzHMgRwGXZ31BnhW2nX28NCB+wq0XBHuGW5RfQz/3DjGaSn9bSYNEENb7JFXjfmDsDc6cjQ75baiKVuBsMtgx9c+1iK5Y7Gw+q5Ld6WkX+gKIPptZ7XprZmpjeLbstfFoLS43Q2ts15PDyy/D/0GZTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 313881BF218;
	Tue, 27 Feb 2024 10:36:17 +0000 (UTC)
Message-ID: <e9524709-96b2-4008-815f-4d48ba5d48d9@ghiti.fr>
Date: Tue, 27 Feb 2024 11:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISCV: Fix panic on pmu overflow handler
To: Fei Wu <fei2.wu@intel.com>, atishp@atishpatra.org, anup@brainfault.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240227030731.2560035-1-fei2.wu@intel.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240227030731.2560035-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Fei,

On 27/02/2024 04:07, Fei Wu wrote:
> Sign extension of (1 << idx) from int is not desired when setting bits
> in unsigned long overflowed_ctrs, kernel panics if 31 is a valid lidx.
> This panic happens when 'perf record -e branches' on a sophgo machine.
>
> [  212.845953] epc : ffffffff80afc288 ra : ffffffff80afd310 sp : fffffff6e36928f0
> [  212.853474]  gp : ffffffff821f7f48 tp : ffffffd9033b9900 t0 : 0000002ad69e9978
> [  212.861069]  t1 : 000000000000002a t2 : ffffffff801764d2 s0 : fffffff6e3692ab0
> [  212.868637]  s1 : 0000000000000020 a0 : 0000000000000000 a1 : 0000000000000015
> [  212.876021]  a2 : 0000000000000000 a3 : 0000000000000015 a4 : 0000000000000020
> [  212.883482]  a5 : ffffffd7ff880640 a6 : 000000000005a569 a7 : ffffffffffffffd5
> [  212.891191]  s2 : 000000000000ffff s3 : 0000000000000000 s4 : ffffffd7ff880540
> [  212.898707]  s5 : 0000000000504d55 s6 : ffffffd902443000 s7 : ffffffff821fe1f8
> [  212.906329]  s8 : 000000007fffffff s9 : ffffffd7ff880540 s10: ffffffd9147a1098
> [  212.914151]  s11: 0000000080000000 t3 : 0000000000000003 t4 : ffffffff80186226
> [  212.921773]  t5 : ffffffff802455ca t6 : ffffffd9058900e8
> [  212.927300] status: 0000000200000100 badaddr: 0000000000000098 cause: 000000000000000d
> [  212.935575] [<ffffffff80afc288>] riscv_pmu_ctr_get_width_mask+0x8/0x60
> [  212.942391] [<ffffffff80079922>] handle_percpu_devid_irq+0x98/0x1e8
> [  212.948855] [<ffffffff80073d06>] generic_handle_domain_irq+0x28/0x36
> [  212.955521] [<ffffffff80481444>] riscv_intc_irq+0x36/0x4e
> [  212.961269] [<ffffffff80ca5fce>] handle_riscv_irq+0x4a/0x74
> [  212.967270] [<ffffffff80ca6afc>] do_irq+0x60/0x90
> [  212.972284] Code: b580 60a2 6402 5529 0141 8082 0013 0000 0013 0000 (6d5c) b783
> [  212.980036] ---[ end trace 0000000000000000 ]---
> [  212.984874] Kernel panic - not syncing: Fatal exception in interrupt
> [  212.991506] SMP: stopping secondary CPUs
> [  212.995964] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>   drivers/perf/riscv_pmu_sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..c87c459e52de 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -731,14 +731,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>   		/* compute hardware counter index */
>   		hidx = info->csr - CSR_CYCLE;
>   		/* check if the corresponding bit is set in sscountovf */
> -		if (!(overflow & (1 << hidx)))
> +		if (!(overflow & (1UL << hidx)))
>   			continue;
>   
>   		/*
>   		 * Keep a track of overflowed counters so that they can be started
>   		 * with updated initial value.
>   		 */
> -		overflowed_ctrs |= 1 << lidx;
> +		overflowed_ctrs |= 1UL << lidx;
>   		hw_evt = &event->hw;
>   		riscv_pmu_event_update(event);
>   		perf_sample_data_init(&data, 0, hw_evt->last_period);


That's a good catch. Do you mind using the BIT macro instead? And I see 
2 other instances of "1 <<" in this file, I think they are safe since we 
only have 32 hw perf counters, but I may be missing something: @Atish WDYT?

Thanks,

Alex



