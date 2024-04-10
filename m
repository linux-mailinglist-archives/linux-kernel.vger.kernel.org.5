Return-Path: <linux-kernel+bounces-139044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C229F89FE00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F57B2E211
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653A17BB1D;
	Wed, 10 Apr 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SrUc9foH"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC217B503
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768916; cv=fail; b=hOrVJb88EEXedzGDENgvbDAliiGVLUS6YxOMJ2Uqc+XSqJTzUOkrvLzyHyGd8cDJ7wS7BS0hSk0t1ZvblHU6iHsc30tbMpSL0eYk9inJLa3ertkBLcm/LHECyq6Ljf2Ir5RnpvpUGjJ7R2ifECDhS5hcsaXVi6SdxEScvOyqNlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768916; c=relaxed/simple;
	bh=qtsg7NPosEps0wJGrDZ5OAfxZWpv+mVXJkajsbSh+6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLSj3NVd8covt6tUQasO8y85JkqPqCsMZHWi+2XTHvnx3sdPF56QGKcFSyVQttAoinP2yudhXo4zpotwqXdtLRoq+LcOVnU7scZebxTmM7I49YNReCVQt1AUzASy/ZRvEBzeO8cBONObkNz+NbNY9qjDAK8ahwAyjBAaQkzFhLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SrUc9foH; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVSuMCBofsV7WiLrcQuBKIzB2LtKUypsboj8HHF594Kb6L2w6SalJxKJuPMv3pV6mNLJigctr7T9dRAtirNgCdDU6vHvLMbrA7WhP4ZrmgzatkE/B1HBlsp3bbVRyz6Znh0dhAV62eEzOpj4fleh/OGFKDrwXtKC9YT1XcID1hgExVs1RLSKAtKQMfFJZi8pTst0aI2tHrH82UyZvoXgrydRYVLNSeKdXiFuV2VhfM1EH6RKZIxQyx6OlIcUHWhTqXijJmL/GaVjBfRXB1WYTwn0uE3zFTZk38WvqwVRz+oK0/nbknkFuwY6WphEQTI+Bh9SfpzNNhSrXI4fMgg11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMUrhmPaUuglFn+QghKD/ocMN2CGGdwUlNU8B0OpfPU=;
 b=m1bjEvQTlybMNug0OsGdvYMZguuWaXknVrEH8ysCJW5GmWS6buX7UjSQUaX2azLZYh+wFhf/HNLobHg2RmK9vIrMdoYMneib/By0dFXckKigjXZjs+W0M3wP5wWgo09JbzsxIZn0gvFouWQIDTDCVJ7Wz4VmM4MI76GMnph3dk17r9Unpj2KwJcJk9VVk1z1bBnSbtAmm7S5ywNKl6fCDugfy6+Me6t9GoKjkxKJ/ejDRDfcJI+ol83qT6GWfxe8pn5sTgmp0BXq2HYpKYcxHGOGN5v4qhMSmDOA5+jcwlY2YshCkOIU2V4axkn7bhxPUW6ax8u4jwIqKKzuWOke9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMUrhmPaUuglFn+QghKD/ocMN2CGGdwUlNU8B0OpfPU=;
 b=SrUc9foHCNWama8gxZTVGQst4L3e3Rs0bcIL2pCIy6AVVM4w4ms8VuWy8DBEyWfNNV+aEY9t38atMcCVPaVrg7IKyHqLHTatIZfCd1dfpCEL+Y38LW4VzNMDs7GY7fG4G7K4wgCPsD+xW7MfvsgVgl0Abg1LXnOjD0VMcArK2JU=
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 17:08:31 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::b8) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Wed, 10 Apr 2024 17:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:08:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 12:08:27 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 12:08:27 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>,
	<shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/3] mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
Date: Wed, 10 Apr 2024 10:08:24 -0700
Message-ID: <20240410170825.1132324-3-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410170825.1132324-1-ben.levinsky@amd.com>
References: <20240410170825.1132324-1-ben.levinsky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ben.levinsky@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ea1052-cc1d-4bb7-80b6-08dc5980d93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eNpzqTw+sokpgrFNoATA77bTMR0aEkQRd2k1fmCdVFoNYVRq0zHCdjliB3cSXOk8KU4FDWGFEItViiWB/84u6yeAYtDQKGC/J+0s2GkL424zV8co4FprTMarJbOqhCAyUEDAYFiyDpW/qwXZb865YTke6mwBzpH8212T0ZbLQxdaX4sMPlHf8qBdLUVUBZhP8oWrcaHvvKXYaVq1XBwjR2MA/D10q0vHBYKUSZhZIyn+SOuBS8htmlaPNdILH+NcQjMzb7GiXBVYLIfKb4UzvYR2KpCFbF8uwfYIWlExLAQwXU+hGiJIMVet6GI1UTA4iFHPOV2jaBVBb8NhBQqVmtXQwOfbrcWwCJFc+QbrWwRXAXA5xWL0iA8mxgCaItpQfKevKvcUyGRuHK5effHPgrPgPYj9vqHGxjtIzyWFIcwzydeqOPAnpKZWtI9dxf8YsGiDj8CbHlZA5ChM4mWpzhu+X3SN7HoEuFEOv68OgRFSbv8e7SRDgx4nZUadkFt60m64vHuSsVY3jwNM7jx8Rh1qGex2KUXUb3zRDaJ6wGGdTPvNOAPGxZ/1POBMdsnehCa/2Uilz0gvVdNPZhGq951Gc1AS/Yv+56RzOn16oFEPSVuBcPUGPOCyaimO39bQNP9b/ZSjJute2E9IC6GnaeIpYVJV1uTsRM253X3Bkgp7mAILevT9LK0bLSwtyDzBHYyY8QFbXw53UmP70zI1419Wc4a6CUVz0UhUqyPu+KxaMsl5c5HtMkUBQ2o6nm9z
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:08:31.3890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea1052-cc1d-4bb7-80b6-08dc5980d93d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Move routine that initializes the mailboxes for send and receive to
a function pointer that is set based on compatible string.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 122 +++++++++++++++++++--------
 1 file changed, 87 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index c7ce0826383f..56ba7135db54 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -72,6 +72,10 @@ struct zynqmp_ipi_mchan {
 	unsigned int chan_type;
 };
 
