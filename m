Return-Path: <linux-kernel+bounces-52288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707AC849656
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D6828128A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C8125DC;
	Mon,  5 Feb 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYcAF3+I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529B12B6A;
	Mon,  5 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124978; cv=none; b=pvQt1jg0jrYBclz4J2J5wKawLPjf2I6ABwBExZWmvjrWGndmFArUkfbxj9E5BGb02LbJ+8seA1QQNwDemRe/jIdkQB+8ALQJpC4LlhJPLQh+v4J7I7oIUhe82NdMTfvvU/Db/RwQIG5khCdrOcSXRUUhbkjciP02+jstvvxHu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124978; c=relaxed/simple;
	bh=rZIs1h4wibSAzUn08niIQzz8jP4BkME14Y0BTOYaFdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGNeMU/vMVSu4Dwq2AzF+k1frX2elQ2il6rELBckT9Zmo1n7e0Uv6iDKRK7tPo8zAd9WyrOPjb8HARDLgtzK00aZoX3M9vjQLw8Ab64lbCW5xQZNADUIIt2rgtp9ZVFjGme510o9bQSDotDjYuJc4Mcnd+jDFizSMGJ7i9IbKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYcAF3+I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707124976; x=1738660976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZIs1h4wibSAzUn08niIQzz8jP4BkME14Y0BTOYaFdQ=;
  b=SYcAF3+I/xGVZkoeegL00mZfH5ybMdEFwoOYqFeOsmMhueednwLNl1er
   k8ek5GlWf1cMxcqjZ8GU7k3whGHpbgACaTTK2O+tkYxTfwSF/p9tSP/yw
   LRZMqID97PVyrEEHYM6Pyxo4Vz5zZqm+JAs0MjRDBWdfmJgALqVCyEEzT
   5Q/vNLJdjwJ0CoSbFLxWg9mQII/YNWSnLRjozZ1r5Txy03Sy5sjvclzQv
   btvc/FVr7Fm9Iy6Uhbx8KjY7cZrdUYBGVR9zBCKWlXbt1W1l89NhbXQI+
   dJPd+Z7uUiSF75r67sILFAxH94oJA12a4lKtSCrmwnKCHBYIrpaoqe115
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="18010555"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="18010555"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31765149"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:22:51 -0800
Message-ID: <82baac58-6d9e-45da-81ff-4a27a0d1d776@intel.com>
Date: Mon, 5 Feb 2024 11:22:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-3-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240122112054.1576835-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/24 13:20, Changbin Du wrote:
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
> 
> ---
> v2:
>   - line up the output by preceding two tabs. (Adrian Hunter)
>   - removed the tailing space. (Adrian Hunter)
>   - forward declaration for perf_sample, thread, machine. (Adrian Hunter)
>   - other trivial fixes (Adrian Hunter)
> ---
>  tools/perf/builtin-script.c  |   8 +--
>  tools/perf/util/Build        |   1 +
>  tools/perf/util/print_insn.c | 133 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/print_insn.h |  16 +++++
>  4 files changed, 153 insertions(+), 5 deletions(-)
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

Better without the space after 'insn:', then
sample__fprintf_insn_raw() can add 1 space before each
byte.
		printed += fprintf(fp, " insn:");

See also further below.

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
> index 000000000000..36b403d4a4df
> --- /dev/null
> +++ b/tools/perf/util/print_insn.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Instruction binary disassembler based on capstone.
> + *
> + * Author(s): Changbin Du <changbin.du@huawei.com>
> + */
> +#include <string.h>
> +#include <stdbool.h>
> +#include "debug.h"
> +#include "event.h"
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
> +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
> +		if (sample->insn_len - i > 1)
> +			printed += fprintf(fp, " ");

Now there are 2 spaces between.  Better like this:

	for (int i = 0; i < sample->insn_len; i++)
		printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);


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
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> +			    struct machine *machine, FILE *fp)
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
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
> +			    struct machine *machine __maybe_unused, FILE *fp)
> +{
> +	return sample__fprintf_insn_raw(sample, fp);
> +}
> +#endif
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> new file mode 100644
> index 000000000000..80dda6da7c60
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
> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> +			    struct machine *machine, FILE *fp);
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> +
> +#endif /* PERF_PRINT_INSN_H */


