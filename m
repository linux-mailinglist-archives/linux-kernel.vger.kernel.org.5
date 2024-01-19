Return-Path: <linux-kernel+bounces-31499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EA832F09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C791C2357F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99423B1;
	Fri, 19 Jan 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeHqFEQu"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330A56778;
	Fri, 19 Jan 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689570; cv=none; b=sqwLoT010IrUzkwdkAfTMpMIzKH1i4ycgFMM8h0XSokL+OwrR/MMu37CAFB1SuBSmJ3lLKut20AkIxhr7bwiMS5Gih1oqEyoZ1vXglCznAIkm5jwTc/vS2kPSRloqzlpPKiBB+ruTuruh0A2m4ZhV8eh4QyY+ESnuPu7cdVkJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689570; c=relaxed/simple;
	bh=1Gn1OgtQ5ch+2QdJcArCviRv9vCtxy1FKMEYMeTXq4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua2HrqWRGoYPasvYxUwGbhXrBS2x61LmN6gs/y6Il+balrCo7dz6U3PxnSu6tOJva4dZQDNymosx6HZ+E+9mYwnJVhWeidX7pRreOvIWAARz9nS5soRGhERSLaQDkQLaMRLq/TJH7K2FHG0JkxQG+sQpQMiPmNL2+BWypkfj2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeHqFEQu; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689569; x=1737225569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Gn1OgtQ5ch+2QdJcArCviRv9vCtxy1FKMEYMeTXq4s=;
  b=aeHqFEQuunkl9zsZaX1oR5eyu4LMkzEjRNQ/qsexY08jjC4SwWhQZh8b
   nKXLtXKeOJD5fHzv7brSY9J14nNpYuyeSVOyK5eM8G4aaL7KmQOBfRGHb
   N9IQuYAGuZSE6jxBX0eHbELL3WLEV/nalaQ5JMIH5uet0ny0JINgSlQTu
   zkPs6zDJinIUb9EVLAYltvHxmf2u+iUMxZ1Xq4zKZUib9n+kMlTrrpKiY
   HGy9ZXaHG5E46alh8eEm/vF7AymMY6Gg9QsqlbmhI8eryyOmws/agXHtY
   XVuyPEpjqFJm8zhO3xWlQ4aYr3uY2VbPZ+fxZtCTzhS1MpH32PxD3lMQn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404578759"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404578759"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778042466"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778042466"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:23 -0800
Message-ID: <e3463435-b879-4d72-9cab-c4bf951b9084@intel.com>
Date: Fri, 19 Jan 2024 20:39:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-3-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119104856.3617986-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 12:48, Changbin Du wrote:
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
> ---
>  tools/perf/builtin-script.c  |   8 +--
>  tools/perf/util/Build        |   1 +
>  tools/perf/util/print_insn.c | 122 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/print_insn.h |  14 ++++
>  4 files changed, 140 insertions(+), 5 deletions(-)
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

"insn:" seems unnecessary.  Also xed prints 2 tabs, which
helps line up the output.  Perhaps 1 tab and 2 spaces is
enough.

> +		printed += sample__fprintf_insn_raw(sample, fp);
>  	}
>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 988473bf907a..c33aab53d8dd 100644
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
> index 000000000000..162be4856f79
> --- /dev/null
> +++ b/tools/perf/util/print_insn.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Instruction binary disassembler based on capstone.
> + *
> + * Author(s): Changbin Du <changbin.du@huawei.com>
> + */
> +#include "print_insn.h"

Please put with the other non-system includes

> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include "util/debug.h"

util/ not needed

> +#include "util/symbol.h"

util/ not needed

> +#include "machine.h"
> +
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	for (int i = 0; i < sample->insn_len; i++)
> +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);

Why change this to put a space on the end?

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
> +	cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);

That's only needed for x86 isn't it

> +	if (machine__normalized_is(machine, "x86"))
> +		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);

Why? Could use a comment.

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

Missing addr_location__exit()

> +
> +		if (op->type == X86_OP_IMM &&
> +		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
> +			printed += fprintf(fp, "%s ", insn[0].mnemonic);
> +			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
> +			return printed;
> +		}
> +	}
> +
> +	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> +	return printed;
> +}
> +
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> +			    struct machine *machine, FILE *fp)
> +{
> +	static csh cs_handle;

Why static?

> +	cs_insn *insn;
> +	size_t count;
> +	size_t printed = 0;
> +	int ret;
> +
> +	ret = capstone_init(machine, &cs_handle);

Does this really need to be done every time?

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
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
> +			    struct machine *machine __maybe_unused, FILE *fp)
> +{
> +	return sample__fprintf_insn_raw(sample, fp);
> +}
> +#endif
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> new file mode 100644
> index 000000000000..af8fa5d01fb7
> --- /dev/null
> +++ b/tools/perf/util/print_insn.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef PERF_PRINT_ISNS_H

Here and elsewhere

ISNS -> INSN

> +#define PERF_PRINT_ISNS_H
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include "event.h"
> +#include "util/thread.h"

Instead of including event.h and thread.h, just forward declare:

struct perf_sample;
struct thread;
struct machine;

> +
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> +			    struct machine *machine, FILE *fp);
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> +
> +#endif /* PERF_PRINT_ISNS_H */


