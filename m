Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21078FFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbjIAPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjIAPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:21:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438DB1727;
        Fri,  1 Sep 2023 08:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOvU5bQrZepv8LbayPTcwaxNDabKWg0oihljoAzCB/Qc3D6cFJfik6Z/8iWjNmggZuN4XOWLXDtPK5DJDVCCGZQ92pBlNZzTVkVmpd8FANEMMFQpCIF9MACmqNoKVyJM+Jan7qX4f4ZeACSC1l2u0EqFI+hjFWmgNjHW084nX94Wudi/1YUOFhjv5oP71fEgidEe/RhbbqiC2eA7UeIJJl7NADHEpacnLFomCi3GC+J481jUZDBGE1q2pLb6dGJ1gVPCsJf9AQoYBJ+xWjLy9Q06pR3x8pWrjL+SIEZJQrMHBNqcWJnoHd8uj1c5WtxbH4gqDlsVg9crMmBiJ0KZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+PbgGhVq8ZSYsidXKIaDFsX5m5RlSOuGg6dPbm7lhQ=;
 b=AfDsT1QUL6+7PxuBDyzzHnmCLtaBXTbBfWBO5fj2Li+G1thXyysUMg/YE6KFLZ5lwyqa/TeRLVAmKw88GxjYhNgonFUJ8bCRLeEV3jPeMlTsfgXKicsG6XSg7m8v0G+0goPIMBNaH7obFnrcyFrZUZcFWzkit0AsAv2UE59p0wplJSOUgThFo7CLG/4Fs4AlOAK0Qsekr30+V8LegDMthiS0pSWDAZ5c4QcdyZ/OmpP2qWxcr8/V5YgJvHkTfk1Pfl0jDWyaj6iQcfuACf1ypofHEezquFCMaopbrjY5Hb5rP/c8jTe0A63/amv7z7RFp+steeD7OSBSnpjoHUkRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+PbgGhVq8ZSYsidXKIaDFsX5m5RlSOuGg6dPbm7lhQ=;
 b=GMSvwFr2WiZ9bDRJOPVceOttgpKwMXU9azGiN07Wkome8663HEFMAJYft0/cM+lLnY3q8IX1U3vJXhLSD2UzZaJov91uGLwIKlnKQZfXZ4DXBJ+6pCdhUdbxbYXC2+ypN6ATnmD6ikW5SZGnb8+x6ex+AxFNo30SUs2195vOR56q54CEj5D8qxWyhUEtHdmyxCJZGgj541trXcLwffTpPeEyjzmcD4hmxCzUwCZIVTxuTmv2OgVCVQHPHPUxtc57UmGjmjTHIEVnm7GXXuqiMi5c8lZqGRSWBcIZKqorRc4efN5YLcy5pErfcnxs711480GqRpSe42C4WhvAD3TDBg==
Received: from DS7PR05CA0033.namprd05.prod.outlook.com (2603:10b6:8:2f::20) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Fri, 1 Sep 2023 15:21:06 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::e) by DS7PR05CA0033.outlook.office365.com
 (2603:10b6:8:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.17 via Frontend
 Transport; Fri, 1 Sep 2023 15:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 15:21:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 08:20:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 08:20:55 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 08:20:52 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch] driver: cpufreq: use refclk delta based loop instead of udelay
Date:   Fri, 1 Sep 2023 20:50:46 +0530
Message-ID: <20230901152046.25662-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a6e85f-7759-45ac-f6e8-08dbaaff1017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWvnSyydadGxyLrxE+syXJ69QGAo0f+KvD0hAMZz+bv+0s+zvrDoHSGx0h3ze0ImeYXPahPdOyJsX4LxIvNayEYzX5GT7Vt2yycBOvt24HxqIwJFvh/jfkjIiSdEOHf28Mks4bOplfVTQpTeQxo9nYatSCwxNSDJoBLE8/aeLLFoQLse34Mjbx8yDvK0HuWdC4bGQJNwH6ADBtcDJDAhL0XMOQspvdSp4tkYxCfj14/caDu8mGEs9zbouYJT92Lh8IlwPvHBQQ6ah9D3+BkehZKqMVdScjuNB2addqsd6C5sUCnkA834DRugBDvVJjb1lrPitz3ZKRboatekgOvO8Gv7viVc05eHpl03hduKVTnYT1ToZCCk+lLBeHeIGxo3R1Bhr8jqS/PCz0uSHJ5BKcz7t2pxFQDDBZre/ablsIgodmPLT+bRrB00NNMOWQ5G1T2jxQMbmtp4idk8lP9uHRpesWkmYJ3yniH+IsVWEWwgVbs86j4dv+MvzCs/Pz245H7XRrZQZJaYXRQpLr9ytXFawp7UAFCyTSVbMFNI4MSONxHALhkfsSjKwpr/OeJMLWd3njrkft7KTvtVLyS3mAJ9aUbEGxSVIAl3D5/NGwS8AO3WVsRzHi2v2BmKksRzQ8XL7TSsq+4z2dQN/YhJB/1TUa0DaqW8tU7J6a+nj/yE8iVXagt4Gh2atyRg+q0IBnTuUU9a1D5TsFFSHlwV0xWMtYBboGRg2QQ3iYlFjBgyu1Begv9PGIbSMMBsm+V8
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(7636003)(40480700001)(40460700003)(82740400003)(2906002)(70586007)(70206006)(316002)(110136005)(54906003)(478600001)(356005)(41300700001)(86362001)(5660300002)(8936002)(4326008)(8676002)(47076005)(107886003)(83380400001)(2616005)(6666004)(36860700001)(1076003)(7696005)(336012)(426003)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 15:21:06.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a6e85f-7759-45ac-f6e8-08dbaaff1017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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
index 386aed3637b4..b7161506b897 100644
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
@@ -62,6 +62,7 @@ struct tegra_cpufreq_soc {
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	phys_addr_t actmon_cntr_base;
+	u32 refclk_delta_min;
 };
 
 struct tegra194_cpufreq_data {
@@ -158,6 +159,8 @@ static void tegra234_read_counters(struct tegra_cpu_ctr *c)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	void __iomem *actmon_reg;
 	u32 cpuid, clusterid;
+	u32 delta_refcnt;
+	int cnt = 0;
 	u64 val;
 
 	data->soc->ops->get_cpu_cluster_id(c->cpu, &cpuid, &clusterid);
@@ -166,10 +169,25 @@ static void tegra234_read_counters(struct tegra_cpu_ctr *c)
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
@@ -184,6 +202,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
+	.refclk_delta_min = 16000,
 };
 
 static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
@@ -191,6 +210,7 @@ static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
+	.refclk_delta_min = 16000,
 };
 
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
@@ -231,15 +251,33 @@ static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
 
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
@@ -297,9 +335,8 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
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
@@ -383,9 +420,9 @@ static unsigned int tegra194_get_speed(u32 cpu)
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
@@ -580,6 +617,7 @@ static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
 	.maxcpus_per_cluster = 2,
 	.num_clusters = 4,
+	.refclk_delta_min = 16000,
 };
 
 static void tegra194_cpufreq_free_resources(void)
@@ -673,7 +711,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters && soc->refclk_delta_min) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
-- 
2.17.1

