Return-Path: <linux-kernel+bounces-13653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C553820A61
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C75FB21AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E64CA75;
	Sun, 31 Dec 2023 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV/cfNnl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388FC8D5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 08:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8B8C433C7;
	Sun, 31 Dec 2023 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704011418;
	bh=D6VXuRwAKv9dO+mNmqMLcBG3Fo8hoXZOx0qi+4o2+wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV/cfNnlutV5oJo3GVEF+qPX7SM5xqctJKNU2amJ7TJU4IOiq3JWRgdUT3zEA+zi6
	 yA+d+w+GWovK1mBnqsKKPAxRFaGoEXNANQwL9/HeB2MfY2USxVQhZJ8gxA11tPd/ue
	 ATpwZ1PQR5TOJg2o5rIlKdnu3JGH35NPy7eQ+GPyknwR0xYo7c8BwjD5fehnihnKCX
	 T02m2Cg1NosuM5VC+Kz+A4jl4He+Eq8Jc6iqdT4m572jiZKEeAE+S8eMqhezNpsHe8
	 dHtKfAfC7klMoG5W7b00l4uXr43yVa8nE9paBEU8WFl2azCTQsVJosZ64QKwWKcfAX
	 iJLa9KiKs6u5w==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
Date: Sun, 31 Dec 2023 03:29:52 -0500
Message-Id: <20231231082955.16516-3-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231231082955.16516-1-guoren@kernel.org>
References: <20231231082955.16516-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
cache line into L1 cache for the next write operation.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..8d3a2ab37678 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,9 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/insn-def.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
@@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
 
+#ifdef CONFIG_RISCV_ISA_ZICBOP
+#define ARCH_HAS_PREFETCHW
+
+#define PREFETCHW_ASM(x)						\
+	ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,			\
+		    RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
+
+
+static inline void prefetchw(const void *x)
+{
+	__asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
+}
+#endif /* CONFIG_RISCV_ISA_ZICBOP */
 
 /* Do necessary setup to start up a newly executed thread. */
 extern void start_thread(struct pt_regs *regs,
-- 
2.40.1


