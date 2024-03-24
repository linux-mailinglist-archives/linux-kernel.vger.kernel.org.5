Return-Path: <linux-kernel+bounces-115840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779A88983E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898C41C317CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84737BFAC;
	Mon, 25 Mar 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5t+iOmU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1E145B10;
	Sun, 24 Mar 2024 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322010; cv=none; b=mL42jcKEPZHqm+lGKTBYTHLjo7SQLR0DUaHOAAo6SILfvkCoSylMPtuGK0HzgLPvltxoVc+ZG0tvVsWRfHqFaB+k4+TlOGfFY30s7BWsW6QK58pXAW22xAmvH0IzXPShvbkBwse6DKs/Q8fGcjsMwBTgasbOjwQ73RuNtzUytSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322010; c=relaxed/simple;
	bh=3Le8gboUrS+vnAKEn4w7S6zkTVVMr2DoH01QyYPhozs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPULg/d5Bvb9pYjDYPc/SYlR3ffu3xFqsoHzoGdy+u1MLyS6owJFXsHYXP7VNRp2cLu4OqAoJSs6n9ztj0AovafLQeYPH2Dzl0UgwFr76y/EGJAUbHUKMsEKGuNFZxFgagFwBNsXcV8K3hdKjBf14r3uXyR3stXzxn/0mLfv8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5t+iOmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2D0C43399;
	Sun, 24 Mar 2024 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322010;
	bh=3Le8gboUrS+vnAKEn4w7S6zkTVVMr2DoH01QyYPhozs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5t+iOmUaBpZ5jG7hdDugZ7CdGEJxWwtPcKTK3D0sgcJVeOod3LY5EkJ1yonsjf45
	 gUZnTCnTFtQhIT3qWu37lCqL7QUk/y5OcNCxe2J7h9JzFXh8716KM9cDE32UJuUSuH
	 V6AVEAJyvPRd25acux6NFCawCf5W27u+FN/fLWqBoMvgBp5/v4VaIbkPOgiJK2k7Nz
	 M9GEcNOI0tO2OKiHoNcTmVD7DuN+aA1KHd7TUy8fVKLgQuS8oAz7ONtyVkepPQJWIK
	 HGI6PBkjhnqv/rpO+IGYh+qtYyVIdd4c3HDnYBx8L96NA3IFOPz04vEvbqLg8dZiKl
	 m+4bAOXpoiqbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/451] sched/fair: Take the scheduling domain into account in select_idle_core()
Date: Sun, 24 Mar 2024 19:05:58 -0400
Message-ID: <20240324231207.1351418-83-sashal@kernel.org>
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
index 1c4e54fffb8b6..91c101ecfef9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6656,7 +6656,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -6664,7 +6664,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.43.0


