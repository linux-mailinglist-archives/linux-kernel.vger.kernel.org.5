Return-Path: <linux-kernel+bounces-116567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE988A283
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6195B655A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F6130A4B;
	Mon, 25 Mar 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2Y+lL6Y"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D914F9DA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346592; cv=fail; b=urIqpOP01iHbiwVIaYyYl2nY5uhfNSpX/Fstuy0itjSa31iQl9rxfvUoHxbr9PLVn7H4izd0/zIrGmWyx6tEmTTozm/JyqPQHaK2C9cHhMHiqnIdQIFoDF6MTmbNZYMXhA8opau/nSB08WJ3cbHzkJ04J+QDS97HgKTXbecC8fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346592; c=relaxed/simple;
	bh=KppJr2cFPnpDKrHgeJ3BJFqUIF78sDWVBLdPhbVUJw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkA2M6qerbbQ1IkHZyZT6EMEAgdmDm8NkHlUSczWDsDNtDbNzp3awZvBZtTwBY6FzWnNjNhKsLZe9kuAkxnQ0TtqJnic6QdZTU7DJzI3cDMgUE/OxCU13vd1XYSg87L976T3yT4PV4/C/XgvXw85mL5Ay+IA2/akE1qhRpy5RfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2Y+lL6Y; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+1KJ+JEq3eddfGaMFXteHm1qUx262/C66ttJokYDr/usO/VIgP+IBvODSWMp8/wU8ylbMb8SgKFNfk6RAZAnjZdiHRcfuW2VdVmDDnuluq+yQa4UReUmzKuMm2ShaBEr6xOB+eJNbUzO41Vnnp86zHfLEMpcwgLmb+PnZWlSTsfW5oec3Da/pUf5xw3zSKvKE5X6AkOKBaNa6inhg7Vaa1e2s5NcPEDo+HmXsM7SR8KPGHMtVb7UHPMMqU3hCowQniutkm4NHWrXVTj06wFfHHYAEuarWDccTdK0SJrw0l8+9cVUJ5P6Rj1Dh7N10VvPdEQKmzx/Tral/cfhLZKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+BjYygwpm4SowN6ieUl25I5iLteAS3WhB9SLrPo4pA=;
 b=QH9xQ03QZYxS3hTvFm0hsxTMini9Jul8gLtHVnDMBimVMkcxdLAfNZq1AmGJMhOK9/ryyf53/ngIQ95oqKLbMtlgg2l/mLj5jtHsiQzQzRWmG+aezIHbV9C9VD9sEmrpNZ6Av4mQllkjwMbLy5RjlKDOac5Tx2dhTfUhiRIBI/sweUJUXBXjpsuVO9+FsmjP4n3N8A/6Sgb2sVfunpoZqJ+gPA/y/iiQXDpM/n/ARevOu2kMUHP4yD1gDt0jns3QyhMTpRaQDk5exr+d36aeOa6RshWCSmMfuOyFWXiJGT/oAyRENe0tLpoYpn8mmCby03NhP9l9Zlw0EbkVOhagnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+BjYygwpm4SowN6ieUl25I5iLteAS3WhB9SLrPo4pA=;
 b=h2Y+lL6Y/k3LfKp+rB/+WPt+Y23zIYWrFVOmjxN8L8sc+paU2i/7LTk/hanwvhAhBAeyN4qxBcHSRllOdUIDy8XgRYQQ3MIJCmrRTiFKA3cUbdm4O+A58VmQmNFaUEMUA3aWh5rHmMTfDOncmz2wguyI/Sx+LDClnCUPdj2yJJw=
