Return-Path: <linux-kernel+bounces-166537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C027B8B9C02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF851F223FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2A13C693;
	Thu,  2 May 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+sY4JEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1DC8F3;
	Thu,  2 May 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658710; cv=none; b=fmqNwrRPb+UzhPuyjzIxt/ryb2XcLr0CTOg1heaZWshjppmqrNUs9AxCWDnmegMzqWa2sZmegzzi5GkmuQ3xDsXNEpd/ej8oDDpu3i5QDl+LGB+BzYMq8CFnMU4Nq3/JCZxrn7LptZ+eUrOS1RP63pCHOuR1BZK+2sBWI0nEFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658710; c=relaxed/simple;
	bh=8y14gJObKP5c3w67SOb6CXspdVuxp4RGI5WB7sMX8w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAd+rUoDVzn0/lIrqAFQCJwIjpmfmCEbPl45nS3xFqq5uN617rx7jo+1PL3hgBpEkF1QirIXqwEr6KBp8VXLrgx4r/vTTWd0ATO1ThSYcg7SdE7uVF5Qow+duK+y91HK0OG8fZLtW+WPDmNNKL+McwhHhsf/LprqUP/249inmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+sY4JEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57987C113CC;
	Thu,  2 May 2024 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714658709;
	bh=8y14gJObKP5c3w67SOb6CXspdVuxp4RGI5WB7sMX8w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+sY4JEBHbXdxo0UZF+JgqYUOIWp66mt2/s3OMmqt7fgd937BR3wvn1JdXLofu/S5
	 NWMRuJ1BBr0kGLUso4UvUSgo8ETaSpk2ChZtcMoi5F8nRapoBZGmf9abp4Vl7oHWQY
	 iZnOMgP8rMZ4BwNbyiwzSdNKZy5Mp1vpmXT2qFobP1IdLKSt+PpDT+IH2e8fotJDlX
	 3kX0kUMqBnal/z0BAwj1FZy8eeup3T/7nG/ipWFPBvB50fKNGhOx3oG2tm9/mer23m
	 0Hox6JjEpbLdra428fTXiKcPkuDtfTegkfkuijH3PcEw7jAfSSYiI66QyyHSHgNdMh
	 mfTiXW1fMhEiQ==
Date: Thu, 2 May 2024 11:05:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Check memory access with two
 registers
Message-ID: <ZjOdkHraWXZIuSy_@x1>
References: <20240502060011.1838090-1-namhyung@kernel.org>
 <20240502060011.1838090-5-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502060011.1838090-5-namhyung@kernel.org>

On Wed, May 01, 2024 at 11:00:09PM -0700, Namhyung Kim wrote:
> The following instruction pattern is used to access a global variable.
> 
>   mov     $0x231c0, %rax
>   movsql  %edi, %rcx
>   mov     -0x7dc94ae0(,%rcx,8), %rcx
>   cmpl    $0x0, 0xa60(%rcx,%rax,1)     <<<--- here
> 
> The first instruction set the address of the per-cpu variable (here, it
> is 'runqueus' of struct rq).  The second instruction seems like a cpu

You mean 'runqueues', i.e. this one:

kernel/sched/core.c
DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);

?

But that 0xa60 would be in an alignment hole, at least in:

$ pahole --hex rq | egrep 0xa40 -A12
	struct mm_struct *         prev_mm;              /* 0xa40   0x8 */
	unsigned int               clock_update_flags;   /* 0xa48   0x4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        clock;                /* 0xa50   0x8 */

	/* XXX 40 bytes hole, try to pack */

	/* --- cacheline 42 boundary (2688 bytes) --- */
	u64                        clock_task __attribute__((__aligned__(64))); /* 0xa80   0x8 */
	u64                        clock_pelt;           /* 0xa88   0x8 */
	long unsigned int          lost_idle_time;       /* 0xa90   0x8 */
$ uname -a
Linux toolbox 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
$

