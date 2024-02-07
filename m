Return-Path: <linux-kernel+bounces-56461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE184CA74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A27E1C25EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D795B685;
	Wed,  7 Feb 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GA8+8bp+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A035BAD4;
	Wed,  7 Feb 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307575; cv=fail; b=npU4P1ExIE9lFsim32Za4plcB4o4HmST7z0+1yDtlesHWqeY+VKX12puGMY8eLIUHfX87AxiJo/O/dJ0D9MzS+ObeX4HIq5KtEXOcrFJCXeaW9/57FvxS7F0mc7rq7YvJMsBzOtrz7v7Lxx6FRqRgOt/OLYZ4zHB/z4hYk1a1PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307575; c=relaxed/simple;
	bh=ecrXkdRTcvTL3mYeFlRfkPY5l91wroACsEPRYcvmHZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNdYyPConLC31Uzu1GebTz8kh23TJhbeZYGbd5+clVXuJKTffJ2NOPiq9PoVLkQqqtR0+G5APfcF5xjv8JK5Q4CMEo7441ag6G0q4kkeuVX3D6bpMHK9wKUlFkLjl6PZXCK9ka42J0Jy7rYpnWCrgYszTiNQ8L2sk5DDFnU8NBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GA8+8bp+; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIIorEwazs2CnAsfyo94RBVAO06SALTS2jT3QdI+lfioWS4mfCdbXEUXMq6yKoe+dki11uU4baXAMc0qbb075HcHbwmNHLp3CHZpQpm7R0f2HJZTVbqOVdoTDVEVlsUZyw9s0CdtzGItalhpVVBbng7tLfErpiz9QaDaRzpxs1yL4l8rKbtw8p4PgFrmDeCFL10Z1FaqD/IoleKKhl5xSCixD7wHo98U2dlsUUjsjaJsHAmddM1v3rhO5xjnW6KZ5aCceUDD8LVs8oAKwtlOLyzOtV6rRXxr6zKc21MsbJbinTjY+CDz38V+eUoVnqywNWiym+k1cX6HT18MzIrBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PvtORgK6PLqJ5rZQrUMQqQDX0M2Pv7Dc9g6S/pA5o4=;
 b=b3p8BnhWliIbCjPNoTkyhTgzy6426lyFlGahaxyvJCcM9U2SC5hROumvJHrF7dTdO/tfsJFR6iDOMC64HNH94p5sD1qCSAFbQRx5YIP1dVb+Ky5OcPfkmBgX8NJ5FI+ThgklrDZ3N9M8ngA16E4p6eLJr2fRDshPGffLFXB4fq13jvUJpPJUXu6eYRjjvZMgyVsOqAPWvQBb0p6taja6AxYqPuQKj4BkjOY/3ELQxitxK+gEYXnlZp9s0tt5PI1SAUdvpOIUE1aJwaEEvKOMhhxDMzOmu7SgmlerwhnsfHIJm8Lx+v+Yao6bFr7iQ+jsExriPw2Xij2YAwVCmHEo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PvtORgK6PLqJ5rZQrUMQqQDX0M2Pv7Dc9g6S/pA5o4=;
 b=GA8+8bp+Rho+uq4sxko731JNmBFBfUxKAQefY4xMP0HvOmkbgdqZf2jxut2XdEzWnlgtNs3hbFHqxRjaaezjRiQMx5yLDy0P8ycX1JSUiQ8qDNJmcIlMdXl1jUCIFfzH+ef0EBc1sYuJe1j+djvsbUfWgK0T++emhIL5Iy2I69PY34xP48ZwI8uUVzPwswHP9mtpZKChMo3l6y2Brg2HLDtLGnzxouDPXMDa7MOADIl6dcMsne0Nu1z+JtgNGbHAEjo+HlkphnEHTifJXfNTfkt+qMGyA6Y2SeQ0v94MuBaV7B7B5p6E99YAoLXq4UnrdEjV9c4vkoSKMrz2MWHAUw==
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 12:06:10 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a4) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 12:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 12:06:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 04:05:56 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 7 Feb 2024 04:05:53 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
	<spujar@nvidia.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>, sheetal
	<sheetal@nvidia.com>
