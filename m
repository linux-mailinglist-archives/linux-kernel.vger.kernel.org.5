Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A17884C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjHYKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbjHYKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEF198A;
        Fri, 25 Aug 2023 03:19:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=684ZZdpEcLPk4+hDlWvoiJeRk734uWOS65vA1Ind1aI=;
        b=V9sywfRjpMfiO+AhZ4zSDaRU8uCpX8LuYFGs+0PSDEEdo7al/pFTAZiBVsnJIkXsOF0tCt
        IUtnOU/uoiGQRwD6WI1a68nvCRVMqkKq92yLQFAmBDKv9sWT6NQ6k/tqkrN53BhGRVzUxc
        a/wDmETEMqHPxxsPsoAqqAnJPHB4/m9gWjyLDEfxoLFj54LPSM7OmlwKgtvrdDAyLUDd+B
        EGcggTWZgu9l/FpLAi0aF8pu6IhT9vHwr6BPnZ7xM+No3ff37TP7q6zaFHvVJSpW4svv8G
        Zd4l7aXLGVESOPOC5n31Xihq80TfzronJGqHGFlRhck8ZDldJGapSrcgpUiZ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=684ZZdpEcLPk4+hDlWvoiJeRk734uWOS65vA1Ind1aI=;
        b=AuBsHafg21VDs64wrOTAgwg+sTIdQbONZUjbk5q+V9cfCi91sycCqaoZDU1k+kBpHJ0JWj
        7/MEaRme4c7lU3AQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove default case for fully switched enums
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org>
References: <858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876979.27769.3081184583053344020.tip-bot2@tip-bot2>
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

Commit-ID:     e1894bd679d20539119ab3b1b61f44e8ac722ba8
Gitweb:        https://git.kernel.org/tip/e1894bd679d20539119ab3b1b61f44e8ac722ba8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:01 +02:00

x86/bugs: Remove default case for fully switched enums

For enum switch statements which handle all possible cases, remove the
default case so a compiler warning gets printed if one of the enums gets
accidentally omitted from the switch statement.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3c7f634..0621615 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1019,7 +1019,6 @@ static void __init retbleed_select_mitigation(void)
 
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
-	default:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
@@ -1290,6 +1289,8 @@ spectre_v2_user_select_mitigation(void)
 
 		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
+		case SPECTRE_V2_USER_CMD_NONE:
+			break;
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
@@ -1301,8 +1302,6 @@ spectre_v2_user_select_mitigation(void)
 		case SPECTRE_V2_USER_CMD_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
-		default:
-			break;
 		}
 
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
@@ -2160,6 +2159,10 @@ static int l1d_flush_prctl_get(struct task_struct *task)
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
+	case SPEC_STORE_BYPASS_NONE:
+		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
@@ -2171,11 +2174,8 @@ static int ssb_prctl_get(struct task_struct *task)
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	default:
-		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-			return PR_SPEC_ENABLE;
-		return PR_SPEC_NOT_AFFECTED;
 	}
+	BUG();
 }
 
 static int ib_prctl_get(struct task_struct *task)
@@ -2504,9 +2504,6 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
                 }
 		break;
-
-	default:
-		break;
 	}
 
 out:
