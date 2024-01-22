Return-Path: <linux-kernel+bounces-32539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B4835CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C893F1F22489
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0F36120;
	Mon, 22 Jan 2024 08:42:32 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D51F5F5;
	Mon, 22 Jan 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912952; cv=none; b=kzbkuZ3Lc+1th25512mytxEyHFWDHqTX2DI7VGMRZeW+ReV48TSV2/SedHz28Yl9UCiuHtiCRuw155xEFNTE7BPipfO8shscmis7Texks3Oe0qaeWk+HGyPcda/Z+cOz15+op4vgP9IzLwYPgUWkB9oePOyG+kfCvUY7PTw0qpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912952; c=relaxed/simple;
	bh=mBTES/bCEwoivf/jzipdBvln5akYDmEnjyi/uVXSK/c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvOeWLtKuOUWEaBAoV+F3E8sKGlKfToipriais6LZBDbs5gZmEAr15GMM/9jYReebiyRUIX1f3dUzdNzTZ8eAvao0jUpIoQ73Nh5Q/O1L80ANDCnGD4RXK3qkoAIzek7nNHm9/pFDOrZOJYuFG85vktA+1LebvXHV98I0T5X3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJNwR5CgHzvVGH;
	Mon, 22 Jan 2024 16:40:55 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id B01AC1404FC;
	Mon, 22 Jan 2024 16:42:25 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 22 Jan
 2024 16:42:24 +0800
Date: Mon, 22 Jan 2024 16:42:16 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo
 Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Message-ID: <20240122084216.rhdhco67mvj47ak7@M910t>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-3-changbin.du@huawei.com>
 <e3463435-b879-4d72-9cab-c4bf951b9084@intel.com>
 <20240120091328.wmk27ktpps2ky5cl@M910t>
 <11a40f8d-baaf-48c8-b921-fbf764722475@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11a40f8d-baaf-48c8-b921-fbf764722475@intel.com>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Mon, Jan 22, 2024 at 10:24:21AM +0200, Adrian Hunter wrote:
