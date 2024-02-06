Return-Path: <linux-kernel+bounces-54758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90584B344
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A177A282C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBA912E1C2;
	Tue,  6 Feb 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaIP4fdf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700256754;
	Tue,  6 Feb 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218238; cv=none; b=BFL/d6AIhtEC+UuI2qfLaHg+5MMHvLpusBfQiNAIop8V27odkD7/8yfy9DBd71Yd4peF2yCTBCymQS4O0VvKJ52RWFqlbB+M3cZE34JjvviPtz5O1ip0YxyynWBMgzL9omPwjHNvvgDGtnJ2sY6kOpsCwWiB75Eyvu8YY+QZQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218238; c=relaxed/simple;
	bh=RpFHXV7Q0t6wvY1ncp739FiP/hrqf7AdU7gOAxIaAz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIGJM265nlZMYyJWpboCUO19Bg7Opzlkl33cf+NOHrBzNlVSoSxTTMiMjAbouCEPUmIFHxsQNrnN/VqKn5dRtqcaLUEfX5BiICJ0q0uJ6qVokht0Qrj+DzRxmd8CaYDFOJmVshYX598C3F38gNCyQvq1PsDryMKipVN1fpPmV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaIP4fdf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707218236; x=1738754236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RpFHXV7Q0t6wvY1ncp739FiP/hrqf7AdU7gOAxIaAz8=;
  b=RaIP4fdfZROlp8MGp6e9ZFeCmhSpEzLWnxhBDCjKBpqj2Sn0/bE3j5ti
   Avs8icvw0lDpmft3yb0LiNUwb+NHyeeZYQ0Rul5z/WRX1CkP4DiPP5OFE
   NAY+bHh39JsE7rPIUdr7TxP/nIvgmWIjY++uDRg8y9h/g8bHB4QUaqF/v
   8aaTJUiOpopHjNdGLo7xBpVAVECUSwPoSuzsgTvM51mrInwybZpzmOlaX
   dUxnh27c/wu9viNB0UNDYqP1xHaQWrs+ZPBlpr19BoquvXqTLLkWRZYd3
   xUE0G0WvQGmRTT74oaRytKah39GG/N3jPha4RUMUadpBfxtAxxJITkuaB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="863065"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="863065"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="980832"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:17:10 -0800
Message-ID: <51db7422-582e-4958-9704-e00719605b25@intel.com>
Date: Tue, 6 Feb 2024 13:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240206021438.768731-1-changbin.du@huawei.com>
 <20240206021438.768731-3-changbin.du@huawei.com>
 <631f8b5e-2bd2-4419-885f-34be07012b29@intel.com>
 <20240206111150.zqjyx33wqipqitzu@M910t>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240206111150.zqjyx33wqipqitzu@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/02/24 13:11, Changbin Du wrote:
