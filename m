Return-Path: <linux-kernel+bounces-51415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0ED848AF7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8050DB258AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892FA17F7;
	Sun,  4 Feb 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="KLq57fu1"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5063A1;
	Sun,  4 Feb 2024 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707019077; cv=none; b=ZtLibcZ4NcgQrrLnknlSEqu1BDMwgoz72Sbn/Sb25mL0S4jHJyDuZCOUs/8zfBU8lX9GLmXbQDjt4DcHOg1xzwlzt3fCrjSBgNDeYuvWL6zJOnShpSv5epvUf9KRUdUgCLjhwmOiV2mvcS3CJcWHEG/3Lj0H8qySW6ujVWy0Nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707019077; c=relaxed/simple;
	bh=WD//COAAgnwG6ByL9FIxCxWk6nNqTSw772pmIuR8KyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTUxzT8Cu2xHAJCDe+iP2gxd1K2kfIrMNcLA6+Z9FL9vWwb+5LdcRmbT8sEi/SCpsUu5RwlcuqDrG8wZ1Ef1BtaBF5aHVZPkpkoc5TavH6FpSH+YL162t1IkIHiXRMHsZI2fe4b9z7kKRz81693Z9JWMdsgxwPIT7/znulAKMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=KLq57fu1; arc=none smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4140prQH023253;
	Sun, 4 Feb 2024 03:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=QKbEKF0BOPhRZnolIBDBWcg1t+uTArb4iAsWd5YiF10=;
 b=KLq57fu1F+VBizIUU7SbpnoOGk2ACVWDAVGSrlHtlBhjKfHgr5LULDfhhGLZifoDbL01
 7CJRcq9Ut0tgxrzCD45HA+fgS+WhONZo0/Qo355B4vJTDfn7OlyG8eFDsIRYeApRHg4Y
 n7lXn4YWKlAQX/4ilWViaF/9gOrEyh0kTVIr5T7iuYvJ7n7EtMu/8HwxHBADz3Up30Dj
 fpBN8AZ53DZM7kOXSz0w+Xl/Ha1GQUPd8qzMEnNNu3QzbdCHoFoLCi4NQJMgmU08+D5N
 39afaFKDEK1TFK9f08xiePsVZx2D2BBQ5t4mLG3vdzv7i+XpjaC0/+IKFiXA5qGkXkP9 xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3w1e8n4ktt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 03:13:05 +0000
Received: from m0166257.ppops.net (m0166257.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4143D4Fw010150;
	Sun, 4 Feb 2024 03:13:05 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0a-00007101.pphosted.com (PPS) with ESMTP id 3w1e8n4ktm-2;
	Sun, 04 Feb 2024 03:13:05 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH v2 1/3] x86/kprobes: Refactor can_{probe,boost} return type to bool
Date: Sat,  3 Feb 2024 21:12:58 -0600
Message-ID: <20240204031300.830475-2-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204031300.830475-1-jinghao7@illinois.edu>
References: <20240204031300.830475-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BvmB3QU77cDUQOBIJkGSbqBZkiK1PtJh
X-Proofpoint-ORIG-GUID: oTAYOSqsYwSJlP7N4HcTMSh_KAGAJsTs
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402040022
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Both can_probe and can_boost have int return type but are using int as
boolean in their context.

Refactor both functions to make them actually return boolean.

Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 arch/x86/kernel/kprobes/common.h |  2 +-
 arch/x86/kernel/kprobes/core.c   | 33 +++++++++++++++-----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index c993521d4933..e772276f5aa9 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -78,7 +78,7 @@
 #endif
 
 /* Ensure if the instruction can be boostable */
-extern int can_boost(struct insn *insn, void *orig_addr);
+extern bool can_boost(struct insn *insn, void *orig_addr);
 /* Recover instruction if given address is probed */
 extern unsigned long recover_probed_instruction(kprobe_opcode_t *buf,
 					 unsigned long addr);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e8babebad7b8..644d416441fb 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -137,14 +137,14 @@ NOKPROBE_SYMBOL(synthesize_relcall);
  * Returns non-zero if INSN is boostable.
  * RIP relative instructions are adjusted at copying time in 64 bits mode
  */
-int can_boost(struct insn *insn, void *addr)
+bool can_boost(struct insn *insn, void *addr)
 {
 	kprobe_opcode_t opcode;
 	insn_byte_t prefix;
 	int i;
 
 	if (search_exception_tables((unsigned long)addr))
-		return 0;	/* Page fault may occur on this address. */
+		return false;	/* Page fault may occur on this address. */
 
 	/* 2nd-byte opcode */
 	if (insn->opcode.nbytes == 2)
@@ -152,7 +152,7 @@ int can_boost(struct insn *insn, void *addr)
 				(unsigned long *)twobyte_is_boostable);
 
 	if (insn->opcode.nbytes != 1)
-		return 0;
+		return false;
 
 	for_each_insn_prefix(insn, i, prefix) {
 		insn_attr_t attr;
@@ -160,7 +160,7 @@ int can_boost(struct insn *insn, void *addr)
 		attr = inat_get_opcode_attribute(prefix);
 		/* Can't boost Address-size override prefix and CS override prefix */
 		if (prefix == 0x2e || inat_is_address_size_prefix(attr))
-			return 0;
+			return false;
 	}
 
 	opcode = insn->opcode.bytes[0];
@@ -181,12 +181,12 @@ int can_boost(struct insn *insn, void *addr)
 	case 0xf6 ... 0xf7:	/* Grp3 */
 	case 0xfe:		/* Grp4 */
 		/* ... are not boostable */
-		return 0;
+		return false;
 	case 0xff:		/* Grp5 */
 		/* Only indirect jmp is boostable */
 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		return 1;
+		return true;
 	}
 }
 
@@ -253,20 +253,18 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 }
 
 /* Check if paddr is at an instruction boundary */
-static int can_probe(unsigned long paddr)
+static bool can_probe(unsigned long paddr)
 {
 	unsigned long addr, __addr, offset = 0;
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
 
 	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
-		return 0;
+		return false;
 
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
-		int ret;
-
 		/*
 		 * Check if the instruction has been modified by another
 		 * kprobe, in which case we replace the breakpoint by the
@@ -277,11 +275,10 @@ static int can_probe(unsigned long paddr)
 		 */
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
-			return 0;
+			return false;
 
-		ret = insn_decode_kernel(&insn, (void *)__addr);
-		if (ret < 0)
-			return 0;
+		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+			return false;
 
 #ifdef CONFIG_KGDB
 		/*
@@ -290,7 +287,7 @@ static int can_probe(unsigned long paddr)
 		 */
 		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE &&
 		    kgdb_has_hit_break(addr))
-			return 0;
+			return false;
 #endif
 		addr += insn.length;
 	}
@@ -310,10 +307,10 @@ static int can_probe(unsigned long paddr)
 		 */
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
-			return 0;
+			return false;
 
 		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
-			return 0;
+			return false;
 
 		if (insn.opcode.value == 0xBA)
 			offset = 12;
@@ -324,7 +321,7 @@ static int can_probe(unsigned long paddr)
 
 		/* This movl/addl is used for decoding CFI. */
 		if (is_cfi_trap(addr + offset))
-			return 0;
+			return false;
 	}
 
 out:
-- 
2.43.0


