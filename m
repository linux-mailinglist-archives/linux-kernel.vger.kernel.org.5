Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC677DB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbjHPHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbjHPHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A5212E;
        Wed, 16 Aug 2023 00:55:21 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmi5lzdW+OG4tH00m3wVFZuGTyD7YdmGYwxawFYDgWs=;
        b=mneS0+Q4S/FVbASlvXNXjs7MLBxX9L1ja2HqwNM17JxiVDNS9Xom7qhMdL4ECrCt2tHI6x
        ThEV9q4an0olMAh4O8F3PXgjv6hhKEsVHbqM2DBB0b/wNPIhzXqZ+9OadV2f+Nd7k5PRD6
        dURiPYOzUOOilCO1GsI1rnBZe59kRx46KazB59Gqgfp1n5F1HAJV4oN8HziUl2nYDqgegA
        kb0LD2a+ozJo1q+EcKeTo9WSfzglOU6+1ud0R3OpAJsvBGABp+l5ptZty4bunqVe1FIK33
        3iwNrkdzLCa5Hfwxxl1Fw1IIHw92WRs6DJRRAiiM4QH0CyfwN+5SGBVyqszgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmi5lzdW+OG4tH00m3wVFZuGTyD7YdmGYwxawFYDgWs=;
        b=MxybxVTX8/40WC9ob52Hl+zUJ7+jZMO8zQGa1NcFNNVucCROQKX+wCSOHQjbu4FDKrZ3R5
        beP0htf47Gw8hiCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.637802730@infradead.org>
References: <20230814121148.637802730@infradead.org>
MIME-Version: 1.0
Message-ID: <169217251809.27769.2416450652330732884.tip-bot2@tip-bot2>
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

Commit-ID:     af023ef335f13c8b579298fc432daeef609a9e60
Gitweb:        https://git.kernel.org/tip/af023ef335f13c8b579298fc432daeef609a9e60
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00

x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()

  vmlinux.o: warning: objtool: srso_untrain_ret() falls through to next function __x86_return_skl()
  vmlinux.o: warning: objtool: __x86_return_thunk() falls through to next function __x86_return_skl()

This is because these functions (can) end with CALL, which objtool
does not consider a terminating instruction. Therefore, replace the
INT3 instruction (which is a non-fatal trap) with UD2 (which is a
fatal-trap).

This indicates execution will not continue past this point.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.637802730@infradead.org
---
 arch/x86/lib/retpoline.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 9427480..a478eb5 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -258,7 +258,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	int3
 	lfence
 	call srso_safe_ret
-	int3
+	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
@@ -268,7 +268,7 @@ SYM_CODE_START(__x86_return_thunk)
 	ANNOTATE_NOENDBR
 	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
 			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
-	int3
+	ud2
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
