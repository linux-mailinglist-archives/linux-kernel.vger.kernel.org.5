Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75E7BD7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjJIKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346057AbjJIKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:06:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBEAC6;
        Mon,  9 Oct 2023 03:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVvDO2gwdTq8TfvnJz2cVzWMWGi0OtukPcUmCei3JrOS36Un1oohFvWQdXCsJW8jccZwTf9T0twnfXwujMo5id3sf5WP+IRcP2leQgcZEdQhshryN4tBOH3ZkKbyqrzs+yhzWnXUITZFgf3H8TEdTdzmqYp4IGDVngxQAZ1ZUZX0fKa9AKR1tNnuPFS8foOeXJ70pXqGArBHSm+4k77vgoU6uGLHKr66t8iqkk3tJaPloXTAH+QHqoCUDkNAlm9Bt1TOlmb1x6iOYYYiXlwxOoyse4ndFWVyqoAHNKHRzsHQzwcpL2yD9AMh480nLDqi/LxEX2CdiKN7IDXyX/+52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bOSTM+yEk4wMHZfxyFrjgvwUwfOEgcd9FAeju5IZTk=;
 b=f3OVGgfl0cUTfuBD1flwy52bPuS1WUcGoFrZoPKjoeh3w9R0ZK51QEQnybq2vmPlQW59WzbJa+maYKMnbcHoH+ptdeNOylzyNPap/nCgbBnjcehSWeeaap8V4eibkSUXhsZheaj3hWOAZwokqmsCST3MasfAfpPH2keguNP1J7wFQtgoBCSEbydcm4MVsWesIUINn56z1jpafoLj/YIqyinMnT1d0aBeDYbOnqd/eVoo4P+X2F9HTLvKOczmlGXCGQWzw01xJuZM7KiGK1/6Kg5I/7dJ+DSqb9LrP/J1vkvgh4rqVqJE712S+r7nTIUvv2NEY8C6FH4NFSBMIrW9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bOSTM+yEk4wMHZfxyFrjgvwUwfOEgcd9FAeju5IZTk=;
 b=POX5C6VdHAERC0bzoYg/Bfanom6f1DzdZMwyvMGO+jjyb0RAQQwX9dQvVXwTdtW5BprBjJOSQVIUre9YjyXB3gs2o+k1FY1eNvQ70nhgiG0tf8bwqYmt1vvATfSHPhzEpI2xFXcaGrs958Ypo0/qDC/judSaF2OTYLrtFG3evbB2zgDBLO9eWKcEscu9Hqz07mwQnHRn1bfMENTQSy5QRsvNiPqooSeaNqhAGdFgOv6/00ycXlu9+4HqFItoaYQxoGXQT8NUORsXb8+A1vW2Tod9falI9Qn6WN2PtapNj6IJbrcpTYluPN6mzIRu84cglNDNQegCDMpvJW+suPI3tQ==
Received: from DM6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:5:bc::45) by
 SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 10:06:13 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::21) by DM6PR13CA0032.outlook.office365.com
 (2603:10b6:5:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 10:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:06:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:07 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 03:06:04 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v2 1/2] firmware: tegra: add suspend hook and reset BPMP IPC early on resume
