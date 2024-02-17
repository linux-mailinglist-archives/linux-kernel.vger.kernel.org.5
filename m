Return-Path: <linux-kernel+bounces-69730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E67858DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058AB2857F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244F51CD23;
	Sat, 17 Feb 2024 07:47:15 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444917727;
	Sat, 17 Feb 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156034; cv=none; b=o3JNtcr+KcvdDRo/73vgpmTPh7q09MCS6KwFojZl5wG0S/w4I2Oli8HetBVDneEp8bazTHAYVqeE5pk333CBWtjoDvTjvCrQc4EcBTDcRLaijr6qRlq/z/3r3EEzMwq9hsg35kaK1orxXTtfWRE6GEtRfjB81SuhMj5u4hOChrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156034; c=relaxed/simple;
	bh=HmzuyM8t+XxaVKKmw70+Ucvminrx6xAAlrX2nPERuyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBp1TqIX9OEHHcP/Zca/NNGOtfqIBNL4ebwoW3YtX/Z00UtLvAjJdA9gcVNaKhTgprUzZnslSY5zQwPDrIss1cseAm911EADB1EkFEekaA8xjyGsoDelwmTlRq+VrM9dKhkAC2lgDv53EpiWasF+TgtGfeXtxtaevfBOn7wk9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TcL6F04sQz1vth8;
	Sat, 17 Feb 2024 15:29:41 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C00218001B;
	Sat, 17 Feb 2024 15:30:13 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 17 Feb
 2024 15:30:11 +0800
Date: Sat, 17 Feb 2024 15:29:36 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Namhyung Kim <namhyung@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>
Subject: Re: [PATCH v7 0/5] perf: script: Intro capstone disasm engine to
 show instruction trace
Message-ID: <20240217072936.6siuj3pvi6hzx3u6@M910t>
References: <20240206112929.1035548-1-changbin.du@huawei.com>
 <bd5ed9b2-cbb7-4b8b-b7b8-5db2eff75f17@intel.com>
 <CAM9d7cieSFcbPj-PH=9EKzAmNJCkVCoytUbQaEz9iRi47CiF7w@mail.gmail.com>
 <dcb11888-444a-40d4-9baf-4e2045156726@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcb11888-444a-40d4-9baf-4e2045156726@intel.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Fri, Feb 16, 2024 at 01:20:31PM +0200, Adrian Hunter wrote:
