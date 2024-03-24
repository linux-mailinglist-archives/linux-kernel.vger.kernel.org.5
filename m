Return-Path: <linux-kernel+bounces-113657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E7888F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C75AB20951
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F41DBF56;
	Sun, 24 Mar 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkev0qVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636F1D5F65;
	Sun, 24 Mar 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320569; cv=none; b=NX3d6KlwZVYqNqlSsjd2G/DSzDEMNh5spxI+smeLK0ge52URCP2KnIH+wPMUhfORTv33+AcB8WRrEBSuX/zq0sprcpy5uoIv9vigoMUdfG2N3jjqyAKvD+KbXNAbseXzVld2hOcfVxqgKlfffPahWlm2aDF0TyiVCfNhos+nt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320569; c=relaxed/simple;
	bh=+5YPbWjlptl8hmfAMIJeiodU22MkYKtuc8lSZTYliSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te2E2/ZYuuYf5Ob8TTd5sXBCNhJU4JsCcrcqt2eyx3dvw3pRu/YMVoNF28atg986LpX6a5sNB68yoigsAHlfia7MSBD7qJCn1u/t5Vw+1edcmMrL9s0BcRFLesEcwh8NYM7xt8kNzG4+7nKeKjqXfbiYNKWuRbxo46bqF7B+C4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkev0qVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F513C433C7;
	Sun, 24 Mar 2024 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320568;
	bh=+5YPbWjlptl8hmfAMIJeiodU22MkYKtuc8lSZTYliSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rkev0qVkQ79UVnVS6CdX6SQKNPinMtq8j7FpCq3RA+x9ApJWXkrKx+YH75Ygj+JBC
	 inWBA2+UQ51KddxQ94VYj8UNnvYnh/YxY1TfmP+76dFEfX70BJB8WD+aHz3jTRvs6A
	 eFAJnQbaB3Typx4dZwgCbQbZKPN3OTRb1Gl31MDhB2e064hipemQMUBtXlWynyAicZ
	 0RS+qoSLjFO5eAxBXDis7IMcL7bnzCr6AD1xHbIahPEfJaMBROCJAqyxgsH0TeXeHb
	 VM1NNHzvOBDhKCNwq454qlm0nbh+CbA/4OO+YLbWu0OWZF+jphgY4wkJrrE+3nzIQr
	 ejg2l4onA+HyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 129/713] sched/fair: Take the scheduling domain into account in select_idle_smt()
Date: Sun, 24 Mar 2024 18:37:35 -0400
Message-ID: <20240324224720.1345309-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 7ac9f4b1d955c..68bd1102133ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7318,13 +7318,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -7348,7 +7354,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7598,7 +7604,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.43.0


