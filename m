Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4076EEE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbjHCP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjHCP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C273A85;
        Thu,  3 Aug 2023 08:59:16 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrlPeRGlA78HVKqkwZR0N0VALee/DtTGcxI3yIftmuI=;
        b=3ElgBHqMFZtFY2LJWs73JmxIL+X1Zc9R1VJwFEiseXHFg6iMlfQ8qh62F6C3yIU8Xz+oSa
        r1yrWd2JZDwH6HOl1F/6OUq69tcgJ5DHlYJ1jQRYOVi3nJ6HztsWPWBQ6VwSAXloWqUT9S
        Q4HcrRnj5RmI2T503pzPqmSU1O2ZRa5uUIzBaxofL0R/153AXvzfhojd2I80vnW3Jr0sb3
        T1fYYsVf6xL4j9KNlR2cztC8YB9JJuiOIAufHfyCVyQa752/eGwqQX9BtepWftSILiDiBo
        lBnDM1O8TixqLPrP1nzjV3Ko+fzofsaB4QQBySp4Kfpel72qhxzfSOH+3U1V5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrlPeRGlA78HVKqkwZR0N0VALee/DtTGcxI3yIftmuI=;
        b=Fk+KuPz8OHVUI/acCaaSTMLThlV/LK/Xp+8G0wlwjyrq+ZEBbS1SMuTj03H5EUXLjrbXMm
        1QGr6RFp3Clsc7AQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/paravirt: Silence unused
 native_pv_lock_init() function warning
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803082619.1369127-7-arnd@kernel.org>
References: <20230803082619.1369127-7-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835342.28540.9038195913134250351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ce0a1b608bfc709cf366f020b520310a3b3272c3
Gitweb:        https://git.kernel.org/tip/ce0a1b608bfc709cf366f020b520310a3b3272c3
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 03 Aug 2023 10:26:18 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 03 Aug 2023 16:50:19 +02:00

x86/paravirt: Silence unused native_pv_lock_init() function warning

The native_pv_lock_init() function is only used in SMP configurations
and declared in asm/qspinlock.h which is not used in UP kernels, but
the function is still defined for both, which causes a warning:

  arch/x86/kernel/paravirt.c:76:13: error: no previous prototype for 'native_pv_lock_init' [-Werror=missing-prototypes]

Move the declaration to asm/paravirt.h so it is visible even
with CONFIG_SMP but short-circuit the definition to turn it
into an empty function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230803082619.1369127-7-arnd@kernel.org
---
 arch/x86/include/asm/paravirt.h  | 7 +++++++
 arch/x86/include/asm/qspinlock.h | 7 +------
 arch/x86/kernel/paravirt.c       | 3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b497786..6c8ff12 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -739,6 +739,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 	     ".popsection")
 
 extern void default_banner(void);
+void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLY__ */
 
@@ -778,6 +779,12 @@ extern void default_banner(void);
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
+
+#ifndef __ASSEMBLY__
+static inline void native_pv_lock_init(void)
+{
+}
+#endif
 #endif /* !CONFIG_PARAVIRT */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index d87451d..cde8357 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -74,8 +74,6 @@ static inline bool vcpu_is_preempted(long cpu)
  */
 DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
-void native_pv_lock_init(void) __init;
-
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
  * virt to hijack it.
@@ -103,10 +101,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 
 	return true;
 }
-#else
-static inline void native_pv_lock_init(void)
-{
-}
+
 #endif /* CONFIG_PARAVIRT */
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ac10b46..32e94a3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -75,7 +75,8 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
+	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
