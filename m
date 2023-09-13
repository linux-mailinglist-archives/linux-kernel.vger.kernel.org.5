Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9779EF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjIMQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjIMQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7AF359D;
        Wed, 13 Sep 2023 09:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqw5Ue7C7uSeYW0xJYq/rqwUXY8PYnVTjqVlx7RfFzi4RxvQYclP1k1SAgfgVMgg8jgkdjhCDb5uZCCRW/GGHrXvFuNVockoJbOUyxf4jusbOOSgwuoeiV4k1jSo8xYMpxBIxx+RqZFUXHH3pXN7BG1nACDHJFwXYLFI/JaBynStccykX12qROSjwIy1zkbEMK++XF1DmmmOCDsrwYxzP5/NXzWROEd2iqZDWUDOPABJ/2KBX3clSn+//vrB4qZsdUP+0TT2V3u+Hv7Pf+RYjAo28oE7PkAS0NjrlId9h9yH3hVzZBPckXpmNpIohZ0cYx7N3+8wER/KNYPejOhcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwzzw8138+YZ3/lmiNY9SOdnltHoR4qUADwwJh2D/Qg=;
 b=SDF78mzj+zBVoN8WWIlpCM25g9kO/O9K43y4APD4gXx6ZRfGaL/2gYwNt4kLl7P/udXvu61fHIvwyoYtNrCdxU7FD1h+KUXgiB1FK1ubhOcgECp+7sIxIYmDtHJrNu37+KzTEbzTpDjdAlCtVUEOwr2B5jTLZoxzlRvRTOpnZsSMOz4gXEKmt4+KYZrKhovDztU4t87/7lRr2fNdtxMhkC5WLp8IJsb65FH/hTvNa2o8EequCBfUA8od1hbG9grHbhkjn2EfTxgjSb9lYsbIiItJh/xE45NFuGkykT0tcDFTfVzQnki4/b5pnNoJFOSSHdotZabd4R8/iHvbjtvjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwzzw8138+YZ3/lmiNY9SOdnltHoR4qUADwwJh2D/Qg=;
 b=M9opHYfTO7FGalLZFSiN2Po/h0LBqnBuYysO5vLRmfYNidxG7jWzr/NcxYSjRr/7Rquiu+sb6kbFTpEybJZLDIkYW2yc/aybd5zvPhkHNpwChdAHquuxHPbrC9utkTnWYYfGVSSxKccez+Il0oFAhic+ccAB1y/8mjZMf6PJZSt2bls45DoiH6dX+wMKGgARvh6JRr59rUK1PUhoZykYSPeGmDGq3LnQWiXiYPvwDBw91iAt9KLF5y8tp15yb52IdPVGgRgb9E2u/A2Cj531BxMJQi5ukSTdS6aoXJY+rmvgG6eNhfREEnL8OGT5G7ISMUH4Uno0WcvF2cLh0ZzInQ==
