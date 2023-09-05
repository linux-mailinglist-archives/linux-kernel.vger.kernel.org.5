Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F52792BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345211AbjIERDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350989AbjIEFFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5ACC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA302B810AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0370C433CC;
        Tue,  5 Sep 2023 05:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890314;
        bh=kzD8Rkhdf6omv3NkeVtM4TRHGvAyOn4bC2fsiLph4tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mu3bALkdO48Xi5v2Bd2JO47Jlt3Duf1+8Np0V0vZNZVTDED6CeuWsIEZ1GgJ5FExG
         r6L48UcFhjlrv9tb5PYYzZmP84I7ZGzSMYulYt4omAiwQ4mjJS6EiDuGvsI5y7pfCz
         ZvHRKsr9vwuS1vyvoWNQv9T0A+HrHhKNcOqRxHB/phtA/ZnD4MVouHxqD4DzWFCl9E
         inyqk3Pw+MLmIojD2XlMl6aZnCVdlDAZTmJHdN4OyMdYXb2X3TNH2AQX39opICCkEL
         rg/vnvaTxF25k1LR0AX6DmDtlYAp5pl2I48NTEc8dtlmX3Hxt4juSkNuF8Kxwi748C
         oMRhCGi5++vZg==
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
Subject: [PATCH v3 12/20] x86/srso: Unexport untraining functions
Date:   Mon,  4 Sep 2023 22:04:56 -0700
Message-ID: <1ae080f95ce7266c82cba6d2adde82349b832654.1693889988.git.jpoimboe@kernel.org>
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
index 9ab634f0b5d2..a40ba18610d8 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -157,7 +157,6 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
-__EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.section .text..__x86.rethunk_safe
 #else
@@ -215,7 +214,7 @@ SYM_CODE_END(srso_alias_return_thunk)
  */
 	.align 64
 	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
-SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
 	 * As executed from retbleed_untrain_ret, this is:
@@ -263,7 +262,6 @@ SYM_CODE_END(retbleed_return_thunk)
 	jmp retbleed_return_thunk
 	int3
 SYM_FUNC_END(retbleed_untrain_ret)
-__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
@@ -277,7 +275,7 @@ __EXPORT_THUNK(retbleed_untrain_ret)
  */
 	.align 64
 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
@@ -298,7 +296,6 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
-__EXPORT_THUNK(srso_untrain_ret)
 
 SYM_CODE_START(srso_return_thunk)
 	UNWIND_HINT_FUNC
-- 
2.41.0

