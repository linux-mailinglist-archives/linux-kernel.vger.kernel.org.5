Return-Path: <linux-kernel+bounces-73418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF485C252
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098E8285466
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73D76C7C;
	Tue, 20 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZaCKCdpY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72176C68;
	Tue, 20 Feb 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449473; cv=fail; b=IFGyeybMUo3c5SSYajqTkcctbqxOnFxXn37s/+wKK+B1JQxc89VQF6ifN9nuJzdwGj3KepXrGbUDNrwrtoOzOXgNiHP6JGwHDFlVmb7+qB+8ZUYkqLmnSUDpNtkM801lXP2GIHTDAMIbNXI/O1VJ7rjAcoECkAWiJWkmIdUaS1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449473; c=relaxed/simple;
	bh=UqDsnlqYBKCPSSidsS2P4E/txgPmzhD4hImu14WOJIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Stg2vYl9SKsPmgmIJ9r3p1v9RPE+vBhNz4eWpuTsJdvsdfYVqpKd9wpRFnFnoOS+My0AcopBqb3mXSwWYroVLUR+JHdh94FmrUsV30TLHIOmkA8LHbD5JCWQ5dOTisOyEgrhiWEBGot7O3T2Q6ZzuPuBFKFB1TXO7KnKp5ef2JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZaCKCdpY; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDqe6tKtP/qxGb5Bi93hGy/xfrY5PLjh97FFh5mHRYL0jzcVIrEdDnac3FIqofym0Jy5R8Kq9BjP0RQun8N8HvzEowLMbR4Yan5M0fFkZY8cp17M4Xd2quNAZloUOsMyXl+WK/XqSLdyzBD7P3AQrTD5BoygD5hLq/4QSBMCdVEHGL8CgEvXcuzfvDIzsMDNDT3BHwYlgqwx+cY9LKP3n9pvrWAKIMqZDJ5Fp77zIaAhikFMcxNGvvUaRsQOKYzNmhHPV3uuOJVhuzSqblgLZ1Vui1LkgEVBk2kYgRxYeLCjBToB+hI6RmCKpHFEkBh6R7n3yipYOoYy7DcJVDZG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dAzWXAGtD1k4Sd4g6zY7umndOUpNmK43wb69pY2RMg=;
 b=dYMpoDW+aEBxrDC51TIQ5DfZqI/9+XpHTyo4lH3DWrNe9crsghLQkigu3y/8uACnnGbf9RxEnsajRWTgeKmAy23FAF/bugIA3VFr4CDpBbfl0/p40N0Za4uU/n9dJf27sU2LBKdcs8jrlScpEikJzWSe5sukD/r+nmcO+hAdDBJXI0C5sOvoDozqpOHibRqUYv4cEjyA7YxYaXKMd1TB5cKmn+a5lB+orGI9lz36q1iziP63nzZHDWalJhioEJvc57QowznGXMfzeFlTbsgwF+s2iRnMePIJNC06qzzSYqqBCBtP4EKRLrpXOCrkj2LvtXl1bD47U90IJ5k7WBLe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dAzWXAGtD1k4Sd4g6zY7umndOUpNmK43wb69pY2RMg=;
 b=ZaCKCdpYMwG6aDQj5Q7aeMUDNl8l7b8wX8JkAmdE7RDTuI/oeXnBNAnq+wChZzObSAJowiBB8HBr8zcsdLlUdYY8/EGdi5EHRotb378pvRmIwWKFHSuTF2wXMnvfOMQ6iHCWjUkch+ol6i6hqo/0Stvt8Ftva4Gsx/MBqN2tLOM=
Received: from PH8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:510:2d2::27)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:17:49 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::5b) by PH8PR15CA0008.outlook.office365.com
 (2603:10b6:510:2d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:17:48 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:17:41 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Tim Chen <tim.c.chen@linux.intel.com>, "David
 Vernet" <void@manifault.com>, <x86@kernel.org>, <linux-pm@vger.kernel.org>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [RFC PATCH 04/14] x86/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:47 +0530
Message-ID: <20240220171457.703-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 70144d14-30f0-42dd-e3fa-08dc3237dcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	glxj1MCJFufDj7jaY6ASZaFWdsZVvp68DoCvAtS5wLb0gzd1b5hPl6h8JWLLncrFETEaUTzxC9NAoV3x6yWBBqhT/YAnmmP6X0fvqMaTZmnqXbp8MCjEf+IhMV1j00WMmnBtsaGx4cxsEPkLDZkqxpZ3fEULz02NJnPep/E7+0+RGyGscWGgAlZCqjiqZUnb/0D0EvLpOqs/EvUawoAI6dfbeh6tC+eg+g+DaanMcJA8CqPfXYXi20NV2zKPd3eLMR7Y4KGtOPNMyFJGXps6UDsbXCAeokXYxBxlFneLNNCK9Pr9sxxJkCZUpxzt68F8LMVOmyr4clohHsM5CQCgukAxJ/ZyI9+diJ3QpSwG/9aJGtnghEUDAREFQst6ozw8HpIBq9+ybYdYlibra/UaXCZlDzfz1RjG01vYBkH731AepzMFszXvlL/SFNqVLK3XHWBxT9lKYSdARXR1i8jgaYUFCH3Xj3plt9OF7YIQmnMFUIneybz54z1KoAXai0u2I3s0/72BDD+WxL4Jj63/VgFVROe+FYXZA1MuLD777zhixfdMLu4OGmwy2lHX0NZgl+3vWXIC246krz2sbNN/JQ7EovkvzGx0tCHC5aXdSCi+G6GfeFVb/lfRXpK/keZ5EqO80/s0c49oNIN6auGAnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:17:48.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70144d14-30f0-42dd-e3fa-08dc3237dcd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Add support for TIF_NOTIFY_IPI on x86. With TIF_NOTIFY_IPI, a sender
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
  kernel:                       	time [pct imp]
  tip:sched/core                	1.00 [0.00]
  tip:sched/core + TIF_NOTIFY_IPI	0.41 [59.29]

tip:sched/core was at tag "sched-core-2024-01-08" at the time of
testing.

[ prateek: Split the changes into a separate patch, commit log ]

Link: https://github.com/antonblanchard/ipistorm [1]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: David Vernet <void@manifault.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..90cdce971397 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -106,6 +107,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-- 
2.34.1


