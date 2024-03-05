Return-Path: <linux-kernel+bounces-92532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB038721BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DD328A4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2647126F08;
	Tue,  5 Mar 2024 14:40:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA56127;
	Tue,  5 Mar 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649629; cv=none; b=oHX6gK2ykHNJXUetBgsNwgMbD6qdEA7JQD+VBGR8HGZqjvsPJcpUb3N2blwylerrlWpebTGXgqHTbO9HpxAMjUFS4ppTFmPZTbqZRNfxToMr/iw0nwayMkqv8lNEJ7WaDf8rcDgy/z4XaOuVhZ682ZIoR5WgdyAeGcMrS94NCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649629; c=relaxed/simple;
	bh=TzU/yVqfFw2Z0bXsBGHvM4X/+uETrSFIV0dy36+M3uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rERsTf0r2KrTXAUhPfgo/coyjcXobz0wZsJxPl2atE0vtEXe/2HivOZW2fBzq455bhkndEvomGB+ff8SFCWQgjiKsw43rLUV4w8QzOwhxmYJvwG0LpeurEMo1FpLNS6Tf5cbN16pGkgBW/DMrmFiem0WXOmy8Hvyp1vFJb8B8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4AC433F1;
	Tue,  5 Mar 2024 14:40:26 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Define the __io_aw() hook as mmiowb()
Date: Tue,  5 Mar 2024 22:39:58 +0800
Message-ID: <20240305143958.1752241-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
mmiowb()") remove all mmiowb() in drivers, but it says:

"NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
spin_unlock(). However, pairing each mmiowb() removal in this patch with
the corresponding call to spin_unlock() is not at all trivial, so there
is a small chance that this change may regress any drivers incorrectly
relying on mmiowb() to order MMIO writes between CPUs using lock-free
synchronisation."

The mmio in radeon_ring_commit() is protected by a mutex rather than a
spinlock, but in the mutex fastpath it behaves similar to spinlock. We
can add mmiowb() calls in the radeon driver but the maintainer says he
doesn't like such a workaround, and radeon is not the only example of
mutex protected mmio.

So we should extend the mmiowb tracking system from spinlock to mutex,
and maybe other locking primitives. This is not easy and error prone, so
we solve it in the architectural code, by simply defining the __io_aw()
hook as mmiowb(). And we no longer need to override queued_spin_unlock()
so use the generic definition.

Without this, we get such an error when run 'glxgears' on weak ordering
architectures such as LoongArch:

radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 last fence id 0x000000000001f414 on ring 3)
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 last fence id 0x000000000000f941 on ring 0)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)

Link: https://lore.kernel.org/dri-devel/29df7e26-d7a8-4f67-b988-44353c4270ac@amd.com/T/#t
Link: https://lore.kernel.org/linux-arch/20240301130532.3953167-1-chenhuacai@loongson.cn/T/#t
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/Kbuild      |  1 +
 arch/loongarch/include/asm/io.h        |  2 ++
 arch/loongarch/include/asm/qspinlock.h | 18 ------------------
 3 files changed, 3 insertions(+), 18 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/qspinlock.h

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index a97c0edbb866..2dbec7853ae8 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += user.h
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index c486c2341b66..4a8adcca329b 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -71,6 +71,8 @@ extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t
 #define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
 #define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
 
+#define __io_aw() mmiowb()
+
 #include <asm-generic/io.h>
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
deleted file mode 100644
index 34f43f8ad591..000000000000
--- a/arch/loongarch/include/asm/qspinlock.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_QSPINLOCK_H
-#define _ASM_QSPINLOCK_H
-
-#include <asm-generic/qspinlock_types.h>
-
-#define queued_spin_unlock queued_spin_unlock
-
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	compiletime_assert_atomic_type(lock->locked);
-	c_sync();
-	WRITE_ONCE(lock->locked, 0);
-}
-
-#include <asm-generic/qspinlock.h>
-
-#endif /* _ASM_QSPINLOCK_H */
-- 
2.43.0