+struct zynqmp_ipi_mbox;
+
+typedef int (*setup_ipi_fn)(struct zynqmp_ipi_mbox *ipi_mbox, struct device_node *node);
+
 /**
  * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
  *                          platform data.
@@ -81,6 +85,7 @@ struct zynqmp_ipi_mchan {
  * @remote_id:            remote IPI agent ID
  * @mbox:                 mailbox Controller
  * @mchans:               array for channels, tx channel and rx channel.
+ * @setup_ipi_fn:         Function Pointer to set up IPI Channels
  */
 struct zynqmp_ipi_mbox {
 	struct zynqmp_ipi_pdata *pdata;
@@ -88,6 +93,7 @@ struct zynqmp_ipi_mbox {
 	u32 remote_id;
 	struct mbox_controller mbox;
 	struct zynqmp_ipi_mchan mchans[2];
+	setup_ipi_fn setup_ipi_fn;
 };
 
 /**
@@ -464,12 +470,9 @@ static void zynqmp_ipi_mbox_dev_release(struct device *dev)
 static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 				 struct device_node *node)
 {
-	struct zynqmp_ipi_mchan *mchan;
 	struct mbox_chan *chans;
 	struct mbox_controller *mbox;
-	struct resource res;
 	struct device *dev, *mdev;
-	const char *name;
 	int ret;
 
 	dev = ipi_mbox->pdata->dev;
@@ -489,6 +492,73 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	}
 	mdev = &ipi_mbox->dev;
 
+	/* Get the IPI remote agent ID */
+	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI remote ID is specified.\n");
+		return ret;
+	}
+
+	ret = ipi_mbox->setup_ipi_fn(ipi_mbox, node);
+	if (ret) {
+		dev_err(dev, "Failed to set up IPI Buffers.\n");
+		return ret;
+	}
+
+	mbox = &ipi_mbox->mbox;
+	mbox->dev = mdev;
+	mbox->ops = &zynqmp_ipi_chan_ops;
+	mbox->num_chans = 2;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->txpoll_period = 5;
+	mbox->of_xlate = zynqmp_ipi_of_xlate;
+	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+	mbox->chans = chans;
+	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
+	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
+	ret = devm_mbox_controller_register(mdev, mbox);
+	if (ret)
+		dev_err(mdev,
+			"Failed to register mbox_controller(%d)\n", ret);
+	else
+		dev_info(mdev,
+			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_setup - set up IPI Buffers for classic flow
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * This will be used to set up IPI Buffers for ZynqMP SOC if user
+ * wishes to use classic driver usage model on new SOC's with only
+ * buffered IPIs.
+ *
+ * Note that bufferless IPIs and mixed usage of buffered and bufferless
+ * IPIs are not supported with this flow.
+ *
+ * This will be invoked with compatible string "xlnx,zynqmp-ipi-mailbox".
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
+			    struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *mchan;
+	struct device *mdev;
+	struct resource res;
+	const char *name;
+	int ret;
+
+	mdev = &ipi_mbox->dev;
+
 	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
 	name = "local_request_region";
 	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
@@ -563,37 +633,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	if (!mchan->rx_buf)
 		return -ENOMEM;
 
-	/* Get the IPI remote agent ID */
-	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
-	if (ret < 0) {
-		dev_err(dev, "No IPI remote ID is specified.\n");
-		return ret;
-	}
-
-	mbox = &ipi_mbox->mbox;
-	mbox->dev = mdev;
-	mbox->ops = &zynqmp_ipi_chan_ops;
-	mbox->num_chans = 2;
-	mbox->txdone_irq = false;
-	mbox->txdone_poll = true;
-	mbox->txpoll_period = 5;
-	mbox->of_xlate = zynqmp_ipi_of_xlate;
-	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
-	if (!chans)
-		return -ENOMEM;
-	mbox->chans = chans;
-	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
-	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
-	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
-	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
-	ret = devm_mbox_controller_register(mdev, mbox);
-	if (ret)
-		dev_err(mdev,
-			"Failed to register mbox_controller(%d)\n", ret);
-	else
-		dev_info(mdev,
-			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
-	return ret;
+	return 0;
 }
 
 /**
@@ -624,6 +664,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_pdata *pdata;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
+	setup_ipi_fn ipi_fn;
 
 	num_mboxes = of_get_available_child_count(np);
 	if (num_mboxes == 0) {
@@ -644,9 +685,18 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ipi_fn = (setup_ipi_fn)device_get_match_data(&pdev->dev);
+	if (!ipi_fn) {
+		dev_err(dev,
+			"Mbox Compatible String is missing IPI Setup fn.\n");
+		return -ENODEV;
+	}
+
 	pdata->num_mboxes = num_mboxes;
 
 	mbox = pdata->ipi_mboxes;
+	mbox->setup_ipi_fn = ipi_fn;
+
 	for_each_available_child_of_node(np, nc) {
 		mbox->pdata = pdata;
 		ret = zynqmp_ipi_mbox_probe(mbox, nc);
@@ -690,7 +740,9 @@ static void zynqmp_ipi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id zynqmp_ipi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox",
+	  .data = &zynqmp_ipi_setup,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
-- 
2.25.1


