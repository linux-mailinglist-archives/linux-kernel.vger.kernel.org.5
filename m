Return-Path: <linux-kernel+bounces-4718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C14818123
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA241C23269
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A879D0;
	Tue, 19 Dec 2023 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="flwxG/s8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9366FAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLTXHyA8xxz++4ID3RtnnrejjHb1+qUNEhDUx6xJtXJmBFqLbz5S9wjK+wklbXvZH7QZYCYEvGUug/OS7+iV+hpCuzoZQUw8Sxq4BF0tgyW9RPwtsWDG5+vhUDjDLrtalP9bYZJvYfYrpyEw1tUDh/qPubEcPZOguKSSIKKx9l6S7wcQH8B1Wk8i3fwxf1SlwXbCopQojZ8u34bbRGiWfQLD+JWobSksbhMxDjDPa0sFrGeWeEpXOfL/TRF1U3KeaB6zScxZtYed6IDmtk/HKPgT29Q6biqBvG0SJ8OFJq0/5wS+kLk3dY/4rHks4lQXzDdlAW1Punkosr22Wdd5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pl441ahlHTJgUCOp3kTIl0zOknnarfPNDQF9OJv0zg=;
 b=bJhjHm85uPRhC17oQIhhiamba3onPZVdOsS5cbqHIyKCtF4VjFMJsWy/QsvGRbkY1MXumyKD9uvAIJFAbkcPXeK8GbCJn22xaoyhi74gaH14b4jrY0K7LJvR2I2JIl6LNo760ymvNH+6Ar0qBZFCUPCKnvjQ+neMqIvomD9GYMi/wjAZ6U44p3rScl5V6sGgacYP/oNx7Ub9k/hzXumKVBbmvhGl1gjkp/ZQg4uPKT8Tw5zmORj4tIVYVbWox8nXDhex9aJ08pTBeol5vC98+Yc90navgh+TfUiZIE4ShYSz4rYwcLYMrslUNe5CN/6aP36T+/RKyxTsE+liArV4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pl441ahlHTJgUCOp3kTIl0zOknnarfPNDQF9OJv0zg=;
 b=flwxG/s8r0FfNFKmxq6QAVuUJL38mvLYSjPoRHqn7FBqOHdEZP5xs0OuwGImGuPP7KHx9sKxb1wDriJye13YwK7CVAg8T2sltuiwYvQbioxQYHVNZiG2llK5O/XKq3EDGWz9uxSRvzdlS4OH0vceTxFI5zi4ZWDxTNbDadu5jNg=
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 05:50:49 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::8e) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 05:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 05:50:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:50:48 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 23:50:47 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH V2 2/2] drivers: soc: xilinx: add check for platform
Date: Mon, 18 Dec 2023 21:50:25 -0800
Message-ID: <20231219055025.27570-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219055025.27570-1-jay.buddhabhatti@amd.com>
References: <20231219055025.27570-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee6bd79-91b5-4da6-0d8b-08dc00567417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UoZa+yfqtiFxoc4Kvp3GXFw5jESul4o05NKKIsnTUYZsAbMFib0HivTOl5+dFZGXz4h3XVraSMYAuhpRjKDs96CiEEG5mMjqmNbkdV6oTjUxIlutB7cg4GeH62bGMzxaWduOSZCIZfehMz2AAz/a7nvBMXI60IYeE8gKTENvPQvxkEk4eGritpnRhmVVMLzjSJxxPPMbI1E9T1UFmClzyTYmo4WaN/uKfdBSp1GC5oG/3CdqQbGSveLIN8NYxviO5Ya0l0hiyhxmSnPxDxRDHBZ7C8PYh9FVewCX/EAbo+7Bf8UmHBpDQoZI7tv9GiUQYQP2zE2ryK2pgB2jh9S0xVzC4lWETZV+IAKa6PQGs44Hzk+zv8aSx+ur3cuLWAE0rrg8GHi19oXaPlacNgMoWf4k54BCPlaiegYs2TK0Aorup3UXN9SMai3lPSUvX0md2uTBBQgUjMhQUb5m7KuQn8SQ1b6X12cMf8w/E1z6H0okI2PvB1KeetK3EYKgenRZ9OyzKxzzhdL2fgXEcdoT4Ed0o8KCZKM1y+oNVeUfxMZIFh6MA558de08gyHaTvh5P+R2gn0Zv9MiAn2apWFkoJugXHdiFIOIBVuEiW8T7Lw/Vv3YxRV06PAanQGdnfjcPWr08YcvygztpQTJyrKRuKiq1KPGuE6OMI/jOcrziouLDZIvVqROcOveWPdGVoLdjSTM3L+4vFBqe4NpGHyoAkIXGh4uQjNDdacx6hwDtBHGSQb03GaLdkDoRI0ABtCgLuyxb+kexVrs+V6jZdshCx4a3GyJse+hK2W/96EJ8a4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(6636002)(54906003)(70586007)(70206006)(110136005)(316002)(40480700001)(478600001)(26005)(426003)(1076003)(336012)(44832011)(47076005)(40460700003)(4326008)(8676002)(8936002)(6666004)(36860700001)(5660300002)(2906002)(86362001)(81166007)(356005)(36756003)(82740400003)(41300700001)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:50:49.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6bd79-91b5-4da6-0d8b-08dc00567417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

Some error event IDs for Versal and Versal NET are different.
Both the platforms should access their respective error event
IDs so use sub_family_code to check for platform and check
error IDs for respective platforms. The family code is passed
via platform data to avoid platform detection again.
Platform data is setup when even driver is registered.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/edac/versal_edac.c              |  4 ++--
 drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 8625de20fc71..62caf454b567 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1005,7 +1005,7 @@ static int mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
-	rc = xlnx_register_event(PM_NOTIFY_CB, EVENT_ERROR_PMC_ERR1,
+	rc = xlnx_register_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR |
 				 XPM_EVENT_ERROR_MASK_NOC_CR | XPM_EVENT_ERROR_MASK_NOC_NCR,
 				 false, err_callback, mci);
@@ -1042,7 +1042,7 @@ static int mc_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(priv->debugfs);
 #endif
 
-	xlnx_unregister_event(PM_NOTIFY_CB, EVENT_ERROR_PMC_ERR1,
+	xlnx_unregister_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
 			      XPM_EVENT_ERROR_MASK_NOC_CR |
 			      XPM_EVENT_ERROR_MASK_NOC_NCR |
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..78f9a3c6ae11 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -77,11 +77,26 @@ struct registered_event_data {
 
 static bool xlnx_is_error_event(const u32 node_id)
 {
-	if (node_id == EVENT_ERROR_PMC_ERR1 ||
-	    node_id == EVENT_ERROR_PMC_ERR2 ||
-	    node_id == EVENT_ERROR_PSM_ERR1 ||
-	    node_id == EVENT_ERROR_PSM_ERR2)
-		return true;
+	u32 pm_family_code, pm_sub_family_code;
+
+	zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+
+	if (pm_sub_family_code == VERSAL_SUB_FAMILY_CODE) {
+		if (node_id == VERSAL_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR2)
+			return true;
+	} else {
+		if (node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4)
+			return true;
+	}
 
 	return false;
 }
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2375ce9b38df..2cfd78f232dc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -91,10 +91,18 @@
 /*
  * Node IDs for the Error Events.
  */
-#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
-#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
-#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
-#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
 
 /* ZynqMP SD tap delay tuning */
 #define SD_ITAPDLY	0xFF180314
-- 
2.17.1


