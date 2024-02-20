Return-Path: <linux-kernel+bounces-73421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C33385C25D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1301F235AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC37762F;
	Tue, 20 Feb 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZTXrSGi"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528176C72;
	Tue, 20 Feb 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449519; cv=fail; b=nirbFNc3DHYzYXpCYDA9ljmgRiI+jC6eeeMXEsEN72fDlvtuJ8GcE2R03ht9rkTKFyyo/fhDKjM7Vje3BvKAiosVzRGt+dkWhpJZ4IICmpfFMIu+TNfES+njvJvPEkwllIYmBXB4vqW/D2SaLF5LK6y188r7rjLBRQT42v4JNd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449519; c=relaxed/simple;
	bh=+8EtkuDL9hV0L39gAigybv0F5NHyhF6vzfYF/RW4LvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuHncHO1SFECuqgfW5N0c1Ez9Pff4eR5Jfc8BIaUJl2PLXe+9wFUa/JN/TQk5XbsiTiGpPezz9B1iRXUcqyX37MztbhZe6tGrwz/0+1KMb8dWA8AcQ5ALWNAeEZXkYd2sqFe2K7tzYjP/R5wCyGPSuzfJoxfgXIqzmeWgDQadtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZTXrSGi; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ptak/+ry+cibyj1vuQYRolHes0+4MMmsYA+eMD2tSknQ9SaiT9+texZeDVl/BimjR51SqvYG5MOUCPEmE/u40MznMAc0MAJ1WkCdYCz4wFZaIZlWaVmWDobPrvSSO4/ZbvfEn+C7PAXVbYV/KUHEsOveNrBy0a7u4dmc5rZAmlJb6a4NCyK+9FzE/GC5AKsKZkfcCYzyvR/kphv1CXsSccdUrkhFSJ9ln3F7u3caJ69lkMWOZZAwL5Ob/aBJbIwk3WYZjW79/gD3B4jZYOp7vRW5fPXGE+VJBVBoajHp5fJpc4Znz7FOEep6I3e125+j/aDsmPPRuHAlkToNzle5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJNpqR2gtovWArCftHGaCuq4yCd0Z6OhTytSKuS1Oiw=;
 b=eHbHsNnyeI6KpSbqNLbJw/BVRleEqVS+hxZqRFqeW5e/tBQyzNVkOrMHrvP052Md/g4PXn4Z/M/HrJcFzvht+2s8/z6WMmL4oV3TohSLplb/kkDf6R18Wyex/6m0IdIih2ByRaN4SYd7sYQ4ZlltXlmhFjGJZaO3DikayBT+U5dOgSh+8PIfY4bJdhXLJugOiVYo1Lv1rkrz4UASjkrZ3AuuVPxHJQUIahbasl6K36WKQHAAbh6l/KP5VMO2sOgBGOg+rNmT1I+QfJYrF5y2A3R/sL4J0alPRO7MtyL6l62Hz6zVwv9Ke0nsMjZxz13nVgwX/YDCmx4TeFSqhGT2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJNpqR2gtovWArCftHGaCuq4yCd0Z6OhTytSKuS1Oiw=;
 b=CZTXrSGi9aWgkUI+oLmJiOeH90jL6EXkpXT6FkdX6gvSeuYcSEQeY3DRraZb+ZAoIVOzdQnO13ta1SANnO38Bf+fGor9K9chprKMmM6MoEspgScggUpYAyDTK/Tnkuni9b1ieITQjnOJGSVlXFPtOoHpMquHk01GmYiVkipGBgM=
Received: from SA0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:130::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Tue, 20 Feb
 2024 17:18:33 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::fa) by SA0PR13CA0011.outlook.office365.com
 (2603:10b6:806:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28 via Frontend
 Transport; Tue, 20 Feb 2024 17:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:18:33 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:18:27 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	<linux-alpha@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 06/14] alpha/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:49 +0530
Message-ID: <20240220171457.703-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1b40be-f2ee-4042-10fa-08dc3237f73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y0O87QMnqS5n+YlTdf70uRvMGSnE6brelmhg0L4/6qdphP7Nyl85iUdffg289sceCBjH4UuntD2XvgJF6nnA+IXdduyFvZZ9CTzkTBkjXBh2afxDZb6ofY+Ei6fKI9LOEdr2N6PaXlJd4P3Ka9hM+jRhIcu5jI99ZC4gtn81O44PQAvkcHCGNP1TCDxSn5YOt+TBhIK3/IBSoSU1KBg4AjXKFcRpNFCsSons1N/e9Q/AKvMt6IejBSyOI9xBLdclHPBd3iSaSMrqLuC+o/Hu8zEH+0ee2G6Vt5ENqsTKfNCNhW1fh18VKNYcI06waa0+B0izSs4Xvhtr3CAjhCcJxnVeF36nodMLD3yJMefGxJ/pB3FILxJ5ZqjKhKzZtcm/Va4HuLPk3FKxobHNA2za7i+Z1dOCTNKhANhBq/Ybhk0w71yxeoKgdPEnwwBo8hDBlusoPD0tLWVXPBVBOChyop34iYdTbZ9We8hfvPcoTcpd2ymQsbcHvTrltovKuIwCQkrl6rYd69xQ9PzHwAJf8oH68nCM4YRsq/5b7Mu4idYTxTYUBjOfSOB1TSLWFVpEVQal5xWqZlW/fZf7s1U/ocGWp/I7gUbb0yMSDvF+mL3IvTkZcm2x3GkIXyAFTkufmwJEe8zCWYzwL9B2vG3arM4H2D3aDzVnZW4zjirb2d4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:18:33.1576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b40be-f2ee-4042-10fa-08dc3237f73b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Add support for TIF_NOTIFY_IPI on Alpha. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
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
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/alpha/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 4a4d00b37986..8c17855c85c7 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -64,6 +64,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SYSCALL_AUDIT	4	/* syscall audit active */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_DIE_IF_KERNEL	9	/* dik recursion lock */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14	/* idle is polling for TIF_NEED_RESCHED */
@@ -74,6 +75,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* Work to do on interrupt/exception return.  */
-- 
2.34.1


