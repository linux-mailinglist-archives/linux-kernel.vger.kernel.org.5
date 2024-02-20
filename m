Return-Path: <linux-kernel+bounces-73431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB885C27E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A26AB2450F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317276C72;
	Tue, 20 Feb 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWZ+ckhr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE176C7C;
	Tue, 20 Feb 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449694; cv=fail; b=h8w0DPmweeJX/mV6Q5+WDxvjgj7Vamb/c92Yil26vWLiqWpk7d/OjM29v6Vk8tVgOUcwCz4ia1VqWJUjyw77RyCZPSbY13YndjbFqK2mbX+6YdpSxXzym7TwP7WX6w4fuJrEocXTzZ5zAqc3EmP4B3USC38XVrjAr+Gx2BcUPJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449694; c=relaxed/simple;
	bh=zB5HCu8lq8m4vBYi/4OiSqE5cfAkKSQqfZo8cLf/lNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSINrWdMjqC/8K9rqPieL43IpQPe3w1tG+80xxYOkB8bBPXgbYB8BXlsJZkvlABbkF7HmdcBye93yP4Rd1KzqtjEzWGkNsqHFaKstpjO3Qy2ewBA2su5m2gi2yrqHa+9ZmTX11hKSjHiUxKx3nQwc7Gr+afYsp4AnosWZFFI9tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWZ+ckhr; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHBzc09kc4uJhALUrynhh6qiCMbOjYmocKUl3qObm1PztqMzGNQKs1/vowM0pR5cxG31RoYkKpY8TBpkpnX0gGwMTDIsmSh578ohLn5nr4B5Uxu50Kzjas1OTjjUj+9eyQMSuD/pb7XV4YYaHzaiBsQoa3MaqsCG1FiiQMk2cLmF/mxlUhmZ3edWkhxXziJEtRXq5ynAdfYYMcjHDuRVs+/AJkbDzNO/PkMo6CYo2Vbg9NnuWDBO+LdYceGvNvtGamsCCM8zk7dBElwwY7ujXxh538fQeJs6oDW25Cdur0f7bZrfjsuYno/JahWsVcMlvXp9hii7L163VPEA9dKUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZtcJG6gt4MGWD2GGDgFRpfnSYpgQ7vdwijBj/DzMOo=;
 b=VJk15+jAB1sZWBR/RSK/Bgw0XPHdi21PTsi4pzqPzHGqttONH0BqNJ8nNE8eB0hBvSdAxsPM+p6PJYtXHcijFkqCbDCMGdaIR2n9H2mgRCXazoRz02RTNk1YbNQZhpCBxDzinq4DBEwFf9aOLxq2uMV6VttyLFzpPPaAMqFKHCTyy4122CunWtYkT4V6vryuqa+wr0adAXTVul8qM9lwhzcrzRkyjc8Bb6uVa/16w55VHp8vOexxstG9LYFGq1E5RketxHd1oi+YUNAqK8qANITOrZtXAEMCdQT3NbU7hFiz8owKP0CiDJh5tZG9TK8eG3ZkQhoPYvomlyz/y/Poig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZtcJG6gt4MGWD2GGDgFRpfnSYpgQ7vdwijBj/DzMOo=;
 b=sWZ+ckhrXCTxQcBpmhKff8VZJIgEjXm2tpJmBdqLlZctDpwIF5s4j9lOoGf8TnIbJmc+4QJRCwwsTWiONXxw/0DhIBg0nMUmwMri82SbWJmEb0GDgXZB4Wle6fH5gLkNsV6tyNizJZK6dOtQ5aHn9xZx2vvEiHYp/X03TVNN8vs=
Received: from PH8PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:2d0::25)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 17:21:28 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::22) by PH8PR02CA0016.outlook.office365.com
 (2603:10b6:510:2d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:21:28 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:21:23 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Michal Simek <monstr@monstr.eu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 14/14] microblaze/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:57 +0530
Message-ID: <20240220171457.703-15-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BN9PR12MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b945c27-2258-426b-bbd7-08dc32385fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nL3QqxHgKrMwekLYbHyUttd6yXqk0XCGJKqhHHEPr8Bo0A05W4jF1TLefwN9YQfPwJ7XZNpJ3q/p30l76EIdNKhQ1b64pg5PLz9k19ftA+S6aPboXSXxDRaM23cgTfGusP9LY2VKCkpp5i2fWcX2M/Fgkf3cl7K/GuN9T7HHB5YJgd8cvkosInHHh8ftN5MENr1Gai2HRW/c1bb7gN/9oJLM9wEwnC/2gwRRzE1UUsKh7TyjhfoN5QOpSZ5ruK7Ssv5En+Bk5h9gr/C7z4lw3XwwVhEPBUF513OS60MzrN169RKev1VRcMGwLrq87r4ejONi4k4ERwXrpwQ1zFZCfB+pHELlSWVjBBD9uX1H11oEFwrBuztHhrwBlSWQEoXgu+taneacTPhk7SIIZI/ASCEUm5gJDlnuMuGzAB3Fi5PiQJAy4FFrgxNPrEd7hGb9WsZP9Q9+ppUnQ5wWrUX9nicX5AhTHMN732Bw5NPVv3kdmIjp4Yrxy9vdHc7n9YCUnxtNd6AP7o+lVtOgwYre+UzAfZ6NeSnTeHMnopb58CQuc3q6/lGzY9L+NVapQ0MkNIOhF4JoCmFWNboA8E5socuaft2gfG04OhQCGZ0ZxD3b8kOfwjkf4q5rLfv7ZdvGLTJFX7kPnJU5OdJmGYIkOae1U5+4K8b8Coe5NjI2o4Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:21:28.3422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b945c27-2258-426b-bbd7-08dc32385fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289

Add support for TIF_NOTIFY_IPI on MicroBlaze. With TIF_NOTIFY_IPI, a
sender sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Michal Simek <monstr@monstr.eu>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/microblaze/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index a0ddd2a36fb9..953a334bb4fe 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -103,6 +103,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		4
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
+#define TIF_NOTIFY_IPI		7	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
 #define TIF_SECCOMP		10      /* secure computing */
 
@@ -115,6 +116,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-- 
2.34.1


