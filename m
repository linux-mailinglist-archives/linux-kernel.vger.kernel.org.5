Return-Path: <linux-kernel+bounces-69725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D149C858DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E92B21AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224501E89A;
	Sat, 17 Feb 2024 07:41:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88641D526;
	Sat, 17 Feb 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155695; cv=none; b=Wx73OWi76J6ct66nSnQ5WksZEx6S92Ler89plC9ygzu+VvDhomeFdd8GnJUTAtSLpGEAfEVHcVTB5b1JuSnrrwg1y9FgaGbG30/hDaPRiquAkKh/lmq/3wrdRqXdaWwBYQnjyObEDapQTvnUYSQLD1Eu4nkmm3IPUtESqKVCHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155695; c=relaxed/simple;
	bh=L+pZSq0Y2ocTmSe9NysyU/JS36LXhGL7+0Fxp73TbbE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN21R4RXzKd9+sBDiNsFbQll3h2w+pBjXMBykVgn5JsdGOBkkJnX5SY6Ih00lkie20XdyO+u05BSwsVJpUrreTFYIlFk8rHCFaDCL5cyMvJ+8cGI0JbkwuG6EoLe5VnShngpHTM/8Bw84AgXIJvCHua6Ijqipcsk+idBMlr3+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TcLLP1yFnz1xnl6;
	Sat, 17 Feb 2024 15:40:13 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 68AC3140485;
	Sat, 17 Feb 2024 15:41:31 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 17 Feb 2024 15:41:30 +0800
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
Subject: [PATCH v8 5/5] perf: script: prefer capstone to XED
Date: Sat, 17 Feb 2024 15:40:46 +0800
Message-ID: <20240217074046.4100789-6-changbin.du@huawei.com>
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

Now perf can show assembly instructions with libcapstone for x86, and the
capstone is better in general.

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2:
  - update Documentation.  (Adrian Hunter)
  - fix typo.
---
 tools/perf/Documentation/perf-intel-pt.txt | 14 +++++++++-----
 tools/perf/ui/browsers/res_sample.c        |  2 +-
 tools/perf/ui/browsers/scripts.c           |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 2109690b0d5f..59ab1ff9d75f 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -115,9 +115,13 @@ toggle respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
+	perf script --insn-trace=disasm
+
+or to use the xed disassembler, which requires installing the xed tool
+(see XED below):
+
 	perf script --insn-trace --xed
 
-Dump all instructions. This requires installing the xed tool (see XED below)
 Dumping all instructions in a long trace can be fairly slow. It is usually better
 to start with higher level decoding, like
 
@@ -130,12 +134,12 @@ or
 and then select a time range of interest. The time range can then be examined
 in detail with
 
-	perf script --time starttime,stoptime --insn-trace --xed
+	perf script --time starttime,stoptime --insn-trace=disasm
 
 While examining the trace it's also useful to filter on specific CPUs using
 the -C option
 
-	perf script --time starttime,stoptime --insn-trace --xed -C 1
+	perf script --time starttime,stoptime --insn-trace=disasm -C 1
 
 Dump all instructions in time range on CPU 1.
 
@@ -1306,7 +1310,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
 
 perf script can be used to provide an instruction trace
 
- $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
        CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
        CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
        CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
@@ -1407,7 +1411,7 @@ There were none.
 
 'perf script' can be used to provide an instruction trace showing timestamps
 
- $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 7cb2d6678039..5f60e515b12e 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		     r->tid ? "--tid " : "",
 		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
 		     extra_format,
-		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_ASM ? "-F +disasm" :
 		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
 		     symbol_conf.inline_name ? "--inline" : "",
 		     "--show-lost-events ",
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 50d45054ed6c..e437d7889de6 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
 	if (evsel)
 		attr_to_script(scriptc.extra_format, &evsel->core.attr);
 	add_script_option("Show individual samples", "", &scriptc);
-	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+	add_script_option("Show individual samples with assembler", "-F +disasm",
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
-- 
2.25.1


