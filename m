Return-Path: <linux-kernel+bounces-18528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D1825EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688C21C23CA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7043523E;
	Sat,  6 Jan 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqHAQLV5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C414411;
	Sat,  6 Jan 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuNsMAgoVadGN1kdPQsWB+rf7d6WDWcE6bAWcVYYX8ebJJks0PLB0qIcP38eyce5m+Wck0pf8fxRISZoBHGT72u3tYXw8k2d+9kUPTfQKEG2VVmScsJltCjP05N+DMbA9Ucl9UBp85a8x/LCPVAfkuxvVWCPj0803PO7STn5lY2gUu3/1IrbeDMhnClVCYARLIGeAtLyxjV3M5aOJ6AqturCHq4Rq065CQ5SyFf/6fPbkSqlqm4UwRWpOA4LlCOgOgwNDww6VEc4v6MVR6d+1GY4WYBUz7GXfERB6EFH/R9toY/iRnM2seYlb1X3BmiGOmyeZATdG11EzTx/aVNNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMNY+ZA7KOFaZfxh6sFnvNa1Cmx9tTN1l8kSFCsgq4I=;
 b=RsaUxQ3Uwc7rmClcqsNh4O64jpFgJtA2YCvgr9iMiB5IeJcZhuTuS5s7GYh0Ww7PEF02DnX+IA649c87HvDE6SPNPCp0Gy7llvYVtMJDhstVf/yFlRgQjfYmvVC02+5VmjcjHKaJ49Ai1WQKz4rki5AQAVz7ytjM7HpaQA57lrqCeb/FhSESxrUvLGQitXGqt78JE4jjBNc2PVjqo4LlSgzpMgoGaM7+lwwIgg7FQZFLaZk3XFpgahM/o7KnegPc7al+KRXsXbZmXU4TLeed+VpQpu3xFcELLYo1ililTGMQS8fuPTjx6OKoyYv+9btKaUHrRuYCE3eBXhw6NV0yAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMNY+ZA7KOFaZfxh6sFnvNa1Cmx9tTN1l8kSFCsgq4I=;
 b=GqHAQLV5pM0AjSbGleWvVeO+VcHoTjyaOxx7mguzzXue3bsL9+zS3rkEMeocZeDW/9RchfkN5wRi4XNjpoqP/YR+zmBdGNTkYsKUVacCQ+0Nk5KFRKX1MQepov2gOzIIejXBMMexMQbldu7xX9qLQLxmCk+GkOH9fbHMs4AFeUuatE7FsupoQfFkR0nlJ8JT+9XpOfTngibZpPA5Bzu5QeEAmWUZrAH5s/IHBsBdinpr3joyo+wbguzTrMCHdJboGQMrNdLR06VTM6v/JyC8ZQjNU4S6ujS9XLG52KVMu8HYmU+KCc5+LJUk0Sbr6zrxAcJOnOz/2k9vyAAbTmXIHQ==
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Sat, 6 Jan
 2024 07:52:45 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::79) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Sat, 6 Jan 2024 07:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Sat, 6 Jan 2024 07:52:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:33 -0800
