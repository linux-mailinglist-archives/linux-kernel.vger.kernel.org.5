Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D648792AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbjIEQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354200AbjIEKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF061B4;
        Tue,  5 Sep 2023 03:09:39 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebE7ouAFN2v/AbRS0OPXGuebP8JRD1BKcjklxO7PBMU=;
        b=4qQfU4HM0z7uHxKOp1al1dBIQEb9D59VI3/nXtoTNukCx7aG2/wMMhdUBC+QVurDaUtzZW
        wl82UmTIrxjwjxEDSXzb0GdVUEVMlT6Nopi0XnQNLGR3+nhni/jIpXeOjiQq7VakkHPmCu
        wpb8ih/Cxd34nw8W5MD/ZUSSvCU21xyTiSO2aF6pW7JcppOL6sRqlheci9m2xpugNI57zB
        WMQ8XOHyOx+uZZNfDutlxenWTK7YYskK5QO5k9w40NmDJ16iR7J5iIpeHsmXNXkxawIyhc
        N2ULN53C8ohBUH11EEwMQRJsIyNO03ABNVr1cm+W2LeTOfh63MMtQmhjnpZBRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebE7ouAFN2v/AbRS0OPXGuebP8JRD1BKcjklxO7PBMU=;
        b=++g/qD4dzQ+BEIQ+3X5MDkjroAoEZpR/0T7/TqtEg9zrUdirHcAgRFCG4lecJFcUDr4tJg
        AXpcDpC40Bhf0/AA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Fix unret validation dependencies
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <299fb7740174d0f2335e91c58af0e9c242b4bac1.1693889988.git.jpoimboe@kernel.org>
References: <299fb7740174d0f2335e91c58af0e9c242b4bac1.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390857741.27769.3886495315985619628.tip-bot2@tip-bot2>
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

Commit-ID:     96d660f35790646f15b69010f767b6b7948fb723
Gitweb:        https://git.kernel.org/tip/96d660f35790646f15b69010f767b6b7948fb723
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:07 +02:00

x86/srso: Fix unret validation dependencies

CONFIG_CPU_SRSO isn't dependent on CONFIG_CPU_UNRET_ENTRY (AMD
Retbleed), so the two features are independently configurable.  Fix
several issues for the (presumably rare) case where CONFIG_CPU_SRSO is
enabled but CONFIG_CPU_UNRET_ENTRY isn't.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/299fb7740174d0f2335e91c58af0e9c242b4bac1.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 include/linux/objtool.h              | 3 ++-
 scripts/Makefile.vmlinux_o           | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c55cc24..197ff4f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,7 +271,7 @@
 .Lskip_rsb_\@:
 .endm
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 #define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
 #define CALL_UNTRAIN_RET	""
@@ -312,7 +312,7 @@
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING)
+	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 03f82c2..b5440e7 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -130,7 +130,8 @@
  * it will be ignored.
  */
 .macro VALIDATE_UNRET_BEGIN
-#if defined(CONFIG_NOINSTR_VALIDATION) && defined(CONFIG_CPU_UNRET_ENTRY)
+#if defined(CONFIG_NOINSTR_VALIDATION) && \
+	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
 .Lhere_\@:
 	.pushsection .discard.validate_unret
 	.long	.Lhere_\@ - .
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb4..25b3b58 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -37,7 +37,8 @@ objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
 vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
-vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)
+vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
+							   $(if $(or $(CONFIG_CPU_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 
