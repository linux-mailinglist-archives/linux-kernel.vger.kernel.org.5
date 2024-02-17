Return-Path: <linux-kernel+bounces-69723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B2858DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29F41C21118
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398201D54A;
	Sat, 17 Feb 2024 07:41:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59E1CD07;
	Sat, 17 Feb 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155693; cv=none; b=Q8QCQfWx9buncnJ0U8UF11zGq2OmjnK+ulQovR80HnSYmCmrqeHXkWVhIRRs4Rahqdrs16BUuqtBYAdUEFBBhI0eRTEdVvsEiR51N1RiBqgbOjBCtP/ZBjAOpk1E+QF/+JW3w3F0RDRk3HO9/zZNZoctWQGa/LzeDQkrCs3V1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155693; c=relaxed/simple;
	bh=Erd0plscaM1fNIfpMjva0QETCJ1XaeURSSfLXhFXv04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYtbyh9D+QK1vdC7LtzZlhTpZfevumjk5pTSpJKi0ZUG/PPZSOHnVFWcOD36gXHlbX/2c0+vGLLYna2vixbacPQ2+C+h2CeOTavP6gqLmCio6DnQ0ro/o+S4ETayQzolwQ8Nk/MdlPpFYfArLcqlwVzvBSpKLLsZMz8NonFcUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TcLLL612Vz1xnZp;
	Sat, 17 Feb 2024 15:40:10 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 00CFC1400FD;
	Sat, 17 Feb 2024 15:41:29 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 17 Feb 2024 15:41:27 +0800
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
Subject: [PATCH v8 3/5] perf: script: add field 'disasm' to display mnemonic instructions
Date: Sat, 17 Feb 2024 15:40:44 +0800
Message-ID: <20240217074046.4100789-4-changbin.du@huawei.com>
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

In addition to the 'insn' field, this adds a new field 'disasm' to
display mnemonic instructions instead of the raw code.

$ sudo perf script -F +disasm
       perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
       perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
              ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rdi
              ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	callq _dl_start+0x0

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2:
  - make '-F +disasm' fatal if libcapstone is not supported.
v2:
  - update Documentation.
---
 tools/perf/Documentation/perf-script.txt | 13 +++++++------
 tools/perf/builtin-script.c              | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff9a52e44688..578fa59f51a5 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -132,9 +132,10 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
-        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
-        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu, cgroup, retire_lat.
+        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
+        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
+        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
+
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
@@ -217,9 +218,9 @@ OPTIONS
 	Instruction Trace decoding. For calls and returns, it will display the
 	name of the symbol indented with spaces to reflect the stack depth.
 
-	When doing instruction trace decoding insn and insnlen give the
-	instruction bytes and the instruction length of the current
-	instruction.
+	When doing instruction trace decoding, insn, disasm and insnlen give the
+	instruction bytes, disassembled instructions (requires libcapstone support)
+	and the instruction length of the current instruction respectively.
 
 	The synth field is used by synthesized events which may be created when
 	Instruction Trace decoding.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4817a37f16e2..a7b0213c9b94 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -135,6 +135,7 @@ enum perf_output_field {
 	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
 	PERF_OUTPUT_DSOFF           = 1ULL << 41,
+	PERF_OUTPUT_DISASM          = 1ULL << 42,
 };
 
 struct perf_script {
@@ -190,6 +191,7 @@ struct output_option {
 	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
 	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
 	{.str = "insn", .field = PERF_OUTPUT_INSN},
+	{.str = "disasm", .field = PERF_OUTPUT_DISASM},
 	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
 	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
 	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
@@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 		printed += fprintf(fp, " insn: ");
 		printed += sample__fprintf_insn_raw(sample, fp);
 	}
+	if (PRINT_FIELD(DISASM) && sample->insn_len) {
+		printed += fprintf(fp, "\t\t");
+		printed += sample__fprintf_insn_asm(sample, thread, machine, fp);
+	}
 	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
 		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
 
@@ -3106,6 +3112,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			rc = -EINVAL;
 			goto out;
 		}
+#ifndef HAVE_LIBCAPSTONE_SUPPORT
+		if (change != REMOVE && strcmp(tok, "disasm") == 0) {
+			fprintf(stderr, "Field \"disasm\" requires perf to be built with libcapstone support.\n");
+			rc = -EINVAL;
+			goto out;
+		}
+#endif
 
 		if (type == -1) {
 			/* add user option to all events types for
@@ -3900,7 +3913,7 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
-		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
+		     "brstackinsnlen,brstackoff,callindent,insn,disasm,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
 		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
 		     parse_output_fields),
-- 
2.25.1


