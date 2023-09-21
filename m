Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9D7A9954
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIUSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjIUSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD551017;
        Thu, 21 Sep 2023 10:15:29 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:21:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695284464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiigUf4+jV0yAF+Zmw7mPWMC69tUoz6kH5ojPyKhrv8=;
        b=ZOvmRcTt7EpDy0oaAAiRjC62np4g/P8zNuyvJvyUQl9MArMWMvc5NSarBmvczIPfW+vCPy
        EkuBd9UdxHXH5dNT+Bjo+m5xgzI0ItmfB84sEUgEd7kKNFYoBLhHab5p+0IARIvpjq/Saj
        g0CzySsuzCckutq5ohPzh6PHnGcIfy+OUN8gcYzbq4/OaGoLTGZfw6H7Jks137xkqkiPzk
        SuATBJg+K9056WfKPwNp5aoOGYmwTjZroHodw0ep9M7ovcyxRmYeJdgZxYHpy1yQWBUMMH
        fTjunoY3vdxV7ax1+VvtAVgoQV8E1rbjzH5oCZGdmtQHhcjerXoneXjSfKRFrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695284464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiigUf4+jV0yAF+Zmw7mPWMC69tUoz6kH5ojPyKhrv8=;
        b=/FNGDqgDPriMlRRWDBCrnBTBYd2N7ljHrxjJU2PpmxI+7MqR9DVBzDssCgj3EHZEu++onC
        aL6baZyXJK4DPMDA==
From:   "tip-bot2 for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked()
Cc:     Guo Ren <guoren@kernel.org>, Guo Ren <guoren@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230908154339.3250567-1-guoren@kernel.org>
References: <20230908154339.3250567-1-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <169528446324.27769.8480622781969702147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c6f4a90022524d06f6d9de323b1757031dcf0c26
Gitweb:        https://git.kernel.org/tip/c6f4a90022524d06f6d9de323b1757031dcf0c26
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Fri, 08 Sep 2023 11:43:39 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 10:17:00 +02:00

asm-generic: ticket-lock: Optimize arch_spin_value_unlocked()

The arch_spin_value_unlocked() of ticket-lock would cause the compiler to
generate inefficient asm code in riscv architecture because of
unnecessary memory access to the contended value.

Before the patch:

	void lockref_get(struct lockref *lockref)
	{
	  78:   fd010113                add     sp,sp,-48
	  7c:   02813023                sd      s0,32(sp)
	  80:   02113423                sd      ra,40(sp)
	  84:   03010413                add     s0,sp,48

	0000000000000088 <.LBB296>:
		CMPXCHG_LOOP(
	  88:   00053783                ld      a5,0(a0)

After the patch:

	void lockref_get(struct lockref *lockref)
	{
		CMPXCHG_LOOP(
	  78:   00053783                ld      a5,0(a0)

After the patch, the lockref_get() could get in a fast path instead of the
function's prologue. This is because ticket lock complex logic would
limit compiler optimization for the spinlock fast path, and qspinlock
won't.

The caller of arch_spin_value_unlocked() could benefit from this
change. Currently, the only caller is lockref.

Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20230908154339.3250567-1-guoren@kernel.org
---
 include/asm-generic/spinlock.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb..90803a8 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 	smp_store_release(ptr, (u16)val + 1);
 }
 
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
 static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(lock);
+	arch_spinlock_t val = READ_ONCE(*lock);
 
-	return ((val >> 16) != (val & 0xffff));
+	return !arch_spin_value_unlocked(val);
 }
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
@@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
 
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return !arch_spin_is_locked(&lock);
-}
-
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
