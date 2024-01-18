Return-Path: <linux-kernel+bounces-29704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658AE83120C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF51286209
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7358F49;
	Thu, 18 Jan 2024 04:12:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE066120;
	Thu, 18 Jan 2024 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705551174; cv=none; b=St2WrWRfNXS+e8BokwGO40YW8XxesrYPh5v2PK8C4O847PJfD8RsR9nil6N5iGVVgcpnL+t04EGlqYRF6hMRwr7D7oqXLKhZxog63/HfsAWlQvy6pV4oZ5ZtU8MqlHu5RfQll71+f2F9TFQZpHsi20hVuW4T7cFAK5Vo8x1YF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705551174; c=relaxed/simple;
	bh=PIbqFKRWt50/9XxfkZXP/coiR4As8sLrJwJx9kyUcow=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=WUU9H/VdkzEuzlvhTEu7/XUmxggThBJ5HWNHb9Xk7Nl87JywQE5YeQli5HBcq1ojZGbpOea2xhTw+LOgU/PW43dyWIBn1EfuprV913KipsxL9ssN0wdbZPHSOj/ZfZvhch1utX5LZyy4oih+zWBaCMDBy6076Qnj5VcV5rpbs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TFq7v2dxPz1Q7yy;
	Thu, 18 Jan 2024 12:11:55 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id CEA3B140499;
	Thu, 18 Jan 2024 12:12:49 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 18 Jan 2024 12:12:48 +0800
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
Subject: [PATCH v3 3/5] perf: script: add field 'insn_disam' to display mnemonic instructions
Date: Thu, 18 Jan 2024 12:12:22 +0800
Message-ID: <20240118041224.2799393-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118041224.2799393-1-changbin.du@huawei.com>
References: <20240118041224.2799393-1-changbin.du@huawei.com>
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

In addition to the 'insn' field, this adds a new field 'insn_disam' to
display mnemonic instructions instead of the raw code.

$ sudo perf script -F +insn_disam
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
index ff9a52e44688..1b0b62dd3145 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -132,9 +132,10 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
-        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
-        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu, cgroup, retire_lat.
+        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insn_disam,
+        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
+        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
+
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4817a37f16e2..33f7dff6d066 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -135,6 +135,7 @@ enum perf_output_field {
 	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
 	PERF_OUTPUT_DSOFF           = 1ULL << 41,
+	PERF_OUTPUT_INSN_DISAM      = 1ULL << 42,
 };
 
 struct perf_script {
@@ -190,6 +191,7 @@ struct output_option {
 	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
 	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
 	{.str = "insn", .field = PERF_OUTPUT_INSN},
+	{.str = "insn_disam", .field = PERF_OUTPUT_INSN_DISAM},
 	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
 	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
 	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
@@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 		printed += fprintf(fp, " insn: ");
 		printed += sample__fprintf_insn_raw(sample, fp);
 	}
+	if (PRINT_FIELD(INSN_DISAM) && sample->insn_len) {
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
+		     "brstackinsnlen,brstackoff,callindent,insn,insn_disam,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
 		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
 		     parse_output_fields),
-- 
2.25.1


