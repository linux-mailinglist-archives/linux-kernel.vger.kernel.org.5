Return-Path: <linux-kernel+bounces-70776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7232859C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB2281A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCB20303;
	Mon, 19 Feb 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4JRVBpl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB8C8D6;
	Mon, 19 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324393; cv=none; b=AxcooZ2iGPRRWlaIkxYoPG1BZjQmpRYy3xsNyiyWRF+gCQLEakDnBgsNSErjR8vm80Fv0qz+a0AXvY3o2LugI0qe9VWy1avOl+rftWve8wz1X6r9TJqOV/lNo/TWSgVxqTl/LHH4SrFwrvDbfib/D2Cpp8eo4KDgobZQ1WyK+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324393; c=relaxed/simple;
	bh=1AE+JZg/i9ql7giDuNGWy1AG4WO9ss9G3PqIKCX8CLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQmhuQ0Qkaj4AOKuzn+VcbNOWZlmxbVUh6q7B14IdurGmtCtLOaYaK+2RRsNzTtbUajMCzOEgIPrchUIPDxHIutoXsYTIkkBKeHJenXvDpXO3lq1SsBfknma1f/1SwiSuXGQzwpzKal3+BjHeqQgEOtZieU7fGhHPzlX6XL029M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4JRVBpl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708324391; x=1739860391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1AE+JZg/i9ql7giDuNGWy1AG4WO9ss9G3PqIKCX8CLM=;
  b=A4JRVBplwpaqp55Wz7HfqkpUBdtRupKD3UhI7HKS7pZohO3WaG4a16Xh
   B6THZCeirbFuXsKkmApART5aKV/tVRusKCY+oUy3K8VJQgOViHhR+ZyO4
   /TCo+CbLimMy1K30PvCp93NQu9/LEX738boqEUj7cTCykw2YpwRhxTLDC
   61BLH4Po68PURxTGydYY4GxOccXhKhx9z+2qP+/jSC+2VG0da8jl0qO4/
   xX8Lfgd3F0lFMMBSzIIDT2gYnBvDqFxhw6QxWKTJW1b/3XvXWKgIZFkF6
   15ynIZ0EKCaRMKWUs8kh4KIolAjjxbBiqyS5fJwjtJYRauZBr9XuvIqbz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2252261"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2252261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4657685"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:33:06 -0800
Message-ID: <9699d30b-f6cb-44d5-ae58-0bdefe3f24eb@intel.com>
Date: Mon, 19 Feb 2024 08:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
To: Changbin Du <changbin.du@huawei.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
 changbin.du@gmail.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
References: <20240217074046.4100789-1-changbin.du@huawei.com>
 <20240217074046.4100789-3-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240217074046.4100789-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/24 09:40, Changbin Du wrote:
> Currently, the instructions of samples are shown as raw hex strings
> which are hard to read. x86 has a special option '--xed' to disassemble
> the hex string via intel XED tool.
> 
> Here we use capstone as our disassembler engine to give more friendly
> instructions. We select libcapstone because capstone can provide more
> insn details. Perf will fallback to raw instructions if libcapstone is
> not available.
> 
> The advantages compared to XED tool:
>  * Support arm, arm64, x86-32, x86_64 (more could be supported),
>    xed only for x86_64.
>  * Immediate address operands are shown as symbol+offs.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

This is the only patch of V8 that made it to my inbox, Namhyung
also mentioned problems receiving V7, but the patches are on lore.

