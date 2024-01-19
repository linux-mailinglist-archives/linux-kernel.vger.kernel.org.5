Return-Path: <linux-kernel+bounces-30917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27E8325E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8D1C22700
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5628E0C;
	Fri, 19 Jan 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjwcU9sX"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC628E01
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653794; cv=fail; b=QoWB3s/W9Eej1B0R4zeVzjkezjK8XrYWmxf65v8xQebOgSjtyLxDmrTOaowGwkC6NO4gTKAR3qACG83psDk+Z3FtqlivifsfBUUVWKIbqfnXxET/VqiBrClXtnfU44I8nJCf/bfWncoELNWozrQq/cg3smi60PD373xUlfRqXy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653794; c=relaxed/simple;
	bh=9wap/LQgYMwDgMBCHqHCLnm9WuUww448ldv89jZqWL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQ90c0wO5AVPO0175PTs0lKN0kyEP89OLRrrESfNbtDYZh0nje8cVGE6hrRYoA4thbsBX/fi/kfvzpBWgN8O90QYFi2OZWd0tRql22rL7gq4vFjdPcWZFpuDdG6iWJVE3Xbeo+uKee+SRMGY5Z+0fuuKeGLtV+XWkwRZVoQxrcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjwcU9sX; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSo94BDyP7j2zgKxlR3y9bext3hkuTN3KfKRXnvpNhV+jHB+KZjfhlkdfHpewbDNfBK5QyJGX/z786yxlqjSt3dU3inEEmt6qnMexKCdMl5FHozodbwfSl2K65zRPD5YDCy6jmCLoOFTqv1bm95Wo5wegfTGRjnqpYYRqImp/a3zNhGUS1MUdZJDTz03WQNhcV/AAam1yxlsv+acefAJC5Z8izEJyoKoPOnSUnc6gvSCX7xd5ORpNos1pKtUzdFSOXhXFZakK1nDughJSC3ZUZSM8r46XgIeP9rRwe7+rS/gntAsLzIq4x9XMzavsUKBFhhMv7WNf7z1ScQnYSTdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Nlaz+MGRPLhpVYEmrL64cGlOJtxz2euNygmwm8EPPY=;
 b=I5SKTJA667Q7bv+SjR2Y1HgL11rSrN111oYRxbgE7V7YOIr7I6cOFb0Rh8IgRgdnEgxZrCRRltmW+nIht5jrc26YfOBYbTylkWQTNmQwxOavtdPWhxGr5TEZ35MHYBRHrTrLQWNNrdyyzgqw9dDVtrk7dRQoVbEEOT6mb9XYDCUsSWoe9pR/8X286xQTgto5nCEimtY6WR+x1UOOBpo9z334lp1VqD56//dWBkmxwaqFTnSiauVs+DJqJLeXiqORpku0+UFNePmgXcT33xy3jR6t92J0HshO9rckdokCpXHRlbj0Na0tkV3QQAxzJeVKv/floRW1bsU9r25I7V2djQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nlaz+MGRPLhpVYEmrL64cGlOJtxz2euNygmwm8EPPY=;
 b=VjwcU9sX8W+p9mNDK+fRgspNkrzR1HxmwMe6f+SmePKpu+Nj4BR+pe5EK6ymc5go/4jx6X9P3605OCKGd6Fj22Q4k6pB/W4Sq9LxOXDeM/x2wnwT93IvqIZJxDNHvKMobMM1lEFZ3WEAPT1Nw/Ykbz+w4+gG8pI90VRGGiaZH3o=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 08:43:09 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::75) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 08:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 08:43:09 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 02:42:53 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>
