Return-Path: <linux-kernel+bounces-28531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF982FFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9778DB247E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD17498;
	Wed, 17 Jan 2024 05:12:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26A611A;
	Wed, 17 Jan 2024 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705468379; cv=none; b=hpyi2Cg2bEbVzcOaPF03ORngy1q6IiFQokYtig6XJNVhazEz2/J60hseKxMu7nqdIN+ydfdW/K3ErdEMrH7DjAgMlD2ag4mUJxyOlw/DwckUPKyikIyjvw+DTIa9bgijqkke96PAREI3eydso+lgwbBVvgiWbgWwRQFjHHSa0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705468379; c=relaxed/simple;
	bh=d9xUie5O6P+HxlRsBhIUu4jueb9/+PkF9GI2X2Xph3Y=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=q8/PVMz+DKGi0v+YN9lcy45rh8w0D5+zF2/t9++p1Ri/6t4qrk+y6B0q/FUnFhBL1I2mgM7OIVhaCwNk2Y29Ni1DnrZSWoOgVn8uEMkRxr3EMCpOVlMYr+ncjity7Iin3UBRodtfPD3v89w8YJPCkByxqyD/+Sm6VSD6liy+bGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TFDXM5d3SzGpnc;
	Wed, 17 Jan 2024 13:12:35 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 821F1140556;
	Wed, 17 Jan 2024 13:12:40 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 17 Jan 2024 13:11:29 +0800
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
Subject: [PATCH v2 5/5] perf: script: prefer capstone to XED
Date: Wed, 17 Jan 2024 13:11:04 +0800
Message-ID: <20240117051104.2147643-6-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117051104.2147643-1-changbin.du@huawei.com>
References: <20240117051104.2147643-1-changbin.du@huawei.com>
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
 tools/perf/Documentation/perf-intel-pt.txt | 11 +++++------
 tools/perf/ui/browsers/res_sample.c        |  2 +-
 tools/perf/ui/browsers/scripts.c           |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 2109690b0d5f..13a02d568267 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -115,9 +115,8 @@ toggle respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
-	perf script --insn-trace --xed
+	perf script --insn-trace=disam
 
-Dump all instructions. This requires installing the xed tool (see XED below)
 Dumping all instructions in a long trace can be fairly slow. It is usually better
 to start with higher level decoding, like
 
@@ -130,12 +129,12 @@ or
 and then select a time range of interest. The time range can then be examined
 in detail with
 
-	perf script --time starttime,stoptime --insn-trace --xed
+	perf script --time starttime,stoptime --insn-trace=disam
 
 While examining the trace it's also useful to filter on specific CPUs using
 the -C option
 
-	perf script --time starttime,stoptime --insn-trace --xed -C 1
+	perf script --time starttime,stoptime --insn-trace=disam -C 1
 
 Dump all instructions in time range on CPU 1.
 
@@ -1306,7 +1305,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
 
 perf script can be used to provide an instruction trace
 
- $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script --guestkallsyms $KALLSYMS --insn-trace=disam -F+ipc | grep -C10 vmresume | head -21
        CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
        CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
        CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
@@ -1407,7 +1406,7 @@ There were none.
 
 'perf script' can be used to provide an instruction trace showing timestamps
 
- $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace=disam -F+ipc | grep -C10 vmresume | head -21
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 7cb2d6678039..0eb2029014a0 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		     r->tid ? "--tid " : "",
 		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
 		     extra_format,
-		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_ASM ? "-F +insn_disam" :
 		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
 		     symbol_conf.inline_name ? "--inline" : "",
 		     "--show-lost-events ",
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 47d2c7a8cbe1..a01b729f4ddc 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
 	if (evsel)
 		attr_to_script(scriptc.extra_format, &evsel->core.attr);
 	add_script_option("Show individual samples", "", &scriptc);
-	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+	add_script_option("Show individual samples with assembler", "-F +insn_disam",
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
-- 
2.25.1


