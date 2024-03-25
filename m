Return-Path: <linux-kernel+bounces-116566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E288A0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576ED1C3805E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343991304B3;
	Mon, 25 Mar 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m90WpsWx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034A14F9C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346566; cv=fail; b=hmWgC41WevosmbIlEUhz9bN+TDAzXKbYdp8MAIcp1oWRe1ihJUd8s0yyHU30SP7+1h7xbgMNd50Rbcu2eM3aLEdxO0fA79Vkx1SWY4GirrzCD82pZD1p5yQGam0ksgSsew7E3YxUlEKLQkSG8ykZl14TyRRVP9FWleLe0V82VVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346566; c=relaxed/simple;
	bh=mrO7zEgCqwWwBp09YCei1cpQ+tFiwvOSQciGKjEe0Kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mG8FmgOKLjkTiyjxPTPkrVh9sHnsu3uqWCifCzMoO6g72j9j54ScWs4fq4KE411VAmnGDfroCDADE1xN+zx1pUWeTigOHIGK+EWEiELZ76OcflVFckFrBAoqVI5S/7+rH9pp86K8PpfGKhCb2rqnl6D4AB81nQ3KTTexaS2UHlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m90WpsWx; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNQxg+H9WijXbdLuMd0nkLfgulEtFJvPRrgoM297Zudw/dV7G9xj1xcGmslst3jAB5f3aYNBFpCtyQe9I2tV8Zs3Mk+zZMD71zeFhAY278zavXQNKFGWbLpIDPBOZUM41NvGvACPS8VUNxX0DSDFIn/Oi42upxADdZTBVwpgaoza95U7uEsP9kUnJFaxOXyS6hLrUBZsDWVybj/xCnierkfJQSxuRsClpIZ+3TaV1lGvaajNcWUVbnbOHbXUsbqw+ugkdWbMr/mIxnIzfSxIMvcZsJjwdlGllXVhXOsuFO1T1XedBUssrz+nOuYTLdwiZDpaJm+fmviZbBE4tp67xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+de9s9cSu5Jy17IcMMVkzrU3eMcK5u/9Sc+11Idhl/8=;
 b=U6RuyjLbyxLFjjaaZNu2kjrI8KwiE7607rInrRKsPNSiC/ZfCTNlPRY5OcnGKH0WC2b4lDRQONRoJ5xEehVdbTL+M1QkpRWggPpadr9EUzqjPBNSi1BkK2owcsfmUbBIo6Coei2dHVECBMyib8cFv/oaBr2365PFBmZU8a3+dKtRCCYoUlz3kDqWbizV+KzkxEhKcLBIF4aBu3cs635uP5jxtlCAPlpl8kJaDJmV5VdAbov6cHlXLH5E++8d4vlX+7Ek9LRCGtbFGmBGgkOowrdkDdsXJc86ENU4qbGW/F5S7flbRizCwQSDPReKoCkNgckxW7u2ZjET123W95fVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+de9s9cSu5Jy17IcMMVkzrU3eMcK5u/9Sc+11Idhl/8=;
 b=m90WpsWxygB+YDH7SrcLFbSAMoJRoff9OOH9B4Zbd++rrLMDApQ42mSifqrDdoBMFwICHjg5DHBIwIlitgNerWrESajP0SIuNfsAw2espqEHWPjTyuGRYHE2rw6OMjcWklPwrfU1ilh9gP/UATXoNM3/J7FyLPCQwiEnrZc5WDM=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 06:02:40 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::2d) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 06:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 06:02:39 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 01:02:33 -0500
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
Subject: [RFC PATCH 0/1] sched/eevdf: Curb wakeup preemption further
Date: Mon, 25 Mar 2024 11:32:25 +0530
Message-ID: <20240325060226.1540-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9125c5d3-e2f6-4def-acc3-08dc4c912daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JV4e53TaC5gG5EUNWalLE/PXEg5Zc4jLqQEQWUwSr7eSJg8lZM/mJby9ZIpVp+0MCt0sNTsJuJSY0uwBt01GR026tN0BX35hDXACfzQ2jo+lkXx/TVVtx+y76bfy0Ber0EYLTIIMMwKGjKu0asF8K+3RqEtulfGZ108EqylvL303hi5HKZ8Z5zh3NSVulD3hvOZJHVWvWLbwlQw92uNiddDbm3EpG7lAn7sp6vFSGJolZKGhflWE0GFiDI+U96FhfARTB7u5yztBnz+JPtLXYwm36wmRiHdl6f6XDd6JlLWbiRuhrMlPYxlh1uvJCIBRvDcjesmG9m5TG2fv4/W/LR2jjrP4OvA8M9CzWtZ98BiUnPOIgkFa0H7wtlyiOtEsihjDIWyvyQ36fjqzsXRwqEFxAAmJs+Q5k3JnygsymQF//7YdTfmGCWM4jabf6law0tKNuFA//rqIc5y0ROZQcIIRucwzGmwqPYVMRLd69J6rD6JhcupVJPw3TGUyucQVuOuv1at0AnMXE3gzvLjFISoj5tgi+QH7yYrLXw+sKH/C34zCl9O8hK289IELoO/hPHZU2U04O24YdpjAf9Od5qAwF/wrhbBglEgtL7/jKubTGnXkKUA04+47Ffjm7lVI0poqfF1b8A5WC9my1HJe1VKaTqaZY8cMh0+pUzqPatjA33RYU4t/G0mMBrSjOuXU4+6Fnz62PGbuR4BhmOIEOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 06:02:39.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9125c5d3-e2f6-4def-acc3-08dc4c912daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

