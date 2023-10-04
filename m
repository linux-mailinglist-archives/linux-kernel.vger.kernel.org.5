Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65087B81C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbjJDOGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJDOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:06:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03778A1;
        Wed,  4 Oct 2023 07:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1sDvb5M9b3IxSqG16T4dzoaRm+Os4k0ky5wenzpy6v+0vmGZXBrffXxsLpFNPU6mNS9EyoAJJ8ACC5R/68AL4Dj9UmyO3UNCY68IXatS4OzLtFtxLf65XBR/eMbcY0SfPc3wZIrKblpUBrHftLOkgUj4RHJJemnKryreK9iU8DmgAjnWtgozowY/j17PpjtAlPn2203Iy7DOf8E0torYZKKFK83WCBvaFP+Cqb/kdp2JmwnLzSOoP0uOh9vzG+De3xt5OFeQFsZdb5FRPTynSCk1dUPAnLX3earDQloaKxnKaI0L8AKtRXQOr7KBpiifSutLkTpWjiEFekBlPQbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlWA6IqwFgnqYSOaNZVXjc157Wbs69fD+N0aGyKM7Qo=;
 b=ZuXdMoOM7nnFQ84uLe4c+hWHsIZDRLSt8ozrLjWmNWTKtE0or/fPYw38exHXRt/LLdCxyXMjn12/gUwqpSXPmb8IGYj9QehvgHzqyCSfG6izHC3/fCM+nRQnhhm8BRVcBQHB3Euswk5Thd5FBYAuYP3svJRE2Bb0sLjr8YQlQuxLCfhxpfHehDaJIVmEuiL79nal6BygzYV/GSNJHXbvAXQvxrWQNGvOwC+KDcpz69+lKkjo+FEpYbMTOLA1BC33csyFkf3gBkuCX+1emOsMsLnlIyYj6l1MXyO2L1aPOx6nes2C+tt11bTVKkgoJdLmEz9WBxRnWfmHydEvsGtxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlWA6IqwFgnqYSOaNZVXjc157Wbs69fD+N0aGyKM7Qo=;
 b=A3VWr+DWfwyk8S5PjPl8CX3qWNjfQ8GqMwruYawrifb0BlM1fO0wIzmlnoNfHZUzqhsYqKwUAbSEeStYlQV1vbGMorUtDfnPS5Wm/lOe+Kanyr7KwuK7ESUXnNufLVKPaQVhv7tueILy3+qUHf8IegRg4tFXkax1JPDYVElfZVTC3zsRZuaQYeLborJYm3UzSPWyXGsVbW/sMN8Nd3dFpFUCO4gnX5zaGpZeTnuURxPdhe5TVawqrwv0mlencbmz1bBTljd4rom+TTKGVvyd4MGah/xJfeIju8hfy/eK0j4TbslgGDwIiYYOasifQoU4tWI/bhx/BnuGj/2LQ4djSw==
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 14:06:08 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::9c) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Wed, 4 Oct 2023 14:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.20 via Frontend Transport; Wed, 4 Oct 2023 14:06:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:57 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 4 Oct 2023 07:05:54 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v3 2/2] cpufreq: tegra194: use refclk delta based loop instead of udelay
Date:   Wed, 4 Oct 2023 19:35:37 +0530
Message-ID: <20231004140537.1954-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004140537.1954-1-sumitg@nvidia.com>
References: <20231004140537.1954-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: c91a4ded-7031-4a20-956b-08dbc4e30e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6k6sv75ZWXVDyNAxEZ6pJjZk97QKHWRnpRg1zDKJSzP45UnV9uo80SHcyVM8WRlSxwP7lmcMgqxyS+ELcsH+Lh3jYitC4kJr2rlKD166I7sjlyDsgIRG5m1GDUWw3lkLMtxSzrY61xp8uXUXTjju68BcuUZQ+fVk5YFzZc62/gpfV+CnKNY/TPhOd4Hu7iopPX9gEmVNUjwMeTBiCm+koPj0MQhFEIDXBznUUGYAaRfYgfYwwAuGgYHptELSUS/bpr2AGhdXeuBK0XAMtQ8vU3NuGCSJoCecTfi7ddaZ0bFtO7oMq8PRpCFe02ILrljvfTjarGqMGEjBhwDGICJEc5nXNw8A4A24B9V5OXgpVx5s6rWa3bdhKE0FYuX0d2M0r9FhgpYqYYIc12BGLJmvBO6Vv2RKUgbx2COyfCgcffsPrK/xSibgrMryWsruPz13XWCBmJ1Gbo4ojC7T2QErSQ3E7ZhZ3lxLZwLwyN/VHoxyqiofwH8xnxB+P7X7CVMDOqg3KGiBjJ0SqwPQ0Y7Fqn/vqUHlESBIbIEuLYbILKDkbQiDvCfL19TfRH7nOtcA/Ux0Ij0ZGAocglo+acxjEJ7LL23EehWxxs2U9ZLCmkj5VQXKno+pTt3vx1L11WfZj34aof4hWr+Tewk5HnzGSqOQcqOgLZzNoSHaIFjKv4bbgpKL0lFolWyg7TYXK4gsVhvS3PtIzHp/kxyc2WhaUyqcE28rpwyYNVQKS259S8RqlNRyuLCRlw1n5uzsqvb
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(426003)(40460700003)(336012)(1076003)(26005)(107886003)(2616005)(82740400003)(7636003)(36860700001)(356005)(86362001)(83380400001)(36756003)(47076005)(316002)(40480700001)(54906003)(478600001)(4326008)(70586007)(5660300002)(8936002)(8676002)(70206006)(7696005)(110136005)(6666004)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:06:07.8352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91a4ded-7031-4a20-956b-08dbc4e30e4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reference clock count based loop instead of "udelay()" for
sampling of counters to improve the accuracy of re-generated CPU
frequency. "udelay()" internally calls "WFE" which stops the
counters and results in bigger delta between the last set freq
and the re-generated value from counters. The counter sampling
window used in loop is the minimum number of reference clock
cycles which is known to give a stable value of CPU frequency.
The change also helps to reduce the sampling window from "500us"
to "<50us".

