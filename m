Return-Path: <linux-kernel+bounces-91454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23F8711B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6487B1F21FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68F5664;
	Tue,  5 Mar 2024 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc5+QLUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378464C96
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598508; cv=none; b=n9tp+L+O1kzeU8Hd3XwK5rKIDwCKESv3ZwUdGrmZCFdkIOKfy29cQmh6PcKq6+DvK6erqku4mWyseTvYy80BxBYsvFkyzBq8bkY1jvny9YGNPwXl30D3zw1nggTBHHm7ajPCQ5Cuofd+gyHyTViEfT6/P6UQSNf73yW62RQsXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598508; c=relaxed/simple;
	bh=S/MxXC0LyuU+rBL34uUkqZ7q4SGqxtyGFgsbajGBEcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+VwmNRY968pfgzjUFjd/jxGKs36G34pERO8H0h2JcIGx4n/B9TTnN1t59yqqjnmUOjsi/lax0m0xDFjI6EvamwIjejqrFzRtLl1iKb1MFC4gmcJc6miroBTOJSAAWh98/SRz3B19uSyAnHQ+jXX3HKlwUaxl0Kzuuaov0fFGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc5+QLUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC955C433F1;
	Tue,  5 Mar 2024 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709598507;
	bh=S/MxXC0LyuU+rBL34uUkqZ7q4SGqxtyGFgsbajGBEcs=;
	h=From:To:Cc:Subject:Date:From;
	b=Rc5+QLUe9qB1IOVNuhSSLxyA/R0diXuNTa/lnQ0xWy3WI3ViHgxYif7nCRHy1Afob
	 YmFhQyaHqqsAkqr+dFrk96K24BdWJPn+o480Tr1RiqpM1AuYk0rSdVdS44PY1hBJjW
	 oucE87ka0LPwAMFvotTo7hG3t9Rl4kK04LmqYLc/d+YsdLDY2hMRXT8l0AzgoQBIA+
	 lYa8yr2l6dE+7T+G3/z3WtOJ67YxIeWPptUlZGhEcGviv45PHjODjF5+uJFvx2uo4Y
	 3lfF2+g1qXDuYtld67zDYYxm8tm7SWEQqq8ZMHSm82xGSMi+2DTn34RUL7QDWEzby6
	 68X47U8y8D4+g==
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] timer/migration: Fix quick check reporting late expiry
Date: Tue,  5 Mar 2024 01:28:22 +0100
Message-ID: <20240305002822.18130-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CPU is the last active in the hierarchy and it tries to enter
into idle, the quick check looking up the next event towards cpuidle
heuristics may report a too late expiry, such as in the following
scenario:

                        [GRP1:0]
                     migrator = NONE
                     active   = NONE
                     nextevt  = T0:0, T0:1
                     /              \
          [GRP0:0]                  [GRP0:1]
       migrator = NONE           migrator = NONE
       active   = NONE           active   = NONE
       nextevt  = T0, T1         nextevt  = T2
       /         \                /         \
      0           1              2           3
    idle       idle           idle         idle

0) The whole system is idle, and CPU 0 was the last migrator. CPU 0 has
a timer (T0), CPU 1 has a timer (T1) and CPU 2 has a timer (T2). The
expire order is T0 < T1 < T2.

                        [GRP1:0]
                     migrator = GRP0:0
                     active   = GRP0:0
                     nextevt  = T0:0(i), T0:1
                   /              \
          [GRP0:0]                  [GRP0:1]
       migrator = CPU0           migrator = NONE
       active   = CPU0           active   = NONE
       nextevt  = T0(i), T1      nextevt  = T2
       /         \                /         \
      0           1              2           3
    active       idle           idle         idle

1) CPU 0 becomes active. The (i) means a now ignored timer.

                        [GRP1:0]
                     migrator = GRP0:0
                     active   = GRP0:0
                     nextevt  = T0:1
                     /              \
          [GRP0:0]                  [GRP0:1]
       migrator = CPU0           migrator = NONE
       active   = CPU0           active   = NONE
       nextevt  = T1             nextevt  = T2
       /         \                /         \
      0           1              2           3
    active       idle           idle         idle

2) CPU 0 handles remote. No timer actually expired but ignored timers
   have been cleaned out and their sibling's timers haven't been
   propagated. As a result the top level's next event is T2 and not T1.

3) CPU 0 tries to enter idle without any global timer enqueued and calls
   tmigr_quick_check(). The expiry of T2 is returned instead of the
   expiry of T1.

When the quick check returns an expiry that is too late, the cpuidle
governor may pick up a C-state that is too deep. This may be result into
undesired CPU wake up latency if the next timer is actually close enough.

Fix this with assuming that expiries aren't sorted top-down while
performing the quick check. Pick up instead the earliest encountered one
while walking up the hierarchy.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d85aa2afb969..085b1d86aba9 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1385,11 +1385,11 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  single group active on the way to top level)
  * * nextevt		- when CPU is offline and has to handle timer on his own
  *			  or when on the way to top in every group only a single
- *			  child is active and but @nextevt is before next_expiry
- *			  of top level group
- * * next_expiry (top)	- value of top level group, when on the way to top in
- *			  every group only a single child is active and @nextevt
- *			  is after this value active child.
+ *			  child is active but @nextevt is before the lowest
+ * 		  next_expiry encountered while walking up to top level.
+ * * next_expiry	- value of lowest expiry encountered while walking groups
+ *			  if only a single child is active on each and @nextevt
+ *			  is after this lowest expiry.
  */
 u64 tmigr_quick_check(u64 nextevt)
 {
@@ -1408,10 +1408,16 @@ u64 tmigr_quick_check(u64 nextevt)
 	do {
 		if (!tmigr_check_lonely(group)) {
 			return KTIME_MAX;
-		} else if (!group->parent) {
-			u64 first_global = READ_ONCE(group->next_expiry);
-
-			return min_t(u64, nextevt, first_global);
+		} else {
+			/*
+			 * Since current CPU is active, events may not be sorted
+			 * from bottom to the top because the CPU's event is ignored
+			 * up to the top and its sibling's events not propagated upwards.
+			 * Thus keep track of the lowest observed expiry.
+			 */
+			nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
+			if (!group->parent)
+				return nextevt;
 		}
 		group = group->parent;
 	} while (group);
-- 
2.44.0


