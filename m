Return-Path: <linux-kernel+bounces-157707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B758B14E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC251C231BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1F15696C;
	Wed, 24 Apr 2024 20:50:05 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFC13A401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991805; cv=none; b=mRMDf0tj/UrkXUHWYCknqZiPK8fN5uJBcLEkgI4bj3XkGTI4xlE6fTK/VateNXza21Pd5Q3sQFOmr1GzCRKtLPEjmMyYRCNlrLwAM9iT0yRLEh+IaHAbByrQbX/iFL/xlMGNT9FbcpvorxuaUglOVk6QY9W57t5angGK3ZNTYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991805; c=relaxed/simple;
	bh=ajeFOpfVo4z7TIpTFRmHzatgfl1dynUtsqBJXQmKN/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1os+SjD4zcIKzJ/9dTmxif/k95qdrRIUZ0xkdtz2VyNUWcN4dnutjY3vMeQQAyIDH7qvTg4duzH3qAQ8Oaq5tME93uAe7MEHnQSaMR29makh9szmC5ez3LL49+32h0jzQVIxSaBPI7FEl779gYSVZaYkkNagB8nnPxkjjeNqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E73F940004;
	Wed, 24 Apr 2024 20:50:00 +0000 (UTC)
Message-ID: <0187110f-e312-407e-85ec-8234ec029305@ghiti.fr>
Date: Wed, 24 Apr 2024 22:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] riscv: Flush the instruction cache during SMP
 bringup
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-2-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240327045035.368512-2-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 27/03/2024 05:49, Samuel Holland wrote:
> Instruction cache flush IPIs are sent only to CPUs in cpu_online_mask,
> so they will not target a CPU until it calls set_cpu_online() earlier in
> smp_callin(). As a result, if instruction memory is modified between the
> CPU coming out of reset and that point, then its instruction cache may
> contain stale data. Therefore, the instruction cache must be flushed
> after the set_cpu_online() synchronization point.
>
> Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v4)
>
> Changes in v4:
>   - New patch for v4
>
>   arch/riscv/kernel/smpboot.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index d41090fc3203..4b3c50da48ba 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -26,7 +26,7 @@
>   #include <linux/sched/task_stack.h>
>   #include <linux/sched/mm.h>
>   
> -#include <asm/cpufeature.h>
> +#include <asm/cacheflush.h>
>   #include <asm/cpu_ops.h>
>   #include <asm/irq.h>
>   #include <asm/mmu_context.h>
> @@ -234,9 +234,10 @@ asmlinkage __visible void smp_callin(void)
>   	riscv_user_isa_enable();
>   
>   	/*
> -	 * Remote TLB flushes are ignored while the CPU is offline, so emit
> -	 * a local TLB flush right now just in case.
> +	 * Remote cache and TLB flushes are ignored while the CPU is offline,
> +	 * so flush them both right now just in case.
>   	 */
> +	local_flush_icache_all();
>   	local_flush_tlb_all();
>   	complete(&cpu_running);
>   	/*


This should go into -fixes, would you mind sending this patch on its 
own? I think it is easier for Palmer.

Thanks,

Alex


