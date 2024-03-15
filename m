Return-Path: <linux-kernel+bounces-104473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379587CE67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AB52830D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9669376F3;
	Fri, 15 Mar 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9+yFVO3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE80374EC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510952; cv=fail; b=T73i2QkOScOT3NFvlbm7xKGWQ5oXzHVFy2KRfiXrLeNUmB1IJNjfuNWpOSOJTZiduwc4HizTHHXfAN4qAMBkiXMGQLvlgKpqbovbrdbcv3dP00wJaaGr1EoS1Gha/aRYJlL5ERw8gJva9JxVibTnK8/HAMqyQkEmDQgl9yCsAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510952; c=relaxed/simple;
	bh=UglrVFlVX/K4jy8OxNXTgw5pLYTm4EunzUjiFHsRVA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJFynRZouCkH0Ki7d1i6jAEVCWwgEhv0P60taZqIu+g3N/+w35qLBC4Rhm3/qX34ElMkuoSKwJMYR7/uigozuRn80de7+R9/Wyc13fueTifxDup32QffvZ3XnSgaK4wVAFRMYshIJAwfwZW3urVwqGZEzmfqgxGszpqJnzcqsfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9+yFVO3; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfU62yAvAvPWFuQO0g1Y26f0MM+gFMEkCJ/diDL25+vKSOdSC8AqIaLkeKvvqeBolAjlGXxtoQ8bFXm/ynM7QVoJQ98XL0ogbcej+tAIEzJDf4zOoJHAowmkZFUQiygeCILGWqGnMHVQFwrofAbZupNxUHJuysKGhNS+vPRvWOlHfzoYbbNSHjgThT9xxuGltK3qL7dDDm+/faYrsD1yS7TGE+AkP70Z/i4s+/Ej2m4jXUwijCPyREjpTwjZog7P4zGzWUrj5w3DTbkZq6Ko3/OoJbJ6yuGHCGaWCzC96CR4n7w6B3fWGXCXUQXK9OojnntzOgbQ9xV0WHysMkefRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pT/yaAecMRzKGdqSGzN009u2s6thc5PMJCKktkkzzw=;
 b=g73czbqX7WcpIWimhRTqj5vxx4MhBVI5TMzzuJuWI5qnVYIQKt9N/jeHpHlurfMsq7eeiSbMGqXo2ao2aVJVg4KAoiXxywKT5GmfURvUT8F8128J6SlN1+2LD5pqhhZrS+HRVTnuNUmEhe2sIA1GEpFzG2DCsr1w8SZd/HFtO4lzL0hYxrwUJvZ3atuUfLoCXpyTzSD9suGYOAtap7l17bnESRV3UYSZ4iYtPqw9uUb0yXn2osNOFsu7TSkb+++jse9gwi4wzU4a//YElDk56jzAiaosnasaLKxtNTskrsawD/UcbmczM8Mf7KCKBdDybCi5winOvfW+3QTm3ZjQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pT/yaAecMRzKGdqSGzN009u2s6thc5PMJCKktkkzzw=;
 b=w9+yFVO3N5Y2UHJRRKNbMB5KJ4Gx4Qa3z7QdWz0shMpmpaXYPyl5NFAmHP0J0y2q6dFcGjwwHhbONIz+V4d8TVKAdKeH5uKo6T3UvTa7RLiisduJmYHf/Isd2kE++vj5bdCYPg2TRHCCvf6baepRgMNoUxT0G4nJ7yuW33vH+mw=
