Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82079780AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376568AbjHRLO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376562AbjHRLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:14:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243EC1FE9;
        Fri, 18 Aug 2023 04:14:00 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692357238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiN71icVYzlR4s63/zJKC42piZqVUS3e45uTbzXDIvg=;
        b=Bt4nSAzrLJ4Qj7fu4XwyPWKtrGkv1M+cBy2QJ9M0punPEXdpNXsnX8qI9FA+RyjJ08gCPg
        SqgzHAyx/JHAVmLqKp3ZZRQz3YnHIJtXreb4OI2sBRlnsXjZgv/ShK9nuEPb5ffjncNzWn
        aHLG5Qlsd+WL8zWZ6o8IGW5rGDhwdtJqhrWPzKCHS+r/LvQXLU1oYLcgtcuakEstrPAy9y
        Zfqf3/vEasKzknm4Affj4SExfhE2RKsLF6dhICSohyZ0umdjRxr58mhG0+LT6RG5whWGvb
        Y/8E4DZf/GXXVcwYjYS1IvG/Pc6dfUUUnOmGjiSUhtwwww0fYn18Rn5RnK7Kxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692357238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiN71icVYzlR4s63/zJKC42piZqVUS3e45uTbzXDIvg=;
        b=8x7IENgy9KCRazznvS5R0wL2z1qTwp9QWWO9xLp8M/DCQbzhxL4qZAxVT0DhoxkxKhhwLv
        HJI6P/d+T4EG3zAw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE: Always save CS register on AMD Zen IF Poison errors
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230814200853.29258-1-yazen.ghannam@amd.com>
References: <20230814200853.29258-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <169235723803.27769.11766321060457693576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67
Gitweb:        https://git.kernel.org/tip/4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 14 Aug 2023 15:08:53 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 18 Aug 2023 13:05:52 +02:00

x86/MCE: Always save CS register on AMD Zen IF Poison errors

The Instruction Fetch (IF) units on current AMD Zen-based systems do not
guarantee a synchronous #MC is delivered for poison consumption errors.
Therefore, MCG_STATUS[EIPV|RIPV] will not be set. However, the
microarchitecture does guarantee that the exception is delivered within
the same context. In other words, the exact rIP is not known, but the
context is known to not have changed.

There is no architecturally-defined method to determine this behavior.

The Code Segment (CS) register is always valid on such IF unit poison
errors regardless of the value of MCG_STATUS[EIPV|RIPV].

Add a quirk to save the CS register for poison consumption from the IF
unit banks.

This is needed to properly determine the context of the error.
Otherwise, the severity grading function will assume the context is
IN_KERNEL due to the m->cs value being 0 (the initialized value). This
leads to unnecessary kernel panics on data poison errors due to the
kernel believing the poison consumption occurred in kernel context.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230814200853.29258-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c     | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b8ad5a5..6f35f72 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -843,6 +843,26 @@ static noinstr bool quirk_skylake_repmov(void)
 }
 
 /*
+ * Some Zen-based Instruction Fetch Units set EIPV=RIPV=0 on poison consumption
+ * errors. This means mce_gather_info() will not save the "ip" and "cs" registers.
+ *
+ * However, the context is still valid, so save the "cs" register for later use.
+ *
+ * The "ip" register is truly unknown, so don't save it or fixup EIPV/RIPV.
+ *
+ * The Instruction Fetch Unit is at MCA bank 1 for all affected systems.
+ */
+static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_regs *regs)
+{
+	if (bank != 1)
+		return;
+	if (!(m->status & MCI_STATUS_POISON))
+		return;
+
+	m->cs = regs->cs;
+}
+
+/*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
@@ -861,6 +881,9 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 		if (mce_flags.snb_ifu_quirk)
 			quirk_sandybridge_ifu(i, m, regs);
 
+		if (mce_flags.zen_ifu_quirk)
+			quirk_zen_ifu(i, m, regs);
+
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
@@ -1849,6 +1872,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x15 && c->x86_model <= 0xf)
 			mce_flags.overflow_recov = 1;
 
+		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+			mce_flags.zen_ifu_quirk = 1;
+
 	}
 
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index ed4a71c..bcf1b3c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -157,6 +157,9 @@ struct mce_vendor_flags {
 	 */
 	smca			: 1,
 
+	/* Zen IFU quirk */
+	zen_ifu_quirk		: 1,
+
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
@@ -172,7 +175,7 @@ struct mce_vendor_flags {
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 56;
+	__reserved_0		: 55;
 };
 
 extern struct mce_vendor_flags mce_flags;
