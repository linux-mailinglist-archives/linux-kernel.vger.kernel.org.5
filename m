Return-Path: <linux-kernel+bounces-15295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2348229DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C960B20E65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CD182B6;
	Wed,  3 Jan 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3UW8I2oO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F61862A;
	Wed,  3 Jan 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZNExqaDBz3n7uBwILN7L+5rPdqxOx2Lo3GyWAy+sgYbi1qcBtepS9Xt845aGpBaJii7+65hHVJGwKEdTHGEzD8Kltoq73Wd2SpKy/p7wWRoh8IhnzJM2k9znjjAmwjmIZXDvvwYzh7HdOb1RwjiR3iG1vGm4ZchEn02Zmbl04TiQoVhFOLQula8UbVG8w3L2E2eXRtlwhch7cf0FsoD7gmvC2JINc0P8tqvIbCGTvT1CL/XfmPPdjl6pzg8KksjWI9BPw0fgdTDKjckdVtpDIx0KHm8jiMWIMdTlYXjoqojd6f+bdN69d0vZ+ilI6JVByKyu8gnjv0JObDzpEWfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6MqCfOD6eQQ1Eh8/I1RNjGVLq5YSYszEpvYybTxlME=;
 b=QQPh20T0Lr0J9FqDWdJ4NnmCuUB9ohC0ra0yqpFXaPU6lHp1D/6hgD7pcr5JEFiyOYyNeVeBYgyeHWAwFY8lxivqNIVVXszxYgJk7LysFuODReBE6rO1sQS18YnF6Nn3qyRL12i1Kd2s2d9Ft/91d7zfVQkutgQf3mgWj/mHMjDSZ5wRgBQWMTrj+OXmmajrFIpND6+QjuvVz0uQPcXPNuNh4wjvkd5hrjJ/26k1glnyhAuz46nk/iG2dp3r+SsO6XCR+nV+B7U8pGCtJu307cXfnEKNZ0+7j1gFM8AKRrkNYhUYYbevYajwGKm5Cgmta2oL6kkWU5l2JknyDg3RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6MqCfOD6eQQ1Eh8/I1RNjGVLq5YSYszEpvYybTxlME=;
 b=3UW8I2oOuq3Tcgz2X3c0CqqaPIsgJ2ndvhTnMl1j+CtHzQlaap/jZTG8YFY92R+d9IsX+LsYoIE9/6BGkD81vcKd9xppTW+86mf+R58IV8ATbgM435MZV7fyM1aLSxZH4AMu6rWczQ4IKUh0SfPce+bJJ9vyrNtEKb3CKHlnfgQ=
