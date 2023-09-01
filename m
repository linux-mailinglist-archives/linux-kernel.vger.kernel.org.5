Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B787900D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbjIAQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347262AbjIAQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:41:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3110F3;
        Fri,  1 Sep 2023 09:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3J+fB0nxhvp6nIUfF+TxeV1ArhH8IyN6vscbFmvbZt1SwImJy209+kcOhGC0678H9CcAhOhtEjx+4RnyLSNb3GGzXbN5bm1wsnZIhS4l5/mgiHxR5k074zchkFda/0g1L/gux0fz2Z8/r0PCIymchkMljBPEANuooV26pjHn0pSRHMnpZ7jIluDowz/c9dy8/zUkiNxCq+grL6pLmYrLyLRB61SIwD+h2zz+L5Dwhlt3kp4VO2jgQkGc0PdW4toL9j56Nt/ElK1oUnDh9AXZ0iIKcYZBFFbTZIHeFnntFpstZAf1fbiSZ8LxhXoP81Mu0+H7+Zf/3jQ/EyVYOFelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rupWK1b7f+rbEZ4GlrZgsRsz6ZUjzaZ8g5pGaR+2Wew=;
 b=Y+vidfM9JMGBWGOQwtZgALfAsxrykwTkp4cA3P41MQtFHGQSfa71a+ts4X0xMqJYhQm+grPY8yvoGZFwSsOdFk6J+Vs0lqYfxtBElAyJ1LqMdop+4AiFMqT8bnXNDK9RzdZEG3ZmlZsyDq3AVNWgwilTbmnyEk0DzOBTgaL6JXJt/IBoQERRwiPf2MUNYOgGCbN9hxYa/3hqES81Eb9RXjUSp3vdP7kfZ3q8o1Dt3cQwdZWpSyM1Y3OAyHdMYmxvOvA6kqqhr8M2zcJaCix/XXkcdblCPTR7+5ime8JBW1D6oKXw/Mcijrhelyh5JdjHDgLVyP8aJ1IxCZ5YSzLy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rupWK1b7f+rbEZ4GlrZgsRsz6ZUjzaZ8g5pGaR+2Wew=;
 b=bcvPMwg8q6yVM5w/Dqa+W2c6um7Wt0N60KWrEuHq/Gd0AUPzy0fbkwoauyq/8lKplaX1Xb8Eme1d3fWn45NxKCp0EBTFuntghPC0IvOwlFSDuYSf/vFFxE9U+x2q+LeZFEnJGt3392TFAhX9IZ2+WPWGvl9yu3vDLwzcrBVO8UyYQlFPPWo0rx4oQ5bGc818nyIubIQvEWCY2In6te3LvoHCji1IB3/IpaBnYLsLR4VnbFs/j30Dmd34lostu3YXdpzcx7qmz6s6qBHdsCDoBpFeJDAemlYqtbjyOvcV+h/NtBaGAgIf3+17qP9dWZ/GgFZQDyud32bujdjoz6IqWg==
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 16:41:39 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::7f) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 16:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 16:41:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 09:41:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 1 Sep 2023 09:41:38 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 09:41:35 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v2 2/2] cpufreq: tegra194: use refclk delta based loop instead of udelay
Date:   Fri, 1 Sep 2023 22:11:13 +0530
Message-ID: <20230901164113.29139-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901164113.29139-1-sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ee3459-dbdb-4eba-4193-08dbab0a50bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySwqWDivpjmb8+IOdg1IzvlflM28TenexgBGBjKRQndiPhSlBgKtR/s83iKiimlLMYEFadTRSb6gSY3ZvzDJHV0sGRxkvQnwWvD+Ov0wHALi/+qurE4cw0gsQa2Tcvx0rS5WmVBFCLZgr/pEQVuaRpr364NqJ+WfZJe75ETzbVVplwqmHPu2ELXZEG7BFRQIKPDBLH6WvMj1b+ZvPg7caujQzIYbf3M/F5JMFGp6R5aAqOMZLsBXDffooXcMyiuTukpfJ0bj7aQBYUrHQR3uZuiw4W0HVIyLMibtFypo51cx8qNq4d9ehZT0KY9NeylM2WnwToi+zQYU6ol4TDgCpTzVfklsn6HEIt98wDyT/SU6Y5uQU5VS2/GZQxyaUBYERIdp5f4dQeWTavUB3ndHQDeAXxprvc786O9qBNPWjKIwM6f7lnY4RzVTMqLbOMxUp1yr9bavIJoZpazqcOW4IgmbliHYuerZDYm34QwJzDgHbMQgggUPcp05bj2BXT7Krk1TAuU0Aqcb5zpG0uF/dMtcRayy+rz6iS9PqACdUoYiNKdv6m4S8bizeCRiLKfTas+ZZ4n/qoB1YGYLIDDz6lc8StX65IAAF+303zn/EzHOgNWMvLS+VuzBiCJqPXcTSGARARXPvqLDhpbMcFEKQ3QokpMbxSyOyuKjrTvLqdUuopaos1jFXlps98TqypTY6lElSv/RtDjbwEhifGXEEtC02RbugK1fbfW5Rb8w94Z5KqS0TlqyYvhCGU1VkfnF
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(6666004)(7696005)(1076003)(478600001)(83380400001)(336012)(426003)(26005)(2906002)(2616005)(107886003)(41300700001)(110136005)(54906003)(70206006)(70586007)(8936002)(4326008)(5660300002)(8676002)(316002)(40460700003)(36756003)(47076005)(40480700001)(86362001)(36860700001)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:41:39.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ee3459-dbdb-4eba-4193-08dbab0a50bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 0d0893cf7f18..cc84c752fff8 100644
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

