Return-Path: <linux-kernel+bounces-94152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91981873A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C78F2841AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2849134733;
	Wed,  6 Mar 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YnOkUDS+"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E8131E4B;
	Wed,  6 Mar 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738709; cv=none; b=mDSno6cy8euJmrJRnMWO/EyS/kDnihb4uXCnLleEFRWMuEMSUzlRFaey0fWKyh9rf20RqHP6Oo+TzkrAzET33bWwpjlbed7Fz4ycCJCG2M/i9YGadIn8/XTwDLkOk4mboNs5QbfUXs/0Lp5B56oeaZRdVaMtU+pSM1I9jyPx57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738709; c=relaxed/simple;
	bh=EDc76FHAyYlhGhEF+aSjah9SCCYqShQbC/emjwhHXkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4V6EY1tF7E/6JjCckH1dGl9/53OHqS4aDj93D5j4wKliOu1/ppmfMiGvE63Kjs3gtTthN1mXNUuNZe9ftI6m/CUDMJPMdZBgn60LL7IrIwkuPQyBjy63OsGj9xMiwMzghy5NxiLfIBkk1IUYpfzUE6riKMx5QBz5BYslgt7IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YnOkUDS+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709738700;
	bh=EDc76FHAyYlhGhEF+aSjah9SCCYqShQbC/emjwhHXkg=;
	h=From:To:Cc:Subject:Date:From;
	b=YnOkUDS+IHPn0lJQvlN8WhKDbpSlcVQnSJwwRrYueGB8MJ5FDfNDq/oDA0o+70lN3
	 LcfAMtGAX6z1f7nfCYfjMA25S7XR4VHogs5D9rTA7A/w+agmGTehnpnd6fV3GAJaPZ
	 PuPCB7QJGjdmiK6wrO6KOgWkL7SXMeryyFy+JTME/f2hSak2hKjx+XkkVTrFVWRBP/
	 sovfbmGECCbBIhPkzFVee34VLcJ4ZV0ob6ad4GmBVmy2BaaoLQwDVPCXX71ZX13hxN
	 gfsX3nR9nCyE0DZS38twlXcMNvp2q4xImvYoQoYs2VRuuOqEHtLdiwYjf24sPj7CoS
	 MT9gE0i++0CnA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TqbpM6s7RzfyB;
	Wed,  6 Mar 2024 10:24:59 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "levi . yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH] sched: Add missing memory barrier in switch_mm_cid
Date: Wed,  6 Mar 2024 10:24:43 -0500
Message-Id: <20240306152443.6340-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
unset the activly used cid when it fails to observe active task after it
sets lazy_put.

The *is* a memory barrier between storing to rq->curr and _return to
userspace_ (as required by membarrier), but the rseq mm_cid has stricter
requirements: the barrier needs to be issued between store to rq->curr
and switch_mm_cid(), which happens earlier than:

- spin_unlock(),
- switch_to().

So it's fine when the architecture switch_mm happens to have that barrier
already, but less so when the architecture only provides the full barrier
in switch_to() or spin_unlock().

It is a bug in the rseq switch_mm_cid() implementation. All architectures
that don't have memory barriers in switch_mm(), but rather have the full
barrier either in finish_lock_switch() or switch_to() have them too late
for the needs of switch_mm_cid().

Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
generic barrier.h header, and use it in switch_mm_cid() for scheduler
transitions where switch_mm() is expected to provide a memory barrier.

Architectures can override smp_mb__after_switch_mm() if their
switch_mm() implementation provides an implicit memory barrier.
Override it with a no-op on x86 which implicitly provide this memory
barrier by writing to CR3.

Reported-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 35389b2af88e..0d5e54201eb2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,9 @@ do {									\
 #define __smp_mb__before_atomic()	do { } while (0)
 #define __smp_mb__after_atomic()	do { } while (0)
 
+/* Writing to CR3 provides a full memory barrier in switch_mm(). */
+#define smp_mb__after_switch_mm()	do { } while (0)
+
 #include <asm-generic/barrier.h>
 
 /*
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 961f4d88f9ef..5a6c94d7a598 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -296,5 +296,13 @@ do {									\
 #define io_stop_wc() do { } while (0)
 #endif
 
+/*
+ * Architectures that guarantee an implicit smp_mb() in switch_mm()
+ * can override smp_mb__after_switch_mm.
+ */
+#ifndef smp_mb__after_switch_mm
+#define smp_mb__after_switch_mm()	smp_mb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..638ebd355912 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -79,6 +79,8 @@
 # include <asm/paravirt_api_clock.h>
 #endif
 
+#include <asm/barrier.h>
+
 #include "cpupri.h"
 #include "cpudeadline.h"
 
@@ -3481,13 +3483,18 @@ static inline void switch_mm_cid(struct rq *rq,
 		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
 		 * Provide it here.
 		 */
-		if (!prev->mm)                          // from kernel
+		if (!prev->mm) {                        // from kernel
 			smp_mb();
-		/*
-		 * user -> user transition guarantees a memory barrier through
-		 * switch_mm() when current->mm changes. If current->mm is
-		 * unchanged, no barrier is needed.
-		 */
+		} else {				// from user
+			/*
+			 * user -> user transition relies on an implicit the
+			 * memory barrier in switch_mm() when current->mm
+			 * changes. If the architecture switch_mm() does not
+			 * have an implicit memory barrier, it is emitted here.
+			 * If current->mm is unchanged, no barrier is needed.
+			 */
+			smp_mb__after_switch_mm();
+		}
 	}
 	if (prev->mm_cid_active) {
 		mm_cid_snapshot_time(rq, prev->mm);
-- 
2.39.2


