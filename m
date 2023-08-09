Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D35775417
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHIH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHIH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC7172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8xFU9MBBRCXYqcJsEM5lvzkq5hInOlKwoKgeAy28v10=; b=EajMsa8j7ET1nFWY7bCbGtfEDw
        0CBpeSECh8MfbWfhOl9u4tWKKqlAqaQkwaXaSa1d6nFKLOeo6R5eMjB4OXYavYxt7Q3Js7SD1MY9m
        5qZJ6H/JlRh/SScwrpc8/e9cFA2D7PC4gqGn5Tf8QxbATfPY9YCbil4gclo7Z+QtyNP6pDsXvCjVn
        S3Z7Vfehk9s1ovI/9a8+eLbe9NUzLgb6/AdkARaAmq4pqdNGnfImI67g3b1UWQAfQKf69gD0uHEHL
        cMlWyBC5VFpxxyteSUvl0AQco39jlY/g8muU9AmEbiw6vEN40+c38fJiRFR6Lwt2ExUzJv4oC9BZW
        c0N8Zxdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdag-004olT-3p; Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96AF430067B;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FAC82CEC71E0; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.922634286@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the difference being that UNTRAIN_RET_VM uses
X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.

This cures VMEXIT doing potentially unret+IBPB or double IBPB.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
 arch/x86/kernel/cpu/bugs.c           |   17 ++++++++++++++++-
 arch/x86/kvm/svm/vmenter.S           |    7 ++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

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