Received: from build-petlozup-20231217T213756539.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Fri, 5 Jan 2024 23:52:33 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an optional aperture
Date: Sat, 6 Jan 2024 07:51:33 +0000
Message-ID: <20240106075134.3933491-2-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240106075134.3933491-1-petlozup@nvidia.com>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: b309bfbf-4cec-47f5-7f00-08dc0e8c77bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r6ZYajYaPbPwSiNev6C8ddponl6gpa8KhveMNqdQA0yCy7Uix4SZqm8ehPtUbUFGbqRDtX8BIetEnbxEK+/LLtFQp1MbawdpAb4qCqExMlr6p1E3W89KyEWrv9Y9Y+E2eYhl9w/EMLnK+TGXv5jiafuoybRl/5bWKXHDOGTUoox7Umk2TUdMlzQ9cwiIIwdCw9USifjV0dvRGtz25M64oOdCw7NrrtrFN3rt1/UVcGDSO4rghVfN27GFFjLmcBxoiLdpTiwGyVWNmNEBFPD7qPNFUaRoKLXgHu1QB2UmOodN3SWC30ZUw9WxkVO9DmeiE3m9iAcRBsdFVmUn3u7trNXhtc+lxB4EXAacS2XrYTPvSwfN7+hAg+p+chs+RYuNyklVab0/FBc9oFswXgbHc6gSyvaKDgVJvD4HOZdIQKttREnv1PmqFq9ejVR/vnrhHpUtJBrYUciG8k2G85jA8Y84tsc4m5SKREwbvGL0XmFbKVvzXptQ1Pg8jVKJ2bdD75ffX3052RgFJoJvxo+88OsODsIpA+8Lckgg/lysL1rtmQJKGtdmwh59wDYCaFC072nsHmc63U/dLQSzDn/ATgviyibcCzx6L4vmSpg5740hOzVrwS3+aQUgZf4XNwcmoCRZGD5HzO4usKLysyVxqLhbanhT6SKDIMtw7UxUlSPKNjDGC1UndVmj8hzGWfOLJ271ea/qWQl+G4w7Z+a4f+a9NUbxHPrKxrChJsVtI40XwN7DLccQ9ncqZyDOPGkbcPAidMIL+XDEMlF+AJXuPw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(40470700004)(46966006)(36840700001)(83380400001)(1076003)(26005)(426003)(336012)(107886003)(2616005)(82740400003)(47076005)(36860700001)(8936002)(8676002)(4326008)(5660300002)(7416002)(2906002)(110136005)(7696005)(316002)(41300700001)(478600001)(70206006)(70586007)(921011)(7636003)(356005)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 07:52:44.5570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b309bfbf-4cec-47f5-7f00-08dc0e8c77bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330

Scratch address space register is used to store reboot reason. For
some Tegra234 systems, the scratch space is not available to store
the reboot reason. This is because scratch region on these systems
is not accessible by the kernel as restricted by the Hypervisor.
Such systems would delist scratch aperture from PMC DT node.

Accordingly, this change makes "scratch" as an optional aperture for
Tegra234 in PMC dt-binding document.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 .../arm/tegra/nvidia,tegra186-pmc.yaml        | 83 +++++++++++++------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
index 0faa403f68c8..2716610a1a02 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
@@ -23,12 +23,7 @@ properties:
 
   reg-names:
     minItems: 4
-    items:
-      - const: pmc
-      - const: wake
-      - const: aotag
-      - const: scratch
-      - const: misc
+    maxItems: 5
 
   interrupt-controller: true
 
@@ -41,25 +36,63 @@ properties:
     description: If present, inverts the PMU interrupt signal.
     $ref: /schemas/types.yaml#/definitions/flag
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: nvidia,tegra186-pmc
-then:
-  properties:
-    reg:
-      maxItems: 4
-
-    reg-names:
-      maxItems: 4
-else:
-  properties:
-    reg:
-      minItems: 5
-
-    reg-names:
-      minItems: 5
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-pmc
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          items:
+            - const: pmc
+            - const: wake
+            - const: aotag
+            - const: scratch
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra194-pmc
+    then:
+      properties:
+        reg:
+          minItems: 5
+        reg-names:
+          items:
+            - const: pmc
+            - const: wake
+            - const: aotag
+            - const: scratch
+            - const: misc
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra234-pmc
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 5
+        reg-names:
+          anyOf:
+           - items:
+               - const: pmc
+               - const: wake
+               - const: aotag
+               - const: misc
+           - items:
+               - const: pmc
+               - const: wake
+               - const: aotag
+               - const: scratch
+               - const: misc
 
 patternProperties:
   "^[a-z0-9]+-[a-z0-9]+$":
-- 
2.17.1


