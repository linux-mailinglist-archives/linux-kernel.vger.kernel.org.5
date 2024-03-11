Return-Path: <linux-kernel+bounces-99473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E88788F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816821C20DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC554FB7;
	Mon, 11 Mar 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2d/L6lw"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D454F9D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185513; cv=none; b=VC+lf7ZgUhkjRuYCW5K9vEVcST8oAqPFlJMWb49E0gjriaSHa5F4Wy5hpwTS88R0JHc9Pjhma6/3WkosgW2NfOA9huP3eBdvCpIH+roAsB+A3O+x+uPiz19DnM+v1P5LFTkd8mZbhRrYcl4w6VDR7eCU3SJWdR8W8Oai43HOesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185513; c=relaxed/simple;
	bh=P9wUwpcw3NHUEai0EY+p4WNxdtLcGXphsLbKEdtDEg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m1f6aPiWIe1jsX2MPwtwLGQZl2cXDk34DsFkQRCReEf30eFLzc+GxK/Xgc9Ijfw2mRIL4h51wWDWmSiVipavmj+FBQieI88oJ5acisTuBT7UT3iYX0eRcuClWiqM/Uf60bMOM6zhZ7mnYCOaFU0OJcqy6QlKyYnGs39jkbhMKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2d/L6lw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e68be494d2so971995b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710185510; x=1710790310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cy5o6m+sWD55XX6nTI+EYS+h0yuQMLX62AkaGtKJN/Q=;
        b=s2d/L6lwEQwHvvaM6Xd+Osh7uFxMFfVwcRZOqHbEMF7kzYiENNX670OPt8C3Uv+3fD
         mMCI8Vmyu09bIIS5kcwna6mz+X5nLXaeZuopHLGHKktjIi7tYFnPZgJ2iiAAUT2i0boQ
         5aH4puQMAn+DD/+MCAmPh4cSLPTrPXXkQ6GwHl6wudtk9OP16PHQhvWdc/BASEUNX8yX
         8U7XLTJpdv/TqbGeL2wwlg9VGNNmDnvaGnp5xDnNkk8plnuu9+W3rJqpauVLoVhUv2mi
         AGhGH0MWy/wgrteC+6Z3ZuagN72E1XT36FXE5SGGVYBZtDsC7exFkcHQHvSmWAKBB3XF
         R22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185510; x=1710790310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cy5o6m+sWD55XX6nTI+EYS+h0yuQMLX62AkaGtKJN/Q=;
        b=wyS9OBJkpQxofWdx+YdJDRfN0fniRshxV8toNKDorpvQAwNFVgYe4AyH4U+LpBSiMZ
         N/Z7Zg0eifJEMbKz6zmkNe3Yb3rOOnhRdAzF7ZDnuOQ0TEKibZGCuJ7FdAjBkJpmVHaf
         6INmzJk7x4UZ75/ScWLGsqLlZvjbIp7aZ0rXtuyDfk5qAH0KcebtFO21kd/RnN80NSa/
         SrMfPxVZgkn0NHrTkHLpDxSFubJu4zUn/h22Qg4krkmZ3058vW9lbHKmRrqkYf8nw7yD
         vCSbRkUOiOXVtr9ud/VbJ6QgQSk0HuCOPSV8Yg3KvbSJveoYum4luD4edke5I9I7lpqH
         xnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9RgZZIhxXLS3ALBFsAruvUVTm9tfYt/vCaYk2+308XlVUu9ruBtCwISaFIMDdn8NJ2wSbsa63n3fyALTu5l2ntWsfinKFDhUPmURH
X-Gm-Message-State: AOJu0YzdRquJ1LxmpXNf88lS7s5OarrRgPQDvhS/IEySuJsI1UHuivNM
	tzCkcPBWA4Wk0Z4fEm9x85EvAIAR/JQRiQCel3/kXlTsY4in6B+mazNF4esIrYckQfqmk4tTTym
	jc8rXHqQcVMHALKNx8p6mZyrpYw==
X-Google-Smtp-Source: AGHT+IFl5rL/5hZzllSQT4kNPhf7K+Mzylld0CDU7EGjFVl6h6YIMbKzhC0pm5GcEpFQvIHX+1rha7stYdM8mqFbCkQ=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:2ea7:b0:6e6:4946:93e3 with
 SMTP id fd39-20020a056a002ea700b006e6494693e3mr151620pfb.3.1710185510021;
 Mon, 11 Mar 2024 12:31:50 -0700 (PDT)
Date: Mon, 11 Mar 2024 19:31:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5091; i=samitolvanen@google.com;
 h=from:subject; bh=P9wUwpcw3NHUEai0EY+p4WNxdtLcGXphsLbKEdtDEg4=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBl71wfJnj+5L8FG37zVyJNxfMfNJoY0VJs0yMLB
 xU3BtR6b7+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZe9cHwAKCRBMtfaEi7xW
 7vAYC/9OQ9Z2KvfsxsRPYjStOgFF960iLZz4U2Yg1Pc04nqTJhJOjAA0LlXHVE6XdGCQ1MK2xTv
 OtI1cV6vtQnAMtpfTPLFdvIwuZ7Op/oYW6FpyU/OLXUZHYssSN6b7f06hUuWdsIDjznZtaHuKaY
 yFBq8JY8H/+aWai3ZaR8aAAUpZti8u3nbZiePGtPhrgQz/PyBjy4Qux9cHB7dCasmi01Km62Od3
 GmaGGdIVhg4OQ4LJag7l9WlxfAIqgCWAojhrslIMlDg24sTaGc6KTE7NRwOS8Jx5Op+MvJGVA9c
 C7Gmr975CCDLfX0MxbY1PmLctEXAJ77Ft9BsCg68UI1YUBgFJD8S/dBlrdbHpfFo/1UeYHIjFdz
 cs1NQ4lXP1lnxvRItHh5uODri1JStub2sD6YywSrGnF/3qkqpI0ey8ybdthU1mYp4WMWFPQwdAA d78nKkyQmeeQTFJU3AiRd6nZpO4pnRf1iCIAOPk55HAB1cx9UwVaE61BAY5z/eARLf3Oo=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311193143.2981310-2-samitolvanen@google.com>
Subject: [PATCH] riscv: Fix syscall wrapper for >word-size arguments
From: Sami Tolvanen <samitolvanen@google.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 arch/riscv/include/asm/syscall_wrapper.h | 53 +++++++++++++++++-------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index eeec04b7dae6..980094c2e976 100644
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
2.44.0.278.ge034bb2e1d-goog


