Return-Path: <linux-kernel+bounces-22823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5D82A361
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CEF289682
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD64F8BD;
	Wed, 10 Jan 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KGOZw2Bb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AD4F61D;
	Wed, 10 Jan 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za3sp3vrT46wRXN1Y5CMElGzl4ORfpHAbw2EddO0qdK9iDNJCECOGIIl9s15fBy4MPPj5mYLWGRZlaTpe0dnrNZMm85nEX3AkY1sBfvfaGc7Z5HPWxl8VQWccUngMvfObbHpEfaxqt1pd3RBE4OR8rDuJTq5rJHvsNJONdC+H5S2X9983DiHOMbsagMYyZLsP96cYn0kcsN8LEZFw1mr/wrD826YZU1az6K+3MrKn7yl9UJD0TNq2JITRV9L2XCRp18OTa8MXQGDKkQiYylTiZGqKiSFHjfeReYEPYNYTkPXehJ4b7IoiJBnOwSW8Bgy2nGelEnX8nCsOwIM0pgE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZQaSRit/J0TP03x89eWNxKGM84p+ZKkNl0p1mHvmCc=;
 b=K9LedBhSesXNoarkJDQRLoXv0Cj3GgzUizEda3Rl0XUFrwM5ND5hUozclH09DRgW3pt+WoHE9GNewClD74jXcK+9Xf6qWs0vB6E/I2iGLKJ7NCSR9n24ARKtd8qZH8p++OVaNep9hKe95hqBrA9S2XwqNu4vnwyxLd/sJZKeGCWH7LCixHdZlJF0XgGZi6SOEFsXiQbjooevLMi6r2SpH4vvxiyy6su1re7H+K5Ig3EbIwr17/Ev6RXgz85ALkCJv23odOR8WGK/f7+1PiKDTGEaM7/9dGmUKCFBuQ7/VWqa6mJpcgF61DPy0B9YL17zE5e4WwRRWui0cmFL8UPA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZQaSRit/J0TP03x89eWNxKGM84p+ZKkNl0p1mHvmCc=;
 b=KGOZw2BbHKJ2WFyd8SNV07QZMjM53JHAWvCP70nlgxOcBFyVRTh4kZWTl/ymqR8hBlWuWH26bLLJjyEZeZ3H7VG2vjHfaPrl424NPtOnAJR07FUOJY0oREw8iNk79yXk7GB2c5KfJ2BRt+wqjQNRu1py0PICnvgKwuBv7dqxZks=
Received: from MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49) by
 CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.25; Wed, 10 Jan 2024 21:36:01 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::49) by MW2PR16CA0036.outlook.office365.com
 (2603:10b6:907::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:36:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:35:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:35:59 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 15:35:58 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/3] remoteproc: zynqmp: parse TCM from device tree
Date: Wed, 10 Jan 2024 13:35:05 -0800
Message-ID: <20240110213504.3626468-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110213504.3626468-1-tanmay.shah@amd.com>
References: <20240110213504.3626468-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CO6PR12MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: bd500a40-826b-44f5-9945-08dc122423df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tcIf4eiruSVOPsUkVOffiTVYwMi1eyYcSQ+kyl8RWRjRFaktQ16IjsFrneMvbdcC6JD8qKh3c93GonimE82OyoHgFcySTDNWXbBVztf82lwJ5G68UIFDSD9WyAXLxHw1fM6T3kp0YzK2yN3cbcht7Yhpzhfq7T9LHVPCn7t3LDeaKKCXhq4txPcW0CZzwIEflUsKK5C8fA9TwsWnVBmbDzhgvzLMx8h7XNWGzHtbbxHlk2IPlTx/nMS04BwfOkChITHfitPj8DElUmwriGOTdAu0GTKC3ELQpT2Ej4MILjnT1xcaEHkOrTUSjBlSqa3ddMMJoEjWRTgCGaizyDHVekFRR0sRxB0wIJ7rohtD49z9fF5MCqJhSw2K1+8zQ0H2sfuBKFgDxBgH51vru6lKyj1sf3RKRKRek5HgQrz9C0cV035EF2by3p+GArxFiMqlkMhO6MJJlnpU6C1ICh4eQDfN53sjv+Wa7cxM+IBcr/yAZj0MjTDBuCxADBytUEVAS0BFik02S9G2HQN+uo/KfTIlO7NeDKSqHcBCT9PvmSPL9W0c5KafaNpw/jjNoJ+nk+zXiFuGRaD48yiU1tZGeh2JI3TsZOljHJs2c/9qyrHxfYpNjMOpvf07Xa5pEdQl0KnDDfMPgKlD6i31MnzVoz7Elb0wTiX4Oh8xMrGWCV50Ef0danHk5odG11xyyXYYqOAriKIiYYZZgCozAw1cCXWWyS171LjUg6PfP33YtwmUg3ylxyfLgmUD8LLdgD+8k2A7YynlWTvOorwi5jY1yA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(36860700001)(7049001)(5660300002)(6666004)(8676002)(86362001)(2616005)(70206006)(316002)(70586007)(41300700001)(110136005)(47076005)(54906003)(36756003)(8936002)(82740400003)(26005)(426003)(1076003)(336012)(83380400001)(81166007)(356005)(4326008)(44832011)(40480700001)(2906002)(66899024)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:36:00.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd500a40-826b-44f5-9945-08dc122423df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v9:
  - Introduce new API to request and release core1 TCM power-domains in
    lockstep mode. This will be used during prepare -> add_tcm_banks
    callback to enable TCM in lockstep mode.
  - Parse TCM from device-tree in lockstep mode and split mode in
    uniform way.
  - Fix TCM representation in device-tree in lockstep mode.

