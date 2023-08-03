Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A111C76E323
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjHCIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjHCI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBB4C2F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC1661CD4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66696C433CD;
        Thu,  3 Aug 2023 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051200;
        bh=/5Ij7ujq3SxzByX7XQp0Gjei+Rmrmwgg4FsA45zy5sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRsMA1ccRGGIZ5bW7Jgg/PC+AW1waWhnTB5EBUcccrvjfSFj8d/LkWVPN+YsjcEvA
         R7BoldjnVdKvqSBayxMibqpXCTAelxJsdDF6gm/zBJldSCtvVS6XR4HiI1uStsilWv
         CzrWwsy6k4g3f8TPxL02XOHsHZE+UR1kOM9adh6iYh2sUP4F7MbFzBgCidhTt3dzhI
         xrVr/tVNRlkW9WlWQb5U6KrtbceyM/uugO0EsPE6/jbdWaxXoua9c70SMTWseN1Ij6
         HO1eswgBdb/Cceg+IP18DivnAl3DVAbupN9mIgHaIdp6QtlxRJ/3R6X/7GKrVQ4dgc
         JgM4f3J23Q+3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 7/7] x86: qspinlock-paravirt: fix mising-prototype warning
Date:   Thu,  3 Aug 2023 10:26:19 +0200
Message-Id: <20230803082619.1369127-8-arnd@kernel.org>
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

__pv_queued_spin_unlock_slowpath is defined in a header file as a global
function, and designed to be called from an inline asm, but there is
no prototype visible in the definition:

kernel/locking/qspinlock_paravirt.h:493:1: error: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Werror=missing-prototypes]

Add this to the x86 header that contains the inline asm calling it,
and ensure this gets included before the definition, rather than
after it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: split out native_pv_lock_init() changes into a separate patch,
keeping only __pv_queued_spin_unlock_slowpath here
---
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

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

