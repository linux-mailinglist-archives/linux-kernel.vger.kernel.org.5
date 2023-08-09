Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1963775411
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjHIH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjHIH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B401FD5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BVebX9fTFlPxjp2AiKNthvfM6as4h+2Rhz5k6wxDBi8=; b=PWuQZoadJEv/Pq1l13i/8UsD9c
        Rs6DL+ZYSWQtcp/JJ1qMOkuxqSV5TQJ2c754eTQUSWZTlQ9rduVad5+mILX/MoZvHPyqyIA/w3DRG
        GrjgjAvBr5GtoJLaNCvG7U7X41oXLIyJjzsJuKVWxDDf0UH1z+g+e4BbAvFoFPxUEWwhxOPexUN0d
        yqoxMM6/g5+7yXVRlZEiy06e4zWwyHmi7LdbpiGoqW8AZ3zPv/T3s7/wcmOf1OWhHkwmiYBwtRtc4
        EhAjlDhmFb4NY9oHGHfUH3qCbd5RNZkci37m/Sp8JQMsFkMB/ZqxeKtIqua8DZLyvUSjswtpzlkir
        AGCBu7ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdag-005TeO-0O;
        Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DDA13013D0;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 796D42CEC71E9; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.125308282@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 10/17] x86: Remove CPU_IBPB_ENTRY
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

It was a pointless .config knob, it didn't even cause entry_ibpb to be
omitted from the build.

Our Kconfig space is definitely too big to carry pointless ones.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                     |    7 -------
 arch/x86/include/asm/nospec-branch.h |    9 +++------
 arch/x86/kernel/cpu/bugs.c           |   18 +++++-------------
 3 files changed, 8 insertions(+), 26 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2577,13 +2577,6 @@ config CALL_THUNKS_DEBUG
 	  Only enable this when you are debugging call thunks as this
 	  creates a noticeable runtime overhead. If unsure say N.
 
-config CPU_IBPB_ENTRY
-	bool "Enable IBPB on kernel entry"
-	depends on CPU_SUP_AMD && X86_64
-	default y
-	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
-
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
 	depends on CPU_SUP_INTEL && X86_64
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -288,8 +288,7 @@
  * where we have a stack but before any RET instruction.
  */
 .macro UNTRAIN_RET
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-    defined(CONFIG_CALL_DEPTH_TRACKING)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -299,8 +298,7 @@
 .endm
 
 .macro UNTRAIN_RET_VM
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-    defined(CONFIG_CALL_DEPTH_TRACKING)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -310,8 +308,7 @@
 .endm
 
 .macro UNTRAIN_RET_FROM_CALL
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-    defined(CONFIG_CALL_DEPTH_TRACKING)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -890,16 +890,13 @@ static void __init retbleed_select_mitig
 		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
 			pr_err("WARNING: CPU does not support IBPB.\n");
 			goto do_cmd_auto;
-		} else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+		} else {
 			if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
 				pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");
 			if (retbleed_cmd == RETBLEED_CMD_IBPB)
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 			if (retbleed_cmd == RETBLEED_CMD_IBPB_VMEXIT)
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB_VMEXIT;
-		} else {
-			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
-			goto do_cmd_auto;
 		}
 		break;
 
@@ -932,7 +929,7 @@ static void __init retbleed_select_mitig
 						retbleed_mitigation = RETBLEED_MITIGATION_UNRET_SRSO;
 				}
 			}
-			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
+			else if (boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		}
 
@@ -2397,14 +2394,9 @@ static void __init srso_select_mitigatio
 		break;
 
 	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-				srso_mitigation = SRSO_MITIGATION_IBPB;
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
-			goto pred_cmd;
+		if (has_microcode) {
+			setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+			srso_mitigation = SRSO_MITIGATION_IBPB;
 		}
 		break;
 


