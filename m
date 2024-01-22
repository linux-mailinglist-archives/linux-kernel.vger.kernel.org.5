Return-Path: <linux-kernel+bounces-32905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6858361C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5726C1F23800
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343A3C08D;
	Mon, 22 Jan 2024 11:21:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7423BB4E;
	Mon, 22 Jan 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922473; cv=none; b=XFJdyNNfIXck6qQaoEcainkiIaLTEMfubFwdylA7p3j3EcaQhlYSZ9OoJOzHurBZuq3ID0WMzu8b6mpRb2HH9dZAz3I2UVGp9kGLrxx+VQhrVinb12eRoFxHY0txucqYMWJ5MG036fjn5fzGrn1RrOff27MruwRoViDuyeh4igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922473; c=relaxed/simple;
	bh=jo052ByZK+zttkLs6b9pYik8D0gc6nSuEONArThMSN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qw3pMDBexFosBLtwg/mqboRuLXX4H9PL9lGCvaCWo1FoJX2998csmUYihxV2UXEJQ8waUmcphObdveOhTwtpJJzshkJ+aIbtiaynh9xozkf5iramzrklZXnTm6AS3hnfoskI/sKUy3QSN4TkXmQyz5DO0h15O8QbkccZU5jEeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TJSSs6mC8zbcF4;
	Mon, 22 Jan 2024 19:20:45 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A3C018005E;
	Mon, 22 Jan 2024 19:21:08 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 22 Jan 2024 19:21:06 +0800
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
Subject: [PATCH v5 0/5] perf: script: Intro capstone disasm engine to show instruction trace
Date: Mon, 22 Jan 2024 19:20:49 +0800
Message-ID: <20240122112054.1576835-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 tools/perf/Documentation/perf-script.txt   |  20 ++--
 tools/perf/Makefile.config                 |  21 ++++
 tools/perf/Makefile.perf                   |   3 +
 tools/perf/builtin-script.c                |  33 +++--
 tools/perf/tests/make                      |   2 +
 tools/perf/ui/browsers/res_sample.c        |   2 +-
 tools/perf/ui/browsers/scripts.c           |   2 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/print_insn.c               | 133 +++++++++++++++++++++
 tools/perf/util/print_insn.h               |  16 +++
 15 files changed, 242 insertions(+), 26 deletions(-)
 create mode 100644 tools/build/feature/test-libcapstone.c
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h

-- 
2.25.1


