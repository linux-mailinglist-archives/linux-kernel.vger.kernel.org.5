Return-Path: <linux-kernel+bounces-35382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331F838FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C28A28D051
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7851605C0;
	Tue, 23 Jan 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDsdxTCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15406605B8;
	Tue, 23 Jan 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016221; cv=none; b=EJXbW5NpQy4lm1CqGpjXH2u8MvtfoBH66D31QaHYh1us6LkBDuoG0OQeF/Rro6vPUDytkfFcxGl0B5yJfytNj6HliIikT93FCqWaMy8y9iPfvFnnA14sg9zrUjryEbT9u9rqZ4GnQY7cOe30DJi8uBX5TpKY9OAC9fm+21YX5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016221; c=relaxed/simple;
	bh=0RGNHFInxFQRBM29nCBUXg7rUT8MFbgsXfxi0b/Mf3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a62pOEOsdkpSjQ5RGZYmNrCOxz2lsrHJl9P4ykb4XCJB1YmmBev15wy5pmfix+gjeLjGxXwVaDjy62OREPADanI23ZBoHoTEbtlz0TrLyPKNjJGIaRe6V3SG/t6t2Xm9BqJW8jEeFPq8FY9vB7a8DZ8fMitUPh1N6P9C1HR7FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDsdxTCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0F6C433F1;
	Tue, 23 Jan 2024 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016220;
	bh=0RGNHFInxFQRBM29nCBUXg7rUT8MFbgsXfxi0b/Mf3o=;
	h=From:To:Cc:Subject:Date:From;
	b=HDsdxTCPF2P8K6rIbqpCVoXFAaJMHGYEHl/5rvQT08ljmM5S+A1N+8n6SEbg37UrZ
	 haKP5Mxsx78xdiZzUoW6l8J0KNzhBUuO3BoyKjQBZ73dosoIMGDg2m52H7psIuxJQH
	 5Jcugn+deUs8HeTfr5/b9S07L942RzQmS0UesSgWhrRaJTAVCLW7PS9CXmLeK0XcnB
	 E5yj4eC33L7JH5ENXkgFu65QRES6Lml1d4qXR/YtnVIYSvW145uoed3RHgHz4i5XKm
	 lnn5/r67EHpwzNIUz3i34+oy1CxWQQujKy5WS7FaZnDSZsrqN6BGUccYHDLGnGUnN1
	 p/ssMhEAlE7sA==
From: Arnd Bergmann <arnd@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] sh: use generic uaccess
Date: Tue, 23 Jan 2024 14:23:20 +0100
Message-Id: <20240123132335.2034611-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

As reported by many people, the nommu SH code runs into a compiler error
with a newly added syscall:

  + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field :  => 590, 593
  + {standard input}: Error: displacement to undefined symbol .L135 overflows 8-bit field :  => 603
  + {standard input}: Error: displacement to undefined symbol .L140 overflows 8-bit field :  => 606
  + {standard input}: Error: displacement to undefined symbol .L76 overflows 12-bit field:  => 591, 594
  + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field : 607 => 607, 582, 585
  + {standard input}: Error: displacement to undefined symbol .L97 overflows 12-bit field:  => 607
  + {standard input}: Error: pcrel too far: 604, 590, 577, 593, 572, 569, 598, 599, 596, 610 => 610, 574, 599, 569, 598, 596, 601, 590, 604, 595, 572, 577, 593

Avoid the code that triggers this entirely by using the same generic
uaccess code that m68k and riscv have on nommu.

Link: https://lore.kernel.org/all/07d8877b-d933-46f4-8ca4-c10ed602f37e@app.fastmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/uaccess.h    |  5 +++++
 arch/sh/include/asm/uaccess_32.h | 23 -----------------------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index a79609eb14be..b42764d55901 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_UACCESS_H
 #define __ASM_SH_UACCESS_H
 
+#ifdef CONFIG_MMU
 #include <asm/extable.h>
 #include <asm-generic/access_ok.h>
 
@@ -130,4 +131,8 @@ struct mem_access {
 int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 			    struct mem_access *ma, int, unsigned long address);
 
+#else
+#include <asm-generic/uaccess.h>
+#endif
+
 #endif /* __ASM_SH_UACCESS_H */
diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..e053f2fd245c 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -35,7 +35,6 @@ do {								\
 	}							\
 } while (0)
 
-#ifdef CONFIG_MMU
 #define __get_user_asm(x, addr, err, insn) \
 ({ \
 __asm__ __volatile__( \
@@ -56,16 +55,6 @@ __asm__ __volatile__( \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
 	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
-#else
-#define __get_user_asm(x, addr, err, insn)		\
-do {							\
-	__asm__ __volatile__ (				\
-		"mov." insn "	%1, %0\n\t"		\
-		: "=&r" (x)				\
-		: "m" (__m(addr))			\
-	);						\
-} while (0)
-#endif /* CONFIG_MMU */
 
 extern void __get_user_unknown(void);
 
@@ -140,7 +129,6 @@ do {							\
 	}						\
 } while (0)
 
-#ifdef CONFIG_MMU
 #define __put_user_asm(x, addr, err, insn)			\
 do {								\
 	__asm__ __volatile__ (					\
@@ -164,17 +152,6 @@ do {								\
 		: "memory"					\
 	);							\
 } while (0)
-#else
-#define __put_user_asm(x, addr, err, insn)		\
-do {							\
-	__asm__ __volatile__ (				\
-		"mov." insn "	%0, %1\n\t"		\
-		: /* no outputs */			\
-		: "r" (x), "m" (__m(addr))		\
-		: "memory"				\
-	);						\
-} while (0)
-#endif /* CONFIG_MMU */
 
 #if defined(CONFIG_CPU_LITTLE_ENDIAN)
 #define __put_user_u64(val,addr,retval) \
-- 
2.39.2


