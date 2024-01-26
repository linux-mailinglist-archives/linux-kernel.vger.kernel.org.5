Return-Path: <linux-kernel+bounces-40459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D1C83E0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F7288513
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61422EF4;
	Fri, 26 Jan 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bRPr3Mu/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D1225AC;
	Fri, 26 Jan 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291003; cv=fail; b=QGlcsCyxpdIKF1EGYDOJmT4LcLRmZwzK3UR/TcdQJJoUwgJkZ/lqo5GXA8MJd40IuFsYRBvUhVuZw14I7l74yW56dbxUOo8fMSlXT5OiR8KDanhMQiFGvNsh8UXpxugns01iREIBpa4Rn9frqOjKwXPMa9YBSNLrzpPo2sVZ1K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291003; c=relaxed/simple;
	bh=Yt/iWHCRy7Zpz5dz46oPIvSEIPgTdiFsOIj1Lua1lhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4MgeZJwKoEs3r+iRbeLsMRdDMVw3LAHvvFicR1f2MrLEgakvaxnvQ+QwqwgsfIcpqNk4zwPOh9HmuaUJ0nlNi1SJjUcmfF9P+XVOaPho3BkE/wZFqQydnR5GH1bLptc7OgiSGUx2iUT5BlZKedagftDjzdglT5rhi96wJeKkqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bRPr3Mu/; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5UkmVdBD6nJ5tqKIF0pumAV74NDT3ElAhGL614SgIJ3e5LzbJqx9vOCPuS0Xx1V55G45NEEclWif0Ojbr5a7liUsQARGEn+eedWOopl6xMPfe5p+w3gDfXWgnsuSF0lM4isJ112iKIv712bpFshOvPV9WqaGDF4xxdfL2c8Zr9qsIuroU6XVV+wLT6vHWemtjZqTsdIeguJB4wPPEe3ok6Xu/sFg3ZVle0Vb4ToCbcABs+tiXI1wNoASTkYyEdK4hrdecieyiiX35OHuZBVUdLhZVIPvk+jUaBQZe635iZTJrBsHJCtIdVpwrVCqp5uT08+33GYEHXj4Lmsd1DOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmsQyTgxUi/VSrFtNrqRVSmeh8weWgeO5L5FzqtbSJc=;
 b=PfMsI2MMcUL4yyeRoQ2UiyupuGX8zV5n+d6g7jWzBXszaV0SdvT9pNNMgpqMFADu4aKROXmweuzSmC7y4DHSJFUsU0qFTsjwhso/Em9hVmL4Z9efFz4kEJ1B2YDzAjfyTduMWOn33DVjAlJ1a7j4mk4nSvYBzNRVE00cs3HOq9lq57WsC2QyoRS6Mw3HxyLQP4hWijtvFkDSIzvJRrm1pgDQQoYJWQQunVOHDnuAyBNGaGDiyuEtbt2xdx8BwjKpablbCYd7hD96u5P/PqmNVzjAJGAQUJhFLtOJe41W2FzpZBqhhJIDfR/Cc85WrRURUVk8+oRkdBNVd1vwfai92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmsQyTgxUi/VSrFtNrqRVSmeh8weWgeO5L5FzqtbSJc=;
 b=bRPr3Mu/bBhSFY8L/nhihv2dbeIojJ04AJCukmRNHap2Nd7t6saYggorZgGnLhTL2fCIZ5TahaRt5KAcJR71otqw3Xoh1TFcJpllhTcPgYD4bEZgX/GLy1xETadJtT2GAFlEUFks6hPfzQdJfEXNExN91sS2jFuJ0n4PDmXUCIw=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 17:43:12 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::f3) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:10 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 04/10] pds_core: Prevent race issues involving the adminq
