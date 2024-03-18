Return-Path: <linux-kernel+bounces-105867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6B87E5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683AD281088
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF32D611;
	Mon, 18 Mar 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpbLo/d7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF002C684
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753954; cv=fail; b=TPnOM8ys8Wfg0KoQ7ph93EnVoCIrLStpwQcdXLrN5zFP0fmfQLXNtdQUn421G3PfOgGbd6V7C9qulO43v+Hdmkc24jgfU522Ns+aUia8p2qRX+kZ0LYUztDLdh3rhXRHfkhQaKbkU/7ZW75lFjcwrRrnKF9mbdytVWY04yXwh1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753954; c=relaxed/simple;
	bh=p4Z8DCde940LQ+F8nckqFDuJld7tSqAsrWmsvMzQxrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgumK/ZyIY/ZkB3r5QX4uXyxsOL1MKbvDU2FzCWFJSA9faDQx2bej3A/1ALrV84cAuyfN95w6fELpneyi5WylXJaTkWMRGgiyIlriSusOEfEjwpDcmSnfaDfYBbmN12yKVFWzGdlAqArGaTQ0WpIs4TUd4/qIQpP5a4t2q9mT5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpbLo/d7; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFo0SQXkr19v1AVnawUvLdIQ1Sl+ChceFtiJJfWsKVOfoq1LVUfbniuXRe2J8Lq76ULOEC6Zj2Dvqv3HzTHQcp7hFtMRorZVZMLhPfU3HpXkx0c/IKV5fA3hfP/DLYX843Xf8rOrMfWVtabmoD7XeSL1zE4AD2nlVMc52AdQLBZWvDeKuYAkh+sGDZTDxQjTUdHBmQCbOY8EqqyuhSmr84PX2VZFLhw4+qXohulNxYvkkRsYUwSc+mR+GiMmhTAsUU4cfH0FCqRsIp82HKjoloY/Q0S8ol1TgaMWdNpVjBc8IoR3lWHF0oJ4/1zBx4/W2moGjzq/NB4U3vLAwZ6H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDMFLoz47nsR4FZDBycEmKlz3BarTUeaJDbhWps9zGU=;
 b=ErOCbOGKaH1b0ySnn7/1Qpaq5wJt015jgFzH5xUs/tZA+uVwVYWYEoUv3EKY444vupxS5TlUF1fTEfhLNyMNtcwfzWeWhvvPchjpiY5YsVVOsaCzNejs4lj8DUNG2xf5V8amcE2Xg91wTKV9PDiWWQJujCNUK8DtQ+4gSupk5wPHVtpmkV+QMZZ7jGVWloN7WbUBLq5HsEQMxJIsuvvGntXDIbMm+bx/X+7BFbiLlvgo7+J47RxcVpPX1ymgJ+0lgxZrEYoxWV5+F3Imn5eT7mbPOwV9G3aX8D1ybIj0UnFMu+o4kaMTLfCLYBzbEusmDw9uq0TrOIzgG/3MaFm4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDMFLoz47nsR4FZDBycEmKlz3BarTUeaJDbhWps9zGU=;
 b=rpbLo/d7YVncg+VWa3TOci1KrEqwhYnEtWzpHvnnmWuha3qd8oN+Wf+/6SII6iUmeCXxQiKHKyTRPVa8poD5+cAIeup03PL43dQb1F7eXkNJdMp09JCa+CWP0fDbx7xejZ3WSzf8ofVethOGwWgkHxuVGWayVEkdqGyMsaEcWR4=
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:25:50 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f7) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23 via Frontend
 Transport; Mon, 18 Mar 2024 09:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Mon, 18 Mar 2024 09:25:50 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 04:25:49 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
Subject: [PATCH v3 1/1] sched: Report the different kinds of imbalances in /proc/schedstat
Date: Mon, 18 Mar 2024 09:24:33 +0000
Message-ID: <20240318092433.1791798-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318092433.1791798-1-swapnil.sapkal@amd.com>
References: <20240318092433.1791798-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f37e78-186d-4972-ffbb-08dc472d66a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9UBjISRXNQ2p2Dh7fpI9D3/A2Hog3MJhZFyc0Cmg86nktT3for7OxELh93Xkn4u1vmE1GtAwe6etDhl7ZMvXcjvmQKQxcxnrzXlFK95IOzlddaD7GpBbFJJG4RBr+0Omch8eqK6/TOmhJbs8QjX6KvZx0DISuvU7QzGhqjuPPDbnhmz+ID/uWSsa9QKVf2hY4EAFZmItu8E5z6zJu6QX9qx8YpSue9WDU8G4a13KXyELWgUnT4q9Mk0HrkCaNQl5Dq1EwYZOH7iRVzn5KsWFJhaLEG5lXbGNnKb1fnW92Sf/lDOzKralG9oPTDnt5k0aeOMlREsMcg5SkPVqv4pNe4LivyHdUnxND/DqODPkPzRPQd8iJew1KqFPdFy52rU9SNq4d3p6LB/l40AvB9lEXxv5ZWEpbBkHAYNxjzwa5vvocUakrbmSudFNr4DUVVIp7o0l/PDeyEWjtIIzY4gOOKNwI51oKRMCQ874uEdBTW/obzNvQWW4KPueYl5nuRw3ZrbSOF/j0BAn8I0tdksJ56biVPgTos+sc2eiQOIP2A/pApoG2ZC4dK6Z0zKeXlBtcLGi0D8HfH+2A+VbVDpo6HzNGcrPSXZfw3Lz3L4NQMNGjnBxYKh7H2RSRS+o9IPyGbg6ZiCySFpYdwEX1stPo/j9UP2vGz4uNYQczKcJ8ofZKxvh0PBo9T+nQHcI4b7255b5qGrJNyhd/ovZsSuKzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:25:50.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f37e78-186d-4972-ffbb-08dc472d66a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

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

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
 include/linux/sched/topology.h          |   5 +-
 kernel/sched/fair.c                     |  21 +++-
 kernel/sched/stats.c                    |   7 +-
 4 files changed, 99 insertions(+), 55 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c4729d..0dd47bdd5608 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -5,11 +5,16 @@ Scheduler Statistics
 Version 16 of schedstats changed the order of definitions within
 'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
 columns in show_schedstat(). In particular the position of CPU_IDLE
-and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
+and __CPU_NOT_IDLE changed places. The size of the enum is unchanged.
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


