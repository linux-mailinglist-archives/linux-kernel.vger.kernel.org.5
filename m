Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA3776433
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjHIPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjHIPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:40:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF2F211D;
        Wed,  9 Aug 2023 08:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQVY1FT9KrI0tyrxV85aLcgoluSNQDF9IViEwc+8EKRCMq1lEzhWYYQGEu8kUOFaTJp9O94eP7CUo4NAP49AiE2M/3H7JXdYrI8NGhTmzIlKmcN8ycqgl0ANweRXALfjGUnk3A4rlUoIBcoNWeH8prOCXU79Z3x68nnYlphMFMoTOYDI69dWTexOZyVHfTYB5jDjVX/qWrvdV3IPO/wyLHRRiTDc5y0BsmvzIjShmhCsYotHitnxOzkwsrex0PZIlbvWd28BABwmvd7AJQdpK/t34yG4zH8fEdo/amZrDpoxBrbP5JvLvYxI/pFJoOENHjrGt6XjMC/RgbKdYhq7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyZfNR/99U85MFKUe4GrDyXWW+8ulGfxnGD6ga2LRqg=;
 b=lXlZVZ5JBz0/d3eFcveBdONzPktxP/TRH31hsnqNXjNpFnxbQAgKy3RE/A22Thc9B7Ue1+x+wIcyqsxk5l88nDSUT364DXoHG2q5CrRBakrr2KNKfUJqwbtqnj48j9LN6kw9W8ndMGxm+m6WSpYv/igGfK8zqr6/szN4QnyEqpnXDhRFI5nYDTZG/TzRVuBJEILOQYCXU7nuSvKi2uL0qw74SyJv4ToH81SHoFGKU1lbH0kwtQkGew+J6Knv2J91nPvL4bYiX7Bk0LC6k2DIPn2B1wR6cjP6mdXySiPZr5am37ZS/yojf58iUjbsx1nIJKJDeMH+d31pMCxDLnCcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyZfNR/99U85MFKUe4GrDyXWW+8ulGfxnGD6ga2LRqg=;
 b=h32UmfgajO4+P6X8udPUvs2lhhxHbdo97Y3Hh5xwuNW5uOGX4SaSGqcOkJc7hSPZaYsw3T7Bh1iSABX6gMQIhNUtiITbkO+juafhmybuTo/AWaFF44cBwZpXCt+xFB/t2+D2h1eLjxqk8TUrvJwIy5ki+wVSaC/QrEh1ERmRTzKItph081Jdi0d91g+zhRPWP3uJelO7WY40jtyQpQZseTv5+wiEPd+/rs9fqvR+qoTce7brhlR3vvoc4B7EPPwUTWouQyDKIzdRAuPatxAHZikHyXOYchKbEF45ePd/o3r9HqgHamOhLl7Pr6cdyRIcj+lxXs2TUfSeDaXGKvP54g==
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:35:18 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::2f) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:35:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 08:35:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 08:35:10 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 08:35:08 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] cpufreq: tegra194: remove opp table in exit hook
Date:   Wed, 9 Aug 2023 21:04:55 +0530
Message-ID: <20230809153455.29056-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e59a3b-dd4a-4e1e-154e-08db98ee3beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z50kDSZemQ1raMqXze464rw2dcaxJ7pTqaMh+IGJ4/icoGS0YviIhfdzBYvZx+uB9Qr9DJA045kW8RRkkTb5S1frDDBYy1jyzKHsDiqx4ZWDJDx7xJA5sao6YWKtliJrxCXdJpUcrzfSDEkmsZxOr9pQ/X7VJTlqDHHAVHJKJFui1aZelMkzVhRDQTXZdcOomZFUOjjpjZiDY97lu15VYhBheI1Io1yRyLS4UpTUAyJCNXY/RdsYG/Phu4fXfxy8fNfiJTSvvUtf052W1Aj0tkVnotPf8/Am1oizJUFPlKW26/FNGSGMHL7uzA1SY18TZc7ZcgV6Sket+2iA9QY+j9sERNgrEOS8aZkWnNKXMCb09h8Y2DJ1Tk+Ial8eoA40MrDia6e25PG0tcuO8UuPnrwAsrLmbwI2uyW62ZvQe6en4j8urqb70IYm88PSrxi4DXkvmYg1M96zGy9uUdLWFdM3bEZON1IB+/r8MavWSTcgIq85rpuUZZimWs/fhltuYYuVcjdmo/EpcjwDMOjzHIgx5PlWygVWO0cr3UzzgdB8TYHAJ1gmEumQ5T3M3zMSGzzgaMedqnxsn5r9vEs+p0QsPW7DE+nrdeaxJGRC5DgciGNg3ycPh4XMIHwB3jSD9WwGVyM/VY0vvKvykclcrE/vNVuevUq8nlmPGMjva+ot/SeZLz7oX9VFoFemdKpxcTzSBPv3NzONoEy+GWKbRO91TWBFXwASpC9gtD+rHOri7bYFRD+6Fedd1qdteiC8
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(186006)(1800799006)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(5660300002)(41300700001)(70206006)(70586007)(4326008)(40460700003)(316002)(86362001)(36756003)(2906002)(40480700001)(336012)(6666004)(7636003)(356005)(2616005)(82740400003)(107886003)(7696005)(1076003)(26005)(36860700001)(110136005)(54906003)(83380400001)(426003)(47076005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:35:17.7020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e59a3b-dd4a-4e1e-154e-08db98ee3beb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exit hook and remove OPP table when all the CPU's in a policy
are offlined. It will fix the below error messages when onlining
first CPU from a policy whose all CPU's were previously offlined.

 debugfs: File 'cpu5' in directory 'opp' already present!
 debugfs: File 'cpu6' in directory 'opp' already present!
 debugfs: File 'cpu7' in directory 'opp' already present!

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
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

