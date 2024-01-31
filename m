Return-Path: <linux-kernel+bounces-46123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C75843AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB25295790
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCFE612D8;
	Wed, 31 Jan 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RuuwBUFE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E376027F;
	Wed, 31 Jan 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692659; cv=fail; b=k4vZZJBoO2bfFV9zfb9GXQyc/aoNLOLl7m/iqMUZCiTCRmqJQ/UBRwPFTB5EkrCZXalngN8jvGnLe0wHH6y6noCgPb2x69ZEecGQKuakwDdGMyikK3QpGpVZQismEJmXYF14xOfmShHaCNjPVa8e4a7JgnzewdEZHdE9Gt5NtTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692659; c=relaxed/simple;
	bh=d+ODgJKrStgTLpcjMm9Mznyo/4Vb32vhrPjgHECpRg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYOlvrfchWkjsvYzmwWqE3Y50uMEObne5Ww2Jsj6xHhg653vDcjle+ddbVXhxGUw3SQKatCWDEKdl7AK016+o1OKU1mcPqi23HJVwLVP/PLRIU8TIZ7Fe+CiyvDiTyPB5LtsvzI69Pu7dA3RF9wC6xSKkHFrA2BGtMjmb9UZUzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RuuwBUFE; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH21Y831UYLJ46cWWegCpp3q0hBok013YU/uE9LR3jPCUFwPB8+jFaTbpEaaXyxf1b2gtWFkaz5GDaBgiBKHp4bJS0F3rjTnu047hdEzOCi7fdjqIRVtVtuLHsv71bj6bc30VQmSwlJESGnku6+fiFytrzwJr+wFhggahROHrvAD9yuSVldlejrm+aZoB5E7bgcPox10NHpXypZP3pwLYgidIYSNJ/uxpeWYU9JbZrSW3sv+uelFOHLYyw6GUa2UAscPSiAFj1J3IKJrThGziGJDKwu8FVa1daQPO7PbGI9Bt9hQXYdDwZcSeITlOk7wA9IOogwfbztWERFXYDwc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC+uqyT+WDDXNVqRGJu/WJTb7DZlXBEh7qU3MjQy7Q0=;
 b=kXqg8Hl4VYcn6iZkL+YBOKqHl4Eb056CMo6GxJOOuRLkUN//+pxcTD4x8THCvnWORbCuDnwv/JF39vxFEqG0Kd/HzHr14PbJD3rLf/5XdCBtLoSmgMIIQS/JCw/qpNAygLCh6qKsi7lhsH6lWE7GG+EoWccn0llYp9TY9zAEzHkpTN3P6ahx4haxC6EnpreuRilrw+SinPKuZDXI3jVTm4TZZNIt1406bVlv1ZVjqW7ZrPEfaEhwypDkhIdAatZXn/dRthclRVudeHKpfXwyy32jwJG6BOXD3+S6+nGJhA/xUWTZ4g4kbaZVQ65SeQ5J5eEsBPhp2CEjGoOZleEr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC+uqyT+WDDXNVqRGJu/WJTb7DZlXBEh7qU3MjQy7Q0=;
 b=RuuwBUFEBm4tE0kgRK3yhaWEJSJSRzyrh0U5hPe4V04Uoh17LWnFZaTHiR1O/AJgGJ+2Fb+oWt2JqRUXgRxUWQf1c26BqDQGOpUGM71s49fAQ6BxNtdOiFJD7fX8YPS+B4BpPn6VvBFEx22ZcsbSxePLDORv8h83ZyUtCNKXqL8=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:17:35 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::4d) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 09:17:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 03:17:31 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: firmware: xilinx: Describe soc-nvmem subnode
