Return-Path: <linux-kernel+bounces-135911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B289CCFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24ECEB24C24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A7C146D77;
	Mon,  8 Apr 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSr5crmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA681465BC;
	Mon,  8 Apr 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608556; cv=none; b=dqP7bmj2wzyNXheJ9K+rEiNwjPzGO/WEyCxF8rU54aEAMrSYR+5PqqEP9cybEo+c7qEOwQToV/UctObt8Pe7U60xDgl9rw53/i9ZmXx1kvl9+M7lR64I4EcgrYkvOzerPwVQpW9klLKFgFov7hZ89BH6FazH5XS4boQkJi/3ROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608556; c=relaxed/simple;
	bh=y1JwbyVZ5NrQUheqw05/5mT5plILgguj4cqylnGnTaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv10dXBarH9fS9gwzdeRV/GYUYrktYDqMKp9g1QP0P6s9bkFT0NJnfd1+kPdo5aT3Yk1gPsUdA/AF1+MWI8KjtB7Itz8Rdd9WigwGdwWxTGmAlv5xTpDrxS3UcfxOHO9b0/8AonWpgzlBbjlWoEFPwcGe6Vc4aAUEeA4NcffqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSr5crmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213FC433F1;
	Mon,  8 Apr 2024 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712608556;
	bh=y1JwbyVZ5NrQUheqw05/5mT5plILgguj4cqylnGnTaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSr5crmuZZIyKRfJGHpVq0sB+tgbeWkUQr/UCivBb8q32Odn7zATTtfvMyTVu1ZdE
	 zVRhTrdrCB/U6KPPVghTMt33HllzIGvEJUyKLwNzwACtT2tyarFv8OlIhMP5nIiGID
	 8EM3XSWV9jm0ojdyxbL4RIosHNKFvGUaqVD57/1kH2IlO7kXmpZFL8/AZQGJIrdyMM
	 Wf2JmrAM5A654/duL5UWr7a8oDEQsw2mtdmmo71a0TsUoBd/fyvvsJefeTlSyq+LGS
	 VlB3GROfXOTUNfg6eh4/cY7i6p4mH0F3BgCCbB/95zkgvL4BHlOpMyvpECD6YNUnX0
	 r4gMUzn05hxfw==
Date: Mon, 8 Apr 2024 17:35:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	changbin.du@huawei.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: Consolidate capstone print functions
Message-ID: <ZhRVKBdymD0Nq0ro@x1>
References: <ZfovVgjCm5oDbze9@tassilo>
 <20240322102158.19738-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322102158.19738-1-adrian.hunter@intel.com>

On Fri, Mar 22, 2024 at 12:21:58PM +0200, Adrian Hunter wrote:
> Consolidate capstone print functions, to reduce duplication. Amend call
> sites to use a file pointer for output, which is consistent with most
> perf tools print functions. Add print_opts with an option to print also
> the hex value of a resolved symbol+offset.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

I'll fix this:

  38    11.53 ubuntu:18.04                  : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    util/print_insn.c: In function 'print_insn_x86':
    util/print_insn.c:90:35: error: expected ')' before 'PRIx64'
         printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
                                       ^~~~~~
    util/print_insn.c:90:32: error: conversion lacks type at end of format [-Werror=format=]
         printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
                                    ^
    cc1: all warnings being treated as errors
    /git/perf-6.8.0/tools/build/Makefile.build:158: recipe for target 'util' failed
    make[3]: *** [util] Error 2
 
