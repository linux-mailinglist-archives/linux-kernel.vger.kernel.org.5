Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9A77EB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjHPVU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346452AbjHPVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:20:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8CA128;
        Wed, 16 Aug 2023 14:20:10 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:20:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692220808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAZoSq4odcuf926GIG6s/EZI+9UAYsNETsXtiP/o2lM=;
        b=JPhoc78BcJe5HXxl0ky0Ok6qp5Qla1FKJKLELqADKSzfCI1B7vx9qELOvp5k6xm/lpO2o1
        pEOMVtRt8aJwmEZAhzQlhXxVp5o7hCySP+dvoWBocqSGs8ZqKeuqFjJcMWND8ZpcsnTd+f
        eOmtTTp9PEg0VTzcJi5fkgPHWUtvcJbUDePbxlDlPElTafpz/BnXuAN8zP8CqFPMkoLjep
        p/QEbPBGHBVZbqG157ukF8NlVCKgelOIwfHK9w7M7vRhASnhz4erORm53jlFK/w9Qfwgv6
        NpJR7W8iBxuECvmzmvtEruK/VtfxSLYFfGIlke22fXttc3NZ3+x+b1VQgx8USQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692220808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAZoSq4odcuf926GIG6s/EZI+9UAYsNETsXtiP/o2lM=;
        b=V6GEE+dS7Ov4mDnN3IrMivL1zFI+fVlbv8o3aNSn/UCGani1fmkF6HfIBgxBsf/QSAkda0
        hiVzxo6HYXpmnGAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121149.109557833@infradead.org>
References: <20230814121149.109557833@infradead.org>
MIME-Version: 1.0
Message-ID: <169222080764.27769.16766658365611464074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     864bcaa38ee44ec6c0e43f79c2d2997b977e26b2
Gitweb:        https://git.kernel.org/tip/864bcaa38ee44ec6c0e43f79c2d2997b977e26b2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:35 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 21:58:59 +02:00

x86/cpu/kvm: Provide UNTRAIN_RET_VM

Similar to how it doesn't make sense to have UNTRAIN_RET have two
untrain calls, it also doesn't make sense for VMEXIT to have an extra
IBPB call.

This cures VMEXIT doing potentially unret+IBPB or double IBPB.
Also, the (SEV) VMEXIT case seems to have been overlooked.

Redefine the meaning of the synthetic IBPB flags to:

 - ENTRY_IBPB     -- issue IBPB on entry  (was: entry + VMEXIT)
 - IBPB_ON_VMEXIT -- issue IBPB on VMEXIT

And have 'retbleed=ibpb' set *BOTH* feature flags to ensure it retains
the previous behaviour and issues IBPB on entry+VMEXIT.

The new 'srso=ibpb_vmexit' option only sets IBPB_ON_VMEXIT.

Create UNTRAIN_RET_VM specifically for the VMEXIT case, and have that
check IBPB_ON_VMEXIT.

All this avoids having the VMEXIT case having to check both ENTRY_IBPB
and IBPB_ON_VMEXIT and simplifies the alternatives.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121149.109557833@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c           |  1 +
 arch/x86/kvm/svm/vmenter.S           |  7 ++-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5285c8e..c55cc24 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -299,6 +299,17 @@
 #endif
 .endm
 
+.macro UNTRAIN_RET_VM
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+	VALIDATE_UNRET_END
+	ALTERNATIVE_3 "",						\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
+		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CALL_DEPTH_TRACKING)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6f3e195..9026e3f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1054,6 +1054,7 @@ do_cmd_auto:
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 		mitigate_smt = true;
 		break;
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 265452f..ef2ebab 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -222,10 +222,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * because interrupt handlers won't sanitize 'ret' if the return is
 	 * from the kernel.
 	 */
-	UNTRAIN_RET
-
-	/* SRSO */
-	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT
+	UNTRAIN_RET_VM
 
 	/*
 	 * Clear all general purpose registers except RSP and RAX to prevent
@@ -362,7 +359,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 * because interrupt handlers won't sanitize RET if the return is
 	 * from the kernel.
 	 */
-	UNTRAIN_RET
+	UNTRAIN_RET_VM
 
 	/* "Pop" @spec_ctrl_intercepted.  */
 	pop %_ASM_BX
