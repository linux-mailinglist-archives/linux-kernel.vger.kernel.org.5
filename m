Return-Path: <linux-kernel+bounces-147342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE68A72BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD141C212ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0E134411;
	Tue, 16 Apr 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="di+jfiIr"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3013440E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290315; cv=none; b=LZUbD50axT3lZa8F1WZvm9PByAoiVkiEc2yUBNCCkrq1N3gZmSY9hZFJYtKiLpICh50HabrKdhxT0orWUFJdMirR/B6ebZQdVMXIOb7wVeilNvVHbUZOB8NRbI07HQPDcfRu09a2tnykCDijtarsCrKSb4z8XQ31agDGevcdiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290315; c=relaxed/simple;
	bh=N/CT3P+7Omjf+N3+98a/akj+c61vNBEbUc2l3yWJgv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJuUtS+JliN4aMY+0vViXJZmgbqOkHmFoGg2TpcdohYvrhQ+wKtABpzFcTxDj3hFckxthdec+qtrekf4eQG6YwHw0U5pBIEk4B06eQ3YAQqoOl0ygitHHHGTl8SDbGdPrHc6tXiM8kPRHWA0yh7mCnz3JLeiN/7olCJqiKpqHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=di+jfiIr; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GHw45O3329010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 16 Apr 2024 10:58:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GHw45O3329010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713290288;
	bh=qHKdQNIRLeXfXAGjCu8RT/wfxxJhV8OqX6DD/MneApw=;
	h=From:To:Cc:Subject:Date:From;
	b=di+jfiIrG6pz7i7B5odEOQg74nBlpvV0sgG1uPd6eG0A5nYJzFiIYQ/EwAqeYUyL2
	 uIHPnAQLPOAnRdtBCtufd7mEz17smmJxBAqP4fILmIqK+Xa9LiHnFQb2GzdKjURG62
	 14xjSHRMXdeojiWoW0HIkURtfxJWPOcXYHUxCxYEI2fMzlhTfkYkonGB0ulmr4OVbO
	 QYwjpWhUIJdUMz3ID60PvsXhNlwMsQCsc3lOBXA/8Nm/6244CsVxuePiKTFm0JZB4e
	 5srF40hM96gyDE/0lwA/FkVcgC/lTRTU41qfHsRByJpWYccYHLJZgttMecb5yT1BxK
	 rvG6IG4GEqRnQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v2 1/1] x86/fred: Fix INT80 emulation for FRED
Date: Tue, 16 Apr 2024 10:58:03 -0700
Message-ID: <20240416175804.3328999-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a FRED-specific INT80 handler fred_int80_emulation().

Commit
  55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
added a bunch of checks to the int $0x80 path, however they are
unnecessary and event wrong in fact under FRED.

1) FRED distinguishes external interrupts from software interrupts,
   thus int80_emulation() should NEVER be called for handling an
   external interrupt, and then int80_is_external() is meaningless
   when FRED is enabled.

2) The FRED kernel entry handler NEVER dispatches INTx, which is
   of event type EVENT_TYPE_SWINT, so the user mode checking in
   do_int80_emulation() is redundant.

3) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likly
   an overkill for new x86 CPU implementations that support FRED.

A dedicated FRED INT80 handler duplicates most of the code in
do_int80_emulation(), but it avoids sprinkling moar tests and
seems more readable.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v1:
* Prefer a FRED-specific INT80 handler instead of sprinkling moar
  tests around (Borislav Petkov).
---
 arch/x86/entry/common.c     | 40 +++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_fred.c |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..3cfc7c4fe1a2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,6 +255,46 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * Called only if a user level application executes "int $0x80".
+ *
+ * Note, under FRED interrupt 0x80 could be used as a hardware interrupt.
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