Date: Wed, 31 Jan 2024 10:17:28 +0100
Message-ID: <24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=michal.simek@amd.com; h=from:subject:message-id; bh=d+ODgJKrStgTLpcjMm9Mznyo/4Vb32vhrPjgHECpRg8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRdAkqy/iWTfdyM2pN6z7U+Efl925TPeEOgSwHn0Qq5g OkLtnzsiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNhaGZY0MDk151mf5Dn09Yd 0Qt/J8ziyz/5g2Ge1h9d08BDXwt31F7/KPRzQZnTtzuTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: d2be985f-c7b7-48d8-00a0-08dc223d763c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j7QxIZSETSYcqgXh/dmMqLFbw8AxH7DV6TxbCzguGIQOeX3+UcA+BU/c8YHOT7+lDN/N6BxUpMu+VNL1H+raTeXCQGduNU2nZ0BAZW+sVs6ZgF+V0UCsJBXJSGT2415+GpPKP174ljV3STYuksGZxJ1ncqYHaikvFAMgaNXpSAvqG5bXKaibW2eSNrdyeNFSZjc3xhJJVcQf7XXMN+LUC30SEnP5+7e/iZUniU6gW+Am1hjR60ZiGaYG6c2wrFDAGfHtCypjxRdT4Y/TbzMy2LpZHqFDmLZv838AoKB4qkfTFJahQeaRIStXVnMOIoV6lcVYL/TPVJGqxWRlcvC5Sglo8GmjY8kuNf9arrBvQ5WNdqP9ywDb0O4ggYir2JREgC44HOj/+qGQOUwtl6ap+fvv2YzG2WHvvHiJxDU379F7VU7SaS8OHvEtQI4an8sCDEL5GIFzXNGBO0XWkADacdwaOzyY3feGj8D0fhK90Sauc2vJlEhbjt0zWTysDHO2jfqVWBgfoBhgKdaZAVJd54N9zxvck98nPkg9LrZUxlG7FASOPxDtgJtc+bLTnLun+SUAxhZYZ/OeMlPw6Bi0PAdM5CwdGWBlrnmoPEKwCaOXZRBaDj+SCpPTFOdDR2dWYEaehGRXz2hdRSDo2eNI2nIJnuyXWYehDhgSU4dE0G3HFi6CokFK2huiOZTk/rKZrLb/VyK5zEZdfOqHdl0G/oi0sSnmXIBwX9UnflpNtBGt0yszuDXmBs/U9FnxiQAqMe10y00CJiTNUB7qI0YkfaueSDY86UV9ly2IBXp0OrZz1xQr3CU9iOODlbNowXRy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(4326008)(8676002)(8936002)(44832011)(5660300002)(966005)(86362001)(2906002)(70586007)(70206006)(316002)(54906003)(110136005)(36860700001)(47076005)(82740400003)(81166007)(356005)(478600001)(6666004)(83380400001)(2616005)(16526019)(26005)(336012)(426003)(41300700001)(40480700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:17:35.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2be985f-c7b7-48d8-00a0-08dc223d763c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Describe soc-nvmem subnode as the part of firmware node. The name can't be
pure nvmem because dt-schema already defines it as array property that's
why different name should be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Fix typo in subject
- Make example bigger requested by Conor

Dt binding for nvmem node has been already merged and it is the part of
linux-next tree.
Here is the reference to it just in case:
https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@linaro.org

v1 available here:
https://lore.kernel.org/r/3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com

---
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 870b94813a43..741f17c830f4 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -62,6 +62,12 @@ properties:
       interface.
     type: object
 
+  soc-nvmem:
+    $ref: /schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
+    description: The ZynqMP MPSoC provides access to the hardware related data
+      like SOC revision, IDCODE and specific purpose efuses.
+    type: object
+
   pcap:
     $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
     description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
@@ -110,6 +116,18 @@ examples:
     firmware {
       zynqmp_firmware: zynqmp-firmware {
         #power-domain-cells = <1>;
+        soc-nvmem {
+          compatible = "xlnx,zynqmp-nvmem-fw";
+          nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            soc_revision: soc-revision@0 {
+                reg = <0x0 0x4>;
+            };
+          };
+        };
         gpio {
           compatible = "xlnx,zynqmp-gpio-modepin";
           gpio-controller;
-- 
2.36.1


