Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B652782123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHUBUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHUBTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD81C5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B9C962600
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78351C433BC;
        Mon, 21 Aug 2023 01:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580777;
        bh=/KwWNgSYPkUd1BQwjMGaME6UyYfycSaI0h8YlDU3UQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLFc6PUE0KYjVA7Hw//4qd4fhfK0GfvqceS+T76cxUjcVCTGQd9vF4KPeO1wDPKil
         /PTO3QmqAQWHbXT3NgZ9YYAOfs6eZpGNmKFpT3H2bZDLDXtCGqTcdGkpCNW6USJhEf
         7DM1qWXADpuqKUqxS0WXNX+hrJZYfTOoYId0glwLXOY6aZjN9nV/BUoGkPBtECXH5y
         o7Pf3O5yHOHkMstIDNni9GnojPzcr6jxwHS639nNI0ftqvxkyZEfygU0GUAk0x9FKu
         2j7r9S3oUqLLmys73+3pjex3ERQew9Jwv+B0jOH2NnrqBPwaDS/srw8XXYZchCpKov
         gpLLWDU6QwGng==
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
Subject: [PATCH 18/22] x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
Date:   Sun, 20 Aug 2023 18:19:15 -0700
Message-ID: <319d14f7bb8303bbc51eba782ed94279720eb156.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index e5be0ecf3ce0..af3c1f0e4fb8 100644
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