Changes in v8:
  - Remove pm_domains framework
  - Remove checking of pm_domain_id validation to power on/off tcm
  - Remove spurious change
  - parse power-domains property from device-tree and use EEMI calls
    to power on/off TCM instead of using pm domains framework

Changes in v7:
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

 drivers/remoteproc/xlnx_r5_remoteproc.c | 245 +++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 4395edea9a64..0f87b984850b 100644
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
@@ -102,6 +102,7 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
  * @ipi: pointer to mailbox information
+ * @lockstep_core1_np: second core's device_node to use in lockstep mode
  */
 struct zynqmp_r5_core {
 	struct device *dev;
@@ -111,6 +112,7 @@ struct zynqmp_r5_core {
 	struct rproc *rproc;
 	u32 pm_domain_id;
 	struct mbox_info *ipi;
+	struct device_node *lockstep_core1_np;
 };
 
 /**
@@ -539,6 +541,110 @@ static int tcm_mem_map(struct rproc *rproc,
 	return 0;
 }
 
+int request_core1_tcm_lockstep(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct of_phandle_args out_args = {0};
+	int ret, i, num_pd, pd_id, ret_err;
+	struct device_node *np;
+
+	np = r5_core->lockstep_core1_np;
+
+	/* Get number of power-domains */
+	num_pd = of_count_phandle_with_args(np, "power-domains",
+					    "#power-domain-cells");
+	if (num_pd <= 0)
+		return -EINVAL;
+
+	/* Get individual power-domain id and enable TCM */
+	for (i = 1; i < num_pd; i++) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells",
+						 i, &out_args);
+		if (ret) {
+			dev_warn(r5_core->dev,
+				 "failed to get tcm %d in power-domains list, ret %d\n",
+				 i, ret);
+			goto fail_request_core1_tcm;
+		}
+
+		pd_id = out_args.args[0];
+		of_node_put(out_args.np);
+
+		ret = zynqmp_pm_request_node(pd_id, ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret) {
+			dev_err(r5_core->dev, "failed to request TCM node 0x%x\n",
+				pd_id);
+			goto fail_request_core1_tcm;
+		}
+	}
+
+	return 0;
+
+fail_request_core1_tcm:
+
+	/* Cache actual error to return later */
+	ret_err = ret;
+
+	/* Release previously requested TCM in case of failure */
+	while (--i > 0) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells",
+						 i, &out_args);
+		if (ret)
+			return ret;
+		pd_id = out_args.args[0];
+		of_node_put(out_args.np);
+		zynqmp_pm_release_node(pd_id);
+	}
+
+	return ret_err;
+}
+
+void release_core1_tcm_lockstep(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct of_phandle_args out_args = {0};
+	struct zynqmp_r5_cluster *cluster;
+	int ret, i, num_pd, pd_id;
+	struct device_node *np;
+
+	/* Get R5 core1 node */
+	cluster = dev_get_drvdata(r5_core->dev->parent);
+
+	if (cluster->mode != LOCKSTEP_MODE)
+		return;
+
+	np = r5_core->lockstep_core1_np;
+
+	/* Get number of power-domains */
+	num_pd = of_count_phandle_with_args(np, "power-domains",
+					    "#power-domain-cells");
+	if (num_pd <= 0)
+		return;
+
+	/* Get individual power-domain id and turn off each TCM */
+	for (i = 1; i < num_pd; i++) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells",
+						 i, &out_args);
+		if (ret) {
+			dev_warn(r5_core->dev,
+				 "failed to get pd of core1 tcm %d in list, ret %d\n",
+				 i, ret);
+			continue;
+		}
+
+		pd_id = out_args.args[0];
+		of_node_put(out_args.np);
+
+		if (zynqmp_pm_release_node(pd_id))
+			dev_warn(r5_core->dev,
+				 "failed to release core1 tcm pd 0x%x\n", pd_id);
+	}
+}
+
 /*
  * add_tcm_carveout_split_mode()
  * @rproc: single R5 core's corresponding rproc instance
@@ -633,6 +739,21 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	r5_core = rproc->priv;
 	dev = r5_core->dev;
 
+	/*
+	 * In lockstep mode, R5 core0 uses TCM of R5 core1 via aliased addresses.
+	 * Aliased addresses are contiguous with core0 TCM and embedded in "reg"
+	 * property. However, R5 core1 TCM power-domains needs to be requested
+	 * from firmware to use R5 core1 TCM. Request core1 TCM power-domains
+	 * if TCM is parsed from device-tree.
+	 */
+	if (of_find_property(r5_core->np, "reg", NULL)) {
+		ret = request_core1_tcm_lockstep(rproc);
+		if (ret) {
+			dev_err(r5_core->dev, "failed to request core1 TCM power-domains\n");
+			return ret;
+		}
+	}
+
 	/* Go through zynqmp banks for r5 node */
 	num_banks = r5_core->tcm_bank_count;
 
