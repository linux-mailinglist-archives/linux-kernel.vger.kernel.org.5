Return-Path: <linux-kernel+bounces-11335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCD81E4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 04:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2574E282C28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCB1A29C;
	Tue, 26 Dec 2023 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzK+NX5x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15418EBE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 03:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08C2C433C7;
	Tue, 26 Dec 2023 03:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703563011;
	bh=bALt5fFkdTtCWQl6cTTgbR1RwayXwAm/GmiyEsQiowQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzK+NX5x0tO3nUF2uxnFu2Ti44+SeA8xMdh+FzKjDWNxGKIeXFsTff1l/BLDVmNSv
	 OkoB4cQpQXeDTLZBSxR7M9Ne8GuY6ifGzpi3/I6eIGtIj5LRrENT6PWVFzTQjs59DL
	 3HKNRerMHLWAmWtUvfJZ74WCgflt3xofhOcIVtrRVrU35Qd6Xzmijq33RK6FJkJXLN
	 GrEN4JRIiRCBx6WWfg0/O2e83TRibgU509Bijm/qcBUjl5bKDRJ02Yp9z+R9LHYnOA
	 i0oIIv8l5AuPCbeRX4PfPKzY3sck/qOAersoY8le76FCjMyRkKM9l/0F5kU51OX7HV
	 nX4P/26txEReQ==
Date: Mon, 25 Dec 2023 22:56:46 -0500
From: Guo Ren <guoren@kernel.org>
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Improve exception and system call latency
Message-ID: <ZYpO/pfbea7hWu3r@gmail.com>
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225040018.1660554-1-antonb@tenstorrent.com>

On Sun, Dec 24, 2023 at 08:00:18PM -0800, Anton Blanchard wrote:
> Many CPUs implement return address branch prediction as a stack. The
> RISCV architecture refers to this as a return address stack (RAS). If
> this gets corrupted then the CPU will mispredict at least one but
> potentally many function returns.
> 
> There are two issues with the current RISCV exception code:
> 
> - We are using the alternate link stack (x5/t0) for the indirect branch
>   which makes the hardware think this is a function return. This will
>   corrupt the RAS.
> 
> - We modify the return address of handle_exception to point to
>   ret_from_exception. This will also corrupt the RAS.
> 
> Testing the null system call latency before and after the patch:
> 
> Visionfive2 (StarFive JH7110 / U74)
> baseline: 189.87 ns
> patched:  176.76 ns
> 
> Lichee pi 4a (T-Head TH1520 / C910)
> baseline: 666.58 ns
> patched:  636.90 ns
> 
> Just over 7% on the U74 and just over 4% on the C910.

Yes, the wrong "jalr zero, t0/ra" would pop RAS and destroy the RAS
layout of the hardware for the userspace. How about giving a fake push
for the RAS to connect "jalr zero, ra" of sub-function call return? I'm
curious if you could measure the difference with only one RAS
misprediction.

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..94c7d2be35d0 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -93,7 +93,8 @@ SYM_CODE_START(handle_exception)
        bge s4, zero, 1f

        /* Handle interrupts */
-       tail do_irq
+       auipc t0, do_irq
+       jalr  t0, t0
 1:
        /* Handle other exceptions */
        slli t0, s4, RISCV_LGPTR
@@ -103,9 +104,10 @@ SYM_CODE_START(handle_exception)
        /* Check if exception code lies within bounds */
        bgeu t0, t2, 1f
        REG_L t0, 0(t0)
-       jr t0
+       jalr t0, t0
 1:
-       tail do_trap_unknown
+       auipc t0, do_trap_unknown
+       jalr  t0, t0
 SYM_CODE_END(handle_exception)

You could prepare a deeper userspace stack calling if you want better
measurement results.

> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> This introduces some complexity in the stackframe walk code. PowerPC
> resolves the multiple exception exit paths issue by placing a value into
> the exception stack frame (basically the word "REGS") that the stack frame
> code can look for. Perhaps something to look at.
> 
>  arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
>  arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..89af35edbf6c 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
>  	scs_load_current_if_task_changed s5
>  
>  	move a0, sp /* pt_regs */
> -	la ra, ret_from_exception
>  
>  	/*
>  	 * MSB of cause differentiates between
> @@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
>  	bge s4, zero, 1f
>  
>  	/* Handle interrupts */
> -	tail do_irq
> +	call do_irq
> +.globl ret_from_irq_exception
> +ret_from_irq_exception:
> +	j ret_from_exception
>  1:
>  	/* Handle other exceptions */
>  	slli t0, s4, RISCV_LGPTR
> @@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
>  	la t2, excp_vect_table_end
>  	add t0, t1, t0
>  	/* Check if exception code lies within bounds */
> -	bgeu t0, t2, 1f
> -	REG_L t0, 0(t0)
> -	jr t0
> -1:
> -	tail do_trap_unknown
> +	bgeu t0, t2, 3f
> +	REG_L t1, 0(t0)
> +2:	jalr ra,t1
> +.globl ret_from_other_exception
> +ret_from_other_exception:
> +	j ret_from_exception
> +3:
> +
> +	la t1, do_trap_unknown
> +	j 2b
>  SYM_CODE_END(handle_exception)
>  
>  /*
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 64a9c093aef9..b9cd131bbc4c 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -17,6 +17,18 @@
>  #ifdef CONFIG_FRAME_POINTER
>  
>  extern asmlinkage void ret_from_exception(void);
> +extern asmlinkage void ret_from_irq_exception(void);
> +extern asmlinkage void ret_from_other_exception(void);
> +
> +static inline bool is_exception_frame(unsigned long pc)
> +{
> +	if ((pc == (unsigned long)ret_from_exception) ||
> +	    (pc == (unsigned long)ret_from_irq_exception) ||
> +	    (pc == (unsigned long)ret_from_other_exception))
> +		return true;
> +
> +	return false;
> +}
We needn't put too many .globl in the entry.S, and just check that pc is
in SYM_CODE_START/END(handle_exception), then entry.S would be cleaner:

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..d452d5f12b1b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
        scs_load_current_if_task_changed s5

        move a0, sp /* pt_regs */

        /*
         * MSB of cause differentiates between
@@ -93,7 +92,8 @@ SYM_CODE_START(handle_exception)
        bge s4, zero, 1f

        /* Handle interrupts */
        call do_irq
        j ret_from_exception
 1:
        /* Handle other exceptions */
        slli t0, s4, RISCV_LGPTR
@@ -102,10 +102,12 @@ SYM_CODE_START(handle_exception)
        add t0, t1, t0
        /* Check if exception code lies within bounds */
        bgeu t0, t2, 1f
        REG_L ra, 0(t0)
        jalr ra, ra
        j ret_from_exception
 1:
        call do_trap_unknown
        j ret_from_exception
 SYM_CODE_END(handle_exception)


>  
>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			     bool (*fn)(void *, unsigned long), void *arg)
> @@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			fp = frame->fp;
>  			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>  						   &frame->ra);
> -			if (pc == (unsigned long)ret_from_exception) {
> +			if (is_exception_frame(pc)) {
>  				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
>  					break;
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

