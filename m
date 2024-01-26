Return-Path: <linux-kernel+bounces-40455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A383E0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C6CB2386E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670A21A03;
	Fri, 26 Jan 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRjIFoxL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A220B21;
	Fri, 26 Jan 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290997; cv=fail; b=Y1dUg6DkoBXyzjUGcfJoi0hSbBMf2KMa7xBH2N8xQsvLtV3XbP+hN3QkFGe1i0B4nTwzvUWsT/Wn6eCbETauKoISGedDLYTiD6DjPDVFWi2Tk7qj4SHxqGdaaDM6HWuXDa62WDTeo85sm1hCz3hBWXSgEu6qMgGLZ2RDrbDYY/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290997; c=relaxed/simple;
	bh=E48HFYY0unp4Iao9V+BF8Nds2Io55gi3kZ3S1Ogek4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6SuprQOnEcEAgVE92O/Dkk1P+HWjbra+QM40pkeio3tr6lWrm/TxwxZRSkGam20rtI2k2cSbal/hd/pdHbsho4NOrVVxQdmSRKVoVLVQQkYsrtW5595hAa09feNWO4GY/Vd0quC+lPyWC93kLBMWVHaUXqwxLtjBoVWo60Twxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRjIFoxL; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHQXfN4HKR0SVMdlPbtBqVK9/yM2ErtpJ4TpWjaU08KoT/Yx4UC7B0iZeaJHBGlR8zRDU8B/+9+H7xnPdTxfA3MyvC+XIgbM1TAbsOPhU1Q5VeMCgJiBq8LeF64JCtKspPEnOweE72wXIkgAFjI0e8a8OG0oikw9zgalhwLszCoyrRxZXLFqTkFbgNvFMULQYZagd7O2oFcgX9P3VpaOv1KksWFpq+waHpCoKbrpyJI2sq8FjFDzAreDn46BrRUHKJBDH8qMDoiiZ0Y+KvX6+8m1ETXYV9zXD3Aol1cy8ydFMKymYCkYImNb6ATLSB+eJBEgmh1jEydhUfJ1qVHkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bppOiY3C41yERXnK78IcQEdDUMHLRbfnf+jL2CRYZ6E=;
 b=RkrhofcQaELT/hmQYlcRiZVuleJEz6NKIhIq/WbMnuXT+CThEc4fCEEA7YRkThS3XBCBZq+SX8nZYNaXIibZ1NW024YtEOitnUyIxTXo9lSILNhmxu4auo1FxEc3UmmxfghnU4/zDAbCbDNbZ6iczhG6a5nm71NBSLwoL9yB2nCodCoNx6N5wbounr/PZujKkFJ8a/n8NiLLh63/TMnBLZ9qpE2tZP3xg/xv/3UP7HXQnROJ7OPiTaoIdr1XYlf3Ygu5VMFu0daiVv4hpQHjYNV9kneXAMEt4ghoA350foo+OvWwG0gZBy+OGRr342U0plIuoBybtTdCmJZn9uNoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bppOiY3C41yERXnK78IcQEdDUMHLRbfnf+jL2CRYZ6E=;
 b=WRjIFoxL55Lz0e7VMsGblR6YouRNmNUjf8GeBPbhefOLo6LUQiX23JFLmfUEXdzKZL8V1u1dhyJ+vCHtzaJtQD8xH9INQ1E/Tta5IsaDyUVoTAkgS8nhioJ1unpR4xnOkldAOVDEOIU5AEbiuLD6/DVMRMfxCf6j0C01ABtZVKg=
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 17:43:13 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::dd) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
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
 2024 11:43:11 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 05/10] pds_core: Clear BARs on reset
Date: Fri, 26 Jan 2024 09:42:50 -0800
Message-ID: <20240126174255.17052-6-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 7615052d-a83e-44dd-47f6-08dc1e9644fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R8JnWZMbijQCrA4icpa6d1dXcW7NOL9KjlDkNRy9SSx4jhHWvZDVFxdJz9ua5QxuWPH68mhWAlVAoksl+YfBoHhGihR1/rszjcfnxIc+ZBjzI0WF9x5AhMjNZzQQqwowVBz83vNfFoPQ8x4N2bEtFMmn4q/cmVv+SrFjHJI9nCuDD8XTfBZlkMmo0kClvgaITh1+V/XPgDv/NZ1i0gDqBltFxxdr4TQHn/UxcgIGLSYUpXTiWOSlD2Ca+CeqeoCFKIRLwnPiPZ2loosb+ABI44yacYOI+MXLk2PBZXZJXO4pYt9ZJAivPt9/yZEa70Urooixti634FWgt+Evb6j1ATGfPlJYl4MyjToeG79TtTPeTDXDpNFMrchNvim7JKNVWYJ/08EgtCrxOvmcBOgfHeCNcvMES63/TzLQBCDXdxO1WfsfAaGy6Gn/hJJ6Sy7CxO+cM1rynOOp1PzDxT2GKbH4oaQnXhd4yn/trFCV5PHB7EWpna76hWL8UynPI/siEWT0lxAEehAj3GUcG9aCn/VyNx7t37qpQEVR8JYbT6FZ1ft+4C+IO7uSMdmWkOBlH7y1MxnzlsfThPpvDpS1YiHnBybUk5MYIIJVXhugSHdvQNawYAfq3lno6GohO2n6cahoXHVqUSyC+kntnzjoD3pFGonDOf4NjSF+ViLueMIXQrUN699gf1hNSOfvu6iySXMUMwd0xrkbqBT4tzpzjWnKRIE2lf6qxamDDpVqARFEanlZEjbhrtGFn+dhF5BF8kXVlTwVbwjXdRqKfasDqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(4326008)(40460700003)(8676002)(40480700001)(44832011)(2906002)(36756003)(316002)(54906003)(70206006)(70586007)(110136005)(26005)(86362001)(336012)(6666004)(1076003)(426003)(2616005)(478600001)(81166007)(16526019)(41300700001)(82740400003)(356005)(83380400001)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:13.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7615052d-a83e-44dd-47f6-08dc1e9644fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679

