Return-Path: <linux-kernel+bounces-111285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBEF886A21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05276B234D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1A383AF;
	Fri, 22 Mar 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNzhNNQM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EFA4C79;
	Fri, 22 Mar 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102943; cv=none; b=QcxKPxHnsngSBvvuQ/aeF9fKfNMiZtp6t+0pHiOiJq0V8tmgghjD+SVDAL5qFlD04LRu8Xt8jla7xaL5foCzDDiBLUk1BMGK+Q3dwYOcey8X7Fci8hWB0Lxa101AGBbpM7PG/9fPI7YOAzwTH9WQC9KzaqtbOJDXQIYcBln570I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102943; c=relaxed/simple;
	bh=k1IS41lyBGD8zf9iJl7Auea+u/99RurJQHJbEsUY61I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK9DmmSMzVXhi61e+IXiqdc+z5uM63Iq78mKo1uOwqYCfBQaaPznko61KoxlB/Qx+LYW14wv+xEzYNbFjLdp8hZajEyvLyzaxWyCZ4wX7KBS5d4A9aFRGVj8KJE4XmQrWJg30agGxlhuvffvpFZkH+XUcGm14AgvCgWFuPeZQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNzhNNQM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711102942; x=1742638942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1IS41lyBGD8zf9iJl7Auea+u/99RurJQHJbEsUY61I=;
  b=RNzhNNQMojx0J9OnJ558I7ITDIKlRz4dRdb5kDuEi7IAKM8rCxXdB8Uy
   5ciyX33Cza1RYa9HftAr+d2TmLo7iB6eSYeSFRDufkVGF2Vi6U7oBMjKT
   6qk1sE2tq+VfHB66/Pc+XtO2BFdQLDYgKw/UgNT1lxpejuobHPelpmyGT
   1AlTumi/lgIYfKQ7S3tzQKxXNhrxqRIMceMSk1Lip5NhlchTCalugRLGu
   r0GT9rcX8PIQhreShaDPwjIUse87QJfwEME/7y/SJOyaKjT0L8g7JSxvg
   qtkRV9kBhNsvkWIdA/7NKkFaQKZDtA4mx1siSlFIIndUA1MrI47aIirbX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17292092"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="17292092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19558048"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.37.137])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:22:18 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	changbin.du@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf script: Consolidate capstone print functions
Date: Fri, 22 Mar 2024 12:21:58 +0200
Message-Id: <20240322102158.19738-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZfovVgjCm5oDbze9@tassilo>
References: <ZfovVgjCm5oDbze9@tassilo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Consolidate capstone print functions, to reduce duplication. Amend call
sites to use a file pointer for output, which is consistent with most
perf tools print functions. Add print_opts with an option to print also
the hex value of a resolved symbol+offset.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


On 20/03/24 02:35, Andi Kleen wrote:
> On Tue, Mar 19, 2024 at 08:52:33AM +0200, Adrian Hunter wrote:
>> On 19/03/24 00:06, Andi Kleen wrote:
>>>> Better to factor out a function that does not depend on "sample"
>>>> e.g. see fprintf_insn_asm() below.
>>>
>>> this doesn't work because it completely ignores the need of the
>>> cs_dump_insn caller for the path that i actually need for my feature,
>>> which requires to return a string.  I didn't apply it.
>>
>> I would probably change the call sites because they already have a
>> file descriptor, but output to memory is doable:
> 
>> 	FILE *fp = fmemopen(x->out, sizeof(x->out), "w+");
> 
> I considered using this at some point, but I'm sure there is some non glibc,
> that people build perf with, that doesn't have fmemopen, so I didn't.

fmemopen() is POSIX since 2008

> 
> Can we just use my version for now and if you prefer more refactor
> please submit a follow on cleanup patch?

Sure, here is a follow on cleanup patch.


 tools/perf/builtin-script.c  |  43 ++++++++++-----
 tools/perf/util/print_insn.c | 103 ++++++++++++-----------------------
 tools/perf/util/print_insn.h |   7 ++-
 3 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 59933bd52e0f..6384acf8dad7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1165,18 +1165,29 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	return ret;
 }
 
-static const char *any_dump_insn(struct perf_event_attr *attr __maybe_unused,
-			struct perf_insn *x, uint64_t ip,
-			u8 *inbuf, int inlen, int *lenp)
+static int any_dump_insn(struct perf_event_attr *attr __maybe_unused,
+			 struct perf_insn *x, uint64_t ip,
+			 u8 *inbuf, int inlen, int *lenp,
+			 FILE *fp)
 {
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	if (PRINT_FIELD(BRSTACKDISASM)) {
-		const char *p = cs_dump_insn(x, ip, inbuf, inlen, lenp);
-		if (p)
-			return p;
+		int printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
+					       (uint8_t *)inbuf, inlen, ip, lenp,
+					       PRINT_INSN_IMM_HEX, fp);
+
+		if (printed > 0)
+			return printed;
 	}
 #endif
-	return dump_insn(x, ip, inbuf, inlen, lenp);
+	return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
+}
+
+static int add_padding(FILE *fp, int printed, int padding)
+{
+	if (printed >= 0 && printed < padding)
+		printed += fprintf(fp, "%*s", padding - printed, "");
+	return printed;
 }
 
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
@@ -1186,8 +1197,10 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct thread *thread)
 {
 	int ilen = 0;
-	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
-			      any_dump_insn(attr, x, ip, inbuf, len, &ilen));
+	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
+
+	printed += add_padding(fp, any_dump_insn(attr, x, ip, inbuf, len, &ilen, fp), 30);
+	printed += fprintf(fp, "\t");
 
 	if (PRINT_FIELD(BRSTACKINSNLEN))
 		printed += fprintf(fp, "ilen: %d\t", ilen);
