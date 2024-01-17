Return-Path: <linux-kernel+bounces-28526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D182FFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A779B287113
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E716FB9;
	Wed, 17 Jan 2024 05:11:52 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25D8825;
	Wed, 17 Jan 2024 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705468311; cv=none; b=KNUpYquNpuZG3uUNMLKFOOEKoPgglJFmEe0UbwuB7aPf8F6Fn7RmgW4/7sy8F7A3NuEnW9I542xQJFe/JQop5ngKw1I5aV/QP3KQmw5BVt13X0MP0GLxi/KqrVhqi9l5HMqam7y0Mw6aoJigoytiCxARvzL/iwEEaHc8x8bV89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705468311; c=relaxed/simple;
	bh=KSLFicrbYVYGENkwfsiKpqLnw2AUEpdI8Q9lLHS3DZc=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy; b=aKgyZ9r1jl9i+LicuGQ6fV9RgUUN/Ivbqv/mbL2kBBKoB087+lo3xwrSUbf7J/ytwiFtwYPJStcQU/mPzBMI5xv2S08ij4DUe3NRHTIEx6qYQdRvU9RKqI9wq013iwYnrPHmMBGJzNYOzopfyBW0KR97j1AatHsZIE2En3XDjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TFDVH0FCCz1Q7q9;
	Wed, 17 Jan 2024 13:10:47 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FDFD14053B;
	Wed, 17 Jan 2024 13:11:25 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 17 Jan 2024 13:11:23 +0800
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
Subject: [PATCH v2 0/5] perf: script: Intro capstone disasm engine to show instruction trace
Date: Wed, 17 Jan 2024 13:10:59 +0800
Message-ID: <20240117051104.2147643-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

This series introduces capstone disassembler engine to print instructions of
Intel PT trace, which was printed via the XED tool.

The advantages compared to XED tool:
    * Support arm, arm64, x86-32, x86_64 (more could be supported),
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
    $ sudo perf script --insn-trace=disam
                perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: cmpq $-0xfff, %rax
                perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: jae __GI___ioctl+0x10
                perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: retq
                perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: testl %eax, %eax
                perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: jne perf_evsel__enable_cpu+0xad
                perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: movq 0xa8(%r12), %rax
                perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: movq 0x20(%rax), %rdx
                perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf) insn: cmpl %edx, %ebx
                perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf) insn: jl perf_evsel__enable_cpu+0x60
                perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf) insn: xorl %eax, %eax

v2:
  - add a new field 'insn_disam' instead of changing the default output.
  - preserve the old --xed option.

Changbin Du (5):
  perf: build: introduce the libcapstone
  perf: util: use capstone disasm engine to show assembly instructions
  perf: script: add field 'insn_disam' to display mnemonic instructions
  perf: script: add raw|disam arguments to --insn-trace option
  perf: script: prefer capstone to XED

 tools/build/Makefile.feature               |   2 +
 tools/build/feature/Makefile               |   4 +
 tools/build/feature/test-all.c             |   4 +
 tools/build/feature/test-libcapstone.c     |  11 ++
 tools/perf/Documentation/perf-intel-pt.txt |  11 +-
 tools/perf/Documentation/perf-script.txt   |  13 ++-
 tools/perf/Makefile.config                 |  21 ++++
 tools/perf/Makefile.perf                   |   3 +
 tools/perf/builtin-script.c                |  33 ++++--
 tools/perf/ui/browsers/res_sample.c        |   2 +-
 tools/perf/ui/browsers/scripts.c           |   2 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/print_insn.c               | 123 +++++++++++++++++++++
 tools/perf/util/print_insn.h               |  14 +++
 14 files changed, 220 insertions(+), 24 deletions(-)
 create mode 100644 tools/build/feature/test-libcapstone.c
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h

-- 
2.25.1


