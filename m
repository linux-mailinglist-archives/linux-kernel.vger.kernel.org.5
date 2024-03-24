Return-Path: <linux-kernel+bounces-112940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5A887FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26E228105C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD057FBD5;
	Sun, 24 Mar 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob6ibY5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DC7F7DF;
	Sun, 24 Mar 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319753; cv=none; b=bwmXhBX+BsvOEtatgqb9UW7B4P1dYbAwuCGZdqV8cHoxolDHuXbsA706xJ7SpF4XVFfx1U4TpDR5RCfrPei0iqvQ/ZTyQ2AK7/+wkWbgjnMNkx/1xRJJMDK+KR9IZah5w9rYk7saZkWpsN7vPhj5YxUh+9/StIRUaSHoA0LZU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319753; c=relaxed/simple;
	bh=1gglt1oQJ1MNnZhWrJGf0VB0kc9/2EXTX9V9hXcUnE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9/3NK2jd+d7jtVs+JXeozgnOpRosrcOYdrK3c2MS75Rm6O+NxrHkV1K93bJW/lDVrqcIwcMQ3UN9oH0FiaVZmjPmV5z3WJxeeERPAtL+jrZx3mIAIG6pEwJ8/mSUaWppZfDPPQHzQjf60jpaKSV5++XgoLvAkUX72bpUR2bDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob6ibY5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0060DC433F1;
	Sun, 24 Mar 2024 22:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319752;
	bh=1gglt1oQJ1MNnZhWrJGf0VB0kc9/2EXTX9V9hXcUnE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ob6ibY5BqtgWhA5XH5PhPGx4WFr3XYY5TmWsmiqirCaBV0Z1DM61ikEi2w7WvrtHt
	 V3SYoSRziLjgevUyMIKn1gI+e/hWlGRLIaaoBwgpZqlwV15QgTZeGAtmAeMRuivMer
	 7kkvbEKh3DJG8oVGjtIx691AL3bJ6nD/u2Tp3XCz5GKtR5w1vC2S0Br+35FZ4bY8RP
	 Pbur+nO6I4eItA2PG2iy3BnN+WcihO7uZ8RXL3426Xz4m2o0nVj9R0g2mTPGLIdW80
	 OdBmD3u8VIhGm75E6hwDxSVXTwKTWa7k6aJivplth5mpTUnzLApV+LUp0VB2QDlZEn
	 4I1C4o0YORNow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 053/715] sched/fair: Take the scheduling domain into account in select_idle_smt()
Date: Sun, 24 Mar 2024 18:23:52 -0400
Message-ID: <20240324223455.1342824-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Keisuke Nishimura <keisuke.nishimura@inria.fr>

[ Upstream commit 8aeaffef8c6eceab0e1498486fdd4f3dc3b7066c ]

When picking a CPU on task wakeup, select_idle_smt() has to take
into account the scheduling domain of @target. This is because the
"isolcpus" kernel command line option can remove CPUs from the domain to
isolate them from other SMT siblings.

This fix checks if the candidate CPU is in the target scheduling domain.

Commit:

  df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated domain")

.. originally introduced this fix by adding the check of the scheduling
domain in the loop.

However, commit:

  3e6efe87cd5cc ("sched/fair: Remove redundant check in select_idle_smt()")

.. accidentally removed the check. Bring it back.

Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240110131707.437301-1-keisuke.nishimura@inria.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a7..66457d4b8965c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7311,13 +7311,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (cpu == target)
 			continue;
+		/*
+		 * Check if the CPU is in the LLC scheduling domain of @target.
+		 * Due to isolcpus, there is no guarantee that all the siblings are in the domain.
+		 */
+		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
@@ -7341,7 +7347,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7591,7 +7597,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.43.0


