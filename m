Return-Path: <linux-kernel+bounces-101215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963C87A41C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F442830F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F1199A1;
	Wed, 13 Mar 2024 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ttSUDRzr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06212E73;
	Wed, 13 Mar 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318790; cv=fail; b=nyKhCcXFNk8gzzrSuW1+wu+Wmho0Rl6/65E0HsaeXEjsE+J9rQDZ+dq9WX8u0qgk7UfD/DgzzeZ5LQ03ccdPZjAm8rI/wiwxqLyP4fY2U41Kyi+vUgT3T8HMrMv4Uq4NASpzb9wssMPOhPmuQHO9P9HFC827G/pb6cISJsVO4vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318790; c=relaxed/simple;
	bh=NvW+145LWlV4PZl2q5JLFqWzRDfvufK0MoJPUZjvWbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwW8ToRXS3vtNcHmiGpKSzUUAUyhq1cYnBqH6gugzo+QKJB3U2TAjKJnBMxbhnOGtXxeyw4QcfJlCozuug26Q6xgjQnWBVdGRO0S9q7DYW3rSj4tvr0gcUmZxH0Z1FE7PnzjjcqB/LkIKKmIQj4reAAnW0klS28NEqkyllIXmqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ttSUDRzr; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRkBd5tTvCPcmyEJ+NloJY/tCKg9P0/jP9AyVt+z/l9wIWU1xsLvoT1VhK25eJdT5cYIZMqRMIpWKYtLyKprOV7LsltAx9exHVm1mymDEo9fnoXFd9CZacGn5gof1R9A68HIxQLg6fH9+iEAEFlqoalxR6gTOGqrcD4/o3Wrf7ybwEZ4TkmiovLKpJddbebOmFO/aJVuIwrpvCPGfhPlwXSER2M5yMpvG2ntKdCFZATqN5g2vLLLy0YIulzuMn9bfUDT9MhFDmE5ezuQAV/P15XT0zEEmlbgI/kIauACa+aVNDws8elKQFD7aFCSSBhhw8fw88x8FY3vct7wI6dDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldWRukoH+7SyPPgBzcppriAAOMg+SYl8OqAdgXH0z0M=;
 b=UE2rIB2IKZNjHP4g7Mds/GgJYwYYucVGZGGMWUICdYtp7xkmp7XKBXHe8hmlE34bSLjV4ew4oRqrOxhlUmHYKGObllgkQD5b6Hd8apGWeCnQ5Kjl7bDPOk2iOPg4EpVTnZKtoI+ia8JYpsWNPMbnJf3kdCo8t3dP+Mw9MAg4o3xkbGNlR0/4UTMcRr6TUpXNUHxQtIzpwQ5quW5cedYOtI+dPTPoBVv3V2Gwtwc/dw/URcNHmqpudx5Jhm1fPL+Y27wwmdk/1wvHU4mVtiHhwS9fdhYXoDdOTon8SI3a7NarGEESxVOUYZI/62uclM5cxVOVkHVNYTR/RMhga53gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldWRukoH+7SyPPgBzcppriAAOMg+SYl8OqAdgXH0z0M=;
 b=ttSUDRzrTVmv5xzH7UA+q38q4rsAMJFqGSDUXeTAxN15VbYSzaYgDRSFABY98osZGoygVQvkiE/PcCaWTIW/pkP30dQ2gfaN+tZT/raa1v43qPpn2tK1trRYukPEWVzLj+/Rtp6n2xsllauevLtJ7rkwBmSL/9fyqXu5S3cYQ1I=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 08:33:06 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::65) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 08:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 08:33:06 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 03:33:00 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <paulmck@kernel.org>, <frederic@kernel.org>, <joel@joelfernandes.org>,
	<josh@joshtriplett.org>, <boqun.feng@gmail.com>, <rostedt@goodmis.org>,
	<mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
	<qiang.zhang1211@gmail.com>
CC: <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<neeraj.upadhyay@kernel.org>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads are in use
Date: Wed, 13 Mar 2024 14:02:28 +0530
Message-ID: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 479c8def-c4b5-4f99-05c7-08dc433834f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oA6UdR+nbiKI0nyNfQAj9lnnG9LRvT7Gb6jWbQCTEc4GnKjJ2OXTHCFETeAxmM3mzsbfm92/3D+dm4r6IXHgrS5VGCPWpkqyeqNfDM1NJN5HXq1dgGbDhNrG4F2yvtPS+pHUtw0w5R6GmfIgtiY+KexkMXy4N2xEiW7Gd++Z+a0+cV2NWMafv56V86PldPou5wsdYGy7lHO+OOGic2Z2waNHI7o12/god7KjeQX5YGZ3dVXWL6bVHzhzj6MPpHVT53bCeQKKW6DbfxumkKiRiBRqPhheJEnn/c7RZn5EVpFwasAJThk1PCPYpNXB3ywFKHEcqd3G0/oD8YBgTCL22j8HemumdgYJrMw6FGJb8fuzgOB1vOvbJxadUrPFqQ5yX0bBSJWxGbMgPSy/e0afeqhQe0Em2cS1KX9/WW+yz2NQQW/objsZ4InRFRhDgUz+11sf+Q3f/5oVWeR6A3gMEHvgWprRbPAfyXuUS7g8I1qH5NNIYEZXjU7byeu9/e/kfhTqNFKo6kRqdOMM+CAU800cC2pa8ER0NprTdKbCjO+ea5AbyMWUCypBDnvXuK780V9Dgb+MAL6hRavqzNV+IBoF2cBkIGrg5NHTYK85GUbq0vFJJRXTjLe4ELWJha/FPnqXjOoAzs8z0dS3koOL/PgydO8ptd8s9Bt8pvPXosAQZ1p2SZwYsyOp7FVYgijrYy680eDHWZXmzgkdfSJ2zwWmMa5yB3yd7seOX9SicVvD6SyVG4DxrNpzs3mvCPIW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 08:33:06.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479c8def-c4b5-4f99-05c7-08dc433834f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118

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
 kernel/rcu/tree.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..bdccce1ed62f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
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
@@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
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


