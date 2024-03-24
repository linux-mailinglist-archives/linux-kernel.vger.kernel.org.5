Return-Path: <linux-kernel+bounces-113659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BF888E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7F1C2AE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D61DC802;
	Sun, 24 Mar 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAWfCVwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4E1D5F74;
	Sun, 24 Mar 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320570; cv=none; b=hebIVTDCVNo6zvtv3hRGyS0sykukkq+TxHCvk7NnkvgfqXBgvcYi+goPGNFrxBUUuWS+3JxLEj728XUt7p1dwrSq7lVOYgZIdF1Z9opZlvSfQ99VwFZFSX+njSmEvPI5x3qlCX6PPpXRKkrbDpXEY4+V0Y0Uc+AGmFKS6BVvGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320570; c=relaxed/simple;
	bh=bNg6LzGgXvZgGySCXYzXDG3E4aRuskSPGtJL92Jmy/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT4W4WUht/htYPdI3+vL7i0sBxZNahh09oUsB474R2cGh+3kqKcBZcD54tYz50N233ceby26SQOfJIIfalMPed4OribTgNY/8Qep4ZKTTo0NGwzS+pKu0jAdOwFi+UB4ENpucUHQIeOvAjWI+5un0N2fUYjYzNneXewKmvJNC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAWfCVwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6A6C433F1;
	Sun, 24 Mar 2024 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320569;
	bh=bNg6LzGgXvZgGySCXYzXDG3E4aRuskSPGtJL92Jmy/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAWfCVwn4lDQbwXP44qD7c+SR9euUfsKo9aiE039Fxf3Eqw3syOLewLJMNh2upGf9
	 4KgVCXvV+MUfFuP3AspJeXvCBGeKQtDTBA1uH33RO8PmHdkkOD/Wm6L9JlgD/gI2yl
	 qUJ+O5hYUmV+IQsWOjqKFgSrJpLSdYGYZLTsy8cmfRGXwdQXAVxvWZYGYpASB1nFPk
	 X+Z/78+vKnGuNCw7utBGSDhONvA7f70W80oLr1iQdneW2WEwIlQrr7kt4MV3G978Q8
	 LuWYTtg0WxQHCnwykZuggle8oK0vCrDlesDm+aS6RBbvEMvhxtIQvwvGnH5iD4J2Z0
	 GVw0cHYzlHa5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 130/713] sched/fair: Take the scheduling domain into account in select_idle_core()
Date: Sun, 24 Mar 2024 18:37:36 -0400
Message-ID: <20240324224720.1345309-131-sashal@kernel.org>
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

[ Upstream commit 23d04d8c6b8ec339057264659b7834027f3e6a63 ]

When picking a CPU on task wakeup, select_idle_core() has to take
into account the scheduling domain where the function looks for the CPU.

This is because the "isolcpus" kernel command line option can remove CPUs
from the domain to isolate them from other SMT siblings.

This change replaces the set of CPUs allowed to run the task from
p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
which is stored in the 'cpus' argument provided by select_idle_cpu().

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240110131707.437301-2-keisuke.nishimura@inria.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 68bd1102133ef..c43b71792a8e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7296,7 +7296,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7304,7 +7304,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.43.0


