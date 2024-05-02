Return-Path: <linux-kernel+bounces-166423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69298B9A74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3ADB216AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB676058;
	Thu,  2 May 2024 12:11:07 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3EF60DCF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651867; cv=none; b=LbBGk/VRg3Xo/0DGePZFB9W6JFBjdADPqbRRq+8Ul39s5Gg2R9CY2aMslpsT/zWNZcdmbjWMVlK0K5KnKt3FR9tqLgqi5c9RxTSI4DF6B1vMN9GE2tI+jAsPuW4zwNAM27LNlPXJpa5++qeOmEL1csZ9pT+B6WTc75Z0hwamM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651867; c=relaxed/simple;
	bh=J0ys2nCMeqQznpcv3TvixEojj3WOQhbihu0iZmOz7CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMhCrYtvDC2gPdjOLF7Drh7qyW6Iv0w9twC6jMRGlsNjL3fIpAm7Ql3LyjdQoXrROdiVciHCmJaNoGDjDySoCRku0zxYLHO7KjJs2fvltz5fe1synAGESj9gQGwejHeZBKx5/FFaaP2vgfQuNGOz7PcopPt+I/uVhk+0FOqAgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:93f:7d7e:5c98:dabc])
	by laurent.telenet-ops.be with bizsmtp
	id JCB12C00P3PjoSD01CB1XB; Thu, 02 May 2024 14:11:02 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s2VGR-0034NX-Be;
	Thu, 02 May 2024 14:11:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s2VHB-004jt6-I9;
	Thu, 02 May 2024 14:11:01 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend v2] locking/spinlocks: Make __raw_* lock ops static
Date: Thu,  2 May 2024 14:10:59 +0200
Message-Id: <d3300a978761220729b58367f7051212826b0f16.1714651617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_GENERIC_LOCKBREAK=y and CONFIG_DEBUG_LOCK_ALLOC=n
(e.g. sh/sdk7786_defconfig):

    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]

All __raw_* lock ops are internal functions without external callers.
Hence fix this by making them static.

Note that if CONFIG_GENERIC_LOCKBREAK=y, no lock ops are inlined, as all
of CONFIG_INLINE_*_LOCK* depend on !GENERIC_LOCKBREAK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Waiman Long <longman@redhat.com>
---
Compile-tested on all defconfigs that have CONFIG_GENERIC_LOCKBREAK=y:
  - sh/sdk7786_defconfig,
  - sh/shx3_defconfig,
  - s390/debug_defconfig,
and also on s390/debug_defconfig after changing:
    CONFIG_DEBUG_LOCK_ALLOC=n
    CONFIG_DEBUG_WW_MUTEX_SLOWPATH=n
    CONFIG_LOCK_STAT=n
    CONFIG_PROVE_LOCKING=n

v2:
  - Add Acked-by,
  - Drop RFC,
  - Improve patch description.
---
 kernel/locking/spinlock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5ad2..7009b568e6255d64 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
  * towards that other CPU that it should break the lock ASAP.
  */
 #define BUILD_LOCK_OPS(op, locktype)					\
-void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
+static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
 {									\
 	for (;;) {							\
 		preempt_disable();					\
@@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
 	}								\
 }									\
 									\
-unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
+static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
 {									\
 	unsigned long flags;						\
 									\
@@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
 	return flags;							\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
 {									\
 	_raw_##op##_lock_irqsave(lock);					\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
 {									\
 	unsigned long flags;						\
 									\
-- 
2.34.1