Subject: [PATCH 4/4] arm64: tegra: Remove Jetson Orin NX and Jetson Orin Nano DTSI
Date: Wed, 7 Feb 2024 17:35:18 +0530
Message-ID: <20240207120518.697926-5-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207120518.697926-1-sheetal@nvidia.com>
References: <20240207120518.697926-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bc95ce-9335-415a-17bc-08dc27d52c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ppzNCCK3auqJxbxEcGRzY6fIuH29NgfbGoKhy88ib3d/Z18dOrygJpFTbYsrWlJvVV55pKN6KQf8LhVLa/tE20kBxC9B2cdEOjA03B2ojsee71tS+sGtA1EyWC8n/3BGU2CMAiTNaLIJtzKZ2EvChyODIbX9s51G0+KazbyTHhFVNs+UgpfhpNXm9wFboLUBw7K187bIyfQ/5MT5YNeyoOhZupDNdSo1cExb4GSVoamshNNPauEbPW8qdpaKA3k8ZhocaRixzr0vtsWKmkFadiZPRCkLlZaJRqjFJAg0fQR0bq3pmTHJ3mdJv2Qfn7qYJE28i2Y7q06ilNULbVpJtEHG3q3JUABka2uKOBUcYZL1EtkSdgr5St0+MjnWLewOPTxHeDbnnwC4xCwWniT+y0GGQhqH/wNW9Uqo6DpWM1Sq+S8D3aDaWT/9JJgnWoN5LEIA0j00UIuL6M3wKyc1w3Dtya7zFPMKBDANYrUvAQ1KXqvJyN1AaqUZzun2sTgnszypzaJWONJbBjCY1+8GAOS2WZlKYGlj0pJwrVKq/se/+jIwaKyvIsJ/zzjpeboxXkfdMhozCRB8TJqW63Q6TKyhk6jyyE6694hi+8fWYFVQ6jJexgzVZWXA4rSvjicFTkSDMAhiX9O73v29LfBYLMjZNcGzGoCgSHFHRUUwJh/y1jkpyGSExPOTStnE3xzBmexLqThh2YmqfnXiSARNwAsinEEtOdLUYWjt0Uo/kc0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(83380400001)(426003)(26005)(336012)(107886003)(1076003)(40460700003)(2616005)(40480700001)(41300700001)(82740400003)(36860700001)(70206006)(47076005)(36756003)(54906003)(316002)(6666004)(478600001)(356005)(7696005)(7636003)(70586007)(86362001)(5660300002)(110136005)(8676002)(2906002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:06:10.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc95ce-9335-415a-17bc-08dc27d52c63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

From: sheetal <sheetal@nvidia.com>

Jetson Orin NX and Jetson Orin Nano DTSI files just define the HDA label
and it is already added as part of base DTS files.
Hence, removing these files.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi | 14 --------------
 .../arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi | 14 --------------
 .../dts/nvidia/tegra234-p3768-0000+p3767-0000.dts  |  2 +-
 .../dts/nvidia/tegra234-p3768-0000+p3767-0005.dts  |  2 +-
 4 files changed, 2 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi
 delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi
deleted file mode 100644
index baf4f69e410d..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include "tegra234-p3767.dtsi"
-
-/ {
-	compatible = "nvidia,p3767-0000", "nvidia,tegra234";
-	model = "NVIDIA Jetson Orin NX";
-
-	bus@0 {
-		hda@3510000 {
-			nvidia,model = "NVIDIA Jetson Orin NX HDA";
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi
deleted file mode 100644
index 232fa95ef4ae..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include "tegra234-p3767.dtsi"
-
-/ {
-	compatible = "nvidia,p3767-0005", "nvidia,tegra234";
-	model = "NVIDIA Jetson Orin Nano";
-
-	bus@0 {
-		hda@3510000 {
-			nvidia,model = "NVIDIA Jetson Orin Nano HDA";
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
index 4c75dc940e99..1607ee14216f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dts
@@ -4,7 +4,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/input/gpio-keys.h>
 
-#include "tegra234-p3767-0000.dtsi"
+#include "tegra234-p3767.dtsi"
 #include "tegra234-p3768-0000.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
index ba949203eba0..dc2d4bef1e83 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dts
@@ -4,7 +4,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/input/gpio-keys.h>
 
-#include "tegra234-p3767-0005.dtsi"
+#include "tegra234-p3767.dtsi"
 #include "tegra234-p3768-0000.dtsi"
 
 / {
-- 
2.34.1


