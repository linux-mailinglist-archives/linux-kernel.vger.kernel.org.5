Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D67973FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjIGPcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbjIGPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9961BFD;
        Thu,  7 Sep 2023 08:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVhFhKap7GRgyiHgLJWdvIQmlWtd6x0833QU2PDe1M/T/MHW3JCEVkrulfJQ4siENAZwOkTI8oYa57ti4l/wLtB28aSq0KKMMR4mAcY5Zr6Uan3giliOlw+hJCSe8V17WbBN4CO3dOVCHEP/6JbPa1KVtpA6UoVrhzBxtfhyzVKrpHYj8ZKXuTUmoatHz1WfY0p9G4uei5i/fFp7SPMXYm3nkSmiu918qRtML1Pu29GEsw5NewY8yBQshMUlv3YaTHScGYIJZQZymVjmeJmaD/O0W9b5Rja1aXrKqEkwP4S0qw4+BRp9mgbERt5NF3Iy1dotC4yJ2SOuYIiGWPSjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NBZQqsIaS+1Erhhm+urQssMC2v/wT0cdJmaOKgR9kc=;
 b=BAEEU1cAzdGbaXw86fzVYGlI+KolTjNeSoFWVqUqBlsHHKeG8S+s28wiqkGUfPVDLpAjWSMq1OX+0TWB8fu+laW3TyKAAnt9JXIva463AJH0m/ueHubEzkhZ+eTDzPvjq3NYyO9RnkYapOfgGHaAJVlAnTuYoTqvaQcfRlzAowcbTS+9N9ViE6R2blJ9gNbAVUH7WscvP/EGgEttPjQ5ZDppBLA4rYsvLdFTjw1xlVYWuWd+UfW51sHV+PWYExchFZWqw3Anse9Xl0J82/6DEeTfS5+h+vPoFNf+F/M3mD8BvP3BhaJQYDWnjYMnBtSa0X8c7cYqbcBYgGqjZccrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBZQqsIaS+1Erhhm+urQssMC2v/wT0cdJmaOKgR9kc=;
 b=oYiQ3XjMpVROtWrKRr2E0A2aEUsjqbQ1UqSa7BQ7SouUhBDD4TVrPKDTrtHRdBaVbZfHn8CL3FDF0OG7AX0xDx3JaoPMHMNPLorRckFR4c+sffMKeIx1fHFYU8+dzC4nlM726Rtaz7BsLuczrO8i8C72xGfURx2TYe6D9ct0z8yQhgr+FDMXw3sZRDM36AU6vzniPhx3V90J/BPpuX2lNqUNLdSu9wiIZiobGDC8jXlUegRgqVvajKK2fBa2ss/rq50J+hUpWt3qWJoiP75WqD+NqM5A/y4S+2EzvA7Wo080LarXtdUZYnHhHbBVg5HVQRmaR5TGvyfrAv58jKW09g==
Received: from SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::26)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:11:16 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::e0) by SA1P222CA0095.outlook.office365.com
 (2603:10b6:806:35e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 07:11:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:04 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:10:59 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] soc/tegra: fuse: Add ACPI support
Date:   Thu, 7 Sep 2023 12:40:46 +0530
Message-ID: <20230907071052.3906-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf22d82-51c1-4518-2236-08dbaf71a057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkcg1hjPyPPSylPmcm8EenUkkLIaE0Do/2HFaqGff+PWjO77INBGBMJj9hDj8ad+pxT6VsgvfLFe2roE4YCO+nTUS+SBl7Mq+IV0pWdh7Op651Duk9bBEWeOHPmW4i8MuHvLjg6wxg7PKC4xUHRoaZeT44g9SnlaFrqIUV2Pzg9+4FEE1kO+BDacjSOhmSOUoIjh2vUXTzpONAs+P0rERZ2Ki0WQp7HBNw0TbUorHxSqEUOqumvl7FQgJAtMdfqemnzTr5IG+GW5TMG1fWw+pM3oqHUs2TRy8YppGhr/PTj8eJH2m/Ani2wSinrgNZKft/6e2uwF+L7HG49zySw7xN/GSHVMrGoltExnBIewjXKwQ2vnhrkalyOurplXTBTzWOx81qyhFsERnkaG0E8Vzkcy0zk5Wv92LdRrvCgNKVk3FSKlkQysJEzB+ImhKtg6gGwZshPQOHnH6YztJ+nVhqA04xx04GVyQVX0L0W0bCqyRweBrAdtcwW1MUWZsMr0Zw/Xa2ZtuHAoGPDj19wj47UfqfzTblY6QjCJKL4VeJ8wjOwZ7jXHccGbDNXb+epPVeqsdya8hPfC9rDa7tp12/Nzr4cNb0Yyj3ido82zdr28F1+2B8DYKLmErA/Y3+bWM0glsEKuyIRUHiaLKHrKHzdL4RKQeUADeI2W3unEss6286Xly3YGme3GD/61mqZjROCjea/2JGMsIRwzEfPwAW9ELI0T2qp385pR0eXwag7ucij8nhqtcs9S/SbocCy205vh2WkO+xatWlYz3N0N+g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(8936002)(8676002)(478600001)(70206006)(110136005)(70586007)(5660300002)(40480700001)(83380400001)(41300700001)(2906002)(316002)(86362001)(6666004)(40460700003)(82740400003)(2616005)(356005)(1076003)(26005)(921005)(7636003)(336012)(426003)(47076005)(36860700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:15.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf22d82-51c1-4518-2236-08dbaf71a057
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add ACPI support for Tegra194 and Tegra234 in
Tegra fuse and apbmisc drivers. It also adds support for Tegra241
which uses ACPI boot.

Kartik (6):
  soc/tegra: fuse: Refactor resource mapping
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 ++
 drivers/soc/tegra/fuse/fuse-tegra.c    | 119 +++++++++++++++++++------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  21 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 +++++++++++++++++++----
 include/soc/tegra/fuse.h               |   1 +
 6 files changed, 217 insertions(+), 44 deletions(-)

---
v2 -> v3:
	* Minor changes in following patches:
	  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
	  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234

v1 -> v2:
	* Used '--patience' while formatting patches.
	* Added "soc/tegra: fuse: Refactor resource mapping" to share
	  the common code between tegra_init_apbmisc() and
	  tegra_acpi_init_apbmisc() functions.
	* Dropped "soc/tegra: fuse: Add function to register nvmem"
	  as ACPI and device-tree boot are sharing the same probe.
	  So, no need to refactor the code here.
---
-- 
2.34.1