Problem Statement
=================

Since EEVDF first landed, DeathStarBench [1] consistently saw a double
digit drop in performance when all the services are running pinned on a
single / multiple CCX(s).

Bisection showed that the regression started at commit 147f3efaa241
("sched/fair: Implement an EEVDF-like scheduling policy") and this was
reported [2]. Further narrowing down than the commit is hard due to the
extent of changes in the commit. EEVDF has seen extensive development
since, but the regression persists.


Narrowing down the problem
==========================

Commit 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling
policy") also added a sched_feat to toggle between EEVDF and legacy CFS.
It was noted that switching to CFS did not completely remedy the
regression. Although some of it could be attributed to the plumbing of
the sched_feat itself, the large enough regression led to audit of the
common path between CFS and EEVDF added since commit 86bfbb7ce4f6
("sched/fair: Add lag based placement"). It was discovered that the
clamping of lag in the offending commit was enough to reproduce the
regression. Specifically, the following change on top of commit
86bfbb7ce4f6 ("sched/fair: Add lag based placement"):

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd12ada69b12..93b5e606e8e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -715,13 +715,20 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->min_vruntime + avg;
 }
 
+static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se);
+
 /*
  * lag_i = S - s_i = w_i * (V - v_i)
  */
 void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	s64 lag, limit;
+
 	SCHED_WARN_ON(!se->on_rq);
-	se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	lag = avg_vruntime(cfs_rq) - se->vruntime;
+
+	limit = calc_delta_fair(max_t(u64, 2 * sysctl_sched_min_granularity, TICK_NSEC), se);
+	se->vlag = clamp(lag, -limit, limit);
 }
 
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
-- 

This turned the attention towards the wakeup path since lag was only
used to determine the vruntime of the entity in place_entity() until
then.


sched-scoreboard analysis
=========================

When analyzing the per-task data from the sched-scoreboard [3], it was
noticed that NGINX server and load-balancer accepting the incoming
requests was being preempted very often. Following are the relative
sched-switch numbers for both algorithms:

				86bfbb7ce4f6 (CFS) 	147f3efaa241 (EEVDF)	%diff
Sum of nr_voluntary_switches		1.00			0.02		-98%
Sum of nr_involuntary_switches		1.00			3.20		220%

Most of the other tasks within the chain of services invoked by the
DeathStarBench workflow saw no significant changes in per-task
statistics except for a drop in number of wakeups proportional to the
drop in the benchmark throughput for the leaf service.

Looking at pick_eevdf() called during wakeup preemption, the eligibility
check for the current entity was identified as the reason for this large
preemption.