Received: from SJ0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:a03:33e::17)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 06:03:07 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::51) by SJ0PR03CA0042.outlook.office365.com
 (2603:10b6:a03:33e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 06:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 06:03:06 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 01:02:57 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, "Tobias
 Huschle" <huschle@linux.ibm.com>, Luis Machado <luis.machado@arm.com>, Chen
 Yu <yu.c.chen@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, Tianchen Ding
	<dtcccc@linux.alibaba.com>, Youssef Esmat <youssefesmat@chromium.org>,
	"Xuewen Yan" <xuewen.yan94@gmail.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current entity during wakeup preemption
Date: Mon, 25 Mar 2024 11:32:26 +0530
Message-ID: <20240325060226.1540-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325060226.1540-1-kprateek.nayak@amd.com>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d9d9c7-f668-4cf7-444e-08dc4c913dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G9ZQY6+pelqMVSCfL6KM5OT7OhIZvZhHECpSRGhOcJtCoSOQLfHg+y69JNpYsz2E6xVopEeqeDv6z0iPrAToLNJ9+9B7f3kRpPR7nnkLX7WPRYjEWwsNkVpZQepu9q6ebqX9FO/hy85bCWb8ku7O+UGfOrOn+vY/Nr2n8XclufdDFoZIUkjShBiM6F/h95YBS1yzLMDELJn/LzlkFoHdf2zQMV5MtiEbnYeKtUrBUV8UnXKI8pOgf+xFcRY//yz2YQA9m623Jx4hTJ7P0FBODHrph31qTBljf0708EUmoFfCIaEdt8drWpkXt0yr56ExxrFJH7blekGb8lPlm89ZrQk/OHa0nG8qamaF1MPQTq620nPiFHOxXPbDoCm0/iTmSYu2i77aR0xz2ytiE0ou3AQsk7+rcHqgR5LFP4DHHjAXn4YWLhCX1hN6fXHIUUu8FEfk8p9eYqpJvgv0nvd3n17RT2tCvuXOL/6UuCCQPh2pxQkZ/M+YkH+ytDQN6tUFtoA49VyywYKlHpKSgWwLvQ5A0PgWgblHdr7fFJx2RHXF0lUnfZN9Uab1ULs2ZuFapO9h2kBy+WHhmEQmlGFt8IarJ3OFBu66iwgH7UUnG8wkO+XshwVPwjRCSH71GtRPTuqLloQ/+V/QiXS76jhvFWbtnWm4HdeudxZjTe2BFGOm3rn0PST4bFZJUGQyu29xrh+Y880AAeRVJIlaG0pL/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 06:03:06.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d9d9c7-f668-4cf7-444e-08dc4c913dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

With the curr entity's eligibility check, a wakeup preemption is very
likely when an entity with positive lag joins the runqueue pushing the
avg_vruntime of the runqueue backwards, making the vruntime of the
current entity ineligible. This leads to aggressive wakeup preemption
which was previously guarded by wakeup_granularity_ns in legacy CFS.
Below figure depicts one such aggressive preemption scenario with EEVDF
in DeathStarBench [1]:

				deadline for Nginx
		   |
	+-------+  |			|
    /-- | Nginx | -|------------------> |
    |	+-------+  |			|
    |		   |
    |	-----------|-------------------------------> vruntime timeline
    |		   \--> rq->avg_vruntime
    |
    | 	wakes service on the same runqueue since system is busy
    |
    |	+---------+|
    \-->| Service || (service has +ve lag pushes avg_vruntime backwards)
	+---------+|
	  |	   |
   wakeup |	+--|-----+			 |
 preempts \---->| N|ginx | --------------------> | {deadline for Nginx}
		+--|-----+  			 |
	   (Nginx ineligible)
	-----------|-------------------------------> vruntime timeline
		   \--> rq->avg_vruntime

When NGINX server is involuntarily switched out, it cannot accept any
incoming request, leading to longer turn around time for the clients and
thus loss in DeathStarBench throughput.

    ==================================================================
    Test          : DeathStarBench
    Units         : Normalized latency
    Interpretation: Lower is better
    Statistic     : Mean
    ==================================================================
    tip		1.00
    eevdf	1.14 (+14.61%)

For current running task, skip eligibility check in pick_eevdf() if it
has not exhausted the slice promised to it during selection despite the
situation having changed since. The behavior is guarded by
RUN_TO_PARITY_WAKEUP sched_feat to simplify testing. With
RUN_TO_PARITY_WAKEUP enabled, performance loss seen with DeathStarBench
since the merge of EEVDF disappears. Following are the results from
testing on a Dual Socket 3rd Generation EPYC server (2 x 64C/128T):

    ==================================================================
    Test          : DeathStarBench
    Units         : Normalized throughput
    Interpretation: Higher is better
    Statistic     : Mean
    ==================================================================
    Pinning      scaling     tip            run-to-parity-wakeup(pct imp)
     1CCD           1       1.00            1.16 (%diff: 16%)
     2CCD           2       1.00            1.03 (%diff: 3%)
     4CCD           4       1.00            1.12 (%diff: 12%)
     8CCD           8       1.00            1.05 (%diff: 6%)

With spec_rstack_overflow=off, the DeathStarBench performance with the
proposed solution is same as the performance on v6.5 release before
EEVDF was merged.

This may lead to newly waking task waiting longer for its turn on the
CPU, however, testing on the same system did not reveal any consistent
regressions with the standard benchmarks.

Link: https://github.com/delimitrou/DeathStarBench/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c     | 24 ++++++++++++++++++++----
 kernel/sched/features.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..a9b145a4eab0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -875,7 +875,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool wakeup_preempt)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
@@ -889,7 +889,23 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_running == 1)
 		return curr && curr->on_rq ? curr : se;
 
-	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+	if (curr && !curr->on_rq)
+		curr = NULL;
+
+	/*
+	 * When an entity with positive lag wakes up, it pushes the
+	 * avg_vruntime of the runqueue backwards. This may causes the
+	 * current entity to be ineligible soon into its run leading to
+	 * wakeup preemption.
+	 *
+	 * To prevent such aggressive preemption of the current running
+	 * entity during task wakeups, skip the eligibility check if the
+	 * slice promised to the entity since its selection has not yet
+	 * elapsed.
+	 */
+	if (curr &&
+	    !(sched_feat(RUN_TO_PARITY_WAKEUP) && wakeup_preempt && curr->vlag == curr->deadline) &&
+	    !entity_eligible(cfs_rq, curr))
 		curr = NULL;
 
 	/*
@@ -5460,7 +5476,7 @@ pick_next_entity(struct cfs_rq *cfs_rq)
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
 		return cfs_rq->next;
 
-	return pick_eevdf(cfs_rq);
+	return pick_eevdf(cfs_rq, false);
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -8340,7 +8356,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (pick_eevdf(cfs_rq, true) == pse)
 		goto preempt;
 
 	return;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..027bab5b4031 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(RUN_TO_PARITY, true)
+SCHED_FEAT(RUN_TO_PARITY_WAKEUP, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
-- 
2.34.1


