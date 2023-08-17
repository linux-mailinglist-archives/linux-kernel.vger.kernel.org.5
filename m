Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53977F34F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbjHQJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349679AbjHQJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:31:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF32D7B;
        Thu, 17 Aug 2023 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niSBR99vvUmeJugP8Cv4V9yfgeqwjGzucYzZpkSRh1yHXJiz4FWskLIc+HEga06LLpnCffjPTty2NWCULTV4eF2OMLmjAICNZGNCV5rWK6aBR6MNDxiaUwdx/i7moZ8d/AQfcmkSb9zLgO1YAet7epnxy15eqPu+P/c7VMYsk138ImnweWOYoF0bbJtwDTBq3FKZJYOpjRp9KW2aofNzLg+xAUzoERw5uiSYMvNhkIwEG+qMCCDJj7DmghT55ltRKxu+ygX79alob+1/ehfGTJgR4g9jm+YG63pzWxELu8ZtWMUFBlbYaH1TmCIb3fzD7tM+kDjIhoB7FalSlqXYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VPNdHieA/LwW2WRFhJjpgW9dhPfxv5W7z65oC+6MHA=;
 b=blMOHR8idhFcuAvw+5bLFZIVoox4M4+NYszalxnRB8GmgvpHMo6uPPSWqSJui0cQvNeCZh4nP3/P5N9ZwemqMZoeHW3NNLtoGGTrJW07TyRq+PCXpD2rCUnx6d7OO6LDyyclDhNM6lO8oHafGunYJ52gHAUl5NilbHo+yP0uTeYRVZHLpsSPqZufd35s42QvP9JviPr96VR8uKHq3hVEeHxuhaNXYtmXMUy7XX/W9gJzoZbCady1NcsObfg4FAuTeYVkkW7lpShk39QSeR0p9buiAj5pHkTDtST4gjBKIn8N+NGyt+EIvYxklsT5cyVb5QRO/calBZbPTSTtBDV/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VPNdHieA/LwW2WRFhJjpgW9dhPfxv5W7z65oC+6MHA=;
 b=L2HRT5PjJYM6qbVwEbF92pvoXlWsiDlopb2IGGEZ84u8y7fxOY4mMHqrgBrfBnMdrlguoV0RewbOiQlKJSZQmKTRUMISMSDrIAxS3z5kp3gsCQqUouuwR1A8P+sc8GJUZR5Fj1hriAYAESayMXNjZCItRWdBTf8C5oAA8pZ6l2mJCgsetvYThJnC7ZNitf86DSX10u8wRWjnqaCXFVzQExqTbkrwvS2xWNJQcDV3sY0lTDcPaHJJXhA2b7rwGF+4mPU+7yBT2q/pP73jvrP+OIFRlSrZU2NHga0/G95ALAjcQKoVZsOHllbsdyMBtU4tT2s6umRNOoQntayKz05U8A==
Received: from CY5PR15CA0096.namprd15.prod.outlook.com (2603:10b6:930:7::11)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 09:30:45 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::d1) by CY5PR15CA0096.outlook.office365.com
 (2603:10b6:930:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 09:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 09:30:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 02:30:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 02:30:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 02:30:18 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch 0/2] Add support for _TFP and configurable throttle pctg 
Date:   Thu, 17 Aug 2023 15:00:09 +0530
Message-ID: <20230817093011.1378-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c5de7b-bcce-431a-f823-08db9f04a25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+fERAtYIIkS7/Ev94O6UqfpzfMw5pkU1hCaGk2sMFO3l3lHyK0HOUt7IhUIj0pmjntVkIC10h/qJPkb2haDy9Twuppdh4m4PKvrR85AOD/LzvYyLUzsfA0cv31xKTZVg1OM6atkFy/tqIBVZnzW9Ddx61EZPp9QJOH28mNSt00PpG9zxzZTbJ8vFzYwLvfXDxc0KrGBWQJ58hXsFs9wj/tcxepYqteotPkB+E8muKBU716W368bMySMRaRDFcAGu5Fn88GW9v7t4+lBoj1SZpkVkUf42RSTzJ2UWRRkhJ9wdT4ovUAXpkcLwGgcmq/6GBi5Q4+v7fJEpvig1v02I+Es5xRPSr64N6NG7E1EWKnuCRMVMW1lwM20yWSuumCrPr33E5Hs2+mJNntcqxZO+JXgL2lvfBDEALoodt00cVG9YS7hYeXDg5Wjf3cATQxiIuTL3077xZr5pgjcY25Qs33JMDaY2HZbFT3OQgh/59yM1BZIq9oq2sbevU8mE6d2MFnqMAKPwwnmgw/Xo5zUPGy5J+QCZwIn8TZpqU2J4VQATGR+PVzN28A5b7fQG2b46Y82ShHlNmJdphztpIBgnq8aVsoqBJ7rBHAgf/+bcOAF9qSmGyTZg9U2OeVXtk+e46DMbFUStsK5kcaIydeMlGo2Ay4vA6JFefUxxotNLCUwUL84Wan5uk1wUcrxT7ob0vps7FbgnUIWGea9fEE3Eo5WkPH08SJdcMR2cVHrlTI6vUS9ZTc6sfVvXI+xIdC5D8dTov7w40QtXZ2KORXKJA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(83380400001)(4744005)(26005)(86362001)(40480700001)(336012)(478600001)(4743002)(426003)(36756003)(7696005)(107886003)(2616005)(6666004)(1076003)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(7636003)(316002)(70206006)(70586007)(110136005)(4326008)(8676002)(8936002)(47076005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:30:45.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c5de7b-bcce-431a-f823-08db9f04a25d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for two features to get a finer control
over the impact of Thermal Throttling on performance.

 1) Patch 1: Adds support to read Thermal fast Sampling Period (_TFP)
    ACPI object and use it over "Thermal Sampling Period (_TSP)" for
    Passive cooling if both are present.

 2) Patch 2: Adds support to configure the CPUFREQ reduction percentage
    and not always cause throttling in steps of "20%".

Both patches can be applied independently.

Jeff Brasen (1):
  ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support

Srikar Srimath Tirumala (1):
  ACPI: processor: Add support to configure CPUFREQ reduction pctg

 drivers/acpi/Kconfig             | 15 +++++++++++++++
 drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
 drivers/acpi/thermal.c           | 21 ++++++++++++++-------
 3 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.17.1

