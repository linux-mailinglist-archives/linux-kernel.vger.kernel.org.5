Return-Path: <linux-kernel+bounces-10893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3F81DE22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725DEB20E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAADE443E;
	Mon, 25 Dec 2023 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jozbum0Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DB29B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FAFC433CC;
	Mon, 25 Dec 2023 04:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703480097;
	bh=6XpfAVFOAhuOEVj65LCeIoXPY0Gh1KiNb/Z3XmVwtL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jozbum0Q/fdcDqQiB55TcCxgyo/ld5j3NiVIyavjUoZCjmDITUYvfSoktcEfqZDYm
	 mkC0SQ4pQdcN/ov8EfaafmTTO/k/2HGyVDc/5pTkpdtHezaUNRwez/H9DX5kgQYTmM
	 F+p4cBLepUCvQK+Xr95SD6HfEaB0S5n6KhAj3EkQoaE12Y2MkTv/Zsx91T/kccZdAb
	 xQat64yxzEgNYd16DF2dUQPW2UHhBuUPyVhlysL49m6z0FPVZ8TcNRwBR9RRMP9d9k
	 wuezVnDoaRokWyF/r27e2kVZy6KIOgqu5H+HF83G0BjnBA8QoLH3a94LfTcetypgy2
	 ehU3rhFvFjLbw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qingfang DENG <dqfext@gmail.com>
Subject: [PATCH v4 2/2] riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW
Date: Mon, 25 Dec 2023 12:42:07 +0800
Message-Id: <20231225044207.3821-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231225044207.3821-1-jszhang@kernel.org>
References: <20231225044207.3821-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DCACHE_WORD_ACCESS uses the word-at-a-time API for optimised string
comparisons in the vfs layer.

This patch implements support for load_unaligned_zeropad in much the
same way as has been done for arm64.

Here is the test program and step:

 $ cat tt.c
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>

 #define ITERATIONS 1000000

 #define PATH "123456781234567812345678123456781"

 int main(void)
 {
         unsigned long i;
         struct stat buf;

         for (i = 0; i < ITERATIONS; i++)
                 stat(PATH, &buf);

         return 0;
 }

 $ gcc -O2 tt.c
 $ touch 123456781234567812345678123456781
 $ time ./a.out

Per my test on T-HEAD C910 platforms, the above test performance is
improved by about 7.5%.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/asm-extable.h    | 15 ++++++++++++
 arch/riscv/include/asm/word-at-a-time.h | 27 +++++++++++++++++++++
 arch/riscv/mm/extable.c                 | 31 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index afcc5fdc16f7..e34863c5a8ed 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -654,6 +654,7 @@ config RISCV_MISALIGNED
 config RISCV_EFFICIENT_UNALIGNED_ACCESS
 	bool "Assume the CPU supports fast unaligned memory accesses"
 	depends on NONPORTABLE
+	select DCACHE_WORD_ACCESS if MMU
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
 	  Say Y here if you want the kernel to assume that the CPU supports
diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 00a96e7a9664..0c8bfd54fc4e 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -6,6 +6,7 @@
 #define EX_TYPE_FIXUP			1
 #define EX_TYPE_BPF			2
 #define EX_TYPE_UACCESS_ERR_ZERO	3
+#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
 
 #ifdef CONFIG_MMU
 
@@ -47,6 +48,11 @@
 #define EX_DATA_REG_ZERO_SHIFT	5
 #define EX_DATA_REG_ZERO	GENMASK(9, 5)
 
+#define EX_DATA_REG_DATA_SHIFT	0
+#define EX_DATA_REG_DATA	GENMASK(4, 0)
+#define EX_DATA_REG_ADDR_SHIFT	5
+#define EX_DATA_REG_ADDR	GENMASK(9, 5)
+
 #define EX_DATA_REG(reg, gpr)						\
 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
 
@@ -62,6 +68,15 @@
 #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)
 
+#define _ASM_EXTABLE_LOAD_UNALIGNED_ZEROPAD(insn, fixup, data, addr)		\
+	__DEFINE_ASM_GPR_NUMS							\
+	__ASM_EXTABLE_RAW(#insn, #fixup,					\
+			  __stringify(EX_TYPE_LOAD_UNALIGNED_ZEROPAD),		\
+			  "("							\
+			    EX_DATA_REG(DATA, data) " | "			\
+			    EX_DATA_REG(ADDR, addr)				\
+			  ")")
+
 #endif /* __ASSEMBLY__ */
 
 #else /* CONFIG_MMU */
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 7c086ac6ecd4..f3f031e34191 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -9,6 +9,7 @@
 #define _ASM_RISCV_WORD_AT_A_TIME_H
 
 
+#include <asm/asm-extable.h>
 #include <linux/kernel.h>
 
 struct word_at_a_time {
@@ -45,4 +46,30 @@ static inline unsigned long find_zero(unsigned long mask)
 /* The mask we created is directly usable as a bytemask */
 #define zero_bytemask(mask) (mask)
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+
+/*
+ * Load an unaligned word from kernel space.
+ *
+ * In the (very unlikely) case of the word being a page-crosser
+ * and the next page not being mapped, take the exception and
+ * return zeroes in the non-existing part.
+ */
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long ret;
+
+	/* Load word from unaligned pointer addr */
+	asm(
+	"1:	" REG_L " %0, %2\n"
+	"2:\n"
+	_ASM_EXTABLE_LOAD_UNALIGNED_ZEROPAD(1b, 2b, %0, %1)
+	: "=&r" (ret)
+	: "r" (addr), "m" (*(unsigned long *)addr));
+
+	return ret;
+}
+
+#endif	/* CONFIG_DCACHE_WORD_ACCESS */
+
 #endif /* _ASM_RISCV_WORD_AT_A_TIME_H */
diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
index 35484d830fd6..dd1530af3ef1 100644
--- a/arch/riscv/mm/extable.c
+++ b/arch/riscv/mm/extable.c
@@ -27,6 +27,14 @@ static bool ex_handler_fixup(const struct exception_table_entry *ex,
 	return true;
 }
 
+static inline unsigned long regs_get_gpr(struct pt_regs *regs, unsigned int offset)
+{
+	if (unlikely(!offset || offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
 static inline void regs_set_gpr(struct pt_regs *regs, unsigned int offset,
 				unsigned long val)
 {
@@ -50,6 +58,27 @@ static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
 	return true;
 }
 
+static bool
+ex_handler_load_unaligned_zeropad(const struct exception_table_entry *ex,
+				  struct pt_regs *regs)
+{
+	int reg_data = FIELD_GET(EX_DATA_REG_DATA, ex->data);
+	int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
+	unsigned long data, addr, offset;
+
+	addr = regs_get_gpr(regs, reg_addr * sizeof(unsigned long));
+
+	offset = addr & 0x7UL;
+	addr &= ~0x7UL;
+
+	data = *(unsigned long *)addr >> (offset * 8);
+
+	regs_set_gpr(regs, reg_data * sizeof(unsigned long), data);
+
+	regs->epc = get_ex_fixup(ex);
+	return true;
+}
+
 bool fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *ex;
@@ -65,6 +94,8 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
+		return ex_handler_load_unaligned_zeropad(ex, regs);
 	}
 
 	BUG();
-- 
2.40.0


