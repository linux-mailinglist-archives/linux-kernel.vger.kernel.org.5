Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA767B81C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjJDOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJDOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:06:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074BDAB;
        Wed,  4 Oct 2023 07:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iij+TWygSMOwW76kwAOC0bQGRIQTieFxQdx+Kdc6PsLXBc/UNhK0E6hRvv6n5L3Ta1Mek6VIsL7gq9Mm0uk6q3wav9S17lV4t3EYJD3f5JDdeM0kNHw/wHokA/UcKBuM2fQ5mjDrbI+FCrk1u7xYBfNd39WizwTr+Vfua6OE7TagSCga9VdytkdHwNSJb9Oo+VAv/Vn0EaLe3OMqoZqZAzNOacuT4WZkX0FLcyMW0KHw2OOSa+ZBRrlWaPUmFGzAufRGnrlzA39f9D57HINT/+sYNteBPxireE0NEIhYdJOunQrw6EqVlAe/ojH+RLzU13CgNiBv3KXL35drvRxYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pky6nMg0VDXVUZ4ilIxjkrdr7ovwOi5yeVaTId+Cx5g=;
 b=XxcuyskrBpfKR4qHtFnIZEjria/3GFzF31sWD3lofv3jW8B99CwHE9N2FUkhcRq5dONY9sOi22gOz0tgIRX8Jn0EInb+Vz3720CzFHQNEBHDYJflEuz+At0UHeaHcDPeBIa6HFyKINzS+hqBnn+AxhgqTnFnonhnSHeOZAmyNciDbgjVPTx4YsJoi07El4mT2Ru8J9Dff/oRw6X7YDV7SKni1kl+gSloxqPs+ElQhMJ8qek0a9UhZ3FYK+rFjMrOZOqN1fQtbarIMNsuv7UBiDx/MG2pqb+dgmpplvDOuq+QTOAggNgR9MXZdkdSiVVt94iOlPCmRxWgHjB3i2AK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pky6nMg0VDXVUZ4ilIxjkrdr7ovwOi5yeVaTId+Cx5g=;
 b=It7wWF7VSLYnwhd+YpD14W+pEMAmUpWOdU2cnzZLUH4Xi4wKh05tNdW2XIpYKS4pZVGtbmV6N21M4epuAOdYDXEPU17RG8J65lEVLOBjmAlfm6rjaGbePBf/wVbiALGHIKzwTg8YdshT9yXV795iRE5CrGOAve2UmZHpnJdCQpOFTt6MZPuD3PILb4GTfB848JrGXsK8FHUYvN9ZX+jqFnEN96wfkSXouc8Xchv4KdZZB1qNxNdzxJ+Duq7RniOFGq0xbpXHdLKlWR/vY9IMqM8RfSkuWS/xRJ0uTiucwmEHjDoH+vmsnxpTPlwpsxZ+RaRd/tHIrGPRNuPgNuu4WA==
Received: from CH0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:610:11a::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 14:06:11 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::e8) by CH0PR03CA0354.outlook.office365.com
 (2603:10b6:610:11a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 14:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:06:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:52 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 4 Oct 2023 07:05:49 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v3 1/2] cpufreq: tegra194: save CPU data to avoid repeated SMP calls
Date:   Wed, 4 Oct 2023 19:35:36 +0530
Message-ID: <20231004140537.1954-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004140537.1954-1-sumitg@nvidia.com>
References: <20231004140537.1954-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5286dea1-47fe-4abd-68c9-08dbc4e30f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsb9OkfaA0ig8naCsV+U3YxoW6AxlcjpToBJN/3hZEupJ0qtO9vW3RUfeFgUd3pucOVBFyAvVx662CzjvaKq8C9fjzKx48HvISzSoDCYlZtXsPyCS9oCJAJGfVv83INmNTXg8Lgf9HHzaTtTq4I9PImq3dbRfZ4eKSEAj1hRjHzrjxaSW/xdtkeI3VM3R9cQE5ZIDY5uMdhMYE/olXX1nEBT5m6Tka4jx7Rv+ah1U2FStoJobpl33ss4zs1Nq+roTS+UWl+fxZYZfaoQMCQkp2baZcEwynMEwHa89mD/NR1ysef5JUiXla/l7tC3OQJIKyaGQKV9oIfkmTrfN1IM/tm60q1HSrtNFNU/Ke3Iz7vtlv/Xhnx6INmlt/OTJU+nd02CAM/pHpsR2JHUQ1vDoVrBSvDkAbItyhzd1MC0sWMs/YZlbD6LnZtZEP8ybThy1ocwGhe8lVOd5kvho6R6Qq3wefY7dCm2TqQLDCWSrIwvVcTR45qBPRPDtBEIcpJ555CIJkUrnWl6KHhWLJ48OJuHf6KUi5QVruGZMVQKb6/0gGkd31zcWxCC8uEB+EKlEvfCK7NGun0Dyq3PnCwVmoeKdMV61BFXfaEBOmpk3VEjmfFg/wmPrlpskm6Z6P/Lv8rVtXfrrcYDQSmTBq3940/KMCeJEfZfEATbdQVMZxz6L9FJx7Z+YnQ1XGtE1UCq/Alxq4cMpPs9UFfsCHxgc2Uk0hAEomG56gtoHo4J5zjrfkpeQvBEz4jkuEhpF4Uu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(336012)(1076003)(2616005)(426003)(26005)(40460700003)(82740400003)(86362001)(36756003)(356005)(7636003)(70586007)(107886003)(83380400001)(2906002)(478600001)(36860700001)(6666004)(47076005)(7696005)(5660300002)(54906003)(316002)(4326008)(41300700001)(8936002)(8676002)(70206006)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:06:09.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5286dea1-47fe-4abd-68c9-08dbc4e30f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we make SMP call on every frequency set request to get the
physical 'CPU ID' and 'CLUSTER ID' for the target CPU. This change
optimizes the repeated calls by storing the physical IDs and the per
core frequency register offset for all CPUs during boot. Later this
info is used directly when required to set the frequency or read it
from ACTMON counters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 79 +++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 386aed3637b4..f6a8e6cf6d94 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -39,6 +39,12 @@
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
+struct tegra_cpu_data {
+	u32 cpuid;
+	u32 clusterid;
+	void __iomem *freq_core_reg;
+};
+
 struct tegra_cpu_ctr {
 	u32 cpu;
 	u32 coreclk_cnt, last_coreclk_cnt;
@@ -69,6 +75,7 @@ struct tegra194_cpufreq_data {
 	struct cpufreq_frequency_table **bpmp_luts;
 	const struct tegra_cpufreq_soc *soc;
 	bool icc_dram_bw_scaling;
+	struct tegra_cpu_data *cpu_data;
 };
 
 static struct workqueue_struct *read_counters_wq;
@@ -116,14 +123,8 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	void __iomem *freq_core_reg;
-	u64 mpidr_id;
-
-	/* use physical id to get address of per core frequency register */
-	mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
-	freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
 
-	*ndiv = readl(freq_core_reg) & NDIV_MASK;
+	*ndiv = readl(data->cpu_data[cpu].freq_core_reg) & NDIV_MASK;
 
 	return 0;
 }
