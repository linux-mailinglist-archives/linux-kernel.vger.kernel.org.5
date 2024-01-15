Return-Path: <linux-kernel+bounces-26091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AD82DB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94671F22911
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD201773F;
	Mon, 15 Jan 2024 14:34:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FF17F3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADF8FEC;
	Mon, 15 Jan 2024 06:35:26 -0800 (PST)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13F2E3F6C4;
	Mon, 15 Jan 2024 06:34:37 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
Date: Mon, 15 Jan 2024 15:34:24 +0100
Message-Id: <20240115143427.1820628-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115143427.1820628-1-pierre.gondois@arm.com>
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup RCU-related spare errors by annotating RCU pointers.

sched_domains_numa_distance:
  error: incompatible types in comparison expression
  (different address spaces):
      int [noderef] __rcu *
      int *

sched_domains_numa_masks:
  error: incompatible types in comparison expression
  (different address spaces):
      struct cpumask **[noderef] __rcu *
      struct cpumask ***

The cast to (void *) adds the following sparse warning:
  warning: cast removes address space '__rcu' of expression
but this should be normal.

Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/topology.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..2a2da9b33e31 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
 static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
-static int			*sched_domains_numa_distance;
-static struct cpumask		***sched_domains_numa_masks;
+static int			__rcu *sched_domains_numa_distance;
+static struct cpumask		** __rcu *sched_domains_numa_masks;
 #endif
 
 /*
@@ -1988,8 +1988,8 @@ void sched_init_numa(int offline_node)
 
 static void sched_reset_numa(void)
 {
-	int nr_levels, *distances;
-	struct cpumask ***masks;
+	int nr_levels, __rcu *distances;
+	struct cpumask ** __rcu *masks;
 
 	nr_levels = sched_domains_numa_levels;
 	sched_domains_numa_levels = 0;
@@ -2003,7 +2003,7 @@ static void sched_reset_numa(void)
 		int i, j;
 
 		synchronize_rcu();
-		kfree(distances);
+		kfree((void *)distances);
 		for (i = 0; i < nr_levels && masks; i++) {
 			if (!masks[i])
 				continue;
@@ -2011,7 +2011,7 @@ static void sched_reset_numa(void)
 				kfree(masks[i][j]);
 			kfree(masks[i]);
 		}
-		kfree(masks);
+		kfree((void *)masks);
 	}
 	if (sched_domain_topology_saved) {
 		kfree(sched_domain_topology);
-- 
2.25.1