Wakeup preemption problem
=========================

With the curr entity's eligibility check, a wakeup preemption is very
likely when an entity with positive lag joins the runqueue pushing the
avg_vruntime of the runqueue backwards, making the vruntime of the
current entity ineligible. This leads to aggressive wakeup preemption
which was previously guarded by wakeup_granularity_ns in legacy CFS.
Below figure depicts one such aggressive preemption scenario with EEVDF:

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
   wakeup |	+--|-----+		|
 preempts \---->| N|ginx | -----------> | {deadline for Nginx}
		+--|-----+  		|
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


Proposed solution
=================

For current running task, skip eligibility check in pick_eevdf() if it
has not exhausted the slice promised to it during selection despite the
situation having changed since. With the proposed solution, the
performance loss seen with the merge of EEVDF goes away. Following are
the results from testing on a Dual Socket 3rd Generation EPYC server
(2 x 64C/128T):

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


Implication
===========

This may lead to newly waking task waiting longer for its turn on the
CPU. However testing on a 3rd Generation Dual Socket EPYC system
(2 x 64C/128T) did not reveal any consistent regressions with the
standard benchmarks:

    ==================================================================
    Test          : hackbench
    Units         : Normalized time in seconds
    Interpretation: Lower is better
    Statistic     : AMean
    ==================================================================
    Case:           tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
     1-groups     1.00 [ -0.00]( 2.08)     0.98 [  2.29]( 3.19)
     2-groups     1.00 [ -0.00]( 0.89)     1.02 [ -2.22]( 1.27)
     4-groups     1.00 [ -0.00]( 0.81)     1.00 [  0.30]( 0.97)
     8-groups     1.00 [ -0.00]( 0.78)     0.97 [  2.62]( 0.80)
    16-groups     1.00 [ -0.00]( 1.60)     0.96 [  3.87]( 2.57)

    ==================================================================
    Test          : tbench
    Units         : Normalized throughput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:    tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
        1     1.00 [  0.00]( 0.71)     1.01 [  1.13]( 0.20)
        2     1.00 [  0.00]( 0.25)     1.00 [ -0.42]( 0.32)
        4     1.00 [  0.00]( 0.85)     1.00 [  0.07]( 0.41)
        8     1.00 [  0.00]( 1.00)     0.99 [ -1.02]( 0.57)
       16     1.00 [  0.00]( 1.25)     0.99 [ -1.13]( 1.90)
       32     1.00 [  0.00]( 0.35)     0.98 [ -1.90]( 2.58)
       64     1.00 [  0.00]( 0.71)     0.98 [ -2.20]( 1.33)
      128     1.00 [  0.00]( 0.46)     0.98 [ -1.94]( 0.42)
      256     1.00 [  0.00]( 0.24)     0.98 [ -2.19]( 0.24)
      512     1.00 [  0.00]( 0.30)     0.99 [ -0.87]( 0.15)
     1024     1.00 [  0.00]( 0.40)     1.00 [ -0.29]( 0.75)

    ==================================================================
    Test          : stream-10
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
     Copy     1.00 [  0.00]( 9.73)     1.01 [  0.53]( 6.33)
    Scale     1.00 [  0.00]( 5.57)     1.00 [ -0.17]( 3.89)
      Add     1.00 [  0.00]( 5.43)     1.00 [  0.48]( 3.63)
    Triad     1.00 [  0.00]( 5.50)     0.98 [ -1.90]( 6.31)

    ==================================================================
    Test          : stream-100
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
     Copy     1.00 [  0.00]( 3.26)     0.99 [ -0.78]( 2.94)
    Scale     1.00 [  0.00]( 1.26)     0.97 [ -2.86]( 6.48)
      Add     1.00 [  0.00]( 1.47)     0.99 [ -1.34]( 4.20)
    Triad     1.00 [  0.00]( 1.77)     1.01 [  0.53]( 2.23)

    ==================================================================
    Test          : netperf
    Units         : Normalized Througput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:         tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
     1-clients     1.00 [  0.00]( 0.22)     1.02 [  2.26]( 1.08)
     2-clients     1.00 [  0.00]( 0.57)     1.02 [  2.02]( 1.03)
     4-clients     1.00 [  0.00]( 0.43)     1.02 [  2.35]( 0.64)
     8-clients     1.00 [  0.00]( 0.27)     1.02 [  2.32]( 0.72)
    16-clients     1.00 [  0.00]( 0.46)     1.02 [  1.55]( 0.73)
    32-clients     1.00 [  0.00]( 0.95)     1.00 [ -0.46]( 1.47)
    64-clients     1.00 [  0.00]( 1.79)     0.97 [ -2.72]( 1.34)
    128-clients    1.00 [  0.00]( 0.89)     1.00 [  0.25]( 0.89)
    256-clients    1.00 [  0.00]( 8.68)     0.95 [ -4.96]( 7.11) *
    512-clients    1.00 [  0.00](35.06)     1.00 [ -0.43](51.55)

    ==================================================================
    Test          : schbench
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)    run-to-parity-wakeup[pct imp](CV)
      1     1.00 [ -0.00](27.28)     0.69 [ 31.25](41.89)
      2     1.00 [ -0.00]( 3.85)     1.00 [ -0.00](11.47)
      4     1.00 [ -0.00](14.00)     1.21 [-21.05]( 7.20) *
      8     1.00 [ -0.00]( 4.68)     1.04 [ -4.17](13.10) *
     16     1.00 [ -0.00]( 4.08)     0.98 [  1.61]( 1.64)
     32     1.00 [ -0.00]( 6.68)     0.94 [  6.12]( 9.27)
     64     1.00 [ -0.00]( 1.79)     0.98 [  1.53]( 2.36)
    128     1.00 [ -0.00]( 6.30)     1.03 [ -3.16]( 8.92) *
    256     1.00 [ -0.00](43.39)     1.36 [-35.94](12.43) *
    512     1.00 [ -0.00]( 2.26)     0.78 [ 22.04]( 1.77)

    ==================================================================
    Test          : SPECjbb (Without any scheduler tunable fiddling) 
    Units         : Throughput
    Interpretation: Lower is better
    Statistic     : Mean
    ==================================================================
    Metric		 tip	run-to-parity-wakeup
    Max-jOPS		1.00	   1.01 (+1.21%)
    Critical-jOPS	1.00	   1.01 (+1.05%)

