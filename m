Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCA78808C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbjHYHDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbjHYHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B219AC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B32A66652
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA15C433CA;
        Fri, 25 Aug 2023 07:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946934;
        bh=up6EQCkk1anAO1jmS2olnlb+On0n5aX/Ud3MSqE+cZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r28Uw/7AeJw1xr4ws4WPL+QRIDOYUqG0xMc8xtYlT703eGDpFnuoe7dJPAt1jSSal
         c0aHXn00jr7v2yOkLxihYSR63uJ7wQ3/3ufAMIQF+foMzN/dY0qE5tEr+fWoDqpx0l
         yHgWVYDHSFjZEHFIuUk6j3VquE7kGfKImeTPP17Ve73CU+4herEQFr/94bmfmerivE
         W6jkTjqFX6sO8OaUqRx+LUowbQ6ZTC2aYyZkmazymk4A1kz03iJaBFTnssmZ/qnd58
         BLtej3X7hqGqV8eORRIX1PJENjQtBgRBhy/5IH8QQwtEyaquMdaicADRaLWj5quZRu
         PGpIQ76fRj40A==
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
Subject: [PATCH 20/23] x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
Date:   Fri, 25 Aug 2023 00:01:51 -0700
Message-ID: <1ae65b98ddc256ebc446768d9d0c461675dd0437.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros already exist for unaligned code block symbols.  Use them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/retpoline.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 8ba79d2b8997..415521dbe15e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -149,7 +149,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 	.pushsection .text..__x86.rethunk_untrain
-SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_CODE_START_NOALIGN(srso_alias_untrain_ret)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
@@ -159,7 +159,7 @@ SYM_FUNC_END(srso_alias_untrain_ret)
 	.popsection
 
 	.pushsection .text..__x86.rethunk_safe
-SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_CODE_START_NOALIGN(srso_alias_safe_ret)
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
@@ -187,7 +187,7 @@ SYM_CODE_END(srso_alias_return_thunk)
  */
 	.align 64
 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
+SYM_CODE_START_LOCAL_NOALIGN(srso_untrain_ret)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
@@ -255,7 +255,7 @@ SYM_CODE_END(srso_return_thunk)
  */
 	.align 64
 	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
-SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
+SYM_CODE_START_LOCAL_NOALIGN(retbleed_untrain_ret)
 	ANNOTATE_NOENDBR
 	/*
 	 * As executed from retbleed_untrain_ret, this is:
-- 
2.41.0

