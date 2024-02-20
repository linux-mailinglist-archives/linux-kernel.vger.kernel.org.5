Return-Path: <linux-kernel+bounces-73425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD2585C26D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376641C2245B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141476C8D;
	Tue, 20 Feb 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qlaWNrQP"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7A76C60;
	Tue, 20 Feb 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449564; cv=fail; b=bXRBteYCyp6vgfJtCWIIKZYH81xhVyO4uqVKmeLIQ6pMShmttLqi4MZFBAcpzF1AcxkLWHzmEX6EdNZadyVsO5ZZK05akvX9wznq7/mtbYio0wmn48t0aevP2G6I/kjgWMG83+EKjVcW/Vz6kMxGFrQUP1O3zfXdwC1SApInqo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449564; c=relaxed/simple;
	bh=DMDI8E7jslPzeTepHfsONRA+jbDaJcCbAS1heHxM5Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1WgVDOsmLuI+dZDNC3aJMH8/jhCTwF9ygffRPNatjv6VnAGJwOR7hM9CpEy/pLfPjygMJK2AU2mwKJhVeGr/0mhseezxITjm/PinxZtJZL71GDlLICgkoXZEUf2DCKUFB/Lr3U3ESj/b329ZCJ1/7nZr1NrQzq/KpLGBoVCUus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qlaWNrQP; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axx25BCMz7AkcwC6doYX7FJieFsv8qO0QTNLAV/1hY5sy1f1eLMb47QldoabvS4p45HicWZ+CXaEO99syP2hwZyV6heK4FVwQGW3bIDPACPkXH9fGSP9bYzPsM5atLtGqoGLG+UaXCmnA+0Qzsl1oaA7FxzSGcxXi9Oim3cly1RUpWoGEOcn/i9brlSe2QsNhB7xVmF6K4YxMwkFROVfXNLd8FnuZ0Gx2TpLm+F3B3cEYNypxJmmljixuy6jezqHlrr0R0aZQpBwtjBOk69oKFKZ+n/uqol+NINmQtVPjwVY2+mh+etOKiht+Bo3ZfXjaEzdnX24vimafTq90wx56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGCVtOeKyckm5h/RRBMlLdaF8ZUAoTg3nZ3RDW0iOgM=;
 b=hOMP6Ox3K1JpoUsZuZxDecVcL6Dn62m9uaVYChSE/yQEAjiiazzeN/oZbMk8DL22ppwbi1qK5Eifi+++rWJGeXS1Q0RU4RyCBBe4A4KViYI/2S4YWmIoe05IRI5ebW01mt+IhIKb035qKa2kxq8ZonZ8dy1bvXSkl5GelMVxBvoHsQaADrlGrQdiyHhXLiUASdFA91KkioutvA0clGg0sYDFNOwLgSZCyPukbjDwYdCvFlXUf6iaaxPoregHy/a/kzsj8DHpy+0WcnsZeuCWoVBgNK9YNbKxBHPOpUlf422cxI5+spLVc1MtmFpWI/NngpjbCROBZXx6r6nK/1Mz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGCVtOeKyckm5h/RRBMlLdaF8ZUAoTg3nZ3RDW0iOgM=;
 b=qlaWNrQPqoSaH5HIdU4IV7ACGKcVeH3+s19vkdQaAcnRiZ5T6DGFjnTTrLI1htefhs6W8wHJndbgEaq8aredGpHJQf3ySZwPoFCIhjSgqGXsjc6jjc/P9D93237oSsRm39fXbHgXxfkwlbtUE0HrsOgO3wUFNIm3UfAVK+GldhQ=
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 17:19:19 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::8d) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:19:19 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:19:11 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Daniel Lezcano" <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel Bristot de
 Oliveira" <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, Nicholas Miehlbradt
	<nicholas@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 08/14] powerpc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:51 +0530
Message-ID: <20240220171457.703-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 298d8946-e44d-453c-b049-08dc323812b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3wZ5JscQM9q5Ne+uB84OH9BSDDwHT8EoBCAAmB/PEJ26NITdQw8Gh5yMxJFplRTQawoRpsl9dfjTWU/jrTZCW715UW6m2Q21snXndMAapBfuQOq2EDV+al8Pv0RT0Mp7COcEJORb1JRWPkNIshNXPELXkXYy6BuM8U21YGERABMvlpdQzv9B+rvV8EGFmvmalU6PFN1PCsH2BaC4oRR2+LJh2zKv5JHjJUFs77nwDtyLBsEiLX6dL/k09MLjpmxonFxGGniOt7EQjXrvlO/jDWA72G3x34I0+ooOorpvHEc4/kXVrwjr4xTu9eQmiV/NqIpzGTB+DgCFlM1njOTpL/uBkdUdiny8bZqvVOC1jKl0UnBXrlqL+Mpu1KrIzwfCrBlhyPDc4wGoL77KykIV/+c+pWj8muBJXAN+TOGnVDoSwuNU+ECfTDLeEJRwogVNGA004HauY6I5F9RP7f2kqI7qGabAfdFeAOt81ZRstu1cwCAUBDaGcxdu6HZ0VFB0+v4RcaLiEw9D3h55z7DGmjVbZKzDKfImVu6gFI/oIpfa/GN/TfHTypSHx4o9dhSBexcZIhkn6Wvg6BKB+gkDmF8Nwe+B3CItRSOgZnIW9KiaSrmt5I3AsZp+0FUThyKe0cdUow8+BW5ZNpidvYC30zdT7rQJz6FPDqTlp/yEbZk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:19:19.2088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298d8946-e44d-453c-b049-08dc323812b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

Add support for TIF_NOTIFY_IPI on PowerPC. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/powerpc/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index bf5dde1a4114..b48db55192e0 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -103,6 +103,7 @@ void arch_setup_new_exec(void);
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
+#define TIF_NOTIFY_IPI		9	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		12	/* Force successful syscall return */
@@ -129,6 +130,7 @@ void arch_setup_new_exec(void);
 #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
-- 
2.34.1


