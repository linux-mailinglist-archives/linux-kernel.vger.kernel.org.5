Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59AB76EEDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjHCP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHCP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B676211B;
        Thu,  3 Aug 2023 08:59:15 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Z4xD1qwh1zepzOUtE/MTHsMbJqTZfxO85iXeVBf80s=;
        b=2LIfbwQRNpgb0sQXpdgARcCpd14iim/iwCZMmD+JgYVylDqB2ASPcx/mMzDP1jl3YipXSV
        96a1N6nGQTCaJsXvuF1xDsxR5TTd/GAgAkwOgva1zlWFsKDb466RBL5fG0pHvHekLgGxC3
        v9p61SmoOlIzg6ayhp10IVFMiN+XKRX7VSO9coay+qllHiOPpN+QTBrKFhes74hVZbm/ge
        XhL68e88nQyY+pZ2ShGYsmOHBNsKrVSt6y4DN3iQ5jAxyeYyzdKhyeBC7Pezyy99wLAnMo
        wu0kZpPsRFDqoF2J8pqxvcmYeQUYqNWg+AzIy7bhQOJ+ap+dNRN0zpkzuL71Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Z4xD1qwh1zepzOUtE/MTHsMbJqTZfxO85iXeVBf80s=;
        b=X0bBKytVVJPTh3uUNJgKmwRNbEUe9mb94OFl1vxwFDE1o1EUPZDHMMgTeLIzBm+BAJlIaG
        5v9kHiQpt8eHvCAA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/qspinlock-paravirt: Fix missing-prototype warning
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803082619.1369127-8-arnd@kernel.org>
References: <20230803082619.1369127-8-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835290.28540.5117595767740504105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8874a414f8f706daf1de467cbf2550988ebec09d
Gitweb:        https://git.kernel.org/tip/8874a414f8f706daf1de467cbf2550988ebec09d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 03 Aug 2023 10:26:19 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 03 Aug 2023 17:15:05 +02:00

x86/qspinlock-paravirt: Fix missing-prototype warning

__pv_queued_spin_unlock_slowpath() is defined in a header file as
a global function, and designed to be called from inline asm, but
there is no prototype visible in the definition:

  kernel/locking/qspinlock_paravirt.h:493:1: error: no previous \
    prototype for '__pv_queued_spin_unlock_slowpath' [-Werror=missing-prototypes]

Add this to the x86 header that contains the inline asm calling it,
and ensure this gets included before the definition, rather than
after it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230803082619.1369127-8-arnd@kernel.org
---
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 42b17cf..85b6e36 100644
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
index 6afc249..6a0184e 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -486,6 +486,16 @@ gotlock:
 }
 
 /*
+ * Include the architecture specific callee-save thunk of the
+ * __pv_queued_spin_unlock(). This thunk is put together with
+ * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
+ * function close to each other sharing consecutive instruction cachelines.
+ * Alternatively, architecture specific version of __pv_queued_spin_unlock()
+ * can be defined.
+ */
+#include <asm/qspinlock_paravirt.h>
+
+/*
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
  */
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