The paragraph then reads:

----
The first instruction set the address of the per-cpu variable (here, it
is 'runqueues' of type 'struct rq').  The second instruction seems like
a cpu number of the per-cpu base.  The third instruction get the base
offset of per-cpu area for that cpu.  The last instruction compares the
value of the per-cpu variable at the offset of 0xa60.
----

Ok?

> number of the per-cpu base.  The third instruction get the base offset
> of per-cpu area for that cpu.  The last instruction compares the value
> of the per-cpu variable at the offset of 0xa60.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 44 +++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index f1e52a531563..245e3ef3e2ff 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1031,22 +1031,37 @@ static void update_insn_state_x86(struct type_state *state,
>  		else if (has_reg_type(state, sreg) &&
>  			 state->regs[sreg].kind == TSR_KIND_PERCPU_BASE) {
>  			u64 ip = dloc->ms->sym->start + dl->al.offset;
> +			u64 var_addr = src->offset;
>  			int offset;
>  
> +			if (src->multi_regs) {
> +				int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
> +
> +				if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
> +				    state->regs[reg2].kind == TSR_KIND_CONST)
> +					var_addr += state->regs[reg2].imm_value;
> +			}
> +
>  			/*
>  			 * In kernel, %gs points to a per-cpu region for the
>  			 * current CPU.  Access with a constant offset should
>  			 * be treated as a global variable access.
>  			 */
> -			if (get_global_var_type(cu_die, dloc, ip, src->offset,
> +			if (get_global_var_type(cu_die, dloc, ip, var_addr,
>  						&offset, &type_die) &&
>  			    die_get_member_type(&type_die, offset, &type_die)) {
>  				tsr->type = type_die;
>  				tsr->kind = TSR_KIND_TYPE;
>  				tsr->ok = true;
>  
> -				pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d",
> -					     insn_offset, src->offset, sreg, dst->reg1);
> +				if (src->multi_regs) {
> +					pr_debug_dtp("mov [%x] percpu %#x(reg%d,reg%d) -> reg%d",
> +						     insn_offset, src->offset, src->reg1,
> +						     src->reg2, dst->reg1);
> +				} else {
> +					pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d",
> +						     insn_offset, src->offset, sreg, dst->reg1);
> +				}
>  				pr_debug_type_name(&tsr->type, tsr->kind);
>  			} else {
>  				tsr->ok = false;
> @@ -1340,6 +1355,17 @@ static int check_matching_type(struct type_state *state,
>  
>  		pr_debug_dtp(" percpu var\n");
>  
> +		if (dloc->op->multi_regs) {
> +			int reg2 = dloc->op->reg2;
> +
> +			if (dloc->op->reg2 == reg)
> +				reg2 = dloc->op->reg1;
> +
> +			if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
> +			    state->regs[reg2].kind == TSR_KIND_CONST)
> +				var_addr += state->regs[reg2].imm_value;
> +		}
> +
>  		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
>  					&var_offset, type_die)) {
>  			dloc->type_offset = var_offset;
> @@ -1527,8 +1553,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
>  		found = find_data_type_insn(dloc, reg, &basic_blocks, var_types,
>  					    cu_die, type_die);
>  		if (found > 0) {
> -			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x\n",
> -				     dloc->op->offset, reg, dloc->type_offset);
> +			char buf[64];
> +
> +			if (dloc->op->multi_regs)
> +				snprintf(buf, sizeof(buf), "reg%d, reg%d",
> +					 dloc->op->reg1, dloc->op->reg2);
> +			else
> +				snprintf(buf, sizeof(buf), "reg%d", dloc->op->reg1);
> +
> +			pr_debug_dtp("found by insn track: %#x(%s) type-offset=%#x\n",
> +				     dloc->op->offset, buf, dloc->type_offset);
>  			pr_debug_type_name(type_die, TSR_KIND_TYPE);
>  			ret = 0;
>  			break;
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

