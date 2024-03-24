Return-Path: <linux-kernel+bounces-112941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C22887FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DA11C208F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4438005B;
	Sun, 24 Mar 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL8lHQxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E780026;
	Sun, 24 Mar 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319754; cv=none; b=flp4jv9DAlCL2XYwhTU47Pka6XJN3bhDg4UzrxgicmEanOVcZDxa5FyMGwx6M7E4HOCWn52Lu4DpvysWfFY6BJvWKFQLhBXo+jGqpHxNoa0PlX/fgBRKvQwxoHCzXaqJqg8KuiZ6dmrvZXjj+JKbeqij6XCUjHXxm8QZSK/jZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319754; c=relaxed/simple;
	bh=pPJ1TW10UmyE3sNxjNNcrlM7CqVYVT02xmFTk6rywQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK+pD/aXtmPTetdorG93M4sb3EHcLG0b6jbxCEStmjxy/TenHU7Zp49261XMsTcSlq5Ls/Pzqc48XmkLxaOdj65XiMhufW6Gd5eRWtgjIS1YCy5K3NK6/lqOn+Ubf93VuwajUyx8OkEhX7iQJsh1uKaxu+b1iMtcnQ66jrQ9Y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL8lHQxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EB6C43390;
	Sun, 24 Mar 2024 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319753;
	bh=pPJ1TW10UmyE3sNxjNNcrlM7CqVYVT02xmFTk6rywQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL8lHQxUGNnLP+gv4xf9XLv712GDiA4hBrTtvasMBilHBeKJja/NJdLncKp7MUMSA
	 lU4qh3Ks2CIPfQnrDCUGq16eUrAAuF3/z8PuNZHwUXcIjUCWP+oxA6aEbThNQPxBYF
	 W3SNkr0fN9JfilhMGB6uCfQd5XxIpLI001Fas/EgjUJ/K2zgLkDXXEUuAzev/DkqOL
	 U8Jxus9pIVU1AborhMkulbHErnO5FzGylort7eWMmqSITqGPsp9IhdVi7vE1AEOkDE
	 b+sI2b2pJhMyqncEdc7QXFWnSLr7LgUL7utpJZh1CaKdvBQWv65uX7MG3g8v61HMCW
	 85nPucBK0ZRWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Julia Lawall <julia.lawall@inria.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 054/715] sched/fair: Take the scheduling domain into account in select_idle_core()
Date: Sun, 24 Mar 2024 18:23:53 -0400
Message-ID: <20240324223455.1342824-55-sashal@kernel.org>
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
index 66457d4b8965c..e2b4e0396af84 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,7 +7289,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7297,7 +7297,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.43.0


