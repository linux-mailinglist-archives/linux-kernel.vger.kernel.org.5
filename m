Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D487EF732
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbjKQRnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjKQRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:42:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA1D7A;
        Fri, 17 Nov 2023 09:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA9wiMZiAVmTN/bouP8xRyDCjKdCFQBCME97ociVAU1WqtG3z70iqJfsGoTl1NEOS2E1f0FLEd2r0w/dGcQcpbLOZaFMfiqDFiscdDaxZB8doobgJahY1T5IgJEkbOwZ+o09a+a7zbxVhEzyayb6kOq0OBMDSFvK0KUF8iueGJqnsnLVQfN7hgcJn+AED2jyYGz+W9J2cBNPvP6qov4c1saxLRBIaHc6qoKNbf8huE+RrRXTp2CvLOd5uXSry464iRHBPZvOWm2GHFXI/QhISPsUHCmO2EjQjno0t9JLtfaR1K8M8jSPfhj7daEIf3ZTqCvXXUp2GnIMfaunojCd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMxDNlzH4itOgmRBqr/XNtpwrr/e1VXONefXBCpitRs=;
 b=QUhMgazmgyEx1WaHBvp4sfCmYAfIP61q5//JSm7NXWQcyh+aSeCsO6IXKy/B5Iv8QoBPNAvxtmFy2bWOFT/eD9ow0U8v8fvLUXK7LKJyR0T7sNIhaOFoelNvWsVAuVdAiwAwu1H2qTUUNNAsfHC3XDQPXWaVxib0bwyzhsT89Ll7wS24eL9ZpHhyxXtGNyPWh9vewJKHSExe980xWyYR5kGH+AU//boqmJewB9cEcAXkF8hWffSgJMfYjcZFyngAwhy6eOsBnulheSPVqS5s2C8dBMV4qefWDZCseGCZrgp8+px8CP1L3HPaA830PXaqfFVPDvgI8e+I+FF1HVF5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMxDNlzH4itOgmRBqr/XNtpwrr/e1VXONefXBCpitRs=;
 b=KwS/G47gClFj4wRXBncPSb1KbembuJ8SEmYZL/1iPi6ZMAjhDOm5723D6iffQr7HdhYBy/Y+F+rOcv/KnUYa++J9fjzLYTLdkQwn+C2kMdCi4DYIestjPoLbFKOcOOPjgKHH7A9KzmLym4FUnhA2QbC1kLpq+71F8fVd7pw3gvM=
