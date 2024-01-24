Return-Path: <linux-kernel+bounces-36644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E983A44E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B4D1C23596
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132AD17983;
	Wed, 24 Jan 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IdMD4VA2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA317980;
	Wed, 24 Jan 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085579; cv=fail; b=RjBw6bVuQuy1hOqFnXnB/k43oIXla3/f1MtuQ+gw8ASw4YMRuh5gin8VHQL5uOjW+r324cIdvfc7NuIA7eWvh8qLu4QpYPnIdYoUrzssS2GAiJt+HiyMn9qdX3qRYegb+fuQm0BXEWeTe4E9h9hssn6TpSh+eqyXZ5lRZ7edYmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085579; c=relaxed/simple;
	bh=VmZb5RSuWKxSXxYSkVaewVi1nzP2X/PIbBmVj15jG1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiGN5eXb9nL41ZoMtVAM5enusPtRVyt1It0Qy+ZmdLVZp/2mGvQXKAexg4r8CJQlto0gN5LSU+VW1OW7/GyXqi7mo6nyNzia7Fo62UqvvfHGbfcRWgFB9ctxGsiyJymaprAz7zSMDNEVmIxPa7bbzGlQs13swCt9IJTeMOUXsIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IdMD4VA2; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTq34OMqzydVHrUyWJkdckibWvrFLrFX8qKAc+l6SVSuEV5X1xnJjTo7Q/BhoEVPB540PMuBn1CvpGkkT1dC1kfz+DopksnGlfLKbi6Sfxim/SmDrW50IybjlFP0uR6kfJUSZQhiCvHpU94WJUJR5HNxEL29KgjKoQ3cdRqbJjRd5/UK4HJbcL+H2Y9DNc8PSsWw1yrKPdfFZ3ulAuKcPC/ZeWYzqqupxjYEZySvDUvcNibGeFEBzaCMRstlLnPRz6BFq0h7ZC0NIDYkY+uWrUs89v6+dzAHcF6FtsDWo+QZjIzdam26YbvludhfWb350Frd4LJn6yw/far88baekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtKa+pAc0nHoGbXoA61+cNlU07hVOAtVW4TUlVj7Ous=;
 b=W1qU+eZbgikiBdzzchTN+S5ejQAGEIL3Jw6wihqNn46K2bZmrk9MQccZKbcHYAG5VCs2T6guVDweeQKfyiSlMloBO71ain2fzClNqALToHEs/9S/qrvC0cGd9g/gYMh1LflwYrCIFmvNGd9dmxQvz8prwFC6ZdpzpPpX2OxAXB/hjM6zJFKZkhgibeCpMhRgkMeKMphK3WMT9HwOlcqpaC08/9dTkPditYvrhwRrjHRQFR2HTBw4zLnfirr5I6dFUUFwxn5HL6A5Jz1RrntuAuFZKub7ShajaxVdQdVmjYPtxekL3qz7/Ld8pTEAa1r5/NxTvN5gkRg1r53PyUJGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtKa+pAc0nHoGbXoA61+cNlU07hVOAtVW4TUlVj7Ous=;
 b=IdMD4VA26rCocozVe1npgC+/AUSdhFHfJHOaqzqeVKarMQPQXiZKUzNIqaLErlzykpLAW3dx3bEx8+9P/Zbv5SOXmuYwhqrlJAKp5F41UyGI56yfZCptkwgROE+yIW7MoGkOOWV+KGNJmku8NAG+hvkOMMJJgq0Hol8e11L2TMfjUKZSMdxEOYL8UqnK8soakWG3LlY5FSXkeWPn09WHJ6X5Jid8l3umUg4fY5Pcr9gmToinIINPvwmmKQMgvU5Z4v+dhnBogmlvyh5noh0N3Y7c5Hu/yrvGn6fAyqXLeKszL0Bm8BZ2SHcy3ztOGM9wEcDkPfl2Vnqj7W4PeagI4A==
Received: from SA9PR13CA0052.namprd13.prod.outlook.com (2603:10b6:806:22::27)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:39:33 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::2b) by SA9PR13CA0052.outlook.office365.com
 (2603:10b6:806:22::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Wed, 24 Jan 2024 08:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:39:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:19 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:18 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 00:39:14 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 1/5] dt-bindings: crypto: Add Tegra Security Engine
