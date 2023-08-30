Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28278DBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbjH3Sk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbjH3L6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:58:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8911B0;
        Wed, 30 Aug 2023 04:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvDQeu86MpBjf8qBId14xgmVZ3hiS5+48/KLPKMLNmYLbt4hTxDNpqj6l2uHtMvSDn+gshtp/0GARe7fCT5ZHomDtExTCyd04RoVkkLH2CXRhqUGN3PG599KnktlNOJq9wDNX+9BhC4fkUr56IeZzhdpgsNjsXrdiZRSIIT7TmGfyo3chEeH3DdS3lQOv3FotMt2IGayiZpQjzs1DQ0RvQwoK47lxMyZK7Sh8ijg6VzVuX6zMRBhJPV2iF8xVAaSsHWIm9x/+MREVCvTY3XBOLEqrBkLpLmS9b83GT3y8eGtPwP+R/vYcFOjWYOG9nfeEY3OWr4eDlZHmgJP3ZUV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Sabd2z4EN9K5LGigJTA3hTk3qNf3pWhPH8nWmVAHI=;
 b=FgUwMZkzSBfyUBm9BpjFi8ZMMbj4crKYiBhJHG1RqfLGk/ROtwdEP4dfh4maqBP/XbnidJMK3qHZ20UO8BhcPYRkPWvp+s8hTGbsubQ+ORNVS4ZzA2e+6k5+oX8YiVQFbOUi9xzcB49gZ37I1Ne/7NK+Pk83I9bZZKyZoU5A8YyxxRwpCM5w6mmAVCNyy5DHv2JnfGpfMCBsA77g15SLN8II9W/JCAOIKu/nab2jNpIwSAScefYxz/mfd2/zE3+RYQTub5MgdMQyJBZ5ALzbMv5bPqM7xDyxYvGNsD2hMU7XF9dH0aPEB1DLPNzpzmQ5kJ2gWZtYv53sTZHrsacZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Sabd2z4EN9K5LGigJTA3hTk3qNf3pWhPH8nWmVAHI=;
 b=dkoun+Sc20gAsRYaSatn9TwXdvtnCn+vNwF5MWeS547sOIuG1rB4KxyllZhGVThpS3Ol39rEwwMJs+kFaTdbZgyzWYz9HoqxzbCtGDD416rM8iDwrxB3e39zVSeB6fz+U+sYQc8RgaQZctQxpTRsYRzFDeGG0EBM07hE8vcPUuxRUONzn6VSg0FDZ3/LUW0qrJICwbGdK36vToDFG/IENdt1sjD4rJvOnZoTa9VI4NSMXC/mIMk45Aj+qYcgiJWALnBr/4ALdaXRi1mqxAFHdN32gq+lUTtpki32Oa8MdXOpQRmay2KwMk777hD8/GenaKikOI58sw58z/voUq610w==
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 11:58:42 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::9c) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 11:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 11:58:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 04:58:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 04:58:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 04:58:31 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sivaramn@nvidia.com>, <talho@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch] firmware: tegra: reset BPMP IPC channels early during resume
Date:   Wed, 30 Aug 2023 17:28:29 +0530
Message-ID: <20230830115829.23977-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: da6e6d57-b820-4e89-41f0-08dba950748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYxUmMJHlSsVtwTzRkvnpAW7kTDkJQHGS6IuQ1qubzi5KZnVhwDy6xonadqgBe0ebMwrzuq1gwkk1pJrIwlv2xbocXKKZqUbTmlBIq5MIlDG3WhEaXMKvUdtryuQcgrT2tXQx5T5YF8yFhoe4bltYA4tMrG6KhIwC4objs5pHNEyZD8VBGB4s7jVBcN8YnF43r12vAWxeu9f/6B+qu+ht1ZxE4w+PVpKQ9e2CrsK5cBDCyH87VTpAEG8D0S4IGruNhUCVEC1Vmt7nYXqwxqjawuPxYvsC+JV/HOdSFbLp/eKWctVV8YhdnGuGnbLa2uW40ECTzdgMZgjiCzwk+TxqW8LnfNC4cEVZTaPdtvCQoeMBjx11HnXrt5TzdVxjc2u4Q0WY0O3JM0EiZj/7Pq2pQtlhDUcsPc7iib0l6hWdJBWQ6cfuUnKJtOzfcrTKi+P9GvVrfW/tyt9DNk3riaMted89DchEkPVqFM1cbcHIDXFEjqVjBUHBmELpjA2pMw+d227sCtUI0Qb1QZbXErvrhFlZFbP3IBlZLDx7Twk/QGtTYR3W6GUJsD90slS/r/te8bO+9SxUIWWGKxGEWlqBnZivBmbH+i1F4CvXrBNHgX0vXd2FSGJoLPx6u9tOaAoCECSvFIxsJ9mt8tuN+RLRLLc+lYkvDdgS/YFxfLTq5cvKCZeubEnuO8E+JTFrisc3QmKoMQByKxNXsWu2DohLt9IQoJau+o4clSNKSIGrYtydQ1s6Pt0LfiWFabTgDhd
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(7636003)(316002)(54906003)(70206006)(70586007)(356005)(478600001)(110136005)(82740400003)(2906002)(86362001)(8936002)(8676002)(450100002)(7696005)(41300700001)(5660300002)(4326008)(83380400001)(107886003)(36860700001)(47076005)(1076003)(26005)(426003)(2616005)(336012)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:58:42.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e6d57-b820-4e89-41f0-08dba950748f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'tegra_bpmp_reset()' function to reset the IPC channels for BPMP
on first call to tegra_bpmp_transfer() API after system resumes. This
allows us to handle any requests that might be sent too soon as they
can cause hang during system resume. One case where we see BPMP requests
being sent before the BPMP driver has resumed is the memory bandwidth
requests which are triggered by onlining the CPUs during system resume.
The CPUs are onlined before the BPMP has resumed and we need to reset
the BPMP IPC channels to handle these requests.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/firmware/tegra/bpmp-private.h  |  2 +-
 drivers/firmware/tegra/bpmp-tegra186.c |  4 +--
 drivers/firmware/tegra/bpmp.c          | 45 ++++++++++++++++++++++----
 include/soc/tegra/bpmp.h               |  2 ++
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-private.h b/drivers/firmware/tegra/bpmp-private.h
index 182bfe396516..8f59bbe990dc 100644
--- a/drivers/firmware/tegra/bpmp-private.h
+++ b/drivers/firmware/tegra/bpmp-private.h
@@ -20,7 +20,7 @@ struct tegra_bpmp_ops {
 	int (*post_response)(struct tegra_bpmp_channel *channel);
 	int (*post_request)(struct tegra_bpmp_channel *channel);
 	int (*ring_doorbell)(struct tegra_bpmp *bpmp);
-	int (*resume)(struct tegra_bpmp *bpmp);
+	int (*reset)(struct tegra_bpmp *bpmp);
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC) || \
diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
index 6f0d0511b486..122d0c630863 100644
--- a/drivers/firmware/tegra/bpmp-tegra186.c
+++ b/drivers/firmware/tegra/bpmp-tegra186.c
@@ -366,7 +366,7 @@ static void tegra186_bpmp_deinit(struct tegra_bpmp *bpmp)
 	tegra186_bpmp_teardown_channels(bpmp);
 }
 
