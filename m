Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FE811101
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbjLMMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378888AbjLMMVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:21:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E55CF;
        Wed, 13 Dec 2023 04:21:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJJQlSVmtR7ZMMySK0PjJjuVxcXidSxSxdQkdzW/gQK8uNlYbLphSpL1ZRq62kWp3Q3mMxhgDV8b9vobJMcGYFhvsvkZJDtIOccLdKQG/0DHCiXr+AnhK3Pp1w2/PeEkB6K1dYRVRo7gbZR6IxuriBALxxoYgEgf12szCJ7IqOrwNZ5botsAB7+wGdWg4c+1zDKBiRROmJe8w6e1VdDMOBnLAWyF3zLeOfdtznHBPAKA5PEbm/1xTjTNLuqcxeszyDPJRWBA5IBag2ciNDF6JG2Ul7oEf/weRS/hYHJCNlemsM8MsBd41vehT+7UKAct337hycPPoILQbflT3PEvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F+fwkli5ySzed5nng9i/+9HcEYwL9hkkpL5cGhqaQI=;
 b=PWZFmg9RU+0g0b8Pc73i/otOWYEQRgXm8DLYmGqMH+PmrXyjvenq+Ar/nNQWIiflXES5vdoVerTHDxWsXMRuu0ZKHoBYIW3pwUjr0K3qlVL18q8OzFjKqKzpWuvisBytyWkV3EIgHntBvDB26uWL6QFoFjkzLX668SuRWO6rW16MvOFA4FBU5TYdmi1cnMF+Zdr1rlztT2IZDSCn/KlJZG4QyN334iuzFCVu9npP2bSL3pLcI5ZQbVGir3jTPRs6YhioH1InmmEyUk34H3cEsM+UTIxg2Do+7xCMB3NaK0nUlLT3exgDcOj4ilszva7Jy2ETPvb7VXtP5i0SsYX+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+fwkli5ySzed5nng9i/+9HcEYwL9hkkpL5cGhqaQI=;
 b=CQhYnwhKumfwrjPxq2SC962XqlaiI5V7xvSpv/v4kogQWTwJMldMIrj8h7+7P7TK2cLWtnoPSxRkWkFNeW/ohOHfQLY/+rbqmn8FymBrLqN393ei53lJGRrnEAq56pXHMtI6w85GGxz4XW+6f5sHux6sLHd2OsL60SGrp2vF4QksVmF6J9TYE0Ys9qIlKe3lzqg4yNiBO1p4dwzo1BW9cRmhY9W2xJqTE0NYRLdR/pSsT0iKgOMJR9oEv2hUVWE+rVnvA6wq03myWzhIAb4XXX5t6BFVjpO9nlAGKRC6w6BOkk7IZ/8NcNJa40r47QuaxoNBOYtGM82zZfNCRG5r8A==
Received: from CY8PR10CA0028.namprd10.prod.outlook.com (2603:10b6:930:4b::18)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 12:21:07 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::8a) by CY8PR10CA0028.outlook.office365.com
 (2603:10b6:930:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 12:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 12:21:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 04:20:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Dec 2023 04:20:57 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 04:20:54 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH 1/5] dt-bindings: crypto: Add Tegra SE DT binding doc
Date:   Wed, 13 Dec 2023 17:50:26 +0530
Message-ID: <20231213122030.11734-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213122030.11734-1-akhilrajeev@nvidia.com>
References: <20231213122030.11734-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4074e96a-6571-45b8-e579-08dbfbd5fb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF6EmaByxpA4tYcE8SP7xoJr/208BMXjOCm80nTi2XkXcZjVbfy7W1a0LyrljEuqnR1oolN8z+2KoOMVnJmWp5h12Fk+Sjx65mAsl5Uo6kwFNgtZHBx9iPM281YnOaf5bK8YVX2KUbp3lcugtTg38TDCPlASJ7YfRIHpQ1N6sqkZhWsg38uxeyEJ6fKYbFGhYO+aJNPkm8RCZCGG+QzVlaxY8j5oBJNA/FYHTILHDplG/1TRTsxhJ5ugNY7q+dG+S+C94H8UBPRoYO+RuuJD6EfykhXTH026X/sVyFdaBil7Vh1oX1dx48IpHZdw5o+XdEVdL26kLIBHCmsypyU633DqKUKru5R3mGLnCmrCpStwsgL9Vvn/0KVL4utf+SDdLB2kuKQktMhtxdixbhcSPY4w8cWnFwmBeeHeJ/JC9qeHqnP3/QyGT5TQU65EzOs35CyqS5g+EGm3Zi85RXjzYPFQkIoTYtcDdMupGBwsvIvWE0Xzy7aJZplmM0/TmPe5p1OaSMFA7ic2vrMOnk4N3p5gOCZf6vSNwjNFkr+bgZxwY2/FqhfpYTv8nsCx7qgNznB3Pg0I3nlWW+duPV4B/YN3aUZtsbflC+xmqlyXZAwTXmNck+GDV6QezFYYH98UoC+yKolD1uzonopbk3GElX+5nLNuqRTg/XajZ6H4mi6bp0kPwCbPSjkeDTT/XwxyhTzytI5ySqGkBbDgfUbSNI9cKp8f/uY6iA7xzOQp3cLDW3KPDO5Eq46VFMSWbxrkdQlCK70HLv+tNVQxrARaK1t3tpbEfH4rypu9gwxWX5c=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(5660300002)(8676002)(4326008)(8936002)(2906002)(316002)(70586007)(110136005)(40460700003)(70206006)(36860700001)(47076005)(966005)(2616005)(107886003)(1076003)(478600001)(6666004)(356005)(336012)(426003)(36756003)(41300700001)(26005)(7636003)(83380400001)(86362001)(82740400003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:21:06.2945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4074e96a-6571-45b8-e579-08dbfbd5fb2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for Tegra Security Engine.
The AES and HASH algorithms are handled independently by separate
engines within the Security Engine. These engines are registered
as two separate crypto engine drivers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../crypto/nvidia,tegra234-se-aes.yaml        | 53 +++++++++++++++++++
 .../crypto/nvidia,tegra234-se-hash.yaml       | 53 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml

diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
new file mode 100644
index 000000000000..35c2e701bd42
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for AES algorithms
+
+description: |
+  The Tegra Security Engine accelerates the following AES encryption/decryption
+  algorithms.
+  AES-ECB, AES-CBC, AES-OFB, AES-XTS, AES-CTR, AES-GCM, AES-CCM, AES-CMAC
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se2-aes
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15820000 {
+        compatible = "nvidia,tegra234-se2-aes";
+        reg = <0x15820000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE1>;
+        dma-coherent;
+    };
+...
diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
new file mode 100644
index 000000000000..e3848e9a53b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-hash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for HASH algorithms
+
+description: |
+  The Tegra Security HASH Engine accelerates the following HASH functions.
+  SHA1, SHA224, SHA256, SHA384, SHA512, SHA3-224, SHA3-256, SHA3-384, SHA3-512
+  HMAC(SHA224), HMAC(SHA256), HMAC(SHA384), HMAC(SHA512)
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se4-hash
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15840000 {
+        compatible = "nvidia,tegra234-se4-hash";
+        reg = <0x15840000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE2>;
+        dma-coherent;
+    };
+...
-- 
2.17.1

