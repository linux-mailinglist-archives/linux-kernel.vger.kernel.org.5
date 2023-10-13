Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B37C7C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjJMEYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjJMEXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:23:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA5D8;
        Thu, 12 Oct 2023 21:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/YI4a8gS9e14P0w6BiJDIA0llR5ioUXLIJG8wzostDmIvlNvx4NDcMaSNPcyFihHb8a2H4f2Jn0gXKkKeTCf4mXb5SPTCo/2VnLSpzyw/TLcuxEdXiJnOl+U76e59nPbf7K9u/aeQwB8ABwP3uxuBOT6aLGt5Q7VF8nVj4bA6FMSulmsNTBdVpKLcrkVkmGJsw2k9c1NN2b/kRQIQq2DbRLjYCDVj0354r8wz7smmA98HjCkJSZddEUjyEnmnZ8Qxl1NSsGcQ2FUMxT3ZXOIpRC4zs5ohJ9MpUF7FI1qtALKtMTQfbZKlaoq1ZbwAPs1BwEwwBt5YIuDV/q/wROug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb2Ep6AX1JlfJV4/Ifz+Vp5pJQUOPG68HXv7nHQeMAw=;
 b=BtPmuUAvtVF4dHzMRoTR4AqNk6REqcZBRW3ILNTBWFU+DUjXFQ/KwD1YC5LBTQGvPZFuykThUBj2KN71sAH5RodI451bFEM6TVu7AGfe6gOhCBrJG0q/PojCOoOaduDvmbakUr3rxo5EIBYtPUYseHvar/ohE65OOPkfqzDPjWZDAHl7T4JX8B7mn4oIDcOGmpijTi9VX6qBm9mv+1JshB0kd+kcLQVhYPHtSLZg58nbb3D2a5c0a6gEGzEdyIzezdiEMmmQ5Ckchm+R1z+av8b9cu5dqNdfQeEDAojyzO7JWHg65WkndBLqHGOV7rTj6YGEeGTY8RcXiYqfnxZGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb2Ep6AX1JlfJV4/Ifz+Vp5pJQUOPG68HXv7nHQeMAw=;
 b=LPx1PRPnT4n3c+JoKkNnyOW2R9jOUH/squ3CTVD9rcfVVPD8dcdmFe3XaT57myBDqdyzIW58oDBkISBKhvRBSo7mHZFJ3dwRACCj5zGuiNNAgFfm0J7WUL+uUz3rFXoIP6ziWSwlQRNA/Ypc/DhXkNDk29EcCOJrMW7Bc5mrFBo=
Received: from BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) by BY5PR12MB4965.namprd12.prod.outlook.com
 (2603:10b6:a03:1c4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 04:23:39 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::cd) by BL0PR1501CA0009.outlook.office365.com
 (2603:10b6:207:17::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 04:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 13 Oct 2023 04:23:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:23:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:23:38 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:23:37 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] remoteproc: zynqmp: add pm domains support
