Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92047B81C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbjJDOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242757AbjJDOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:06:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A1AD;
        Wed,  4 Oct 2023 07:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAFqm5oaP/IicXRveVlpI3clqwQRdVMo7evxSgWqnrUgMn5JVwVoH5RK5Ckhwbv+DpUueb099c7bNCoq1gt5k4oVnMPlh23XvIcNqUKVeZa9+BCvMYma2SCNPQ+18KlfBwAOVIuhIxWoh1bicqywjh594bS55iGp+tEoihKpoZPunnPAHzkVsDtyw8Mhkb+EkcAjUIB1tCHQtgMKaEtPIB4nLfbJdSuTfnbA12sPFuiT8NDg+7INbKJv7AhIFKZuHCHNPuasR3XCmq5xOXa8qjijJsfs57+FIK+mYsuW0ibqsnZksS91DkrB4fouYTiIAoC/kXwBvKj2Zb4fkNALJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox70atXCa1yw/ahkFwgVYgCGINbSrJ3tXMMuQ4HFBWg=;
 b=duXVL9/KEBsfsKXsrBBcXBD1KIPCao4lkHS74/phg1unfkOwT/1/ibSoX8PTZp/9o5ioTR6nmOJMRYmijKwFLEQMbOmJKX+iy+gzZK/C16tZ7jBuPyhERHXrlAN1deTMpjuz22atNLYEGuQSgfSU77Vk9BiPs2AtLazg0AxLN4YRuoZr89ksv5fCpedl3Zn2onnYZFGlC0wqlB1GDUacJZblKOvAbz3swQmdvaEA1sGqpwZslqvkydW4cFlT2OeEXfm3BaaASg+l8N1+l268y75eVY6AHmDyTWoqSDL2Ny9AGUc9lb33Z9Hk7kBZ6grxIoWfXcp7isrdJ/knbrKFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox70atXCa1yw/ahkFwgVYgCGINbSrJ3tXMMuQ4HFBWg=;
 b=MGtZRQyB8kXzmjpOJfZr8B1PV4QrM9h5gclTuc7JFUe4ATtBdA1CMA8qU6nSajsyZuTjGDmgG+ZyCL6PpqQlbblQ+MD4EAcXvh0/4p+st6CNNi6ROeXvxoaWPYUH12vL9/nRA9x2bJ3ciYP6HQiIwJKAinHHy1CLm7gLEMw9hlJVILcOKVukpsSem7FkeHEvVXBukbBJVpAqvRIPHE/vxlr+9HveJSrZG6eVwb+mhdNbvu/CAQMjeC+3QjdjYK2WB//fZD1dsGvTp8/KXhVNvfqvOki1+3nJMve2CGkaLYOOsTgij50twxUFPz+w6zbJU8lPkjJLcqBImeG2JI61Ow==
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 14:06:09 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::fe) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 14:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 14:06:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:05:47 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 4 Oct 2023 07:05:44 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v3 0/2] Improvements to the Tegra CPUFREQ driver
Date:   Wed, 4 Oct 2023 19:35:35 +0530
Message-ID: <20231004140537.1954-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e24e44-0e30-41c4-3dbc-08dbc4e30d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEIKC32gkd+YYbeEHXsUns3w45SD1R6PNSlghKLaRVGAdzkPzjyLIhSUn6qeWlGw70RB5PEL7ulgA9+elUtlMrlXhb5qx3vs6F6gXCEmPEZxQlzzhQxWb6C6hCT+AP0jTSDWnSDtA4J/p8rFOkhAJ8LxPQIAgYIgPtuPw5TBKuzURBgOxOaWE4pM4etP9M1YwVa1Em7z/HE1zoDqr1JXdWkqQMVKZWECw+eIUIyKyfJKWnRncFV2L1OFYGr28h5TyQ3CJPHaW3LoybErKDZ/fEQCHxXwtJlQPpy4oIpltAsIMvZzZnnmSf0FYUvF328dVMpPgSL/YXa8DBkd/MoFDwdvwNShlq04WTJ2zGHUPAopdLHmlIPcP7qhahIj+bSjW2Vg4ssd57QBw7ODz5M9rHYdh7mJDc3U29KO4QR/Cl7Imb3AG2J0s1ODqGO0Okn9YpTsb6dAnZPY+Q+L1VKibfyoKEGW4VGENVnmdgaDsafucBIsybwbg7PGmcwp8aIAFTiRf1AbpwT9KWVxX2gas/sVeglXuZHnCjLAtCmjCej2eNnywXrCww7Z7OmOoLTKj9oF64Q/OtwO6ehvYDwFVaW5Ez2GKaT5p826qq5wM7DegDEKA4zIi64cFo6M5ZyxnwrXCwo1U2tHjWGNwNfYV7wfUqD/vpPMI8AMbHqWdVieGQX/iN9XCtxscy50d/r76odFOXE9dr6BhZmtSHEB5Vze4Vq1Des6qRnN76bifkyCKInnvJB/++WBMsDUh0sCIiYPZT71TiKB7qfIHBzjK8dn4RzvA3RAQNavxzP9dgRGKdPF+0U/R91iMnSN27cu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(7696005)(478600001)(6666004)(47076005)(426003)(966005)(36860700001)(86362001)(356005)(7636003)(82740400003)(83380400001)(336012)(107886003)(1076003)(26005)(2906002)(2616005)(316002)(36756003)(70206006)(70586007)(110136005)(41300700001)(8936002)(8676002)(5660300002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:06:06.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e24e44-0e30-41c4-3dbc-08dbc4e30d73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds below improvements to the Tegra194 CPUFREQ driver.
They are applicable to all the Tegra SoC's supported by the driver.

1) Patch 1: Avoid making SMP call on every frequency request to reduce
   the time for frequency set and get calls.

2) Patch 2: Use reference clock count based loop instead of udelay()
   to improve the accuracy of re-generated CPU frequency.

The patches are not related but have minor conflict. So, need to be
applied in order of patch numbers. If 'Patch 2' is to be applied first
then will rebase that and send separately.

---
v1[2] -> v3:
- Patch 1: used sizeof(*data->cpu_data) in devm_kcalloc(). 

v1[1] -> v2:
- Patch 1: added new patch.
- Patch 2: changed subject and patch order.

Sumit Gupta (2):
  cpufreq: tegra194: save CPU data to avoid repeated SMP calls
  cpufreq: tegra194: use refclk delta based loop instead of udelay

 drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 45 deletions(-)

[2] https://lore.kernel.org/lkml/20230901164113.29139-1-sumitg@nvidia.com/
[1] https://lore.kernel.org/lkml/20230901152046.25662-1-sumitg@nvidia.com/ 

-- 
2.17.1

