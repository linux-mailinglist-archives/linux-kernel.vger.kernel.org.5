Return-Path: <linux-kernel+bounces-42683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F38404EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC521F22B49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96722604D3;
	Mon, 29 Jan 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vwRqqOVe"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE46026A;
	Mon, 29 Jan 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531118; cv=fail; b=C1MkHgPoK96O3XqWMLVIWQEADkvc66yLoEQ9R9C+z01s71n0L6/9Qnjb0u2b6Py7sNxliEZP81jMWvQisApE633wzrUz13XDZbNpI+FaElivFDZe/WbBVej2drpEmfLHkhY/o8fkfPU5NTV4wg8HaasBpO0t/zY8uMwYAiGaHxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531118; c=relaxed/simple;
	bh=2lx+2gdFtjk/u/dhZJ9fLFk/df7JAwEbdcysfU5ZZR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMpcfeZelJU2lu8PsMTws7cDpGRZPLc6QQjNyDS4d/y851c+KTrjMPTJSel/5hLs4/hSp59ZZkJWMnE1C21Y7SAseL6oHYTbMsQhCTPPwP2LTOkogNzwpD6PeRYcBybcnoymo7weTrkB/oUaWSdX2YIh89dhYKtKEWVbTxMjFmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vwRqqOVe; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7WkdHAzvclbZAW8o1VIIIB5Zi42t8zasQPZJLTpI1IBs7pgDt8AC2bXHe0HkLfVmXKb7Oq+l58BrJXLovIJnmGnqj9q1FGSbr/0Ba55otfG+hL1XktLGGzj62+sE4uF8Fr0yuynGDPsEjevjyE8Q+gt2OU9QXI3/i9Nt8VYx0SDFB0bT6fGlhwauVXHe6+DiWNJ2UsV5+tf062O/FsksAlJaDxDYEGcO8DsaA+SJkA3NlIPUF9FbWUU1CGFOj8ImZ3gyPydMAfP1dWRXF8Kl2k5cpXwToGVTx09clFpwsHLGnBkTW1FlgnLJ/8RL0v6oLAuDqYeereJp1FDgZbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5EYf5oACji4KuOrO6D0nzrvrs8DBLtyw4/DyQdLkTI=;
 b=NeUzZ7ozyzMT6LLD0YVIBKuFsHwZWN721PdeZ7VCEp3RuBL/99LhNOmQb8rYK431kVCCDK+aDfXci6V7hEHmB8lbC02Z1WHVWZhRfDbSsWYCbNgd5hTohj9b5P7NSbIgf0UoU3D2nRLy+SSugCnG31ZF+ZXIRylxObpl+kw+BJduk2L6oP1Hh1a09wF6v0bCGbicbTP9FjF1EXp8IAOC1Hu4wMtPJL6vs+WMjvCzATM8F6v9RY3ayLwZTCkDKyJxoAwEi1bGfp8s1swa5Nu8NuBTp2tBmEjoqPUou3RSsQJFuLQ0qWSwi+/ot5DUmhEO1g8GAoXuh5BH50gBYuwI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5EYf5oACji4KuOrO6D0nzrvrs8DBLtyw4/DyQdLkTI=;
 b=vwRqqOVelSRDtdayZjYUUE8KbddudT3m117vIPgOCgPe+EiOe+2KlRY6EZ4+pcYfbV+DsChTwGgXEsWSXv8h/TwztKJZF8fAth2a4D9zdUUTv2KWrjK8TGECb/Dws64nBQCl1m0E5ySSXIheKbFUliSjTjC6GCqra+vkQPVAnjs=
Received: from MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:25:11 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::2e) by MW2PR16CA0045.outlook.office365.com
 (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 12:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 12:25:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 06:25:09 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: firmware: xilinx: Describe soc-vvmem subnode
Date: Mon, 29 Jan 2024 13:25:06 +0100
Message-ID: <3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=michal.simek@amd.com; h=from:subject:message-id; bh=2lx+2gdFtjk/u/dhZJ9fLFk/df7JAwEbdcysfU5ZZR0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTtMxXq3O+nTBR2e7M+skWvZn+ggOT5KfZPgzsu2e08x 8cdUruiI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEyk9iDDXLmGdfKVfl2/L0tN V3TVOTXRoEj2JsP8bEXPS09X5QWdWbms3/OjhOaDRUtLAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd37f13-4a42-42be-6660-08dc20c556ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wE5WsZN9SMXpD1kCJd/A0n5uQ9v1nacw0ZlDfbL695Largv8V6s48DsbjMIDL4mE3Ildm65Tf6/mmcnEK1kG9JzfJrWBGyZSo0PSsiEA93PADGvtBRhaytEVhJZRPeOBKkVSQbynbkx8yJzFG1HpUBGpdIE0SOJQa90BN2lgURzeU3uxCdAySmv3I/WYR62crglLyi9AAwLEvTd4ejDrS3LcE0kHDl0YjX1HjMhw1qavECZ/HkzPDImuWvkmB2opHMKPiuzuporPZYhFWwtbiD0KQhCi1ztMMne2MIJxcBIx65cSvUe/NNKHXxbw/hXZEGVB2dFWnI6K9aC9s+CdHdcCcPCViugUoUDP4MOQAtNNjuupzq45Hc0Qf6+VIEsV66CS5rI/BAPBdWxsXiChGjUodq8iFY2NGcPYSxbWCMZ5c5zqCtFabs5RFT+WQ+umaliQkCFgPx8FYfLW+5rpHNUbLB9q+xxsmovI3lJst4F5FTWxP6Bi6e1+tLcRbnrUPbes5RZa3XL0gz0u/cp5U4f1TFfpgWk1iE+agEuDxbdte2DwkDb2KmHyiSQSbYPB1LWKhG2CoJ176StLWTz6PoBILfB4eFRom3DbBxiEiX3ShTIl3ZYhMH6996WH0sUpK63OGs6UApfWBHuFF56a1rfAbiW+l1DnDIA7yCZDwcepCvXuJGaVP6tfxvy4JxxCzkKp9SCs1BkQrdhSYSRvHXd12NKfgGpf95dQzG7T3kzs5buGHh+ND0lJdZeKqrNRDC8H806tnYGFfmPEM5RkhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(8676002)(70586007)(70206006)(110136005)(54906003)(4326008)(8936002)(316002)(26005)(16526019)(83380400001)(36860700001)(478600001)(6666004)(86362001)(2906002)(5660300002)(44832011)(966005)(2616005)(36756003)(81166007)(82740400003)(40460700003)(40480700001)(336012)(426003)(47076005)(356005)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:25:11.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd37f13-4a42-42be-6660-08dc20c556ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

Describe soc-nvmem subnode as the part of firmware node. The name can't be
pure nvmem because dt-schema already defines it as array property that's
why different name should be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Dt binding for nvmem node has been already merged and it is the part of
linux-next tree.
Here is the reference to it just in case:
https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@linaro.org

---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 7586fbff7ad6..108772ef574f 100644
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
     $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
     description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
@@ -110,6 +116,9 @@ examples:
     firmware {
       zynqmp_firmware: zynqmp-firmware {
         #power-domain-cells = <1>;
+        soc-nvmem {
+          compatible = "xlnx,zynqmp-nvmem-fw";
+        };
         gpio {
           compatible = "xlnx,zynqmp-gpio-modepin";
           gpio-controller;
-- 
2.36.1