> 
> On 20/03/24 02:35, Andi Kleen wrote:
> > On Tue, Mar 19, 2024 at 08:52:33AM +0200, Adrian Hunter wrote:
> >> On 19/03/24 00:06, Andi Kleen wrote:
> >>>> Better to factor out a function that does not depend on "sample"
> >>>> e.g. see fprintf_insn_asm() below.
> >>>
> >>> this doesn't work because it completely ignores the need of the
> >>> cs_dump_insn caller for the path that i actually need for my feature,
> >>> which requires to return a string.  I didn't apply it.
> >>
> >> I would probably change the call sites because they already have a
> >> file descriptor, but output to memory is doable:
> > 
> >> 	FILE *fp = fmemopen(x->out, sizeof(x->out), "w+");
> > 
> > I considered using this at some point, but I'm sure there is some non glibc,
> > that people build perf with, that doesn't have fmemopen, so I didn't.
> 
> fmemopen() is POSIX since 2008
> 
> > 
> > Can we just use my version for now and if you prefer more refactor
> > please submit a follow on cleanup patch?
> 
> Sure, here is a follow on cleanup patch.
> 
> 
>  tools/perf/builtin-script.c  |  43 ++++++++++-----
>  tools/perf/util/print_insn.c | 103 ++++++++++++-----------------------
>  tools/perf/util/print_insn.h |   7 ++-
>  3 files changed, 67 insertions(+), 86 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 59933bd52e0f..6384acf8dad7 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1165,18 +1165,29 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
>  	return ret;
>  }
>  
> -static const char *any_dump_insn(struct perf_event_attr *attr __maybe_unused,
> -			struct perf_insn *x, uint64_t ip,
> -			u8 *inbuf, int inlen, int *lenp)
> +static int any_dump_insn(struct perf_event_attr *attr __maybe_unused,
> +			 struct perf_insn *x, uint64_t ip,
> +			 u8 *inbuf, int inlen, int *lenp,
> +			 FILE *fp)
>  {
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	if (PRINT_FIELD(BRSTACKDISASM)) {
> -		const char *p = cs_dump_insn(x, ip, inbuf, inlen, lenp);
> -		if (p)
> -			return p;
> +		int printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
> +					       (uint8_t *)inbuf, inlen, ip, lenp,
> +					       PRINT_INSN_IMM_HEX, fp);
> +
> +		if (printed > 0)
> +			return printed;
>  	}
>  #endif
> -	return dump_insn(x, ip, inbuf, inlen, lenp);
> +	return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
> +}
> +
> +static int add_padding(FILE *fp, int printed, int padding)
> +{
> +	if (printed >= 0 && printed < padding)
> +		printed += fprintf(fp, "%*s", padding - printed, "");
> +	return printed;
>  }
>  
>  static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
> @@ -1186,8 +1197,10 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			    struct thread *thread)
>  {
>  	int ilen = 0;
> -	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
> -			      any_dump_insn(attr, x, ip, inbuf, len, &ilen));
> +	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
> +
> +	printed += add_padding(fp, any_dump_insn(attr, x, ip, inbuf, len, &ilen, fp), 30);
> +	printed += fprintf(fp, "\t");
>  
>  	if (PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += fprintf(fp, "ilen: %d\t", ilen);
> @@ -1330,8 +1343,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  				break;
>  			} else {
>  				ilen = 0;
> -				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
> -						   any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen));
> +				printed += fprintf(fp, "\t%016" PRIx64 "\t", ip);
> +				printed += any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen, fp);
>  				if (PRINT_FIELD(BRSTACKINSNLEN))
>  					printed += fprintf(fp, "\tilen: %d", ilen);
>  				printed += fprintf(fp, "\n");
> @@ -1378,8 +1391,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		if (len <= 0)
>  			goto out;
>  		ilen = 0;
> -		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
> -			any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen));
> +		printed += fprintf(fp, "\t%016" PRIx64 "\t", sample->ip);
> +		printed += any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen, fp);
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> @@ -1389,8 +1402,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  	}
>  	for (off = 0; off <= end - start; off += ilen) {
>  		ilen = 0;
> -		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
> -				   any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen));
> +		printed += fprintf(fp, "\t%016" PRIx64 "\t", start + off);
> +		printed += any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen, fp);
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 8825330d435f..931a2c5293c9 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -72,59 +72,8 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
>  	return 0;
>  }
>  
> -static void dump_insn_x86(struct thread *thread, cs_insn *insn, struct perf_insn *x)
> -{
> -	struct addr_location al;
> -	bool printed = false;
> -
> -	if (insn->detail && insn->detail->x86.op_count == 1) {
> -		cs_x86_op *op = &insn->detail->x86.operands[0];
> -
> -		addr_location__init(&al);
> -		if (op->type == X86_OP_IMM &&
> -		    thread__find_symbol(thread, x->cpumode, op->imm, &al) &&
> -		    al.sym &&
> -		    al.addr < al.sym->end) {
> -			snprintf(x->out, sizeof(x->out), "%s %s+%#" PRIx64 " [%#" PRIx64 "]", insn[0].mnemonic,
> -					al.sym->name, al.addr - al.sym->start, op->imm);
> -			printed = true;
> -		}
> -		addr_location__exit(&al);
> -	}
> -
> -	if (!printed)
> -		snprintf(x->out, sizeof(x->out), "%s %s", insn[0].mnemonic, insn[0].op_str);
> -}
> -
> -const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
> -			 u8 *inbuf, int inlen, int *lenp)
> -{
> -	int ret;
> -	int count;
> -	cs_insn *insn;
> -	csh cs_handle;
> -
> -	ret = capstone_init(x->machine, &cs_handle, x->is64bit);
> -	if (ret < 0)
> -		return NULL;
> -
> -	count = cs_disasm(cs_handle, (uint8_t *)inbuf, inlen, ip, 1, &insn);
> -	if (count > 0) {
> -		if (machine__normalized_is(x->machine, "x86"))
> -			dump_insn_x86(x->thread, &insn[0], x);
> -		else
> -			snprintf(x->out, sizeof(x->out), "%s %s",
> -					insn[0].mnemonic, insn[0].op_str);
> -		*lenp = insn->size;
> -		cs_free(insn, count);
> -	} else {
> -		return NULL;
> -	}
> -	return x->out;
> -}
> -
> -static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
> -			     cs_insn *insn, FILE *fp)
> +static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
> +			     int print_opts, FILE *fp)
>  {
>  	struct addr_location al;
>  	size_t printed = 0;
> @@ -134,9 +83,11 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  
>  		addr_location__init(&al);
>  		if (op->type == X86_OP_IMM &&
> -		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
> +		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
>  			printed += fprintf(fp, "%s ", insn[0].mnemonic);
>  			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
> +			if (print_opts & PRINT_INSN_IMM_HEX)
> +				printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
>  			addr_location__exit(&al);
>  			return printed;
>  		}
> @@ -159,39 +110,53 @@ static bool is64bitip(struct machine *machine, struct addr_location *al)
>  		machine__normalized_is(machine, "s390");
>  }
>  
> -size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> -				struct machine *machine, FILE *fp,
> -				struct addr_location *al)
> +ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
> +			 bool is64bit, const uint8_t *code, size_t code_size,
> +			 uint64_t ip, int *lenp, int print_opts, FILE *fp)
>  {
> -	csh cs_handle;
> +	size_t printed;
>  	cs_insn *insn;
> +	csh cs_handle;
>  	size_t count;
> -	size_t printed = 0;
>  	int ret;
> -	bool is64bit = is64bitip(machine, al);
>  
>  	/* TODO: Try to initiate capstone only once but need a proper place. */
>  	ret = capstone_init(machine, &cs_handle, is64bit);
> -	if (ret < 0) {
> -		/* fallback */
> -		return sample__fprintf_insn_raw(sample, fp);
> -	}
> +	if (ret < 0)
> +		return ret;
>  
> -	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
> -			  sample->ip, 1, &insn);
> +	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
>  	if (count > 0) {
>  		if (machine__normalized_is(machine, "x86"))
> -			printed += print_insn_x86(sample, thread, &insn[0], fp);
> +			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
>  		else
> -			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> +			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> +		if (lenp)
> +			*lenp = insn->size;
>  		cs_free(insn, count);
>  	} else {
> -		printed += fprintf(fp, "illegal instruction");
> +		printed = -1;
>  	}
>  
>  	cs_close(&cs_handle);
>  	return printed;
>  }
> +
> +size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> +				struct machine *machine, FILE *fp,
> +				struct addr_location *al)
> +{
> +	bool is64bit = is64bitip(machine, al);
> +	ssize_t printed;
> +
> +	printed = fprintf_insn_asm(machine, thread, sample->cpumode, is64bit,
> +				   (uint8_t *)sample->insn, sample->insn_len,
> +				   sample->ip, NULL, 0, fp);
> +	if (printed < 0)
> +		return sample__fprintf_insn_raw(sample, fp);
> +
> +	return printed;
> +}
>  #else
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
>  				struct thread *thread __maybe_unused,
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index c2a6391a45ce..07d11af3fc1c 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -10,10 +10,13 @@ struct thread;
>  struct machine;
>  struct perf_insn;
>  
> +#define PRINT_INSN_IMM_HEX		(1<<0)
> +
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>  				struct machine *machine, FILE *fp, struct addr_location *al);
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> -const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
> -                         u8 *inbuf, int inlen, int *lenp);
> +ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
> +			 bool is64bit, const uint8_t *code, size_t code_size,
> +			 uint64_t ip, int *lenp, int print_opts, FILE *fp);
>  
>  #endif /* PERF_PRINT_INSN_H */
> -- 
> 2.34.1

