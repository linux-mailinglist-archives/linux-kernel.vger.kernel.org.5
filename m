Return-Path: <linux-kernel+bounces-113591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172B88858C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395611C24ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B531CC5E0;
	Sun, 24 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGqC/tUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671021CBE08;
	Sun, 24 Mar 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320394; cv=none; b=LhGgja9yPZsbVCi6Ohf77CeQmU0uivoN5ocVOHR6TH5qRTbHoN05LECWTJiwhCEurA0UmJCE/arnD3PAekcu9u0QYy0TL0xT3XlrYg0KpCXZwOFv8YCx81YJmAQ69eR/Y1vR4NCpMdh4Y+hTlI8Yl4MofFF0tUGFwlL+oONGEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320394; c=relaxed/simple;
	bh=2XYdaDwIQxAFtp7bJ97Ze2DQ/dAGBHGTKD1mDsVG0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9ohHb7s8I4NtYst9YGk1d2KhDXpY8oJy8xF7ghvkjUsHmwrqN3HFitNK3MG8K9+iZs7symClcFY2HZlg2tDbOufMuap1RvJj1zgrmxcsDPw0ND/DQfSlBf5OMr9M5b8IV+iFfdmUalyyfYANYZcVDwDDegh5bh/jKWiRs0+76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGqC/tUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F77C43390;
	Sun, 24 Mar 2024 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320394;
	bh=2XYdaDwIQxAFtp7bJ97Ze2DQ/dAGBHGTKD1mDsVG0ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGqC/tUi2PolM7nRpswvTJRTeQPL/dcXmYq8ttSRhIa4qBH7L/TmqhEWCKltQkM/u
	 RizNTiL9AyHES9oKwo6XET6u0UvpK5gXk3HXO97qnJQkQLjsN2X6iNh7ugeIYnDIZP
	 IsgG0MM4aU8rYQbVaxjF4brhmtLJYiIIpYdPvKnpkS90HA4n/Tyl6R4u/ZznZFObVL
	 jjGBmGwa+ZynmPHEXV0aakMXiHJZ8hMQwvw9A0CkgBGN4j7MeGF2972ov53Xp4sPCz
	 ZRZERr2SVuG1Wn3esLD4NXxX9zdNwpxsR1U3aNnMs3mDXF6UH3S4AVf/eJvje5/GTu
	 XjO12553mZQ+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Khem Raj <raj.khem@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 700/715] riscv: Fix syscall wrapper for >word-size arguments
Date: Sun, 24 Mar 2024 18:34:39 -0400
Message-ID: <20240324223455.1342824-701-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


