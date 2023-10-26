Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56117D7F92
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjJZJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJZJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:31:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74A196;
        Thu, 26 Oct 2023 02:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2q/fy71ITYRTzDex8MD1i/bZeTB/Gu5Uo+yZ++V/UAoFIdzCiOOdBptBbTx3snPuC+IO2VLQSDB43g9ACTpVSqNFowLd16z2OqXzUPg4MKVymP/sNS8AmcwnMELLnmjI7QT0FsNHjkIj97fVikQcB7w9LQdk0bw9ylIxeWwmvV85LrXdbmSLnyE1M9AiihTBjQd+yhyvSiTQ573ZElALuPy+IaRitBYA6tCVlpxlJoVmZvCgXBlyI0shX0kYsQdCIhZSY5rZ5uDIHVz87HEKKh99lP5leoDkhlfEFKcwZVxQCilXjRaOxvzDM9SR9VKWRgGwG30cvV40OjOOEBe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/f12NrSFQP7dKwCuTvy8aW7mGugG2U90CW9inIhK2c=;
 b=cl4Blg2jJi2fl7lk7gKuWdbqH/9LBtMWDOvaMiP+tTsEc4KpasDuQ1S5P6cnFgYaYxh0nvrGHlMgfiV/dbYWQygI66YAlraPpm3S38r2MR5nuSqlAZAh5PGtrRartP/Ss18re0IFyzNLttNzIQnaxd8BCxEpIWkZ2Z5zyT63w+XSijsYNu4OutEHLqa023aZUuoZIqRh+3ulbkzHKJWtiKqntlzWqTP3pwTUwr7GlVfrqYCAQcQ1griMZFRtZPJHptyK0sndJmJDRJR9PS3mrI23MvJp7oFwMEucweyceP0j42UhymXRoq4r4PpOaemRYUcrG4VQqFINgoJ5xtokng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/f12NrSFQP7dKwCuTvy8aW7mGugG2U90CW9inIhK2c=;
 b=AbQ9PbhFPyslPtQXgIQ5E08RtR8pozFyL4Jb3xmdP7D2kuDd4j8pT/7blxktFI6fy4Uu9rLnNqGWdgjokUdQru3ouaXa1doBWcMX9HRmTGvRqvXlP0KfRKLLBWMMg4WQlutH5LeWiE31jcES4oxgzFwLkdQ2uQS6S4F1ZRFHSok=
Received: from MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17) by
 BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Thu, 26 Oct 2023 09:31:03 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::55) by MN2PR01CA0048.outlook.office365.com
 (2603:10b6:208:23f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 09:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 09:31:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 04:31:02 -0500
Received: from xsjapps58.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 04:31:01 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RESEND v2 0/2] w1: Add AXI 1-wire host driver for AMD programmable logic IP core
Date:   Thu, 26 Oct 2023 02:28:40 -0700
Message-ID: <20231026093029.3122573-1-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8870f880-447d-4011-0eb0-08dbd60645bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP4/rT3TsTaWeboRrRC0mHv9qzi23eCh+B5Biom0jdAuI8GZUAxH7Ul63b3z0aJPntbStlH812lz3lyYa2QeCphfR9lnb3oTdOa9TMK27GWWdSyMrAY7aHybo15Ay6QFKxUaGO11A+SMBSIjTYseBxqeE0BQMM1464E/J0Rue1ioBWz5jZJ5Ypy32ctu/ZB/vtNmlcnRd5WRoDfAM+NPZe72GsfsnD+57xpBJh729UsxrgptLZk5iMxo3SSGjDIdxxQMxeiZloc3wSoqJSbQe2rMc/pstmStzDkHNn+uTdKD4qjKNxGHFRD71KYEMOIfFQOgU+r8/D8NPqyM+hhP0CfAMUGpStFRIroMalRLpcgnO/ybqXPrlFmfn88FdeI2OdW3VYlC+CQ9SKnUzqi4Ntn5nqNhO/Rr93x4trmfkYHKFGpLkmjta0p8crw4a+MqgQCLz6asgiIf0IRnhdOELT0WDUUZ+i3cjmQgZMOtuXrcB83m+d7a4mJM2qFWMD2JsZpwPzbqzD6+uPGLnNbMu6u4PZ+XCAq31JCES9KPYHDQ1vXauTk9cFpIbF2xJFP9HcsVE4UiSaAKsbaN9gH7ZknpKtfo+UhQdY96DY7gcNI59T6EXLxSlZtSDIeE9jJo2+YOxk7WaT6WmkUNM+G+QtD61u+SzOhwZLCBdugxc7xkXWmc6Xgr53pmSZsEBgXtGwbFmHRINksKRGfCJ1BJGgiT8VGBpYmvmH1Uks9xuNV3FdOJ6+Siq975MVzcVyhzZPTWJSvEgQPmPLlP8/FVUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(44832011)(41300700001)(81166007)(336012)(426003)(40460700003)(40480700001)(356005)(5660300002)(1076003)(70206006)(26005)(8676002)(4326008)(8936002)(478600001)(54906003)(316002)(70586007)(36756003)(110136005)(6666004)(86362001)(2906002)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:31:03.0885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8870f880-447d-4011-0eb0-08dbd60645bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 Updated IP name and binding to axi-1wire-host and filenames to match  Comment pruning where operation obvious, additional comments where not  Unwrapped helper functions for register read/writes  Removed un-necessary device reset on fail to add device  Fixed duplicate clock disable in remove function  Move bus master structure to per instance  Improved hardware testing with multiple w1 instances

Add a host driver to support the AMD 1-Wire programmable logic IP block.
This block guarantees protocol timing for driving off-board devices such as thermal sensors, proms, etc.

Kris Chaplin (2):
  dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and
    MAINTAINERS entry
  w1: Add AXI 1-wire host driver for AMD programmable logic IP core

 .../bindings/w1/amd,axi-1wire-host.yaml       |  44 ++
 MAINTAINERS                                   |   8 +
 drivers/w1/masters/Kconfig                    |  11 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/amd_axi_w1.c               | 395 ++++++++++++++++++
 5 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
 create mode 100644 drivers/w1/masters/amd_axi_w1.c

-- 
2.42.GIT

