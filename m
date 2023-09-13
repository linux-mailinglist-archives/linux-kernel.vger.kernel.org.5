Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F579EF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjIMQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjIMQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F230FC;
        Wed, 13 Sep 2023 09:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXrzim9Z4XYFRHL4L+4ECA2kqZWyt5Iz4xNpyDHLsW21sE3sxlfvAubUKDo9JhXoGaAB+d00rd4tHu/z1tNu5ooT6yS3J5x6fje6E7KJebD+jjYS7lkJ4fzkPn6Oena38dWGDuf22v4RzdIbbYjUexPnnv2D4iGRJD2o7WRFPzJfPFZfxr9KV5tNQYXz+vvjtHce+DggpYDSruYPbUqiZGa63sCJoY2FYBGrYLBn9oAcFzzMqE0cIdx+YQk3Y2rgqOr/aqNZDY8lQLLrag/BMWCQyfnh8/dRq477B4OGlPOMYNfCSxnbEy8cCVjfv/neUXMYpi889z4pTgCXZd7uDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lexUrfTOHDgG17UXRgYxeBsFUV0v2PLyQwrbeunN3Yo=;
 b=ENxZ0RJhuazhI30kgp6bqcuy3+0X8zrfWTJEPu8W2R/bXJolr+ISftjymbcR7NfcxYMKHsBiw1t9GN+po3QfBiEn5VRTLxZXjktAOjwbirVREGB880XhkEzzD6tQpLM5tVYnz2U2mEP/UtT++GXPNhMNQBV4c0Hdxnt1WlUicpbnTUmFrNkB4W2xj0DReAFzHZZWYbc7DW64GpwBM815HisIXPIRTG676RLKxo6rzBTj8ciQYWcfJlTUnSkw6q/uwH3RjPNgpA8+1hlg5tLpkRqdsaBnTPlXQPsnBLIr0ZHHZaQIrMUrQvrjVTiQPpv2hEWNThdu51Rnst3ODGrgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lexUrfTOHDgG17UXRgYxeBsFUV0v2PLyQwrbeunN3Yo=;
 b=ucrbBaYRf289kH848bbxO+hTnUWZnzaChCMZ+/cPSNj3mqswF1Q+zk73yJajp9l7C8tjbxHBJmVHqvekLoiMr+rRbK4AnVUP38iW7vn7P6To9GsgsZLQbbB4iUM0ran8Rjk67bbdgyQrm2NcTGb8BQ75grq5vZo+N8D4OctZPHOsIL7f/R3TeyfqTwYyy0SKM2Ppp3idpAbcTbGKaD9cF2sRcziVQgjj0oUyiSvssPoybnHppVX6MycDgJ3eGghVdAQbhqF7kIr9bnlxQKdAeRG4gyps6NGztHhQ2nhlg94zyOssn0caFuzZhTe5SLQrGRhqq/f6wWi1bMYqxj5c3A==
Received: from BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 16:47:25 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::a6) by BL0PR02CA0102.outlook.office365.com
 (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 16:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 16:47:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 13 Sep 2023
 09:47:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:47:13 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Sep 2023 09:47:09 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch v2 0/2] Add support for _TFP and change throttle pctg
Date:   Wed, 13 Sep 2023 22:16:57 +0530
Message-ID: <20230913164659.9345-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3204cc23-2c2a-4188-e570-08dbb4791b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+ugCuVn8Yq1diC6tX15bKMIxws13obbWpMX7y7Q0u/mR+sVSwIZMMS3ULxdasUadxDE9weh8DzsmNIX7IhRJAYMtqwvNsfSYBgciWXw9IrZwDzf6IhGhZya0zTmyMoZw3uNoU3J+3b6zZUvnwpOfv+R0/pAYr7ZOXSb/F3GzF+vQNzUr6iGygE/rdXZkj9vEtyf0NiKhFNzDRuoryQ5ledIUwhgw8EfMIaICk2PTpM0EEkSpCj2/OJo6wxEslonzFhWE/jqCpAMTlolgJi+j2u9gMjbZDGoJ8SmFLZkWpUoRSAtOzgReYlN+wgSnO5ugLb//OOqNQhvibI/yy9sXkJCqAcNamJUtLLrskqERrRH+vQm90Mbqfhh/yxsv2GSbR4hUdlOWYHFQAEs9J4jFc4i50uoq6ZBPe179BdjDypCLceR6XpgOeNXyN3c+gkT+MdX3hzVxp3SJpHS2Xo0A/4ESSGBCvhhOyzyFtlCIVUbojORa6GfyMpRqtZa0QazztHIqsAfZY4uW1tixmTpVpDVQew9WwaeiM+ZP+mQOfRpBnBAkx+KNxRK2wchmcC5qXkFs33N4xQzsnKxObmuBCAn92ABQmXzpaZZBIKMA25wP56tXoI9/ToO+H03OUuEybNx71npqWOBsH0ISKepyMWHjd6DmxH3iNGRZ1g6zDnvtNfRabvGRhByfP32AHdwj1Ttu8d8CprC3aZph9r4tG1vHZMUZZY3gVeUZDMwlJbkWab9JV4nmy2VjfjMI0MVPQ61EZAsEkcc1QXoTnPqF+rnGw+WoyWtGzpCLkHRNTD5Hv63CPzjTQsv8vrtef6S
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(4326008)(8676002)(8936002)(86362001)(40480700001)(5660300002)(40460700003)(2906002)(36756003)(478600001)(966005)(26005)(336012)(1076003)(70586007)(426003)(2616005)(7696005)(82740400003)(6666004)(107886003)(356005)(83380400001)(7636003)(47076005)(41300700001)(54906003)(36860700001)(316002)(110136005)(70206006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:47:23.8177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3204cc23-2c2a-4188-e570-08dbb4791b01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for two features to get a finer control
over the impact of Thermal Throttling on performance.

 1) Patch 1: Adds support to read Thermal fast Sampling Period (_TFP)
    ACPI object and use it over "Thermal Sampling Period (_TSP)" for
    Passive cooling if both are present.

 2) Patch 2: Adds support to reduce the CPUFREQ reduction percentage
    and not always cause throttling in steps of "20%".

Both patches can be applied independently.

---
v1[1] -> v2:
- Patch 1: add ACPI spec section info in commit description and rebased.
- Patch 2: add info about hardware in the commit description.
- Patch 2: switched CPUFREQ THERMAL tuning macros to static variables.
- Patch 2: update the tunings for Tegra241 SoC only using soc_id check.

Jeff Brasen (1):
  ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support

Srikar Srimath Tirumala (1):
  ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241

 drivers/acpi/processor_thermal.c | 41 +++++++++++++++++++++++++++++---
 drivers/acpi/thermal.c           | 25 ++++++++++---------
 2 files changed, 52 insertions(+), 14 deletions(-)

[1] https://lore.kernel.org/lkml/20230817093011.1378-1-sumitg@nvidia.com/

-- 
2.17.1

