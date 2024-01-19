Return-Path: <linux-kernel+bounces-31061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F883282F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D596B24305
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE94EB3F;
	Fri, 19 Jan 2024 10:49:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00A4D5A2;
	Fri, 19 Jan 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661364; cv=none; b=cVWPksuFmfOrF46EwBgVPTcxDeY5WwN35qh6/s7jqp/i7981bUH8gd4mE1HJcel/SfuFJPnx3hftmEjYrUCQN9PoEIEnZm2Goo1AkdWRnUeeLazQbqg+odhMm29CmwGoNjeMNRyuqBA3lgnsEtfcq2pCxE7M6yze1iAViUDl1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661364; c=relaxed/simple;
	bh=5OxkKbu58xs6nmHY43tH+C7ACBzyqJ5R5ryqzSRIpxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q47+Zs3DYWIHilbVStEg5OJ9kFLvKtUFz+cJAcOhZcUa1onZiDMGzm9wahttiNzglQnZdhkmN71BbPl8IFYfQ9/8g6bvdL42SH0RUQe9GAg2AMbTXCUUWW15ANKTAxcdi6ocQdyktL6Wpucj++JqSXI7ypMZxXAI1tReCbsu3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TGbts1JWmz1Q7qj;
	Fri, 19 Jan 2024 18:48:21 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 51F96140153;
	Fri, 19 Jan 2024 18:49:17 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 19 Jan 2024 18:49:15 +0800
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
Subject: [PATCH v4 3/5] perf: script: add field 'disasm' to display mnemonic instructions
Date: Fri, 19 Jan 2024 18:48:54 +0800
Message-ID: <20240119104856.3617986-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119104856.3617986-1-changbin.du@huawei.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

In addition to the 'insn' field, this adds a new field 'disasm' to
display mnemonic instructions instead of the raw code.

$ sudo perf script -F +disasm
       perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
       perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
              ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
              ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-script.txt | 7 ++++---
 tools/perf/builtin-script.c              | 8 +++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff9a52e44688..fc79167c6bf8 100644
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
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4817a37f16e2..12d886694f6c 100644
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
+		printed += fprintf(fp, " insn: ");
+		printed += sample__fprintf_insn(sample, thread, machine, fp);
+	}
 	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
 		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
 
@@ -3900,7 +3906,7 @@ int cmd_script(int argc, const char **argv)
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


