Return-Path: <linux-kernel+bounces-57286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1B84D626
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619A728998E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CE200D5;
	Wed,  7 Feb 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7ST32eq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94220321;
	Wed,  7 Feb 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346616; cv=fail; b=HYuLPjSdN9kYO1ZgqDoRLPT0XQyLoUaR6W753K/fgfAGjv7ofT981EPQCFfdsHIK4Q8TrzG+BVbFjhJhal9mNbJFWAn91qzmFnnGS2cjKwMHMH2W0YH6NCeZwpWlDJPkDwEHfZtbrWLuGwKQQHIpeh/ZDKysAdaE3FfFqGyHKGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346616; c=relaxed/simple;
	bh=/IaD9plDDZKsEd0TBtj74+KiWP909ThCo1jVK6eXHuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7KGvpF3FnaQxi/81LkP4NQvRBvorlVF+eFHg3lgB7EtLW614z9tLDrN38oa728vcRxSQTT9eYpWxt5wCpKEEZweZbLfC3WcJQg7RGc1C6l/mCTLfCL3CoDWt4tdZ9NBiJ4WxC05y/UrvEvUSUNK32WBFmwFVM7VXpkHoxwy1cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7ST32eq; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAo6hGaPfUn8xiFXQ7Drb8MqMHisFcm2WtJ8HDc+GElZGLm11VQ6m6lKvVUQt6io0Bm0UeQaZDx+BCx0dz/hJ6TOQWW+BpuOEwsCcEs07VnV9FJLKPLRB/5LCMs9+c5atd1uMRObvjF93Pri6OLahpIBqDR9fnbKGlKoGRcJkvgFjNWyAxZxJNuLiMwF+TTlIfdxz0F6zCZK1citDc41eoJe2p+3/1BCnUgrOqKjDjP2GNbFKGiqBmBoJxJkkhE05U9Myj2RGfxL+GglBiTOa9jOmaYpIwJN/XznCcWJTNSZV7+aJoHIY60zNEjA9UpRRPz+xM2KxLAGW6m7JpP55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdLlaJ3qgEQXIuxrrjF304AlTozbs/GwbO921UjGhr0=;
 b=al+TmkMtwx4FM8klaV9K8afXXo+wdzL3wwBu0DTfzOxWbq2McfKbs0Re8+IFH49gzYLapM/Hc53MCMnyF2uzWhh5EJVlvM8wAf2xWEQD9CJl6lYb4DbhYPWOx/2+g0nLlMucTgY4FiuEKpTgbI/eO5B3KIYAxPrHPf2X+n+8P/dv3HGU/++dwOv6qEof+T+YEJw36nzi/lFe4gauIEfCZsOzVEssJsnx43UjXvpAfcfgVTgjODbA5nxOnE/2XhBrHsXGM2FD0LfSBz7yFZqnUDazNNeg9hRlOUJ5j0bhaykeGe4hWJfkgAecYD2Cg5jvanFa8lR9MP/qf38MsLqraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdLlaJ3qgEQXIuxrrjF304AlTozbs/GwbO921UjGhr0=;
 b=l7ST32eq6nymamis6ubDWo6dzjHx61a1nXr1LczEXiBHWru3uJr7KS4hEICLedhdNSQ3Aj1BdKEKbmWc5PmOtS1nGujhj2ctRNudR+fPghXa2vZjAMUc7+XohGMxJi4XT8HzXFWrxQyq2oRHeo7qOW345j8CmEA0BCKQvzSjSQE=
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 7 Feb
 2024 22:56:50 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ac:cafe::37) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 22:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 22:56:50 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 16:56:49 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Date: Wed, 7 Feb 2024 16:56:31 -0600
