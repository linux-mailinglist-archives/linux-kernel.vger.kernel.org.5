Return-Path: <linux-kernel+bounces-68510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E8857B74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12F41F22147
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC869D22;
	Fri, 16 Feb 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLT0/N6h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E469950;
	Fri, 16 Feb 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082448; cv=none; b=UghtrPkWrZtAy/USaZUOShrgnAMnnJwtJu6OilbwDTiAOezodeQSW2cr94YV4q2uZHDv+GkeJO2CkkW8YEcu4+HVV1cIjWu94FBQpt/QUJipkpDmPiv+7B8joFR/D1za+efftFMPo8paEdTG4ZlwoO4usOXG4cQSk4zqHR/9MQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082448; c=relaxed/simple;
	bh=TRXk9FafwvB9zinJFgR9imM4O51KogOM+Q5/b/HNL5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kd7nr55jo6FfhOvv0L7k9DLPW8hnZB8v1nGTudggvBkU/O9CI30T39R/xeYSbDi1/1S4/yQgmSvG+vmZ04XQPhBQG/liZzt9D6ND+zCr0sNHU2VVcibg0ZgqLio2+DT4HBhCepRHHBPGeHzylkRCkRZ8xsJ4GHu7vNH5UAiefQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLT0/N6h; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708082446; x=1739618446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TRXk9FafwvB9zinJFgR9imM4O51KogOM+Q5/b/HNL5M=;
  b=GLT0/N6hmYsnEPFEuGF09Ar+LvklcOravgYkR5V5O/VRCWq0fgGvmsjS
   uV8M/z+/2gqh0uCyFoS+UxW8p+BQQotVpHm+hA/ltP39uVYC01nTIgfcD
   nu4Jmpi+Kf14fpps0AjpmxHjDkzU0EqV47JDrX2LSUwd5KVm9TSSyTZRC
   1v5ICSMkBrsqkuE7WKuMR2hl8LB9Yy5HCD16O+TikEP5nS83dec7LSNXa
   /OTJt1PKm32j6LJqQ7VACodBFSMUlR5W1KHMuadxGXa/v04xBzHvBHn54
   7LSL+MUJ543IImvVTY/YoW6hKBUOeJlGu0hWuvj7JFnPIiwSZy1/SoIo4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2357254"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2357254"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826567443"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="826567443"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:20:36 -0800
Message-ID: <dcb11888-444a-40d4-9baf-4e2045156726@intel.com>
Date: Fri, 16 Feb 2024 13:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] perf: script: Intro capstone disasm engine to show
 instruction trace
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>, Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
 changbin.du@gmail.com
References: <20240206112929.1035548-1-changbin.du@huawei.com>
 <bd5ed9b2-cbb7-4b8b-b7b8-5db2eff75f17@intel.com>
 <CAM9d7cieSFcbPj-PH=9EKzAmNJCkVCoytUbQaEz9iRi47CiF7w@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cieSFcbPj-PH=9EKzAmNJCkVCoytUbQaEz9iRi47CiF7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/02/24 20:49, Namhyung Kim wrote:
