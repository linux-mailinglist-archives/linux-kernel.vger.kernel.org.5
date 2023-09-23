Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6C7AC1ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjIWMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjIWMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599119E;
        Sat, 23 Sep 2023 05:20:13 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUy1lbYMT+Y8MxMW8a1+gM5qQU4f8ydFq0r8SGpHcCw=;
        b=fxmwkvRM09KDjVExjHyeBUVmOUcYciV1Icbodq2vE4J5YPqbt78cvAgO+lX/ZQCAbuLbMt
        k1NaFCGbcolnzTHW9Idqw91YwYeq1YgEU8BScE+ksuc4QU69gAvWCcBBsZKDOwZ46di2Aw
        2v14ijVlF/NlNPpPwfJGzBY2nK/NcEPD68FsnA2FP3Q93iLrN2Za8utCns6iIs3DLVmVXo
        K2I97ShhMmn59t2P8tdGLAil53WHSlNmRNv7y+XYVMgynySxojCGCqAcvh7NVeFrS1+Avm
        bZqEgMg6QxmcpwT+1a2QUiSUYJUw7Ix5b7X/oCnUOzgwqRH0qRtUiQA9DHSmzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUy1lbYMT+Y8MxMW8a1+gM5qQU4f8ydFq0r8SGpHcCw=;
        b=tLn63FYKkCxXKob7R3qQpiUKwoYuJfOjfFJhLdLs/fR830j6u4tlgi3cLOzTwY2XC3co0N
        hSQ7uzOWhwcFo0Dg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Fix vulnerability reporting for missing microcode
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a8a14f97d1b0e03ec255c81637afdf4cf0ae9c99.1693889988.git.jpoimboe@kernel.org>
References: <a8a14f97d1b0e03ec255c81637afdf4cf0ae9c99.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547161142.27769.8858709009368292828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8caca8ceaae016329eb055f39bb0c95246bcc5b1
Gitweb:        https://git.kernel.org/tip/8caca8ceaae016329eb055f39bb0c95246bcc5b1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:02 +02:00

x86/srso: Fix vulnerability reporting for missing microcode

The SRSO default safe-ret mitigation is reported as "mitigated" even if
microcode hasn't been updated.  That's wrong because userspace may still
be vulnerable to SRSO attacks due to IBPB not flushing branch type
predictions.

Report the safe-ret + !microcode case as vulnerable.

Also report the microcode-only case as vulnerable as it leaves the
kernel open to attacks.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/a8a14f97d1b0e03ec255c81637afdf4cf0ae9c99.1693889988.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/srso.rst | 24 +++++++++-----
 arch/x86/kernel/cpu/bugs.c                 | 36 ++++++++++++---------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index b6cfb51..e715bfc 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -46,12 +46,22 @@ The possible values in this file are:
 
    The processor is not vulnerable
 
- * 'Vulnerable: no microcode':
+* 'Vulnerable':
+
+   The processor is vulnerable and no mitigations have been applied.
+
+ * 'Vulnerable: No microcode':
 
    The processor is vulnerable, no microcode extending IBPB
    functionality to address the vulnerability has been applied.
 
- * 'Mitigation: microcode':
+ * 'Vulnerable: Safe RET, no microcode':
+
+   The "Safe RET" mitigation (see below) has been applied to protect the
+   kernel, but the IBPB-extending microcode has not been applied.  User
+   space tasks may still be vulnerable.
+
+ * 'Vulnerable: Microcode, no safe RET':
 
    Extended IBPB functionality microcode patch has been applied. It does
    not address User->Kernel and Guest->Host transitions protection but it
@@ -72,11 +82,11 @@ The possible values in this file are:
 
    (spec_rstack_overflow=microcode)
 
- * 'Mitigation: safe RET':
+ * 'Mitigation: Safe RET':
 
-   Software-only mitigation. It complements the extended IBPB microcode
-   patch functionality by addressing User->Kernel and Guest->Host
-   transitions protection.
+   Combined microcode/software mitigation. It complements the
+   extended IBPB microcode patch functionality by addressing
+   User->Kernel and Guest->Host transitions protection.
 
    Selected by default or by spec_rstack_overflow=safe-ret
 
@@ -129,7 +139,7 @@ an indrect branch prediction barrier after having applied the required
 microcode patch for one's system. This mitigation comes also at
 a performance cost.
 
-Mitigation: safe RET
+Mitigation: Safe RET
 --------------------
 
 The mitigation works by ensuring all RET instructions speculate to
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c47f37..e45dd69 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2353,6 +2353,8 @@ early_param("l1tf", l1tf_cmdline);
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_UCODE_NEEDED,
+	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
 	SRSO_MITIGATION_SAFE_RET,
 	SRSO_MITIGATION_IBPB,
@@ -2368,11 +2370,13 @@ enum srso_mitigation_cmd {
 };
 
 static const char * const srso_strings[] = {
-	[SRSO_MITIGATION_NONE]           = "Vulnerable",
-	[SRSO_MITIGATION_MICROCODE]      = "Mitigation: microcode",
-	[SRSO_MITIGATION_SAFE_RET]	 = "Mitigation: safe RET",
-	[SRSO_MITIGATION_IBPB]		 = "Mitigation: IBPB",
-	[SRSO_MITIGATION_IBPB_ON_VMEXIT] = "Mitigation: IBPB on VMEXIT only"
+	[SRSO_MITIGATION_NONE]			= "Vulnerable",
+	[SRSO_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
+	[SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED]	= "Vulnerable: Safe RET, no microcode",
+	[SRSO_MITIGATION_MICROCODE]		= "Vulnerable: Microcode, no safe RET",
+	[SRSO_MITIGATION_SAFE_RET]		= "Mitigation: Safe RET",
+	[SRSO_MITIGATION_IBPB]			= "Mitigation: IBPB",
+	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only"
 };
 
 static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
@@ -2409,10 +2413,7 @@ static void __init srso_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
 		goto pred_cmd;
 
-	if (!has_microcode) {
-		pr_warn("IBPB-extending microcode not applied!\n");
-		pr_warn(SRSO_NOTICE);
-	} else {
+	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
@@ -2428,6 +2429,12 @@ static void __init srso_select_mitigation(void)
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out;
 		}
+	} else {
+		pr_warn("IBPB-extending microcode not applied!\n");
+		pr_warn(SRSO_NOTICE);
+
+		/* may be overwritten by SRSO_CMD_SAFE_RET below */
+		srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 	}
 
 	switch (srso_cmd) {
@@ -2457,7 +2464,10 @@ static void __init srso_select_mitigation(void)
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
 				x86_return_thunk = srso_return_thunk;
 			}
-			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+			if (has_microcode)
+				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+			else
+				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
 		}
@@ -2490,7 +2500,7 @@ static void __init srso_select_mitigation(void)
 	}
 
 out:
-	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
+	pr_info("%s\n", srso_strings[srso_mitigation]);
 
 pred_cmd:
 	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
@@ -2701,9 +2711,7 @@ static ssize_t srso_show_state(char *buf)
 	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
 		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
 
-	return sysfs_emit(buf, "%s%s\n",
-			  srso_strings[srso_mitigation],
-			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
+	return sysfs_emit(buf, "%s\n", srso_strings[srso_mitigation]);
 }
 
 static ssize_t gds_show_state(char *buf)