@@ -131,19 +132,10 @@ static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	void __iomem *freq_core_reg;
-	u32 cpu, cpuid, clusterid;
-	u64 mpidr_id;
-
-	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
-		data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
-
-		/* use physical id to get address of per core frequency register */
-		mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
-		freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
+	u32 cpu;
 
-		writel(ndiv, freq_core_reg);
-	}
+	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask)
+		writel(ndiv, data->cpu_data[cpu].freq_core_reg);
 }
 
 /*
@@ -157,11 +149,10 @@ static void tegra234_read_counters(struct tegra_cpu_ctr *c)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	void __iomem *actmon_reg;
-	u32 cpuid, clusterid;
 	u64 val;
 
-	data->soc->ops->get_cpu_cluster_id(c->cpu, &cpuid, &clusterid);
-	actmon_reg = CORE_ACTMON_CNTR_REG(data, clusterid, cpuid);
+	actmon_reg = CORE_ACTMON_CNTR_REG(data, data->cpu_data[c->cpu].clusterid,
+					  data->cpu_data[c->cpu].cpuid);
 
 	val = readq(actmon_reg);
 	c->last_refclk_cnt = upper_32_bits(val);
@@ -357,19 +348,17 @@ static void tegra194_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
 static unsigned int tegra194_get_speed(u32 cpu)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	u32 clusterid = data->cpu_data[cpu].clusterid;
 	struct cpufreq_frequency_table *pos;
-	u32 cpuid, clusterid;
 	unsigned int rate;
 	u64 ndiv;
 	int ret;
 
-	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
-
 	/* reconstruct actual cpu freq using counters */
 	rate = tegra194_calculate_speed(cpu);
 
 	/* get last written ndiv value */
-	ret = data->soc->ops->get_cpu_ndiv(cpu, cpuid, clusterid, &ndiv);
+	ret = data->soc->ops->get_cpu_ndiv(cpu, data->cpu_data[cpu].cpuid, clusterid, &ndiv);
 	if (WARN_ON_ONCE(ret))
 		return rate;
 
@@ -475,13 +464,12 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	int maxcpus_per_cluster = data->soc->maxcpus_per_cluster;
+	u32 clusterid = data->cpu_data[policy->cpu].clusterid;
 	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_frequency_table *bpmp_lut;
 	u32 start_cpu, cpu;
-	u32 clusterid;
 	int ret;
 
-	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
 	if (clusterid >= data->soc->num_clusters || !data->bpmp_luts[clusterid])
 		return -EINVAL;
 
@@ -659,6 +647,28 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
 	return freq_table;
 }
 
+static int tegra194_cpufreq_store_physids(unsigned int cpu, struct tegra194_cpufreq_data *data)
+{
+	int num_cpus = data->soc->maxcpus_per_cluster * data->soc->num_clusters;
+	u32 cpuid, clusterid;
+	u64 mpidr_id;
+
+	if (cpu > (num_cpus - 1)) {
+		pr_err("cpufreq: wrong num of cpus or clusters in soc data\n");
+		return -EINVAL;
+	}
+
+	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
+
+	mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
+
+	data->cpu_data[cpu].cpuid = cpuid;
+	data->cpu_data[cpu].clusterid = clusterid;
+	data->cpu_data[cpu].freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
+
+	return 0;
+}
+
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
 	const struct tegra_cpufreq_soc *soc;
@@ -666,6 +676,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	struct tegra_bpmp *bpmp;
 	struct device *cpu_dev;
 	int err, i;
+	u32 cpu;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -692,6 +703,12 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 			return PTR_ERR(data->regs);
 	}
 
+	data->cpu_data = devm_kcalloc(&pdev->dev, data->soc->num_clusters *
+				      data->soc->maxcpus_per_cluster,
+				      sizeof(*data->cpu_data), GFP_KERNEL);
+	if (!data->cpu_data)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, data);
 
 	bpmp = tegra_bpmp_get(&pdev->dev);
@@ -713,6 +730,12 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		err = tegra194_cpufreq_store_physids(cpu, data);
+		if (err)
+			goto err_free_res;
+	}
+
 	tegra194_cpufreq_driver.driver_data = data;
 
 	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
-- 
2.17.1

