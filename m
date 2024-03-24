Return-Path: <linux-kernel+bounces-114092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA38888858
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528101F26CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAF238F36;
	Sun, 24 Mar 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg9PoFm0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEF1E6F7E;
	Sun, 24 Mar 2024 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321389; cv=none; b=HYn6zIMOTl/lsoDxvT1V40FyKWs7z4PRdWUytZSTIA7SOqXrnjmKTq1tT2qDUrxrIh4ta4wHkWmfMjgXe/mfYh//q9ew6dZ3DnP79sp7EJgjQAQVDEmLQvsKNTY7lM/c2GZFbUyt0xxVy1FygjchUOg63hui4GO9smhTUEmQ0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321389; c=relaxed/simple;
	bh=kFJjxiqC/e/Tnxf4UKSvVVOgXrGXwDn98yQoBSlLLL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gotzBAMUdyzasYeYo6HXp2z2ALjTfSu6tOBMD+poODjibwskaDWX/kj89Gx8zscZUT5Qz9xYJU8FL/MSZVJGzxCCgDcSZ5ltYNkmPtbSk3CN7w0Uu2hGB5/YNFUMmo986Od3kymynHwVj4uYSMVWJwu3ErA9eYT2RX43CISHskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg9PoFm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1F6C433F1;
	Sun, 24 Mar 2024 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321388;
	bh=kFJjxiqC/e/Tnxf4UKSvVVOgXrGXwDn98yQoBSlLLL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lg9PoFm01V99AEBoIW7m67DUeeKWq7aPPDlIR9bGuZzLTLw3PjUhPNU84SzZAe6zT
	 dX3ZkHk+22GFi6HP/7IUEAh+FkL13yvvwFE1inCqjwJeCZ4Pm85E9QRGVrzqatnt7q
	 7oDiq/TLmbkivQWjmvLpfRV4tMHxTMWtMHDJOBm1D/Q0O9bZlUxTooXfvg/pKi0Wzv
	 0KCTRFv+oYHFH+OL0a9BIYYMFmWIz6DPObCuj9RKWY649XnhPi+ftjXdH3qEguVUaS
	 FO84tfMi9loruOR2tGQrFxgZKrG0R9s1Fo+xTFoS/Hb6kKKiJxEockdw+VaYLIR0I4
	 bGQv5ed1Y9WCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 112/638] sched/fair: Take the scheduling domain into account in select_idle_core()
Date: Sun, 24 Mar 2024 18:52:29 -0400
Message-ID: <20240324230116.1348576-113-sashal@kernel.org>
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
index fed669ec72bce..69fe62126a28e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7184,7 +7184,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7192,7 +7192,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.43.0