* Points of large regression also show large run-to-run variance on both
  tip:sched/core and with the proposed solution.


Future work and alternatives
============================

If wakeup latency is indeed a concern, this solution can be paired with
"sched/eevdf: Allow shorter slices to wakeup-preempt" patch from Peter's
EEVDF tree [4] to allow for latency sensitive tasks to preempt the
current running task with "PREEMPT_SHORT" feat superseding
"RUN_TO_PARITY_WAKEUP" decision for such tasks.

If not "RUN_TO_PARITY_WAKEUP" a tunable, similar to
"wakeup_granularity_ns" might need to be re-introduced to curb such
scenarios with EEVDF.

Tobias seems to be dealing with other side of the coin where a newly
woken task is not being scheduled in fast enough on the CPU [5]. It'll
be good to discuss how to keep both sides happy, or discover a middle
ground where both are less unhappy :)


References
==========

[1] https://github.com/delimitrou/DeathStarBench/
[2] https://lore.kernel.org/all/18199afa-16e2-8e76-c96b-9507f92befdc@amd.com/
[3] https://github.com/AMDESE/sched-scoreboard/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=c2594f33fb1e1f4a2a4d962c464cb63a27a8f3d9 (Prone to force-update)
[5] https://lore.kernel.org/lkml/20240228161018.14253-1-huschle@linux.ibm.com/

The patch applies cleanly on tip:sched/core at commit b9e6e2866392
("sched/fair: Fix typos in comments")
---
K Prateek Nayak (1):
  sched/eevdf: Skip eligibility check for current entity during wakeup
    preemption

 kernel/sched/fair.c     | 24 ++++++++++++++++++++----
 kernel/sched/features.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.34.1


