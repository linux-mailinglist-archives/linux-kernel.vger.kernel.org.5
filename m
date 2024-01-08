Return-Path: <linux-kernel+bounces-19129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E771B826869
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9270B281802
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CE8BF6;
	Mon,  8 Jan 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHCdtxSG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A779F4;
	Mon,  8 Jan 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LF0x5OqxikW92E6tW53GMsX7DXWMrPunKcFQ7/Vhjvk=; b=qHCdtxSGpgkfwJQp7Cyd/q3I1U
	Cd/6XAFW55VidI9bjw34x8u7O5ubcOKL1eRq+9o3inW7GXjzzBs2iDH1/p7KCiDrgdxWsd65zUZs8
	Ytz1J2Fqtw+Pbtf/lRdDccLljJbfy0YpZILTb0sibi0qyjFySnlE5swh3rEXeEf31ZWdS+Nh7OUfW
	RC1NSFXPG1eAplwKQbmvH1EliQ0M6e5jQUnyo8O52sY4/3N1BXYGu/26JaO4Uf9BrVySFwjklk8hw
	GIVIg4pgyx/jeh/VNKohWPeGhCyh/IpMC/gXeBZCUlm53JyIlh4Bhy9sfJHlDGgNdG6nm0WLYDzWy
	PdhIEs8g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMjiW-0048l9-1B;
	Mon, 08 Jan 2024 07:06:36 +0000
Message-ID: <34f6da8c-1e63-43a5-b9d4-d6865a5d2252@infradead.org>
Date: Sun, 7 Jan 2024 23:06:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com>
 <20240107-fencei-v4-2-d4cf2fb905d3@rivosinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240107-fencei-v4-2-d4cf2fb905d3@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 1/7/24 22:21, Charlie Jenkins wrote:
> Provide documentation that explains how to properly do CMODX in riscv.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
>  Documentation/arch/riscv/index.rst |  1 +
>  2 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
> new file mode 100644
> index 000000000000..71598850e131
> --- /dev/null
> +++ b/Documentation/arch/riscv/cmodx.rst
> @@ -0,0 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================================================
> +Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
> +==============================================================================
> +
> +CMODX is a programming technique where a program executes instructions that were
> +modified by the program itself. Instruction storage and the instruction cache
> +(icache) is not guaranteed to be synchronized on RISC-V hardware. Therefore, the

            are not

> +program must enforce its own synchronization with the unprivileged fence.i
> +instruction.
> +
> +However, the default Linux ABI prohibits the use of fence.i in userspace
> +applications. At any point the scheduler may migrate a task onto a new hart. If
> +migration occurs after the userspace synchronized the icache and instruction
> +storage with fence.i, the icache will no longer be clean. This is due to the
> +behavior of fence.i only affecting the hart that it is called on. Thus, the hart
> +that the task has been migrated to, may not have synchronized instruction

                                   to may not

> +storage and icache.
> +
> +There are two ways to solve this problem: use the riscv_flush_icache() syscall,
> +or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
> +userspace. The syscall performs a one-off icache flushing operation. The prctl
> +changes the Linux ABI to allow userspace to emit icache flushing operations.
> +
> +1.  prctl() Interface
> +---------------------

Why is "1." needed here? or is it?

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
> +		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, 0);
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
>      patch-acceptance
>      uabi
>      vector
> +    cmodx
>  
>      features
>  
> 

Thanks.
-- 
#Randy

