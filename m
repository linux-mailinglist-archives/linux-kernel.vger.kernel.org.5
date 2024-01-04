Return-Path: <linux-kernel+bounces-16996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C138246FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749C91C240DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BE2C1A1;
	Thu,  4 Jan 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rOMK1gaQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F02C68D;
	Thu,  4 Jan 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp8gM+mo5FfYWouLrsaw08N2CGA4qfTNbBlRp5bTlrDqOkA553S1mjrELGLrfKNxmJyyCNT90sdDPAsIYh/E8enphgjth4OKdnPfatCzch1VYLsmtgwfENyew3ZOIXY0s8YN7seCCYvZYU+FoWsJu7tobJYCiuVx0Ta8YUL+iMj95dhrZjbGECgq/tykG0voAMrgPFcd+62kVHeYtDWNPjeDAtOVO/73wjeTRk3MPHXoNLmPSV1BGUTAPV0CKpAduEYUiCn7NNbUXxuu7BzKpnalw6bDRX2a/LKb6mTaBOZ/5K6qFEL+jz3BzA2uU4/+0dlfO33mrDjObg/FrVPZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0cwSIWaX4xESWMXtNloBt2dXBKHki5Ge3vDIzXrBb4=;
 b=Uv+dpgvuJpeTx4X/pUe/kXT/+3iXKlRslWBtT2AthuSjDYXIsUjU9j6qFShHHNuxZGKfZn2A2+lMGrLZZCOBnPtu3UwMzAmwtMTa3jTNm7wcdvcW/ZsGT/XdXsF3Y8lboPLbVUo8EOR3ur4l3Rv1ySrBw86Y+DBIr3Fm3yaBvzAWwUSAP8nROckOMp24J2I1csJNO7+z5a3RxtJBDeh5YGVrLy29Lb3nhRl/h9Yo3Fop9fjZl1VoZlmXTUWQeWIhW7Ge67slPeh26RTCiCSDsobwutcEEjv8h+1vPCvJ1QS3bY4ZUIKs6LXkvnuOYyNF9O6fCA1swqLYjD7RY6TF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0cwSIWaX4xESWMXtNloBt2dXBKHki5Ge3vDIzXrBb4=;
 b=rOMK1gaQr7ELFMj0TxgsuIMrl9HeNvMAa+jHqGdn6fmcDo2DqzY8X7I/DfhCTQ9Kdt2Fb/6my6QctoU5mDsCN0oW57ZteYvYiY5255Nt/rSN9Q7hrhkO51c6fqA/uot9Kap3gR+ZPO5WpZ4PAfiCoNaoKfb0hoGAsj2X3QQhVes=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:12:42 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::20) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:38 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 4/8] pds_core: Prevent race issues involving the adminq
Date: Thu, 4 Jan 2024 09:12:17 -0800
Message-ID: <20240104171221.31399-5-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104171221.31399-1-brett.creeley@amd.com>
References: <20240104171221.31399-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: db67b6a0-1f26-46d4-55f9-08dc0d485cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Z3fLDNeJdZKf/MWMwhpdThjlzrBAQ7MDYpAOt4YwtBRv0pGd6DWYdY3g/jXLELOpNwVp4jNR6vKptWfM1u7OdzLNuwTxpLUv5cCjB8o/3mpgyhi0lx6yY7rcvRdOYZwZG8amIrcrjaBpuIiVZPk1+lMkFLq2XIIcsXlU2Tvfbi0tLgadCNtgcSu2tVH3HwtulctbjJWTrxiOgTRxWdaeeoG0dP9YiYoHJS3wPW77k3cid5p0Mbhn7+L5cbK+I/dEmoBXuE2IyMO5DaMK2eKejEraaKiFZGtd9ko6xBc0A023pxY13MGoXnrGRpE4xFX/kxabgMfpoK0rLvERuK/FmRoUBJk7qGGJHBwnAvfGNx4nfATj5ltNAMCKMFbs8jOxzhQEDH2gmfzpV/5fPZd8Bx1ruD2CGf+g29nqFWRhKk94IhCqJs1q0YUO4IWp9eBuMopdfQas5ekFxExNmBpOrK1sxVm+fop/1jcuhRGLQMx7kNOoZJPfpMN+5CizxqmLsCFrUbFbfnzC678nTOTyZAgZ9M0JBQzdjiUyKviZ5DEXjimBtW5yu/AnBV8s9tsg01jPxczxXs0kFPZ/vPdxTrxVQ6f7y/pXrKItCMR6sl+zieTG57T1QDwjlq2VjcyPt1y8cBStVwdHi0m3ySXccvLmdW0Rgba/pqIXjcFOiPZb+/x+Yvgnf7NLGQSn2TsRfzBNxOC/uiLgJU/iWJHX2+Hkd/pBQhtiXnmziALfdAflMCmzROdV0isaNJClpqDZ4GRA1WwpV3mtKCq+4RiTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(4326008)(36860700001)(8936002)(8676002)(47076005)(44832011)(5660300002)(36756003)(82740400003)(356005)(41300700001)(81166007)(6666004)(478600001)(1076003)(26005)(336012)(426003)(2616005)(316002)(54906003)(16526019)(83380400001)(110136005)(70586007)(70206006)(40480700001)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:42.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db67b6a0-1f26-46d4-55f9-08dc0d485cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

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
index 0356e56a6e99..3b3e1541dd1c 100644
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
 
+void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
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