Date: Fri, 26 Jan 2024 09:42:49 -0800
Message-ID: <20240126174255.17052-5-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: fe47bb1d-2271-45e0-ae4e-08dc1e9644a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gMMdkOxZ6ju9PO0C9fV9Pq1A5wmhceYfT5olHrFUOizeI3fWg1nIAOfOz40uz/ZP6QQqWlmBXbt2g6vvIcJOGd0c3loHppiAEVH9679zRt2/cdxpabQIYgQpNoq93viFq4VdbIksJCfmFflXHNj93dLUSMOU7TB3pIRb/IcIT5wPlQ8XqDgch1zf30BugVVqmgQF6f/YR+4NgOuvyWvdvW3T7fKVHVY4FX2/WQIY2Yd3Oxun8fDoUT/4aexhXwZWqM05rDoY6SAlMyH49xaIrXIp6xrAwyUXIuYtXNY0q41RhnjTuXho5Z99R3Y4Q5PVvQVoDDPAeRVLv8TK/7lAI6BRjQvQg3pr1pRMC/x98GSDwii5lHo0iO+X5+5fqrlCXFNylZQZfdV93Gi1GjSZ1p+5tVaMaqhYboh4PtLITj5IoLlFwIcz3YzRm5qmtnZNXReHPBsNxnDbRumGf/ug2a78znsisbrclN0KM4k2BmTDnAGrwDZ55t0tP1VPqmNg9EqPF8BdTWU8cPvwrPuwVsoOejVklHexsVb7GqSc9AfDtoFHHWz5UJcdSSy+2TkufybR0SVTfXLtdXCJcilEh3C5hzu4dXEKI78Jdtv/nV9csmBG8UGb4f0kOgXTVKaTNp3i2Rb8yitRpTKCrdSJSkYEpqWwaL5/ys5sIx1AerUTMyCDm2IoQ9JOUqZM5SG8oOVzK3IddZRuGsyzMpU9Pa1q7rEK+A5MNu1wLIc7YLGEbUfakWoaPzDp25coCBTgAqdo9vWiLJNhf6L887k7Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(26005)(16526019)(356005)(1076003)(44832011)(5660300002)(336012)(40480700001)(36860700001)(40460700003)(47076005)(426003)(81166007)(2616005)(83380400001)(6666004)(86362001)(478600001)(54906003)(8676002)(4326008)(110136005)(70206006)(316002)(70586007)(8936002)(36756003)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:12.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe47bb1d-2271-45e0-ae4e-08dc1e9644a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

There are multiple paths that can result in using the pdsc's
adminq.

[1] pdsc_adminq_isr and the resulting work from queue_work(),
    i.e. pdsc_work_thread()->pdsc_process_adminq()

[2] pdsc_adminq_post()

When the device goes through reset via PCIe reset and/or
a fw_down/fw_up cycle due to bad PCIe state or bad device
state the adminq is destroyed and recreated.

A NULL pointer dereference can happen if [1] or [2] happens
after the adminq is already destroyed.

In order to fix this, add some further state checks and
implement reference counting for adminq uses. Reference
counting was used because multiple threads can attempt to
access the adminq at the same time via [1] or [2]. Additionally,
multiple clients (i.e. pds-vfio-pci) can be using [2]
at the same time.

The adminq_refcnt is initialized to 1 when the adminq has been
allocated and is ready to use. Users/clients of the adminq
(i.e. [1] and [2]) will increment the refcnt when they are using
the adminq. When the driver goes into a fw_down cycle it will
set the PDSC_S_FW_DEAD bit and then wait for the adminq_refcnt
to hit 1. Setting the PDSC_S_FW_DEAD before waiting will prevent
any further adminq_refcnt increments. Waiting for the
adminq_refcnt to hit 1 allows for any current users of the adminq
to finish before the driver frees the adminq. Once the
adminq_refcnt hits 1 the driver clears the refcnt to signify that
the adminq is deleted and cannot be used. On the fw_up cycle the
driver will once again initialize the adminq_refcnt to 1 allowing
the adminq to be used again.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 31 +++++++++++++++++-----
 drivers/net/ethernet/amd/pds_core/core.c   | 21 +++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 68be5ea251fc..5edff33d56f3 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -63,6 +63,15 @@ static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 	return nq_work;
 }
 
