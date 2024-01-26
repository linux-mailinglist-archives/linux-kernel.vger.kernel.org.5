Return-Path: <linux-kernel+bounces-40456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCE83E0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56F228849A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217521A16;
	Fri, 26 Jan 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AYnhay2l"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8B20B3D;
	Fri, 26 Jan 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290997; cv=fail; b=j+79zkI5YttEwkwkhejxLX37TGj9gVFqAYzTRTfOAGRRJ0VF/PNHysFA/AwKEE50lZy1yGxcKnUUdAAp0hyxFCbeUtffZfPi1j/IQSKC0A2r7LLVFGrT0ylWGynT+rmYbJDHUG5N81SqpSykoPQXgLdhoH+SdunuB4JxDEU1kG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290997; c=relaxed/simple;
	bh=OcihoKLnFzEjF+DoPWaTm2RPO77zkUL8IQBfQ3SxmA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LM3rF7qrkbMm4y9O6fy4efM/FQAfhHMfBEyTXrGXwqV2o0TYNvbvxBO+ye6PhuCPcKw5vJwUKelecgNkMv+pjnmA6mqiJqjL7iRIcmbGG08RlqyYg9INDBfaGP2fRYOY3ScxsMiq2YZZNJ3PwOEK+jUFaejiTJYAtR1dZQj2XcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AYnhay2l; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5zcb1rurCvoSGKrN4vVnRh0aqX0gYOGkFPxvANblbcHPtNGSThIGQzXgI7t4YGHHbNdn9z2B8YfoAwVNyGT+gsUM4E3l5qVeQ9aKyNgTm7ndeAhyvVGzfd97e22UDBld1QNKiUf059M6D9lDYJdp03HSePihfwqOoboDhoGPIR7IijkzMvODOXdAbOblnzVVxXvzs45EGdFjMpSGsr4AKa+43yPBbBQucnq98EqDs0133RsRTjQ4wV7wzVh/3j5W95oGHoNEoOXdodxnLz1inNA1fr8pMIPu2RdQgqmJCfCIG36OBA/+8MEkN6t0iEwUtBarljoCnoQT7DNobU+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT2A6oQ43hhRBwlGJPnzjjs8HzMfRfhrNXe8X+thyTw=;
 b=MNlEIouPNLnMfCy25scW/l5AD/OuG2zfcQRVDJddG/LlJt3xkfoSyD+XAMPBpi+E8qAkoTmgFQnQ1F6DnZYrBy4o/zDuxzVl19Xw2QKgm13EVPckVDf8if+WQdYQxqiX4iF2BQsgcsmXxkGBeEjnoR12P4Eozt/49xXaLBBgWK/FRkweyERIa/TlZ/O2L+XrlMsntzNw8tuNONqyPpOtJFz0qVomM/U6BVi7VnuTFqWSp6gDre9bJ+K+t2+CVyCIGmGfkOR2zNRaEwsrdPbct7y1qsBE9ZDEJBg0FufNav/sH9FuUDEX8pvuLEvQTjlE6HJtG0H14XAiPoCC1E1XdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT2A6oQ43hhRBwlGJPnzjjs8HzMfRfhrNXe8X+thyTw=;
 b=AYnhay2lnJ46FMP2AAbUvcYmn8ZCPF/A2W0EY4Xs0Nts4GwC0Okgc/ez+HnzqR4l3j/gi25THOtzw7yr17MOInFZLxpOD0OM4MVkqeq68VKJ6JcC4Eleevw1yvIApbLImLf0OiJaQvyWhIApRYKUSuRkFyfrA3TatRzPjzaR6TI=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 17:43:13 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::92) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:12 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 06/10] pds_core: Don't assign interrupt index/bound_intr to notifyq