Received: from BN9PR03CA0865.namprd03.prod.outlook.com (2603:10b6:408:13d::30)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 13:55:47 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::97) by BN9PR03CA0865.outlook.office365.com
 (2603:10b6:408:13d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Fri, 15 Mar 2024 13:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 13:55:47 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 08:55:46 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
Subject: [PATCH v2 1/1] sched: Report the different kinds of imbalances in /proc/schedstat
Date: Fri, 15 Mar 2024 13:55:01 +0000
Message-ID: <20240315135501.1778620-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315135501.1778620-1-swapnil.sapkal@amd.com>
References: <20240315135501.1778620-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ac2236-ad6f-4a7c-20e9-08dc44f79db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+x0H1RqEIVxgtVU718QEWgVMqlDxGHjWKo2u09OiEjUVx+2dASxDHsTGAxwWMdUq8tJWsQXPlvseIUamlO2+PSLPX5y+mYZyudiMDDVvVBu5d4AfnZ0pfeRsUU+KadG6SY8tjAPLurJ6trvEDbsv4i8BCUVIOnKUiIm7g18Ui3E5V77URdLTohbemDGuOkDBHONaA9DtMaZe0lcVzUSluaER8secCooixsfA7q3Kb6mj/8VegJZBHiePxg1awQN1S6fipAQzjTNqBOuVckh8Ssk2PrdXXfazvLLXTo5ucVMezNnOu8J/zFqyEow+MkxXJrBo00BSfyFSsnQXS17sb4w9soDUJJ6qH0xmcunHw6mNd3eDQVXc9p4tSiXFP5dZS57AHjmB0jlQC8nV9KdybVgSlbjl8qVne17ZXSUb/F3mfHBngqrvm4uJEClFK08yiCGzyJeabX2laVbkehHJtbD3o5UVt8r5O33naxbyFhrhj7wpGhf3nB8PgBbTZKjiG+DiKU1NuGZuPpzlxw0Jnv2N9nyyjIYu8FxUp25bo2mn4VwyjtPRP4blaANbuk+gGVg/y2P4TzlWjTaok78eqbBok4xfCsn7D23q280VZtSh31goLPB3Jo3MDyQyEzo49xwn6eY3ux1hYdmiX7PoYHA15ge/Bmtl+s1Bxq+c9drv9y/0+HbcyHufDmXrfvEzQyKKrQ0p4Tu6nmBm3cbMEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:55:47.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ac2236-ad6f-4a7c-20e9-08dc44f79db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

In /proc/schedstat, lb_imbalance reports the sum of imbalances
discovered in sched domains with each call to sched_balance_rq(), which is
not very useful because lb_imbalance does not mention whether the imbalance
is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
from /proc/schedstat.

Currently there is no field in /proc/schedstat to report different types
of imbalances. Introduce new fields in /proc/schedstat to report the
total imbalances in load, utilization, nr_tasks or misfit_tasks.

Added fields to /proc/schedstat:
 	- lb_imbalance_load: Total imbalance due to load.
	- lb_imbalance_util: Total imbalance due to utilization.
	- lb_imbalance_task: Total imbalance due to number of tasks.
	- lb_imbalance_misfit: Total imbalance due to misfit tasks.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 Documentation/scheduler/sched-stats.rst | 119 ++++++++++++++----------
 include/linux/sched/topology.h          |   5 +-
 kernel/sched/fair.c                     |  21 ++++-
 kernel/sched/stats.c                    |   7 +-
 4 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c4729d..e2a6b53a38ee 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -6,10 +6,15 @@ Version 16 of schedstats changed the order of definitions within
 'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
 columns in show_schedstat(). In particular the position of CPU_IDLE
 and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
+Also stop reporting 'lb_imbalance' as it has no significance anymore
+and instead add more relevant fields namely 'lb_imbalance_load',
+'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
 
 Version 15 of schedstats dropped counters for some sched_yield:
 yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
-identical to version 14.
+identical to version 14. Details are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-stats.txt?id=1e1dbb259c79b
 
 Version 14 of schedstats includes support for sched_domains, which hit the
 mainline kernel in 2.6.20 although it is identical to the stats from version
@@ -26,7 +31,14 @@ cpus on the machine, while domain0 is the most tightly focused domain,
 sometimes balancing only between pairs of cpus.  At this time, there
 are no architectures which need more than three domain levels. The first
 field in the domain stats is a bit map indicating which cpus are affected
-by that domain.
+by that domain. Details are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sched-stats.txt?id=b762f3ffb797c
+
+The schedstat documentation is maintained version 10 onwards and is not
+updated for version 11 and 12. The details for version 10 are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sched-stats.txt?id=1da177e4c3f4
 
 These fields are counters, and only increment.  Programs which make use
 of these will need to start with a baseline observation and then calculate
@@ -73,86 +85,93 @@ One of these is produced per domain for each cpu described. (Note that if
 CONFIG_SMP is not defined, *no* domains are utilized and these lines
 will not appear in the output.)
 
-domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
+domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
 
 The first field is a bit mask indicating what cpus this domain operates over.
 
-The next 24 are a variety of sched_balance_rq() statistics in grouped into types
-of idleness (idle, busy, and newly idle):
+The next 33 are a variety of sched_balance_rq() statistics in grouped into types
+of idleness (busy, idle and newly idle):
 
     1)  # of times in this domain sched_balance_rq() was called when the
