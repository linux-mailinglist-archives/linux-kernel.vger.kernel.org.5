Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A876E12D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHCHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHCHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:23:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4172728;
        Thu,  3 Aug 2023 00:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDcXvSeVnzgY7PLF8MYDWtwvmZ40aU0LJrdC6Sdy6tokowg05wHSpOICjt4i9t09tsbMNDx3ohG9lkik1mYQ839PVIAEcq+CnqWhITW7vt96RMhwP/i1o27W/coXzfY56XjCOEHicwH20yiAljyijvlPeVmzcemfUm/565x1ilF6iq+F1616fbrPcBnwXupJVXIGwpTWilRE4OFIqUIlwphXyc85sbjXnX2Vg2cWp5kfO2hIyYicv/rfHaugBtI/XDmHeSLNnoEecmh3HcXxL3LljBG5FjkoxtIqd5mggWSEl8b+gx5HGmAq2abHtQGgLpE/K9sx2Y6JrKGnKUDsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/u4/ZHL9cnzdbRUxyhGgVqTkVbUQ95aL/FCi8ciTM0=;
 b=biOZwN0GuMfzJyUGfeZVLasgAaU1wRX9VYfU3Eby6EqFRc5wb/GeJ2dzxovTKyZ5LEXn3hMn5U3aGRktkswYK854vYlvlcKf/kPFreVs9lOehEFx5ryzVWK1Hy9d+8H06v+S7EjH+X6f5jNA/sKhnuvRaSy69lA319a/WORn3e95uyNGXJfqGpsdjcQJrwExYzQcTnIrTYf/39NzRuus6yTR/sofSOB7MCbbejOtV9StTj4SGZ3eIWxKMiAqqybfNVB5dqJll4r4LyMGjgJJvRCqH2xAf9/EFbOtUZWCoHAY3IL+nquMqdhmYLimplhDH0yBwPmAQArL2HDyEEDQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/u4/ZHL9cnzdbRUxyhGgVqTkVbUQ95aL/FCi8ciTM0=;
 b=0Moxgk3yaLyPYxX8CF214+3/Kd82PvG7RxUMNqkaJzyKe1rXVlcN/vCHJm5BhkryDWYx41wnY1VGjSLfZMytgCkK72PitCYunaOhhYQ+N925Y3YMgJ7pV5iZVH0KpVJ/u10keWpJouylZ4Kkgp/DSMxHC/PmSZ12cLEyGhuIILI=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:23:01 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4c) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Thu, 3 Aug 2023 07:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 07:23:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 02:22:59 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: arasan,sdci: Add power-domains and iommus properties
Date:   Thu, 3 Aug 2023 09:22:56 +0200
Message-ID: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=michal.simek@amd.com; h=from:subject:message-id; bh=QETIvgX3V57/dkLvgnSJujEXcaw0ufXCBLRrEW5vXcQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTToae1BJTFfoanLSu5Of3P24DNPNM/9fOI8zod5fo0Q cGSJU+2I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkwgeGBZNnbt1tv+zO/F17 pi9O/uw0qdPL4DDDPK0fiv53rqzOLGfZNPPYzR8hPWl5dwE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c739760-4963-4200-1c1c-08db93f27889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KlGrPjC+uhwxzoJoM2aY3jIJRKhwFoT59FrmB82x4faB0g8F5vmlHzLskzRWp5Z1QdgmC5MqgkWIerCybuWKD67ZksG8MrOTJ/kpWPztTMfvM6GWLzxVmehYGbl4HZZ+HDMRx6vID1EC5cZiJGR9sIKIF09GvYkNmah1nmOe2JUEb2NhRWnleygXNQBGFiFrZGCXJOs5TX7z/2Fjfw6NzY7gc1ilkoMEXLeYkg5e0pu8Pws1esKD7LnRGsBoBgMUxlLq9q9E8iwspCvVgJihZNMtOS0oP3FgMHWtuSugAk7bu9duEB+V2zuvB7huWRhRLz1bPBN6hcAY+mgbVP5ZBYEzvAdQzwW3edv6HuintHHMQgB9OH9SBIMGuAXmoOWiBJX6KW+2JbetYuWK4BsBUzfOUCjfzTrtKFipWF1Hduyq4O7RgATmxyEo0zLwZ+nciCY0tCspnKA0qQT8Lm592i3nvYASGkg8vHZXQ49bKDyQeg8HgGBluMKU0A8JT8E6lBnLIk/QP69ozeECUnorvrWT/ru9rAHY5MZqZMQ8TQwQoXLOBKE5mjWL/IQUcz7m+wCdAI9zay5uQ4A2jXkLFHQtiWPNtbSyMsvrbDeDyaxyoHzpd8XeXtL2Ock/vENjQyxPL6tJ2LFLwdpA13oeJy+GyuRIU+qZdbkaRju80n3seCUUSU/m3WRsc7x6LSCUFBLnXPhR8XZeuu5Ek1xs8kSpPFck+EW3anDOj7jjWNpAsXmNNP0aCJ7ak71LTJC4JHH3XB5bK1LvNMYOq2+X7n3oPVstGBSEP+gqNcRM/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(82740400003)(36756003)(86362001)(16526019)(40460700003)(40480700001)(478600001)(54906003)(110136005)(356005)(81166007)(47076005)(336012)(426003)(2616005)(83380400001)(186003)(26005)(41300700001)(8676002)(8936002)(7416002)(44832011)(6666004)(316002)(36860700001)(4744005)(5660300002)(4326008)(70206006)(70586007)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:23:01.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c739760-4963-4200-1c1c-08db93f27889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP SDHCI Arasan IP core has own power domain and also iommu ID that's
why describe optional power-domains and iommus properties.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index a6c19a6cc99e..3e99801f77d2 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -160,6 +160,12 @@ properties:
     description:
       The MIO bank number in which the command and data lines are configured.
 
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
 dependencies:
   '#clock-cells': [ clock-output-names ]
 
-- 
2.36.1

