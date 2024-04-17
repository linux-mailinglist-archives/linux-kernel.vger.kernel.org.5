Return-Path: <linux-kernel+bounces-147993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1168A7C56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C19F1C2242A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE762746B;
	Wed, 17 Apr 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BBlwiVnj"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F23032A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335437; cv=none; b=fmWPLeNDXB4zgT61IYoH7vFJozWBa9GZ4dlYYEor3eztEPel3YwHAozGHVZKjK/uzu0xMB9NmqJdR1Mt0A3d2j8C31suHw7ofzDLX1DW3o59I/E/GxzxyOYV1A1+sK+02j/Y378+8T6uynnfKWbst8EtGIQzC1K1VzMyIQg8RkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335437; c=relaxed/simple;
	bh=l57S2k3a5cClPY53nArBf5nXDY9ccwkPA9ayWeYIee8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tvadu7w5njWZhB/sC82vIFftvhXxFJKeG6u5YE7HBo2FACNFZ3DVJb14bwU3nCrW9liVSrx6FyNfwq6FWuOZdMuIzYXt3ti2yZFv5avMgS7nHnt3isFolDQ21dwRp4jFiln+mLevNRutC6P2A0tDoLFq2ilKLjT0dajbGXdMvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BBlwiVnj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43H6U1Zq3773528
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 16 Apr 2024 23:30:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43H6U1Zq3773528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713335405;
	bh=Zd/sWirjrmKezpysIIxkVCSK4urm0r21DAh1st/8xeU=;
	h=From:To:Cc:Subject:Date:From;
	b=BBlwiVnjlrN5ItmaQwpVVBH5rZ3Ze8emFROoXGYe1AhtMSs7i8affBcNlqECVlbnZ
	 Dtlr5E1UyYWZsvC12HFldFxvyLgXSPU6oWYA730aFmBDxKhakvuHZZRldX9zqSc9HA
	 uEHA62DP+rgLV968zCvOp+EfWdHV5pDaXsoc0ewHFg7mrFJTUV5l5BLlhzi/c3J+KG
	 DOZ8g/WZuFoqNAyCa018JjVdWiGF9p/6Hqe5TUNqVkv1YAa855pbpjEXBl6YWaVRzT
	 sHLPEMA8j05xDOblyqsToRyfb6Kc7kJ7w34dwLOopqg/WOiDLAr6VHyjx6BXidG+V6
	 wASQ7mnFyh2hg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Date: Tue, 16 Apr 2024 23:30:01 -0700
Message-ID: <20240417063001.3773507-1-xin@zytor.com>
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

3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
   which is of event type EVENT_TYPE_SWINT, so compared with
   do_int80_emulation(), there is no need to do any user mode check.

4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
   overkill for new x86 CPU implementations that support FRED.

5) int $0x80 is the FAST path for 32-bit system calls under FRED.

A dedicated FRED INT80 handler duplicates quite a bit of the code in
do_int80_emulation(), but it avoids sprinkling more tests and seems
more readable. Just remember that we can always unify common stuff
later if it turns out that it won't diverge anymore, i.e., after the
FRED code settles.

Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

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
 arch/x86/entry/common.c     | 64 +++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_fred.c |  2 +-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..213d9b33a63c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,6 +255,70 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
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
+ * 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
+ *    which is of event type EVENT_TYPE_SWINT, so compared with
+ *    do_int80_emulation(), there is no need to do any user mode check.
+ *
+ * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
+ *    overkill for new x86 CPU implementations that support FRED.
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
 

base-commit: 367dc2b68007e8ca00a0d8dc9afb69bff5451ae7
-- 
2.44.0


