Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40A57D7F93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjJZJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJZJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:31:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F01B3;
        Thu, 26 Oct 2023 02:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA2aKw0xBYvnnwX4PGpHFc5afaepYe+ETXkC0T24LNRs3V7QjdBeSzBVgEwoSiKjHVXd/UffKbWMdBYesbHeu2TEoyJfefRxGcRHKxlicwu1liv51JM9aAnGiIDe+gi0EfW7HMeD9dvbJcQYTbByGOsbFXqivedxW4leQufW9xVJD0AnxiqKesfJIyF/pBig01INKRrYsTaJld5LpuyYdB9rErw5T2EH7FQJ/1VbA95Z6Vi3+g7mGbmd85qyT3VSbC77poCujVSFhm1r2fEy8gjZehUyW63Geqyv+3yrkBLneick7skYp24b3kVuaRIkAKkEp+GqBY0B6H73NXVgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqy1+QTZyYLaaDxLaviw8xElaRM4FXdntpt34FsfIy0=;
 b=WSta14QbuWhxO8Jgzf8g1P5VaOHsSAgBvdaY1kcfZxebGtYj1ZfvK8r9VvQFuTRqy8ihcgeykfVzaeYXOjSAtNDLKsE10D2FgwM+Rvx2H2b1gKAlvw63NpH4fqmrsZgV4zPci4aVodLDwARLCJ80ovdTLBNd+XNyq4urfsNj28IRXltEdOZhsV7rbDz++CaLv63fqKG7tCMQzW9lQ4Zffz3Uvm7qG6k/kQrgToyg5LNaFGn+cLCWRyL4bwjE1kVpQiupOyEop+TPi6k6s6WFGEruPpQUzCmyvcrBbpe0oouO+ISEU4Imtu9hMt3Ncc0Mi7dlVCv0VQyoawJKbWE9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqy1+QTZyYLaaDxLaviw8xElaRM4FXdntpt34FsfIy0=;
 b=qe9/p96mw2EC20my48i2Z8YBrSUtUEDrT0T1ll+cFbphYe0HylK/t5LyB1/AB2UvZO95JnxBg8GSRbRF3fIpTlZwgwhTfkbqhuparqBLI1jfS6/lBZn9Sd/dBLrahyrH+xNrex+qoibn+fQASWC/IfBOIY05HJzKRCtJ6tzXayg=
Received: from DS7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:8:54::7) by
 IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 09:31:15 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::5a) by DS7PR06CA0039.outlook.office365.com
 (2603:10b6:8:54::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 09:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Thu, 26 Oct 2023 09:31:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 04:31:14 -0500
Received: from xsjapps58.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 04:31:13 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RESEND v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and MAINTAINERS entry
Date:   Thu, 26 Oct 2023 02:28:41 -0700
Message-ID: <20231026093029.3122573-2-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231026093029.3122573-1-kris.chaplin@amd.com>
References: <20231026093029.3122573-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f5e10f-2547-4ee0-3075-08dbd6064cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqlZzIjl0rcm6OwN22b+hZG/hSittneyVn+7ws7MiP2T8+eOvhBKzj5jMOYlqoUFeaR6Kvpa46JweBYtF/kSk2oVJNmeqh/sKxcBXZ4qrJmJpQ0n3g57dFssRZHwg5zjjrHQfEAZlpG7J8usVBOk5nFP/ZukYhKOtLI38byCJ8HxOYBz0ivx+/OOiP4yG/MEeXW7GGoQquq7dTFgwlarklffRGub73a1Y/Y1bc9OZy1Vlis/MYgjKO3cG9NqJSCE3H4/ZxUHi0RHvIJuktKXn7lWCx2CtEkwIPA1yRszJddJQBWK7NFzeJUIwsnSJ/U3IRCCIFRF/L9rJm3jHYI1YrhW1yD+upQ+L90nUYFzpylKwPFwLgDwSzxvgQeI+XDqiIfuJllAykgIhjWoB4XUDQUeh/e5B3IWtb6w4WVM0QhdSWjgCo/+AcHn2ybsbpZGq4EJ7brdXDke7V8JDCoJu5KbtjrMRswIAzd7dJ/xMlmD42BEV5TB4v/+imcDx2gQru7Odpl7tVD7FdFqvU8+HiRfjHhi871VZ2urNDugxGkvRXB5+UME3yAIpfLth5VnPAZKwbe1PoaTR+1B2rAeqfmXz922Xzyq+ycx7K2S351MUYU/xuxUpHurIM6Pibfit1YNWkL8LUX/g4vNoFAzovSuwV5/1IL2CBKty4z22MdsbV4wRQQHVB8xFYhSWoctG4aOlrDlK4+yOrnwzB6B6MPnrvzSEghfEJJu9jytXYIVFxM2XIFm3gvRDlCM7mz8RW8kFFIwxTGe6wKtG8jya4lCi4GAMsUGYmOKOfkylLzrYZ0L6P/LiSOWko129X/kMmRakoUnJ50BSfCq5tSo5SP+XsaAJ8KWBLTjdKAvTek=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(54906003)(86362001)(40460700003)(40480700001)(2616005)(47076005)(5660300002)(1076003)(4326008)(44832011)(81166007)(2906002)(82740400003)(83380400001)(426003)(356005)(26005)(336012)(36860700001)(8936002)(8676002)(36756003)(6666004)(966005)(41300700001)(70586007)(316002)(70206006)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:31:15.1626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f5e10f-2547-4ee0-3075-08dbd6064cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT schema for the AMD AXI w1 host IP.

This hardware guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc using the 1wire protocol.

Add MAINTAINERS entry for DT schema.

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
---
 .../bindings/w1/amd,axi-1wire-host.yaml       | 44 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml

diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
new file mode 100644
index 000000000000..ef70fa2c0c5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/amd,axi-1wire-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD AXI 1-wire bus host for programmable logic
+
+maintainers:
+  - Kris Chaplin <kris.chaplin@amd.com>
+
+properties:
+  compatible:
+    const: amd,axi-1wire-host
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
+        compatible = "amd,axi-1wire-host";
+        reg = <0xa0000000 0x10000>;
+        clocks = <&zynqmp_clk 0x47>;
+        interrupts = <GIC_SPI 0x59 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..3dacb7ed6e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,6 +890,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD AXI W1 DRIVER
+M:	Kris Chaplin <kris.chaplin@amd.com>
+R:	Thomas Delev <thomas.delev@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
+
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
-- 
2.42.GIT

