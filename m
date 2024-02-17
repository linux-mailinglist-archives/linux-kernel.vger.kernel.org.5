Return-Path: <linux-kernel+bounces-69724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE945858DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FF71F222E4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081D1DFF3;
	Sat, 17 Feb 2024 07:41:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D11CF9B;
	Sat, 17 Feb 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155695; cv=none; b=DhrWRVSOglYPlRn6FMz1FKMXwVFsmzMutW2ScTt3aAGnHosrxihTObF5JMpyKElHt7nTRcY+AJiEuCEfcUA0r5E20GwUQJkKx6hM0TpPd3vj4H+W3yjKVjT/NNZ8bpsZfSIhlvKpFGrVbh4Fi8NoxIkMRePzCSpZ28DE8RUHgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155695; c=relaxed/simple;
	bh=X0DFxaAa0zlTFTZ090bSfmxwSp4bqQH3CYz1cMcQ+S8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hsewx0DIbxTMQjqBLmrrJzHPttnVnLWUkpbOAkIBuqBTWK3GmyIY6nlN6CtZJMGefR+RcmARpImc8iRqWmv9j4E1tAj3CEEQNxjvwOjzIKoyJztkfLHM6Pna32ZzfcuU1WXru9Fc/jFjxwXSpWHQdbYKPfoHhzz4ObZ015HGx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcLGL6stkz1FKpf;
	Sat, 17 Feb 2024 15:36:42 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 382D01A0172;
	Sat, 17 Feb 2024 15:41:30 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 17 Feb 2024 15:41:28 +0800
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
Subject: [PATCH v8 4/5] perf: script: add raw|disasm arguments to --insn-trace option
Date: Sat, 17 Feb 2024 15:40:45 +0800
Message-ID: <20240217074046.4100789-5-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240217074046.4100789-1-changbin.du@huawei.com>
References: <20240217074046.4100789-1-changbin.du@huawei.com>
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

Now '--insn-trace' accept a argument to specify the output format:
  - raw: display raw instructions.
  - disasm: display mnemonic instructions (if capstone is installed).

$ sudo perf script --insn-trace=raw
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: 48 89 e7
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: e8 e8 0c 00 00
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: f3 0f 1e fa

$ sudo perf script --insn-trace=disasm
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)		movq %rsp, %rdi
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)		callq _dl_start+0x0
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	illegal instruction
              ls 1443864 [006] 2275506.209908875:      7f216b426df4 _dl_start+0x4 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	pushq %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df5 _dl_start+0x5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df8 _dl_start+0x8 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	pushq %r15

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2:
  - update Documentation (Adrian Hunter)
---
 tools/perf/Documentation/perf-script.txt |  7 ++++---
 tools/perf/builtin-script.c              | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 578fa59f51a5..005e51df855e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -442,9 +442,10 @@ include::itrace.txt[]
 	will be printed. Each entry has function name and file/line. Enabled by
 	default, disable with --no-inline.
 
---insn-trace::
-	Show instruction stream for intel_pt traces. Combine with --xed to
-	show disassembly.
+--insn-trace[=<raw|disasm>]::
+	Show instruction stream in bytes (raw) or disassembled (disasm)
+	for intel_pt traces. The default is 'raw'. To use xed, combine
+	'raw' with --xed to show disassembly done by xed.
 
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a7b0213c9b94..0dd311a72c7e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3776,10 +3776,24 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
 #endif
 
 static int parse_insn_trace(const struct option *opt __maybe_unused,
-			    const char *str __maybe_unused,
-			    int unset __maybe_unused)
+			    const char *str, int unset __maybe_unused)
 {
-	parse_output_fields(NULL, "+insn,-event,-period", 0);
+	const char *fields = "+insn,-event,-period";
+	int ret;
+
+	if (str) {
+		if (strcmp(str, "disasm") == 0)
+			fields = "+disasm,-event,-period";
+		else if (strlen(str) != 0 && strcmp(str, "raw") != 0) {
+			fprintf(stderr, "Only accept raw|disasm\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = parse_output_fields(NULL, fields, 0);
+	if (ret < 0)
+		return ret;
+
 	itrace_parse_synth_opts(opt, "i0ns", 0);
 	symbol_conf.nanosecs = true;
 	return 0;
@@ -3925,7 +3939,7 @@ int cmd_script(int argc, const char **argv)
 		   "only consider these symbols"),
 	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
 		    "Use with -S to list traced records within address range"),
-	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
+	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, "raw|disasm",
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
-- 
2.25.1


