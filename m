Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DDD78AFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjH1MK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjH1MKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:10:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173BA9;
        Mon, 28 Aug 2023 05:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLMTVAyWRd+x/4giTQLcLwD/gD1HyEBT5FACjLuIrfuXza9Qxx9EBHgSGoCwNcvL/RqhwlveqePZI+AI6z2d/yr9LoXRUuzYNziICtB4nPXmJEW1hRrbfnMwaFcsMP3zzb9MgaEUO+9z6JstvHUYtwDXRFDTRxdIO762qFrJLsiF20CdL7ZO1mJj1q7bitn6mBl+mmL5lq9rjLuQ8lWesceUU8cUSdkxOkKGtplQG3t19hF+F9gw8+zHJfbrjZGW6VptV0KhWy2l17L9OpHbNR+owC1SDq2ID8x72+q2wRLoFyht5Q+kdyrpmHtvFDvMJiIJzLWA/6xpbx/uBVwHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEneMGFpP7wgwjGsBhTwDDrohulnX8L7vh5k9HOd3zU=;
 b=ZANwjrJb+CAnTXWRVfAAq/ypBCHC6et/JP+AHILTLVfOzf0+ubtGUAmdeiiaDyYWJI1tb7bXlD+KWsWgf0XhKGDPCJMlTBqkK0IqtcU8RXmQZ6yQr21cWypNC5tSljnDGWXLhUGmGxfInUiPcrkYOKFJTHpX5ccvpuQg9v+05UchghklWHXURp94uKqzicrumDeSZUhrj31CPo4GXa/XBGio2pI6W8DguDz+WTNuyAnysKfgtchynojT0no6qr+2mbwoTv/MsVpN+MIUT8m1rXHXiLy2rXSAovfPI10xA3EXbcizyI2TYD9Bxto7G7iYSszd5+Ka5mNRk9DxdMKo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEneMGFpP7wgwjGsBhTwDDrohulnX8L7vh5k9HOd3zU=;
 b=un7TIXn1LD+w95YNK7wvrIzGfTOc/p5S46vK/rq8K5o5vhTSZa4CqK6sk65WOFzL10NLf5dvHLUNpnQo2XnKxGTBvf4z9a/Ef3fTdWfZ+dGpZyJHlVLoj/NImWQa8YnzUKrQbAzOs0tDNG4SGwGNJt0Gjewt9gVReO7R8nyDsxfjf8pUzf+lggJxzMDjaNEHWmb0CJzLKCzLWEfYY/gkEACZWKezsNb4H0V7dfBP0Mw3HJRFipJyBgzwROevN/8MlEj6cKQ06CYNtKk8Oooy+P3pg1sXb6hwKJb1r3Xk2TLPJjNOmLLbaOy69G3T4lOjbAI8cApFqn1NlJlF2AZi+A==
Received: from PR3P189CA0038.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::13)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:10:19 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10a6:102:53:cafe::76) by PR3P189CA0038.outlook.office365.com
 (2603:10a6:102:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 12:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 12:10:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 05:10:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 05:10:04 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 28 Aug 2023 05:10:01 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] cpufreq: tegra194: fix warning due to missing opp_put
Date:   Mon, 28 Aug 2023 17:39:59 +0530
Message-ID: <20230828120959.24680-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: e289bd8a-9230-48f7-79bf-08dba7bfbe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0F64nWUA64Phu4DCwR6LAv24KeSLKH0f1O9d0/bfOBLibQMZpJZLs+Rs+JdhHrabMyYDRj5RDGoJhFUxZAPdzLgtfrCYlvv81iRN9ClFY4EUah/2cSyIS1qqlXtq1kM7wbe5bfAWvfsr2C252H4Y21V+8Vfn00ybNqrpl4mkHPONsTFfVnvN0H3VX0W8K+WOnqZrS+ETqhac/B4d+zkF7cIbpK3g8a9qz6L0mkKmTKrlYIHR6cMYqqvRciD3THyiUtSrPR0o1kQe14FMZH6UQwsNpgDi8IP07mAA6xFdNmXfFSCM7XToLMnF9/Q3Ws97NoTjhkMhUo5U8MYjoPKIg8Jyl4bCQcIyUf/cpZVTnm4UdUWSZ+5hv/rv95ipz1VxREilwx22Fk1OyDqHmNxr7b1NKuuc+9iGttqJa5RZb8jLPMzQkpLWx8dFkWy93o8ogfn2+SGB4X29HmWfaqcFU8pHirAcwC5JVcLihftMdjwlbJlKoWF1U2mA+lmIlYQM9IALO87Ba4h4XFPdje2uNir0gyyLU5/RP8W2CiePLcq1oba7m/xGSl2fc+V5NrGuLCfPj+9+0oSlB7NrmV/F5mnKNM07QII4+HtzYTmSlQus4MN5ogfXCz84tybSfxuzYyxKyK8BP9q7CgZOK03ngp4D6ffd4YpGEvdtZ+OGw1ZIJF1BWdx1oVFT1NKigTn5C5FaSYOKSK5p/9XlkJgCDgRL81wE2+x84fWJhKQD96s=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(7636003)(356005)(82740400003)(26005)(426003)(336012)(47076005)(36860700001)(107886003)(1076003)(2616005)(40480700001)(7696005)(110136005)(86362001)(2906002)(316002)(4326008)(70206006)(8676002)(70586007)(41300700001)(8936002)(54906003)(36756003)(5660300002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:10:17.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e289bd8a-9230-48f7-79bf-08dba7bfbe5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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
 drivers/cpufreq/tegra194-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 88ef5e57ccd0..f63f7a6c2034 100644
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
-- 
2.17.1

