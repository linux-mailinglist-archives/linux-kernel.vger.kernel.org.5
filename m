Return-Path: <linux-kernel+bounces-115582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6721889CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523172933AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFF1F3B18;
	Mon, 25 Mar 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osaAX36B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2014BF94;
	Sun, 24 Mar 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321138; cv=none; b=Rjee3QGlIfIIRyF+Lu2zYNzGJOF52PbH1qH4sH69Mqz1ju3tXVkKEnyxN73mhHs6t5PChFo56zjbrMTc/YJ/9OrPTssbg0G+JZHDml0ZjmWcofpQ3KI/SW7urW2xffl8u6ey+KEE/v8lhnNcV1nDBNilKS7Q5eNqJhjpp7ekbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321138; c=relaxed/simple;
	bh=2XYdaDwIQxAFtp7bJ97Ze2DQ/dAGBHGTKD1mDsVG0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rESeKXwWJz2/p7a4rEAdCBsKMbqVmB7yMEAjR8L5chIjEV/g4SrjYnB7wQnl4PTRP3PtH1iEW8wjXqkVR+TLxF2qwjxaIOq3RNuL1Tmz0pg3WU/19PzK2awFDN1sHkFXJUS+Lbq8WYg8UfEPEzjzcX9XAJiwm4XZ6NvxkkY50As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osaAX36B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AABDC43390;
	Sun, 24 Mar 2024 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321136;
	bh=2XYdaDwIQxAFtp7bJ97Ze2DQ/dAGBHGTKD1mDsVG0ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osaAX36BfZMoEfo9RlXV2LlZ1rcGdx7iM9Rwc2NVJU90Y++RbzwgDlj7LoXNSYLP3
	 BARpc4+V143yf/4/ZRxS7jeRgv9Ww/iAkxKJnObmnEF5qLzwLBgyiKGbM2PQgjeEWL
	 TZ79wZXZ01nq4UBjcuwUihebi5E2/qBG8FNcDx/Kp1a399q9YA3A+38zqLp7C7p5rP
	 iCwhBEULi8SAW8DkNnLRxE9KOoIVDPkVAwIpN0blyj85ybzSWcjuB4XDoibidQjofa
	 TRQt7XeUKdTYkb2bB2fOT6o1VJCnhhTiCrHQxq+LPvzku5+cOELpjcX2LwXN9A0Ge6
	 W71WRYsUxtQmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Khem Raj <raj.khem@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 698/713] riscv: Fix syscall wrapper for >word-size arguments
Date: Sun, 24 Mar 2024 18:47:04 -0400
Message-ID: <20240324224720.1345309-699-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit a9ad73295cc1e3af0253eee7d08943b2419444c4 ]

The current syscall wrapper macros break 64-bit arguments on
rv32 because they only guarantee the first N input registers are
passed to syscalls that accept N arguments. According to the
calling convention, values twice the word size reside in register
pairs and as a result, syscall arguments don't always have a
direct register mapping on rv32.

Instead of using `__MAP(x,__SC_LONG,__VA_ARGS__)` to declare the
type of the `__se(_compat)_sys_*` functions on rv32, change the
function declarations to accept `ulong` arguments and alias them
to the actual syscall implementations, similarly to the existing
macros in include/linux/syscalls.h. This matches previous
behavior and ensures registers are passed to syscalls as-is, no
matter which argument types they expect.

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Reported-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20240311193143.2981310-2-samitolvanen@google.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/syscall_wrapper.h | 53 +++++++++++++++++-------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index eeec04b7dae67..980094c2e9761 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -12,25 +12,51 @@
 
 asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 
-#define SC_RISCV_REGS_TO_ARGS(x, ...)				\
-	__MAP(x,__SC_ARGS					\
-	      ,,regs->orig_a0,,regs->a1,,regs->a2		\
+#ifdef CONFIG_64BIT
+
+#define __SYSCALL_SE_DEFINEx(x, prefix, name, ...)					\
+	static long __se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static long __se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
+
+#define SC_RISCV_REGS_TO_ARGS(x, ...)							\
+	__MAP(x,__SC_ARGS								\
+	      ,,regs->orig_a0,,regs->a1,,regs->a2					\
 	      ,,regs->a3,,regs->a4,,regs->a5,,regs->a6)
 
+#else
+/*
+ * Use type aliasing to ensure registers a0-a6 are correctly passed to the syscall
+ * implementation when >word-size arguments are used.
+ */
+#define __SYSCALL_SE_DEFINEx(x, prefix, name, ...)					\
+	__diag_push();									\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",					\
+			"Type aliasing is used to sanitize syscall arguments");		\
+	static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong, 	\
+					ulong)						\
+			__attribute__((alias(__stringify(___se_##prefix##name))));	\
+	__diag_pop();									\
+	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
+
+#define SC_RISCV_REGS_TO_ARGS(x, ...) \
+	regs->orig_a0,regs->a1,regs->a2,regs->a3,regs->a4,regs->a5,regs->a6
+
+#endif /* CONFIG_64BIT */
+
 #ifdef CONFIG_COMPAT
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
 	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__riscv_compat_sys##name, ERRNO);				\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
-	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs)		\
+	__SYSCALL_SE_DEFINEx(x, compat_sys, name, __VA_ARGS__)				\
 	{										\
-		return __se_compat_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
 	}										\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs)		\
 	{										\
-		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
+		return __se_compat_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
 	}										\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
@@ -51,19 +77,18 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 #define __SYSCALL_DEFINEx(x, name, ...)						\
 	asmlinkage long __riscv_sys##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__riscv_sys##name, ERRNO);			\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
-	asmlinkage long __riscv_sys##name(const struct pt_regs *regs)		\
-	{									\
-		return __se_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
-	}									\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	__SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)				\
 	{									\
 		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
 		__MAP(x,__SC_TEST,__VA_ARGS__);					\
 		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
 		return ret;							\
 	}									\
+	asmlinkage long __riscv_sys##name(const struct pt_regs *regs)		\
+	{									\
+		return __se_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}									\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
 #define SYSCALL_DEFINE0(sname)							\
-- 
2.43.0


