Return-Path: <linux-kernel+bounces-1846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86B8154BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC62B22E12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5614B12B;
	Fri, 15 Dec 2023 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="thWYxail"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDB48CF9;
	Fri, 15 Dec 2023 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZDVILEsm3/GMKBkCkupPEcfLujAbOSuKWv5dPvLGrwOjnp4pR7e6E9ng+d5MN2ZtfB2wwxGSs00tTOj6K1Ds52YJPTgnTwG4GltYcervJC5oOqTSv6e2x7U4C3r8vscrL0nNufVFz7D4R9pd6elI1Cpmx0/x7nV9BDsM4qOll9TiAbeB6TXm0aorVwY7xxBMzIb9Gtaa9EL3jtUJ6dqkVROymBfqFcJ07gS1PrkIqypQewlz8TMi7bICZHatIYbmIFh7Vomskg/WmwkFErOy5LHo7DWmUiWzfLFrfMcA24FadkqyubaLlKUwgK2kIUPOFYMpaNqaUwsk/6+zfuiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvl4+cVaqYww/vIFr5BXRJxt5oa6SG5tXO0+w9gsOII=;
 b=Hu1s5XC4TfW/BPQ/GqpeN7ZvpefXRLh9Py04bmvlXdGRTuu9hhIuLWqcIro5Re3V4hBsWqGtrO3aF+bflz17dePxeaKcWbbg6P2De4Hjx+vXBQJgh+mnHPzIo+udHn6DsaLIMOJgNZF07c5KwsyEGjYYhYWBDxJINkaT/oKOJILKaroldvnF/8/B47qQjWJXUVWr8DIfS+FqYNErO9VaZaL/CQDofc7Jck6spTZuLvW3EtgKCuwNrqoObkgSqEAQDu2qHbihEbGgz04DrrV4X/T3S0sKFOOPPgIkbv1z7Qy3rDooEHFCICa5th+aWxE3j42CoUJw3l8/we/fiqs3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvl4+cVaqYww/vIFr5BXRJxt5oa6SG5tXO0+w9gsOII=;
 b=thWYxailPGeAuSHyOkx+R0Sku/DHZNBePgZTmYIkN1hlNXGRXXm6fMhkb+ZPToeO1UoyWmdAGMJgAeYZQj1kS/BPoKb1Xb2FZT7DAn7CAOnFyn7BiUVCJl5Zpa5lR7uDYfiTVJ7C7isiOeVYtmYeRd5PB+FKn6zLVyxeMvfLLws=
Received: from MN2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:208:236::30)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 23:58:33 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::e6) by MN2PR05CA0061.outlook.office365.com
 (2603:10b6:208:236::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 23:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 23:58:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:23 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 17:58:22 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/3] remoteproc: zynqmp: parse TCM from device tree
Date: Fri, 15 Dec 2023 15:57:25 -0800
Message-ID: <20231215235725.1247350-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215235725.1247350-1-tanmay.shah@amd.com>
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: f06354c2-4059-4097-dc20-08dbfdc9be72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2M9kLUlrAhqglEr1/Q3PV++PuXQ9jeoNe3KtUnLwS/9E0ynWPtu86WT90AygtIfUbYirEYvsbVHfIGwoFtaqihrlTDxzaupfubS9tp0UmjsaEAX6tDozRBPkQuVJDfVVZ/5B8/Fsc3woRK4ElbT0nOhrtb2uSK444azdWmQBM83ZRGfMg5ruYuBgTOJkFKKHh60Y2DeMtq/mUGKngpP470AHHv6p0yzLY/QgnR7ZGjwqzuZeToxqAqFYriE9TRhlvOxp/qkJOmgicAtjoiPaVMI+ZbiEaWwoX/Eilk6GKCki5HyqoQSS4hOOmk7nvmPv9THgpr2BXpSs+iCkBevQvE/T7azHIik8uieBZERtQElQqZFGrxz5arIODVMx14XoD6VGNj8jx4FS0QZFF+75Nl5RPMHBe4ulCJM5ayl+EO1PowRaKvKOjPfipl6dLWt8iQbcr+hYqpvoDD0W05x4gN50tr+4N8RAFvzmo5S8P3rZ1uL5te4bqFPlF3Oq6q5rNjvPP9avcCCLOaXVwQRtM7WiduxO/9biVm2iEDF+un04zVag20fUdKnmNhlAmM3GisnCYyhmDxOfjVacTZDdPrlbgiK/mDuRjL/H4E9EuoBbuHsKlmLxCygZvjUN+aDrryVnU/NjIRrIbqHiO8cQhl0oD5OmUdhmPPYTLtuUXu2CuHEutoLacsnSqvxW8A3KdG1b7dCl5E0csC8LoyogMuv24HLZ+7ZydbTXYnwP+en75vQygeyrM7JwJztAdvkWjvmiPmsQfuZR+2VnBfeZXA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(66899024)(40460700003)(26005)(426003)(336012)(2616005)(1076003)(7049001)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(83380400001)(5660300002)(4326008)(44832011)(36860700001)(70586007)(316002)(70206006)(110136005)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 23:58:32.8196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06354c2-4059-4097-dc20-08dbfdc9be72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v8:
  - parse power-domains property from device-tree and use EEMI calls
    to power on/off TCM instead of using pm domains framework
  - Remove checking of pm_domain_id validation to power on/off tcm
  - Remove spurious change