During reset the BARs might be accessed when they are
unmapped. This can cause unexpected issues, so fix it by
clearing the cached BAR values so they are not accessed
until they are re-mapped.

Also, make sure any places that can access the BARs
when they are NULL are prevented.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c  | 28 +++++++++++++++------
 drivers/net/ethernet/amd/pds_core/core.c    |  8 +++++-
 drivers/net/ethernet/amd/pds_core/dev.c     |  9 ++++++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  3 ++-
 drivers/net/ethernet/amd/pds_core/fw.c      |  3 +++
 drivers/net/ethernet/amd/pds_core/main.c    |  5 ++++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 5edff33d56f3..ea773cfa0af6 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -191,10 +191,16 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 
 	/* Check that the FW is running */
 	if (!pdsc_is_fw_running(pdsc)) {
-		u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
-
-		dev_info(pdsc->dev, "%s: post failed - fw not running %#02x:\n",
-			 __func__, fw_status);
+		if (pdsc->info_regs) {
+			u8 fw_status =
+				ioread8(&pdsc->info_regs->fw_status);
+
+			dev_info(pdsc->dev, "%s: post failed - fw not running %#02x:\n",
+				 __func__, fw_status);
+		} else {
+			dev_info(pdsc->dev, "%s: post failed - BARs not setup\n",
+				 __func__);
+		}
 		ret = -ENXIO;
 
 		goto err_out_unlock;
@@ -266,10 +272,16 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 			break;
 
 		if (!pdsc_is_fw_running(pdsc)) {
-			u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
-
-			dev_dbg(pdsc->dev, "%s: post wait failed - fw not running %#02x:\n",
-				__func__, fw_status);
+			if (pdsc->info_regs) {
+				u8 fw_status =
+					ioread8(&pdsc->info_regs->fw_status);
+
+				dev_dbg(pdsc->dev, "%s: post wait failed - fw not running %#02x:\n",
+					__func__, fw_status);
+			} else {
+				dev_dbg(pdsc->dev, "%s: post wait failed - BARs not setup\n",
+					__func__);
+			}
 			err = -ENXIO;
 			break;
 		}
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index f44333bd1256..65c8a7072e35 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -600,7 +600,13 @@ void pdsc_fw_up(struct pdsc *pdsc)
 
 static void pdsc_check_pci_health(struct pdsc *pdsc)
 {
-	u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
+	u8 fw_status;
+
+	/* some sort of teardown already in progress */
+	if (!pdsc->info_regs)
+		return;
+
+	fw_status = ioread8(&pdsc->info_regs->fw_status);
 
 	/* is PCI broken? */
 	if (fw_status != PDS_RC_BAD_PCI)
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 31940b857e0e..62a38e0a8454 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -57,6 +57,9 @@ int pdsc_err_to_errno(enum pds_core_status_code code)
 
 bool pdsc_is_fw_running(struct pdsc *pdsc)
 {
+	if (!pdsc->info_regs)
+		return false;
+
 	pdsc->fw_status = ioread8(&pdsc->info_regs->fw_status);
 	pdsc->last_fw_time = jiffies;
 	pdsc->last_hb = ioread32(&pdsc->info_regs->fw_heartbeat);
@@ -182,13 +185,17 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 {
 	int err;
 
+	if (!pdsc->cmd_regs)
+		return -ENXIO;
+
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
 	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
-	memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
+	else
+		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
 	return err;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index e9948ea5bbcd..54864f27c87a 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -111,7 +111,8 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 
 	mutex_lock(&pdsc->devcmd_lock);
 	err = pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
-	memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
+	if (!err)
+		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
 	if (err && err != -EIO)
 		return err;
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index 90a811f3878a..fa626719e68d 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -107,6 +107,9 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 
 	dev_info(pdsc->dev, "Installing firmware\n");
 
+	if (!pdsc->cmd_regs)
+		return -ENXIO;
+
 	dl = priv_to_devlink(pdsc);
 	devlink_flash_update_status_notify(dl, "Preparing to flash",
 					   NULL, 0, 0);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 5172a5ad8ec6..05fdeb235e5f 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -37,6 +37,11 @@ static void pdsc_unmap_bars(struct pdsc *pdsc)
 	struct pdsc_dev_bar *bars = pdsc->bars;
 	unsigned int i;
 
+	pdsc->info_regs = NULL;
+	pdsc->cmd_regs = NULL;
+	pdsc->intr_status = NULL;
+	pdsc->intr_ctrl = NULL;
+
 	for (i = 0; i < PDS_CORE_BARS_MAX; i++) {
 		if (bars[i].vaddr)
 			pci_iounmap(pdsc->pdev, bars[i].vaddr);
-- 
2.17.1


