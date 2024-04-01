Return-Path: <linux-kernel+bounces-127099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70048946A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F541B22E95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239458AC3;
	Mon,  1 Apr 2024 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRjGv/+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95C56759
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=if5QF8zSOzXRHgCLYYOsmmHhtBM4Ruzar0AnEML9S6x1WJcFyJ0fvHU7IS6bvOOOzal6x0//0hvM25pFoJosK5iWzX+VtomlxJvwtK4CsMcnkEnJhTaovr4vjoBkOxQYvUP4EmqKiItSq1BtDeG7Swyclu488IVVWWyLx+lKqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=cHdjMWF2pKpjp1cSSio1TIEvF/d3v3dy9dZ8dApGZaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q74puIz1yoDLZIm+/4kZreKTOXI65uTCj1lAzsh4XKQzcuZPuquLc8I9FV1ITiswytoC/uPv3uyavbkMfZQwkcvZyQ7RCVD6be+H+PSnlqbKp94Ba7W4i2Qn/NN1Wp3uTwizWMUdbtVU9pqwGi5L7CSQpoEOfTsAwGLfW4ySHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRjGv/+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC9DC41674;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=cHdjMWF2pKpjp1cSSio1TIEvF/d3v3dy9dZ8dApGZaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRjGv/+gDSEbG4K6K0NV7MmU0QufJtVBYBfxeKyOQa0h0evV+yct5bBRhoMQSPCMP
	 XDRZmN2Q2pb7o9OYst/ZZnhP3K5xDW7pk44v4JOxwr4VbVkbO5sBbK541XzK7IWXMk
	 pXBVXdoF4cxiWsNPVZwjs4XFjDhVLYvN1G/Gc5NVJrK/HRrlrxizsJ33IyuBJBraTt
	 jOv64zBDQ/UT9nD2WhwhbL4C5Nz0/bvECe1F1YsTvCotZG8uG6rZQo0/ghkTS7kgdr
	 6fHuxnq+I1XegKXRmh+QS/do3AO8kEqEYwmIvblcphWI1Hu4Tcnvt3vJyEL+HwUjQs
	 ZF6d+P70ZxP2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD0D4CE16EF; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:50 -0700
Message-Id: <20240401213950.3910531-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
and two-byte cmpxchg() on riscv.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: <linux-riscv@lists.infradead.org>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56b..4eaf40d0a52ec 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,6 +44,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2fee65cc84432..a5b377481785c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <linux/cmpxchg-emu.h>
 
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
@@ -170,6 +171,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
+	case 2:								\
+		break;							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
@@ -214,6 +221,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
+	case 2:								\
+		break;							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
@@ -260,6 +273,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
+	case 2:								\
+		break;							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 	case 4:								\
 		__asm__ __volatile__ (					\
 			RISCV_RELEASE_BARRIER				\
@@ -306,6 +325,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
+	case 2:								\
+		break;							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
-- 
2.40.1