> On Tue, Feb 06, 2024 at 12:33:10PM +0200, Adrian Hunter wrote:
>> On 6/02/24 04:14, Changbin Du wrote:
>>> Currently, the instructions of samples are shown as raw hex strings
>>> which are hard to read. x86 has a special option '--xed' to disassemble
>>> the hex string via intel XED tool.
>>>
>>> Here we use capstone as our disassembler engine to give more friendly
>>> instructions. We select libcapstone because capstone can provide more
>>> insn details. Perf will fallback to raw instructions if libcapstone is
>>> not available.
>>>
>>> The advantages compared to XED tool:
>>>  * Support arm, arm64, x86-32, x86_64 (more could be supported),
>>>    xed only for x86_64.
>>>  * Immediate address operands are shown as symbol+offs.
>>>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>>
>>> ---
>>> v3:
>>>   - show warning msg if libcapstone is not available.
>>> v2:
>>>   - line up the output by preceding two tabs. (Adrian Hunter)
>>>   - removed the tailing space. (Adrian Hunter)
>>>   - forward declaration for perf_sample, thread, machine. (Adrian Hunter)
>>>   - other trivial fixes (Adrian Hunter)
>>> ---
>>>  tools/perf/builtin-script.c  |   8 +--
>>>  tools/perf/util/Build        |   1 +
>>>  tools/perf/util/print_insn.c | 134 +++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/print_insn.h |  16 +++++
>>>  4 files changed, 154 insertions(+), 5 deletions(-)
>>>  create mode 100644 tools/perf/util/print_insn.c
>>>  create mode 100644 tools/perf/util/print_insn.h
>>>
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index b1f57401ff23..4817a37f16e2 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -34,6 +34,7 @@
>>>  #include "util/event.h"
>>>  #include "ui/ui.h"
>>>  #include "print_binary.h"
>>> +#include "print_insn.h"
>>>  #include "archinsn.h"
>>>  #include <linux/bitmap.h>
>>>  #include <linux/kernel.h>
>>> @@ -1511,11 +1512,8 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>>>  	if (PRINT_FIELD(INSNLEN))
>>>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
>>>  	if (PRINT_FIELD(INSN) && sample->insn_len) {
>>> -		int i;
>>> -
>>> -		printed += fprintf(fp, " insn:");
>>> -		for (i = 0; i < sample->insn_len; i++)
>>> -			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
>>> +		printed += fprintf(fp, " insn: ");
>>> +		printed += sample__fprintf_insn_raw(sample, fp);
>>>  	}
>>>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>>>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>>> index 8027f450fa3e..2cbeeb79b6ef 100644
>>> --- a/tools/perf/util/Build
>>> +++ b/tools/perf/util/Build
>>> @@ -32,6 +32,7 @@ perf-y += perf_regs.o
>>>  perf-y += perf-regs-arch/
>>>  perf-y += path.o
>>>  perf-y += print_binary.o
>>> +perf-y += print_insn.o
>>>  perf-y += rlimit.o
>>>  perf-y += argv_split.o
>>>  perf-y += rbtree.o
>>> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
>>> new file mode 100644
>>> index 000000000000..163307a02274
>>> --- /dev/null
>>> +++ b/tools/perf/util/print_insn.c
>>> @@ -0,0 +1,134 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Instruction binary disassembler based on capstone.
>>> + *
>>> + * Author(s): Changbin Du <changbin.du@huawei.com>
>>> + */
>>> +#include <string.h>
>>> +#include <stdbool.h>
>>> +#include "debug.h"
>>> +#include "event.h"
>>> +#include "symbol.h"
>>> +#include "machine.h"
>>> +#include "thread.h"
>>> +#include "print_insn.h"
>>> +
>>> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>>> +{
>>> +	int printed = 0;
>>> +
>>> +	for (int i = 0; i < sample->insn_len; i++) {
>>> +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
>>
>> Same as last time, there are 2 spaces between bytes
>> instead of 1.  It needs:
>>
>> 	"%02x "      ->      "%02x"
>>
> My fault. Fixed. Thanks!
> 
>>> +		if (sample->insn_len - i > 1)
>>> +			printed += fprintf(fp, " ");
>>> +	}
>>> +	return printed;
>>> +}
>>> +
>>> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
>>> +#include <capstone/capstone.h>
>>> +
>>> +static int capstone_init(struct machine *machine, csh *cs_handle)
>>> +{
>>> +	cs_arch arch;
>>> +	cs_mode mode;
>>> +
>>> +	if (machine__is(machine, "x86_64")) {
>>> +		arch = CS_ARCH_X86;
>>> +		mode = CS_MODE_64;
>>> +	} else if (machine__normalized_is(machine, "x86")) {
>>> +		arch = CS_ARCH_X86;
>>> +		mode = CS_MODE_32;
>>> +	} else if (machine__normalized_is(machine, "arm64")) {
>>> +		arch = CS_ARCH_ARM64;
>>> +		mode = CS_MODE_ARM;
>>> +	} else if (machine__normalized_is(machine, "arm")) {
>>> +		arch = CS_ARCH_ARM;
>>> +		mode = CS_MODE_ARM + CS_MODE_V8;
>>> +	} else if (machine__normalized_is(machine, "s390")) {
>>> +		arch = CS_ARCH_SYSZ;
>>> +		mode = CS_MODE_BIG_ENDIAN;
>>> +	} else {
>>> +		return -1;
>>> +	}
>>> +
>>> +	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
>>> +		pr_warning_once("cs_open failed\n");
>>> +		return -1;
>>> +	}
>>> +
>>> +	if (machine__normalized_is(machine, "x86")) {
>>> +		cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
>>> +		/*
>>> +		 * Resolving address operands to symbols is implemented
>>> +		 * on x86 by investigating instruction details.
>>> +		 */
>>> +		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>>> +			     cs_insn *insn, FILE *fp)
>>> +{
>>> +	struct addr_location al;
>>> +	size_t printed = 0;
>>> +
>>> +	if (insn->detail && insn->detail->x86.op_count == 1) {
>>> +		cs_x86_op *op = &insn->detail->x86.operands[0];
>>> +
>>> +		addr_location__init(&al);
>>> +		if (op->type == X86_OP_IMM &&
>>> +		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
>>> +			printed += fprintf(fp, "%s ", insn[0].mnemonic);
>>> +			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
>>> +			addr_location__exit(&al);
>>> +			return printed;
>>> +		}
>>> +		addr_location__exit(&al);
>>> +	}
>>> +
>>> +	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
>>> +	return printed;
>>> +}
>>> +
>>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
>>> +			    struct machine *machine, FILE *fp)
>>> +{
>>> +	csh cs_handle;
>>> +	cs_insn *insn;
>>> +	size_t count;
>>> +	size_t printed = 0;
>>> +	int ret;
>>> +
>>> +	/* TODO: Try to initiate capstone only once but need a proper place. */
>>> +	ret = capstone_init(machine, &cs_handle);
>>> +	if (ret < 0) {
>>> +		/* fallback */
>>> +		return sample__fprintf_insn_raw(sample, fp);
>>> +	}
>>> +
>>> +	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
>>> +			  sample->ip, 1, &insn);
>>> +	if (count > 0) {
>>> +		if (machine__normalized_is(machine, "x86"))
>>> +			printed += print_insn_x86(sample, thread, &insn[0], fp);
>>> +		else
>>> +			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
>>> +		cs_free(insn, count);
>>> +	} else {
>>> +		printed += fprintf(fp, "illegal instruction");
>>> +	}
>>> +
>>> +	cs_close(&cs_handle);
>>> +	return printed;
>>> +}
>>> +#else
>>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
>>> +			    struct machine *machine __maybe_unused, FILE *fp)
>>> +{
>>> +	pr_warning_once("perf needs to be built with libcapstone support to disassemble instructions\n");
>>> +	return sample__fprintf_insn_raw(sample, fp);
>>
>> The validation stops this being called so could just leave
>> out the 2 lines above, and add __maybe_unused as necessary.
>>
> I expect this being a generic api and could be invoked by other functions which
> may not require the validation (raw code is acceptable).

kernel-style is not to add code if it isn't being used,
but it seems likely another user of the API would probably
need to check for libcapstone first, just like perf script,
so the code would still not be used.

> 
>>> +}
>>> +#endif
>>> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
>>> new file mode 100644
>>> index 000000000000..80dda6da7c60
>>> --- /dev/null
>>> +++ b/tools/perf/util/print_insn.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef PERF_PRINT_INSN_H
>>> +#define PERF_PRINT_INSN_H
>>> +
>>> +#include <stddef.h>
>>> +#include <stdio.h>
>>> +
>>> +struct perf_sample;
>>> +struct thread;
>>> +struct machine;
>>> +
>>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
>>> +			    struct machine *machine, FILE *fp);
>>> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
>>> +
>>> +#endif /* PERF_PRINT_INSN_H */
>>
> 


