Return-Path: <linux-kernel+bounces-127376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFA894A74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DA81F204C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7D1F94B;
	Tue,  2 Apr 2024 04:27:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA71C292
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032033; cv=none; b=Qy8yVpQDzNl9tJWbBQ9O7l2rJXNqBcJ6BRlnHgfAyL2ANrjH6PpaylET1siI0F07Amvg1nivnSGb+qSrd8iFoz/sluJPF/PGGX1aQQ4WiH5l3/J0GDk8zWmmi6D+ZKES75LobS/bbXKigLcca9tkImMm8LtuIYgOPrq7XDuk7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032033; c=relaxed/simple;
	bh=RihDwvO58suRgQreoRv3uBrOoU2Kph2MBTIP+ZUHIpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZlS2FDIfa0AtTtx3JHfczxmNzVgrBUD40RgKdRt8yudkkF7Q9SSb220UybwQ1rAfeyKVo4it//EESV1RQ2W2k/e4/5IBQQ9K0DfvTAz2byAeqg8tzwkH9gOzhnPNaBKSRSV2kQ84LLiDAYzbJBsblLzZwSjdrHzrOM2YCDg5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CC1C43394;
	Tue,  2 Apr 2024 04:27:12 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 5/8] parisc: __cmpxchg_u32(): lift conversion into the callers
Date: Tue,  2 Apr 2024 00:28:32 -0400
Message-Id: <20240402042835.11815-5-viro@zeniv.linux.org.uk>
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

__cmpxchg_u32() return value is unsigned int explicitly cast to
unsigned long.  Both callers are returns from functions that
return unsigned long; might as well return have __cmpxchg_u32()
return that unsigned int (aka u32) and let the callers convert
implicitly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/cmpxchg.h | 3 +--
 arch/parisc/lib/bitops.c          | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index c1d776bb16b4..0924ebc576d2 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -57,8 +57,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 extern void __cmpxchg_called_with_bad_pointer(void);
 
 /* __cmpxchg_u32/u64 defined in arch/parisc/lib/bitops.c */
-extern unsigned long __cmpxchg_u32(volatile unsigned int *m, unsigned int old,
-				   unsigned int new_);
+extern u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
 extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index 36a314199074..ae2231d92198 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -68,16 +68,16 @@ u64 notrace __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
 	return prev;
 }
 
-unsigned long notrace __cmpxchg_u32(volatile unsigned int *ptr, unsigned int old, unsigned int new)
+u32 notrace __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
 	unsigned long flags;
-	unsigned int prev;
+	u32 prev;
 
 	_atomic_spin_lock_irqsave(ptr, flags);
 	if ((prev = *ptr) == old)
 		*ptr = new;
 	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return (unsigned long)prev;
+	return prev;
 }
 
 u8 notrace __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
-- 
2.39.2


