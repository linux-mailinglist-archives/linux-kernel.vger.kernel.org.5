Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428657A1D67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjIOLZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjIOLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:25:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E71B1;
        Fri, 15 Sep 2023 04:25:04 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:25:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694777102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/ouAHMy0z5FMxazVqTNkA5KNv/eBXdXO68JiIIQxpg=;
        b=W+gunOOwKsaIQU99f1bUR8e7wi9zChtZ5RY1JsA84oQRM6bwwZ/dqvvQ38MHMkKDKxMKcK
        d7i5fGlgZStkk5e5pNj+ZsrWJzDj4HYr99Hht40B7hJUQVAdm5g0QEpdHYA8UIjMrqb4n8
        b2m/r1KSgx96HRpmZnSy3DBCtkQVU2ccTjsD7X+clZSoi16q/P1dm+TWYDrug1kE0nxHT4
        LOlj5UQVZ24GKgcWVEmGPeq3ezRcLO4xhQmugKT03aMLY0pFpZl3L7aEzw0akpu/kVdAND
        Ese4+IdK3RmR1mEgsxTQwJX5CSdi6bUoIfnoHL/iP13EvNVmCD8jP7d2vlHe9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694777102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/ouAHMy0z5FMxazVqTNkA5KNv/eBXdXO68JiIIQxpg=;
        b=uqm+XEA91+TIWX8qsKH5kjjcpb8JafPnHYDbW2RTI6B4Ml8u6ssgnoCFMvWgUY39+rv0du
        Ow4pgxuEZffQ/AAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Define raw_cpu_try_cmpxchg and
 this_cpu_try_cmpxchg()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230830151623.3900-1-ubizjak@gmail.com>
References: <20230830151623.3900-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169477710197.27769.9358331675930285966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     5f863897d964e834a0da35b1e483b5bb8faca522
Gitweb:        https://git.kernel.org/tip/5f863897d964e834a0da35b1e483b5bb8faca522
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 30 Aug 2023 17:13:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:18:23 +02:00

x86/percpu: Define raw_cpu_try_cmpxchg and this_cpu_try_cmpxchg()

Define target-specific raw_cpu_try_cmpxchg_N() and
this_cpu_try_cmpxchg_N() macros. These definitions override
the generic fallback definitions and enable target-specific
optimized implementations.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230830151623.3900-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 4c36419..a87db61 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,25 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#define percpu_try_cmpxchg_op(size, qual, _var, _ovalp, _nval)		\
+({									\
+	bool success;							\
+	__pcpu_type_##size *pco_oval__ = (__pcpu_type_##size *)(_ovalp); \
+	__pcpu_type_##size pco_old__ = *pco_oval__;			\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [oval] "+a" (pco_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pco_new__)		\
+		  : "memory");						\
+	if (unlikely(!success))						\
+		*pco_oval__ = pco_old__;				\
+	likely(success);						\
+})
+
 #if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
@@ -410,6 +429,9 @@ do {									\
 #define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, , pcp, ovalp, nval)
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
@@ -417,6 +439,9 @@ do {									\
 #define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, volatile, pcp, ovalp, nval)
 
 /*
  * Per cpu atomic 64 bit operations are only available under 64 bit.
@@ -431,6 +456,7 @@ do {									\
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
@@ -440,6 +466,7 @@ do {									\
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