Subject: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is woken up to process an IPI
Date: Fri, 19 Jan 2024 14:15:48 +0530
Message-ID: <20240119084548.2788-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: f85439a5-4230-4ebe-a9a1-08dc18caa9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PIDIQHEIYZ0dY6uD6h6ebsnj4NbtfUoDUdLsZWrrDfUqqRiru5KrdghitHAjlE+ZjJW0wAUeYCOvGCmj0PVdL0VOfC8rGL3+5l6Rxoj3MlTJfjjAjsmbiP7CgYdz2TkGtV9q9Dkm3AhoDL68e2CMf9+YWzRdVMKUtpygqg3qoHLE8d3JX2ahrSTBvFC6XPATXDTg7rj4/srL2E1bQKWGfhJpMuPTQEygSmingOrDR5pwJTbM5VVLNd/J1CLdzSsy+oUc14KXH6fESLkW1To/jc+ECBFL7n6NFWyQcitJPeXE+ip1mYT1upagmxcfHrKZboohWJuWUi8a5ebsNULmqyOHblPZ1ozNR+I/Vh9BpUPyQnUMbL3PsJ/HRudH1jVxdCOErMkc8a6ANMeMYh8HWEPzjEzSHFktyW/wKFS6nxB2NmONWxlPPL5rr7kuzOv3lrjnNRo/VtjcXdvm/FAly7SlBohhs1DslFkZpzkWOOIVdg99X7tS0mOpdLbHV/CGtAXdgsLkgRGA5eQ8gXzvHxiIeQGr9Mo+0P7Inl2H9Ph8Xp0kMERjbuE/htDtGp8C/YMvBWogb+KEHmG+b4KMbgqEku6rDN0QppjZYF+U4Y/Upjt6xVCW87crbXonr1pveof2gTggRaC2GIJ+GOtNcgksxhgTjC4Ngbv3n0+vEsPm9b0G/0ZlPKlYa2ZvM7FFp+0zvhdEmXteHwRyLGsXf7HOgQ8m5hHNEtscLVl5D3nAGjZ3363ebn2L4sUtsm7W4X3KSQrbIUBA7V40wL/GTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(16526019)(1076003)(2616005)(426003)(336012)(2906002)(7416002)(26005)(5660300002)(7696005)(6666004)(70586007)(70206006)(8936002)(316002)(4326008)(8676002)(54906003)(6916009)(36860700001)(81166007)(356005)(82740400003)(966005)(478600001)(86362001)(83380400001)(47076005)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 08:43:09.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85439a5-4230-4ebe-a9a1-08dc18caa9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

When measuring IPI throughput using a modified version of Anton
Blanchard's ipistorm benchmark [1], configured to measure time taken to
perform a fixed number of smp_call_function_single() (with wait set to
1), an increase in benchmark time was observed between v5.7 and v5.8.
Bisection pointed to commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") as the reason behind this increase in
runtime.

Since a clean revert is not possible with the latest kernel, to restore
the older behavior, the call_function_single_prep_ipi() check in
send_call_function_single_ipi() was skipped leading to
send_call_function_single_ipi() always calling
arch_send_call_function_single_ipi(). The
flush_smp_call_function_queue() introduced in do_idle() by the same
commit was removed as well since the above change would unconditionally
send an IPI to the idle CPU in TIF_POLLING mode.

With the above changes (which will be referred to as "revert"
henceforth) the ipistorm benchmark time improves. Following are
normalized results from test runs (average runtime from 10 runs of
ipistorm) on a dual socket 4th Generation EPYC system (2 x 128C/256T):

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

  ==================================================================
  Test          : ipistorm (modified)
  Units         : Normalized runtime
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  kernel:		time [pct imp]
  v6.7-rc5		1.00 [0.00]
  v6.7-rc5 + revert	0.66 [34.41]

Although the revert improves ipistorm performance, it also regresses
tbench and netperf when applied on top of latest tip:sched/core
supporting the validity of the optimization

