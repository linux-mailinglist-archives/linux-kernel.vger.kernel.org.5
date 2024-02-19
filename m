Return-Path: <linux-kernel+bounces-71754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C885A9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5D4289454
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5B27714;
	Mon, 19 Feb 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQ2r+iNf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728E44C97;
	Mon, 19 Feb 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363589; cv=fail; b=SJI6HyoCtoKoqH2UXYhIMhUZTQJDFCU10CfY8asOgJ/BpKtw8CBxekJC0WpTwrWVCrxwAiCjMdaLUlfvjEOnpnv4Z60TUhwvUqcTS6EBdr7RKix9f/JqyjEW+Wyqd6nOaOPXOdjn3ade8DFDD6bNdlOGVPhh3FP6mwNNUF8xojQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363589; c=relaxed/simple;
	bh=VmZb5RSuWKxSXxYSkVaewVi1nzP2X/PIbBmVj15jG1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCzLLGJz7hvyoAJYim6s95rD0Sd0E0IyKDUsIruWihEsofUYqdbew2OAUYISxRun2EQMYRhX679doaMeuzLmWBMzDOxFuuP3k9lB6wZ0IBAQuyWb3GpDRGhszMIQP1nCY/Q7tMN+Y3/usk81tPU38q/C78GEg1udKAe822xFdlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQ2r+iNf; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6nSXpEhJ+/enOvKmQD/zsvOel/77p5sDSKOa2kvjeY2wkS7/04XaGQA9nM7AuyTqzbBeciEyDLb0JZnf2Zy0SyMOx9GhBPk6waR9h63ifmdmtrHGEFn2sgdkvG11RYaBQGgr+x7AD6wgzNXn7C9/LMxsSZ22Zc7plo0TnyKIp0+sFIo16w1v5pmw3v2hu/XSFcX0S4qRLBo0hSxeOJjdQyn50+rKRaCtIVivCNvPOhcgaYYwlqRJen7YKWMzW0Wnu+o/FXGuYmmdCVG63AudThXhSk5tUmbnn+oSzvNztwsabhS50DNWMVqEVR7ahez6epvv5IYP1yXGn7IJ0ZH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtKa+pAc0nHoGbXoA61+cNlU07hVOAtVW4TUlVj7Ous=;
 b=hFVV7Sxgn58iCogzNf4vO+Gd2diTFyrL8mKF+4YJyv8upTKjPvoYsif/l+OxMUKsJXi+yX9GHn3tasP/6OLUtW2eg7mPBmtDx+kRYStjIg35MkZCYWYt1LxnloUu5pbMozdVInv/+6zzzto5+oujR5IHKFwMygxzeaYJCD8gKMdq6/wS68GshCS+oXFmI5Vt/PyL0MRBnDEBrBCYV0PvupSHn6ijlStf313RPeykRzWYZ0eMjaipttgYrUPes+uDSRYROWoCUh4r1FjjmZJF0OO8HDORkPNVadhJ1+dq5U89D9FKkeZLgTRL8itqqHoR3B169cniBek02yi5BLK9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtKa+pAc0nHoGbXoA61+cNlU07hVOAtVW4TUlVj7Ous=;
 b=iQ2r+iNfjbviV613WZ1nTCwa4vXUATLnAccVea1IlrxjXCXSABkpribh5xborj1lweQSGKpAjtBrnDnVUlgRQXHeXwdqP3Mkm8zRpfDgnzHDJwlpekeD2NJNoUKXXqkqgD+4YTzrWU3pQLcpM8FWjoGSgKKDOnw6YzIFxTV9kHB+Kcpu8HxkBLN5S8aijJlkePHzZN/11Qg5I7Q7u++eUm9en5y+OXEfqPGNzHySvYR9JI1A0iOzEWDVRPghi3+wDoHWFEVo4KpP7f7tWJ87mO5OXQDD6ZfOK3/LTkF6fxsv5CjOd2hnfIrah2b0fJ0zS8P6O0z+uqsd0s3dR4SQ2A==
Received: from BYAPR11CA0037.namprd11.prod.outlook.com (2603:10b6:a03:80::14)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:26:24 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::4f) by BYAPR11CA0037.outlook.office365.com
 (2603:10b6:a03:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 17:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:26:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 19 Feb
 2024 09:26:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 19 Feb
 2024 09:26:04 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 19 Feb 2024 09:26:00 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 1/5] dt-bindings: crypto: Add Tegra Security Engine
Date: Mon, 19 Feb 2024 22:55:26 +0530
Message-ID: <20240219172530.20517-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219172530.20517-1-akhilrajeev@nvidia.com>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb19281-3d6f-4bb3-8d45-08dc316fe544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+cnUE+9HN9C0uSFHYGLL5RheG/W/u7cj7HaHuZFUe+N+S7Qe8fEGB5SGDr+hy65o8KwXGvslhpjx6Ip2iwLBHKhSqS/1hdX2ZVzbid92TWxQo8DpapAwOgqMUVnfknlnkLFC6Flv6Jo1rMMrSTuBFoeoE5HdbIeER2qAXFddjG1r1qWcZOd7D3vbDeaF0kw8SUYLRd0UpdfQCgBNgMwYQh3t0X7c6RgkeMldzaf+APMF8T2ISZ+uEY9Q6MsCnbcy922varPXP+oa6c+0lLuJSsPFuJO9aOY0Jl4Sky1kUZVkBH4K58O1Hnp9onQrHATbTRl3q2JBofJJuPEBCco2St5vGrcRW3WlUHbSp3ydzpzB5ZG5buoHcZIe2QUJ600oG/BO1/Db2bI4uqaSt0z+nuCxmBwwd5UPFktY4pKEfw3OgtHpggENDTSa+7GyqLs+8hCEmm8IsIhOBSYPPAZP9NqWDaA79up6S9N9bMJxQctNqfYNi745CPoh2z1DTA/W/FeeRj71EIhHQg5hT+uc2tg0EYmZWtn79D/7YARdBC/UmrDrBEBDxA6rzLtJmeHPI3swNvJVgSqas+Bp+AHQp0gKmfMsYELzulOjTSYvsHmG0uB9fPTy3PAwEpQ0MT7qh41tGgrIcC+plzAmQJ/pP58DJZUNwcZvF1tPGioAr0AO5BO6RuT8HUNfcDiLPkGOUTChSJvkjKYzWls9MwDDrA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:26:23.4873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb19281-3d6f-4bb3-8d45-08dc316fe544
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

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


