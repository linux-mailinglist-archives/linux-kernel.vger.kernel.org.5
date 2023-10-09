Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C977BD511
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjJIIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjJIIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:24:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F7A3;
        Mon,  9 Oct 2023 01:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C57cHAAdOJ4BTEE9vPUPQLjXT08xGreAhkaT78f2PGplhre0vYGPGp5xhr/ndw+IWqsuwT7Cfe5YpCEFhJDPbM/y4kvqrB6dyZjUety+xS+54vxlUeUF+5Cshg2c1FBqfrPBWQUXR7KqVKipp1B+Qvg2gYkZJJXlw7XRHoTfFREOU70kOVNoz4202iH7ipjO7ABxRnKBVLuueFvJ2gKwR+RTFGet4sEXE9d3p1klFkzg4NAJlHX6Rgg7DdSsT4/erOatArlvKLouyDPr+k9ZU0w+rSGaFXA13d85jPFRXn2MdCPf6geOO2LP0TW1SO58pO+a2iW3aD6sR2kIHHQLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/g7A8r3Z+OC2nUcVQ/ZkMvyBNgd+TIO6VflJhEGTdI=;
 b=fQ1hcEL/FIt36kIurtpSLCLOz57NyBlWkRpRvA5wmIaihASGV76quqEQZ04mN7nTdAEBGGYVirNbtZ0qo23ijeJAwHUhtBgHPKxRuaMTTsFblLrmkCBDpEJhsUUgl+96ACDkpr8/cMLtTj0GsDSbkRMht7e+418VmymLxERmhq5ngYAy8qygOz3QdqRz3OXFVGp42s4VEJyh7NqNlyIFCIQIO2b8o+j8NmIIKJD0UvO5CEt831zk7TtJeKFdlvs3rf2Yeye1t/nPhgNDCdMfJrHHcTkjVwnQwoBRHqL7Zf2RLn5qaoYqTv5lgbCrhxLhDmFm0nIJr6FBgdOOwF9OMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/g7A8r3Z+OC2nUcVQ/ZkMvyBNgd+TIO6VflJhEGTdI=;
 b=JQAJaOMOqiraBUGRSGWZCrp5awFnXqVDR7fMyIYlTfxOy40Ce4lh0iwFmUbwsvJOspDPNl56G1EPIG0kLZGY+UR4OjfjOJYZDqqP6yqqJCQBnUhnXZbHroZ0JG9xWPG0E8IKZEFrsiOvV7lq1MrWX9ZeiiyPj2hi9tWnXjEP4lNr0hrFsSeS87TEPxCA0w3HByaH2/lh9J7DV9DcvnU0rMOR5+GyPRIMIpfFfSTnWP/FhVzTMza3A/bPt1gR6/y8KeKjM4loAj834PVjsh8RED/YrPjmI9BxwsJ2yLOgqybZjDMJaHR7qTAmc6PAYg8te5BOxK9MAvEnPXqoL8mlhQ==
Received: from SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 08:24:45 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::20) by SN1PR12CA0083.outlook.office365.com
 (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 08:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 08:24:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 01:24:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 01:24:31 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 01:24:29 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch] cpufreq: tegra194: remove redundant AND with cpu_online_mask
Date:   Mon, 9 Oct 2023 13:54:23 +0530
Message-ID: <20231009082423.16714-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c67fe4-e270-4c33-c925-08dbc8a1317a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nN/U1pBiQaAneo+A6JY96R/qcz0r2YsinK2AOSoEqiLFrEiY4jZTwwPwyNkG3Ei6gFcZOCFPfwFiFKQnK1ApltEgg6GWqFNP1EE0drfiJKsIFKvZMRp6Ys//6wHOAVqQ9R01741JTxkr+wOaf64MQXMkNOyci9ipzceiQpwddwJoyOmk0NPNBveYuolqbFJrBCUoax65HaZwpiNf0qo0yWf6qdYhbS/7duenSkeA801hHkttDvooP9OgAQNBURhyySXMFuXmA/yRH8mWn1rmRGnikBv5rXldvURyt0DbaqNRoWqyCeqoV2kYBSKpHLh0uAyd2UbWtkV4K2Pi7OPI0ngQiN6JXNJQQfFoiwboz/G5MW0dT8gAK0z1+/Eg1GQblcx/52/e4cajjNgkpBwiuke+pftT6s94C/B30s+u90Xd4rhShxtv1WDtYn8YFp6ZsbcfrgaxuayDeFKIvPeiVAnV10mXhqFQxhUobriveoCWvxd2Y5MnmG8MqtlWAUdXT8yEAmyexdKLfNPIcjHbaH3MRvzO1B9aClcow80gugHoOGYCj+4h6le4/EGsOoMV8ZBp00Fz1WuxReVxsMKVLN3Pl8Y4SqE+vzEokJGiPHIzz1yu/eccbESR04v8A3OfXi0UnF7C81XwPm6Y1UuIRzn16G44UQfOSxi2MgfBp4M7hJCBswhRiD3zllALj5975jhPABzOfOTSfvTc6nWjcF+P2SIrFuSK4iYN8Rtjv2DQszqnV1T2ZZXCvQwEIhMx1bHYDmep77t+jnDtmeZHg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(4744005)(40460700003)(426003)(336012)(26005)(2616005)(107886003)(86362001)(1076003)(6666004)(7696005)(36756003)(478600001)(36860700001)(47076005)(83380400001)(356005)(7636003)(82740400003)(40480700001)(966005)(54906003)(316002)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:24:44.7227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c67fe4-e270-4c33-c925-08dbc8a1317a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant 'AND' with cpu_online_mask as the policy->cpus always
contains only the currently online CPUs.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/lkml/20231003050019.a6mcchw2o2z2wkrh@vireshk-i7/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 386aed3637b4..607e699b3d84 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -135,7 +135,7 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
 	u32 cpu, cpuid, clusterid;
 	u64 mpidr_id;
 
-	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
+	for_each_cpu(cpu, policy->cpus) {
 		data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
 
 		/* use physical id to get address of per core frequency register */
-- 
2.17.1

