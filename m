Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2D7900D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbjIAQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjIAQlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:41:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99C10EB;
        Fri,  1 Sep 2023 09:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb5cOQlTu0RaA0Q//VVVuyY2jo1HnDXasdujELJ+2PyCEFRc39FCKiKCX6nqijEm/nri2GMJoXQlNyh1zFtu5kcqPY5AFbY58Kg4fkvEv+qGpYvaKOx0ADvSnn5JwgVhBZZfbpTppVze56oReVXWlYWa5Irva3HPmKiyw4dTyscwkKQViYL8z33tRYLWoaINw9wFQNxX1smuhGoDLN81pr2h/aPwkd7SZjhcaXVmYgIcTR/vMQvfBT9YIXWFVJUPUDs5YSyJKVf+0Zv/CN5MoU0jqDhwUn4gu/F9ZP4iyc1dnpxijdv5O5I3lqVH4OfPPCXZiwc8ew39ybW6iNiK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzM+607jMPN5yXKcn3Nu+imnsL5vsDssKjrwO7RYBKs=;
 b=IDvzP9Sfxu5qY0Tqk08elW/ZnNxTGbo91v04rM1a1j45RsW92A3b9wcwo+7BVzmgTSr8DlLGO/xdaO7gcRZEFzuXqT/T36y7URFiDGpNPdwAkc4+Y9WKvHEGBcfzRwHvvEGxjMWXHtckzrE75GtjMRz8S71LKEkV0Lq/68UCYSad+CiEAJYwHtmFO15YqmEggS3ZtorbgDskEZoT/dfnvCFGYjy7bHaYUws154ylLUmUXa+76CHUMG9HTGqyjsAAqB1I814d0GRR7jSGndDWrjC8QJRxwGdoZcGFHVnfBXUTnaJcAxGwN2Qk5aI/PrORhzsd+wG9vzPb4pOtPfbkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzM+607jMPN5yXKcn3Nu+imnsL5vsDssKjrwO7RYBKs=;
 b=Z/dEIVXWOWqkTMpWiflOXC/tFtPDiZHQ7X2Kppei7fEwT/tkCKvUCxhz/OSllIKCHr2/0pmvrGb/bNpQFQwNl6QxQMamhGvl8s7IBk1J57CuQ8cq5Mnun9QAIVL8tX3RiqOIHk3FKY1+PpvTpc+x/483ngzvZRkhiCHPv1xko6fj4LdoY7+AOJYW3pG+0QWX/qABle4l3AAp2tnBXuZ8Rb5xQdwi2ieRKsLR5LnpWIE26Zb0KTo2MtJoVhRjQcKDnWMBYEU96w1pS/DYSmiJyCP9QSEDjB+MPatd3LFUpi7auKnQmA2Xtgp9fS6y45FoDftGFHu7TCQrOpnb1ZqbSw==
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 16:41:29 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::41) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 16:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 16:41:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 09:41:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 1 Sep 2023 09:41:28 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 09:41:25 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <amiettinen@nvidia.com>
Subject: [Patch v2 0/2] Improvements to the Tegra CPUFREQ driver
Date:   Fri, 1 Sep 2023 22:11:11 +0530
Message-ID: <20230901164113.29139-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ebeaa2-6734-4fb6-a665-08dbab0a4aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmBDgRCp5soYcdJz+5hfla5utfAh58l4O6dYyWcwrVCuiTiI/hUAQbGbndmP4i2inVQMTDBZJ1QWOYz1uRxd9XhlZNvrUmmtOdKXEz9smRn/W61Q7SfRhjFmDPKUn0vb9oBrKzm4eRWjheDST6XYMAfXHAEjTxL/MBbdGjDErTj/lm5UhCMJYKxtM7jwQQelHDp04CX6N4Qzxdgt62EGrylF3/QY1g5tqSn5fhsm5uvwadnEd+L/b/9vnbXBgloARTLOHVL2cFJEteqCDO/gwlkzy6/49oUDhijYh4/yhhPFoFPrrselYmqL0j8SmVZxYg8x1Fj+lQhoBkApj+oiwjv62TVYYmBPVdVJ2C4WJ00Finquonuys4NnknL0qFQRCXfb6KiXojMLz4r/A0aMOFldlq8Yfwcu4m1rQn5E4rme30nbRBo+S71XHM+uFnUsIvm9PMkabKFzjXLk4XgeMjBzRvfkAZtuVSyEw8P0MOkknkQ9K/uwHYnhHJOLivu7Y1eCBSB4DlvvWtqzE77IDS5bJYiOv4TUznHmQIhiL1CSDDKjJAuvucozbxeO1rYtIGTB9GUFTYwh51Gmmi/XxnMM+5KU+ocR2oXqcvQ8xQZBx88xnSBaSo0jNs9nucENPBZgYBwXx8iYet1DbvfQGB/o9oXEwzVAqSlLutXgzRU7rddGAUZdpO3yFbnIZoIhoC0kBZbEOfbaFDVJLrMAcfYSh/kokvF/aFu9ioBWpG7AGJazq+di2J8FC84SKOZW
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(83380400001)(356005)(7636003)(86362001)(6666004)(478600001)(82740400003)(47076005)(426003)(7696005)(1076003)(36860700001)(2616005)(40480700001)(4744005)(336012)(26005)(107886003)(70206006)(110136005)(70586007)(36756003)(54906003)(5660300002)(316002)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:41:29.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ebeaa2-6734-4fb6-a665-08dbab0a4aa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Sumit Gupta (2):
  cpufreq: tegra194: save CPU data to avoid repeated SMP calls
  cpufreq: tegra194: use refclk delta based loop instead of udelay

 drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 45 deletions(-)

-- 
2.17.1

