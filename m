Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317F2782119
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjHUBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjHUBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778CCBB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5007D62656
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48445C433CA;
        Mon, 21 Aug 2023 01:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580776;
        bh=Rh6jVE627xOscRDx5dqwSk4xoZ7NqUVdoeif7QYfiIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHOSMxip3/QqUYd1m5/BLbDmsTpT/F9Prp4TIfTL8TfCODSnLJq3YG00YoDaSEh/z
         I/psGJ4yR5FH+/bg32mE/1xGIMBLUNVXza9RzrTZIQ9LltFno8+fXRtRfqr3PppS/q
         8Z2TcdcEaM9zieB0Qd5MLpKWhBFADWOrN3Ne7cCGyWZ8682HcQC8QYo+VIYJ1jzOgK
         vtJlz6zqg9eV3C1TYLC1S/zSayYYE5R2xA6Vyj43OovHJrK67AlG7t4ZF9w/V104TA
         9uifkOzTIi3TJjucoX0scP4eEz1gbS+D7BzrzN9aUtO1wIGcso6Y0TwVo2uaCJP1f4
         7ih/O7ITBMeUw==
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
Subject: [PATCH 16/22] x86/srso: Unexport untraining functions
Date:   Sun, 20 Aug 2023 18:19:13 -0700
Message-ID: <3f72ac3b503c69ab65d86b4372ca54909d730d7a.1692580085.git.jpoimboe@kernel.org>
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

These functions aren't called outside of retpoline.S.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 arch/x86/lib/retpoline.S             | 7 ++-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 197ff4f4d1ce..6c14fd1f5912 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -352,10 +352,6 @@ extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
-extern void retbleed_untrain_ret(void);
-extern void srso_untrain_ret(void);
-extern void srso_alias_untrain_ret(void);
-
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb5fdd3..5e3b016c6d3e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -157,7 +157,6 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
-__EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.section .text..__x86.rethunk_safe
 #else
@@ -216,7 +215,7 @@ SYM_CODE_END(srso_alias_return_thunk)
  */
 	.align 64
 	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
-SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
 	 * As executed from retbleed_untrain_ret, this is:
@@ -264,7 +263,6 @@ SYM_CODE_END(retbleed_return_thunk)
 	jmp retbleed_return_thunk
 	int3
 SYM_FUNC_END(retbleed_untrain_ret)
-__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
@@ -278,7 +276,7 @@ __EXPORT_THUNK(retbleed_untrain_ret)
  */
 	.align 64
 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
@@ -299,7 +297,6 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
-__EXPORT_THUNK(srso_untrain_ret)
 
 SYM_CODE_START(srso_return_thunk)
 	UNWIND_HINT_FUNC
-- 
2.41.0

