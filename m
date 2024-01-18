Return-Path: <linux-kernel+bounces-29707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414883120F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137821F22C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF711C89;
	Thu, 18 Jan 2024 04:12:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19F8F51;
	Thu, 18 Jan 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705551177; cv=none; b=GA+ZDGnecut+xvnaS7DZcQLYg1YRoSQq5j1WcpDJUcfztUkl0XQ7fGaYYQK+ba/zo7nQxf2Ng/iOISFg6pWgqWcy8pZF5/VNT3JDUbOhVaUPhvfmgQtzIqe1luy1L0L/Q1SCQLaP0lbIz4K5W04R8nzIgzbDadjAUJ42PezCUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705551177; c=relaxed/simple;
	bh=9OqL/TnQaMU9t4z4GaJ8a2Rg3FBFuZEVi5+uJjAorUA=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy; b=tJsWZodPBi3+ZveB4nJuD+z130P9rE/9tBKdTiWzR0wNazt5KaudILqRNHZleKzn2ZuxNyDFuWmTbey28ablkXsfHgGG+tZJu8A2LaTXq11r0+4pImx8EWE40MZjPHKuotU7vriN3s3wQPZWPcEjkbvwY0dm5EhU2nILXT/CTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TFq7g1TQ7zWmhq;
	Thu, 18 Jan 2024 12:11:43 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 1468A140499;
	Thu, 18 Jan 2024 12:12:46 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 18 Jan 2024 12:12:44 +0800
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
Subject: [PATCH v3 0/5] perf: script: Intro capstone disasm engine to show instruction trace
Date: Thu, 18 Jan 2024 12:12:19 +0800
Message-ID: <20240118041224.2799393-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

v3:
  - fix s390 detection. (Thomas Richter)
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
 tools/perf/util/print_insn.c               | 122 +++++++++++++++++++++
 tools/perf/util/print_insn.h               |  14 +++
 14 files changed, 219 insertions(+), 24 deletions(-)
 create mode 100644 tools/build/feature/test-libcapstone.c
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h

-- 
2.25.1