> On 9/02/24 20:49, Namhyung Kim wrote:
> > Hello,
> > 
> > For some reason, I cannot see Changbin's email in my mailbox. :(
> > 
> > On Tue, Feb 6, 2024 at 3:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 6/02/24 13:29, Changbin Du wrote:
> >>> This series introduces capstone disassembler engine to print instructions of
> >>> Intel PT trace, which was printed via the XED tool.
> >>>
> >>> The advantages compared to XED tool:
> >>>     * Support arm, arm64, x86-32, x86_64, s390 (more could be supported),
> >>>       xed only for x86_64.
> >>>     * More friendly to read. Immediate address operands are shown as symbol+offs.
> >>>
> >>> Display raw instructions:
> >>>     $ sudo perf record --event intel_pt//u -- ls
> >>>     $ sudo perf script --insn-trace
> >>>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
> >>>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
> >>>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a8 00 00 00
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20
> >>>
> >>> Display mnemonic instructions:
> >>>     $ sudo perf script --insn-trace=disasm
> >>>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so)            cmpq $-0xfff, %rax
> >>>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so)            jae __GI___ioctl+0x10
> >>>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so)            retq
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf)                testl %eax, %eax
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf)                jne perf_evsel__enable_cpu+0xad
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf)                movq 0xa8(%r12), %rax
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf)                movq 0x20(%rax), %rdx
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf)                cmpl %edx, %ebx
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf)                jl perf_evsel__enable_cpu+0x60
> >>>                 perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf)                xorl %eax, %eax
> >>>
> >>> v7:
> >>>   - remove redundant space for raw instruction.
> >>>   - rename sample__fprintf_insn() as sample__fprintf_insn_asm() and make it empty if libcapstone is not available.
> >>> v6:
> >>>   - make '-F +disasm' fatal if libcapstone is not supported. (Adrian Hunter)
> >>>   - display with perf version --build-options. (Adrian Hunter)
> >>>   - exclude libcapstone from make_minimal. (Adrian Hunter)
> >>> v5:
> >>>   - fixes and improments suggested by Adrian Hunter
> >>> v4:
> >>>   - rename 'insn_disam' to 'disasm' (Adrian Hunter)
> >>> v3:
> >>>   - fix s390 detection. (Thomas Richter)
> >>> v2:
> >>>   - add a new field 'insn_disam' instead of changing the default output.
> >>>   - preserve the old --xed option.
> >>>
> >>> Changbin Du (5):
> >>>   perf: build: introduce the libcapstone
> >>>   perf: util: use capstone disasm engine to show assembly instructions
> >>>   perf: script: add field 'disasm' to display mnemonic instructions
> >>>   perf: script: add raw|disasm arguments to --insn-trace option
> >>>   perf: script: prefer capstone to XED
> >>>
> >>>  tools/build/Makefile.feature               |   2 +
> >>>  tools/build/feature/Makefile               |   4 +
> >>>  tools/build/feature/test-all.c             |   4 +
> >>>  tools/build/feature/test-libcapstone.c     |  11 ++
> >>>  tools/perf/Documentation/perf-intel-pt.txt |  14 ++-
> >>>  tools/perf/Documentation/perf-script.txt   |  20 +--
> >>>  tools/perf/Makefile.config                 |  21 ++++
> >>>  tools/perf/Makefile.perf                   |   3 +
> >>>  tools/perf/builtin-script.c                |  45 +++++--
> >>>  tools/perf/builtin-version.c               |   1 +
> >>>  tools/perf/tests/make                      |   4 +-
> >>>  tools/perf/ui/browsers/res_sample.c        |   2 +-
> >>>  tools/perf/ui/browsers/scripts.c           |   2 +-
> >>>  tools/perf/util/Build                      |   1 +
> >>>  tools/perf/util/print_insn.c               | 135 +++++++++++++++++++++
> >>>  tools/perf/util/print_insn.h               |  16 +++
> >>>  16 files changed, 258 insertions(+), 27 deletions(-)
> >>>  create mode 100644 tools/build/feature/test-libcapstone.c
> >>>  create mode 100644 tools/perf/util/print_insn.c
> >>>  create mode 100644 tools/perf/util/print_insn.h
> >>>
> >>
> >> For whole patch set:
> >>
> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Anyway, I see a build failure on Fedora 40.
> > 
> > In file included from /usr/include/capstone/capstone.h:325,
> >                  from util/print_insn.c:29:
> > /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong
> > kind of tag
> >    94 | typedef enum bpf_insn {
> >       |              ^~~~~~~~
> 
> libcapstone header files seem to trample on other namespaces.
Yes, the tag 'bpf_insn' are both defined by capstone/bpf.h and uapi/linux/bpf.h.

 util/event.h
. /work/linux/tools/include/uapi/linux/stddef.h
. /work/linux/tools/perf/libperf/include/perf/event.h
.. /work/linux/tools/include/uapi/linux/perf_event.h
... /usr/include/linux/ioctl.h
.... /usr/include/asm/ioctl.h
..... /usr/include/asm-generic/ioctl.h
... /usr/include/asm/byteorder.h
.... /usr/include/linux/byteorder/little_endian.h
..... /usr/include/linux/swab.h
...... /work/linux/tools/perf/util/include/asm/swab.h
.. /usr/include/linux/limits.h
.. /work/linux/tools/include/uapi/linux/bpf.h
... /work/linux/tools/include/uapi/linux/bpf_common.h


> We might have to wrap the libcapstone API at some point, but
> for now I suggest avoiding including the conflicting headers
> in the same C file.  Below works for me:
> 
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index c10ccda529b13..459e0e93d7b1b 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -7,7 +7,7 @@
>  #include <string.h>
>  #include <stdbool.h>
>  #include "debug.h"
> -#include "event.h"
> +#include "sample.h"
>  #include "symbol.h"
>  #include "machine.h"
>  #include "thread.h"
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 0df775b5c1105..df344262eaee0 100644
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
This works for me, too. I'll include this fix and keep Adrian's Reviewed-by.

> 
> 
> 
> 
> 
> 
> 

-- 
Cheers,
Changbin Du