For whole patch set:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> v4:
>   - fix conflicting header bpf.h problem, aka, capstone/bpf.h and
>     uapi/linux/bpf.h. (Namhyung Kim, Adrian Hunter)
> v3:
>   - show warning msg if libcapstone is not available.
> v2:
>   - line up the output by preceding two tabs. (Adrian Hunter)
>   - removed the tailing space. (Adrian Hunter)
>   - forward declaration for perf_sample, thread, machine. (Adrian Hunter)
>   - other trivial fixes (Adrian Hunter)
> ---
>  tools/perf/builtin-script.c  |   8 +--
>  tools/perf/util/Build        |   1 +
>  tools/perf/util/print_insn.c | 135 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/print_insn.h |  16 +++++
>  tools/perf/util/thread.h     |   1 -
>  5 files changed, 155 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/util/print_insn.c
>  create mode 100644 tools/perf/util/print_insn.h
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b1f57401ff23..4817a37f16e2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -34,6 +34,7 @@
>  #include "util/event.h"
>  #include "ui/ui.h"
>  #include "print_binary.h"
> +#include "print_insn.h"
>  #include "archinsn.h"
>  #include <linux/bitmap.h>
>  #include <linux/kernel.h>
> @@ -1511,11 +1512,8 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  	if (PRINT_FIELD(INSNLEN))
>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
>  	if (PRINT_FIELD(INSN) && sample->insn_len) {
> -		int i;
> -
> -		printed += fprintf(fp, " insn:");
> -		for (i = 0; i < sample->insn_len; i++)
> -			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
> +		printed += fprintf(fp, " insn: ");
> +		printed += sample__fprintf_insn_raw(sample, fp);
>  	}
>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8027f450fa3e..2cbeeb79b6ef 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -32,6 +32,7 @@ perf-y += perf_regs.o
>  perf-y += perf-regs-arch/
>  perf-y += path.o
>  perf-y += print_binary.o
> +perf-y += print_insn.o
>  perf-y += rlimit.o
>  perf-y += argv_split.o
>  perf-y += rbtree.o
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> new file mode 100644
> index 000000000000..459e0e93d7b1
> --- /dev/null
> +++ b/tools/perf/util/print_insn.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Instruction binary disassembler based on capstone.
> + *
> + * Author(s): Changbin Du <changbin.du@huawei.com>
> + */
> +#include <string.h>
> +#include <stdbool.h>
> +#include "debug.h"
> +#include "sample.h"
> +#include "symbol.h"
> +#include "machine.h"
> +#include "thread.h"
> +#include "print_insn.h"
> +
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	for (int i = 0; i < sample->insn_len; i++) {
> +		printed += fprintf(fp, "%02x", (unsigned char)sample->insn[i]);
> +		if (sample->insn_len - i > 1)
> +			printed += fprintf(fp, " ");
> +	}
> +	return printed;
> +}
> +
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +#include <capstone/capstone.h>
> +
> +static int capstone_init(struct machine *machine, csh *cs_handle)
> +{
> +	cs_arch arch;
> +	cs_mode mode;
> +
> +	if (machine__is(machine, "x86_64")) {
> +		arch = CS_ARCH_X86;
> +		mode = CS_MODE_64;
> +	} else if (machine__normalized_is(machine, "x86")) {
> +		arch = CS_ARCH_X86;
> +		mode = CS_MODE_32;
> +	} else if (machine__normalized_is(machine, "arm64")) {
> +		arch = CS_ARCH_ARM64;
> +		mode = CS_MODE_ARM;
> +	} else if (machine__normalized_is(machine, "arm")) {
> +		arch = CS_ARCH_ARM;
> +		mode = CS_MODE_ARM + CS_MODE_V8;
> +	} else if (machine__normalized_is(machine, "s390")) {
> +		arch = CS_ARCH_SYSZ;
> +		mode = CS_MODE_BIG_ENDIAN;
> +	} else {
> +		return -1;
> +	}
> +
> +	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
> +		pr_warning_once("cs_open failed\n");
> +		return -1;
> +	}
> +
> +	if (machine__normalized_is(machine, "x86")) {
> +		cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +		/*
> +		 * Resolving address operands to symbols is implemented
> +		 * on x86 by investigating instruction details.
> +		 */
> +		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> +	}
> +
> +	return 0;
> +}
> +
> +static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
> +			     cs_insn *insn, FILE *fp)
> +{
> +	struct addr_location al;
> +	size_t printed = 0;
> +
> +	if (insn->detail && insn->detail->x86.op_count == 1) {
> +		cs_x86_op *op = &insn->detail->x86.operands[0];
> +
> +		addr_location__init(&al);
> +		if (op->type == X86_OP_IMM &&
> +		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
> +			printed += fprintf(fp, "%s ", insn[0].mnemonic);
> +			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
> +			addr_location__exit(&al);
> +			return printed;
> +		}
> +		addr_location__exit(&al);
> +	}
> +
> +	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> +	return printed;
> +}
> +
> +size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> +				struct machine *machine, FILE *fp)
> +{
> +	csh cs_handle;
> +	cs_insn *insn;
> +	size_t count;
> +	size_t printed = 0;
> +	int ret;
> +
> +	/* TODO: Try to initiate capstone only once but need a proper place. */
> +	ret = capstone_init(machine, &cs_handle);
> +	if (ret < 0) {
> +		/* fallback */
> +		return sample__fprintf_insn_raw(sample, fp);
> +	}
> +
> +	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
> +			  sample->ip, 1, &insn);
> +	if (count > 0) {
> +		if (machine__normalized_is(machine, "x86"))
> +			printed += print_insn_x86(sample, thread, &insn[0], fp);
> +		else
> +			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> +		cs_free(insn, count);
> +	} else {
> +		printed += fprintf(fp, "illegal instruction");
> +	}
> +
> +	cs_close(&cs_handle);
> +	return printed;
> +}
> +#else
> +size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
> +				struct thread *thread __maybe_unused,
> +				struct machine *machine __maybe_unused,
> +				FILE *fp __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> new file mode 100644
> index 000000000000..465bdcfcc2fd
> --- /dev/null
> +++ b/tools/perf/util/print_insn.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef PERF_PRINT_INSN_H
> +#define PERF_PRINT_INSN_H
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +
> +struct perf_sample;
> +struct thread;
> +struct machine;
> +
> +size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> +				struct machine *machine, FILE *fp);
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> +
> +#endif /* PERF_PRINT_INSN_H */
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 0df775b5c110..df344262eaee 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -13,7 +13,6 @@
>  #include <strlist.h>
>  #include <intlist.h>
>  #include "rwsem.h"
> -#include "event.h"
>  #include "callchain.h"
>  #include <internal/rc_check.h>
>  


