Return-Path: <linux-kernel+bounces-54770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337A84B378
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD981F22835
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27E12F5BB;
	Tue,  6 Feb 2024 11:29:57 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5212EBDB;
	Tue,  6 Feb 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218996; cv=none; b=elsob/X9Xn++A3mA4u7/Tp0v6x+Uy5kv25ial6+fgW0fTWdeELOE/us3MivuqHTbZoZ4LF/aaz49vthGOy9mYlajvs875wOKoglzoa66n72Iqd6l/BV4U9QiF+tqmU7mPY4S2W5IPOJ52kyJ5nQ5fI2X/su1LQf1Kh2J+F8c93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218996; c=relaxed/simple;
	bh=ViZRPZt/ztxnXRqlJgfRFU5tnjk2QaZZglcLwcCI4Is=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mZNgMM3i8+t5Iw/X4ayDOECLt2h9iYOprnj4AAu6511zsdv0MrReJ2b3MecREK08XfGdDxEvVyuvtq3qXweq0tAa25ZgHZdqMqh6KHq4FvgVKuWy1AvqNLYm6Qlx54ljNE8+eP18MgxRVZReRywpeZVlZ+wSmp+5GFdAN60rSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTgx96nDLz1xnNw;
	Tue,  6 Feb 2024 19:28:45 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 6999E140499;
	Tue,  6 Feb 2024 19:29:52 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 6 Feb 2024 19:29:51 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v7 0/5] perf: script: Intro capstone disasm engine to show instruction trace
Date: Tue, 6 Feb 2024 19:29:24 +0800
Message-ID: <20240206112929.1035548-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)

This series introduces capstone disassembler engine to print instructions of
Intel PT trace, which was printed via the XED tool.

The advantages compared to XED tool:
    * Support arm, arm64, x86-32, x86_64, s390 (more could be supported),
      xed only for x86_64.
    * More friendly to read. Immediate address operands are shown as symbol+offs.

Display raw instructions:
    $ sudo perf record --event intel_pt//u -- ls
    $ sudo perf script --insn-trace
                perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
                perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
                perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
                perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
                perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
                perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a8 00 00 00
                perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20

Display mnemonic instructions:
    $ sudo perf script --insn-trace=disasm
                perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so)		cmpq $-0xfff, %rax
                perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so)		jae __GI___ioctl+0x10
                perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so)		retq
                perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf)		testl %eax, %eax
                perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf)		jne perf_evsel__enable_cpu+0xad
                perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf)		movq 0xa8(%r12), %rax
                perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf)		movq 0x20(%rax), %rdx
                perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf)		cmpl %edx, %ebx
                perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf)		jl perf_evsel__enable_cpu+0x60
                perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf)		xorl %eax, %eax

v7:
  - remove redundant space for raw instruction.
  - rename sample__fprintf_insn() as sample__fprintf_insn_asm() and make it empty if libcapstone is not available.
v6:
  - make '-F +disasm' fatal if libcapstone is not supported. (Adrian Hunter)
  - display with perf version --build-options. (Adrian Hunter)
  - exclude libcapstone from make_minimal. (Adrian Hunter)
v5:
  - fixes and improments suggested by Adrian Hunter
v4:
  - rename 'insn_disam' to 'disasm' (Adrian Hunter)
v3:
  - fix s390 detection. (Thomas Richter)
v2:
  - add a new field 'insn_disam' instead of changing the default output.
  - preserve the old --xed option.

Changbin Du (5):
  perf: build: introduce the libcapstone
  perf: util: use capstone disasm engine to show assembly instructions
  perf: script: add field 'disasm' to display mnemonic instructions
  perf: script: add raw|disasm arguments to --insn-trace option
  perf: script: prefer capstone to XED

 tools/build/Makefile.feature               |   2 +
 tools/build/feature/Makefile               |   4 +
 tools/build/feature/test-all.c             |   4 +
 tools/build/feature/test-libcapstone.c     |  11 ++
 tools/perf/Documentation/perf-intel-pt.txt |  14 ++-
 tools/perf/Documentation/perf-script.txt   |  20 +--
 tools/perf/Makefile.config                 |  21 ++++
 tools/perf/Makefile.perf                   |   3 +
 tools/perf/builtin-script.c                |  45 +++++--
 tools/perf/builtin-version.c               |   1 +
 tools/perf/tests/make                      |   4 +-
 tools/perf/ui/browsers/res_sample.c        |   2 +-
 tools/perf/ui/browsers/scripts.c           |   2 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/print_insn.c               | 135 +++++++++++++++++++++
 tools/perf/util/print_insn.h               |  16 +++
 16 files changed, 258 insertions(+), 27 deletions(-)
 create mode 100644 tools/build/feature/test-libcapstone.c
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h

-- 
2.25.1