> Hello,
> 
> For some reason, I cannot see Changbin's email in my mailbox. :(
> 
> On Tue, Feb 6, 2024 at 3:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/02/24 13:29, Changbin Du wrote:
>>> This series introduces capstone disassembler engine to print instructions of
>>> Intel PT trace, which was printed via the XED tool.
>>>
>>> The advantages compared to XED tool:
>>>     * Support arm, arm64, x86-32, x86_64, s390 (more could be supported),
>>>       xed only for x86_64.
>>>     * More friendly to read. Immediate address operands are shown as symbol+offs.
>>>
>>> Display raw instructions:
>>>     $ sudo perf record --event intel_pt//u -- ls
>>>     $ sudo perf script --insn-trace
>>>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
>>>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
>>>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a8 00 00 00
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20
>>>
>>> Display mnemonic instructions:
>>>     $ sudo perf script --insn-trace=disasm
>>>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so)            cmpq $-0xfff, %rax
>>>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so)            jae __GI___ioctl+0x10
>>>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so)            retq
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf)                testl %eax, %eax
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf)                jne perf_evsel__enable_cpu+0xad
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf)                movq 0xa8(%r12), %rax
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf)                movq 0x20(%rax), %rdx
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf)                cmpl %edx, %ebx
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf)                jl perf_evsel__enable_cpu+0x60
>>>                 perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf)                xorl %eax, %eax
>>>
>>> v7:
>>>   - remove redundant space for raw instruction.
>>>   - rename sample__fprintf_insn() as sample__fprintf_insn_asm() and make it empty if libcapstone is not available.
>>> v6:
>>>   - make '-F +disasm' fatal if libcapstone is not supported. (Adrian Hunter)
>>>   - display with perf version --build-options. (Adrian Hunter)
>>>   - exclude libcapstone from make_minimal. (Adrian Hunter)
>>> v5:
>>>   - fixes and improments suggested by Adrian Hunter
>>> v4:
>>>   - rename 'insn_disam' to 'disasm' (Adrian Hunter)
>>> v3:
>>>   - fix s390 detection. (Thomas Richter)
>>> v2:
>>>   - add a new field 'insn_disam' instead of changing the default output.
>>>   - preserve the old --xed option.
>>>
>>> Changbin Du (5):
>>>   perf: build: introduce the libcapstone
>>>   perf: util: use capstone disasm engine to show assembly instructions
>>>   perf: script: add field 'disasm' to display mnemonic instructions
>>>   perf: script: add raw|disasm arguments to --insn-trace option
>>>   perf: script: prefer capstone to XED
>>>
>>>  tools/build/Makefile.feature               |   2 +
>>>  tools/build/feature/Makefile               |   4 +
>>>  tools/build/feature/test-all.c             |   4 +
>>>  tools/build/feature/test-libcapstone.c     |  11 ++
>>>  tools/perf/Documentation/perf-intel-pt.txt |  14 ++-
>>>  tools/perf/Documentation/perf-script.txt   |  20 +--
>>>  tools/perf/Makefile.config                 |  21 ++++
>>>  tools/perf/Makefile.perf                   |   3 +
>>>  tools/perf/builtin-script.c                |  45 +++++--
>>>  tools/perf/builtin-version.c               |   1 +
>>>  tools/perf/tests/make                      |   4 +-
>>>  tools/perf/ui/browsers/res_sample.c        |   2 +-
>>>  tools/perf/ui/browsers/scripts.c           |   2 +-
>>>  tools/perf/util/Build                      |   1 +
>>>  tools/perf/util/print_insn.c               | 135 +++++++++++++++++++++
>>>  tools/perf/util/print_insn.h               |  16 +++
>>>  16 files changed, 258 insertions(+), 27 deletions(-)
>>>  create mode 100644 tools/build/feature/test-libcapstone.c
>>>  create mode 100644 tools/perf/util/print_insn.c
>>>  create mode 100644 tools/perf/util/print_insn.h
>>>
>>
>> For whole patch set:
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Anyway, I see a build failure on Fedora 40.
> 
> In file included from /usr/include/capstone/capstone.h:325,
>                  from util/print_insn.c:29:
> /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong
> kind of tag
>    94 | typedef enum bpf_insn {
>       |              ^~~~~~~~

libcapstone header files seem to trample on other namespaces.
We might have to wrap the libcapstone API at some point, but
for now I suggest avoiding including the conflicting headers
in the same C file.  Below works for me:

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index c10ccda529b13..459e0e93d7b1b 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -7,7 +7,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include "debug.h"
-#include "event.h"
+#include "sample.h"
 #include "symbol.h"
 #include "machine.h"
 #include "thread.h"
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 0df775b5c1105..df344262eaee0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -13,7 +13,6 @@
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
-#include "event.h"
 #include "callchain.h"
 #include <internal/rc_check.h>
 







