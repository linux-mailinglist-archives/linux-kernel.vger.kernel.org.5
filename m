Return-Path: <linux-kernel+bounces-73427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D785C274
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DE2820FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922776C68;
	Tue, 20 Feb 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ynRcDNtd"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3476C83;
	Tue, 20 Feb 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449608; cv=fail; b=qI5L4Zm/XRbG04+5SoWalezugvmhbDMykLOAIe6MFPP6138O/Sz093M5n90ozgLAjHgXh8Ayxk8qWD9iot1kWkKy7Kg1ghc4zwyQxM1NlUtbrUm0ffWIPUvFcdRn/7rpFtFA41ztipX/7sNPsJtEhGKPj/51J7DckpT4+Nh+/ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449608; c=relaxed/simple;
	bh=etRlzNr3y/VBDzVXVzZrB/dKFh6yiHeIx/jxF5/1jKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKrFK+B17tF+/WhRENjLzW/A9O/RPXTj1VvLfPgDvB85eBrjAknVt+tMneMTgyr/TrQk8eMy4CMsIy3G5GYmmfJYA/cogQGDwePWMcyTIyONZWJ6in9npH/uQEguLauuEzm9ePDiVzEBLggHZKaQJhrEjb2b0o+kJhVRwvHmcRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ynRcDNtd; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiLYKS/TH37gcORaWQmHoc6sQ0qfU4vu23+7G+71R7DmWJpUDoark/cvzyjtlvvMxvhtSjxZZ5qQRxBeZCawWtTTBf0r1lSkb+SxUn+pW7W3cFyOeOxrk7WNvAcKXnaPbZD080sODpRM7TZFeSJOrfq+TLfGbsLBk21WI8Mmr7Tw+gakmiYYtrtWU4dgAc11wTtuX8JOvrynnB4fzdSvGCjyld652IvRhpBCQgMDKSWaPGLR6jfQYACDwuNgvTSyix7a0dzKYP7DjP94oTLLasrkQEemwoVaT42Gu44vV+ztvpkD+LqxuK+3M9jwY+YNfwwWzyySwsO85latq/tqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBxGvGTPWFTY0JyzVEvPo7GMumkNd2FmOKD5X/ik2Rs=;
 b=lcuBb/oOqoYC/VyrH8Pj/dl1BU+fvQpKx8oUCc3KWh/o1jygNaYh4p8wzRGh5WopOIu2zuocx16VN7Rzle7bOInxQjknEWSyszvDnIN5WF1re4IzMO+ZdlP3GWQ1J/NBBJ9gSCkfOv4+FaG4FQ4rVDG+/FlXDB228a1vg85HBNgwO5VMXjIH2uCWz7jmj3CbUpEaC/ohB24HYxMSjvpdtstLaFL/F5jLi5KHAkKerqOBOQUt7Z4mF59sDAKfDZ4omn4Kjyl3ty3N8+uaBPZx/f45wqbVZCbiQWPhZ9i9htRokrBjBZ4evJAEF3C4mazpc508mpkzJh6xncqfHV1iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBxGvGTPWFTY0JyzVEvPo7GMumkNd2FmOKD5X/ik2Rs=;
 b=ynRcDNtdcK/shaV4JxT/up6pnsXuvt3KUmc2+WFLKUo3Gg0upQuNta5UnRDQWvS6Xmj8BH6uXCv+VWsGZJUnSW6X26EPRdmjRpKdN8DWjZJvwc5BeXqRxOWrKd9fEkupQtGcP4EVOG1A3zuJ051TLn411FiHSN6xoP+7QsE6WmE=
Received: from PH8PR02CA0027.namprd02.prod.outlook.com (2603:10b6:510:2da::18)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 17:20:03 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::ab) by PH8PR02CA0027.outlook.office365.com
 (2603:10b6:510:2da::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:20:03 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:19:57 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "David S. Miller" <davem@davemloft.net>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <sparclinux@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 10/14] sparc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:53 +0530
Message-ID: <20240220171457.703-11-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1013d6c4-91f1-46ff-0e25-08dc32382d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	edrQ45KLWJSQjoTOzabJ9s90qSXo4D6x8zeM/xL3SN7fi2+aAfXpSiFKIqWF3QzFcpEe6mr3gYC1GQUW34NrCuVAmgwCfdWRFAEZR30UYTbGSHgTRQU6z3nCPP9STA6jDDMUyOnF3I2WHHcOhZd1fNnRY1aAkfb+d8zb1Rd6MKw8IZXwMJ3xb/MkmlJfKygSNyiSm+zWltwbSLIXnVmEAZ0yLsEmGvidJULJPUzh1NtvWZMJMgUWFxu2U4kyLScuY3j94H98qB9BeWVXkbhNCS8v4t2sBcRbnx+4mNnPqRibwsqwTi33dZwOOZPQpe7u9quVsdNt7smP2mALN5DjGkpiApAKZ/3fk/wfBFn3CamBAy5mHAY91f0G004Wf6gnueTK0r3njcxOZ4vxwl7kkob3aHc8lg/r5JRHnAM2S81aH0/JpTrIppSdWb0xi4KyKfLqi4uEDX8KzPCl6j6QtArQmY4vL+h1INBrDNYpxcTHVKQb5ayGJtJoaxS2lDocBVbkYPsv8NmzjTafwAxvgaeU85kuw3CsAzpx/rQbvPQFACfT/0hFmJkd1Pi+YhHSVWA9pjg/R06uvrRPcxWQDyygNt9g8ub2jYTxN63bYmV+7kdeib5QH+XSMkSsiJjDduXkZFxBhLATYIYz1wul01W4dMNmo4Q0d1d6i2QXgjE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:20:03.4399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013d6c4-91f1-46ff-0e25-08dc32382d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

Add support for TIF_NOTIFY_IPI on SPARC. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: "David S. Miller" <davem@davemloft.net>
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
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/sparc/include/asm/thread_info_32.h | 2 ++
 arch/sparc/include/asm/thread_info_64.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 45b4955b253f..f538ede526d1 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -105,6 +105,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_USEDFPU		8	/* FPU was used by this task
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
@@ -117,6 +118,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 1a44372e2bc0..3558101ccdd1 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -194,6 +194,7 @@ extern struct thread_info *current_thread_info(void);
 #define TIF_MCDPER		12	/* Precise MCD exception */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14
+#define TIF_NOTIFY_IPI		15	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -208,6 +209,7 @@ extern struct thread_info *current_thread_info(void);
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 
 #define _TIF_USER_WORK_MASK	((0xff << TI_FLAG_WSAVED_SHIFT) | \
 				 _TIF_DO_NOTIFY_RESUME_MASK | \
-- 
2.34.1