Received: from CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::19)
 by DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 17:42:49 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::d1) by CH0P221CA0018.outlook.office365.com
 (2603:10b6:610:11c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 17:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Fri, 17 Nov 2023 17:42:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 11:42:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 09:42:48 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 11:42:47 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Date:   Fri, 17 Nov 2023 09:42:37 -0800
Message-ID: <20231117174238.1876655-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117174238.1876655-1-tanmay.shah@amd.com>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM6PR12MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf99c33-5518-4d45-28be-08dbe7949d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUf178ogUnXfuaa6NEJfIUf8ye7q5I38IY6XdsCC0YZsoB7YB6ITJaghDQcccj4G4mClxzMH8AwxvrIPxhR/F6dWJp03t3kQ+MvRGpx1OOxspmAcr65fytCAMgJg+CQC9dDVjOBPD+J3sIH0msUEngpaFM+DprC6vAuGv6wyNoi7s/kHW+Xkq3ZrqhvwtFmzV7itOUY7UI//dRlsemwTrGQmKaJ+J+4i/23rDgpEdOcryIxmi5QPLcmmPdaG2BQLqz07qxx4ybQ+879XzIMg0rbPtvZp/jLXHZ33qw6Owr/hQLxELV68By6Iu6mnQ9heE6V2jrGkF18y9Gh0iHP349ip9OMrEW1sFzQC1jtnZ1iHpQ269APc0lZ6UQ+jPEeLrvVsrZ5exw01M+hoo8V/zZk1RLZAXb1WBlNs89ob3CaK3c7DjqeQBvVkuMUGH3NNVnB7vOk5Y23Pg9O2zpA5uEySYvr1hufzu17vg7PxD6oHz4xMzWsKLFrQQ8o6LNyBiLuO1wvEY+6KaAv9aoLX7WqHRTKsAIqg7BAlmn5gP83g8Np9O7cAddWrl1LOUx+zKv+9KPB3WcpgvWqmwsYFZuf+EE+PyU5q7ZeWGS9LmF3hb3eU7VPC17456eT60tYc9NED45cFDlkgsmQS771dA3tbVlXrhWOs/NmiNmx7evN2fpChM0mKxHadqXwAbALC/7IqPezxCmWQ2n+rRSmqt+AMmOWaIcsopWmLcvdPRqVr0gPRanIBtfZNrE8a3D2+PXxkNgKc0cwBmRsoisvdAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(36756003)(316002)(478600001)(40460700003)(83380400001)(41300700001)(356005)(81166007)(426003)(336012)(82740400003)(36860700001)(1076003)(8936002)(8676002)(5660300002)(4326008)(44832011)(47076005)(26005)(6666004)(86362001)(70206006)(110136005)(70586007)(2906002)(2616005)(40480700001)(7049001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:42:48.6332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf99c33-5518-4d45-28be-08dbe7949d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use TCM pm domains extracted from device-tree
to power on/off TCM using general pm domain framework.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v7:
  - %s/pm_dev1/pm_dev_core0/r
  - %s/pm_dev_link1/pm_dev_core0_link/r
  - %s/pm_dev2/pm_dev_core1/r
  - %s/pm_dev_link2/pm_dev_core1_link/r
  - remove pm_domain_id check to move next patch
  - add comment about how 1st entry in pm domain list is used
  - fix loop when jump to fail_add_pm_domains loop

 drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 4395edea9a64..22bccc5075a0 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/pm_domain.h>
 
 #include "remoteproc_internal.h"
 
@@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
  * @ipi: pointer to mailbox information
+ * @num_pm_dev: number of tcm pm domain devices for this core
+ * @pm_dev_core0: pm domain virtual devices for power domain framework
+ * @pm_dev_core0_link: pm domain device links after registration
+ * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
+ * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
+ * registration
  */
 struct zynqmp_r5_core {
 	struct device *dev;
@@ -111,6 +118,11 @@ struct zynqmp_r5_core {
 	struct rproc *rproc;
 	u32 pm_domain_id;
 	struct mbox_info *ipi;
+	int num_pm_dev;
+	struct device **pm_dev_core0;
+	struct device_link **pm_dev_core0_link;
+	struct device **pm_dev_core1;
+	struct device_link **pm_dev_core1_link;
 };
 
 /**
@@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
 					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
 		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
+			dev_err(dev, "failed to turn on TCM 0x%x",
+				pm_domain_id);
 			goto release_tcm_lockstep;
 		}
 
@@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct device *dev = r5_core->dev;
+	struct zynqmp_r5_cluster *cluster;
+	int i;
+
+	cluster = platform_get_drvdata(to_platform_device(dev->parent));
+
+	for (i = 1; i < r5_core->num_pm_dev; i++) {
+		device_link_del(r5_core->pm_dev_core0_link[i]);
+		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
+	}
+
+	kfree(r5_core->pm_dev_core0);
+	r5_core->pm_dev_core0 = NULL;
+	kfree(r5_core->pm_dev_core0_link);
+	r5_core->pm_dev_core0_link = NULL;
+
+	if (cluster->mode == SPLIT_MODE) {
+		r5_core->num_pm_dev = 0;
+		return;
+	}
+
+	for (i = 1; i < r5_core->num_pm_dev; i++) {
+		device_link_del(r5_core->pm_dev_core1_link[i]);
+		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
+	}
+
+	kfree(r5_core->pm_dev_core1);
+	r5_core->pm_dev_core1 = NULL;
+	kfree(r5_core->pm_dev_core1_link);
+	r5_core->pm_dev_core1_link = NULL;
+	r5_core->num_pm_dev = 0;
+}
+
+static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct device *dev = r5_core->dev, *dev2;
+	struct zynqmp_r5_cluster *cluster;
+	struct platform_device *pdev;
+	struct device_node *np;
+	int i, j, num_pm_dev, ret;
+
+	cluster = dev_get_drvdata(dev->parent);
+
+	/* get number of power-domains */
+	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
+						"#power-domain-cells");
+
+	if (num_pm_dev <= 0)
+		return -EINVAL;
+
+	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
+					sizeof(struct device *),
+					GFP_KERNEL);
+	if (!r5_core->pm_dev_core0)
+		ret = -ENOMEM;
+
+	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
+					     sizeof(struct device_link *),
+					     GFP_KERNEL);
+	if (!r5_core->pm_dev_core0_link) {
+		kfree(r5_core->pm_dev_core0);
+		r5_core->pm_dev_core0 = NULL;
+		return -ENOMEM;
+	}
+
+	r5_core->num_pm_dev = num_pm_dev;
+
+	/*
+	 * start from 2nd entry in power-domains property list as
+	 * for zynqmp we only add TCM power domains and not core's power domain.
+	 * 1st entry is used to configure r5 operation mode.
+	 */
+	for (i = 1; i < r5_core->num_pm_dev; i++) {
+		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
+			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
+				PTR_ERR(r5_core->pm_dev_core0[i]));
+			ret = -EINVAL;
+			goto fail_add_pm_domains;
+		}
+		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
+								r5_core->pm_dev_core0[i],
+								DL_FLAG_STATELESS |
+								DL_FLAG_RPM_ACTIVE |
+								DL_FLAG_PM_RUNTIME);
+		if (!r5_core->pm_dev_core0_link[i]) {
+			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
+			r5_core->pm_dev_core0[i] = NULL;
+			ret = -EINVAL;
+			goto fail_add_pm_domains;
+		}
+	}
+
+	if (cluster->mode == SPLIT_MODE)
+		return 0;
+
+	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
+					sizeof(struct device *),
+					GFP_KERNEL);
+	if (!r5_core->pm_dev_core1) {
+		ret = -ENOMEM;
+		goto fail_add_pm_domains;
+	}
+
+	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
+					     sizeof(struct device_link *),
+					     GFP_KERNEL);
+	if (!r5_core->pm_dev_core1_link) {
+		kfree(r5_core->pm_dev_core1);
+		r5_core->pm_dev_core1 = NULL;
+		ret = -ENOMEM;
+		goto fail_add_pm_domains;
+	}
+
+	/* get second core's device to detach its power-domains */
+	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		dev_err(cluster->dev, "core1 platform device not available\n");
+		kfree(r5_core->pm_dev_core1);
+		kfree(r5_core->pm_dev_core1_link);
+		r5_core->pm_dev_core1 = NULL;
+		r5_core->pm_dev_core1_link = NULL;
+		ret = -EINVAL;
+		goto fail_add_pm_domains;
+	}
+
+	dev2 = &pdev->dev;
+
+	/* for zynqmp we only add TCM power domains and not core's power domain */
+	for (j = 1; j < r5_core->num_pm_dev; j++) {
+		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
+		if (!r5_core->pm_dev_core1[j]) {
+			dev_dbg(dev, "can't attach to pm domain %d\n", j);
+			ret = -EINVAL;
+			goto fail_add_pm_domains_lockstep;
+		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
+			dev_dbg(dev, "can't attach to pm domain %d\n", j);
+			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
+			goto fail_add_pm_domains_lockstep;
+		}
+
+		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
+								r5_core->pm_dev_core1[j],
+								DL_FLAG_STATELESS |
+								DL_FLAG_RPM_ACTIVE |
+								DL_FLAG_PM_RUNTIME);
+		if (!r5_core->pm_dev_core1_link[j]) {
+			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
+			r5_core->pm_dev_core1[j] = NULL;
+			ret = -ENODEV;
+			goto fail_add_pm_domains_lockstep;
+		}
+	}
+
+fail_add_pm_domains_lockstep:
+	while (--j >= 0) {
+		device_link_del(r5_core->pm_dev_core1_link[j]);
+		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
+	}
+	kfree(r5_core->pm_dev_core1);
+	r5_core->pm_dev_core1 = NULL;
+	kfree(r5_core->pm_dev_core1_link);
+	r5_core->pm_dev_core1_link = NULL;
+
+fail_add_pm_domains:
+	while (--i >= 0) {
+		device_link_del(r5_core->pm_dev_core0_link[i]);
+		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
+	}
+	kfree(r5_core->pm_dev_core0);
+	r5_core->pm_dev_core0 = NULL;
+	kfree(r5_core->pm_dev_core0_link);
+	r5_core->pm_dev_core0_link = NULL;
+
+	return ret;
+}
+
 /**
  * zynqmp_r5_rproc_prepare()
  * adds carveouts for TCM bank and reserved memory regions
@@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
 {
 	int ret;
 
+	ret = zynqmp_r5_add_pm_domains(rproc);
+	if (ret) {
+		dev_err(&rproc->dev, "failed to add pm domains\n");
+		return ret;
+	}
+
 	ret = add_tcm_banks(rproc);
 	if (ret) {
 		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
-		return ret;
+		goto fail_prepare;
 	}
 
 	ret = add_mem_regions_carveout(rproc);
 	if (ret) {
 		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
-		return ret;
+		goto fail_prepare;
 	}
 
 	return 0;
+
+fail_prepare:
+	zynqmp_r5_remove_pm_domains(rproc);
+
+	return ret;
 }
 
 /**
@@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 
 	r5_core = rproc->priv;
 
+	zynqmp_r5_remove_pm_domains(rproc);
+
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 		if (zynqmp_pm_release_node(pm_domain_id))
-- 
2.25.1

