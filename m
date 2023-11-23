Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889697F58CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjKWHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:03:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DF83;
        Wed, 22 Nov 2023 23:03:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8gbAVNV2UnQagJViJgEMHYCtl56GBEa/mwar5hLCg0uVcV0uj5s/lvn7rd3jL4KnQrGzSXzxyRiA/BjSElAt6u3nhQzsNpeG80KVZCJXW8MHZacaXMSplSNTjj2/pt/ETMq69BOIndlkZeMZM2LvW6rGtZsyU5SlKeVMt34bCwSl2tKg/Ht1eLIjVeLMGX7ITRMONlQXEQ4yKIt7m/bi22wfStyQlS5on8SqI++MLv4DckIUu7LXXVs65iNqMLdZ52VGWRatgeHS/rkbGxDaQcKsggVap27ghrYznWrYZZsBWrCmvu6ICMZf6nu7o3+Hz+dcM48LiMALmZNnfE/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJCvTv7g7IRRtyUu6v74+tMPZzuHDbeVWTOEj7JuNnw=;
 b=GaWUFDpYj0UX6WDAQqLO1NbNUZCIko1I8m2n4ppxsKBoUVrfDgk+u1l1gZ1+D0Hd4KCz0XDDveeQQ3PL5yz9Guj77017LwbzAgKXWE9Ig9C75eZN0FExYDkjwdorkMOgaC8xuzXQ9lGvuVTKLl6yzavzg8/T4p+ZMMUcvRstfJuz/WI1ghpFMIK8AHdT0OR2wORlzxpmhN9pJi7jQsfg6+E2M1gtDfMSRH05fiDq+i42WOmWiphVpt+/lnJ4ICBMc04ZLlaINkHCHABybVP/2M7rHh5xqM/ruX4xqsMF3mZVgMBn5UfcWCUw3sJNgDUt0Rdwu1U6ODC9VV69jdhiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJCvTv7g7IRRtyUu6v74+tMPZzuHDbeVWTOEj7JuNnw=;
 b=Bg5ylAQtckn0OJoGm2QAaJ3u7k2WVy8xI7UTHDr37uVcRK2twv+Aq20ycBcjP+yHOD8f+oBEEaqmEGXA1rvUptyRWZHRSrHW5g3bQBad4g9JR9WHL5UqfT2fGMbn4uvUCvJ8O9r8iqC3VIw3yb1o6Xz+Msy0kMIN0z8/Ry3S03Y=
Received: from CY5PR15CA0202.namprd15.prod.outlook.com (2603:10b6:930:82::17)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 07:03:15 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::7e) by CY5PR15CA0202.outlook.office365.com
 (2603:10b6:930:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 07:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.20 via Frontend Transport; Thu, 23 Nov 2023 07:03:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 01:02:34 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from arm to soc
Date:   Thu, 23 Nov 2023 08:02:27 +0100
Message-ID: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356; i=michal.simek@amd.com; h=from:subject:message-id; bh=Y7ul9phu2Zi+pjjgIT8veVQSgqw5wCbcQnQJzUeZTSg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS4H/8Wn7i2OT164eqY2VVVwVt2NdyfJsrsksfE5TzDX e4Va0xBRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhITQHDbJZ78/leB+WI5zvk MHmt9BLPvPIlkWGegSzrxnqTri1K4SeNOJyUtxmaP8gEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5272d39e-70a0-4ad8-8e91-08dbebf243eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPWgA+AKpvzgtk6Se+zG+VTTRSMSWn1NlVTWxMmY0ndnPjsqERb9DJuvc2aAPVOnvND/brAtwllBLUtfYsOfXDVVF4/TsHLIzgrdk8y9tTGqw9tFPCp9lje2VSlWsKSs2+i7u+FRI1quZYsIe0YYXfCgXOjgtO9VfMMxBfkh/94hl2SFVPA+2rPCO3HEkARxSCUCjmLBQDGw21elvW0G+YplOCuHZoXqjImsR4LuVdFZ5OrshQI9qI2DT81tnYW5oglfxNhpBOAOQOUWL0iilWSiXTysOCkmLVdA6Ed+0FkyNanZiVHc7GlANuWR8oTjFvs567WqDyWFFW9mDDFkj4syyOY1M1tmvBTeOoulGOK+aZo2TJ9HojB3st02X+obK1h80wsaPXFZucBdpCffuWkUXuWDm+CV6s2iZFJ8YztHzbyqDh7n8j9Yz6hzwI1CEE7rL1I2ZhelsyQf1vPtTcDi39QjL53c1IDjKQOY3hsr2t3oqrRltamHg/JbXjHQxO7h9LxeeTXRpNDejiVPovUpC9YzjVWYioYLR+tbBYqTh5V/Doe+uqY03UVNdW63WZJ+xVlRV3FjeGj0jexCGGl4CEbDbCFBonXaMz5KA/1nJRJzvTQIOxN3nVYhwJpz/sP9hVGXRpO74+MSnM9J3RKT7bu+UCHXpvtrptjxve5+o8ZRc5Wg9crrgg1A2rnqyFC4x1z9xuZAJTfDJq8ClzVBNQYjQ6T2Ph4Pof54vLqo9i0cLJSsRedr1R0L5cANBgoLCwbCf960di+MB9eYUAysU9KNiMkJqe5hiQ4ppParxV6DsjqA+ICd8dQCpCAq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(966005)(6666004)(2906002)(40460700003)(478600001)(4326008)(8676002)(8936002)(44832011)(54906003)(316002)(70206006)(70586007)(110136005)(86362001)(356005)(41300700001)(81166007)(83380400001)(40480700001)(36860700001)(47076005)(82740400003)(26005)(16526019)(426003)(336012)(36756003)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 07:03:15.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5272d39e-70a0-4ad8-8e91-08dbebf243eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Xilinx boards can hosts also soft core CPUs like MicroBlaze or
MicroBlaze V (RISC-V ISA) that's why move boards description from arm
folder to soc folder.
Similar change was done for Renesas by commit c27ce08b806d ("dt-bindings:
soc: renesas: Move renesas.yaml from arm to soc").

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v4:
- s/chagne/change/ in commit message
- Fix binding location

Changes in v3:
- Fix commit message reported by Krzysztof and add his ACK

Changes in v2:
- New patch in the series

Based on discussion here.
https://lore.kernel.org/r/20231108-copper-scoff-b4de5febb954@spud

---
 .../devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml         | 2 +-
 MAINTAINERS                                                     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml (98%)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/arm/xilinx.yaml
rename to Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index f57ed0347894..95758deca325 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/xilinx.yaml#
+$id: http://devicetree.org/schemas/soc/xilinx/xilinx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xilinx Zynq Platforms
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..14ad00009a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3020,6 +3020,7 @@ F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
+F:	Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
 F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.36.1

