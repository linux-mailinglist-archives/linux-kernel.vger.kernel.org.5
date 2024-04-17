Return-Path: <linux-kernel+bounces-149007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D38A8A65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E11C2226E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC4171678;
	Wed, 17 Apr 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="J9wggrKL"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031311E507
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376110; cv=none; b=jarD835w1s5m6J8ylv3BT1cIn7uAEeOSZUTchQ8MO4ZUPD5qs+Heim2WoiXbOQV6FADLSSV0AqEdvoW8lg73SK+ic3KskECaOHA46y17Pysj/UwUfnT3AquVsFPBOUXmKENmY0v67k3ZPmygiwfyAQSsNuidHFVu8597OtS9Lw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376110; c=relaxed/simple;
	bh=a7bZvcywozzVlCeLFnGT0CCjqIRMqtBtMANKuD9ixYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eV1HAvKmLrr4sII/U6Zjt1oXxEYtUgPXclMndyXcNZFMO8yF3W3dhepuDgHxM5ZCJhSfW1x7f+RscuTlHoRkMyh7xDVb1u5DA7/wikhaHBnJYSiotGxrlNpWbnj87i4RVV8uNH8+kHsEwbkLcaDN4LUdvADqjJSA4ayMgmuWryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=J9wggrKL; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HHlW0r4189605
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 17 Apr 2024 10:47:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HHlW0r4189605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713376056;
	bh=Ldoe1fGWh+9vm300B76AUJF2WcamDair78tmjuXrJWM=;
	h=From:To:Cc:Subject:Date:From;
	b=J9wggrKLhkdFbVX2AgQ0wdgpiJICTxVxPwK99wz6lQHlsSjOzqNBTQ5dpNs461d6e
	 T6FBqdliu+Jb5Gy50pBaW1nuX+FllRYGK/maFoGNmHwyAQ/O7qj6zUaRYRyPsf6QoQ
	 kJcgqjr5ENhx76d3WJMZKfgyyEmo6DM2bYG7Jv0nWaIGmgepC78L8Shzja2+yj1loo
	 XexYP5XLEPACcMkkIH/O8rIJl9bErO9r7v3PigrBz/oeP/GH8raSVwVKA7mDNiwnE+
	 1+TlbM0uqi5Zs7Q0762n1oBnRzy33j8tOh9UwxQMRDq7Oeja6/Y4XEJ1x42qXNtq4T
	 44se13E4mW/Xg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v4 1/1] x86/fred: Fix INT80 emulation for FRED
Date: Wed, 17 Apr 2024 10:47:31 -0700
Message-ID: <20240417174731.4189592-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a FRED-specific INT80 handler fred_int80_emulation():

1) As INT instructions and hardware interrupts are separate event
   types, FRED does not preclude the use of vector 0x80 for external
   interrupts. As a result the FRED setup code does *NOT* reserve
   vector 0x80 and calling int80_is_external() is not merely
   suboptimal but actively incorrect: it could cause a system call
   to be incorrectly ignored.

2) fred_int80_emulation(), only called for handling vector 0x80 of
   event type EVENT_TYPE_SWINT, will NEVER be called to handle any
   external interrupt (event type EVENT_TYPE_EXTINT).

3) FRED has separate entry flows depending on if the event came from
   user space or kernel space, and because kernel does not use INT
   insns, the FRED kernel entry handler fred_entry_from_kernel()
   falls through to fred_bad_type() if the event type is
   EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
   an INT insn, it can only be from a user level application.

4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is
   IDT-specific. While FRED will likely take a different approach if
   it is ever needed: it *probably* belongs in either fred_intx()/
   fred_other() or asm_fred_entrypoint_user(), depending on if this
   ought to be done for all entries from userspace or only system
   calls.

5) int $0x80 is the FAST path for 32-bit system calls under FRED.

A dedicated FRED INT80 handler duplicates quite a bit of the code in
do_int80_emulation(), but it avoids sprinkling more tests and seems
more readable.

Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v3:
* Make it more clear that why the FRED kernel entry handler
  fred_entry_from_kernel() falls through to fred_bad_type() if the event
  type is EVENT_TYPE_SWINT, i.e., INT insns (Borislav Petkov).
* Fix the comment about CLEAR_BRANCH_HISTORY (Nikolay Borisov).

Changes since v2:
* Add comments explaining the reasons why a FRED-specific INT80 handler
  is required to the head comment of fred_int80_emulation(), not just
  the change log (H. Peter Anvin).
* Incorporate extra clarifications from H. Peter Anvin.
* Fix a few typos and wordings (H. Peter Anvin).
* Add a maintainer tip to the change log and head comment: unify common
  stuff later, i.e., after the code settles (Borislav Petkov).

Change since v1:
* Prefer a FRED-specific INT80 handler instead of sprinkling more tests
  around (Borislav Petkov).
---
 arch/x86/entry/common.c     | 71 +++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_fred.c |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..700acda99cc8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,6 +255,77 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * A FRED-specific INT80 handler fred_int80_emulation() is required:
+ *
+ * 1) As INT instructions and hardware interrupts are separate event
+ *    types, FRED does not preclude the use of vector 0x80 for external
+ *    interrupts. As a result the FRED setup code does *NOT* reserve
+ *    vector 0x80 and calling int80_is_external() is not merely
+ *    suboptimal but actively incorrect: it could cause a system call
+ *    to be incorrectly ignored.
+ *
+ * 2) fred_int80_emulation(), only called for handling vector 0x80 of
+ *    event type EVENT_TYPE_SWINT, will NEVER be called to handle any
+ *    external interrupt (event type EVENT_TYPE_EXTINT).
+ *
+ * 3) FRED has separate entry flows depending on if the event came from
+ *    user space or kernel space, and because kernel does not use INT
+ *    insns, the FRED kernel entry handler fred_entry_from_kernel()
+ *    falls through to fred_bad_type() if the event type is
+ *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
+ *    an INT insn, it can only be from a user level application.
+ *
+ * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is
+ *    IDT-specific. While FRED will likely take a different approach if
+ *    it is ever needed: it *probably* belongs in either fred_intx()/
+ *    fred_other() or asm_fred_entrypoint_user(), depending on if this
+ *    ought to be done for all entries from userspace or only system
+ *    calls.
+ *
+ * 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
+ *
+ * A dedicated FRED INT80 handler duplicates quite a bit of the code in
+ * do_int80_emulation(), but it avoids sprinkling more tests and seems
+ * more readable. Just remember that we can always unify common stuff
+ * later if it turns out that it won't diverge anymore, i.e., after the
+ * FRED code settles.
+ */
+DEFINE_FREDENTRY_RAW(int80_emulation)
+{
+	int nr;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/*
+	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
+	 * syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif
 #else /* CONFIG_IA32_EMULATION */
 
 /* Handles int $0x80 on a 32bit kernel */
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ac120cbdaaf2..9fa18b8c7f26 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -66,7 +66,7 @@ static noinstr void fred_intx(struct pt_regs *regs)
 	/* INT80 */
 	case IA32_SYSCALL_VECTOR:
 		if (ia32_enabled())
-			return int80_emulation(regs);
+			return fred_int80_emulation(regs);
 		fallthrough;
 #endif
 

base-commit: 1e0fd81e4f32a8a383c05d27a672d742b45c1088
-- 
2.44.0


