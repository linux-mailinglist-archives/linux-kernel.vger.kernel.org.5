Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7406378C0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjH2IoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjH2Inx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:43:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94DAD;
        Tue, 29 Aug 2023 01:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqAnRFiJAvgSinnxkt9ZLeESHv0j5232fmvmhTeoS5H3vmqleWbbVjwD51XjydwCHUOY3jslCXqc4fsqp1lgq7alA5FLA1Njcf2sidMxISp33Fc29NbLoSYmbE/KL9VaW7xPO92fQ4X7seObPLFUHDPyesSuq7pPBpSFvApkpZcRldX/tRWfTucUB0Kx6yOudE+MJDDbZwtrZCv6WODYSHrnbzpJMK2t6vuA2spnHvSuPkLX1of7dMF8NO88vlV0HTIXMapU+jyXCbe+GZcbkekPEL6J0jnLVJCVVz2GlfL4k0icLc1eFQtt6rG2/H7UAuztxGPOumIyTRbDjb0AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnUigKOqD6XqO606esSg1381KmsLvK4vrtXMs1cFWUU=;
 b=Hm6XGIyu2eTqNJlBprr+FV2y7MSz2qZeKw3oy3EBO5aJYO5qfXcVfx1wZXJLHx7zgOhzRdT6HzxdNEATiSe/VGGCKk3t3Fi9Xy4TCyXlKLLkBA8f0t87qUSY9cyHS0dr0gtqHRyLSqgiV1V6mtxIzRxESVeCgETDIchrc+1E2gnB4eydRZETdiL4VpYFBF1h8ptsCQ/IkjpMJUFSuI+dtrT+Ed1PpmzBDezKXddeAkdvlFqcgsKAwpLlfJtmOuOZjO0fyj50g5hQx3BYlmqye7C6WlVmexlxBOl1/o0wo1PD0cgie2/+ox6ucjCEkGcSgjnRwN4eXgEmhVkRV2Bg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnUigKOqD6XqO606esSg1381KmsLvK4vrtXMs1cFWUU=;
 b=NaaK9mIGxfhAZx8Zd4CLC+8fPguMiA3BRDZ8lWY82nuSc3HstbglvW1VBhfgP2PsNN1Uwc/dg48qnEhfdK5GZ5S2MLaqT9OVUXYgE0V1BYhJFpfXdD37SKX0YmS+z/eaPrkuLc9SXA2mO1kxIRKUWk1n8wq5R4MSdPgUUC0WXnIU+2h9thELdXvHEurcDjcV8pcQvYZpgPvxBsINsd4FUJ8KNeAjYVvNd9x7leKW9sBA5TkRd+oiV7c/j2Gup0sdktm4xRUD9jcNdOQRNACpHxuh4rOeESlrpq2gl1Eg2NLM+SatZsmHQxMwzeugfvuQHmZ5aVl27W+O5QYwcvqh9Q==
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:43:46 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::4) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 08:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 08:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 01:43:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 01:43:30 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 01:43:27 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2] cpufreq: tegra194: fix warning due to missing opp_put
Date:   Tue, 29 Aug 2023 14:13:22 +0530
Message-ID: <20230829084322.30558-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: d9800d66-6e9e-4305-d94b-08dba86c0ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lW6q9AasPlnXWhb0czsAjvqJA64pmYgQoFadP7n7yY8t5Ma1XskjtYHb6xvNaljx01TqIiFKTgpUXJkGaXEyrWtwtI39S5ynJHYVC40NyJOnJFxNVx7YSI8VCxFcmILsl+wqzP8nVNumVQigyoGiTuvOrv+oXAOn9iMvUpqWcpI4BEVHxAre3OXhGTTj3hL+fwi/qfqnEXtKGlKsKELlSdjl4Qx7QQOKTQBdixJcNi6O39bJd7/7Zmem3WOyR8LhsaaCUExTtnRvFhwfSdZmjYiRepgN9qFfpSifTz51B2rnRRX+rJXFnPkosUFYXOZMRbCE7MEBIlunjGIsJMXjz+hzNq3A/voymVq1cYDxngUHy5ujrnjpIgJOB/eG9v/+giAziR2p8VsoFfJluGEM93lp/+/MzIeD+tngrZv3Cd9qr7AFPpjV18P5IW/p+wpBkDn+1kHe+xwOgMobvae0gadaZs59pGOSRMT0RX+fo8qb39fRb9wJvEFo0oCF6w6dMEu514IVOTc9NgfgQ2AZjCiUk0xJyOy43DSzv5Yrl/omNn/I05CmNynR6Qwx3/tQeUEVrHNkC6QVRdMnhXt0eu+auR47FQz7IzTBbt9BLXmzmI+jM2/gk4PsCcTSFN6hpwh6NzHfYWbFuxkHEOGmxhCjTveafGsccZmVgO+2FmKlXs79uodiYbAgINNWsbZ9be29UxpfFmcQm3H/RlFAp2f3VYUv3qtrrJ/ZwdwJHw8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(7696005)(36756003)(40460700003)(86362001)(7636003)(356005)(40480700001)(36860700001)(47076005)(2616005)(107886003)(1076003)(2906002)(336012)(426003)(26005)(83380400001)(478600001)(110136005)(41300700001)(70586007)(54906003)(70206006)(8936002)(8676002)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 08:43:46.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9800d66-6e9e-4305-d94b-08dba86c0ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning due to missing dev_pm_opp_put() call and hence
wrong refcount value. This causes below warning message when
trying to remove the module.

 Call trace:
  dev_pm_opp_put_opp_table+0x154/0x15c
  dev_pm_opp_remove_table+0x34/0xa0
  _dev_pm_opp_cpumask_remove_table+0x7c/0xbc
  dev_pm_opp_of_cpumask_remove_table+0x10/0x18
  tegra194_cpufreq_exit+0x24/0x34 [tegra194_cpufreq]
  cpufreq_remove_dev+0xa8/0xf8
  subsys_interface_unregister+0x90/0xe8
  cpufreq_unregister_driver+0x54/0x9c
  tegra194_cpufreq_remove+0x18/0x2c [tegra194_cpufreq]
  platform_remove+0x24/0x74
  device_remove+0x48/0x78
  device_release_driver_internal+0xc8/0x160
  driver_detach+0x4c/0x90
  bus_remove_driver+0x68/0xb8
  driver_unregister+0x2c/0x58
  platform_driver_unregister+0x10/0x18
  tegra194_ccplex_driver_exit+0x14/0x1e0 [tegra194_cpufreq]
  __arm64_sys_delete_module+0x184/0x270

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 88ef5e57ccd0..9d7e1d58f6e5 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -450,6 +450,7 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
 		if (IS_ERR(opp))
 			continue;
 
+		dev_pm_opp_put(opp);
 		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
 		if (ret < 0)
 			return ret;
-- 
2.17.1

