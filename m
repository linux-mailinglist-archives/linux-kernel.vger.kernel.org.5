Return-Path: <linux-kernel+bounces-73428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6C85C276
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7011F240D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98677623;
	Tue, 20 Feb 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E2RamymM"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A676C94;
	Tue, 20 Feb 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449628; cv=fail; b=L8Rwds+30fbkGbR/5wWtpRYqSwHfAF3ER5BMPXwioR4n2an2GzyzwJI0biQq5qB0q2P18olDdFZcAJgbueYegOrkLTlDj6RKvo4HrS95uaq1OcBx+ZW0IwMrDIaCXu3yNDgPdv7RblLJbyHdc9pkfzz7OO2Nywg0T0bfwMX9vZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449628; c=relaxed/simple;
	bh=7ka1MOUCYXafNHzcpxNpfeCObgjAygMIaAO27nXcmOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOWFF4zfMdKmGit8EqG4F11uNt7RUYHxArEqHvK/LfOtDQH3qzEeSLXTr/PtDl4JRCOlVlhShQ4gTYOB0QQ1qQh0T/OxWTzMNj7c9ygl4sFGWudC97xJy1mikW/nJGA7fChF5+4Q03mdPBfd5aIfWxvJZzTVCSEiH9ip7K8M0Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E2RamymM; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axvwfv2CJJQly3rHJRBXR1QZaPjzqaeh6HohplLY2YX0QZ3wP4UISWo2MoBQ/X6BSAe9+1lKB6WC5Qi3NZYx2awBxOpBhYZK8raCnsqkJ705haOBeJZyDNkMl8uVMxRZ3tbMXWzkoow2oQdiHY/J46KFW4eF8bcnr75hyaEV/zC/Axj/T6qEDYWp6Idx2C6Kp1Q7bEsgP8+uPywtJ3PqFYv0+am2FZ56w5v4AMzOaEDUiOK9zyEra5vk4ZdK6zMMfvy+Jbp8BMoZ8lOvVLoZrA2RTiIY9QgMCp1c2sE9jwBHNSQdWjL15Vo1qOcn2BbG+qDODhL+KvzzJAjADH4rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuKPwHD8BCMhA/WWY5rqy7i6+sYURXBQ2sRihgwwoP0=;
 b=O6oN9IUVH3TnzkzG72sUq1x9utnXI3sXtCHtCoTPB74xofAmULgbtefPTGTz5B6tlR32sA03xtVUhEcssuTKzbFF/SDNNK1w++mUkhckDQ7qAFreyWlUGJ5uGvOAe9dstBaX+Li7emo4Awo1O2Vzi2XqOdJ8bsGyvaflJhF0+COjwmr42eg165W0B23GFYl9XYNe0cNgT91vVfdt403j1SvS7ZHcrPJP81xnK1Unvb82LoFfi+1xcH9+qMRyT+gvPvHlbEySZJHM6ICbylBi8PqOBO2wkhNv+a9+CdPP95q5lKhbFg7O/1mOz/IizMcfz4QcR+9jtDgf6RZxZqDyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuKPwHD8BCMhA/WWY5rqy7i6+sYURXBQ2sRihgwwoP0=;
 b=E2RamymMXLbhGBRBDUCfUNQ70wOuWb/AXSuOdJ3wK9jlf+yzlvJ5ChJLgh2sC2QT0N/CMG9vu9kzSwg3dHc0cX92iSTRByfmrGodalwjihC4SMp17PsYsSHg0ldxnV817SwqxhmHnewUlm69xNJSKS9EzBjBj+SeTX4s51+P+rQ=
Received: from PH8PR02CA0045.namprd02.prod.outlook.com (2603:10b6:510:2da::33)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 20 Feb
 2024 17:20:24 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::6e) by PH8PR02CA0045.outlook.office365.com
 (2603:10b6:510:2da::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 17:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:20:23 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:20:18 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Guo Ren <guoren@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-csky@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 11/14] csky/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:54 +0530
Message-ID: <20240220171457.703-12-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e0b977-c205-427e-83c7-08dc32383926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UbIkKYeCwiHzlOq4uurgPHm4I0prEpFU7fmWvG/JY2XAg3EUHFI5u0XiRoR1aIp2QbXyJU1gRfZ729skk/PO+cXZDfFDaJHUJ/0odWWHKEUug5Id1bVcqYuH/ZCoUSbcDVa4yynBdu93z7J5QsUayE3xyRtSjyX1zdMtelVdTWIIG19rk1NsqgEO0TyLkP5kBMyhsIPxTa0AD+RO2CFx01I3PK2IHLxcvaTiiCPIV+l4fGK4cRh3VyIIBzuuyYOraG0IHAgp5FCARI1Ff9W/iLN1cDzkHNvy46sYIZVW92T+80Yuuct7xVEbN7C25nXkEA85iCXEAKMDvscYOSTe7hEWto8/G99Tet5SeHpjzrECbnN42Uhjn36/Wtj/ecRA1cBqOCZWNwl+LYra0A2IoJojS5Duje5IeTxNTYlsyelq80gbq3BsjxGav2hgNf43xNDOYhCLHOcEXYYqWUrn31yioWEEU8jE5kszEdEcM6drxwc67E3Ep+YeM0M9hBKIywwwQrQCZPpN4DBYIDn/PGdBTZAOyb4a7NgF2z/9RtZwONdXbtc7/fdBcrFs912AJv8OXGHX1n6h8r9SO3VS7e0PuTuRu4I+HnrZEWVx3exg84Y63prqfnHl0QZQchauf7cIkY9XlfmsJhgCwo8rWahQZcHs5Y/6noz37J5XKo0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:20:23.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e0b977-c205-427e-83c7-08dc32383926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

Add support for TIF_NOTIFY_IPI on C-SKY. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Guo Ren <guoren@kernel.org>
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
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/csky/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index b5ed788f0c68..9bc7a037c476 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -61,6 +61,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		8	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
@@ -73,6 +74,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
-- 
2.34.1