+static bool pdsc_adminq_inc_if_up(struct pdsc *pdsc)
+{
+	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER) ||
+	    pdsc->state & BIT_ULL(PDSC_S_FW_DEAD))
+		return false;
+
+	return refcount_inc_not_zero(&pdsc->adminq_refcnt);
+}
+
 void pdsc_process_adminq(struct pdsc_qcq *qcq)
 {
 	union pds_core_adminq_comp *comp;
@@ -75,9 +84,9 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	int aq_work = 0;
 	int credits;
 
-	/* Don't process AdminQ when shutting down */
-	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
-		dev_err(pdsc->dev, "%s: called while PDSC_S_STOPPING_DRIVER\n",
+	/* Don't process AdminQ when it's not up */
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_err(pdsc->dev, "%s: called while adminq is unavailable\n",
 			__func__);
 		return;
 	}
@@ -124,6 +133,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
 				      credits,
 				      PDS_CORE_INTR_CRED_REARM);
+	refcount_dec(&pdsc->adminq_refcnt);
 }
 
 void pdsc_work_thread(struct work_struct *work)
@@ -138,9 +148,9 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	struct pdsc *pdsc = data;
 	struct pdsc_qcq *qcq;
 
-	/* Don't process AdminQ when shutting down */
-	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
-		dev_err(pdsc->dev, "%s: called while PDSC_S_STOPPING_DRIVER\n",
+	/* Don't process AdminQ when it's not up */
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_err(pdsc->dev, "%s: called while adminq is unavailable\n",
 			__func__);
 		return IRQ_HANDLED;
 	}
@@ -148,6 +158,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
 	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
+	refcount_dec(&pdsc->adminq_refcnt);
 
 	return IRQ_HANDLED;
 }
@@ -231,6 +242,12 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	int err = 0;
 	int index;
 
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_dbg(pdsc->dev, "%s: preventing adminq cmd %u\n",
+			__func__, cmd->opcode);
+		return -ENXIO;
+	}
+
 	wc.qcq = &pdsc->adminqcq;
 	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
 	if (index < 0) {
@@ -286,6 +303,8 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 			queue_work(pdsc->wq, &pdsc->health_work);
 	}
 
+	refcount_dec(&pdsc->adminq_refcnt);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(pdsc_adminq_post);
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 0356e56a6e99..f44333bd1256 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -450,6 +450,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 		pdsc_debugfs_add_viftype(pdsc);
 	}
 
+	refcount_set(&pdsc->adminq_refcnt, 1);
 	clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
 	return 0;
 
@@ -514,6 +515,24 @@ void pdsc_stop(struct pdsc *pdsc)
 					   PDS_CORE_INTR_MASK_SET);
 }
 
+static void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
+{
+	/* The driver initializes the adminq_refcnt to 1 when the adminq is
+	 * allocated and ready for use. Other users/requesters will increment
+	 * the refcnt while in use. If the refcnt is down to 1 then the adminq
+	 * is not in use and the refcnt can be cleared and adminq freed. Before
+	 * calling this function the driver will set PDSC_S_FW_DEAD, which
+	 * prevent subsequent attempts to use the adminq and increment the
+	 * refcnt to fail. This guarantees that this function will eventually
+	 * exit.
+	 */
+	while (!refcount_dec_if_one(&pdsc->adminq_refcnt)) {
+		dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
+				    __func__);
+		cpu_relax();
+	}
+}
+
 void pdsc_fw_down(struct pdsc *pdsc)
 {
 	union pds_core_notifyq_comp reset_event = {
@@ -529,6 +548,8 @@ void pdsc_fw_down(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	pdsc_adminq_wait_and_dec_once_unused(pdsc);
+
 	/* Notify clients of fw_down */
 	if (pdsc->fw_reporter)
 		devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index e35d3e7006bf..cbd5716f46e6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -184,6 +184,7 @@ struct pdsc {
 	struct mutex devcmd_lock;	/* lock for dev_cmd operations */
 	struct mutex config_lock;	/* lock for configuration operations */
 	spinlock_t adminq_lock;		/* lock for adminq operations */
+	refcount_t adminq_refcnt;
 	struct pds_core_dev_info_regs __iomem *info_regs;
 	struct pds_core_dev_cmd_regs __iomem *cmd_regs;
 	struct pds_core_intr __iomem *intr_ctrl;
-- 
2.17.1


