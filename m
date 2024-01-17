Return-Path: <linux-kernel+bounces-28456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6AA82FEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2AE1F26388
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79E79CC;
	Wed, 17 Jan 2024 02:17:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB7465;
	Wed, 17 Jan 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705457860; cv=none; b=hur9N8zYwSgeszxBx7jECiMXK5Erb68RIoCI8usJwxaM1+qk3n+tx2SITGADM5S0UvNkovMbk0Eegu62ig6jKhxNEzlLGP0gMp6Ptq22oZi4soYV7Sw7QWEFaq7uMU4VgXL1Ybg3OB4jK8CpwbpFQEP9Gd5Wx7fGYepZqpxchxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705457860; c=relaxed/simple;
	bh=jegW/nWdpLJ6lB+mwu+Qfv6Qgp1PNS4pZ2t3/gk/UKQ=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy; b=HiQOHB5LGv76uqFqe7Dau6AqrLtv19sDRA+nOkTunRAxuWCTDTYIz0iWLVTG7kVTra7glNAKJU8ZVvMxa3+wxALn5ZVGNKwGIKBLqpGAOU19rqu9jPLazgQIKa3MyPrN9I2o6u0NhLdyLRGOjyNNkEZQXVNSucYVZbk9khszaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TF8f306JNzGpqH;
	Wed, 17 Jan 2024 10:17:15 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id A8699180076;
	Wed, 17 Jan 2024 10:17:34 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 17 Jan
 2024 10:17:33 +0800
Date: Wed, 17 Jan 2024 10:17:23 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Thomas Richter <tmricht@linux.ibm.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/3] perf: script: use capstone disasm engine to show
 assembly instructions
Message-ID: <20240117021723.bhxvgha74syz5fbg@M910t>
References: <20240116113437.1507537-1-changbin.du@huawei.com>
 <20240116113437.1507537-3-changbin.du@huawei.com>
 <f81cf759-d5a4-4b46-bd2c-2e11355447a8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81cf759-d5a4-4b46-bd2c-2e11355447a8@linux.ibm.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Tue, Jan 16, 2024 at 03:26:52PM +0100, Thomas Richter wrote:
> On 1/16/24 12:34, Changbin Du wrote:
> > Currently, the instructions of samples are shown as raw hex strings
> > which are hard to read. x86 has a special option '--xed' to disassemble
> > the hex string via intel XED tool.
> > 
> > Here we use capstone as our disassembler engine to give more friendly
> > instructions. We select libcapstone because capstone can provide more
> > insn details. Perf will fallback to raw instructions if libcapstone is
> > not available.
> > 
> > The advantages compared to XED tool:
> >  * Support arm, arm64, x86-32, x86_64 (more could be supported),
> >    xed only for x86_64.
> >  * Immediate address operands are shown as symbol+offs.
> > 
> > Before:
> > $ sudo perf record --event intel_pt//u -- ls
> > $ sudo perf script --insn-trace
> >             perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
> >             perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
> >             perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
> >             perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
> >             perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
> >             perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a8 00 00 00
> >             perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20
> > 
> > After:
> > $ sudo perf script --insn-trace
> >             perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: cmpq $-0xfff, %rax
> >             perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: jae __GI___ioctl+0x10
> >             perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: retq
> >             perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: testl %eax, %eax
> >             perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: jne perf_evsel__enable_cpu+0xad
> >             perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: movq 0xa8(%r12), %rax
> >             perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: movq 0x20(%rax), %rdx
> >             perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf) insn: cmpl %edx, %ebx
> >             perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf) insn: jl perf_evsel__enable_cpu+0x60
> >             perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf) insn: xorl %eax, %eax
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> 
> ....
> 
> > diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> > new file mode 100644
> > index 000000000000..c8d9741748cd
> > --- /dev/null
> > +++ b/tools/perf/util/print_insn.c
> > @@ -0,0 +1,118 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Instruction binary disassembler based on capstone.
> > + *
> > + * Author(s): Changbin Du <changbin.du@huawei.com>
> > + */
> > +#include "print_insn.h"
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <stdbool.h>
> > +#include "util/debug.h"
> > +#include "util/symbol.h"
> > +#include "machine.h"
> > +
> > +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> > +{
> > +	int printed = 0;
> > +
> > +	for (int i = 0; i < sample->insn_len; i++)
> > +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
> > +	return printed;
> > +}
> > +
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +#include <capstone/capstone.h>
> > +
> > +static int capstone_init(struct machine *machine, csh *cs_handle)
> > +{
> > +	cs_arch arch;
> > +	cs_mode mode;
> > +
> > +	if (machine__is(machine, "x86_64")) {
> > +		arch = CS_ARCH_X86;
> > +		mode = CS_MODE_64;
> > +	} else if (machine__normalized_is(machine, "x86")) {
> > +		arch = CS_ARCH_X86;
> > +		mode = CS_MODE_32;
> > +	} else if (machine__normalized_is(machine, "arm64")) {
> > +		arch = CS_ARCH_ARM64;
> > +		mode = CS_MODE_ARM;
> > +	} else if (machine__normalized_is(machine, "arm")) {
> > +		arch = CS_ARCH_ARM;
> > +		mode = CS_MODE_ARM + CS_MODE_V8;
> > +	} else {
> > +		return -1;
> > +	}
> > ...
> 
> Did you forgot to support s390? Or was it omitted on intention?
> Something along the lines will support s390:
> 
>  # git diff util/print_insn.c
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index c8d9741748cd..c5127910c75b 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -41,6 +41,9 @@ static int capstone_init(struct machine *machine, csh *cs_handle)
>         } else if (machine__normalized_is(machine, "arm")) {
>                 arch = CS_ARCH_ARM;
>                 mode = CS_MODE_ARM + CS_MODE_V8;
> +       } else if (machine__normalized_is(machine, "s390x")) {
> +               arch = CS_ARCH_SYSZ;
> +               mode = CS_MODE_BIG_ENDIAN;
>         } else {
>                 return -1;
>         }
>   #
> 
> Thanks a lot for including these line in your next version.
> 
No problem, thanks.

> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 

-- 
Cheers,
Changbin Du

