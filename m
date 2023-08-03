Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510D376E31F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjHCI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjHCI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D64C0D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8126B61C4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F554C43391;
        Thu,  3 Aug 2023 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051197;
        bh=ePyKU1YMopmwzc/Oe51J6v27McxWIDUV7ds7IsNZfvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6tC89azknyzgPThJCu65qkNSwtEz1ekEYAX3ftbBQPgorFF3eBj11bLO8pX8H5Jf
         CGXvde0vej1G0RlhG0HGIxWKFthslelFSC7Zi4jowqvePOWcrRpFp7zEI3h+p4YdqN
         ptXZGP2rW/W4uK8dbwrpSU1g9wbWqjDapv0lrlBvjW57vsipb/IsmgSIhWc9Dja52y
         Rgp3zReGzWZRgIWjE+852ndbVuLRHRnTPuleNTwDPSNEV9XGQ71qUiPaG6hL/8hxm7
         ymY0aWaVESezPTTOuY+dWkJucxZFAQqst0VG7bJ1ekjLNRYzEH8ZgiOKeplNs23xYE
         wOVHNhUJK73dg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 6/7] x86: paravirt: shut up unused native_pv_lock_init() function warning
Date:   Thu,  3 Aug 2023 10:26:18 +0200
Message-Id: <20230803082619.1369127-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803082619.1369127-1-arnd@kernel.org>
References: <20230803082619.1369127-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The native_pv_lock_init function is only used in SMP configurations
and declared in asm/qspinlock.h, which is not used in UP kernels,
but the function is still defined for both, which causes a warning:

    arch/x86/kernel/paravirt.c:76:13: error: no previous prototype for 'native_pv_lock_init' [-Werror=missing-prototypes]

Move the declaration to asm/paravirt.h so it is visible even
with CONFIG_SMP but short-circuit the definition to turn it
into an empty function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: new patch to avoid adding another #ifdef to paravirt.c
---
 arch/x86/include/asm/paravirt.h  | 7 +++++++
 arch/x86/include/asm/qspinlock.h | 7 +------
 arch/x86/kernel/paravirt.c       | 3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b49778664d2be..6c8ff12140aea 100644
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
index d87451df480bd..cde8357bb226d 100644
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
index 89842bb7ec9cc..066fc19d2568e 100644
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
 
-- 
2.39.2