Date:   Mon, 9 Oct 2023 15:35:56 +0530
Message-ID: <20231009100557.18224-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009100557.18224-1-sumitg@nvidia.com>
References: <20231009100557.18224-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b61d2f-d19d-4340-0e25-08dbc8af5e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdEhdBXnaaeek/PnrxsH00nrjbRbPdTp02/gQaXlVSa+NPZdz6wNj5IbYiQ4wrHfX3g8cNG6J2HricGrdc9VxJaSXK1TxFbTZ+VQYqXo8JHVtv8DyluKI+4GiknIhXU6x0k2JoGjsKAtFv/I467k543eK/4Hcshsj0ysZdW8YX0HA3PYixZIujNeteJKpbalTLQZasmCojuj38B6/8KQwDEtBbX65zKCyuCA6TR9gZOEYOSJolYIjcAn4DVWoc39Ex9kcatfUq0NNPk4ZBCWCbSdJdyVkne5myq61vOhSUe/xh37WrlauPN/oCz21T68jgQWw1OzFPohxhwfEg34iBqLitJzXu7404Il10A/ietHmnvVRRpYYfaAmdWLVRXMy3OCOtvevKhmCUyhXiWXCmmHcPQdgk2cs24pp+jEfskAeIcRAV+jbcVf2jONPY28yXZkxdRhGuqGimii5s2OLYyFlAq18MCAViGePBBFr54Kyt1cJE6AUd/IXwVuQjnCz0mI2n4Lwm+7enEE48SLCnwSP9csDyXSOrnZv1Bh9V7JDcK8zn+vpUgQuVLL5wn5n8A5ZoJUuSWDR2atM5u92oZANDzZyI3tyMTq103wzWDkijxdF7i0x1N98C9/QzkPkRlFDLkWoYtWt2vhJGeY74IjtjOWOM0FXshOTom7BF4OSi6SgI3Mn2zfHrw5CCczhwQqkSGH4AU8KVKeKNwmMYWA9iLmYy34VvWPficY89JkRWhI7HplR/OmdHAPU56a
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(426003)(40460700003)(83380400001)(107886003)(1076003)(2616005)(336012)(26005)(47076005)(36860700001)(110136005)(70206006)(70586007)(54906003)(316002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(7696005)(6666004)(2906002)(15650500001)(82740400003)(478600001)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:06:12.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b61d2f-d19d-4340-0e25-08dbc8af5e43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend hook and a 'suspended' field in the 'struct tegra_bpmp'
to mark if BPMP is suspended. Also, add a 'flags' field in the
'struct tegra_bpmp_message' whose 'TEGRA_BPMP_MESSAGE_RESET' bit
can be set from the Tegra MC driver to signal that the reset of BPMP
IPC channels is required before sending MRQ to the BPMP FW.
Together both the fields allow us to handle any requests that might
be sent too soon as they can cause hang during system resume.
One case where we see BPMP requests being sent before the BPMP driver
has resumed is the memory bandwidth requests which are triggered by
onlining the CPUs during system resume. The CPUs are onlined before
the BPMP has resumed and we need to reset the BPMP IPC channels to
handle these requests.
The additional check for 'flags' is done to avoid any un-intended BPMP
IPC reset if the tegra_bpmp_transfer*() API gets called during suspend
sequence after the BPMP driver is suspended.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Co-developed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 30 ++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 51d062e0c3f1..c1590d3aa9cb 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -313,6 +313,8 @@ static ssize_t tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
 	return __tegra_bpmp_channel_write(channel, mrq, flags, data, size);
 }
 
+static int __maybe_unused tegra_bpmp_resume(struct device *dev);
+
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg)
 {
@@ -325,6 +327,14 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->suspended) {
+		/* Reset BPMP IPC channels during resume based on flags passed */
+		if (msg->flags & TEGRA_BPMP_MESSAGE_RESET)
+			tegra_bpmp_resume(bpmp->dev);
+		else
+			return -EAGAIN;
+	}
+
 	channel = bpmp->tx_channel;
 
 	spin_lock(&bpmp->atomic_tx_lock);
@@ -364,6 +374,14 @@ int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	if (bpmp->suspended) {
+		/* Reset BPMP IPC channels during resume based on flags passed */
+		if (msg->flags & TEGRA_BPMP_MESSAGE_RESET)
+			tegra_bpmp_resume(bpmp->dev);
+		else
+			return -EAGAIN;
+	}
+
 	channel = tegra_bpmp_write_threaded(bpmp, msg->mrq, msg->tx.data,
 					    msg->tx.size);
 	if (IS_ERR(channel))
@@ -796,10 +814,21 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused tegra_bpmp_suspend(struct device *dev)
+{
+	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
+
+	bpmp->suspended = true;
+
+	return 0;
+}
+
 static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 
+	bpmp->suspended = false;
+
 	if (bpmp->soc->ops->resume)
 		return bpmp->soc->ops->resume(bpmp);
 	else
@@ -807,6 +836,7 @@ static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_bpmp_pm_ops = {
+	.suspend_noirq = tegra_bpmp_suspend,
 	.resume_noirq = tegra_bpmp_resume,
 };
 
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 5842e38bb288..f5e4ac5b8cce 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -102,8 +102,12 @@ struct tegra_bpmp {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_mirror;
 #endif
+
+	bool suspended;
 };
 
+#define TEGRA_BPMP_MESSAGE_RESET BIT(0)
+
 struct tegra_bpmp_message {
 	unsigned int mrq;
 
@@ -117,6 +121,8 @@ struct tegra_bpmp_message {
 		size_t size;
 		int ret;
 	} rx;
+
+	unsigned long flags;
 };
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
-- 
2.17.1

