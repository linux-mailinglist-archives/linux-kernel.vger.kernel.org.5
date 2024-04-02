Return-Path: <linux-kernel+bounces-127379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B93894A77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20111F20F41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1A2BB1B;
	Tue,  2 Apr 2024 04:27:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A929421
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032036; cv=none; b=NanGtBgyHLYWY4DTz9qZ+S0g1/bqO0cLk8BHMoQD8tlO7uLt8RutUXylFqJOhoPhv9A3hlHrRz2lREjp14sNvHTzrI5pkdxKtpCR69Cj4vLXrDvCEebTMrsB/jCMzK3GR2VGkLJNJctd1MpAnIJvnQYL/dRJrUYB3RCWDx9S7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032036; c=relaxed/simple;
	bh=eO8Ldq5bVBT1ZWhJzdjOelO13j/YRq1I97V1Ay9Buzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8/8orS2wLDRMjXV4lV2UAXdCxxSeQXRHjEepVnydbrDYfGfGpgogyxSGI9fY4KN4Cbffav40OdWvCk5lQDHYK1Tb68KjQeKxH3ZZkXujUfE8Bq971jTcRd3ZniFA/aVIxejGmD1tPqrey8G/zFZRJBO/cc+uZA+IdwGSd+pdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45495C433F1;
	Tue,  2 Apr 2024 04:27:15 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 8/8] parisc: add u16 support to cmpxchg()
Date: Tue,  2 Apr 2024 00:28:35 -0400
Message-Id: <20240402042835.11815-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402042835.11815-1-viro@zeniv.linux.org.uk>
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add (and export) __cmpxchg_u16(), teach __cmpxchg() to use it.
And get rid of the casts of {old,new_} in __cmpxchg() - __cmpxchg_u...()
has those arguments declared as u<size> and conversion from unsigned
long to those is automatic.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/cmpxchg.h | 13 +++++++------
 arch/parisc/kernel/parisc_ksyms.c |  1 +
 arch/parisc/lib/bitops.c          |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 0924ebc576d2..1a0eec8c91f5 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -56,10 +56,11 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 /* bug catcher for when unsupported size is used - won't link */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-/* __cmpxchg_u32/u64 defined in arch/parisc/lib/bitops.c */
+/* __cmpxchg_u... defined in arch/parisc/lib/bitops.c */
+extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
+extern u16 __cmpxchg_u16(volatile u16 *ptr, u16 old, u16 new_);
 extern u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
-extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -67,11 +68,11 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
 	switch (size) {
 #ifdef CONFIG_64BIT
-	case 8: return __cmpxchg_u64((u64 *)ptr, old, new_);
+	case 8: return __cmpxchg_u64((volatile u64 *)ptr, old, new_);
 #endif
-	case 4: return __cmpxchg_u32((unsigned int *)ptr,
-				     (unsigned int)old, (unsigned int)new_);
-	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
+	case 4: return __cmpxchg_u32((volatile u32 *)ptr, old, new_);
+	case 2: return __cmpxchg_u16((volatile u16 *)ptr, old, new_);
+	case 1: return __cmpxchg_u8((volatile u8 *)ptr, old, new_);
 	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index dcf61cbd3147..c1587aa35beb 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
 EXPORT_SYMBOL(__cmpxchg_u8);
+EXPORT_SYMBOL(__cmpxchg_u16);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index cae30a3eb6d9..9df810050642 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -71,4 +71,5 @@ unsigned long notrace __xchg8(char x, volatile char *ptr)
 
 CMPXCHG(u64)
 CMPXCHG(u32)
+CMPXCHG(u16)
 CMPXCHG(u8)
-- 
2.39.2


