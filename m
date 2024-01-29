Return-Path: <linux-kernel+bounces-43637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A8841711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A162851A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340F15A49F;
	Mon, 29 Jan 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dVDFJcIF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087253E09;
	Mon, 29 Jan 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571658; cv=fail; b=d1hZaNZ4QcDBm/rKXiEEbG8NuaTHLlnrO9f3+MX9VD59WDBdKZ15hHpWMvmZo2Gjgxq7x1jSK0tndOUeUImX/GYWTB8b5eiJJS3iFYWueuUwqMmbmO0HNj7fUY+n6EJr19oSZ1YGGJtYRKC29Sr+jQbIV9FY73IeqSN3OlIYTuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571658; c=relaxed/simple;
	bh=09N7qJhOxcMs3JPcPWh9Q2fSzJczPkW3uO17qBl13EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDXcIcsUUra8VXwptD+pI6s/6KOKPUMV87TrxzA9Y9YqwFxgBCmSZxmwONwApi8ZykgnI0EgWj3RTS8cMb25fzbwAGTtVqZhlIJcQjcCQ9CZgrudrGvacthVroy+6Boc/l5zTii1Ej/9CM9tVuKJrzwlg7Y9S5KYyxoDbu7qAS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dVDFJcIF; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZyrirTkp0BMjNsMOyOIL8yEk7j6RPsSJWG+u1jzPf6sEcPgr67ItuJtuK8M2B6N48NEmpbS2ABoW5gAnmptVHEvGoOpNbYsE6hG0/fyoYouzpvIDMdNzqI0Vwk2ET1MvcmBl4TDj43VjMdKftgw7V5fNeZt2MgmX7w03NjNNg5dnU8jQDbjV0Q9fLtXGa0aS2zNwsllmnPunbH0Je32cZUVOoCXljOdQynpxlcQl+I/h3LwEJ+1Wgn+C5+G6vlX3qwuajerNv/U1xa6jM32Z4dO0NFS2IxE30o1nDKAwdbMBGaphjrE0F2HmUKCSljZW1BY3KrpixDwUguv0pMPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca9JGtk5MuV5dkfeRt5CNnJsmhfMqm8khn53cPYt1GA=;
 b=gouGGSuGBU6v9L4oMTUrP6x1izxImpuuoTfNrm+sYmKya9yFFi52J/rEhAq+knKK5OhynvvvviVtwrqpFB4hKUgX9NqMRM6wARPKFlCbmTlTQER/7bdKtEau3YfIJtO0aN9GT/8osMzoNErB9n+pu1W90+kNwUCmv52psXe3Kurf1Lu99pq9Fl+5fWbo0+v/hxyztkdA+QExd+I+6yw5Er32m5UllpftEF8zOQnluEBqHSDdo6cPwFMidBfRFkqVy/ZS8f6cMV+qtanMpT/Z0lZfWJiwoA7o3r5Tpteng8a8etH4QH04z7rGQK8hFXj5RcE19ylog6nkNYxd55Kncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca9JGtk5MuV5dkfeRt5CNnJsmhfMqm8khn53cPYt1GA=;
 b=dVDFJcIFbRp9fHQFTURtIW5H98tLW8R8eKtbb2mdOvoghkRinVSkVDrM36Jz9CuJtNIe4RpGRgLdR2Cx7mg1wWBGyln5LLgS1AH3DgwAc/kx88XqCuqivmjY1LG653Ql1sxLKAmjOUYFmhRxJHJ7kDGe/nxEd4LMT6ckSnbk4T8=
Received: from CH0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:610:b3::7)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 23:40:54 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::65) by CH0PR03CA0032.outlook.office365.com
 (2603:10b6:610:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:51 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 4/6] pds_core: Prevent race issues involving the adminq
Date: Mon, 29 Jan 2024 15:40:33 -0800
Message-ID: <20240129234035.69802-5-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129234035.69802-1-brett.creeley@amd.com>
References: <20240129234035.69802-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c58e92-a46e-459b-0845-08dc2123bc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sn0reMQrDyuqX7C6k5jMLuAzJ9qmtnaMsjUvNEtn1g6YfpmJNMZhB1rcpN4f6w418n03/Wcs5MXPSzcXqg8msmn0Ilqyflx4gQEd+h8v9OHvmxrlwNqWslbcVV9SEhWnxWsfRS7JvYWN7fQ6HwTzJY2YmduU7GXnKns3JEngGh4BW3Rtmcm1eP92rJo6/hlxYRdObRcuu9zf/TnI9nkiKb2aaqgHmwSbD6SBRXMPzC5jblk6TvChk2IXYfvi14Q8DX4RGuFvgdekvSyB3WjfJJ1BWrpWd1pUCfe8GGosBEPHCSmNHnzTHmedEpwOtl6hXYovtl9sHaiXKRsT7WyFh9Bc3ydR6Stl1IgBh7IPCGs2zHZurgHCkmFmiXvKcks2zNT1fo1Wo9SscW+GjnhoaoxVXtp2R7EUfQpdt2sB0iCTRtE+9Qwoe6NUX/1vTmzEhKRtauaQQj40OG52GmJoge2suXBiOfl5PzjvudA6MA7jsUx3zOPEg/cPkoBEAWQwq571Gt/QFR7nsbpeowMrDE0AmIc6v7Nhf8IAsm0iw7d3ZAclwvA6zvnUfjST+/jegjlotY95gDML/eUFgYzo4GlCS0RpPtX+Esba92FUJzDbS2jVYuR24HOBu7U4fLpkHP8XGXxIOkAbiSgNu04CSssin0uUN9Qg+YyX8bhbJHoWmd4xL9nzHhmuGiCqdiCKHJLxmIw70bUJn88QH93QQ71ye3rtzO2o4kAyiv1MeXobXoj5FFa+cTeyBR7pZRI5JRHavudmIFFnkmBJxPRlmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(36756003)(356005)(86362001)(36860700001)(82740400003)(81166007)(47076005)(1076003)(44832011)(26005)(2616005)(426003)(16526019)(336012)(4326008)(478600001)(2906002)(41300700001)(316002)(70206006)(70586007)(110136005)(6666004)(5660300002)(54906003)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:54.5945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c58e92-a46e-459b-0845-08dc2123bc4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

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

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
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


