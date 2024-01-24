Return-Path: <linux-kernel+bounces-36535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE283A2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DC11F27E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AD17C91;
	Wed, 24 Jan 2024 07:19:52 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC817C65;
	Wed, 24 Jan 2024 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706080791; cv=none; b=WUgAHZVrKGHxjj5ODqLZtrMLRxoeE8cl+dIvty6TVHo40PN+VhFrWzyu53P5V2NHL9kXlRqyWcx6o08Gs+dZu68UyXF7LLdnokBEEkI2ODuEAoNrbxizIRFY/f16vrqc+B2NT4t3IlgNT8VCEqiaggwhpdBulNOaZOTGb8O1TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706080791; c=relaxed/simple;
	bh=P1H368CplIrSMK/Tn+EOuciQSfSHbP8vxDXizZuog+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LigL5Nt7NrXkvu1YP5V53YtcDcaoNrNTqadSfWafE996XqiP53yX2q9iG8/GhNtYM5hQjA6EKgOztG+EaxSK9KP6uiNICyI2JOJONRBIl3YL5+DrYqSjPrftb38jtVtr9Ah0zYfL+4ZVT5EvDJGB/6DTw/G2O6RtYALrwIvyneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 185EDE000C;
	Wed, 24 Jan 2024 07:19:42 +0000 (UTC)
Message-ID: <26808f34-d9c4-404a-bf09-45c4aff139ad@ghiti.fr>
Date: Wed, 24 Jan 2024 08:19:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
References: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
 <20240123-fencei-v9-2-71411bfe8d71@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240123-fencei-v9-2-71411bfe8d71@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 24/01/2024 00:29, Charlie Jenkins wrote:
> Provide documentation that explains how to properly do CMODX in riscv.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> ---
>   Documentation/arch/riscv/cmodx.rst | 96 ++++++++++++++++++++++++++++++++++++++
>   Documentation/arch/riscv/index.rst |  1 +
>   2 files changed, 97 insertions(+)
>
> diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
> new file mode 100644
> index 000000000000..2ad46129d812
> --- /dev/null
> +++ b/Documentation/arch/riscv/cmodx.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================================================
> +Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
> +==============================================================================
> +
> +CMODX is a programming technique where a program executes instructions that were
> +modified by the program itself. Instruction storage and the instruction cache
> +(icache) are not guaranteed to be synchronized on RISC-V hardware. Therefore, the
> +program must enforce its own synchronization with the unprivileged fence.i
> +instruction.
> +
> +However, the default Linux ABI prohibits the use of fence.i in userspace
> +applications. At any point the scheduler may migrate a task onto a new hart. If
> +migration occurs after the userspace synchronized the icache and instruction
> +storage with fence.i, the icache will no longer be clean. This is due to the


Nit: I think you mean "the icache on the new hart will no longer be clean".


> +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> +that the task has been migrated to may not have synchronized instruction storage
> +and icache.
> +
> +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
> +userspace. The syscall performs a one-off icache flushing operation. The prctl
> +changes the Linux ABI to allow userspace to emit icache flushing operations.
> +
> +As an aside, "deferred" icache flushes can sometimes be triggered in the kernel.
> +At the time of writing, this only occurs during the riscv_flush_icache() syscall
> +and when the kernel uses copy_to_user_page(). These deferred flushes happen only
> +when the memory map being used by a hart changes. If the prctl() context caused
> +an icache flush, this deferred icache flush will be skipped as it is redundant.
> +Therefore, there will be no additional flush when using the riscv_flush_icache()
> +syscall inside of the prctl() context.
> +
> +prctl() Interface
> +---------------------
> +
> +Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
> +remaining arguments will be delegated to the riscv_set_icache_flush_ctx
> +function detailed below.
> +
> +.. kernel-doc:: arch/riscv/mm/cacheflush.c
> +	:identifiers: riscv_set_icache_flush_ctx
> +
> +Example usage:
> +
> +The following files are meant to be compiled and linked with each other. The
> +modify_instruction() function replaces an add with 0 with an add with one,
> +causing the instruction sequence in get_value() to change from returning a zero
> +to returning a one.
> +
> +cmodx.c::
> +
> +	#include <stdio.h>
> +	#include <sys/prctl.h>
> +
> +	extern int get_value();
> +	extern void modify_instruction();
> +
> +	int main()
> +	{
> +		int value = get_value();
> +		printf("Value before cmodx: %d\n", value);
> +
> +		// Call prctl before first fence.i is called inside modify_instruction
> +		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
> +		modify_instruction();
> +
> +		value = get_value();
> +		printf("Value after cmodx: %d\n", value);
> +		return 0;
> +	}
> +
> +cmodx.S::
> +
> +	.option norvc
> +
> +	.text
> +	.global modify_instruction
> +	modify_instruction:
> +	lw a0, new_insn
> +	lui a5,%hi(old_insn)
> +	sw  a0,%lo(old_insn)(a5)
> +	fence.i
> +	ret
> +
> +	.section modifiable, "awx"
> +	.global get_value
> +	get_value:
> +	li a0, 0
> +	old_insn:
> +	addi a0, a0, 0
> +	ret
> +
> +	.data
> +	new_insn:
> +	addi a0, a0, 1
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
> index 4dab0cb4b900..eecf347ce849 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -13,6 +13,7 @@ RISC-V architecture
>       patch-acceptance
>       uabi
>       vector
> +    cmodx
>   
>       features
>   
>

I don't know how man pages are synchronized with new additions in the 
kernel, do you? It would be nice to have this new prctl documented for 
userspace.

Thanks,

Alex


