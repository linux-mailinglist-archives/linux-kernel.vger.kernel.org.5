Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F57A511F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjIRRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjIRRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:40:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B4120;
        Mon, 18 Sep 2023 10:40:05 -0700 (PDT)
Date:   Mon, 18 Sep 2023 17:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695058803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMV+aYIwt4Khm50JTk4ncuxEaUe0Ws1UZVFqlZVBTSY=;
        b=hR8/RRt6J6Ud5RnhKy4vv95FQI2JaiQvzTlAZ4n8n0+ZK6FTmNQSr/PRvqZCJRaCkF9MMs
        gMKkXRsMmytwU2U7sZLYpUbfPyFiTtPyJibd/SyuP9e3CqFvPMVeZoD/epuooawAWkq+K6
        Ai7ZD4vsVIHjvEtKRwKIrRATNbU2PNOZAC8Rc3qv+YQ2BP8ZbDxSoNw5+p8H28reW9BDbO
        mOzOHjs0/gAzBihExIsCqkI5BGY7QrbuWf6ZYU4H9acrreSiyXpzwcnfUq5asGjtqkGfhn
        187qvfBddVJFDWbXAh0nGDYq/OTu4e6nBW7pJcLCmV9HfeQy1TIE21Ev8Q2ewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695058803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMV+aYIwt4Khm50JTk4ncuxEaUe0Ws1UZVFqlZVBTSY=;
        b=NayFbMprSHikNNtEYuEhdBmHIttmsmSksLPM1tk1ccXH8SVk+KTPE6nWOTlNH0Kb0Wz8e9
        AQ9WEmP4uPgG/WBw==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/asm: Fix build of UML with KASAN
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918-uml-kasan-v3-1-7ad6db477df6@axis.com>
References: <20230918-uml-kasan-v3-1-7ad6db477df6@axis.com>
MIME-Version: 1.0
Message-ID: <169505880286.27769.17911777703263341245.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     10f4c9b9a33b7df000f74fa0d896351fb1a61e6a
Gitweb:        https://git.kernel.org/tip/10f4c9b9a33b7df000f74fa0d896351fb1a61e6a
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Mon, 18 Sep 2023 12:52:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 19:30:08 +02:00

x86/asm: Fix build of UML with KASAN

Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
x86: Disallow overriding mem*() functions") with the following errors:

 $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 ...
 ld: mm/kasan/shadow.o: in function `memset':
 shadow.c:(.text+0x40): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memmove':
 shadow.c:(.text+0x90): multiple definition of `memmove';
 arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memcpy':
 shadow.c:(.text+0x110): multiple definition of `memcpy';
 arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

UML does not use GENERIC_ENTRY and is still supposed to be allowed to
override the mem*() functions, so use weak aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230918-uml-kasan-v3-1-7ad6db477df6@axis.com
---
 arch/x86/include/asm/linkage.h | 7 +++++++
 arch/x86/lib/memcpy_64.S       | 2 +-
 arch/x86/lib/memmove_64.S      | 2 +-
 arch/x86/lib/memset_64.S       | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 5ff49fd..571fe4d 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -105,6 +105,13 @@
 	CFI_POST_PADDING					\
 	SYM_FUNC_END(__cfi_##name)
 
+/* UML needs to be able to override memcpy() and friends for KASAN. */
+#ifdef CONFIG_UML
+# define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS_WEAK
+#else
+# define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
+#endif
+
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb2..76697df 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS(memcpy, __memcpy)
+SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b20..ccdf3a5 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,5 +212,5 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-SYM_FUNC_ALIAS(memmove, __memmove)
+SYM_FUNC_ALIAS_MEMFUNC(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a70..3d818b8 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS(memset, __memset)
+SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)
