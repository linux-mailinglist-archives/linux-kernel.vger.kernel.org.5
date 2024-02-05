Return-Path: <linux-kernel+bounces-52866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D796F849D99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033F41C23847
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E52CCBA;
	Mon,  5 Feb 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3QTN7G6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEB2C84F;
	Mon,  5 Feb 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145131; cv=none; b=rTnUJqoQPfeMpDQQlD7ZkTF4BgVfs/bJzRensaxaO+2Ue9Tu2Bkhp0WXcNvUcGbPu8cjhO+DgdByJg6UzmxflUXBkdi1L0x1Ps/aWL+O4tUio6ds7Hve9CqrN4TJiT0Gn3JoVl7j/bAptjB3vq94Cv+y85I1gotA8lYFzoC3EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145131; c=relaxed/simple;
	bh=tXJR2T7k5Uq6FwdUAH5rqufg2PWRQL0MIQHWeqNj4NU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKjzV2Xnz3+sIX5Vc1suuxSDP4ED2PrlwaeH80EPHD7PaTje8g3FUE4hBbfrrLrzqGVhiGdXd40y9l+ff0bzkP/8cuo3EGHjE1zJCSfHPrr7SjTAOwLFu8b+pkZTAFvMIjS5h5B49VOd/UmeBDwKaDtNeFb2mx2iDKe90eEyvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3QTN7G6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707145130; x=1738681130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tXJR2T7k5Uq6FwdUAH5rqufg2PWRQL0MIQHWeqNj4NU=;
  b=b3QTN7G6wxPpAWUJOnFCho92dBdWMDgOmLNqW4u9yKwZr+74KofMIQqH
   UiIOnZpiSaUSO/f/IZwldNpDdFVsnYNdxgQ+dakiP4dtY0EeZTT8IEtkl
   vKBVvYQ6xaUCZSOgVnAOM0/V+G6T02r3e/Bwp99T1LkA12d2eaDQXDcmL
   eB/93CPmE74Ofqv5/ePStlS7Y5pC2zl4SitUsDMQa8Gu2JCnFWBJNBEO3
   K00QDy+LN/Nw0/UnPb/FGM+Kdtc5q8Z0gZq14fxzOTZ0jlIe62ZVDGHcL
   pDv3T2P7wS4V+p/SMayAVYdxxWHc+pj/FxYgrvjmTVHld7RgFJovfIayp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="23017575"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="23017575"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1045388"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa006.jf.intel.com with ESMTP; 05 Feb 2024 06:58:50 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	amiri.khalil@intel.com,
	ahmad.yasin@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf script: Print source line for each jump in brstackinsn
Date: Mon,  5 Feb 2024 06:58:19 -0800
Message-Id: <20240205145819.1943114-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

With the srcline option, the perf script only prints a source line at
the beginning of a sample with call/ret from functions, but not for
each jump in brstackinsn. It's useful to print a source line for each
jump in brstackinsn when the end user analyze the full assembler
sequences of branch sequences for the sample.

The srccode option can also be used to locate the source code line.
However, it's printed almost for every line and makes the output less
readable.

 $perf script -F +brstackinsn,+srcline --xed

Before the patch,

 tchain_edit_deb 1463275 15228549.107820:     282495 instructions:u:            401133 f3+0xd (/home/kan/os.li>
  tchain_edit.c:22
        f3+40:  tchain_edit.c:20
        000000000040114e                        jle 0x401133                    # PRED 6 cycles [6]
        0000000000401133                        movl  -0x4(%rbp), %eax
        0000000000401136                        and $0x1, %eax
        0000000000401139                        test %eax, %eax
        000000000040113b                        jz 0x401143
        000000000040113d                        addl  $0x1, -0x4(%rbp)
        0000000000401141                        jmp 0x401147                    # PRED 3 cycles [9] 2.00 IPC
        0000000000401147                        cmpl  $0x3e7, -0x4(%rbp)
        000000000040114e                        jle 0x401133                    # PRED 6 cycles [15] 0.33 IPC

After the patch,

 tchain_edit_deb 1463275 15228549.107820:     282495 instructions:u:            401133 f3+0xd (/home/kan/os.li>
  tchain_edit.c:22
        f3+40:  tchain_edit.c:20
        000000000040114e                        jle 0x401133                     srcline: tchain_edit.c:20      # PRED 6 cycles [6]
        0000000000401133                        movl  -0x4(%rbp), %eax
        0000000000401136                        and $0x1, %eax
        0000000000401139                        test %eax, %eax
        000000000040113b                        jz 0x401143
        000000000040113d                        addl  $0x1, -0x4(%rbp)
        0000000000401141                        jmp 0x401147                     srcline: tchain_edit.c:23      # PRED 3 cycles [9] 2.00 IPC
        0000000000401147                        cmpl  $0x3e7, -0x4(%rbp)
        000000000040114e                        jle 0x401133                     srcline: tchain_edit.c:20      # PRED 6 cycles [15] 0.33 IPC

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b1f57401ff23..af63b7c37c8a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1162,7 +1162,8 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
 			    int insn, FILE *fp, int *total_cycles,
-			    struct perf_event_attr *attr)
+			    struct perf_event_attr *attr,
+			    struct thread *thread)
 {
 	int ilen = 0;
 	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
@@ -1171,6 +1172,16 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 	if (PRINT_FIELD(BRSTACKINSNLEN))
 		printed += fprintf(fp, "ilen: %d\t", ilen);
 
+	if (PRINT_FIELD(SRCLINE)) {
+		struct addr_location al;
+
+		addr_location__init(&al);
+		thread__find_map(thread, x->cpumode, ip, &al);
+		printed += map__fprintf_srcline(al.map, al.addr, " srcline: ", fp);
+		printed += fprintf(fp, "\t");
+		addr_location__exit(&al);
+	}
+
 	printed += fprintf(fp, "#%s%s%s%s",
 			      en->flags.predicted ? " PRED" : "",
 			      en->flags.mispred ? " MISPRED" : "",
@@ -1182,6 +1193,7 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		if (insn)
 			printed += fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
+
 	return printed + fprintf(fp, "\n");
 }
 
@@ -1260,7 +1272,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles,
-					    attr);
+					    attr, thread);
 		if (PRINT_FIELD(SRCCODE))
 			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
@@ -1291,7 +1303,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
 				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
-							    &total_cycles, attr);
+							    &total_cycles, attr, thread);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
-- 
2.35.1


