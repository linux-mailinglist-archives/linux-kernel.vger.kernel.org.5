Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1037D8092
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjJZKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjJZKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:20:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E233D6F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4116C433C8;
        Thu, 26 Oct 2023 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698315611;
        bh=HTgDnY6nOK0UE+C53lOyr46cNkU6RAJxBArDMZcQUKU=;
        h=From:To:Cc:Subject:Date:From;
        b=qEKGSub5Z8oLBiMI2J2SXGHlKosMfJIrdE7oOGvTW868BjkOGFtbdWjJL86QAidw5
         mhTFMJTTrBo8LxwDa5KjbPWRd78e3xrmv9+DMSIC82qXgtq8qjeA84mkoOlbKyCoMW
         Fx+WWkmhglTC3EsALOLaBZy5vAEviAgKF6yIXf7Xjr3NuMJdRgKWKghkpqJNbS3FBd
         XRSxLTYa+qznnJyM0fSt+bUalLwCloCTdAhF7dJxtDDOguVTcqwMrJUlVZFOoKT3Hp
         273IYM2XKujF1fLy/lNsTa0THgh7H6OpcF18Y25wgQE6jSUTU8saXaWUaacaJn3CYL
         FYxJcHFl7bLPw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
Date:   Thu, 26 Oct 2023 12:19:57 +0200
Message-Id: <20231026101957.320572-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some (future) users of the irq matrix allocator, do not know the size
of the matrix bitmaps at compile time.

To avoid wasting memory on unnecessary large bitmaps, size the bitmap
at matrix allocation time.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
Here's a cleaned up, boot tested, proper patch.

Thomas, this is just FYI/RFC. This change would only make sense, if
the RISC-V AIA series starts using the IRQ matrix allocator.


Björn
---
 arch/x86/include/asm/hw_irq.h |  2 --
 kernel/irq/matrix.c           | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 551829884734..dcfaa3812306 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,8 +16,6 @@
 
 #include <asm/irq_vectors.h>
 
-#define IRQ_MATRIX_BITS		NR_VECTORS
-
 #ifndef __ASSEMBLY__
 
 #include <linux/percpu.h>
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..996cbb46d654 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,8 +8,6 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
-
 struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
@@ -17,8 +15,8 @@ struct cpumap {
 	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
-	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
-	unsigned long		managed_map[IRQ_MATRIX_SIZE];
+	unsigned long		*managed_map;
+	unsigned long		alloc_map[];
 };
 
 struct irq_matrix {
@@ -32,8 +30,8 @@ struct irq_matrix {
 	unsigned int		total_allocated;
 	unsigned int		online_maps;
 	struct cpumap __percpu	*maps;
-	unsigned long		scratch_map[IRQ_MATRIX_SIZE];
-	unsigned long		system_map[IRQ_MATRIX_SIZE];
+	unsigned long		*system_map;
+	unsigned long		scratch_map[];
 };
 
 #define CREATE_TRACE_POINTS
@@ -50,24 +48,32 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned int matrix_bits,
 					   unsigned int alloc_start,
 					   unsigned int alloc_end)
 {
+	unsigned int cpu, matrix_size = BITS_TO_LONGS(matrix_bits);
 	struct irq_matrix *m;
 
-	if (matrix_bits > IRQ_MATRIX_BITS)
-		return NULL;
-
-	m = kzalloc(sizeof(*m), GFP_KERNEL);
+	m = kzalloc(struct_size(m, scratch_map, matrix_size * 2), GFP_KERNEL);
 	if (!m)
 		return NULL;
 
+	m->system_map = &m->scratch_map[matrix_size];
+
 	m->matrix_bits = matrix_bits;
 	m->alloc_start = alloc_start;
 	m->alloc_end = alloc_end;
 	m->alloc_size = alloc_end - alloc_start;
-	m->maps = alloc_percpu(*m->maps);
+	m->maps = __alloc_percpu(struct_size(m->maps, alloc_map, matrix_size * 2),
+				 __alignof__(*m->maps));
 	if (!m->maps) {
 		kfree(m);
 		return NULL;
 	}
+
+	for_each_possible_cpu(cpu) {
+		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
+
+		cm->managed_map = &cm->alloc_map[matrix_size];
+	}
+
 	return m;
 }
 

base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
-- 
2.40.1

