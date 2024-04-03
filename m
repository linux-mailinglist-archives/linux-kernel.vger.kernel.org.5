Return-Path: <linux-kernel+bounces-129611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B3896D47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D0028FAFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C813A417;
	Wed,  3 Apr 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xABjMrox"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690541DFCE;
	Wed,  3 Apr 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141555; cv=fail; b=CNmtECjz8N1YoKZGTQ2hsfvsN26+3ZZmiOvHbLXRV5so8jRPXwNEkX4KrKZZ8ZUqqgoq+jltVgpti0AuC8qBM2T+2gJHYdOYwkqhkYF7CiGeQvGcOaV9JErDerKpG6UHGENLVHGn/ZRC4+e3pAZhj+tpISO7eFxhV51D3Ay/O80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141555; c=relaxed/simple;
	bh=t9MDU+qklGaS7PT/MJ+lnbuE1x93CJ2k1EffQySySUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4GEXCyv+5q6IVVv9WRoQNVTQuo1xjfg9DazkYVU3XM/qQ1STITLxIyQ9/y/HOmPbEQjOz1HeKuE3L45KqkyTsb1eBFlU15u5l/bbZQobeSGt37IQ56zYOAsWVcn9+D7WgHDJ/OvOyaE41eYTUmEcnyceDXqzblHEy8auuNxDsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xABjMrox; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8V2x5JDHh6dUygHDHNSgLNmQgwJ7TWqzsr5ZQYrgS4Bov34cKJg+GpI5TW9q5zU+9LzyRUd2qSGSLPUjAUMeGUnwrDINp5JnDqXOKJiRHVPzccY2E1Spf+iLpWyq53Tc5DNY0iHUy9JBnls49r2ueAp2VvBLmiEWj4sExH1TivxwcnaUV/KpviTsyyHLMexkNy4ZLyW4D/62vWeRmIx2/q3g/inLSWEld7kIbjCmF1zn4p5XrQxD+M7nS9LIN26udbsOE9fE0WfJ6WGZfPfRxOTtMpfFaT44CGHR6wibvVUmYHSx/G4Mejc1Oky6QRCTPzw7AI2VhzSe03bKTLOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65sTwRPcmWsCQeE9IBiQBWqG80QjtNY6KXKiDw5L6v8=;
 b=ScH/HeiNmKGcD81tmioIV2DMcRsXGi5S/yEmRS4BbZN0CLOnVTt0YKA0oawHEJAy4UY7C/8au1U2G/SUFkbAJfsORtqijSoQmjdS4X+5dnz9AJbfOtU586iniDfsoZ1RYmtb4Jok9kagHb1SIwFsV8YVjSrsd1sokZYld14nrJ8H8HQX21MdiFqO+7yVDEuxnBI+82CWYs5TGS+pv6pAQG+4nZrLDaL0B+uKw/PRq4CwRW0C5LB8nJAf6NApHo5JvWE4amMCjiujvAWkTCXW2obzyRVygz2WECrJbcxls7ibx0zeP5kny6jjq512ZtevRgA6nBdLBoccK//6Uc8qhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65sTwRPcmWsCQeE9IBiQBWqG80QjtNY6KXKiDw5L6v8=;
 b=xABjMroxNWLKXjOhk9cmcxQAxfx5crkNo6Fq7yDRjlxCknyNb0/Mp3SnVAkof6s+bANthW22ZbGH1XIP/kD2hA6ALKl7S6p6fBxcen8sta4yAiDSAC1X5hGijNpuQPYErwQMASjqdx+e6JTS8h2k27Fhw7syv5PBDkV+vC6P3q8=
