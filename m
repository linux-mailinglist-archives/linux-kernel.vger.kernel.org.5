Return-Path: <linux-kernel+bounces-73419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9785C255
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884791F230DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1E76C7C;
	Tue, 20 Feb 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Go47fWE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D58768F5;
	Tue, 20 Feb 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449498; cv=fail; b=sSgGiaOpPHhQc1KszZjsCBA5FFcQAWqU1M4YS9PHyDAPxVhDJCrD35CipMxv2iBOPciTq2b6T6zTGmbYc5Wh14AJRg1OpuT80qFOTwSqT1bTf564T5AF9pM+EqCn8RS0w8TlBrpvATTEOHLjV2qHh/8VmW4QRBbCBms3TmxOsg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449498; c=relaxed/simple;
	bh=jSgqo+XHfB8LEmGdl2KSWwnfQijZJw5wsB1buN89VzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av5yHRNk8m4lwJXm+/ZGFOnyJrYBzgAcUkTPxBQ47Ld5ojl4NiX6VK/GTzzOIwAaU3Eo6SvNAFmUsMlfWCZ4ChhJ+g1OU5DpUJeWgI7HL1r+MnfzhV6UTSQ8ii3fMX7hVSR/TkNcUhg1n1RYAyd1+eYANNtuvvXf0hJGsc823xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Go47fWE; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHMRem4eNjRYI+GCS+7m+ZjUw4ZyTRv5BWRNqjNG5/5pRYclIFnshpsI74i/ty2taG9THEChBjry4qPVa9QMLQIz5RMWO0o4VX0VPJUF1fPt14sXWDO65qZvpVrdGVZZD+7g+ai0gKeInD13PlXcMJBsNmI6C01vVimAuLE2l9FiZuFWbZToknnf3fpHBbyD2MxSIyDSLPkHunFge0GR7DfqbiFtzv1L/2Oaslktz0JgG8vbRnvU7Lzm9TuxF15Z0l5BXT2YuXt3pZy7l1jd71peqtg9HFw2LVlSuuq6ZHGKo90JSZiXCPD6MslkHo6M2T+jqYS0iObrBisBGbpxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKxxEovpoVS3uTI/efTcUmNgbj5XCh6Szmel8hIHEXs=;
 b=ei70i1c5HjimLQuhD0IfsCQbkiO+OmjPStbwy7r0rbc/CHZys7hdBflcWb3lUFoiDkCAfRjaZHPwxajgcNomv6aLQa4zkUHI5WfeT2vXPak6KasMfwXalKhJbkyJ7jhcHa4R8AXmLxyMJCbKkiK3aPwqujqAwxeNZWuYTFv4opM2W0cPLhYOV/aW2+FFskSKbwgt/olLFrj/iNyt7CNsS7mmKKgOslZb+q0M95Rk7k5P6/WcyCsE+SdHgwCVZ+1Duyl+jVmI9qy97ADPjonUizu7Jp+/2c5/rZF5GoUsilzgOfwRzGGI2fP/pm9EF6XAPVOutnl03IITqszuymOP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKxxEovpoVS3uTI/efTcUmNgbj5XCh6Szmel8hIHEXs=;
 b=5Go47fWElgI+sfHqmYX+VRdYUSvdL+jwwRTZSgAnV47Hiv2R+bbHW/CBh240eaN1OYklUB9LKEb/hf++fpXv70d0sHQmFsFHaWJAJV64W84rn18t0pntK/nWLiqjawlaGjm9rlR66XWzEFe58k3d1eyPv82cca7s2vGM540rYmc=
Received: from PH7PR17CA0013.namprd17.prod.outlook.com (2603:10b6:510:324::6)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 17:18:11 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::8e) by PH7PR17CA0013.outlook.office365.com
 (2603:10b6:510:324::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:18:11 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:18:04 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Russell King <linux@armlinux.org.uk>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 05/14] arm/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:48 +0530
Message-ID: <20240220171457.703-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220171457.703-1-kprateek.nayak@amd.com>
References: <20240220171457.703-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d8eddb-297c-4389-09c9-08dc3237ea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xf84UKcLhaDtJnRoa0bxbLmkHDwHPLUKoOO875ZQ4jibsSt2pEg3HZehhC3S1aMrRATmpxJIh8ilNxdI5Y182kwnXZstaA2xMqnGCDbvvwfbzY/itw6MoSCAkMRVUd6aPj9207lZp3sPkhdwc9LOQuTLJBZ2fLPBHT76fclgJMRSUMtQ08V2rtHF+hEA5QlmCnHjrMG2ZBOivp6v6p1YatiB1o9ybP/hocu0MtJEJ/fVrf/ABBWTOawhs8tNPfAKrYbutQwgGehHgKnDTN1gopyx2DQUNEzxs/qcceP1ipiEq7lQH8F/jVTCiBUxAGwNGVnhDb+NKk4uT7Od7OjrPzjNPrEHY4WvIiMxXPmmHfj9SsD0sz+0PJSiL3RB0lTWLmVL7QseB77NuMH3ldbxZtAAuMbeE2np2HccqqU9Y7Q6so5Vf/zl1SaUP8kMxK/t+jN0+K0qbTaTI37yPhkXzpmVrKXIjs0ECSTaQY7QAt6GYU8yXEcFj5DM1IhbGPDN3o0epzK7nErAjc/H9fo2f4Imxq/CV9YvdCuUCaelUdnTM/6YhlovaOO5ola2V6deJ061fdpH+Z80hEddIkwCADPU5mzHCvMg2kA0UzOrcfMUkHt4VPVKeXB5z0ZEFQrFLADUyKD001YBpfRmIsiFMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:18:11.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d8eddb-297c-4389-09c9-08dc3237ea20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

Add support for TIF_NOTIFY_IPI on ARM. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

IPI throughput measured using a modified version of Anton Blanchard's
ipistorm benchmark [1], configured to measure time taken to perform a
fixed number of smp_call_function_single() (with wait set to 1),
improves significantly with TIF_NOTIFY_IPI on a dual socket Ampere Server
(2 x 64C) with the benchmark time reducing to less than half for
100000 IPIs between two CPUs. (Note: Only WFI idle mode was left enabled
during testing to reduce variance)

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

  ==================================================================
  Test          : ipistorm (modified)
  Units         : Normalized runtime
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  kernel:				time [pct imp]
  tip:sched/core			1.00 [0.00]
  tip:sched/core + TIF_NOTIFY_IPI	0.41 [59.29]

tip:sched/core was at tag "sched-core-2024-01-08" at the time of
testing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Link: https://github.com/antonblanchard/ipistorm [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/arm/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d2..324248d87c9e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -136,6 +136,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
  * thread information flags:
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
+ *			  or TIF_NOTIFY_IPI
  *
  * Any bit in the range of 0..15 will cause do_work_pending() to be invoked.
  */
@@ -144,6 +145,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_UPROBE		3	/* breakpointed or singlestepping */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		5	/* pending IPI on TIF_POLLLING idle CPU */
 
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -164,6 +166,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 
 /* Checks for any syscall work in entry-common.S */
 #define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-- 
2.34.1


