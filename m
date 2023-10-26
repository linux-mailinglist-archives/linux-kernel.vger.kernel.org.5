Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD847D7E70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJZI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbjJZI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:26:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318D189
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZeFFyh4aUuWdZbmgRlN6TlLR2bBPI2YeNCcWDRp1qbaA0DO1U1g3JAYqtXKMDP5fjTNFjD0YALcAYRpvKS4k5a5ZfknYWvwj+C7+ciTl5K9WsWH+J3hAqgRiMWbLuNYn52rxaWM1Qj/9Uu1hE43unspomzEU6OBn+ibTp3kYnYLpF696MMbm/ihjHBi9ms5p5vftlT/h+mNvP2eyRoWfv+CmtoKwOJjK46kD4dTLmXXpNkxrkOzcsbtLXvn6xxZZiV3Jud3MATXIjUAR5KC1MbGRcpO4F72z6+QevGtfw7Lh0yEScJMUisgSv9WXQuP8JAVxIbLOxazXZv5/TsdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB8fGrM5a0s1VQlduXtiADHn3jHn5GOSBpNAePZYaac=;
 b=WCnKWg9CtMPDbMsEkmS4ZS0BENzoTGJAUn7WwvG9Nl6gFkf9Li9jySNeWEaqT5fH0+oq1dwnloiHyiR4WkDCVWR0gH9YfuZkPeCgvLzW8syl/gIBPz9BtX/bZcZGO+jey8qZxCHMU0UAOaP55eQB0E83AR/cI04PazlaVQO7xtrlreHlJk0Fc0rZTG4jEkPh2HvaWs5EQsYjPQ5Apygq1KYJYep8aDXNpEbuchfecyE2bC1h+55GLks4kxvni4Uhg0iEKE8qhdgdlEur/PdkXV5NyQGVaFbg3TShHoEdA41ZcwH+souNazUEs7cLUy3msbJdtp3owzaWFa6LuPM9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB8fGrM5a0s1VQlduXtiADHn3jHn5GOSBpNAePZYaac=;
 b=ZC/tGzNeo1If+e3weapJGtzREIAmAp95CjpimSCRScd6GykXnfNLaeptoudmYiLi/nskhIL8mX9tcou/KjK77DMdsg1IAhBNqaZzP3Gq79qh6zxWuOILwNdtVoIgIqs9RPvv81RcZDO0k3o+9MshfOPXmp4RWxcDR26T1Jj2WRVM63vX0GfJmuLSBT/qJkaKnexOFzgk3tmZYbYP2WUCss5LrAk+ovINlc2i53328erWyuKDI5PujFooGpG1K3pezqSNgoU4NRXky5+rDUsGX6kcG+SEyOYprlNqgaNgTyB7JWVYV2ACd6eDYiuW5Uh274XicXJjlxK+I0tzK4j65Q==
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 08:26:16 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::9a) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 08:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Thu, 26 Oct 2023 08:26:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 26 Oct
 2023 01:26:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 26 Oct
 2023 01:26:03 -0700
Received: from r-build-bsp-02.mtr.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 26 Oct 2023 01:26:01 -0700
From:   <michaelsh@nvidia.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <vadimp@nvidia.com>, <oe-kbuild-all@lists.linux.dev>,
        <trivial@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Shych <michaelsh@nvidia.com>
Subject: [PATCH v1 1/1] watchdog: mlx-wdt: Parameter desctiption warning fix
Date:   Thu, 26 Oct 2023 08:25:58 +0000
Message-ID: <20231026082558.12142-1-michaelsh@nvidia.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 32225fbc-d8c7-4260-3d46-08dbd5fd380f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqBlfybfT3+m8pVDdd5u19K5BIuNHrMFKckgrSLSv9XPQwqtTmkE4cxehIQdIa8BiqdP9vOpYmufqLAEPgnaK5GhAEXY1BNoKOmdCLhH5vSryH4hTK+0gIE4aykMlv/K1lTnh0oJqll9u9G4p/DuoUQAeYfe0/XWewG64lFO3Cf/FsAL4+5IWu387Evl2ohpSHbqXyy0c74Kw5+BWmwryXmFqNyxGRgZ6N6qGoYYi1cSo72To9KVLzQl+qwfm7xPQpKMnL9CXsxmtjN5Q8T8RhPmr3WAM44cnvwP3hcV4rLnUIK+ackDOObkXLvDapG/CeeZLYW4v/Xur5NB+Hd59+lBWOENu8Kk+Z5iGeh5Tsx8GUBFC3VVneSvcmjCbdD1whgdng6AXlVJed0LTG1eGdKZvkpusSVvTSeV+U8wWn+DRQB+gGgZ2bEe8ABEq+KgDe1LCRk6udswCI9I2PSyh+4dPMYaDznIhCwrov3W9x5CCXsLEQvzMmql/pyNeXXy8w070uRsjX0E2qU3wNTn3o07UmrHcaLuDfYaCgFS1+zpqRkSw/HLLsAbtnBVscL+iP6ZLgg14bUo3hrQtxJzWf7XrCI2JxGcd02AUrcy051PV3ehKwSjBO0LKVpnTPr4iTxptziMjRbJRuXlEz3ng2yUViJDbnVs+31hljHUoJju2r5Cp/OlmMZA8hi0zR0lYDmThnGN4QOoLxzcOKlRFVy8goqlEbh62iHGuGcIq7CHHjwqjuc1kl7AYItljNifXcQ7qwd4qRoYpn5FyINV2ADjSgHwfw3qKRQ0p6ouHkU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(1076003)(7636003)(26005)(2906002)(4744005)(2876002)(36860700001)(70206006)(41300700001)(5660300002)(86362001)(40460700003)(4326008)(8936002)(8676002)(110136005)(82740400003)(6666004)(478600001)(107886003)(54906003)(36756003)(356005)(316002)(83380400001)(70586007)(2616005)(40480700001)(336012)(966005)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:26:14.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32225fbc-d8c7-4260-3d46-08dbd5fd380f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@nvidia.com>

Add parameter desription to fix warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310241044.lvqeOGli-lkp@intel.com
Signed-off-by: Michael Shych <michaelsh@nvidia.com>
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/watchdog/mlx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
index 9c5b6616fc87..667e2c5b3431 100644
--- a/drivers/watchdog/mlx_wdt.c
+++ b/drivers/watchdog/mlx_wdt.c
@@ -39,6 +39,7 @@
  * @tleft_idx:	index for direct access to time left register;
  * @ping_idx:	index for direct access to ping register;
  * @reset_idx:	index for direct access to reset cause register;
+ * @regmap_val_sz: size of value in register map;
  * @wd_type:	watchdog HW type;
  */
 struct mlxreg_wdt {
-- 
2.14.1