+        cpu was busy
+    2)  # of times in this domain sched_balance_rq() checked but found the
+        load did not require balancing when busy
+    3)  # of times in this domain sched_balance_rq() tried to move one or
+        more tasks and failed, when the cpu was busy
+    4)  Total imbalance in load when the cpu was busy
+    5)  Total imbalance in utilization when the cpu was busy
+    6)  Total imbalance in number of tasks when the cpu was busy
+    7)  Total imbalance due to misfit tasks when the cpu was busy
+    8)  # of times in this domain pull_task() was called when busy
+    9)  # of times in this domain pull_task() was called even though the
+        target task was cache-hot when busy
+    10) # of times in this domain sched_balance_rq() was called but did not
+        find a busier queue while the cpu was busy
+    11) # of times in this domain a busier queue was found while the cpu
+        was busy but no busier group was found
+
+    12) # of times in this domain sched_balance_rq() was called when the
         cpu was idle
-    2)  # of times in this domain sched_balance_rq() checked but found
+    13) # of times in this domain sched_balance_rq() checked but found
         the load did not require balancing when the cpu was idle
-    3)  # of times in this domain sched_balance_rq() tried to move one or
+    14) # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was idle
-    4)  sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was idle
-    5)  # of times in this domain pull_task() was called when the cpu
+    15) Total imbalance in load when the cpu was idle
+    16) Total imbalance in utilization when the cpu was idle
+    17) Total imbalance in number of tasks when the cpu was idle
+    18) Total imbalance due to misfit tasks when the cpu was idle
+    19) # of times in this domain pull_task() was called when the cpu
         was idle
-    6)  # of times in this domain pull_task() was called even though
+    20) # of times in this domain pull_task() was called even though
         the target task was cache-hot when idle
-    7)  # of times in this domain sched_balance_rq() was called but did
+    21) # of times in this domain sched_balance_rq() was called but did
         not find a busier queue while the cpu was idle
-    8)  # of times in this domain a busier queue was found while the
+    22) # of times in this domain a busier queue was found while the
         cpu was idle but no busier group was found
-    9)  # of times in this domain sched_balance_rq() was called when the
-        cpu was busy
-    10) # of times in this domain sched_balance_rq() checked but found the
-        load did not require balancing when busy
-    11) # of times in this domain sched_balance_rq() tried to move one or
-        more tasks and failed, when the cpu was busy
-    12) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was busy
-    13) # of times in this domain pull_task() was called when busy
-    14) # of times in this domain pull_task() was called even though the
-        target task was cache-hot when busy
-    15) # of times in this domain sched_balance_rq() was called but did not
-        find a busier queue while the cpu was busy
-    16) # of times in this domain a busier queue was found while the cpu
-        was busy but no busier group was found
 
-    17) # of times in this domain sched_balance_rq() was called when the
-        cpu was just becoming idle
-    18) # of times in this domain sched_balance_rq() checked but found the
+    23) # of times in this domain sched_balance_rq() was called when the
+        was just becoming idle
+    24) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when the cpu was just becoming idle
-    19) # of times in this domain sched_balance_rq() tried to move one or more
+    25) # of times in this domain sched_balance_rq() tried to move one or more
         tasks and failed, when the cpu was just becoming idle
