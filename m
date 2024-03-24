Return-Path: <linux-kernel+bounces-115838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7F8894C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601A71C2D700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012C37BF80;
	Mon, 25 Mar 2024 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnxKTtVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C521448C9;
	Sun, 24 Mar 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322009; cv=none; b=cO6eURhCJuC+hSlriQc3Xq7grt/VzRC31tmAKb2NvUqa7n91/sgvRR0p1u2bR9hjYg0v3GaxyI5M4hwDKdRMlmM+HF9JqLtiblB4DJA3bRsn1h8MCyOaTLuuCTRi1hfjWcmfhE690H5scQPvaopJUG15KYQqIgQn2QEDy1WVacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322009; c=relaxed/simple;
	bh=TKCgqMi4JKjK1DRtsQX7URt7rxVjhX1KP57kx5DM9Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK1QbA9WPryQqoMfRAz7jIRF0sL5j9Up2bx1n760wmDvja5gkYTpZNWogStN3tCJmQT8JbOivFoiL8/SFhPxgyBDlW0zjN21yTL+P2jRWAOvFE6lyEdmn586ixXpAQvQdao9fXsPxoj8+waGZzm8QAefKJWiyk5gkkI4IN2R4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnxKTtVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B844C433C7;
	Sun, 24 Mar 2024 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322009;
	bh=TKCgqMi4JKjK1DRtsQX7URt7rxVjhX1KP57kx5DM9Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnxKTtVyRI5f0TtKIzQeUFBhqqJqm7I1PWle5NrO9Jzjb4/1Fb3rjrvwg4nVJ7dY8
	 66yQ0y9ZsbPWULuMcxLKeaqE0U7lWwF13AW4VAcjfq79qR0Rf01ZeYz8cXGP4rnWRQ
	 6HSg9ikg4lADisAlqCAwZRlq8aSxAOVVaVhIxIdSMknLSuTncQQSarWqZ6s2nTe9Do
	 YHlMrAFhRJbDnyDRq/n6h2RmmVhzAyiP6NfpC2TzJG2mz1QHqKWp14EmUW+ibqghqU
	 hmHP5KkkHrkPu2VuHYnOaMV4cW6gOgI9QfcKbb7tOQiHzcZutsoVKCRBWkuRo1NJGn
	 8Ut/hDpz9tBMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/451] sched/fair: Take the scheduling domain into account in select_idle_smt()
Date: Sun, 24 Mar 2024 19:05:57 -0400
Message-ID: <20240324231207.1351418-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 2558ab9033bee..1c4e54fffb8b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6678,13 +6678,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -6708,7 +6714,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -6970,7 +6976,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.43.0


