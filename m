Return-Path: <linux-kernel+bounces-27325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF682EDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D5B1F24082
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CC1BDC6;
	Tue, 16 Jan 2024 11:35:14 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64CC1BC3E;
	Tue, 16 Jan 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TDn3m4dBZz1wn3N;
	Tue, 16 Jan 2024 19:34:44 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 4810F1A016B;
	Tue, 16 Jan 2024 19:35:03 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 16 Jan 2024 19:35:02 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 3/3] perf: script: deprecate the '--xed' option
Date: Tue, 16 Jan 2024 19:34:37 +0800
Message-ID: <20240116113437.1507537-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116113437.1507537-1-changbin.du@huawei.com>
References: <20240116113437.1507537-1-changbin.du@huawei.com>
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

Now perf can show assembly instructions with libcapstone for both x86 and
Arm. So the old '--xed' option should not be used.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/build-xed.txt     | 19 -------------------
 tools/perf/Documentation/perf-intel-pt.txt | 17 +++++------------
 tools/perf/Documentation/perf-script.txt   |  5 ++---
 tools/perf/Documentation/tips.txt          |  2 +-
 tools/perf/builtin-script.c                |  7 ++-----
 tools/perf/ui/browsers/res_sample.c        |  2 +-
 tools/perf/ui/browsers/scripts.c           |  4 ++--
 7 files changed, 13 insertions(+), 43 deletions(-)
 delete mode 100644 tools/perf/Documentation/build-xed.txt

diff --git a/tools/perf/Documentation/build-xed.txt b/tools/perf/Documentation/build-xed.txt
deleted file mode 100644
index 6222c1e7231f..000000000000
--- a/tools/perf/Documentation/build-xed.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-
-For --xed the xed tool is needed. Here is how to install it:
-
-  $ git clone https://github.com/intelxed/mbuild.git mbuild
-  $ git clone https://github.com/intelxed/xed
-  $ cd xed
-  $ ./mfile.py --share
-  $ ./mfile.py examples
-  $ sudo ./mfile.py --prefix=/usr/local install
-  $ sudo ldconfig
-  $ sudo cp obj/examples/xed /usr/local/bin
-
-Basic xed testing:
-
-  $ xed | head -3
-  ERROR: required argument(s) were missing
-  Copyright (C) 2017, Intel Corporation. All rights reserved.
-  XED version: [v10.0-328-g7d62c8c49b7b]
-  $
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 2109690b0d5f..15ae7be599e4 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -115,9 +115,8 @@ toggle respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
-	perf script --insn-trace --xed
+	perf script --insn-trace
 
-Dump all instructions. This requires installing the xed tool (see XED below)
 Dumping all instructions in a long trace can be fairly slow. It is usually better
 to start with higher level decoding, like
 
@@ -130,12 +129,12 @@ or
 and then select a time range of interest. The time range can then be examined
 in detail with
 
-	perf script --time starttime,stoptime --insn-trace --xed
+	perf script --time starttime,stoptime --insn-trace
 
 While examining the trace it's also useful to filter on specific CPUs using
 the -C option
 
-	perf script --time starttime,stoptime --insn-trace --xed -C 1
+	perf script --time starttime,stoptime --insn-trace -C 1
 
 Dump all instructions in time range on CPU 1.
 
@@ -1243,12 +1242,6 @@ To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
 	perf script --itrace=oe
 
-XED
----
-
-include::build-xed.txt[]
-
-
 Tracing Virtual Machines (kernel only)
 --------------------------------------
 
@@ -1306,7 +1299,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
 
 perf script can be used to provide an instruction trace
 
- $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script --guestkallsyms $KALLSYMS --insn-trace -F+ipc | grep -C10 vmresume | head -21
        CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
        CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
        CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
@@ -1407,7 +1400,7 @@ There were none.
 
 'perf script' can be used to provide an instruction trace showing timestamps
 
- $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace -F+ipc | grep -C10 vmresume | head -21
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff9a52e44688..74a0bc2e117f 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -442,11 +442,10 @@ include::itrace.txt[]
 	default, disable with --no-inline.
 
 --insn-trace::
-	Show instruction stream for intel_pt traces. Combine with --xed to
-	show disassembly.
+	Show instruction stream for intel_pt traces.
 
 --xed::
-	Run xed disassembler on output. Requires installing the xed disassembler.
+	Run xed disassembler on output. (deprecated)
 
 -S::
 --symbols=symbol[,symbol...]::
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 825745a645c1..5e1182514730 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -15,7 +15,7 @@ To see callchains in a more compact form: perf report -g folded
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
-To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
+To show assembler sample contexts use perf record -b / perf script -F +brstackinsn
 Treat branches as callchains: perf report --branch-history
 To count events in every 1000 msec: perf stat -I 1000
 Print event counts in CSV format with: perf stat -x,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c32a326e660f..9768d00323e6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3776,10 +3776,7 @@ static int parse_xed(const struct option *opt __maybe_unused,
 		     const char *str __maybe_unused,
 		     int unset __maybe_unused)
 {
-	if (isatty(1))
-		force_pager("xed -F insn: -A -64 | less");
-	else
-		force_pager("xed -F insn: -A -64");
+	pr_warning("xed option is deprecated\n");
 	return 0;
 }
 
@@ -3915,7 +3912,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
-			"Run xed disassembler on output", parse_xed),
+			"Run xed disassembler on output (deprecated)", parse_xed),
 	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode calls from itrace", parse_call_trace),
 	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 7cb2d6678039..382f1fb07a73 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		     r->tid ? "--tid " : "",
 		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
 		     extra_format,
-		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_ASM ? "-F +insn" :
 		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
 		     symbol_conf.inline_name ? "--inline" : "",
 		     "--show-lost-events ",
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 47d2c7a8cbe1..056c51a95712 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -37,7 +37,7 @@ void attr_to_script(char *extra_format, struct perf_event_attr *attr)
 	if (attr->read_format & PERF_FORMAT_GROUP)
 		strcat(extra_format, " -F +metric");
 	if (attr->sample_type & PERF_SAMPLE_BRANCH_STACK)
-		strcat(extra_format, " -F +brstackinsn --xed");
+		strcat(extra_format, " -F +brstackinsn");
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		strcat(extra_format, " -F +iregs");
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER)
@@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
 	if (evsel)
 		attr_to_script(scriptc.extra_format, &evsel->core.attr);
 	add_script_option("Show individual samples", "", &scriptc);
-	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+	add_script_option("Show individual samples with assembler", "-F +insn",
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
-- 
2.25.1


