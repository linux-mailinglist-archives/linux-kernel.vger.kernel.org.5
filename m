Return-Path: <linux-kernel+bounces-127375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F49894A73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CD61C222E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA018AE0;
	Tue,  2 Apr 2024 04:27:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E62182C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032032; cv=none; b=VUbBzyv9tSMm8Mw0SVH6CZrT0oydF/lWfO7NNtsKIDnB4WsRx5vQqulG8jdkcnFYJ41v2m/uhRjwv1kbomOH3VVZJV4r46STvaQxJ1hlCVvJVdbqhFKiItrUgrghJAWxOF4x4zTSXAq1HjXe2Gmt8+sFP0su2dQr4gEbK0pgfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032032; c=relaxed/simple;
	bh=tg20vIYtQAbEjR/CpCzmgPfaaRyjY/cpsAH8T7IzX6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpACuU0lGYdaMhmt2qvskKPC7Rljl14+GQOx2oryapghRJpPegwAtLPNVzd4KHvZt3/ohcuEtbo6s/6fnut7fuGQvR8pboGBZlXdesawyfxDpQWnoS4N/DqQIE/ZrjL6uoVWweczZXjJT+LUadd5toeJZGGYaListl/TsUry8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F6CC43399;
	Tue,  2 Apr 2024 04:27:11 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 4/8] sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
Date: Tue,  2 Apr 2024 00:28:31 -0400
Message-Id: <20240402042835.11815-4-viro@zeniv.linux.org.uk>
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

trivial now

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/cmpxchg_32.h | 7 ++++++-
 arch/sparc/lib/atomic32.c           | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 86254c366477..1324984de36a 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -38,7 +38,8 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
 
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
-/* we only need to support cmpxchg of a u32 on sparc */
+u8 __cmpxchg_u8(volatile u8 *m, u8 old, u8 new_);
+u16 __cmpxchg_u16(volatile u16 *m, u16 old, u16 new_);
 u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 
 /* don't worry...optimizer will get rid of most of this */
@@ -46,6 +47,10 @@ static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
+	case 2:
+		return __cmpxchg_u16((u16 *)ptr, (u16)old, (u16)new_);
 	case 4:
 		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
 	default:
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 0d215a772428..8ae880ebf07a 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -173,8 +173,12 @@ EXPORT_SYMBOL(sp32___change_bit);
 		return prev;					\
 	}
 
+CMPXCHG(u8)
+CMPXCHG(u16)
 CMPXCHG(u32)
 CMPXCHG(u64)
+EXPORT_SYMBOL(__cmpxchg_u8);
+EXPORT_SYMBOL(__cmpxchg_u16);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 
-- 
2.39.2


