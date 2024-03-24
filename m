Return-Path: <linux-kernel+bounces-115615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5D889CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF26B2C4913
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAE16A9A5;
	Mon, 25 Mar 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrcTduna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BB20012F;
	Sun, 24 Mar 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321387; cv=none; b=d5RhJC4hJdxtaI/6yDPhngwlEEV435dKfRVKbhIfFI5Tu7znYnz3UyizhzDW8jYiRHKXBMqJncdTGYARxMnj1WyBOg60WDtR7XC6bvEivtUKuCceeTX2yaGO/sWsuhgotOUKPgcciZ9s/4Y8DzexfaBAtOIAwtWaWI73tZQOGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321387; c=relaxed/simple;
	bh=Zi18348681HHYzgRbflhzZPKMScdvghDeS/vYLjkrvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwhqSqEY8jt1ptCKuWfAbJ80W+flyTSLooRIf0nRl6mQG1v7N9JdTJo3K5NY0j8E/yctZ0gfLQSNwkA7TyDMQ4rUAeUjdLKUb5urHfLt655gSFIHagIqz/Ari57x5+/P/BaAdAndn36ly3/yPDRP7nGJfcID+aGKhOZKTfKtlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrcTduna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDAFC43399;
	Sun, 24 Mar 2024 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321387;
	bh=Zi18348681HHYzgRbflhzZPKMScdvghDeS/vYLjkrvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrcTdunac0/KjsCMAYzPLa5kDeilJ3ahckO/yrZykdIjq0z/40DyvrM3S/DKpPcJO
	 TFoMrdZbbsFNMRbeWZbzaz5y68+ElDVpTvGikrsQx5g5I1XDFd6dA8XmG14QPiBW9Y
	 74oOA1LnCXzq1K2Mbp2CXJKrkuXn57ZobrFLuFxBDoJ18XJgNZPg3rd1OxqWq4SpUv
	 w/9osB9oHXGPyRFTD8vwbKSz7V7Z3lOl7RYYQArVUzI8OF45mUMh4WGZqUDw+kCSQV
	 dRYtOP5tcf2PcGspnaB1vNiZiKBz6uq91lD/sWm0Z7Cd+RAZL2Q+p4VaAhJnEhpgAt
	 eyM6zuP9Umt2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/638] sched/fair: Take the scheduling domain into account in select_idle_smt()
Date: Sun, 24 Mar 2024 18:52:28 -0400
Message-ID: <20240324230116.1348576-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index d336af9cba134..fed669ec72bce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7206,13 +7206,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -7236,7 +7242,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7498,7 +7504,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.43.0


