Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580E77900DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbjIAQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348028AbjIAQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:42:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAACB1722;
        Fri,  1 Sep 2023 09:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abTDcvFFk3mHAJUcRUAyuoJw9mKGTe73WJgYEgJtJnNFjlubgWmWc9tf+dWQ0p4J02MXTqRIEThO+cnmEMJyj14Wj4X+uG11ZdleyADmz4B55BDQoCDabpmq97gQ0IKaYNFpfQ6RRZeBLCgd96hTO2fVnJt7hciaSmHTkg3+3wIGChYIizglKOp/tUEk0OnpHxKd9dvQI4IktMz+FyS6fqiITSTAllEkJKEljSAu1rnH90ivRtSIYNbdM2qzdysQfSeZfet9ZNwG5sJrJ07XfORYV6CrkI8oimQbFNY5nw5vHiKXpAjVKbAsQPUIM1/d3AktvKHZZ+dwEi4rJsVjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIE/QiD/Y3t9g39o+y+qgmXG7yX4XpAu4qS8K1NrhoI=;
 b=jGCs/a8/mbRHSa8Ru7ff0BCNn5vLhrSwg9FpgnQ8DkE3Jj2OXOI3mZF6UF+yge9YawC0ucuRnUIHXOClnlWUaO1oM7dGiHjCoyG8OiGrbXCHqhgjXgN2NwYY/xI7UcMyg+v4Vb5MMcIz6JX7ONSsPiG0yKZgZ49ZxONXEmWNIuW1f9gOK09Py/T4sCnm32EmJld7i6wUV8yXfl7xWEYlpuvxF8z9Bnd6DH12zYr+cRrJezCZk98pRlubL3yrLHnP+a/7z2CVlpLNtimkJF5JqkRvfRxEXfvuxfZ5aM7RhGL+aXijCnHwRdwBxUy2Xbab2DBUjiRzMew6UWr//KooCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIE/QiD/Y3t9g39o+y+qgmXG7yX4XpAu4qS8K1NrhoI=;
 b=egOzEDsH/yu+AFqPpLnHJRxpPNvbZasj9zT01XDAXQbQuHjr+CNF670Xwx8dRyRCmUn2Kx44D+/mpGlYXG/gkZNsYiUaSi2iCWrIKYWexUN+hmuw5tiZDzCv0qPgTKimGHJiO6Ov53k57FpT0ZsEfV4RJubrEvMWWPX9FUlDgn4QJZW+ZCJ2HfZnHs9cJetS74hKMKtXfvyRwBa6qMLAVFR58GBLvSE1DdZGXBXOsBx2kqsaG+msgOsShwhL8DDKb7lKEDlUNGAaZlqeprZPJqXsB8CfAX0ykAETWdVa4TY1fz6ZEf/blJg0G7fRdVBr0t0IrM35F5iMfqWn6nVcWw==
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Fri, 1 Sep 2023 16:41:46 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::9f) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26 via Frontend
 Transport; Fri, 1 Sep 2023 16:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 16:41:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 09:41:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 1 Sep 2023 09:41:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 09:41:30 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid repeated SMP calls
Date:   Fri, 1 Sep 2023 22:11:12 +0530
Message-ID: <20230901164113.29139-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901164113.29139-1-sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ef6b7a-d7a2-4721-71bc-08dbab0a54c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3e+eqvGU/4V7juBzjs2tO8F1vb3zSrX36Ekn7CWIT9SBcREgF0P82ozHVextnjHnBsm2wC5qkopKmpKn8Y0FQHrLYTFCrW8L9/TWWkLKLZ6WEWkv7TjlKEvELLAVLswvLxZ8uLBP25YedmhlK9fwJxOGINtiPLXo9zeuSncgXtHWpamMT0M9FqIwU4xyxRSTLAX1diZWqUho/OlWZzqriX3TpJw/Rv1ajGJo7S/mTR+wI6shYEz6rAWtpeQLEs+cBnwskl7n0DHZgTXmjpR+yF+RhqVDEGe4ylvr4FSm/l8Xk62ur4LntQ1gVqDTkhxF+HM7ZDHlQeht4sUX2V2N0WbcNFt/WZamuPeMPASOKAwb7BToeOQz7tOaDIUZzh3RYNhOPd2Y0s3ioA+4P5i/2+iMWkd77mlcjSitB+6ATASKZU9VLhVDi0dAzV/2ZAXQO6RIMuVrFCJkpLnbSSd0NF9Sh6K/AYQg1iwAsmLZtRwHCrlaz/h3SU7sDXtjUSxVxhXGktQhaq0CVjF8AOCk7nIw6Vels1LY9zkSjLprKEo6Xoedl9+Nf19HT0KOBQj4kzzkcwoekAXzH9LbxSdTStyFY4mGSMMuQQZh7Ii8bigaMtlPyABcQB9eh50e5Qm9kChQAQhUiKhDZ7mfvr6rPmMuS9OeJWvOEIGd+x9oEhxbINlaBypLE/MIUbmtjwrbyMeY2jPYIJdMvWuaXdqTnKm03imuj1jZXKFePaLCu7/g53Un5LHxe/vKbZCPq3v
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(7696005)(6666004)(83380400001)(110136005)(41300700001)(478600001)(1076003)(54906003)(26005)(336012)(8676002)(70206006)(2616005)(316002)(70586007)(5660300002)(36756003)(40460700003)(40480700001)(47076005)(7636003)(356005)(36860700001)(107886003)(2906002)(86362001)(426003)(8936002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:41:46.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ef6b7a-d7a2-4721-71bc-08dbab0a54c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 386aed3637b4..0d0893cf7f18 100644
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
+				      sizeof(struct tegra_cpu_data), GFP_KERNEL);
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

