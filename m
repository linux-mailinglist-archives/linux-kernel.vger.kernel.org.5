Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8403788572
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjHYLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjHYLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:16:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA91BD4;
        Fri, 25 Aug 2023 04:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S05Lfmka7oAScCehm8pKY4GpoyQK2yqYrGXk9b7gwcefK+8iFoX9JAzBgo4ikIaRhx/TZ8VITCiJjiJ0sxM8GFsFE8Iu3GxW/VU5r6KphPVEnvp7QrzQYc3bN3rsMGM+KhnZAtzwgJ/F/+hVJbNH5l6HXcuE69LsEZadxj1Sxi8EReVFFZxMlnk4h3wAr8R2hfK2iQ0P8xDyRT/AOlRIc79KRgUM4w8F0fSoBP+JRjlLLwmE1B0INoRV5MsGMLtPd+HWYvyuIjaZ4cK3aueev1DbndJseNHXuxmyYiaAGRRJ82h5+LTcYOnW7Uih8YsUl+mslqEym67T3He6bnPkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOlSc1pn5BPG6P115ED1Rbjr6/JR+iTLO4FKrgFMyzg=;
 b=hS8YPpcEjN0OcplVNRoYD8iSKzjzE8w0rFRS7z/tE6LYZI1WSx6LdETa/gGSNJJ6GnJv5L08NpuddK+l4AFTuE04Yz0HUGz19ZS+/q3StfYpRTXZAsAxgA5J3EGMihhZ89YdXXlPEpt/SgNv+nalpr6hTlq/9MbLETUp5gJ8AEHytt3RtrNOjrmSLEGrO++0lB7Rztp3HRzsqgA86viLqBkCoLK9QbBiu0DMfsAB/jf4H2Oc+b8/YEIkf8jE3RnvzwvHRxCSld20lMsqiDTRIoWaOfhyzA6iAZhvaoSyOsmtziswdysJ4KfTGvYFBIptM/qaGCh5sHsXZPdKmdtPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOlSc1pn5BPG6P115ED1Rbjr6/JR+iTLO4FKrgFMyzg=;
 b=CEjHnZeuXCDJecEWLxtGjl6SnssbGUmB4gJjO948pwGJBz2ZI+8ToStDsftyWZXVymgubJL/C365MgqL4R4hn/GtlzFpauWznbEXhzOisMx0d9nFFJ98vPlvLCcKJ8D5Yd8o7tFmvaRLCt3lsJHrT0emjy94Wa+Mp8b4m+f583A1YaqDfJtgTwjP+499nU+tslwq+NYgdMmMlkRbc85sQRGcCpnNHjWZkLLaN3wtoYZPiKaLrVG1XhlSTJjpMYeKn0zeBN46PL3BR+r/G4l9t8zvvCgPY0Glx9bKg339o09FQpbDU1x0pRDgnZcvfKsYaL0HbCtyXfPnkZVmvM8Gpw==
Received: from CY8PR02CA0015.namprd02.prod.outlook.com (2603:10b6:930:4d::18)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 11:16:32 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::e9) by CY8PR02CA0015.outlook.office365.com
 (2603:10b6:930:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 11:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 11:16:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 04:16:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 25 Aug
 2023 04:16:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 04:16:20 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v2] cpufreq: tegra194: remove opp table in exit hook
Date:   Fri, 25 Aug 2023 16:46:17 +0530
Message-ID: <20230825111617.8069-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fab9fe2-440d-4c9e-331d-08dba55cbc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPFBNZjKf0z3+GIxqy316imu/fdtgPYjXzU5u6WGNttxCvq5XdFUOYqZj4KiDHEK3zV0DQpMti9aIMJH6sH0Rkg02Sg/rwmwZIHTZUhac5bg77JA3FRfIrr3ZRuUIdfDNOCMhROr61rPJbyWHg9aD1mweDC9sMMPnS3GJVGgbtGlO0S7vSq61oCAXElqTJ5PtmihFe81HYOXLQv2ieeKGAUU2hxGvu1qdRTxpxFqAcnJ8YXVFBgHozF2l3TLYHzBri2E3U+7lQ7H8XuyOheFVZEn8Wl3nqeILqWh+By63vd5wiBrtmVlSQxdYb7AzL0uYVawHyJxzrllXh2/KF6evyhINM+zZix5BC1U0WM4AlVwnSaAhRngtL3Y44/fnrN9K7Ua9FNIaVxQ5yXmI8F1INjYhRWLwdEFFvz8qaa7jxGQji107Crf1nLSz64vZi2hhMhOdeizcceT4qlJRjwvcIWZYySN9reIKp4fh0QQLZwBkI/rngl4D6CAdvUT8LQtcDmJyZgl/FeYRyJXkR/xDZ68QY/R0zW0NOX+Iumkch9sGNcFZ0cJQvSOGccRUULU2cqeavp3hls/6ZYQkkCEfA8Z6+/jR6YC5NqGPlgoeEza9di/ZLQ3B7b220A1+Q2fL8+EYy2fuNzRO1VfzX/H832nKfnJutGr4GbkzuCpO47MOn7D6uCm2bqi/Ykdk9If4QLJ6IauxROZA6blasqr3vUVlUGVJ/kO7UPctNRlWsS9T4szJ/nUBdoF3VCLzz7n2d53oc9JnyhgRG/00YxRQDzGfSFSOXEvLBqAnZQ/+ss=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(36860700001)(336012)(426003)(83380400001)(26005)(107886003)(1076003)(47076005)(41300700001)(2906002)(316002)(70586007)(54906003)(5660300002)(4326008)(70206006)(8936002)(110136005)(8676002)(6666004)(7696005)(478600001)(966005)(40480700001)(86362001)(7636003)(356005)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 11:16:31.6058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab9fe2-440d-4c9e-331d-08dba55cbc43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exit hook and remove OPP table when the device gets unregistered.
This will fix the error messages when the CPU FREQ driver module is
removed and then re-inserted. It also fixes these messages while
onlining the first CPU from a policy whose all CPU's were previously
offlined.

 debugfs: File 'cpu5' in directory 'opp' already present!
 debugfs: File 'cpu6' in directory 'opp' already present!
 debugfs: File 'cpu7' in directory 'opp' already present!

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---

v1[1] -> v2:
- updated commit description.

[1] https://lore.kernel.org/lkml/20230809153455.29056-1-sumitg@nvidia.com/

 drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index c90b30469165..66a9c23544db 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
 		if (ret < 0)
 			return ret;
 
+		dev_pm_opp_put(opp);
+
 		freq_table[j].driver_data = pos->driver_data;
 		freq_table[j].frequency = pos->frequency;
 		j++;
@@ -508,6 +510,16 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+
+	return 0;
+}
+
 static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
@@ -535,6 +547,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.target_index = tegra194_cpufreq_set_target,
 	.get = tegra194_get_speed,
 	.init = tegra194_cpufreq_init,
+	.exit = tegra194_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.17.1

