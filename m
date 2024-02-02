Return-Path: <linux-kernel+bounces-50517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D18847A24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8229BB295AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCE81721;
	Fri,  2 Feb 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykheOFpj"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8C12C7E3;
	Fri,  2 Feb 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903970; cv=fail; b=rm5Nmysln74bpH9M+itVAWMzdrXI9D6B4JlVATuzaUmGsp0UjAcYkRedy7Ajhb1sbTnxngaGnK0UV2IPxGdP9mTIul0olQBEAbU3d1VcPx3KsPcLTqXqNZ8qMZiBaoold5YmyP1R1PwysS3/pcojOvXehvA2RtwdRc1FjiidQbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903970; c=relaxed/simple;
	bh=Eoj/9Mx5vMMhgEI7x3x7jva4l7J/bdvL48HUa8UbLNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9VD/0ApFy5/1SNutBDn7VYEutmqghj3jiGTFQ7z1dwR5T/6LMyk8XsbzGgqvl6celgCbihzb8dQMBNW5dbZ5GtKi7ab2ASq1oBeSzYTla/10s6M3pMIbHZ+hoppIOMep5qp3ntKLGbFva/9gzaPi+phMD0hSrFE97G2nqDCimc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykheOFpj; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLb8B8qc5RoRxYkmeCBwmNSCafmhFIKkjocJ8qhVU9AHFe0l7xxioT3Nok8wEF/ANMbrTPYy3VHsUvmncOr/3zt8pomaePZe2L+hogK6mhOMjbymNajQmy5Jv4bOYsafz+6DCyGTF5Ax/tzrBC7hdS04T0QjHUpMiH5SGzkV7RzXpuz/fnbDpJXRGVfPR4RuS71jgThh7Z0NA0hUPnRPsE9ZKknyFtg+cvSVaPMS+gzZJZmqcVxWuU7FtCt2d5SjRMsABOnxomoEmhNHK/gg2FsRZTIA7YyaHydwlDyKxRoMSr6XsKcRRRRhFyO+Pf1VdHfVhr1RGpMBiXZatBQibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybQE2AD8Jiz5wxvemGlQ5FEgHVq6cisqumIo/nA1XWw=;
 b=SClA99u54lZJaADMdxXf3AmWAZmCBj81bKMCny7t8nS3+X6zEv42VF9jnkN90PyOQDR21dHWh/ewUUIJ8dysh6P0lnEiWLzzo0uTi2sPtPCSK93O9IHUTFbDfDuq3ENepTXkzjDRivMP7igqmvOHWi/32ztCySQH1Z/Nn/6PW3YwgSajN7DuPtpwnGmyCcy4pxseWzSW9R0mzns4nBepS6e0pNwc4SXR2HtSQvh1rRSLSZDsz2f8cigMu30BFMZGqghMTf3rZg6duo9HJKtWrKtAgv/9zMzhJtJoF6DoO46nyiDpgfBO7MdH/AOvQelrRBfqYymx1SIVBDdhhB3qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybQE2AD8Jiz5wxvemGlQ5FEgHVq6cisqumIo/nA1XWw=;
 b=ykheOFpjQoW2CU9429F3wowTXLI6HwqxGx3MrgdwTVlldGsh0sicCr+ai9nWOxpkFRAkNezExZGMScHep9dEB9TApq80ZC+vXqHXDgoOvUT4rgerY0lTnMaSL0uaapxzCgOrzfg8p12V9CnUVFyyEt0x+6scDW1lXDEJ7Lx+8Ik=
Received: from BYAPR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:40::23)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 19:59:25 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::60) by BYAPR04CA0010.outlook.office365.com
 (2603:10b6:a03:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Fri, 2 Feb 2024 19:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 2 Feb 2024 19:59:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 13:59:23 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 1/4] pds_core: Don't assign interrupt index/bound_intr to notifyq
Date: Fri, 2 Feb 2024 11:59:08 -0800
Message-ID: <20240202195911.65338-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202195911.65338-1-brett.creeley@amd.com>
References: <20240202195911.65338-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 844aea47-c7cd-4212-c5ae-08dc24297506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mYMZ5Yn9vPVRMlQyhODqRvP7tvE40GMkmDxcvgm31Hi1FLqpdtmHrS1Xa7An/9HhQF/qkIgNmlOu8+Duk4usRx0lgC+UBGBF4mSQjDU3MatFUYFjbu56GLiyrBpP9uHYY5+/7M/JYfNLxmn0YcmAVvjJZcsoMYRAdjP4IlPnc2PvXCG9zu0wAqWKqRfMS8PsZfInwCUb3SPEx0LUeruT1fsEkIHSnHLU+Tz52Fp9P0c9KJHexoeR4tOc1m0JQqsN24yOvsCrpQSCBUQMQEvZcnTPqz/DZwHwyOgNQC3HsIsQTynl099rS7Ov3DhKVqBhera7pDwYlArW88wOaFbIEJzJCeVXMfKR+9TY7nVVrFYtVWSsB2R9rrbUmDhn+10hmPZOom+QX9YpYxAWhvGriQcyCiQxEIJ8eCwGReyKEhza0WLQVt454i9YIQVLfsij749J0PuuMchDn9NicHgbWjsJfwo43vDdXLzQ02Gc89HH+zuye+cP5AD44I0IQWeRHqXc3aHk/hvvI+LI9XU3LVFJD2l5fb2XeD0QitqPYzqrxUmjfiq1XsN12oMw01597FtvDSsC6vkQCtpHgIz5lCwMhC+MFVMuasbZNT0h8xmvJp063YVb93yN/ER6/QloaMKce6ayksRpsN0XdefEDvHCL+ufBQLarJOP4/pCHm835Sm8kvpXdcZf/89rbcMBNytL66kU7i/yLYaKSB0eRfysrR9CtTHsRsdEa2bq+0ZC56fzG872MyTBUXO3VNYscPYsqQFukpWjem2ocu6FMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(41300700001)(81166007)(426003)(336012)(16526019)(2616005)(26005)(36860700001)(82740400003)(5660300002)(8676002)(1076003)(4326008)(110136005)(8936002)(44832011)(70206006)(316002)(2906002)(54906003)(6666004)(70586007)(478600001)(356005)(36756003)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:59:25.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844aea47-c7cd-4212-c5ae-08dc24297506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

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
index 7658a7286767..41507ade3570 100644
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
@@ -430,9 +430,6 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	if (err)
 		goto err_out_teardown;
 
-	/* NotifyQ rides on the AdminQ interrupt */
-	pdsc->notifyqcq.intx = pdsc->adminqcq.intx;
-
 	/* Set up the Core with the AdminQ and NotifyQ info */
 	err = pdsc_core_init(pdsc);
 	if (err)
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 4e8579ca1c8c..ba592dbeef14 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -109,7 +109,6 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
 	struct dentry *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
-	struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
 
@@ -147,6 +146,8 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	debugfs_create_u16("tail", 0400, cq_dentry, &cq->tail_idx);
 
 	if (qcq->flags & PDS_CORE_QCQ_F_INTR) {
+		struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
+
 		intr_dentry = debugfs_create_dir("intr", qcq->dentry);
 		if (IS_ERR_OR_NULL(intr_dentry))
 			return;
-- 
2.17.1