@@ -689,6 +810,9 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 		zynqmp_pm_release_node(pm_domain_id);
 	}
+
+	release_core1_tcm_lockstep(rproc);
+
 	return ret;
 }
 
@@ -808,6 +932,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 				 "can't turn off TCM bank 0x%x", pm_domain_id);
 	}
 
+	release_core1_tcm_lockstep(rproc);
+
 	return 0;
 }
 
@@ -878,6 +1004,95 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
+{
+	int i, j, tcm_bank_count, ret, tcm_pd_idx;
+	struct of_phandle_args out_args = {0};
+	struct zynqmp_r5_core *r5_core;
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
+		np = r5_core->np;
+
+		/* we have address cell 2 and size cell as 2 */
+		tcm_bank_count = of_property_count_elems_of_size(np, "reg",
+								 4 * sizeof(u32));
+		if (tcm_bank_count <= 0) {
+			dev_err(dev, "can't get reg property err %d\n", tcm_bank_count);
+			return -EINVAL;
+		}
+
+		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
+						  sizeof(struct mem_bank_data *),
+						  GFP_KERNEL);
+		if (!r5_core->tcm_banks)
+			ret = -ENOMEM;
+
+		r5_core->tcm_bank_count = tcm_bank_count;
+		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
+			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
+					   GFP_KERNEL);
+			if (!tcm)
+				return -ENOMEM;
+
+			r5_core->tcm_banks[j] = tcm;
+
+			/* Get power-domains id of TCM. */
+			ret = of_parse_phandle_with_args(np, "power-domains",
+							 "#power-domain-cells",
+							 tcm_pd_idx, &out_args);
+			if (ret) {
+				dev_err(r5_core->dev,
+					"failed to get tcm %d pm domain, ret %d\n",
+					tcm_pd_idx, ret);
+				return ret;
+			}
+			tcm->pm_domain_id = out_args.args[0];
+			of_node_put(out_args.np);
+
+			/* Get TCM address without translation. */
+			ret = of_property_read_reg(np, j, &abs_addr, &size);
+			if (ret) {
+				dev_err(dev, "failed to get reg property\n");
+				return ret;
+			}
+
+			/*
+			 * Remote processor can address only 32 bits
+			 * so convert 64-bits into 32-bits. This will discard
+			 * any unwanted upper 32-bits.
+			 */
+			tcm->da = (u32)abs_addr;
+			tcm->size = (u32)size;
+
+			cpdev = to_platform_device(dev);
+			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
+			if (!res) {
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
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * zynqmp_r5_get_tcm_node()
  * Ideally this function should parse tcm node and store information
@@ -956,9 +1171,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
+	r5_core = cluster->r5_cores[0];
+	if (of_find_property(r5_core->np, "reg", NULL))
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+	else
+		ret = zynqmp_r5_get_tcm_node(cluster);
+
+	if (ret) {
+		dev_err(dev, "can't get tcm, err %d\n", ret);
 		return ret;
 	}
 
@@ -1099,7 +1319,19 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 		 * then ignore second child node.
 		 */
 		if (cluster_mode == LOCKSTEP_MODE) {
-			of_node_put(child);
+			/*
+			 * Get second core's device node only to use its power-domains.
+			 * Also, no need to use of_node_put on first core's device_node
+			 * as it is taken care by of_get_next_available_child.
+			 */
+			r5_cores[i]->lockstep_core1_np =
+				of_get_next_available_child(dev_node, child);
+
+			if (!r5_cores[i]->lockstep_core1_np) {
+				ret = -EINVAL;
+				goto release_r5_cores;
+			}
+
 			break;
 		}
 
@@ -1158,6 +1390,7 @@ static void zynqmp_r5_cluster_exit(void *data)
 		r5_core = cluster->r5_cores[i];
 		zynqmp_r5_free_mbox(r5_core->ipi);
 		of_reserved_mem_device_release(r5_core->dev);
+		of_node_put(r5_core->lockstep_core1_np);
 		put_device(r5_core->dev);
 		rproc_del(r5_core->rproc);
 		rproc_free(r5_core->rproc);
-- 
2.25.1