Date:   Thu, 12 Oct 2023 21:22:28 -0700
Message-ID: <20231013042229.3954527-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013042229.3954527-1-tanmay.shah@amd.com>
References: <20231013042229.3954527-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 155f68b3-f6bb-494b-b884-08dbcba42cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkWXj1kTm7WmapAKZHlgRcFYFlcmFnibZCyA9DOFnEx72D53s78TKKkkwxnvp8WPsI3RAcQGeP3pN3jmhoBlG1BjX+4CnnNj7otVyr1cPOf2s+0JhV++qqCAE6lnKfKgkbCKleZouyZ4HZE2D8rQhPggxXhR8PzD2ztgCnmqSP5y9qOOAcrPs///7j9ghUd2OVBPdDfpDmcWoLj2K4GEwT8jcqCSKTe6XuSYISlFXZwdlK2voHrBvpcUEMmzdiuaBnKyBm49sU69SVsy3eWkEhmTEHy3E59eMQdUjCgNdAfOp0PMgDkGE8Zhf3aNjeh+P/HP21V4j9TkRLbHfNEoE2BHhWYf+FmGF5zA8rcUWr2Ypn57LHrdQkMmNkCBEjWqBD2qKuS2fCvCcdJgWobPeceTj3bdgOZwMAQsGPxD4i8Qz/tMr+ny4ANVaeCDuHIlXeVctNzwnfjjZwr2sUvRBBVd1WKhAdbw/0Z670ys83C9Gg0qGT3w0mwEI3AUEu2Joyx4CZ5n/GsqYJkMTG5XEVDV7vUKTg6OOWk8fARNGo/4tMb0B6S2ce+k+WeKFwyN6JKCREWbVayCIrQHkdy8vZ7A6F2eGJ/FOq4mwgvYaOE1NNRbr9JrYGQAug2EKehHTXyIOcxaZgAv93dYBebsATvkaZeNddgmEzdKr2Q7VcTOzs3IPS14ZYEOdgNUlM1gOAMjq4hWWy+LZgGfAXwH6FyzquPYVszIDIvx6dDfKaeY+Zoqg5cQno5K7iMFxG07f+gkn3TIEAXNByQX9t1Z5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(316002)(40460700003)(36756003)(110136005)(8676002)(8936002)(70586007)(82740400003)(356005)(81166007)(86362001)(36860700001)(40480700001)(54906003)(70206006)(4326008)(44832011)(2906002)(41300700001)(30864003)(6666004)(2616005)(426003)(336012)(7049001)(5660300002)(1076003)(26005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 04:23:39.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155f68b3-f6bb-494b-b884-08dbcba42cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use TCM pm domains extracted from device-tree
to power on/off TCM using general pm domain framework.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v6:
  - Remove spurious change
  - Handle errors in add_pm_domains function
  - Remove redundant code to handle errors from remove_pm_domains

 drivers/remoteproc/xlnx_r5_remoteproc.c | 262 ++++++++++++++++++++++--
 1 file changed, 243 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 4395edea9a64..04e95d880184 100644
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
+ * @pm_dev1: pm domain virtual devices for power domain framework
+ * @pm_dev_link1: pm domain device links after registration
+ * @pm_dev2: used only in lockstep mode. second core's pm domain virtual devices
+ * @pm_dev_link2: used only in lockstep mode. second core's pm device links after
+ * registration
  */
 struct zynqmp_r5_core {
 	struct device *dev;
@@ -111,6 +118,11 @@ struct zynqmp_r5_core {
 	struct rproc *rproc;
 	u32 pm_domain_id;
 	struct mbox_info *ipi;
+	int num_pm_dev;
+	struct device **pm_dev1;
+	struct device_link **pm_dev_link1;
+	struct device **pm_dev2;
+	struct device_link **pm_dev_link2;
 };
 
 /**
@@ -575,12 +587,21 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 		bank_size = r5_core->tcm_banks[i]->size;
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 
-		ret = zynqmp_pm_request_node(pm_domain_id,
-					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
-					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
-		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
-			goto release_tcm_split;
+		/*
+		 * If TCM information is available in device-tree then
+		 * in that case, pm domain framework will power on/off TCM.
+		 * In that case pm_domain_id is set to 0. If hardcode
+		 * bindings from driver is used, then only this driver will
+		 * use pm_domain_id.
+		 */
+		if (pm_domain_id) {
+			ret = zynqmp_pm_request_node(pm_domain_id,
+						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+			if (ret < 0) {
+				dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
+				goto release_tcm_split;
+			}
 		}
 
 		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
@@ -646,13 +667,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	for (i = 0; i < num_banks; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 
-		/* Turn on each TCM bank individually */
-		ret = zynqmp_pm_request_node(pm_domain_id,
-					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
-					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
-		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
-			goto release_tcm_lockstep;
+		if (pm_domain_id) {
+			/* Turn on each TCM bank individually */
+			ret = zynqmp_pm_request_node(pm_domain_id,
+						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+			if (ret < 0) {
+				dev_err(dev, "failed to turn on TCM 0x%x",
+					pm_domain_id);
+				goto release_tcm_lockstep;
+			}
 		}
 
 		bank_size = r5_core->tcm_banks[i]->size;
@@ -687,7 +711,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
+		if (pm_domain_id)
+			zynqmp_pm_release_node(pm_domain_id);
 	}
 	return ret;
 }
@@ -758,6 +783,192 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
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
+		device_link_del(r5_core->pm_dev_link1[i]);
+		dev_pm_domain_detach(r5_core->pm_dev1[i], false);
+	}
+
+	kfree(r5_core->pm_dev1);
+	r5_core->pm_dev1 = NULL;
+	kfree(r5_core->pm_dev_link1);
+	r5_core->pm_dev_link1 = NULL;
+
+	if (cluster->mode == SPLIT_MODE) {
+		r5_core->num_pm_dev = 0;
+		return;
+	}
+
+	for (i = 1; i < r5_core->num_pm_dev; i++) {
+		device_link_del(r5_core->pm_dev_link2[i]);
+		dev_pm_domain_detach(r5_core->pm_dev2[i], false);
+	}
+
+	kfree(r5_core->pm_dev2);
+	r5_core->pm_dev2 = NULL;
+	kfree(r5_core->pm_dev_link2);
+	r5_core->pm_dev_link2 = NULL;
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
+	r5_core->pm_dev1 = kcalloc(num_pm_dev,
+				   sizeof(struct device *),
+				   GFP_KERNEL);
+	if (!r5_core->pm_dev1)
+		ret = -ENOMEM;
+
+	r5_core->pm_dev_link1 = kcalloc(num_pm_dev,
+					sizeof(struct device_link *),
+					GFP_KERNEL);
+	if (!r5_core->pm_dev_link1) {
+		kfree(r5_core->pm_dev1);
+		r5_core->pm_dev1 = NULL;
+		return -ENOMEM;
+	}
+
+	r5_core->num_pm_dev = num_pm_dev;
+
+	/*
+	 * start from 2nd entry in power-domains property list as
+	 * for zynqmp we only add TCM power domains and not core's power domain.
+	 */
+	for (i = 1; i < r5_core->num_pm_dev; i++) {
+		r5_core->pm_dev1[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR_OR_NULL(r5_core->pm_dev1[i])) {
+			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
+				PTR_ERR(r5_core->pm_dev1[i]));
+			ret = -EINVAL;
+			goto fail_add_pm_domains;
+		}
+		r5_core->pm_dev_link1[i] = device_link_add(dev, r5_core->pm_dev1[i],
+							   DL_FLAG_STATELESS |
+							   DL_FLAG_RPM_ACTIVE |
+							   DL_FLAG_PM_RUNTIME);
+		if (!r5_core->pm_dev_link1[i]) {
+			dev_pm_domain_detach(r5_core->pm_dev1[i], true);
+			r5_core->pm_dev1[i] = NULL;
+			ret = -EINVAL;
+			goto fail_add_pm_domains;
+		}
+	}
+
+	if (cluster->mode == SPLIT_MODE)
+		return 0;
+
+	r5_core->pm_dev2 = kcalloc(num_pm_dev,
+				   sizeof(struct device *),
+				   GFP_KERNEL);
+	if (!r5_core->pm_dev2) {
+		ret = -ENOMEM;
+		goto fail_add_pm_domains;
+	}
+
+	r5_core->pm_dev_link2 = kcalloc(num_pm_dev,
+					sizeof(struct device_link *),
+					GFP_KERNEL);
+	if (!r5_core->pm_dev_link2) {
+		kfree(r5_core->pm_dev2);
+		r5_core->pm_dev2 = NULL;
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
+		kfree(r5_core->pm_dev2);
+		kfree(r5_core->pm_dev_link2);
+		r5_core->pm_dev2 = NULL;
+		r5_core->pm_dev_link2 = NULL;
+		ret = -EINVAL;
+		goto fail_add_pm_domains;
+	}
+
+	dev2 = &pdev->dev;
+
+	/* for zynqmp we only add TCM power domains and not core's power domain */
+	for (j = 1; j < r5_core->num_pm_dev; j++) {
+		r5_core->pm_dev2[j] = dev_pm_domain_attach_by_id(dev2, j);
+		if (!r5_core->pm_dev2[j]) {
+			dev_dbg(dev, "can't attach to pm domain %d\n", j);
+			ret = -EINVAL;
+			goto fail_add_pm_domains_lockstep;
+		} else if (IS_ERR(r5_core->pm_dev2[j])) {
+			dev_dbg(dev, "can't attach to pm domain %d\n", j);
+			ret = PTR_ERR(r5_core->pm_dev2[j]);
+			goto fail_add_pm_domains_lockstep;
+		}
+
+		r5_core->pm_dev_link2[j] = device_link_add(dev, r5_core->pm_dev2[j],
+							   DL_FLAG_STATELESS |
+							   DL_FLAG_RPM_ACTIVE |
+							   DL_FLAG_PM_RUNTIME);
+		if (!r5_core->pm_dev_link2[j]) {
+			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
+			r5_core->pm_dev2[j] = NULL;
+			ret = -ENODEV;
+			goto fail_add_pm_domains_lockstep;
+		}
+	}
+
+fail_add_pm_domains_lockstep:
+	while (j >= 1) {
+		if (r5_core->pm_dev_link2 && !IS_ERR_OR_NULL(r5_core->pm_dev_link2[j]))
+			device_link_del(r5_core->pm_dev_link2[j]);
+		if (r5_core->pm_dev2 && !IS_ERR_OR_NULL(r5_core->pm_dev2[j]))
+			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
+		j--;
+	}
+	kfree(r5_core->pm_dev2);
+	r5_core->pm_dev2 = NULL;
+	kfree(r5_core->pm_dev_link2);
+	r5_core->pm_dev_link2 = NULL;
+
+fail_add_pm_domains:
+	while (i >= 1) {
+		if (r5_core->pm_dev_link1 && !IS_ERR_OR_NULL(r5_core->pm_dev_link1[i]))
+			device_link_del(r5_core->pm_dev_link1[i]);
+		if (r5_core->pm_dev1 && !IS_ERR_OR_NULL(r5_core->pm_dev1[i]))
+			dev_pm_domain_detach(r5_core->pm_dev1[i], true);
+		i--;
+	}
+	kfree(r5_core->pm_dev1);
+	r5_core->pm_dev1 = NULL;
+	kfree(r5_core->pm_dev_link1);
+	r5_core->pm_dev_link1 = NULL;
+
+	return ret;
+}
+
 /**
  * zynqmp_r5_rproc_prepare()
  * adds carveouts for TCM bank and reserved memory regions
@@ -770,19 +981,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
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
@@ -801,11 +1023,13 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 
 	r5_core = rproc->priv;
 
+	zynqmp_r5_remove_pm_domains(rproc);
+
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		if (zynqmp_pm_release_node(pm_domain_id))
-			dev_warn(r5_core->dev,
-				 "can't turn off TCM bank 0x%x", pm_domain_id);
+		if (pm_domain_id && zynqmp_pm_release_node(pm_domain_id))
+			dev_dbg(r5_core->dev,
+				"can't turn off TCM bank 0x%x", pm_domain_id);
 	}
 
 	return 0;
-- 
2.25.1