Received: from CH0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:610:119::8)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:52:30 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::e0) by CH0PR03CA0380.outlook.office365.com
 (2603:10b6:610:119::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Wed, 3 Apr 2024 10:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 10:52:30 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 05:52:26 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <paulmck@kernel.org>, <frederic@kernel.org>, <joel@joelfernandes.org>,
	<urezki@gmail.com>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
	<rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang1211@gmail.com>
CC: <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<neeraj.upadhyay@kernel.org>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait heads are in use
Date: Wed, 3 Apr 2024 16:22:12 +0530
Message-ID: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b996f8-8449-4ae0-93ca-08dc53cc290d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HjUzCN6z5BAzUXF9//v23b1DXdmBkbtpI+hnQ1gJue8n9X4zqEGiFOI7wbhcT2qzep6yOCZwfCbuH8KC5hq0ZNDkmcqm7ZCE2PXVVlm4w7kip1jPDV4Z1UQgP9b/qdMjz6hoG3j+1kUe6Bz6KiUfiYmqpxE0cwlye9cNB+zJD8r2jgi1sYR7+XXdy04ZP7vx+BmqWm/030UbcHoAKx3SqhwpTPt/mqvVKYBcwbNE9SPLQn3nhICUevZC6hSsE6KRoHTp1ew32BzQRI3x21KMD5hMbmv0I2TZuiUnXsCQvNpSDUtOkj7ozZmi93DQMTg7z0yV4zsyJBGgm56qLz98gk7y4/RK3HqJ847LKldcScUA7zCkq+YO0rJcTFbpZ1QsuUh8Ifvgzfvf84Zpa4rtu2Q5d4J0J6xuEze9LsG7NOEQ5R4lYSZpz2bB3/X3nKASln95tfLrqWTOoS87YOmK8tea98k/HHdEBNOrhdniC7tmQcHqa42rcyMuW6HYFnC4y6JY0tm068e2fR78XVtXxzitHsaUtr5o/lcMcEM+SIgJdQQ/WZ7pRlDyPOZ5cdxLOadq0cxlR3jljJY+tieKk245yTF+320escELCYNmWz7C3vB4m/jVtjj0U9EDTr7M8fXYBtmV2vgD9H4I1EdLtEeV5lbYw7yXjogjrJC1mz37ceYz9HstgT7hpZrKyAQZHQrNupKjeao26SjVyS2ZVC0pXpOKt4uFLCkgCtGEm5qImUMO4feYKPRAZ6jS1+4qar1CMvVVSP+XPctKCBAQYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400014)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:52:30.5394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b996f8-8449-4ae0-93ca-08dc53cc290d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

When all wait heads are in use, which can happen when
rcu_sr_normal_gp_cleanup_work()'s callback processing
is slow, any new synchronize_rcu() user's rcu_synchronize
node's processing is deferred to future GP periods. This
can result in long list of synchronize_rcu() invocations
waiting for full grace period processing, which can delay
freeing of memory. Mitigate this problem by using first
node in the list as wait tail when all wait heads are in use.
While methods to speed up callback processing would be needed
to recover from this situation, allowing new nodes to complete
their grace period can help prevent delays due to a fixed
number of wait head nodes.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
Changes since v1:
* Fix use-after-free issue in rcu_sr_normal_gp_cleanup() (Frederic)
* Remove WARN_ON_ONCE(!rcu_sr_is_wait_head()) for wait and done tail
  (Frederic)
* Rebase on top of commit 1c56d246027f ("rcu/tree: Reduce wake up
  for synchronize_rcu() common case") (Joel)
---
 kernel/rcu/tree.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a7c7a2b2b527..fe4a59d7cf61 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1464,14 +1464,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
  * for this new grace period. Given that there are a fixed
  * number of wait nodes, if all wait nodes are in use
  * (which can happen when kworker callback processing
- * is delayed) and additional grace period is requested.
- * This means, a system is slow in processing callbacks.
- *
- * TODO: If a slow processing is detected, a first node
- * in the llist should be used as a wait-tail for this
- * grace period, therefore users which should wait due
- * to a slow process are handled by _this_ grace period
- * and not next.
+ * is delayed), first node in the llist is used as wait
+ * tail for this grace period. This means, the first node
+ * has to go through additional grace periods before it is
+ * part of the wait callbacks. This should be ok, as
+ * the system is slow in processing callbacks anyway.
  *
  * Below is an illustration of how the done and wait
  * tail pointers move from one set of rcu_synchronize nodes
@@ -1642,7 +1639,6 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 		return;
 	}
 
-	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
 	head = done->next;
 	done->next = NULL;
 
@@ -1682,13 +1678,21 @@ static void rcu_sr_normal_gp_cleanup(void)
 
 	rcu_state.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
-	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
 
 	/*
 	 * Process (a) and (d) cases. See an illustration.
 	 */
 	llist_for_each_safe(rcu, next, wait_tail->next) {
-		if (rcu_sr_is_wait_head(rcu))
+		/*
+		 * The done tail may reference a rcu_synchronize node.
+		 * Stop at done tail, as using rcu_sr_normal_complete()
+		 * from this path can result in use-after-free. This
+		 * may occur if, following the wake-up of the synchronize_rcu()
+		 * wait contexts and freeing up of node memory,
+		 * rcu_sr_normal_gp_cleanup_work() accesses the done tail and
+		 * its subsequent nodes.
+		 */
+		if (wait_tail->next == rcu_state.srs_done_tail)
 			break;
 
 		rcu_sr_normal_complete(rcu);
@@ -1743,15 +1747,17 @@ static bool rcu_sr_normal_gp_init(void)
 		return start_new_poll;
 
 	wait_head = rcu_sr_get_wait_head();
-	if (!wait_head) {
-		// Kick another GP to retry.
+	if (wait_head) {
+		/* Inject a wait-dummy-node. */
+		llist_add(wait_head, &rcu_state.srs_next);
+	} else {
+		// Kick another GP for first node.
 		start_new_poll = true;
-		return start_new_poll;
+		if (first == rcu_state.srs_done_tail)
+			return start_new_poll;
+		wait_head = first;
 	}
 
-	/* Inject a wait-dummy-node. */
-	llist_add(wait_head, &rcu_state.srs_next);
-
 	/*
 	 * A waiting list of rcu_synchronize nodes should be empty on
 	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
-- 
2.34.1


