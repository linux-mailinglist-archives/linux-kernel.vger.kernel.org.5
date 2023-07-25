Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C46761A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjGYNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjGYNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E81FEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C91D6172B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC465C433C8;
        Tue, 25 Jul 2023 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292934;
        bh=zYu6Qhej4I4I1hLCR7E73XOIiFQaNmUV38IfQaN/KuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAmJGHZFj2zo+lvyiyj2fARLACXKFwJ2boCMrtE7zfaYak3R3wGWKP6DvHA6vHc5O
         0AIHxxPmMvavg9tB4Qhid7TvINrJXSsaSgJp6tcjqW/qVt5W1XEsVIakR10S+DWfRR
         NceH4hpvM8NmwIZciDhvbPlLN4WamF5VC9aIj+55ATUwLQ9L4hdgVB7JaB8awGJcEJ
         Td16jllJNdzKyTCfW7hCfIxoE/g67k2vV1LBjspYSymtn6H+gKtIgBBSquXU0TM24A
         ni6LFYe9rKhmt4GhCNqwpzOCw4uMqHNIN9iWTYkslCFwD7Hf6lr3RTbPxm3PHI+xTz
         t0Qh1KpUNFrUw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/5] [RESEND] x86: qspinlock-paravirt: fix mising-prototype warnings
Date:   Tue, 25 Jul 2023 15:48:35 +0200
Message-Id: <20230725134837.1534228-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725134837.1534228-1-arnd@kernel.org>
References: <20230725134837.1534228-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

__pv_queued_spin_unlock_slowpath is defined in a header file as a global
function, and designed to be called from an inline asm, but there is
no prototype visible in the definition:

kernel/locking/qspinlock_paravirt.h:493:1: error: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Werror=missing-prototypes]

Add this to the x86 header that contains the inline asm calling it,
and ensure this gets included before the definition, rather than
after it.

The native_pv_lock_init function in turn is only declared in SMP
builds but can be left out in UP to avoid another warning:

arch/x86/kernel/paravirt.c:76:13: error: no previous prototype for 'native_pv_lock_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 arch/x86/kernel/paravirt.c                |  2 ++
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 42b17cf10b10e..85b6e3609cb92 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -4,6 +4,8 @@
 
 #include <asm/ibt.h>
 
+void __lockfunc __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked);
+
 /*
  * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
  * registers. For i386, however, only 1 32-bit register needs to be saved
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 89842bb7ec9cc..64a6bba70d183 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -73,11 +73,13 @@ DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
+#ifdef CONFIG_SMP
 void __init native_pv_lock_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
+#endif
 
 unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 			    unsigned int len)
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 6afc249ce697d..6a0184e9c2348 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -485,6 +485,16 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
 }
 
+/*
+ * Include the architecture specific callee-save thunk of the
+ * __pv_queued_spin_unlock(). This thunk is put together with
+ * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
+ * function close to each other sharing consecutive instruction cachelines.
+ * Alternatively, architecture specific version of __pv_queued_spin_unlock()
+ * can be defined.
+ */
+#include <asm/qspinlock_paravirt.h>
+
 /*
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
@@ -533,16 +543,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	pv_kick(node->cpu);
 }
 
-/*
- * Include the architecture specific callee-save thunk of the
- * __pv_queued_spin_unlock(). This thunk is put together with
- * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
- * function close to each other sharing consecutive instruction cachelines.
- * Alternatively, architecture specific version of __pv_queued_spin_unlock()
- * can be defined.
- */
-#include <asm/qspinlock_paravirt.h>
-
 #ifndef __pv_queued_spin_unlock
 __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-- 
2.39.2

