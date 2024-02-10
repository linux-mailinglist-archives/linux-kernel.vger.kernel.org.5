Return-Path: <linux-kernel+bounces-60381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60785043E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF141C228F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9C3D992;
	Sat, 10 Feb 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ6OlXpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840953D986
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564993; cv=none; b=B/N7Zrq5X4AAhwuTBzdAzTWdo1D3Qh0aa8Lvf+FnBsfRXpv5zaBgr0ojNhIqgT7Qv8v397rrZ9l6NYjuNMBSI8Otue55bOyKNy1UciL8ZhLk4GcUQ+UF/xeOQ/8MwFoj7tTjBZPtjbWjc8FHHkNZI2DJZ2Hw3noaMF9PFktEZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564993; c=relaxed/simple;
	bh=oI0X6ZAibKBh5HTxaKZhT4zJgSzw5vMV8hSzj08VmQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MljIxCwWdIusjKQnbocwq8+Azk/AuappisAMGwENgIco5WJZBWW0XlL7mgSWb4bQRoBOJM578sUFYnn10sdAMOMfhvtaSGpUxYM6uR2jb8fYVPidPafQv7dUAhxegUti6C6FNW6USa62ThRdNpVQWkrtiE8zyy8E/KB/ABMFC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ6OlXpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2686BC43390;
	Sat, 10 Feb 2024 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564993;
	bh=oI0X6ZAibKBh5HTxaKZhT4zJgSzw5vMV8hSzj08VmQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQ6OlXpUx1RH+EL7QIe7bhORMXP1+/r/DwxllnGExM2GIlLJJA3sZc8Y5PXdnecxy
	 0n45Wr9DG/EVoCcTi3pAKJm+/kcY4RDp/eG4UweDmfopRofrlFG3yEC1QT++Uz1Qvt
	 kOn5UIaoQupAEm/YHAO60BGMLCn2B6A6tedlPp6vjGyrtUs7qH2VwVfJsEGb+L5KSX
	 z4hWw6RqQYXuvcnGrRU5ics1bDRp0ktQc2NoK1Ox2RV8xsGyi7qh5/uLpjdJoG7+UE
	 1xs5N5Za9YiHRoBnbBoXrrV0nhKZkMNu9v9jVyEFir+rlgl4OCEvDBoaZqtOzVMqJx
	 p8z25ltPnTXhQ==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Alex Shi <alexs@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
Date: Sat, 10 Feb 2024 19:39:22 +0800
Message-ID: <20240210113924.1130448-4-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210113924.1130448-1-alexs@kernel.org>
References: <20240210113924.1130448-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

sched_use_asym_prio() checks whether CPU priorities should be used. It
makes sense to check for the SD_ASYM_PACKING() inside the function.
Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
remove the now superfluous checks for the flag in various places.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 426eda9eda57..cd1ec57c0b7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
+	if (!(sd->flags & SD_ASYM_PACKING))
+		return false;
+
 	if (!sched_smt_active())
 		return true;
 
@@ -9933,11 +9936,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_group_asym(env, sgs, group)) {
+	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
-	}
 
 	/* Check for loaded SMT group to be balanced to dst CPU */
 	if (!local_group && smt_balance(env, sgs, group))
@@ -11033,9 +11034,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * If balancing between cores, let lower priority CPUs help
 		 * SMT cores with more than one busy sibling.
 		 */
-		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym(env->sd, i, env->dst_cpu) &&
-		    nr_running == 1)
+		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
 			continue;
 
 		switch (env->migration_type) {
@@ -11131,8 +11130,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
-- 
2.43.0