Message-ID: <20240207225632.159276-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207225632.159276-1-avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: aac2ff5c-0399-4f2f-8052-08dc283011cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7J9hoUL9Dqm/JxuAQvfl08aWWHQ4NgSciAzHIZ+jdiZA0DuLR0j8I8mqEm1Csb0UGMsJ23zjUFu2h4VnUyFNPp8SowL7iBeTRRDBFNuT4UaHwMJA8JlhiNr5Fju9Qtk67gXNN6lTIU+WSNri68jgYKt7wcDfhc2q2vOamsA+dMg/ty4O7hpqfwYsU30oip+cdluVQYrZcolmbtRr72q9bglimwnefiEmGk2SDDxwFjInEUPelT97kxdDLvc7/TLPHBEwX2CWSO5lnJt28FGd/NqjmbV6vv8EnED6fUjZuzkS0B0qeqHPTummRWmvsGKEOtmvzAtrqYIOtu+SIEq9WDo9OW1shayYV1K+Mtl3qs9z2sgtc0vTiJyygoS4kG4oSZHXLzFGWZiKv77rtlMgIybciSLG7VnVBotJ3SMqrFJoKtV4j6GYG5Av79KIVYFN2gnYx6ExJqzBT1O2Idi6Dtzk1ouf65518L8lrnMPFO3wHzS9ZlMrRAAfZh2WyliZWQbuhrMQ/WsWRfr8UOx/i6YkD0Xo1AyL43rY08OB1ZbrrMXqUNXNb/iqb4uJizxP+h7D6gGv7b7GsqVOGHCWmcyQx5ZILmFdQWV4Mix3vUk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(1076003)(336012)(83380400001)(5660300002)(70206006)(41300700001)(478600001)(8936002)(4326008)(70586007)(86362001)(2906002)(8676002)(44832011)(36756003)(110136005)(356005)(54906003)(316002)(6666004)(82740400003)(7696005)(81166007)(16526019)(26005)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:56:50.0739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2ff5c-0399-4f2f-8052-08dc283011cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

Currently, 2 pages are allocated for the MCE Records pool during system
bootup. Records of MCEs (struct mce) occurring on the system are added to
the pool through mce_gen_pool_add() in MC context. These records are then
decoded later, in process context through notifier chains.

However, on systems with high CPU count, the 2 pages allocated for the
pool might not be sufficient in some instances. Successive MCEs received
back-to-back, before they are decoded through mce_gen_pool_process(), will
result in the pool getting exhausted. Consequently, some MCE records will
be missed. The issue further intensifies since the amount of memory
associated with a system typically increases with the CPU count, thereby,
increasing the probability of MCEs being received.

The limit of 2 pages for the MCE records pool was set more than 8 years
ago and has not been revised till date. The CPU count and the amount of
memory associated with a system however, have increased enormously since
then. Additionally, the size of MCE Records (struct mce) too has increased
from 88 bytes to 124 bytes.

Extend the size of MCE Records pool to better serve modern systems. The
increase in size depends on the CPU count of the system. Currently, since
size of struct mce is 124 bytes, each logical CPU of the system will have
space for at least 2 MCE records available in the pool. To get around the
allocation woes during early boot time, the same is undertaken using
late_initcall().

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c     |  3 +++
 arch/x86/kernel/cpu/mce/genpool.c  | 22 ++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5cc557cfc37..5d6d7994d549 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2901,6 +2901,9 @@ static int __init mcheck_late_init(void)
 	if (mca_cfg.recovery)
 		enable_copy_mc_fragile();
 
+	if (mce_gen_pool_extend())
+		pr_info("Couldn't extend MCE records pool!\n");
+
 	mcheck_debugfs_init();
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..aed01612d342 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -20,6 +20,7 @@
  * 2 pages to save MCE events for now (~80 MCE records at most).
  */
 #define MCE_POOLSZ	(2 * PAGE_SIZE)
+#define CPU_GEN_MEMSZ	256
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
@@ -116,6 +117,27 @@ int mce_gen_pool_add(struct mce *mce)
 	return 0;
 }
 
+int mce_gen_pool_extend(void)
+{
+	unsigned long addr, len;
+	int ret = -ENOMEM;
+	u32 num_threads;
+
+	num_threads = num_present_cpus();
+	len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);
+	addr = (unsigned long)kzalloc(len, GFP_KERNEL);
+
+	if (!addr)
+		goto out;
+
+	ret = gen_pool_add(mce_evt_pool, addr, len, -1);
+	if (ret)
+		kfree((void *)addr);
+
+out:
+	return ret;
+}
+
 static int mce_gen_pool_create(void)
 {
 	struct gen_pool *tmpp;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..81e35ec58ebc 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -33,6 +33,7 @@ void mce_gen_pool_process(struct work_struct *__unused);
 bool mce_gen_pool_empty(void);
 int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
+int mce_gen_pool_extend(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
 int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);
-- 
2.34.1


