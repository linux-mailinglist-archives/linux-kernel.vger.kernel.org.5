Return-Path: <linux-kernel+bounces-16994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352848246F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F31B216BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE928E29;
	Thu,  4 Jan 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CaQ5bIk7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66C28E06;
	Thu,  4 Jan 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBlVPBCMYFvtAWphm01tteO7Vp3Ui0lXj9XnRsqxBsLtcOItvCPy3se2efX1XhfJj7QCduo0OyKT5n3JYmKvQoy8u+ZXF/l/u8r+pqGdUkAog0mn5xEZJCU1aNhPnVb8nII6IIiPR7dQVRLNEtxTkvIPeYZDqUzBFNai79HhxCXMUuPdtcuALJf+/DFjSPpvW3xWKUVPICtgmUVkz51vqfuW1sx6if7hBU9eeKbZ+I6nY22P3+cAXzvtO8B3GRX5guAmo0CwfxoSKmnIaCdrgQ2eqqGVlX5AVx9ctF1ssk36JZfpeTbbBGjOLwMphoAmi00ppPtV6qWbgpbg7Ok7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+dlkuWMJkvaR6JZQa8AmAvq+gqFp1jXyolnCqC28hI=;
 b=Eq0VNoVdq2sUs3zqx9kB4PQ5mXfZXVnIVHYbi1WUfFzUuRM2Xw4p0SX+MLrKG0cNcOdtVGxB4u+G2zHhEXw/Rrpqfa7Kticc0KZyzYNPkKBfJzhGCJo4491MjmpxC6TPN9rwDRs84+Tbuh/ylilx//0YQZbEvzO2ZqOJBTkB+/4Hp1ILHIq7Z0AXhWmI7w5ngZ0hMveegJayxmCcf92L4+1uxkkTwMYP60TRoi4iW3lU6hnsghnudhC4fccauDIBNDZy0eOhlaltu8IQOExb82v0lzjKjz94lC0SrwLWLOHrf5nzB3udcXVAkMht3OfEMofagawp3r00SWGktFtv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+dlkuWMJkvaR6JZQa8AmAvq+gqFp1jXyolnCqC28hI=;
 b=CaQ5bIk7i7HrDBdPY86+A+OV2sbWn25l8m6Lj5tRq4A49Fthlo31BxAIwgeVZh4zQURiFVt0aHDAjbN2uPkTQ1ekCjiJ6iXAaQmwB4/JaxR60Cb1BmnXv2tuO8RY7+OB0QCxFsUmCETEZ5N/DS+X5Z47gew9omRV+D+y4rmMJnw=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 17:12:37 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2c) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:35 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 1/8] pds_core: Prevent health thread from running during reset/remove
Date: Thu, 4 Jan 2024 09:12:14 -0800
Message-ID: <20240104171221.31399-2-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ed67ce-8944-4aa4-f1ca-08dc0d48598b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y14mKHzwzMyoEl+RCQgmyCKFGNsnPmkxjznR43Ud7ycRlGJDkRZfrn9ALH6PMFGoKyKWmZNx/1nZm2yueHM7gNnuc3Gw7vMBpc5dlp1bKfWtBK1JTruvkacIFuxoK1PaTYfLeoGfrTHM1JxYuvkCcIosds5b53dD8XOohFyKBI43v4pFwqnvOrpIpy55dTsiZ/a3xqUix7Zl/IAFx2v3o1zhOOdKkimYhFyaViaG7dVEdJo5DeIJGFPt1mmOl56zC8Hjox3pfMQoP14sPbgem9iFNi5rWmOkF+FI5prwJDE5vug6D07wNC06Cx/GZ+BOnzgb74zZUMN1phoeGSUmJ6KxPUd9tODrAAFXsECS371HeZUjNgVGytQ6Uewj1cQ5q5yM8VH7GndORUAjpyuo1yTOjPM+OzI+zm7Rd0b5mDX8OlDJePwQ2nwCV2FlM3Oo5tAgXKAWusJtXvqQcXcr/Hc8NE7zABriYAKu2bYwe6MjIG2C+QGe4nw39+kuXK/FaTG4YYBW2DGfDANrWogXOq96xjEwBj/zVzU8rYzl+zKtajP2auhvvCQd1+ehg3FrnW2sNIXWwNY0ntfvMxzVw3yyZEYrM8Rhs6bEr0Rm2eLH1sO64rPIjq6vpjEUSfr5JmmdDyWgnEBu9mhnX+TrTw1ExasfRbs4ZKUB9kAspG8VGpW/lH1Y8KtKyRaprOQjjRikVaHfQ7keJGHNb3OzTe+nj+bD7hY1E4BAwOYLtE8E0VpmZMMt6Cv2o0g3m/EV8qLAz6OvTOzKQ8whY2T7SA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(2906002)(356005)(8936002)(4326008)(8676002)(316002)(336012)(426003)(2616005)(16526019)(1076003)(83380400001)(81166007)(36860700001)(26005)(40480700001)(36756003)(40460700003)(82740400003)(86362001)(41300700001)(70586007)(6666004)(110136005)(478600001)(70206006)(47076005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:36.9042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ed67ce-8944-4aa4-f1ca-08dc0d48598b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815

The PCIe reset handlers can run at the same time as the
health thread. This can cause the health thread to
stomp on the PCIe reset. Fix this by preventing the
health thread from running while a PCIe reset is happening.

As part of this use timer_shutdown_sync() during reset and
remove to make sure the timer doesn't ever get rearmed.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 3080898d7b95..5172a5ad8ec6 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -293,7 +293,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 err_out_teardown:
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
 err_out_unmap_bars:
-	del_timer_sync(&pdsc->wdtimer);
+	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->wq)
 		destroy_workqueue(pdsc->wq);
 	mutex_destroy(&pdsc->config_lock);
@@ -420,7 +420,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		 */
 		pdsc_sriov_configure(pdev, 0);
 
-		del_timer_sync(&pdsc->wdtimer);
+		timer_shutdown_sync(&pdsc->wdtimer);
 		if (pdsc->wq)
 			destroy_workqueue(pdsc->wq);
 
@@ -445,10 +445,24 @@ static void pdsc_remove(struct pci_dev *pdev)
 	devlink_free(dl);
 }
 
+static void pdsc_stop_health_thread(struct pdsc *pdsc)
+{
+	timer_shutdown_sync(&pdsc->wdtimer);
+	if (pdsc->health_work.func)
+		cancel_work_sync(&pdsc->health_work);
+}
+
+static void pdsc_restart_health_thread(struct pdsc *pdsc)
+{
+	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
+	mod_timer(&pdsc->wdtimer, jiffies + 1);
+}
+
 void pdsc_reset_prepare(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 
+	pdsc_stop_health_thread(pdsc);
 	pdsc_fw_down(pdsc);
 
 	pci_free_irq_vectors(pdev);
@@ -486,6 +500,7 @@ void pdsc_reset_done(struct pci_dev *pdev)
 	}
 
 	pdsc_fw_up(pdsc);
+	pdsc_restart_health_thread(pdsc);
 }
 
 static const struct pci_error_handlers pdsc_err_handler = {
-- 
2.17.1


