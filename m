Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756007C8215
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjJMJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjJMJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:31:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7ABBE;
        Fri, 13 Oct 2023 02:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHfC8dNCFOgl/aVYREahA91IH6/pGNj2UeIR7inWXIS4VPihxHff67jpo21Mkg8Sv3ICUz5UN9h/Bn6vHLzr+P4EN0jjgRKwokvVJWxS84EHl8zSgjfL6EPfNrD2tAEabX4cU3Y98cDCPQjiE4B1xW3Pm4A/c+b1kmLhsGSqn3Eo4kOYs/eqbax+nsOmOLoHtfhUtDR7KztLtUAdVyTdr+x4d3nSg6oiTs3QTZ7BWzZB8I7P2BJDrt1FBJicVlNNyM3fX/a2FD6HPeCynYd1G9f2KG21L4widHSOzvHXVLfNsFHD2hUhcDVXslgoSoRMBRw8q7lQEzBADJtd0QU3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX7zrHpZICgkYz2ipg5F0EBl3fQ3AA2GrgujCX7fTC0=;
 b=GTC6/OUv0rrNkYVm0dseSjjDtkCoA/vSihUI4zXjg3fAJwZWeD1UeqBxRn1EQru56s3fxQ1hDLK81ECjCOECq9aUk9jccKom1tLBx8tfN9yyzmCex61WBlaGJKgyQztZVBZH4q9+CVcqtsGDhQmop4TyQh69X9hjttOlDHGWxiNT9WlvGbFOsMUENGS+FUYdEanOuMfjfb8yEvUlK8lglvSKScLVDWiIKeGA6WbutxBdFzjauKxkVkuhAEwGZ0JLdPf5bysnpmToQM5GIRdpCwNGsSTS1HoYp13WCxPNNcDGCyd5GGVxTpvAXxnHg8hITUvis8bU2EiSuFZaXZiS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX7zrHpZICgkYz2ipg5F0EBl3fQ3AA2GrgujCX7fTC0=;
 b=U5zaF3Ly/RFRY9g4ZWGAHpzLh72xMvidZpmcJdFd7tQ/OO4CP3m7YWD66yuBaVkRc0KK0mGw9Pht3jpg+Qn65OOtAn3L41N3Sk6x7GWUjHV6acYnhO1FHseR7R4IJ/otqHEn6QJPCt1QI+X9j339K8am4cgPPnnj/3RskY9knf0=
Received: from MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:31:31 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::26) by MW2PR16CA0045.outlook.office365.com
 (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Fri, 13 Oct 2023 09:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 09:31:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 04:31:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 02:31:29 -0700
Received: from xsjapps55.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 04:31:28 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master and MAINTAINERS entry
Date:   Fri, 13 Oct 2023 02:30:12 -0700
Message-ID: <20231013093109.37165-2-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231013093109.37165-1-kris.chaplin@amd.com>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2a0f81-407f-461e-b4e4-08dbcbcf2eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxjiVcrfU5o4x3rnq8locK6ep3OSTJ5EQ1ZNKWpA//8amdsTzV6q1VYIFD8thV3d+nkxF2BVKMVTxJxbbTyh8oc1Bh/YSzbxNxfcqxzZRUWRilyB8WaRCaXyHgBDZ+0cjxrUsJrnfTHYLwA1h9Qs59WOsxzDCElEBI8x5yjuJhpSvTY/bMsYYTzt7fRiP1hFBIsWXPZ67Oz6Be1r6+hDO7rLkTQ7i1Q9e+QfsRdJKqizrzOhYvEtlpCbkn/OBKlBE7+rQGTUvic6Nv0Jbp8l2pVTmn/jdvGomauSqOttLT/EOUmH/Dm038MseS7Hoqr1IMXFVk0zycAfPFAxFCRHSb65qgfQkCXykwbGk9sD4RUApbWC5u2ZPEIKN7yBSq1aL0gX174rlAWHj6OgaJ7I75HiPK2K6A0D6lBMrCuYDanmi5wLbiudbZ9oPV1iwxd69RAaioUoWWBlGp8z9JczQejHTBEDm9FML4lFPW+CRpJBu9jtdWicDBB/BiPd8fbTHuzehnmzRzrZEuKpKSkjjWS2HTXmEUjPXP9g9viGeumFAD/Fguq9KxFJm+TG/ncwVy9bwav0hNLNN2BsvfxiXfjLNkOYi1ze580b6DulnXWB7UeIEFc5v4pqftvhl2m0G/Tz7dysLizre0nVm/viam/Ob0A+kK9MRxM7RhdSWrOdYo6Q8BoKPufxZqf19MKio6qGxKr2oSWASAqvY8hjua6epA4aose5mg6tvGt+0tUS9R/yb6sDPK5dICo40g4CyDzr/V/FYuhwoAWjuhQMfGSDSNfp2NFkrg05hYH/R8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(966005)(478600001)(70586007)(70206006)(6666004)(110136005)(82740400003)(47076005)(86362001)(81166007)(54906003)(83380400001)(36860700001)(26005)(316002)(2616005)(1076003)(336012)(426003)(36756003)(2906002)(5660300002)(356005)(44832011)(8936002)(8676002)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:31:30.8517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a0f81-407f-461e-b4e4-08dbcbcf2eff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT Schema for the AMD w1 master IP.

This hardware guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc using the 1wire protocol.

Add MAINTAINERS entry for DT Schema.

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
---
 .../bindings/w1/amd,axi-1wire-master.yaml     | 44 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml

diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
new file mode 100644
index 000000000000..41f7294a84a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/amd,axi-1wire-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD AXI 1-wire bus master for Programmable Logic
+
+maintainers:
+  - Kris Chaplin <kris.chaplin@amd.com>
+
+properties:
+  compatible:
+    const: amd,axi-1wire-master
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    onewire@a0000000 {
+        compatible = "amd,axi-1wire-master";
+        reg = <0xa0000000 0x10000>;
+        clocks = <&zynqmp_clk 0x47>;
+        interrupts = <GIC_SPI 0x59 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b2c378b4fd9..6ec3922b256e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1066,6 +1066,13 @@ M:	Sanjay R Mehta <sanju.mehta@amd.com>
 S:	Maintained
 F:	drivers/spi/spi-amd.c
 
+AMD W1 DRIVER
+M:	Kris Chaplin <kris.chaplin@amd.com>
+R:	Thomas Delev <thomas.delev@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
+
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
 L:	netdev@vger.kernel.org
-- 
2.42.GIT

