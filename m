Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426A7E1C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjKFIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjKFIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:47:52 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14E74EA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:47:47 -0800 (PST)
Received: from loongson.cn (unknown [112.22.233.25])
        by gateway (Coremail) with SMTP id _____8DxBfEyqEhlmEQ3AA--.43271S3;
        Mon, 06 Nov 2023 16:47:46 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.233.25])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+QtqEhl0y86AA--.62988S2;
        Mon, 06 Nov 2023 16:47:44 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Relax memory ordering for atomic operations
Date:   Mon,  6 Nov 2023 16:47:34 +0800
Message-ID: <20231106084734.203243-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxE+QtqEhl0y86AA--.62988S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xry8XrW3Cr1xZF4UWr1fZrc_yoWDJFWfp3
        y09F98tF45Xay5G3yvyan8W345Jr1YvryqqryYyr9ruFy2kwnxJ3W8XF1vvr1Utw48Ka1r
        Gr4jkayUWFn2vwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU2G-eUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch relaxes the implementation while satisfying the memory ordering
requirements for atomic operations, which will help improve performance on
LA664+.

Unixbench with full threads (8)
                                           before       after
  Dhrystone 2 using register variables   203910714.2  203909539.8   0.00%
  Double-Precision Whetstone                 37930.9        37931   0.00%
  Execl Throughput                           29431.5      29545.8   0.39%
  File Copy 1024 bufsize 2000 maxblocks    6645759.5      6676320   0.46%
  File Copy 256 bufsize 500 maxblocks      2138772.4    2144182.4   0.25%
  File Copy 4096 bufsize 8000 maxblocks   11640698.4     11602703  -0.33%
  Pipe Throughput                          8849077.7    8917009.4   0.77%
  Pipe-based Context Switching             1255108.5    1287277.3   2.56%
  Process Creation                           50825.9      50442.1  -0.76%
  Shell Scripts (1 concurrent)               25795.8      25942.3   0.57%
  Shell Scripts (8 concurrent)                3812.6       3835.2   0.59%
  System Call Overhead                     9248212.6    9353348.6   1.14%
                                                                  =======
  System Benchmarks Index Score               8076.6       8114.4   0.47%

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 arch/loongarch/include/asm/atomic.h | 88 ++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index e27f0c72d324..99af8b3160a8 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -36,19 +36,19 @@
 static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	__asm__ __volatile__(						\
-	"am"#asm_op"_db.w" " $zero, %1, %0	\n"			\
+	"am"#asm_op".w" " $zero, %1, %0	\n"				\
 	: "+ZB" (v->counter)						\
 	: "r" (I)							\
 	: "memory");							\
 }
 
-#define ATOMIC_OP_RETURN(op, I, asm_op, c_op)				\
-static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+#define ATOMIC_OP_RETURN(op, I, asm_op, c_op, mb, suffix)		\
+static inline int arch_atomic_##op##_return##suffix(int i, atomic_t *v)	\
 {									\
 	int result;							\
 									\
 	__asm__ __volatile__(						\
-	"am"#asm_op"_db.w" " %1, %2, %0		\n"			\
+	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
 	: "+ZB" (v->counter), "=&r" (result)				\
 	: "r" (I)							\
 	: "memory");							\
@@ -56,13 +56,13 @@ static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 	return result c_op I;						\
 }
 