tip:sched/core was at tag "sched-core-2024-01-08" during the test. C2
was disabled but boost remained on coupled with performance governor for
all the tests.

  ==================================================================
  Test          : tbench
  Units         : Normalized throughput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:    tip[pct imp](CV)       revert[pct imp](CV)
      1     1.00 [  0.00]( 0.24)     0.91 [ -8.96]( 0.30)
      2     1.00 [  0.00]( 0.25)     0.92 [ -8.20]( 0.97)
      4     1.00 [  0.00]( 0.23)     0.91 [ -9.20]( 1.75)
      8     1.00 [  0.00]( 0.69)     0.91 [ -9.48]( 1.56)
     16     1.00 [  0.00]( 0.66)     0.92 [ -8.49]( 2.43)
     32     1.00 [  0.00]( 0.96)     0.89 [-11.13]( 0.96)
     64     1.00 [  0.00]( 1.06)     0.90 [ -9.72]( 2.49)
    128     1.00 [  0.00]( 0.70)     0.92 [ -8.36]( 1.26)
    256     1.00 [  0.00]( 0.72)     0.97 [ -3.30]( 1.10)
    512     1.00 [  0.00]( 0.42)     0.98 [ -1.73]( 0.37)
   1024     1.00 [  0.00]( 0.28)     0.99 [ -1.39]( 0.43)

  ==================================================================
  Test          : netperf
  Units         : Normalized Througput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:         tip[pct imp](CV)       revert[pct imp](CV)
   1-clients     1.00 [  0.00]( 0.50)     0.89 [-10.51]( 0.20)
   2-clients     1.00 [  0.00]( 1.16)     0.89 [-11.10]( 0.59)
   4-clients     1.00 [  0.00]( 1.03)     0.89 [-10.68]( 0.38)
   8-clients     1.00 [  0.00]( 0.99)     0.89 [-10.54]( 0.50)
  16-clients     1.00 [  0.00]( 0.87)     0.89 [-10.92]( 0.95)
  32-clients     1.00 [  0.00]( 1.24)     0.89 [-10.85]( 0.63)
  64-clients     1.00 [  0.00]( 1.58)     0.90 [-10.11]( 1.18)
  128-clients    1.00 [  0.00]( 0.87)     0.89 [-10.94]( 1.11)
  256-clients    1.00 [  0.00]( 4.77)     1.00 [ -0.16]( 3.45)
  512-clients    1.00 [  0.00](56.16)     1.02 [  2.10](56.05)

Looking further into the difference in the code path taken, it was
noticed that to pull a TIF_POLLING thread out of idle to process an IPI,
the sender sets the TIF_NEED_RESCHED bit in the idle task's thread info.
As a result, the scheduler expects a task to be enqueued when exiting
the idle path. This is not the case with non-polling idle states where
the idle CPU exits the non-polling idle state to process the interrupt,
and since need_resched() returns false, soon goes back to idle again.

When TIF_NEED_RESCHED flag is set, do_idle() will call schedule_idle(),
a large part of which runs with local IRQ disabled. In case of ipistorm,
when measuring IPI throughput, this large IRQ disabled section delays
processing of IPIs. Further auditing revealed that in absence of any
runnable tasks, pick_next_task_fair(), which is called from the
pick_next_task() fast path, will always call newidle_balance() in this
scenario, further increasing the time spent in the IRQ disabled section.

In cases where an idle CPU in TIF_POLLING mode wakes up to process only
an interrupt, with no new tasks enqueued, skip newidle_balance(). This
also makes the behavior consistent with scenarios where an idle CPU in
non-polling mode is woken up only to process an interrupt where
need_resched() will return false leading to an immediate idle re-entry.

Following is the ipistorm results on the same test system with this
patch:

  ==================================================================
  Test          : ipistorm (modified)
  Units         : Normalized runtime
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  kernel:		time [pct imp]
  v6.7-rc5		1.00 [0.00]
  v6.7-rc5 + revert	0.66 [34.41]
  v6.7-rc5 + patch	0.55 [44.81]

netperf and tbench results with the patch match the results on tip.
Additionally, hackbench, stream, and schbench too were tested, with
results from the patched kernel matching that of the tip.

Link: https://github.com/antonblanchard/ipistorm [1]
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
This patch is based on tip:sched/core at tag "sched-core-2024-01-08".
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..1fedc7e29c98 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8499,6 +8499,16 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;
 
+	/*
+	 * An idle CPU in TIF_POLLING mode might end up here after processing
+	 * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
+	 * sending an actual IPI. In such cases, where an idle CPU was woken
+	 * up only to process an interrupt, without necessarily queuing a task
+	 * on it, skip newidle_balance() to facilitate faster idle re-entry.
+	 */
+	if (prev == rq->idle)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
-- 
2.25.1