Changes in v7:
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

 drivers/remoteproc/xlnx_r5_remoteproc.c | 154 +++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 4395edea9a64..36d73dcd93f0 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -74,8 +74,8 @@ struct mbox_info {
 };
 
 /*
- * Hardcoded TCM bank values. This will be removed once TCM bindings are
- * accepted for system-dt specifications and upstreamed in linux kernel
+ * Hardcoded TCM bank values. This will stay in driver to maintain backward
+ * compatibility with device-tree that does not have TCM information.
  */
 static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
 	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
@@ -878,6 +878,139 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
+{
+	struct of_phandle_args out_args;
+	int tcm_reg_per_r5, tcm_pd_idx;
+	struct zynqmp_r5_core *r5_core;
+	int i, j, tcm_bank_count, ret;
+	struct platform_device *cpdev;
+	struct mem_bank_data *tcm;
+	struct device_node *np;
+	struct resource *res;
+	u64 abs_addr, size;
+	struct device *dev;
+
+	for (i = 0; i < cluster->core_count; i++) {
+		r5_core = cluster->r5_cores[i];
+		dev = r5_core->dev;
+		np = of_node_get(dev_of_node(dev));
+		tcm_pd_idx = 1;
+
+		/* we have address cell 2 and size cell as 2 */
+		tcm_reg_per_r5 = of_property_count_elems_of_size(np, "reg",
+								 4 * sizeof(u32));
+		if (tcm_reg_per_r5 <= 0) {
+			dev_err(dev, "can't get reg property err %d\n", tcm_reg_per_r5);
+			return -EINVAL;
+		}
+
+		/*
+		 * In lockstep mode, r5 core 0 will use r5 core 1 TCM
+		 * power domains as well. so allocate twice of per core TCM
+		 */
+		if (cluster->mode == LOCKSTEP_MODE)
+			tcm_bank_count = tcm_reg_per_r5 * 2;
+		else
+			tcm_bank_count = tcm_reg_per_r5;
+
+		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
+						  sizeof(struct mem_bank_data *),
+						  GFP_KERNEL);
+		if (!r5_core->tcm_banks)
+			ret = -ENOMEM;
+
+		r5_core->tcm_bank_count = tcm_bank_count;
+		for (j = 0; j < tcm_bank_count; j++) {
+			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
+					   GFP_KERNEL);
+			if (!tcm)
+				return -ENOMEM;
+
+			r5_core->tcm_banks[j] = tcm;
+
+			/*
+			 * In lockstep mode, get second core's TCM power domains id
+			 * after first core TCM parsing is done as
+			 */
+			if (j == tcm_reg_per_r5) {
+				/* dec first core node */
+				of_node_put(np);
+
+				/* get second core node */
+				np = of_get_next_child(cluster->dev->of_node, np);
+
+				/*
+				 * reset index of power-domains property list
+				 * for second core
+				 */
+				tcm_pd_idx = 1;
+			}
+
+			/* get power-domains id of tcm */
+			ret = of_parse_phandle_with_args(np, "power-domains",
+							 "#power-domain-cells",
+							 tcm_pd_idx,
+							 &out_args);
+			if (ret) {
+				dev_err(r5_core->dev,
+					"failed to get tcm %d pm domain, ret %d\n",
+					j, ret);
+				of_node_put(out_args.np);
+				return ret;
+			}
+			tcm->pm_domain_id = out_args.args[0];
+			of_node_put(out_args.np);
+			tcm_pd_idx++;
+
+			/*
+			 * In lockstep mode, we only need second core's power domain
+			 * ids. Other information from second core isn't needed so
+			 * ignore it. This forms table as zynqmp_tcm_banks_lockstep
+			 */
+			if (j >= tcm_reg_per_r5)
+				continue;
+
+			/* get tcm address without translation */
+			ret = of_property_read_reg(np, j, &abs_addr, &size);
+			if (ret) {
+				of_node_put(np);
+				dev_err(dev, "failed to get reg property\n");
+				return ret;
+			}
+
+			/*
+			 * remote processor can address only 32 bits
+			 * so convert 64-bits into 32-bits. This will discard
+			 * any unwanted upper 32-bits.
+			 */
+			tcm->da = (u32)abs_addr;
+			tcm->size = (u32)size;
+
+			cpdev = to_platform_device(dev);
+			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
+			if (!res) {
+				of_node_put(np);
+				dev_err(dev, "failed to get tcm resource\n");
+				return -EINVAL;
+			}
+
+			tcm->addr = (u32)res->start;
+			tcm->bank_name = (char *)res->name;
+			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
+						      tcm->bank_name);
+			if (!res) {
+				dev_err(dev, "failed to request tcm resource\n");
+				of_node_put(np);
+				return -EINVAL;
+			}
+		}
+	}
+
+	of_node_put(np);
+	return 0;
+}
+
 /**
  * zynqmp_r5_get_tcm_node()
  * Ideally this function should parse tcm node and store information
@@ -956,10 +1089,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
-		return ret;
+	r5_core = cluster->r5_cores[0];
+	if (of_find_property(r5_core->np, "reg", NULL)) {
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+		if (ret) {
+			dev_err(dev, "can't get tcm node from dt, err %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = zynqmp_r5_get_tcm_node(cluster);
+		if (ret < 0) {
+			dev_err(dev, "can't get tcm node, err %d\n", ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < cluster->core_count; i++) {
-- 
2.25.1


