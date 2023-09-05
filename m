Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4F792AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbjIEQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351058AbjIEFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE4CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E93C7B810BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4539AC433CC;
        Tue,  5 Sep 2023 05:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890318;
        bh=ABB0VEm/1qgHSMYLRDciSz5DC9qBJP3kxsxjFgJZZ5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqRlBv1vqa96SUYMcbu9CqLO4riJxpeOPL1O1q0+WVkfErtwpPiuAWmJBXlL/CkNh
         GlZFKTmh4i846st4IrBkX/SjpsAYo9tjGClQT/7NXjCB7XwfkV4EDMbYQ/c9p/wWLX
         nBu6J0PxAfr0p+Iv8u7PW4Yh1G5RMFd71YXTTKZHf7nEcswpK+iHFC/LrC1KY737pI
         zMriydFYzZCPZOu1BFB9Y/wRm4+Ee0X6x2zc4q6W2OmBtjftGEQlpcyK4EA/PD5951
         KU8vTCqyRaTj4zYXiuz+gk+2TeRT3HhEBOi4NWz5PJ4kAYWJ8mIm0X4qXINPeeVhIW
         cM2g8oUsvimcQ==
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
Subject: [PATCH v3 19/20] x86/nospec: Refactor UNTRAIN_RET[_*]
Date:   Mon,  4 Sep 2023 22:05:03 -0700
Message-ID: <f06d45489778bd49623297af2a983eea09067a74.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
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

Factor out the UNTRAIN_RET[_*] common bits into a helper macro.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 31 +++++++++-------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 51e3f1a287d2..dcc78477a38d 100644
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
-- 
2.41.0