Received: from DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 09:02:10 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::d6) by DS7P222CA0021.outlook.office365.com
 (2603:10b6:8:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 09:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 09:02:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 03:02:03 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Peter Huewe
	<peterhuewe@gmx.de>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: security: tpm: Convert TPM tis spi to yaml
Date: Wed, 3 Jan 2024 10:01:46 +0100
Message-ID: <0f59acbb394cd09ae2a7950d8c01f8e40abf9f34.1704272496.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294; i=michal.simek@amd.com; h=from:subject:message-id; bh=in8bCANvdWINK2juUHEULdmDc8loyOis1d6CLD/bSyU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSpSiW8Hdk3f/ud0fsasvOIp8eM9j7/A29yN/I6Chfsz kybIr26I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkewnDgobpm54UrO3mNTtm pmYXbvuqQ/DaOYb5iXZbrX17TP9G6512N/aZyu7e4ioCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1157bd7e-dcd1-4ca7-9924-08dc0c3aab1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HV+RQEdquUB/K9r7/3ZPgN6c1QvY2HBDpt2FzEWbpsWF1Gljy7Y1JCSu8fPbCL21zA55NXUDzjt0XoONNaXcmD2YIxrwd3c6u2Sg/rTP7pXV/HGSiG61QaCBvmMcTS2WlKReWcjJJ8w45jPI7Gw0xUqamRbcAJ6yZmdoXiiCEf3M6u+rsH2S85kcZ/9mLd4oxscqTm62eshxPanPghtQw+21TwUiGI7Etmg8p3NPhaSXLao9ZB9znfVFYT+fJgIx/Q5ZcCu62bYh1JgrDS2CXChHIhahn/si8QQgB4psIZJuvdk6pP1ZLwdE18NoRRm/S7Fga7iFfXwpYQslko881ylCEcuIgK541Qu7/6cWRorIMeu891cQfa6xpZR9HFv7eFrvAzCW41Wm0gpGFDZRqyJaZ5IataXLNvUZ7Bmb95ViVziMHG2VwN4fc9q6H9Rfq1fqp12vmgh9VG6A2z1Y3majrYkJtxG/zXKP2MLXGUWc+DGw2X9QcAgWT83FDPhaQiH0tVLYLNsfeHs/XFqiZkOwnlGoJ5/6zp9rMb1FvxES0IffeYEYHCuAd2JOKXeJtgVn0XTM/fYIE6tnJisNgVWoL24yAqMNyd/Pi2zeRB2NyJNnLxCqjvVi7yfAShHTK12H6vzqszuN+mZWmKEp3WDsj6zKTTU1S3tJKWaWMtD2teVOJ45D+W5bb6mQ1obt315VNS4Cz4nrKwSzMNZ2Mz0nXXgD6zkW6xihfLZHqi1Oe9YANr95pog9hwW9e/gjCmWaXUg+J43ZZNhbqFM0BQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(15650500001)(2906002)(966005)(44832011)(41300700001)(478600001)(82740400003)(8936002)(356005)(81166007)(86362001)(47076005)(36756003)(83380400001)(26005)(16526019)(2616005)(336012)(36860700001)(426003)(316002)(4326008)(8676002)(110136005)(54906003)(70206006)(70586007)(6666004)(40480700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 09:02:09.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1157bd7e-dcd1-4ca7-9924-08dc0c3aab1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

Convert binding from txt to yaml. Enforce that node name starts with tpm@
which should be generic enough for these devices.
Deprecating tcg,tpm_tis-spi because it is using "_" which shouldn't be used
by in compatible string that's why infineon compatible string is used for
file name too.
Also add current TPM maintainers and maintainers of this dt binding too.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I want to do just conversion but not really take care about this device.
---
 .../security/tpm/infineon,slb9670.yaml        | 54 +++++++++++++++++++
 .../bindings/security/tpm/tpm_tis_spi.txt     | 23 --------
 2 files changed, 54 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/infineon,slb9670.yaml
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/infineon,slb9670.yaml b/Documentation/devicetree/bindings/security/tpm/infineon,slb9670.yaml
new file mode 100644
index 000000000000..309b91881774
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/infineon,slb9670.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/infineon,slb9670.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trusted Platform Module (TPM) with a SPI interface
+
+maintainers:
+  - Peter Huewe <peterhuewe@gmx.de>
+  - Jarkko Sakkinen <jarkko@kernel.org>
+
+properties:
+  $nodename:
+    pattern: "^tpm@[0-9a-f]{1,2}$"
+
+  compatible:
+    oneOf:
+      - enum:
+          - st,st33htpm-spi
+          - infineon,slb9670
+          - google,cr50
+      - const: tcg,tpm_tis-spi
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      tpm@1 {
+        compatible = "infineon,slb9670";
+        reg = <0x1>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tpm>;
+        spi-max-frequency = <20000000>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
deleted file mode 100644
index b800667da92b..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Required properties:
-- compatible: should be one of the following
-    "st,st33htpm-spi"
-    "infineon,slb9670"
-    "tcg,tpm_tis-spi"
-- spi-max-frequency: Maximum SPI frequency (depends on TPMs).
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-
-Example (for ARM-based BeagleBoard xM with TPM_TIS on SPI4):
-
-&mcspi4 {
-
-
-        tpm_tis@0 {
-
-                compatible = "tcg,tpm_tis-spi";
-
-                spi-max-frequency = <10000000>;
-        };
-};
-- 
2.36.1