-#define ATOMIC_FETCH_OP(op, I, asm_op)					\
-static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+#define ATOMIC_FETCH_OP(op, I, asm_op, mb, suffix)			\
+static inline int arch_atomic_fetch_##op##suffix(int i, atomic_t *v)	\
 {									\
 	int result;							\
 									\
 	__asm__ __volatile__(						\
-	"am"#asm_op"_db.w" " %1, %2, %0		\n"			\
+	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
 	: "+ZB" (v->counter), "=&r" (result)				\
 	: "r" (I)							\
 	: "memory");							\
@@ -72,29 +72,53 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 
 #define ATOMIC_OPS(op, I, asm_op, c_op)					\
 	ATOMIC_OP(op, I, asm_op)					\
-	ATOMIC_OP_RETURN(op, I, asm_op, c_op)				\
-	ATOMIC_FETCH_OP(op, I, asm_op)
+	ATOMIC_OP_RETURN(op, I, asm_op, c_op, _db,         )		\
+	ATOMIC_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		\
+	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
+	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
 
 ATOMIC_OPS(add, i, add, +)
 ATOMIC_OPS(sub, -i, add, +)
 
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_add_return_acquire	arch_atomic_add_return
+#define arch_atomic_add_return_release	arch_atomic_add_return
 #define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return		arch_atomic_sub_return
+#define arch_atomic_sub_return_acquire	arch_atomic_sub_return
+#define arch_atomic_sub_return_release	arch_atomic_sub_return
 #define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release	arch_atomic_fetch_add
 #define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub
 #define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
 
 #undef ATOMIC_OPS
 
 #define ATOMIC_OPS(op, I, asm_op)					\
 	ATOMIC_OP(op, I, asm_op)					\
-	ATOMIC_FETCH_OP(op, I, asm_op)
+	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
+	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
 
 ATOMIC_OPS(and, i, and)
 ATOMIC_OPS(or, i, or)
 ATOMIC_OPS(xor, i, xor)
 
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
+#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release	arch_atomic_fetch_and
 #define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release	arch_atomic_fetch_or
 #define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor
 #define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
 
 #undef ATOMIC_OPS
@@ -172,18 +196,18 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
 {									\
 	__asm__ __volatile__(						\
-	"am"#asm_op"_db.d " " $zero, %1, %0	\n"			\
+	"am"#asm_op".d " " $zero, %1, %0	\n"			\
 	: "+ZB" (v->counter)						\
 	: "r" (I)							\
 	: "memory");							\
 }
 
-#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op)					\
-static inline long arch_atomic64_##op##_return_relaxed(long i, atomic64_t *v)	\
+#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op, mb, suffix)			\
+static inline long arch_atomic64_##op##_return##suffix(long i, atomic64_t *v)	\
 {										\
 	long result;								\
 	__asm__ __volatile__(							\
-	"am"#asm_op"_db.d " " %1, %2, %0		\n"			\
+	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
 	: "+ZB" (v->counter), "=&r" (result)					\
 	: "r" (I)								\
 	: "memory");								\
@@ -191,13 +215,13 @@ static inline long arch_atomic64_##op##_return_relaxed(long i, atomic64_t *v)	\
 	return result c_op I;							\
 }
 
-#define ATOMIC64_FETCH_OP(op, I, asm_op)					\
-static inline long arch_atomic64_fetch_##op##_relaxed(long i, atomic64_t *v)	\
+#define ATOMIC64_FETCH_OP(op, I, asm_op, mb, suffix)				\
+static inline long arch_atomic64_fetch_##op##suffix(long i, atomic64_t *v)	\
 {										\
 	long result;								\
 										\
 	__asm__ __volatile__(							\
-	"am"#asm_op"_db.d " " %1, %2, %0		\n"			\
+	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
 	: "+ZB" (v->counter), "=&r" (result)					\
 	: "r" (I)								\
 	: "memory");								\
@@ -207,29 +231,53 @@ static inline long arch_atomic64_fetch_##op##_relaxed(long i, atomic64_t *v)	\
 
 #define ATOMIC64_OPS(op, I, asm_op, c_op)				      \
 	ATOMIC64_OP(op, I, asm_op)					      \
-	ATOMIC64_OP_RETURN(op, I, asm_op, c_op)				      \
-	ATOMIC64_FETCH_OP(op, I, asm_op)
+	ATOMIC64_OP_RETURN(op, I, asm_op, c_op, _db,         )		      \
+	ATOMIC64_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		      \
+	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
+	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
 
 ATOMIC64_OPS(add, i, add, +)
 ATOMIC64_OPS(sub, -i, add, +)
 
+#define arch_atomic64_add_return		arch_atomic64_add_return
+#define arch_atomic64_add_return_acquire	arch_atomic64_add_return
+#define arch_atomic64_add_return_release	arch_atomic64_add_return
 #define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release	arch_atomic64_sub_return
 #define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_acquire		arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release		arch_atomic64_fetch_add
 #define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_acquire		arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release		arch_atomic64_fetch_sub
 #define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
 
 #undef ATOMIC64_OPS
 
 #define ATOMIC64_OPS(op, I, asm_op)					      \
 	ATOMIC64_OP(op, I, asm_op)					      \
-	ATOMIC64_FETCH_OP(op, I, asm_op)
+	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
+	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
 
 ATOMIC64_OPS(and, i, and)
 ATOMIC64_OPS(or, i, or)
 ATOMIC64_OPS(xor, i, xor)
 
+#define arch_atomic64_fetch_and		arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_acquire	arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release	arch_atomic64_fetch_and
 #define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_or		arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_acquire	arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release	arch_atomic64_fetch_or
 #define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_acquire	arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release	arch_atomic64_fetch_xor
 #define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
 
 #undef ATOMIC64_OPS
-- 
2.42.1

