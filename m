Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8777E21D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjHPNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbjHPNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:03:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7171BFB;
        Wed, 16 Aug 2023 06:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WigPJZX7K5AiPZRvlEcqBz4KOP/17hIF05bv0Maqx/WqyDp4E4UJ2lgns/k4NbYcWefo8wmP4UstA+fu3N9yatXAXPV940AnCf2bE2MKuZxzMvnm66AuXTzqHRvd7eQFdFp/tEbQ1OGUL7GMokH4wsavvWyxyNMElQ4Z+WXyFu3YrochCLnxYvKAConryK6dqH3/5Wl69zlc4n1gk2RwRZFlf6HK9L+UpM1riryBJLENciUInjHnX6yoV51NNk8Z4P+cbkdlZa6di9i9uksbS04+cee637TLeTPE/J0AIibyern73AHzSM0RhPZb/ymjlDyXu1WKNJuqUglBF8h7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYkocjOKlpt6A7J9xQ+CeuEm06ixB8N1Aj1Ncgj2NBU=;
 b=gd/QHPnELOve19MnPK9I4zr+6Tgj26QL+SBYe/xQthdpLGPmpobBb+b/8E2nlUNO7V6NxM7mdHK5SQu8n7zaqblphH25thRcNGxqNGsIydKacP5oeyGZBhIAvcI/bsxs+6s2EAObhoI4OwvX0evBf0rYR519KLT0DT+jJfrYuKeaNhwPjHjPChDaUu9U2Qs0ugzZnzudv0UHfYxapYRacz4LjzhNCRszNnRlS2gTDqH8x4oMZjilY+klWagKksev/zcUI+Xx3Egj8BGglTqwmo3sk9eQK7lMRlkqncl7VL5l6ygH586n691+4FmOPn3SwR11huugV0DyCtkGRIitag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYkocjOKlpt6A7J9xQ+CeuEm06ixB8N1Aj1Ncgj2NBU=;
 b=5PRTKz5Teg7He4jW48cIHE36nqxjyIC/OkXHaeM11Vvy3IJ+gziIy/AjheOE5Cyq3rMqP7Mwmjh5tKK3WtWb1s9V2HBQby2NoseNIWWGd5P6WKmpWEzl6dxJrR6H2bZAYiQXuOioAzsGhd4SecD3gLMdAK/WC7fsvCJCyX83lYQ=
Received: from SA0PR11CA0172.namprd11.prod.outlook.com (2603:10b6:806:1bb::27)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 13:03:42 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a6) by SA0PR11CA0172.outlook.office365.com
 (2603:10b6:806:1bb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 13:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 13:03:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 08:03:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 08:03:42 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 08:03:41 -0500
From:   Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <sebastian.reichel@collabora.com>,
        <naman.trivedimanojbhai@amd.com>, <jassisinghbrar@gmail.com>,
        <dlemoal@kernel.org>, <nava.kishore.manne@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: power: xilinx: merge zynqmp-genpd.txt with firmware binding
Date:   Wed, 16 Aug 2023 06:03:09 -0700
Message-ID: <20230816130309.1338446-1-naman.trivedimanojbhai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: a25aa52a-3370-44c6-5ded-08db9e5937c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOMqzssUkcXf6Ar+OCNAq4wObudJp47sfI5jCnSjnBu3tT3aDMgvm7RnEMILIV7t8nepEdwVTBwTGfeUgI6EYboTjLi50mqiVfHfEIDspdx8DAnG1HNZgT/crqtixVMJgo2aW5PG2CpmApkwF7jR1T6DUtLaGaQt+zsrobWbArXJHQksTigASo8ue8qDti7NmjpQCYmrMkSFb9i2d1j1Zb9tbK0EGTOSx5Rd82T+KUnVq2JiyoOVxqIRfCGnG6VwxI2vZSJt8Tg/3X6/zO5LdzABMzUI/YjDmI5hAA9hKz3dogahjyQ4SxU6jHdgWpyxIuYwETBchL9jmJqz7nc7FA/KhNLSnUCRB5pCWquQF0O/K2i0FfiFy669m44XxtSsLRgG2S9chxp44APDTzK1fAAqYeTvNU/XlW7ZoXC0QTxodBl1/VtoTCSnlkO3iq0e+EpngDMk2FhNRgCCKp2mi38d/fvwlqhpvmHCwMAgOMWxg9MQjeN6hQtvyf9y4daH6Lj8+YxX+QI2Vw49I5G3FUlFpluSLxaaJsQ+WrjcQGSRbrhftUVn3Or/pRcHECMS9P4xGeYuOdzMvhfqhe2/Z5yVVhAkG6NS/S+3iuyqzkssXeUZ2lo2p9t7gpYUlS8EONqC9AErg9F/JQ8hNhm+/nrIFvDqC5UfZhKa6zwuVYYZ9iQI3E2cIqURtLXaHzCg+YOJ8/70IFJZ1QeEc/iopR3E2r7SS93MlA3m3/tkE6c023D8qaKmk84ju1HfXKkxLMGkp/+ircm39XtR6tO9RP/V1YQx9GVVtTOp1Ucye8A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(921005)(356005)(82740400003)(81166007)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:03:42.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25aa52a-3370-44c6-5ded-08db9e5937c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the zynqmp-genpd.txt binding. Add the power-domain-cells
property from the zynqmp-genpd.txt binding to firmware binding.

Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 14 ++++++++
 .../bindings/power/xlnx,zynqmp-genpd.txt      | 34 -------------------
 2 files changed, 14 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 910bebe6cfa8..822864488dcb 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -38,6 +38,9 @@ properties:
       - smc
       - hvc
 
+  "#power-domain-cells":
+    const: 1
+
   versal_fpga:
     $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
     description: Compatible of the FPGA device.
@@ -66,6 +69,17 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    firmware {
+      zynqmp_firmware: zynqmp-firmware {
+        #power-domain-cells = <1>;
+        };
+    };
+
+    sata {
+      power-domains = <&zynqmp_firmware PD_SATA>;
+    };
+
     versal-firmware {
       compatible = "xlnx,versal-firmware";
       method = "smc";
diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
deleted file mode 100644
index 54b9f9d0f90f..000000000000
--- a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
+++ /dev/null
@@ -1,34 +0,0 @@
------------------------------------------------------------
-Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
------------------------------------------------------------
-The binding for zynqmp-power-controller follow the common
-generic PM domain binding[1].
-
-[1] Documentation/devicetree/bindings/power/power-domain.yaml
-
-== Zynq MPSoC Generic PM Domain Node ==
-
-Required property:
- - Below property should be in zynqmp-firmware node.
- - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
-
-Power domain ID indexes are mentioned in
-include/dt-bindings/power/xlnx-zynqmp-power.h.
-
--------
-Example
--------
-
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		...
-		#power-domain-cells = <1>;
-		...
-	};
-};
-
-sata {
-	...
-	power-domains = <&zynqmp_firmware 28>;
-	...
-};
-- 
2.25.1

