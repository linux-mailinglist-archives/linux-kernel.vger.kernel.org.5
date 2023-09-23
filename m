Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC47AC1D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjIWMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjIWMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6604199;
        Sat, 23 Sep 2023 05:20:08 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7KEZCoe5ju1kNVC6Zn1SX9PPgHP02P29tTEaFfkK14=;
        b=wWbcIuM9YjU4QVUjKq2COXKSoxR6pNNpOTqaMrd1UnIPA/k3RLbuK3Lt6UeRZVL60dviRk
        Jgg8C3G6Afv2N45aEfE0MsuBL427qEY4R8KeJNqkBdIYcMC/7tmUdP+95tQW6JxuTz34cH
        LD9NvT3bvGmItCrg7fzgeYcTtjippuq38IOEFj7NMoy5D+qQhEya4Izc1+FPVc/K9fftMY
        dgNA8BoqxS6kXml3fhqwQ1v+Q3ahLp2L6x9B3zTN3iLevOa0gagw06BvjjFQnnsxoz0JpR
        Nl39hfnJ1w8FA+50mHatp4INUFoyUHOFIhxnL+pO68l1X076YCea+ayDZl7C4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7KEZCoe5ju1kNVC6Zn1SX9PPgHP02P29tTEaFfkK14=;
        b=QFBUwWbKTKfjrh28C86pvZzIHXygW/jW+1CL7kYr0+zo6nOM9bdGRKKedyWmhjcSFRWuOm
        SVT0QEdbU4moxXAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/nospec: Refactor UNTRAIN_RET[_*]
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f06d45489778bd49623297af2a983eea09067a74.1693889988.git.jpoimboe@kernel.org>
References: <f06d45489778bd49623297af2a983eea09067a74.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547160606.27769.3396015442662054917.tip-bot2@tip-bot2>
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

Commit-ID:     e653cf101de2ac99d92049c38735cebc537fa2fb
Gitweb:        https://git.kernel.org/tip/e653cf101de2ac99d92049c38735cebc537fa2fb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:05:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:03 +02:00

x86/nospec: Refactor UNTRAIN_RET[_*]

Factor out the UNTRAIN_RET[_*] common bits into a helper macro.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/f06d45489778bd49623297af2a983eea09067a74.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 31 ++++++++-------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 51e3f1a..dcc7847 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -288,35 +288,24 @@
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
  * where we have a stack but before any RET instruction.
  */
-.macro UNTRAIN_RET
+.macro __UNTRAIN_RET ibpb_feature, call_depth_insns
 #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		     __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+		      "call entry_ibpb", \ibpb_feature,			\
+		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
-.macro UNTRAIN_RET_VM
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
-	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
-		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
-#endif
-.endm
+#define UNTRAIN_RET \
+	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH)
 
-.macro UNTRAIN_RET_FROM_CALL
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
-	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
-#endif
-.endm
+#define UNTRAIN_RET_VM \
+	__UNTRAIN_RET X86_FEATURE_IBPB_ON_VMEXIT, __stringify(RESET_CALL_DEPTH)
+
+#define UNTRAIN_RET_FROM_CALL \
+	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH_FROM_CALL)
 
 
 .macro CALL_DEPTH_ACCOUNT