> On 20/01/24 11:13, Changbin Du wrote:
> > On Fri, Jan 19, 2024 at 08:39:19PM +0200, Adrian Hunter wrote:
> >> On 19/01/24 12:48, Changbin Du wrote:
> >>> Currently, the instructions of samples are shown as raw hex strings
> >>> which are hard to read. x86 has a special option '--xed' to disassemble
> >>> the hex string via intel XED tool.
> >>>
> >>> Here we use capstone as our disassembler engine to give more friendly
> >>> instructions. We select libcapstone because capstone can provide more
> >>> insn details. Perf will fallback to raw instructions if libcapstone is
> >>> not available.
> >>>
> >>> The advantages compared to XED tool:
> >>>  * Support arm, arm64, x86-32, x86_64 (more could be supported),
> >>>    xed only for x86_64.
> >>>  * Immediate address operands are shown as symbol+offs.
> >>>
> >>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> >>> ---
> >>>  tools/perf/builtin-script.c  |   8 +--
> >>>  tools/perf/util/Build        |   1 +
> >>>  tools/perf/util/print_insn.c | 122 +++++++++++++++++++++++++++++++++++
> >>>  tools/perf/util/print_insn.h |  14 ++++
> >>>  4 files changed, 140 insertions(+), 5 deletions(-)
> >>>  create mode 100644 tools/perf/util/print_insn.c
> >>>  create mode 100644 tools/perf/util/print_insn.h
> >>>
> >>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >>> index b1f57401ff23..4817a37f16e2 100644
> >>> --- a/tools/perf/builtin-script.c
> >>> +++ b/tools/perf/builtin-script.c
> >>> @@ -34,6 +34,7 @@
> >>>  #include "util/event.h"
> >>>  #include "ui/ui.h"
> >>>  #include "print_binary.h"
> >>> +#include "print_insn.h"
> >>>  #include "archinsn.h"
> >>>  #include <linux/bitmap.h>
> >>>  #include <linux/kernel.h>
> >>> @@ -1511,11 +1512,8 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
> >>>  	if (PRINT_FIELD(INSNLEN))
> >>>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
> >>>  	if (PRINT_FIELD(INSN) && sample->insn_len) {
> >>> -		int i;
> >>> -
> >>> -		printed += fprintf(fp, " insn:");
> >>> -		for (i = 0; i < sample->insn_len; i++)
> >>> -			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
> >>> +		printed += fprintf(fp, " insn: ");
> >>
> >> "insn:" seems unnecessary.  Also xed prints 2 tabs, which
> >> helps line up the output.  Perhaps 1 tab and 2 spaces is
> >> enough.
> >>
> > The "insn:" is used by xed. So it can not be removed if we preserve xed
> > function.
> 
> I got mixed up - it is patch 3 that the comment is meant for.
> 
> > 
> > For 'insn' field, I keep the original output format.
> > For 'disasm' field, we can line up the output. I changed to 2 tabs and removed
> > 'insn:'.
> 
> That is better, thanks!
> 
> > 
> >>> +		printed += sample__fprintf_insn_raw(sample, fp);
> >>>  	}
> >>>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
> >>>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
> >>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> >>> index 988473bf907a..c33aab53d8dd 100644
> >>> --- a/tools/perf/util/Build
> >>> +++ b/tools/perf/util/Build
> >>> @@ -32,6 +32,7 @@ perf-y += perf_regs.o
> >>>  perf-y += perf-regs-arch/
> >>>  perf-y += path.o
> >>>  perf-y += print_binary.o
> >>> +perf-y += print_insn.o
> >>>  perf-y += rlimit.o
> >>>  perf-y += argv_split.o
> >>>  perf-y += rbtree.o
> >>> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> >>> new file mode 100644
> >>> index 000000000000..162be4856f79
> >>> --- /dev/null
> >>> +++ b/tools/perf/util/print_insn.c
> >>> @@ -0,0 +1,122 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Instruction binary disassembler based on capstone.
> >>> + *
> >>> + * Author(s): Changbin Du <changbin.du@huawei.com>
> >>> + */
> >>> +#include "print_insn.h"
> >>
> >> Please put with the other non-system includes
> >>
> > done.
> > 
> >>> +#include <stdlib.h>
> >>> +#include <string.h>
> >>> +#include <stdbool.h>
> >>> +#include "util/debug.h"
> >>
> >> util/ not needed
> >>
> > done.
> > 
> >>> +#include "util/symbol.h"
> >>
> >> util/ not needed
> >>
> > done.
> > 
> >>> +#include "machine.h"
> >>> +
> >>> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> >>> +{
> >>> +	int printed = 0;
> >>> +
> >>> +	for (int i = 0; i < sample->insn_len; i++)
> >>> +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
> >>
> >> Why change this to put a space on the end?
> >>
> > Removed the tailing space.
> > 
> >>> +	return printed;
> >>> +}
> >>> +
> >>> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >>> +#include <capstone/capstone.h>
> >>> +
> >>> +static int capstone_init(struct machine *machine, csh *cs_handle)
> >>> +{
> >>> +	cs_arch arch;
> >>> +	cs_mode mode;
> >>> +
> >>> +	if (machine__is(machine, "x86_64")) {
> >>> +		arch = CS_ARCH_X86;
> >>> +		mode = CS_MODE_64;
> >>> +	} else if (machine__normalized_is(machine, "x86")) {
> >>> +		arch = CS_ARCH_X86;
> >>> +		mode = CS_MODE_32;
> >>> +	} else if (machine__normalized_is(machine, "arm64")) {
> >>> +		arch = CS_ARCH_ARM64;
> >>> +		mode = CS_MODE_ARM;
> >>> +	} else if (machine__normalized_is(machine, "arm")) {
> >>> +		arch = CS_ARCH_ARM;
> >>> +		mode = CS_MODE_ARM + CS_MODE_V8;
> >>> +	} else if (machine__normalized_is(machine, "s390")) {
> >>> +		arch = CS_ARCH_SYSZ;
> >>> +		mode = CS_MODE_BIG_ENDIAN;
> >>> +	} else {
> >>> +		return -1;
> >>> +	}
> >>> +
> >>> +	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
> >>> +		pr_warning_once("cs_open failed\n");
> >>> +		return -1;
> >>> +	}
> >>> +
> >>> +	cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> >>
> >> That's only needed for x86 isn't it
> >>
> > Moved into below branch.
> > 
> >>> +	if (machine__normalized_is(machine, "x86"))
> >>> +		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> >>
> >> Why? Could use a comment.
> >>
> > 		/*
> > 		 * Resolving address oprands to symbols is implemented
> 
> oprands -> operands
Fixed, thanks!

> 
> > 		 * on x86 by investigating instruction details.
> > 		 */
> > 
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
> >>> +			     cs_insn *insn, FILE *fp)
> >>> +{
> >>> +	struct addr_location al;
> >>> +	size_t printed = 0;
> >>> +
> >>> +	if (insn->detail && insn->detail->x86.op_count == 1) {
> >>> +		cs_x86_op *op = &insn->detail->x86.operands[0];
> >>> +
> >>> +		addr_location__init(&al);
> >>
> >> Missing addr_location__exit()
> >>
> > Fixed.
> > 
> >>> +
> >>> +		if (op->type == X86_OP_IMM &&
> >>> +		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
> >>> +			printed += fprintf(fp, "%s ", insn[0].mnemonic);
> >>> +			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
> >>> +			return printed;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> >>> +	return printed;
> >>> +}
> >>> +
> >>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> >>> +			    struct machine *machine, FILE *fp)
> >>> +{
> >>> +	static csh cs_handle;
> >>
> >> Why static?
> >>
> > Removed. See below.
> > 
> >>> +	cs_insn *insn;
> >>> +	size_t count;
> >>> +	size_t printed = 0;
> >>> +	int ret;
> >>> +
> >>> +	ret = capstone_init(machine, &cs_handle);
> >>
> >> Does this really need to be done every time?
> >>
> > Only need to init once exactly. The problem is I cannot find a appropriate
> > place to do the initiation.
> > 
> > I tried to initiate on first call but we still need a global mutex to be
> > initiated.
> > 
> > So finally I fallback to initiate every time. The redundant initiation is
> > acceptable per my test.
> 
> OK, could add a FIXME
>
I added a TODO instead.

/* TODO: Try to initiate capstone only once but need a proper place. */

> > 
> >>> +	if (ret < 0) {
> >>> +		/* fallback */
> >>> +		return sample__fprintf_insn_raw(sample, fp);
> >>> +	}
> >>> +
> >>> +	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
> >>> +			  sample->ip, 1, &insn);
> >>> +	if (count > 0) {
> >>> +		if (machine__normalized_is(machine, "x86"))
> >>> +			printed += print_insn_x86(sample, thread, &insn[0], fp);
> >>> +		else
> >>> +			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
> >>> +		cs_free(insn, count);
> >>> +	} else {
> >>> +		printed += fprintf(fp, "illegal instruction");
> >>> +	}
> >>> +
> >>> +	cs_close(&cs_handle);
> >>> +	return printed;
> >>> +}
> >>> +#else
> >>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
> >>> +			    struct machine *machine __maybe_unused, FILE *fp)
> >>> +{
> >>> +	return sample__fprintf_insn_raw(sample, fp);
> >>> +}
> >>> +#endif
> >>> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> >>> new file mode 100644
> >>> index 000000000000..af8fa5d01fb7
> >>> --- /dev/null
> >>> +++ b/tools/perf/util/print_insn.h
> >>> @@ -0,0 +1,14 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +#ifndef PERF_PRINT_ISNS_H
> >>
> >> Here and elsewhere
> >>
> >> ISNS -> INSN
> >>
> > fixed.
> > 
> >>> +#define PERF_PRINT_ISNS_H
> >>> +
> >>> +#include <stddef.h>
> >>> +#include <stdio.h>
> >>> +#include "event.h"
> >>> +#include "util/thread.h"
> >>
> >> Instead of including event.h and thread.h, just forward declare:
> >>
> >> struct perf_sample;
> >> struct thread;
> >> struct machine;
> >>
> > Why forward declaration?
> 
> That is how it is done in perf tools.  It avoids unnecessary dependency
> among headers.
ok, done.

> 
> > 
> >>> +
> >>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
> >>> +			    struct machine *machine, FILE *fp);
> >>> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> >>> +
> >>> +#endif /* PERF_PRINT_ISNS_H */
> >>
> > 
> 

-- 
Cheers,
Changbin Du