-static int tegra186_bpmp_resume(struct tegra_bpmp *bpmp)
+static int tegra186_bpmp_reset(struct tegra_bpmp *bpmp)
 {
 	tegra186_bpmp_reset_channels(bpmp);
 
@@ -385,5 +385,5 @@ const struct tegra_bpmp_ops tegra186_bpmp_ops = {
 	.post_response = tegra186_bpmp_post_message,
 	.post_request = tegra186_bpmp_post_message,
 	.ring_doorbell = tegra186_bpmp_ring_doorbell,
-	.resume = tegra186_bpmp_resume,
+	.reset = tegra186_bpmp_reset,
 };
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 51d062e0c3f1..6a269a66175e 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -313,6 +313,14 @@ static ssize_t tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
 	return __tegra_bpmp_channel_write(channel, mrq, flags, data, size);
 }
 
+static int tegra_bpmp_reset(struct tegra_bpmp *bpmp)
+{
+	if (bpmp->soc->ops->reset)
+		return bpmp->soc->ops->reset(bpmp);
+
+	return 0;
+}
+
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg)
 {
@@ -325,6 +333,15 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->needs_reset) {
+		err = tegra_bpmp_reset(bpmp);
+		if (err < 0) {
+			dev_err(bpmp->dev, "Failed to reset the BPMP!\n");
+			return err;
+		}
+		bpmp->needs_reset = false;
+	}
+
 	channel = bpmp->tx_channel;
 
 	spin_lock(&bpmp->atomic_tx_lock);
@@ -364,6 +381,15 @@ int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->needs_reset) {
+		err = tegra_bpmp_reset(bpmp);
+		if (err < 0) {
+			dev_err(bpmp->dev, "Failed to reset the BPMP!\n");
+			return err;
+		}
+		bpmp->needs_reset = false;
+	}
+
 	channel = tegra_bpmp_write_threaded(bpmp, msg->mrq, msg->tx.data,
 					    msg->tx.size);
 	if (IS_ERR(channel))
@@ -740,6 +766,8 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	bpmp->needs_reset = false;
+
 	err = tegra_bpmp_request_mrq(bpmp, MRQ_PING,
 				     tegra_bpmp_mrq_handle_ping, bpmp);
 	if (err < 0)
@@ -796,18 +824,23 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __maybe_unused tegra_bpmp_resume(struct device *dev)
+static int __maybe_unused tegra_bpmp_suspend(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 
-	if (bpmp->soc->ops->resume)
-		return bpmp->soc->ops->resume(bpmp);
-	else
-		return 0;
+	/*
+	 * If the BPMP has a reset handler then mark as
+	 * not ready until on entry to suspend. This flag
+	 * is used to trigger the reset after resume.
+	 */
+	if (bpmp->soc->ops->reset)
+		bpmp->needs_reset = true;
+
+	return 0;
 }
 
 static const struct dev_pm_ops tegra_bpmp_pm_ops = {
-	.resume_noirq = tegra_bpmp_resume,
+	.suspend_noirq = tegra_bpmp_suspend,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC) || \
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 5842e38bb288..932f7fd1edfb 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -102,6 +102,8 @@ struct tegra_bpmp {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_mirror;
 #endif
+
+	bool needs_reset;
 };
 
 struct tegra_bpmp_message {
-- 
2.17.1