Date: Wed, 24 Jan 2024 14:08:42 +0530
Message-ID: <20240124083846.46487-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124083846.46487-1-akhilrajeev@nvidia.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e93aa9-4006-44d4-70fe-08dc1cb7fc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	spPARiRftWqfpOh6tUzAginYBgBtHMQfSMQPfqHhOMHeNRCyfrarD2oQYHwIxnKpkbmPPojmqYPG6ieH3HZrGuOp7cQ4inBtRJH2H15flWiFPOdPs97+47/FRnBhZoeVMuRChsAtoiU+7fBgP6DP5J7kZv8gXH1CvuDeAFig6q3Oj0tgh7Cc4T9oborzHbyL5h2Ff3TVLHQfC/VFCjykme1renW4JGBw40FDpEVqvtQDFUBKNPsiFPEOslvFKmdecIQ1SCvtM2Aqz6LskbJMwCHtxPQZ62HvmMLfuMX2u99snsj9ZcureXM01yxQQtd5+SeRBRNh4f3ivZq21etgIz4KIMWnm0bfpgKIwkbmbPQ4SxyBTUy2n/WFsEz2KtrF6T1oEhyIepu+AVEK8IYAB22gLQKhdrNcPGBCt/y2qQ31Upad41lviq0hOHlH0CkKSIYSl67BK8eYYKaWP50IbB4P1oBt0puQdurf2jO7u8EaZj6yW7TiYg+27pJW9cc50OVblh6i7f72m3PM+0xGpWD/ujjeW304V9rwbh8tdzRNBx0+XE+zWBcB8qoG3kR5w1sQJDmwiBCHjUsuhGF045pe7KYzIUWfih55tiakPd18usYLtmwk7/Rv7Q5mxp4mkgMA8e4lQMIBUS1B88KeYWqFJdhvOJqnjQNTSdKaQ6m53sGbl9qizVzoVFr176nNjHq0gtsbCx3sgGrc61Rijdc6Id9hISmKOltPQEQzeOhZc2C/7fiGaDoaPAiJNw30YlwXh8sRKfIhM6z7RksAdzuKFe9ggK6Pk1FBh3sYp/c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(15650500001)(7416002)(2906002)(5660300002)(356005)(36756003)(86362001)(478600001)(82740400003)(7636003)(966005)(2616005)(83380400001)(7696005)(26005)(426003)(47076005)(1076003)(336012)(107886003)(36860700001)(6666004)(316002)(4326008)(8936002)(8676002)(41300700001)(70206006)(70586007)(110136005)(921011)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:39:31.8469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e93aa9-4006-44d4-70fe-08dc1cb7fc72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922

Add DT binding document for Tegra Security Engine.
The AES and HASH algorithms are handled independently by separate
engines within the Security Engine. These engines are registered
as two separate crypto engine drivers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../crypto/nvidia,tegra234-se-aes.yaml        | 52 +++++++++++++++++++
 .../crypto/nvidia,tegra234-se-hash.yaml       | 52 +++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml

diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
new file mode 100644
index 000000000000..cb47ae2889b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for AES algorithms
+
+description:
+  The Tegra Security Engine accelerates the following AES encryption/decryption
+  algorithms - AES-ECB, AES-CBC, AES-OFB, AES-XTS, AES-CTR, AES-GCM, AES-CCM,
+  AES-CMAC
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se-aes
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
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15820000 {
+        compatible = "nvidia,tegra234-se-aes";
+        reg = <0x15820000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE1>;
+        dma-coherent;
+    };
+...
diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
new file mode 100644
index 000000000000..f57ef10645e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-hash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for HASH algorithms
+
+description:
+  The Tegra Security HASH Engine accelerates the following HASH functions -
+  SHA1, SHA224, SHA256, SHA384, SHA512, SHA3-224, SHA3-256, SHA3-384, SHA3-512
+  HMAC(SHA224), HMAC(SHA256), HMAC(SHA384), HMAC(SHA512)
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se-hash
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
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15840000 {
+        compatible = "nvidia,tegra234-se-hash";
+        reg = <0x15840000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE2>;
+        dma-coherent;
+    };
+...
-- 
2.17.1


