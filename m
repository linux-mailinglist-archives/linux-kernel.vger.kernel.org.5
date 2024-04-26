Return-Path: <linux-kernel+bounces-159972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450D8B36FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F001B20C29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B308145B0B;
	Fri, 26 Apr 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="LxwJxAt8"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84113D244
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133698; cv=none; b=qzXCvuiHuxqVtA0YNVOjIbGO9nVmNr5ac/IIx3L7oZVQ9HZBKdS0c1RLRM4JXN4S0o0aoa4R06blIjrW8yQk6KA8wRRousjAYqHlZ+gQdx2NDuf69jQM/FYCwoD7qHiqb6Vv/RA1T+uG7+AGF9a+wR+LIMxMv3bDvFvOk8Fw8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133698; c=relaxed/simple;
	bh=4J9T8dLyYXPXJscrNbpt1oBl/KJlwJW8Y+aBv80jApI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZERsDevM2410YYiSRC3pGqbkLUpyKJBCT7H7gN7maRQZeB2GoikS2QFesW4Wswwkm10O1cJKJTSYWfQ9cGCtfUIOxUYKutfXdzDtp5O7xRIYmQVyDW1RuvDBasmDgQ+RQbyljPeYPjVeBsRqjklR3e42/Yozloa1vQb80NDTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=LxwJxAt8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714133695;
	bh=4J9T8dLyYXPXJscrNbpt1oBl/KJlwJW8Y+aBv80jApI=;
	h=From:To:Cc:Subject:Date:From;
	b=LxwJxAt8/g6M7msXHMHks3zBsv3trPsFTq5Y3GkofG8RSK57Ri0OLsIDpRA3r87Rl
	 yi3DK/U9VYkVRZe49CUSv4P60KOPSpVdJx4z+9sKWyUs2xWLDKkrr7aZs4jeWb+FBG
	 tI0pACelksWmzua+P4kgZIyGfJcPFZASACmu3iP4=
Received: from stargazer.. (unknown [IPv6:240e:358:1105:4a00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3B6DC659FD;
	Fri, 26 Apr 2024 08:14:50 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
Date: Fri, 26 Apr 2024 20:14:42 +0800
Message-ID: <20240426121442.882029-1-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After selecting ARCH_SUPPORTS_INT128, when optimizing for size the
compiler generates calls to __lshrti3, __ashrti3, and __ashrti3 for
shifting __int128 values, causing a link failure:

    loongarch64-unknown-linux-gnu-ld: kernel/sched/fair.o: in
    function `mul_u64_u32_shr':
    <PATH>/include/linux/math64.h:161:(.text+0x5e4): undefined
    reference to `__lshrti3'

Provide the implementation of these functions if ARCH_SUPPORTS_INT128.

Reported-by: Huacai Chen <chenhuacai@kernel.org>
Closes: https://lore.kernel.org/loongarch/CAAhV-H5EZ=7OF7CSiYyZ8_+wWuenpo=K2WT8-6mAT4CvzUC_4g@mail.gmail.com/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/asm-prototypes.h |  6 +++
 arch/loongarch/lib/Makefile                 |  2 +
 arch/loongarch/lib/tishift.S                | 56 +++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 arch/loongarch/lib/tishift.S

diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
index cf8e1a4e7c19..51f224bcfc65 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -6,3 +6,9 @@
 #include <asm/page.h>
 #include <asm/ftrace.h>
 #include <asm-generic/asm-prototypes.h>
+
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+__int128_t __ashlti3(__int128_t a, int b);
+__int128_t __ashrti3(__int128_t a, int b);
+__int128_t __lshrti3(__int128_t a, int b);
+#endif
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index a77bf160bfc4..f61af161f16e 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -9,3 +9,5 @@ lib-y	+= delay.o memset.o memcpy.o memmove.o \
 obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
diff --git a/arch/loongarch/lib/tishift.S b/arch/loongarch/lib/tishift.S
new file mode 100644
index 000000000000..eb43f29f4d0b
--- /dev/null
+++ b/arch/loongarch/lib/tishift.S
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/asmmacro.h>
+#include <linux/linkage.h>
+#include <linux/export.h>
+
+SYM_FUNC_START(__lshrti3)
+	slli.d	t2, a1, 1
+	nor	t3, zero, a2
+	srl.d	t1, a0, a2
+	sll.d	t2, t2, t3
+	andi	t0, a2, 64
+	srl.d	a1, a1, a2
+	or	t1, t2, t1
+	maskeqz	a0, a1, t0
+	masknez	a1, a1, t0
+	masknez	t0, t1, t0
+	or	a0, t0, a0
+	jr	ra
+SYM_FUNC_END(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
+
+SYM_FUNC_START(__ashrti3)
+	nor	t3, zero, a2
+	slli.d	t2, a1, 1
+	srl.d	t1, a0, a2
+	sll.d	t2, t2, t3
+	andi	t0, a2, 64
+	or	t1, t2, t1
+	sra.d	a2, a1, a2
+	srai.d	a1, a1, 63
+	maskeqz	a0, a2, t0
+	maskeqz	a1, a1, t0
+	masknez	a2, a2, t0
+	masknez	t0, t1, t0
+	or	a1, a1, a2
+	or	a0, t0, a0
+	jr	ra
+SYM_FUNC_END(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
+
+SYM_FUNC_START(__ashlti3)
+	srli.d	t2, a0, 1
+	nor	t3, zero, a2
+	sll.d	t1, a1, a2
+	srl.d	t2, t2, t3
+	andi	t0, a2, 64
+	sll.d	a0, a0, a2
+	or	t1, t2, t1
+	maskeqz	a1, a0, t0
+	masknez	a0, a0, t0
+	masknez	t0, t1, t0
+	or	a1, t0, a1
+	jr	ra
+SYM_FUNC_END(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
-- 
2.44.0