Suggested-by: Antti Miettinen <amiettinen@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 72 +++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index f6a8e6cf6d94..9dae6195e0e7 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -5,7 +5,6 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,10 +20,11 @@
 
 #define KHZ                     1000
 #define REF_CLK_MHZ             408 /* 408 MHz */
-#define US_DELAY                500
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
 #define MAX_CNT                 ~0U
 
+#define MAX_DELTA_KHZ          115200
+
 #define NDIV_MASK              0x1FF
 
 #define CORE_OFFSET(cpu)			(cpu * 8)
@@ -68,6 +68,7 @@ struct tegra_cpufreq_soc {
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	phys_addr_t actmon_cntr_base;
+	u32 refclk_delta_min;
 };
 
 struct tegra194_cpufreq_data {
@@ -149,6 +150,8 @@ static void tegra234_read_counters(struct tegra_cpu_ctr *c)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	void __iomem *actmon_reg;
+	u32 delta_refcnt;
+	int cnt = 0;
 	u64 val;
 
 	actmon_reg = CORE_ACTMON_CNTR_REG(data, data->cpu_data[c->cpu].clusterid,
@@ -157,10 +160,25 @@ static void tegra234_read_counters(struct tegra_cpu_ctr *c)
 	val = readq(actmon_reg);
 	c->last_refclk_cnt = upper_32_bits(val);
 	c->last_coreclk_cnt = lower_32_bits(val);
-	udelay(US_DELAY);
-	val = readq(actmon_reg);
-	c->refclk_cnt = upper_32_bits(val);
-	c->coreclk_cnt = lower_32_bits(val);
+
+	/*
+	 * The sampling window is based on the minimum number of reference
+	 * clock cycles which is known to give a stable value of CPU frequency.
+	 */
+	do {
+		val = readq(actmon_reg);
+		c->refclk_cnt = upper_32_bits(val);
+		c->coreclk_cnt = lower_32_bits(val);
+		if (c->refclk_cnt < c->last_refclk_cnt)
+			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
+		else
+			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
+		if (++cnt >= 0xFFFF) {
+			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
+				c->cpu, delta_refcnt, cnt);
+			break;
+		}
+	} while (delta_refcnt < data->soc->refclk_delta_min);
 }
 
 static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
@@ -175,6 +193,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
+	.refclk_delta_min = 16000,
 };
 
 static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
@@ -182,6 +201,7 @@ static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
+	.refclk_delta_min = 16000,
 };
 
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
@@ -222,15 +242,33 @@ static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
 
 static void tegra194_read_counters(struct tegra_cpu_ctr *c)
 {
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	u32 delta_refcnt;
+	int cnt = 0;
 	u64 val;
 
 	val = read_freq_feedback();
 	c->last_refclk_cnt = lower_32_bits(val);
 	c->last_coreclk_cnt = upper_32_bits(val);
-	udelay(US_DELAY);
-	val = read_freq_feedback();
-	c->refclk_cnt = lower_32_bits(val);
-	c->coreclk_cnt = upper_32_bits(val);
+
+	/*
+	 * The sampling window is based on the minimum number of reference
+	 * clock cycles which is known to give a stable value of CPU frequency.
+	 */
+	do {
+		val = read_freq_feedback();
+		c->refclk_cnt = lower_32_bits(val);
+		c->coreclk_cnt = upper_32_bits(val);
+		if (c->refclk_cnt < c->last_refclk_cnt)
+			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
+		else
+			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
+		if (++cnt >= 0xFFFF) {
+			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
+				c->cpu, delta_refcnt, cnt);
+			break;
+		}
+	} while (delta_refcnt < data->soc->refclk_delta_min);
 }
 
 static void tegra_read_counters(struct work_struct *work)
@@ -288,9 +326,8 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	u32 rate_mhz;
 
 	/*
-	 * udelay() is required to reconstruct cpu frequency over an
-	 * observation window. Using workqueue to call udelay() with
-	 * interrupts enabled.
+	 * Reconstruct cpu frequency over an observation/sampling window.
+	 * Using workqueue to keep interrupts enabled during the interval.
 	 */
 	read_counters_work.c.cpu = cpu;
 	INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
@@ -372,9 +409,9 @@ static unsigned int tegra194_get_speed(u32 cpu)
 		if (pos->driver_data != ndiv)
 			continue;
 
-		if (abs(pos->frequency - rate) > 115200) {
-			pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
-				cpu, rate, pos->frequency, ndiv);
+		if (abs(pos->frequency - rate) > MAX_DELTA_KHZ) {
+			pr_warn("cpufreq: cpu%d,cur:%u,set:%u,delta:%d,set ndiv:%llu\n",
+				cpu, rate, pos->frequency, abs(rate - pos->frequency), ndiv);
 		} else {
 			rate = pos->frequency;
 		}
@@ -568,6 +605,7 @@ static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
 	.maxcpus_per_cluster = 2,
 	.num_clusters = 4,
+	.refclk_delta_min = 16000,
 };
 
 static void tegra194_cpufreq_free_resources(void)
@@ -684,7 +722,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters && soc->refclk_delta_min) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
-- 
2.17.1