Date: Fri, 26 Jan 2024 09:42:51 -0800
Message-ID: <20240126174255.17052-7-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126174255.17052-1-brett.creeley@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ed66b8-ae34-422d-a71e-08dc1e96453e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WH+QADN86ZErcIwgVEC7gRQW8cOP8DK03l6+MMNlnGzKKjS5VdD28FCoeQq6mdD8oyggKnmUGAaPUqlEaXREOLZMYmPF82fTLoWczh7o1uGx1eYesZwyGUXjQa1E6AQTUe/sT7y6yRBZd18xHUjiBQIkeBiQwJzf+/qjvsrx9zHLnJBfSF/5y6vjtchFLtYXZbx4egPhI3K1M8Dipwv2DaahjOBqKSUddlbIm8jwHGYCAW5PDs9QhVjiUwDGBdVZhl2I/EVDK91wwWwH2vDujB7H+9Tue4xLeN+DBz2Zx0zLNUsyGYPxzhGeUUWhLNcz9ZhyRAqzNstHQJYEki55bP/AhuTlqLxYxOx3oBhmOZNWZ+7OdlQpxgchdF0SddR9Y36F6UWzLaz8Igq0UZj31rjS7ZwszPkyTBgs/RDgoUDYQ7op+zD0YyaKE3eayNbrMUrI8SdeCKeEmb/kFDFqFId34aNKqo5PPlDJOP9Sk75ljQSxto0paR//uknM6fob6RBi2M9IuSLy2M4R8Ei6ga4OO2EgETW0ZdiTles6NndinKfYL1lnOWP3RYNm6zAr3KhTHMG27ufhy58mv1Nvz28xAODv2zpMJTsWUR6VWE/myptH9La2LAph1utKyI+rQwJH3CDHcbu6kpg/2pNrbJ+/MuQH6T4bvdWoE/+4WALd0mdeqtaQtGW2u3LDreFdwWLPrHj/7O+krBetfCOwxvsrjA0ZzYhIgZM7BBQNrqFzgQR2np8Q0YepPQHREfY4nNG0N/Hdf069DXblLLeVLA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(41300700001)(356005)(81166007)(82740400003)(86362001)(36756003)(478600001)(16526019)(2616005)(1076003)(426003)(26005)(336012)(6666004)(36860700001)(47076005)(83380400001)(4326008)(8676002)(8936002)(44832011)(70206006)(70586007)(110136005)(316002)(54906003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:13.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ed66b8-ae34-422d-a71e-08dc1e96453e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

The notifyq rides on the adminq's interrupt, so there's
no need to setup and/or access the notifyq's interrupt
index or bound_intr. The driver sets the bound_intr
using  qcq->intx = -1 for the notifyq, but luckily
nothing accesses that field for notifyq. Instead of
expecting that remains the case, just clean up
the notifyq's interrupt index and bound_intr fields.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    | 5 +----
 drivers/net/ethernet/amd/pds_core/debugfs.c | 3 ++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 65c8a7072e35..fe7e1d10224c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -129,6 +129,7 @@ static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	if (index < 0)
 		return index;
 	qcq->intx = index;
+	qcq->cq.bound_intr = &pdsc->intr_info[index];
 
 	return 0;
 }
@@ -222,7 +223,6 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
 		goto err_out_free_irq;
 	}
 
-	qcq->cq.bound_intr = &pdsc->intr_info[qcq->intx];
 	qcq->cq.num_descs = num_descs;
 	qcq->cq.desc_size = cq_desc_size;
 	qcq->cq.tail_idx = 0;
@@ -433,9 +433,6 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	if (err)
 		goto err_out_teardown;
 
-	/* NotifyQ rides on the AdminQ interrupt */
-	pdsc->notifyqcq.intx = pdsc->adminqcq.intx;
-
 	/* Set up the Core with the AdminQ and NotifyQ info */
 	err = pdsc_core_init(pdsc);
 	if (err)
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 8ec392299b7d..dd6aaeecfe0a 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -105,7 +105,6 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
 	struct dentry *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
-	struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
 
@@ -143,6 +142,8 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	debugfs_create_u16("tail", 0400, cq_dentry, &cq->tail_idx);
 
 	if (qcq->flags & PDS_CORE_QCQ_F_INTR) {
+		struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
+
 		intr_dentry = debugfs_create_dir("intr", qcq->dentry);
 		if (IS_ERR_OR_NULL(intr_dentry))
 			return;
-- 
2.17.1


