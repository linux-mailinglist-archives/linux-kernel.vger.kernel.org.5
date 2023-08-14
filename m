Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A177B880
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHNMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHNMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3018F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RWAKOPXL75r/HZ4tdiHieOe7R8DXm6PJWs2Op5/I0MI=; b=at9vLP/NyIwieP1QiMvha26Uib
        K79BfN17+B5So+qNaPaY5zvn9gonO3E31gWwhm3AxBTmngCg1haw8dHEd+xVXDPva8GzEhZn8+7fh
        DjyP6/CL1P8EbjRHY57hx0kfHFEpBL9rf/Y9qbG/d9RB5LA/MTvKixgRocNlbvs8froSt9BSmxnHN
        1EARSZHPQgheljCEkHAZKoA1rjkSgX0jubJ28uQN3bJyL4cyYV6iVcVLDnVL9CjHSi4hOEA7suWtu
        jD8WAj+oQc9m2PQxRauiWLCoJ1JvRRbBDsOFbx+CyQ9JJ2BPl4t/zCQ9acugRYMW2dbR/GwgDs2Wl
        HxTtbIfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWXY-00AaKa-37;
        Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4EF0300886;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D32B821C1D1B8; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121149.109557833@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 09/11] x86/cpu/kvm: Provide UNTRAIN_RET_VM
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
 arch/x86/kernel/cpu/bugs.c           |    1 +
 arch/x86/kvm/svm/vmenter.S           |    7 ++-----
 3 files changed, 14 insertions(+), 5 deletions(-)

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
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1045,6 +1045,7 @@ static void __init retbleed_select_mitig
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 		mitigate_smt = true;
 		break;
 
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


