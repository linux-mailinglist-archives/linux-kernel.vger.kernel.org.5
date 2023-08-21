Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321F78211F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjHUBTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjHUBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75EA0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81601625E7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771CAC433C7;
        Mon, 21 Aug 2023 01:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580774;
        bh=VITXRxzmYd+x/eSRYov7MGSe9fadUUYm+SsVHZIsK90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnLGpssLnig19O7XuSvdqyualyIfVZTWxLdMDmAAacwE+GksIRYECU8G7PQslNpbK
         d6oCA8KNuFpFq3VATCubAtmsAKmBk2NxTrojDL5nd1iFqvISpn4+w7FAo3LDlKYtWR
         UcP1OVJmK56gMEZPq/A/5nmiI2NovhEel36iKEWx1xohExLur1nEJjQAI6GbuaiyIG
         IKSyv/Md+WFfSif6c5kFykUcW56oatRIPlCwOi1whRLTu00j7NBotuXEwgckCA8DOs
         PxapRxvuGyPIuHX46fwMyE430CCwrQ/KOxewOJC0Ol8rSjxo3xWU1Jr2ZMjouP9LQ4
         vNzbMmLyEdQvg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/22] x86/srso: Fix vulnerability reporting for missing microcode
Date:   Sun, 20 Aug 2023 18:19:10 -0700
Message-ID: <eb3742847f3f374fb1761e8284890792ebcfaea1.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRSO default safe-ret mitigation is reported as "mitigated" even if
microcode hasn't been updated.  That's wrong because userspace may still
be vulnerable to SRSO attacks due to IBPB not flushing branch type
predictions.

Report the safe-ret + !microcode case as vulnerable.

Also report the microcode-only case as vulnerable as it leaves the
kernel open to attacks.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/srso.rst | 22 +++++++++----
 arch/x86/kernel/cpu/bugs.c                 | 36 +++++++++++++---------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index b6cfb51cb0b4..4516719e00b5 100644
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
+   The "Safe Ret" mitigation (see below) has been applied to protect the
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
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index aeddd5ce9f34..f24c0f7e3e8a 100644
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
@@ -2406,13 +2410,10 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off() || srso_cmd == SRSO_CMD_OFF)
 		goto out;
 
-	if (!has_microcode) {
-		pr_warn("IBPB-extending microcode not applied!\n");
-		pr_warn(SRSO_NOTICE);
-	} else {
+	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
@@ -2427,6 +2428,12 @@ static void __init srso_select_mitigation(void)
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out_print;
 		}
+	} else {
+		pr_warn("IBPB-extending microcode not applied!\n");
+		pr_warn(SRSO_NOTICE);
+
+		/* may be overwritten by SRSO_CMD_SAFE_RET below */
+		srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 	}
 
 	switch (srso_cmd) {
@@ -2456,7 +2463,10 @@ static void __init srso_select_mitigation(void)
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
@@ -2696,9 +2706,7 @@ static ssize_t srso_show_state(char *buf)
 	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
 		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
 
-	return sysfs_emit(buf, "%s%s\n",
-			  srso_strings[srso_mitigation],
-			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
+	return sysfs_emit(buf, "%s\n", srso_strings[srso_mitigation]);
 }
 
 static ssize_t gds_show_state(char *buf)
-- 
2.41.0

