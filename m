Return-Path: <linux-kernel+bounces-26613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95E82E42D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9201C21DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D7637;
	Tue, 16 Jan 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxw/HXk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71A193;
	Tue, 16 Jan 2024 00:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A42C433C7;
	Tue, 16 Jan 2024 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363722;
	bh=XkhCEJwfPjfgpAonk61uf59FuoJ2/3YBNAe7yKZHVUM=;
	h=From:To:Cc:Subject:Date:From;
	b=Mxw/HXk8ODZ4c2rcTcxsb9nACueYeski2Ar+FhJO9mIF32uhcXiW5RDj8hcQWzToe
	 d869/VofoX8h0zW9up86t2yi9dHXH2aSfuV5FogpJ3STWyCtDfwiNAbrzGB4vNnZBf
	 zatTTRN16JSppAwKKDbm+GEDbOHVxvhbNuJJEQSbZa5ZhCkFv7b2Tsw9lSy9iLQHGq
	 yVLD3iQJrnyLnRgdRgZlXBjMrlUv88+ZlfSPw22TIMS7RH/qk1swR4UnmNWxvyL2OV
	 DdeAX2tNpOtyKhSP2JJ8HtRgpX5bzTOMi3SoE9d3B5is/wmD5Nsgd2P5iifernHiD4
	 QU9xd//QlaeAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Raghavendra K T <raghavendra.kt@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mel Gorman <mgorman@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	surenb@google.com,
	mgorman@techsingularity.net,
	jhubbard@nvidia.com,
	Liam.Howlett@oracle.com,
	jgg@ziepe.ca,
	mathieu.desnoyers@efficios.com,
	vishal.moola@gmail.com,
	dhowells@redhat.com,
	sidhartha.kumar@oracle.com
Subject: [PATCH AUTOSEL 6.7 1/8] sched/numa: Fix mm numa_scan_seq based unconditional scan
Date: Mon, 15 Jan 2024 19:08:13 -0500
Message-ID: <20240116000838.212299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Raghavendra K T <raghavendra.kt@amd.com>

[ Upstream commit 84db47ca7146d7bd00eb5cf2b93989a971c84650 ]

Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")

NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
task had previously accessed VMA. However unconditional scan of VMAs are
allowed during initial phase of VMA creation until process's
mm numa_scan_seq reaches 2 even though current task had not accessed VMA.

Rationale:
 - Without initial scan subsequent PTE update may never happen.
 - Give fair opportunity to all the VMAs to be scanned and subsequently
understand the access pattern of all the VMAs.

But it has a corner case where, if a VMA is created after some time,
process's mm numa_scan_seq could be already greater than 2.

For e.g., values of mm numa_scan_seq when VMAs are created by running
mmtest autonuma benchmark briefly looks like:
start_seq=0 : 459
start_seq=2 : 138
start_seq=3 : 144
start_seq=4 : 8
start_seq=8 : 1
start_seq=9 : 1
This results in no unconditional PTE updates for those VMAs created after
some time.

Fix:
 - Note down the initial value of mm numa_scan_seq in per VMA start_seq.
 - Allow unconditional scan till start_seq + 2.

Result:
SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
base kernel: upstream 6.6-rc6 with Mels patches [1] applied.

kernbench
==========		base                  patched %gain
Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*

Duration User       41404.28    41375.08
Duration System      9862.22     9768.48
Duration Elapsed      519.87      518.72

Ops NUMA PTE updates           1041416.00      831536.00
Ops NUMA hint faults            263296.00      220966.00
Ops NUMA pages migrated         258021.00      212769.00
Ops AutoNUMA cost                 1328.67        1114.69

autonumabench

NUMA01_THREADLOCAL
==================
Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*

Duration User       54832.73    47379.67
Duration System        75.00      185.75
Duration Elapsed      576.72      476.09

Ops NUMA PTE updates                  394429.00    11121044.00
Ops NUMA hint faults                    1001.00     8906404.00
Ops NUMA pages migrated                  288.00     2998694.00
Ops AutoNUMA cost                          7.77       44666.84

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm_types.h | 3 +++
 kernel/sched/fair.c      | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..950df415d7de 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -600,6 +600,9 @@ struct vma_numab_state {
 	 */
 	unsigned long pids_active[2];
 
+	/* MM scan sequence ID when scan first started after VMA creation */
+	int start_scan_seq;
+
 	/*
 	 * MM scan sequence ID when the VMA was last completely scanned.
 	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..44b5262b6657 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3164,7 +3164,7 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
 		return true;
 
 	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
@@ -3307,6 +3307,8 @@ static void task_numa_work(struct callback_head *work)
 			if (!vma->numab_state)
 				continue;
 
+			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
+
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 
-- 
2.43.0


