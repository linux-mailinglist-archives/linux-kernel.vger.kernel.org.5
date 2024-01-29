Return-Path: <linux-kernel+bounces-43639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DD841715
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C209828541D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C215B0EF;
	Mon, 29 Jan 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s4ozQf+9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43215AAAA;
	Mon, 29 Jan 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571662; cv=fail; b=Px6TW+mu/oTWaxbVDt46sAzCQI4ka/GUOta1YZV24XXXkSOKLn9+wyJ8sP8Z0Mv+vXkLufsiGG9uX0f9gjF0vCVOdsHpFGGnR8x77ajKxHqeliCtzfUKgW153cQtYqwECUC75PI73Uhf661F2/+WJPmMtm/2QX5EutEcrEnK/0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571662; c=relaxed/simple;
	bh=o4P71fNvSXTnO3fUt6UmgqhjWd63SKip1VC7TeFrFy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDdaB/QVSq51yDiqVKEG7BIJCgjUMtfiw2g02yohk0P1uKJLGqwYkqdDbsuVqYZ48QBKi9/laJAzRissL9eq9kGSa28xeNPZ0JaqNoHf96bWF6zDFQ7zGYalslG2jMMZHc6Xyznz/NF2QG0DWKE4LtnPboca9BD8J1SEE6t9Wz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s4ozQf+9; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTLIO1uPZhqa2yVnkkK9vJ1/8Ru7Uiums1dR8G+MCHB20q9quoHcx4kczrn0ejlRLrWmebrbIXcMt6hYP27eEPvICzgCS90BDeko5W3J/AFrzUkuyEPV1ZMwYTRdWvwnjW7yRq9RG2BdsF4uODn3p3ssaB7SyrvBy+py+vBSFdmAFt4Azz1riyxozxj6eOYydR4VSNFpuoRPZnIQopNQqYKso3eSLWzTt5SHweWL5sJF+y2l/m6pQBeUGnvfBJsFh84aFBVetKpJqIrFZFfC545g1HtWB5QLiIG1bUuuqNOHQ8thgnQMHsyLt3bTYWh3V9HQQoq2ss5k6bqfiqEBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVnPXx6BjNUaU8fmEAUwqSRRckWQ5fpbwjWpNBJS+FQ=;
 b=X6lJ5DG/Ka7D49DP7+gXJwpC9g3aCCZTC/eqkASPWG1lsEfdx3LD77BOt/VdLZlY0Qf+E84Y3XD1t2FdWpdVf1EDerdE8J/6YNW3+afNqGi7JVPszamqUFp+YOboVdOrJmVBcaCkHYyEn8qs3TAh6PPyf8ynLAG1qUnizwX0gkA5TE3ItQWNX/YPjMJ9RN2kGWQL9iuFDtLbMm9xaheQezzaAm7QHmLZ9czkzzK8+22wvGgUHSVVbS+5Wy9o2ppp0TgR4bjxsE9jQ4IOINTjbhMdHP2Bw0AnaFBz1U8LiOyf6uTs6NHOer0R0zDdAzovFGyaikzOsmFmoSs4D00GjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVnPXx6BjNUaU8fmEAUwqSRRckWQ5fpbwjWpNBJS+FQ=;
 b=s4ozQf+9x1FQ9KpKX1FjA2CmftYin7C0UnLpGZwtNNgOBY4eD4XQzfwgMgtq1juACqn8lvKw4+3IbTBgo6u3HpptWAwtPX2eVPZxyMsle8upBgdw+gH7/EJGuQwlhr4kks03+aJwpubky7JCT5twY3zjeAW7xGHHJHTMyiha9k0=
Received: from CH0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:610:b3::24)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 23:40:55 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::2a) by CH0PR03CA0049.outlook.office365.com
 (2603:10b6:610:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:52 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 5/6] pds_core: Clear BARs on reset
Date: Mon, 29 Jan 2024 15:40:34 -0800
Message-ID: <20240129234035.69802-6-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5119229d-e780-46df-b5c0-08dc2123bc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jl/+iTYzvzgZVORDK2N1b8IAVTSqKjpUYeMktOVBV9m+GzKeUWh/2YgP6jQJXoyeXnpaL01IDOEtXKVVvmo3uYkq0OwUxrVd3OE4xX0iFlw+61mlh4oI03QTtl2uoH+zMhbx7YW4JkOMwHL77T2VqJozSDzAlbaWo93MJfOoPhgYTD0gRxUy+echd7eyLPvU+lPUXmRxHZLgQdgNJ3f/akm9cVkV3JaRnOjH/FTonb25LZAz3U6wSWT9nTaIjk7ZA7Y3Vl5r3iVt3r4cG+mNOxLr9QaY7CQ5JOOHIndCr0OeRJiLXuyXZis7jlwcqpBpu/QA4kixyORmfKgdmk15t45dNqbJ0rYlEpgNtBc7DeHLCVKrsEzRWr5J9E0/ESKr9B9cqWBu/xVw9ESpRTbh+kqnzD8ObI3KgG0bPYTbjahx56Db91RrSVs/ySOdGxbLwIIk1pAxG/OSygnmMT3IFN/A0bDgNAM2HcqEQsZWg/20Y9gVup/8EPqhv9NUI5lYqTbxXPKgY/Xikltl8TuU4W86w3E746i7MJviYNcfte8HuH8LJ2XR59FmGoTxGdh54rB9SPCyqDA3YJ0+QDHQt6vkPELD88G4jGM+wD5ZpHO+7UkR+nCiqmeG9KJdlIZ8ndMUSPhV4cfj3drM9ek3SD1h45/HCLy3MU3E04dKQOpDrmC/npD4MpD/4/6f0tFI+bVGMeUIztPu6BZdCcpdCZ2yxOClEB/Cu+69sly3wvvfPt05Q7AZqhTAEWnFgG7HCkAOoznIgnesvaMiiv0PSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(426003)(1076003)(6666004)(336012)(478600001)(36860700001)(316002)(47076005)(8936002)(8676002)(5660300002)(4326008)(44832011)(81166007)(41300700001)(2616005)(70586007)(2906002)(54906003)(70206006)(110136005)(82740400003)(26005)(36756003)(86362001)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:55.1101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5119229d-e780-46df-b5c0-08dc2123bc9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107

During reset the BARs might be accessed when they are
unmapped. This can cause unexpected issues, so fix it by
clearing the cached BAR values so they are not accessed
until they are re-mapped.

Also, make sure any places that can access the BARs
when they are NULL are prevented.

Fixes: 49ce92fbee0b ("pds_core: add FW update feature to devlink")
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


