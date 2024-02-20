Return-Path: <linux-kernel+bounces-73423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D985C265
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE07F1C212F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BB77634;
	Tue, 20 Feb 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frgN18bT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4876C83;
	Tue, 20 Feb 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449542; cv=fail; b=c9plL7J2B3ZHO9JoCqfXsSKwI9r67gDMqYruIsNsQ9/rC/O8XiVlPfN/p8Qv+jUqy8YBnynCBLCgYjRZIk1nLqWlHUwaMABYfW3KG6GdDjGIfb1GiTT5Z6hAApsJS6ZkB8HEByYj6865DmUlWCC7ZW2VU9pgN33XSH+fqbniBUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449542; c=relaxed/simple;
	bh=CwzG6ydWsv+EKOLi+9GDLbPaWIC3g3eUihWf5naV0b0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jq0oK2RLhTXXP9GbE9FLeD9BH/Ff8V5pM91u4ioZiWw6UMHjH1ViKmWGERnoSXD7BOTEWxDVircq0xmj/2WPlWsx+YxoOYwtfeo3zhOCvs7HElrvCRqsHt1+mLwK/+gSjzVCo9MdNd/PE/MuTFTjAiV9u8KU4XY/fbITIPzhHAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frgN18bT; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7qgOHti9QW81kwk8PUVKXGMsV0LFORfbEsrBTYVMdDi6RQaG4bt8vL/TbLA/KC+zGhbcZeOmJhcmPFhfoRM407P8U7+cP0cjRDgg7Paxq1+VE4AxD2x5sy+t+TZfE+mkJh1rz70qSpzvTTwBuU1hOriI4Yfn0a0vriON8K7HZ0HwszZgHbM+waLvdSu9Tw1sdgu9ueDIuMRx0RvDd1aijFwB0dI3N3DYXQDBtyUExuqscsL4D/vAYrheOpGRYXi5n6f+cLIYEdfQ6f2fnBUVp0lVIrCAhB+NNOQHm36D0TkeJtb2sHOjXIp/2JEvhR/xIhcpN1+0VvbJzlsML02fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6czL3dpK2EwlKPguEMMqCsMLBLCyWcEF3F3TT793Pv4=;
 b=LCgv2qZV2vZP0Rt2tkHJ/4TP/saJRjCLS8VjujSHkyE55o6m2HBjaAvKCV+WgX9Uw13SQesB3EMNab772JBn8aLnXWS6kDkXV9Q4SLMOm3hwWhdPxSfMoOL33ktwOrwgzxVIQKw2CBMC587D7Gz9L4Tf/trJ+nlFXV4DtCF2AY13X7VXgldehjWrPO+jPxXOXJnNHcArFR8wQsVPDuVhyFm/SZW+dmutEgGCSU0pk9lR4tvIFNIrYKd6n0gjH335CfKZ40j95FqvM6lO+fOz/aCaOi2rlirWme2NGt8CZRsliI5UyL4QeUkOf07LGy4vPe2gavsn8shKXWYKoXRY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6czL3dpK2EwlKPguEMMqCsMLBLCyWcEF3F3TT793Pv4=;
 b=frgN18bT8FLRDetMtfPlhveJ8unttgXomZBIrBMqQfDBpzDER7ZlLpDN30x21jcpzZgM+F2AXPdtYnQRFJ3fuNV0erx4vjAqKpHAF+VZU0pqjOohtPEFrjTkZ+Q7NZntsxGLxMlbnLrJ5R6h65J2UnNvZmKQ7AB0RQfHDISCdtY=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:18:57 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f0) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 17:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:18:56 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:18:49 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Jonas Bonn <jonas@southpole.se>, "Stefan
 Kristiansson" <stefan.kristiansson@saunalahti.fi>, Stafford Horne
	<shorne@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-openrisc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 07/14] openrisc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:50 +0530
Message-ID: <20240220171457.703-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 872b0406-2ebd-4595-99a9-08dc32380504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xL7zTcZvsKZJXDntHAfXw7E0pVyxKWET4ugkR3Jj+tmg7XzgEofi5jLlq8agt0oOAVW07xT4x3uYs9UpzRVN+S5j5SM+SvL7ANYbKpcvkf3HJc0sc1d6e3EgFMZk56lflChJd6h4UFt1qb/6LNwRj0bzK7Z0CLf6urSuBZHG9qxojGfe3XG2P/kWzYyFeQniMOGnYXuqeqPaDj+6eGNtflSmos9Y/zGNy1/YLfVgQtDePwEurJd8boLnufYMCjKK5uPNEqBaa9Jshy3rpb3kbNt1MxCdSMU/kmbivo28BGFeZIBwe6DWRTtBgJv6mRsv+0DSvkWcaD45vnEtli6Uf8aRAjZEklmWzhqBU30CFHXQ7XAjB+7YCjDsyRCYcTEOJkCsSObnNV/OMIhmx0olEU3rwj4BVhX/YBkLLF7yl+Ppvx+5xrOtGB4vEbNHV0TpA+MRvAsyd6YCAXNKl916W+uxvKqQp1iE+Ly2HPzu+nL6RkzNyzhbuK0o8DtUswnPKVXZHlD2yFczcTiMllQxuhXWvRpBdradujffoxhLe4fihhE/bHX3kU75k8nNFu//JGvbCeC4GeqmGd692+DHk1b6X2Xjt+DYC7flGE0WqWKWcLDxZtpPObUI6yVgHxFaqXYdOiSouxUynAlEj47cD66wSjVz8BtkQ2QTY+3G238=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:18:56.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872b0406-2ebd-4595-99a9-08dc32380504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

Add support for TIF_NOTIFY_IPI on OpenRISC. With TIF_NOTIFY_IPI, a
sender sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
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
Cc: linux-openrisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/openrisc/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 4af3049c34c2..6a386703bc43 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -92,6 +92,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
 					 * mode
 					 */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SYSCALL_TRACEPOINT  8       /* for ftrace syscall instrumentation */
 #define TIF_RESTORE_SIGMASK     9
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling						 * TIF_NEED_RESCHED
@@ -104,6 +105,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 
-- 
2.34.1


