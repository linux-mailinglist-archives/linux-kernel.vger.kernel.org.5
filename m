Return-Path: <linux-kernel+bounces-73429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A785C27A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627C21F2358A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78077625;
	Tue, 20 Feb 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="49IcixjY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4C76C70;
	Tue, 20 Feb 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449650; cv=fail; b=GxRdjbAOU0FN4dh23bEGjlfkbKU6INwgvraSdZP48ElkhSH4gVua1xa9yBrZkqgcrunmIN/Al7trO8WTDJHxm5axZITrFZF3UoBw7epOk4lMgg1jsPeIPa9Q2swbtzdcq0JGd5lDzWxa6bTI6L+yL6RBuj3VM8Iynmex70S2uug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449650; c=relaxed/simple;
	bh=BvbQlpF0l8qucLRjSFCRYYNOpRbfRjSP3ub3kYrDbdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkXgJEUyr9BHzIg79VwSh9nAq5zbHvmM2Tgod5bQKnK1tAqgoKgbxPxQmKUxwq1axryPioeEgjAEeBqVYDpB/CyJtcS2cL0CYjhJxux4fd95H6IkqvenqOs/Grsc3n3yGbiPHyiiayYCh2POWxftA1QMHIdNjp9zfAU8XcMh/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=49IcixjY; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk8LD/p8IHi6AtpZzkO8t2tLNcbwadLRSwi3pE+CP3joR7FY/S3nRdF4cvYrpVkosBEgaYfd87gYHIRJmFSvl6Wh0tTGnMbJxIel7ckJzQ3ocxegTMMyk4VrxyM9koXsJn2Z+xNp6yn42QB3ezbdtbQz06SZtw/F2mgpWxNRrqut6YInm6z6iu8QO7BEEyyDKQXCAWrjVfAUsD/MeX1UFEK4eA79ZGJdcMgW8w8OkYJJlCQ2IYfGUrl+tDNPZVijWNGqItYWB9LAFcxR2wTAOe/UIs+sV+uQmuYT0w5q5mvo+jVNgrgZcs08ulnd4+vBBEvcQTz6UdSTtURV7G5bOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpObeRcQEb/jwCZj6zGwV2/6GTvW69XYaITuZXkFnvs=;
 b=jQH7VkzX9C5t7XN4LbS3lOmP4gifUGFJx9QSNlrPA4F0lVvbUmbSBHZtjSZTo1RnHudQVMwYTozVjKvt6LaxZTsm2NFOMhM7Jyj2xmWJB1kk9dZYlkObw30QMxiZ4a4OCcXyag8ZYltsaHjWXgP6xUiYnknFbYVZL0HYcK/JAygMdXP+ZrDkBm0INQ50kZcJauVPaetpnjd7y0ADKmASbiTzkYiBvDnNQntwKul8irlM/CToy2K9sfT5JRLcagJ9rK/7O3enPY/ZjJdcq8y18GlO2QMgGY5jfb+qI+nJi08pphp1MF92YpO2JlM7PgYNFksyvIUfTPd7HeDKl87Tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpObeRcQEb/jwCZj6zGwV2/6GTvW69XYaITuZXkFnvs=;
 b=49IcixjYr9VaT8xrJzw3m66eE4bfOp82xu4yGfp0mJSlYZ6MzQjt9m6htXrmusWbyt/TYkfHtFi05bJ6AA22d3yQ/bmRbAo8sNoobw4dTUko0Dp/TMKIhqwn3IdlPYpw+osCkqENmO9U/BqFgETJpMdSLai4QXrk5qc8FTIUHeg=
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:20:45 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::2) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:20:44 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:20:38 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-parisc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 12/14] parisc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:55 +0530
Message-ID: <20240220171457.703-13-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW3PR12MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: d662f4dc-cbb6-4d7a-1548-08dc3238459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NhlX6kO/lOuZ7X2yCs/2g2+4aYEoTsiVaVg24jbzSr+4t47nU0e+KSBMcn5HXdpQWy44TfYhh6QKHouXTm7tHfqJxja6+t0xWMyd+L/vKpHuaZyjc8CKpfWFytAKL68Owr+RKGgQHrMzcaZiTDj4KqqPIwDoefNewnaI+Ln51XQ0FfM1s4qHL49OsZeICRtv8ewle/xfdW7h9ODy8kJR6sPI7lPH1aIEf3M7IHIarHb7vdJkpKkPolfXK5TWBVTBHEjJr5HVVB+wbUknnbYm/Q3HZPISTxaHW6Rd8JjKbiMajYez+sVpqR21dNGHZM94VHj+lzPpXA7lLac4h2CxJev1x0T5IYoJUMexzcA1jfMBW+nxyo6+HI5Fl2FwLNaE+3isJ2PYAffPxF9xyhJoCGEb1gTmQh+xBXEfaGvG4Edqj3xDqWFXfNiTdvOKYlZcL00hp358BdEGHmyUUmrUuOfGo9WnEfYDswigWn8Wi4VmgohOUdyOBFeYhDa+wytG+sSaYRbqvs0Ukqc490jS+y1x1y7zTp8jXXz3aOTT0awcBtj5ybEmLrUbRVt+jq3Oab5BQ/TbPEV4ODWTMdSde/wXSI+HIolECwJVIt+B25MQdsIvMNIHK4YLEbvokJnW9HzonR7yWEqNNq8PXB6LIKlUIbvERj2DuQeaZmOfekQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:20:44.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d662f4dc-cbb6-4d7a-1548-08dc3238459d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506

Add support for TIF_NOTIFY_IPI on PA-RISC. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
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
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/parisc/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index 1a58795f785c..35f1deeb8f36 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -52,6 +52,7 @@ struct thread_info {
 #define TIF_SECCOMP		11	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	12	/* syscall tracepoint instrumentation */
 #define TIF_NONBLOCK_WARNING	13	/* warned about wrong O_NONBLOCK usage */
+#define TIF_NOTIFY_IPI		14	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -65,6 +66,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 
 #define _TIF_USER_WORK_MASK     (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | \
                                  _TIF_NEED_RESCHED | _TIF_NOTIFY_SIGNAL)
-- 
2.34.1


