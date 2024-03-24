Return-Path: <linux-kernel+bounces-116014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D547E8894FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF3E296BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1A17C634;
	Mon, 25 Mar 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKvp1USC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F39219542;
	Sun, 24 Mar 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323350; cv=none; b=st3gsPTb74AiTLGGeEl/NH07NL7TdPSdzZPxtKl/Svus16snX1SKblne9sLBa9p9BfKbkblEJpFj9QJ7dbuaDP51PdnpWmv+TwEu88IxAFP0vGI117qYQW2R2jRFuInxC4e0QbonFLGdqgLO2HkFPuSPDDWr4WTvavxNp0myIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323350; c=relaxed/simple;
	bh=Pym40Mvyrep7NQDgHM/rPOEdnrvgk4WaB7EzFAhrMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIHN/GmjGgOusZ0WGpHyBD1fQjSWJAjO13V9m0PyXnQ87ITFNiue0QzPMkyOpIKb0jW6qSa6MQYqB9sBzjiFudQix9SWtarM7u3o/Q6ESpcznKuRKB5E0KhdptyYwik++k5kqnJaNe3blzXPoHGJWTSMcWJqKYIsM9Rje9jb9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKvp1USC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C7C433C7;
	Sun, 24 Mar 2024 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323349;
	bh=Pym40Mvyrep7NQDgHM/rPOEdnrvgk4WaB7EzFAhrMDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKvp1USCugjwSb5gECxI7l3u3cQIdzqFo/JZ9XDB6AQZHvc55lT0+aYhXUi45ymFW
	 xtNOsa5iqdO93gQ3koE48Ck11jQJf5iRdtqGCSpCPhuxzKZuauY9Sc7lmtoC0Bg6vJ
	 xd9WWTxmnlQXfhf+mm+9QtyYlp3T0V+sPXP5DA74dGJFAHzYQUvlsv4hncJjkRMabF
	 aL9ce+izv/nAqCQmc1WSY2xLDdeP6nY4xuqmZU/CCvm5aj+fdcqJA2v6YUuW56oIfT
	 JnHJqg5qpC7TJ6c12lKr62ohnLAgACW3NTLWc19r0nBrRZjFpnpx8w7jupZ7mHcARk
	 TT8A/y0Pxi5Vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 049/317] sched/fair: Take the scheduling domain into account in select_idle_core()
Date: Sun, 24 Mar 2024 19:30:29 -0400
Message-ID: <20240324233458.1352854-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index b55d51b4105cd..4a1393405a6fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6394,7 +6394,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -6402,7 +6402,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.43.0