Received: from BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Wed, 13 Sep 2023 16:47:36 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::5) by BL1PR13CA0169.outlook.office365.com
 (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 16:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 16:47:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 13 Sep 2023
 09:47:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:47:24 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Sep 2023 09:47:20 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date:   Wed, 13 Sep 2023 22:16:59 +0530
Message-ID: <20230913164659.9345-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913164659.9345-1-sumitg@nvidia.com>
References: <20230913164659.9345-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af7ba26-6a74-4522-d959-08dbb4792230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVjwhxMc48mYqxMqUlmxx49NW/ivPnab5yh9M4ZZbtCjLg48FjY0t9Aey00MgJFGnS7FWbxukhrUbSvSgb/tPE5Hq2z0HqdP0MSYKxdnaJUtQKkmBjT7dBaSwnFU9dH2zRNNFosaEY/SxFV+24NxjcY/hGWuFgGu4lgDbuDpoRBUQIbecSTy3cpHBB512tf2JWkxpVZoJiu/bqe6OrvwWZsLkJEgisXcT7l9BvOgwJOL2pd4ZT2TpzrTZdOGMzeAxMYC/3xmmd3q1XJwapW1N/PGOiV12BMuuLoNS8s7wq9OvuSN03XsE6VNin3gx36A56pB6d/MZB0JIRyD6aCUH7SYmw2uFwhDMiTzaSSHEipuDzn5LBmfO8AaZlFhvhItLInIGWF+jK7H3/5gVrUSznfiZTvEnxukWd1JBtPThmNMwQyQTa43EJpOqavNZBW3a8lws/L2aPEpllo+XUM2gvZm2V/XriiNL5XQupb1S5QqsB5xCWcMHTyndI4gtUjeOdYyy5HEgWw9asVstS2QLqs/XdB/T3JTpnZrxvPpuah9Rn3AAygnRAOCGmk94hfoXfpIel/o2YBUaYQFTBBShpGoa4Qgiq/yP7jmh7Qy4dLP4ZSRuIxyLZCE3XBVa1rnOgRjRvNlzGDYX95d0bYwBH/ZrTnEugvPGl3L6arVrbxHC+RO2/86nXUpC3tY3U0tnXKHyi8/TVvETAlS8Cd/p9FMhsbiI/BBHGSRDSL/iAl7+F8h5KrlYapf8paxpQzx/ajb+smdflHUUrtU6Vq72w==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(316002)(41300700001)(26005)(1076003)(426003)(40480700001)(107886003)(336012)(4326008)(2906002)(70586007)(8676002)(54906003)(70206006)(8936002)(478600001)(5660300002)(110136005)(6666004)(40460700003)(7696005)(36756003)(36860700001)(2616005)(83380400001)(47076005)(86362001)(7636003)(82740400003)(356005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:47:35.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af7ba26-6a74-4522-d959-08dbb4792230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Srimath Tirumala <srikars@nvidia.com>

Current implementation of processor_thermal performs software throttling
in fixed steps of "20%" which can be too coarse for some platforms.
We observed some performance gain after reducing the throttle percentage.
Change the CPUFREQ thermal reduction percentage and maximum thermal steps
to be configurable. Also, update the default values of both for Nvidia
Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
and accordingly the maximum number of thermal steps are increased as they
are derived from the reduction percentage.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/processor_thermal.c | 41 +++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b7c6287eccca..30f2801abce6 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -26,7 +26,16 @@
  */
 
 #define CPUFREQ_THERMAL_MIN_STEP 0
-#define CPUFREQ_THERMAL_MAX_STEP 3
+
+static int cpufreq_thermal_max_step = 3;
+
+/*
+ * Minimum throttle percentage for processor_thermal cooling device.
+ * The processor_thermal driver uses it to calculate the percentage amount by
+ * which cpu frequency must be reduced for each cooling state. This is also used
+ * to calculate the maximum number of throttling steps or cooling states.
+ */
+static int cpufreq_thermal_pctg = 20;
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
 
@@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	return CPUFREQ_THERMAL_MAX_STEP;
+	return cpufreq_thermal_max_step;
 }
 
 static int cpufreq_get_cur_state(unsigned int cpu)
@@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 		if (!policy)
 			return -EINVAL;
 
-		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+		max_freq = (policy->cpuinfo.max_freq *
+			    (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
 
 		cpufreq_cpu_put(policy);
 
@@ -126,10 +136,35 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	return 0;
 }
 
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+void acpi_thermal_cpufreq_config_nvidia(void)
+{
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+	s32 soc_id = arm_smccc_get_soc_id_version();
+
+	/* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
+	if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
+		return;
+
+	/* Reduce the CPUFREQ Thermal reduction percentage to 5% */
+	cpufreq_thermal_pctg = 5;
+
+	/*
+	 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
+	 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
+	 * the CPU performance doesn't become 0.
+	 */
+	cpufreq_thermal_max_step = ((100 / cpufreq_thermal_pctg) - 1);
+#endif
+}
+
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
 
+	acpi_thermal_cpufreq_config_nvidia();
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
-- 
2.17.1