@@ -1330,8 +1343,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				break;
 			} else {
 				ilen = 0;
-				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
-						   any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen));
+				printed += fprintf(fp, "\t%016" PRIx64 "\t", ip);
+				printed += any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen, fp);
 				if (PRINT_FIELD(BRSTACKINSNLEN))
 					printed += fprintf(fp, "\tilen: %d", ilen);
 				printed += fprintf(fp, "\n");
@@ -1378,8 +1391,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		if (len <= 0)
 			goto out;
 		ilen = 0;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
-			any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen));
+		printed += fprintf(fp, "\t%016" PRIx64 "\t", sample->ip);
+		printed += any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
@@ -1389,8 +1402,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	}
 	for (off = 0; off <= end - start; off += ilen) {
 		ilen = 0;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
-				   any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen));
+		printed += fprintf(fp, "\t%016" PRIx64 "\t", start + off);
+		printed += any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 8825330d435f..931a2c5293c9 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -72,59 +72,8 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
 	return 0;
 }
 
-static void dump_insn_x86(struct thread *thread, cs_insn *insn, struct perf_insn *x)
-{
-	struct addr_location al;
-	bool printed = false;
-
-	if (insn->detail && insn->detail->x86.op_count == 1) {
-		cs_x86_op *op = &insn->detail->x86.operands[0];
-
-		addr_location__init(&al);
-		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, x->cpumode, op->imm, &al) &&
-		    al.sym &&
-		    al.addr < al.sym->end) {
-			snprintf(x->out, sizeof(x->out), "%s %s+%#" PRIx64 " [%#" PRIx64 "]", insn[0].mnemonic,
-					al.sym->name, al.addr - al.sym->start, op->imm);
-			printed = true;
-		}
-		addr_location__exit(&al);
-	}
-
-	if (!printed)
-		snprintf(x->out, sizeof(x->out), "%s %s", insn[0].mnemonic, insn[0].op_str);
-}
-
-const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
-			 u8 *inbuf, int inlen, int *lenp)
-{
-	int ret;
-	int count;
-	cs_insn *insn;
-	csh cs_handle;
-
-	ret = capstone_init(x->machine, &cs_handle, x->is64bit);
-	if (ret < 0)
-		return NULL;
-
-	count = cs_disasm(cs_handle, (uint8_t *)inbuf, inlen, ip, 1, &insn);
-	if (count > 0) {
-		if (machine__normalized_is(x->machine, "x86"))
-			dump_insn_x86(x->thread, &insn[0], x);
-		else
-			snprintf(x->out, sizeof(x->out), "%s %s",
-					insn[0].mnemonic, insn[0].op_str);
-		*lenp = insn->size;
-		cs_free(insn, count);
-	} else {
-		return NULL;
-	}
-	return x->out;
-}
-
-static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
-			     cs_insn *insn, FILE *fp)
+static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
+			     int print_opts, FILE *fp)
 {
 	struct addr_location al;
 	size_t printed = 0;
@@ -134,9 +83,11 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
+		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
 			printed += fprintf(fp, "%s ", insn[0].mnemonic);
 			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
+			if (print_opts & PRINT_INSN_IMM_HEX)
+				printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
 			addr_location__exit(&al);
 			return printed;
 		}
@@ -159,39 +110,53 @@ static bool is64bitip(struct machine *machine, struct addr_location *al)
 		machine__normalized_is(machine, "s390");
 }
 
-size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
-				struct machine *machine, FILE *fp,
-				struct addr_location *al)
+ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+			 bool is64bit, const uint8_t *code, size_t code_size,
+			 uint64_t ip, int *lenp, int print_opts, FILE *fp)
 {
-	csh cs_handle;
+	size_t printed;
 	cs_insn *insn;
+	csh cs_handle;
 	size_t count;
-	size_t printed = 0;
 	int ret;
-	bool is64bit = is64bitip(machine, al);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
 	ret = capstone_init(machine, &cs_handle, is64bit);
-	if (ret < 0) {
-		/* fallback */
-		return sample__fprintf_insn_raw(sample, fp);
-	}
+	if (ret < 0)
+		return ret;
 
-	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
-			  sample->ip, 1, &insn);
+	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
 		if (machine__normalized_is(machine, "x86"))
-			printed += print_insn_x86(sample, thread, &insn[0], fp);
+			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
 		else
-			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+		if (lenp)
+			*lenp = insn->size;
 		cs_free(insn, count);
 	} else {
-		printed += fprintf(fp, "illegal instruction");
+		printed = -1;
 	}
 
 	cs_close(&cs_handle);
 	return printed;
 }
+
+size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
+				struct machine *machine, FILE *fp,
+				struct addr_location *al)
+{
+	bool is64bit = is64bitip(machine, al);
+	ssize_t printed;
+
+	printed = fprintf_insn_asm(machine, thread, sample->cpumode, is64bit,
+				   (uint8_t *)sample->insn, sample->insn_len,
+				   sample->ip, NULL, 0, fp);
+	if (printed < 0)
+		return sample__fprintf_insn_raw(sample, fp);
+
+	return printed;
+}
 #else
 size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
 				struct thread *thread __maybe_unused,
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index c2a6391a45ce..07d11af3fc1c 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -10,10 +10,13 @@ struct thread;
 struct machine;
 struct perf_insn;
 
+#define PRINT_INSN_IMM_HEX		(1<<0)
+
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
 				struct machine *machine, FILE *fp, struct addr_location *al);
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
-const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
-                         u8 *inbuf, int inlen, int *lenp);
+ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+			 bool is64bit, const uint8_t *code, size_t code_size,
+			 uint64_t ip, int *lenp, int print_opts, FILE *fp);
 
 #endif /* PERF_PRINT_INSN_H */
-- 
2.34.1


