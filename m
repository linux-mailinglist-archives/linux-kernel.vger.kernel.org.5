Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5817B8403
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbjJDPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJDPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:46:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8DB9E;
        Wed,  4 Oct 2023 08:46:37 -0700 (PDT)
Date:   Wed, 04 Oct 2023 15:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696434396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHk6/fMFBCJekUniiqNZc91KS/ATUE8I9h6xGyYTE3g=;
        b=rQDJQC0N8/4hCLN36pERrLQoLZM70YoNq77I2EO2Y20EJvZbX6+oPi8WAC5yIvSHnQOZFD
        zvG5TtG9WEybfBYXlGbN/XYeGTMBrXl9mr1KTeKg/idGmu3qbrJMkO6PzdBbOMj54/OPt8
        Dwk2QJSpckpydHliW+/34azw/ZNfQqtfV1seMxMdhdcyPD+psDIL/tU8gyP5uRrQdObm/o
        LFND3B+WNKnH9W5bWCp+urTiuIZL5dAaBFpwbelAYJskx6kNkgj+OUT6aA868wbPNbrP+7
        Oht5ws01onso/hu1rJ7MI9wOOo2YtXmuyXXDdgcTElLMgbBChUVa95xke5iKsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696434396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHk6/fMFBCJekUniiqNZc91KS/ATUE8I9h6xGyYTE3g=;
        b=riQqRqvRU6KvXMhjP8DZZar/0mHvRCrb0HOPoMWXYkPYN8ei5YRVYucNJgFl24OlclDv3d
        /h4nUCUFKklK56Cw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local, arch: Rewrite local_add_unless()
 as a static inline function
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230731084458.28096-1-ubizjak@gmail.com>
References: <20230731084458.28096-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169643439535.3135.5571885434602858806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5e0eb67974e88dbaded765278a3ffe7af33e3b22
Gitweb:        https://git.kernel.org/tip/5e0eb67974e88dbaded765278a3ffe7af33e3b22
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 31 Jul 2023 10:42:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 11:38:11 +02:00

locking/local, arch: Rewrite local_add_unless() as a static inline function

Rewrite local_add_unless() as a static inline function with boolean
return value, similar to the arch_atomic_add_unless() arch fallbacks.

The function is currently unused.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230731084458.28096-1-ubizjak@gmail.com
---
 arch/alpha/include/asm/local.h     | 33 ++++++++++++++---------------
 arch/loongarch/include/asm/local.h | 27 ++++++++++++++----------
 arch/mips/include/asm/local.h      | 27 ++++++++++++++----------
 arch/powerpc/include/asm/local.h   | 12 +++++------
 arch/x86/include/asm/local.h       | 33 ++++++++++++++---------------
 5 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index 0fcaad6..88eb398 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -65,28 +65,27 @@ static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	for (;;) {						\
-		if (unlikely(c == (u)))				\
-			break;					\
-		old = local_cmpxchg((l), c, c + (a));	\
-		if (likely(old == c))				\
-			break;					\
-		c = old;					\
-	}							\
-	c != (u);						\
-})
+static __inline__ bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index c496758..f53ea65 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -70,22 +70,27 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
+static inline bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_dec_return(l) local_sub_return(1, (l))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index e6ae3df..86fc240 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -108,22 +108,27 @@ static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
+static __inline__ bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_dec_return(l) local_sub_return(1, (l))
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 45492fb..ec6ced6 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -115,23 +115,23 @@ static __inline__ long local_xchg(local_t *l, long n)
 }
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-static __inline__ int local_add_unless(local_t *l, long a, long u)
+static __inline__ bool local_add_unless(local_t *l, long a, long u)
 {
 	unsigned long flags;
-	int ret = 0;
+	bool ret = false;
 
 	powerpc_local_irq_pmu_save(flags);
 	if (l->v != u) {
 		l->v += a;
-		ret = 1;
+		ret = true;
 	}
 	powerpc_local_irq_pmu_restore(flags);
 
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 635132a..73dba8b 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -135,28 +135,27 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read((l));					\
-	for (;;) {						\
-		if (unlikely(c == (u)))				\
-			break;					\
-		old = local_cmpxchg((l), c, c + (a));		\
-		if (likely(old == c))				\
-			break;					\
-		c = old;					\
-	}							\
-	c != (u);						\
-})
+static __always_inline bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 /* On x86_32, these are no better than the atomic variants.
