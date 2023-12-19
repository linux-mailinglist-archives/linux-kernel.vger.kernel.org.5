Return-Path: <linux-kernel+bounces-5220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD281881E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B63B2513F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DC18C32;
	Tue, 19 Dec 2023 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpnU1/zM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AB18650;
	Tue, 19 Dec 2023 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy1UWiB+WEi0oGeZjvKyYdfSO7+ggDywmOFOlFin+AeTy/9Bduq5kgx3oZCsJaOJeUuz/OkqHYhZjccqjh6zE9JLDlpnBUoGojaMPB0qLKj6Yd3zxUzK8lvHGol2BuSC2Xxg7Mcpuj21FCmcYSljr1Muu1S9otstwtFzv2fuX5ov1c3DB4WeZv0n+WCXxGOx3ehKXUfhnKOpyFBK8OdFCpYiXRzYeL1hvWXrAciSOtSSXA/W7X8G+ePEyl7lKu+OSjRFWbvKY7EQm3ys3pmv6sATL5DFQ5G+RTLn3B7OjzKaNPE4hbwjhfYAANsFVpwnXesPwD42pPRGU3E2v9NJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F+fwkli5ySzed5nng9i/+9HcEYwL9hkkpL5cGhqaQI=;
 b=esSAhEyW0fiIuxAyQSX6M2rPQgeTwl1OMVwZK2hFWIcchRE3m1WqEU/mXOOWZ/rJh5GGGF5KkdPfJtVHinkeYPGnNjtLV6cyI3dPS+fRX81jXX+6GEN4ZqTobNL0RxkhS97QFn2TBFjaKznO/+8bbIat8UpDN3U7OlZVOFBBN/RfaZ4k3l6QZFcOGTOVXkkk4G/z6ItEOrkVoTTZrhOLxVIFiDg14PKPpZuxX2pMprxybespESeArLe/M5SiF64pqHAK0+AP6MpyXOc3KHIB7+f4OM9Rf6X6pG60PqE5Qv1RMUFEPAQBaToWrVwoxUVBCkiZJUboZN1JZkcecC6tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+fwkli5ySzed5nng9i/+9HcEYwL9hkkpL5cGhqaQI=;
 b=kpnU1/zM41o0gt2soBHLG0RgtiZISzlW/r5ZkJyoSIb7H3aVr9Eu3lYvi2tz2LlvvNDNQfCcWl6cR22O1dLKQEac3P1zVX9jLXwNRl3bTTmtlH7m5pLRRL3lA90I0uz2OL6OhPFl8legOPLwhHO5xm3hYVVxTICA8hyINTgCTVIH+9xn57JdW5KszzriNRnt4KPU/cnlAG1ZH6mGqXLW2lICLXt/WS6ZxzfeRQzTZeqxynSmXIa70wKrXQ73mBx2f3TGt9ud9MTDrluuHSBmnXiwGvyVAJPWx8V29vZNfJHnjJLaa6qvC8Tjf5l14J4J0NldoOn3gzZVTjhGHUdg3A==
Received: from CY8PR11CA0005.namprd11.prod.outlook.com (2603:10b6:930:48::18)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:56:52 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::d5) by CY8PR11CA0005.outlook.office365.com
 (2603:10b6:930:48::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 12:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:56:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 04:56:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 04:56:48 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 04:56:44 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/5] dt-bindings: crypto: Add Tegra Security Engine
Date: Tue, 19 Dec 2023 18:26:10 +0530
Message-ID: <20231219125614.33062-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219125614.33062-1-akhilrajeev@nvidia.com>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: f7edfcd8-e0d1-4625-2828-08dc0091f818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5way4xjrEP7+sil4Uwui/da9+/aZpHujWAnqVRs6ER21/aSRdN5OLBNsaOP2rL+sIMEZbaxaQkeDotA4/a2hcs8Fhivg3LgUU9Z1QWV2oIs/zkCC1NqlEN/6IsV+WKw7PmmD6ONdOmySPmA9WhE8IwsoNuaIY7RdIHPWvvEMIBu8IEB0BMUxgD2HtageJ8QGl20kTnVqNUh+Wz2NdgzLwVvsISLIcJl8DeipSYoS75DJgyzlqZ73kfVMuYppQdr5iN5lesS4Vg/v76mIPr6itAsNh4vGAjKNzr+vCrZgAxL+o7EviwujRMVejwh1JFayU0EVzGz8ZrZIKANK2pzg9Wj3iLjwkRPkjBAoK3KTxPv0JvxZWS0WB0haErTyf4Cri7HDRB0+DD7Ru9rGwdfJ2wIWcI8/qunpFtE1zRRa6m+YiWpavLkIEVbSAc/mRvCwN7XAKgJr86rG2O9b12k5zuAL66B8VZZl9qo1zmApWX62Ag+vBcy5P8iIgYkeY0u7lRefPAThaQpt70dzSsjxCJ30La6VqTxFawstiN6pVccJnMjQOsSkZFNxJsvSTorkyI/gLCOoMoAypQumHrYp7r7t5ST2G6dxoAy8wa1lATHgNSMJJiG9XpPgfAY3VRWgFTgWwYEbtIgKCjuPHIggqjpmSYAAkg4N3GsaTD82UfIkjP9lQz/g0U9YzvfzxFSl74pLI2QxIPawxnPd8NR5BfM5elY88uVnEGzR0RJCh5D+MtTMxFdoc8SQafzcXDQuGsw5DQebyVUmJZq9R2zWuFq3WPqz8ore7fC7g50fHfA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(921008)(316002)(83380400001)(40480700001)(7416002)(426003)(336012)(70586007)(110136005)(70206006)(2906002)(15650500001)(4326008)(47076005)(8676002)(5660300002)(36860700001)(7696005)(6666004)(8936002)(107886003)(86362001)(1076003)(966005)(478600001)(2616005)(26005)(41300700001)(82740400003)(7636003)(40460700003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:56:51.1420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7edfcd8-e0d1-4625-2828-08dc0091f818
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

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