-    20) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was just becoming idle
-    21) # of times in this domain pull_task() was called when newly idle
-    22) # of times in this domain pull_task() was called even though the
+    26) Total imbalance in load when the cpu was just becoming idle
+    27) Total imbalance in utilization when the cpu was just becoming idle
+    28) Total imbalance in number of tasks when the cpu was just becoming idle
+    29) Total imbalance due to misfit tasks when the cpu was just becoming idle
+    30) # of times in this domain pull_task() was called when newly idle
+    31) # of times in this domain pull_task() was called even though the
         target task was cache-hot when just becoming idle
-    23) # of times in this domain sched_balance_rq() was called but did not
+    32) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was just becoming idle
-    24) # of times in this domain a busier queue was found while the cpu
+    33) # of times in this domain a busier queue was found while the cpu
         was just becoming idle but no busier group was found
 
    Next three are active_load_balance() statistics:
 
-    25) # of times active_load_balance() was called
-    26) # of times active_load_balance() tried to move a task and failed
-    27) # of times active_load_balance() successfully moved a task
+    34) # of times active_load_balance() was called
+    35) # of times active_load_balance() tried to move a task and failed
+    36) # of times active_load_balance() successfully moved a task
 
    Next three are sched_balance_exec() statistics:
 
-    28) sbe_cnt is not used
-    29) sbe_balanced is not used
-    30) sbe_pushed is not used
+    37) sbe_cnt is not used
+    38) sbe_balanced is not used
+    39) sbe_pushed is not used
 
    Next three are sched_balance_fork() statistics:
 
-    31) sbf_cnt is not used
-    32) sbf_balanced is not used
-    33) sbf_pushed is not used
+    40) sbf_cnt is not used
+    41) sbf_balanced is not used
+    42) sbf_pushed is not used
 
    Next three are try_to_wake_up() statistics:
 
-    34) # of times in this domain try_to_wake_up() awoke a task that
+    43) # of times in this domain try_to_wake_up() awoke a task that
         last ran on a different cpu in this domain
-    35) # of times in this domain try_to_wake_up() moved a task to the
+    44) # of times in this domain try_to_wake_up() moved a task to the
         waking cpu because it was cache-cold on its own cpu anyway
-    36) # of times in this domain try_to_wake_up() started passive balancing
+    45) # of times in this domain try_to_wake_up() started passive balancing
 
 /proc/<pid>/schedstat
 ---------------------
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c8fe9bab981b..15685c40a713 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -114,7 +114,10 @@ struct sched_domain {
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
-	unsigned int lb_imbalance[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_load[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_util[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_task[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_misfit[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a19ea290b790..31077a702e78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11238,6 +11238,25 @@ static int should_we_balance(struct lb_env *env)
 	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
+static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd,
+				     enum cpu_idle_type idle)
+{
+	switch (env->migration_type) {
+	case migrate_load:
+		schedstat_add(sd->lb_imbalance_load[idle], env->imbalance);
+		break;
+	case migrate_util:
+		schedstat_add(sd->lb_imbalance_util[idle], env->imbalance);
+		break;
+	case migrate_task:
+		schedstat_add(sd->lb_imbalance_task[idle], env->imbalance);
+		break;
+	case migrate_misfit:
+		schedstat_add(sd->lb_imbalance_misfit[idle], env->imbalance);
+		break;
+	}
+}
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11288,7 +11307,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 
 	WARN_ON_ONCE(busiest == env.dst_rq);
 
-	schedstat_add(sd->lb_imbalance[idle], env.imbalance);
+	update_lb_imbalance_stat(&env, sd, idle);
 
 	env.src_cpu = busiest->cpu;
 	env.src_rq = busiest;
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 78e48f5426ee..a02bc9db2f1c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 			seq_printf(seq, "domain%d %*pb", dcount++,
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
+				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
-				    sd->lb_imbalance[itype],
+				    sd->lb_imbalance_load[itype],
+				    sd->lb_imbalance_util[itype],
+				    sd->lb_imbalance_task[itype],
+				    sd->lb_imbalance_misfit[itype],
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-- 
2.34.1


