Return-Path: <linux-kernel+bounces-27353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56B82EE90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4241C23294
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88071B961;
	Tue, 16 Jan 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pMcyZxpF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839A1B944;
	Tue, 16 Jan 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLp5lpfTrHF2nGta+YRkjvUIxBC3nmLh67/mCf5Yz56O/uN8xkAekwDOb5spd3O38iFrJPoSYdO4JKFPD2qYaeJqeVdREGkfDbOCO+5tRZZQHsRLOKaw/omTtGOsYniLRAUlcKBYctsVRBXVW8Hti9Vdi+5kxQlFxFjiYKCpuUhP4FqIKG141FmpuaM/y2PFHWh/oZpiJYMixxQzxK5qrx+2qckqpSnTLcqZT7e4LTRiAKG3nuLy+5AdqwesIWBJ7b3SjyYAKVW/6G1guSpQlSvrF/irESA5ykP+HSeqJCtshHNjTAxm2b54NOmYsedEG6LZNSvziWGkVm0r21F0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jISansvkBL3gRwNlm5DECa5ZeHMZm7A1EbkoRTSj2NY=;
 b=E4JTgOPyg+/OxXGmlePAUeFMYbDfPA7GyCdCm+RM6qUNPBAcZaSjIEYZ3m9uWRNJqqdOPQpGOGms4BENJZLYXHtRemocRu1AlgWOzwHOVsxMgJCJicZoGUQ57mW0B3mTKMqE8twh7Xd+tCGKjSXDfNZwTyKAt+ahNBtL+5gn7KZ2F8bjWemXJ4Pn+ma97W4IOg/oVwW0TCNAOUxSe14qMSnGEy7//4uaJIVLfVKH5E9iY8SCn9SzkvunKC7/v5HApyoxwMH/WBSG3foR7cLIZnTqKBrJdvNBtdp65tErAOOzz73nmg/wi3NC1M1LdtqJhJz9OjVeGvcQplevH5A6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jISansvkBL3gRwNlm5DECa5ZeHMZm7A1EbkoRTSj2NY=;
 b=pMcyZxpFVAwqzboRHKZye/Al2gzz0CtpIFJhO2VmLexoIOY9eb4pyl1RI1M0/YX23z4bkD+xVueW40lZn6/hbxdLBAux5Jcyw3XqUCkMK4I8BCZjdom+qinRlSVQqkT2ruZfEqZsJOx1/xMjWpjEMj1RY5TqB66i5PZ+Qfbuoho=
Received: from CYZPR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:8a::15)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:58:53 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::8c) by CYZPR10CA0003.outlook.office365.com
 (2603:10b6:930:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 11:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:58:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:58:52 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 05:58:49 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>,
	<sebastian.reichel@collabora.com>, <shubhrajyoti.datta@amd.com>,
	<naman.trivedimanojbhai@amd.com>, <jay.buddhabhatti@xilinx.com>,
	<nava.kishore.manne@amd.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] dt-bindings: firmware: versal: add versal-net compatible string
Date: Tue, 16 Jan 2024 17:28:46 +0530
Message-ID: <1705406326-2947516-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f74144b-b021-40ba-cc0c-08dc168a82c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E+1uRtpBQtj2w4UBLKiUNlvIkM4PU8o14qJW3wfnaQ+sj/w8df7AT9HXIjV48SEAfKkU1PH6YXovQL2EBD9Kc4euAnwOhmo+b0CgHd3WExkfyLUDuoZZ8d3biN50jjZG8CxIp/MCDqwgI+MoMzlcvySnU7oLCpofdG+PNaAfdPESJsovK/JFDrVwKEXYwKmJcqQGe/fGWkAQJ4H33/2YtvSlLN/oTyJg0oHNZYtuCdC3M5gEl5PbKcs1eAzF6iJxIxSKM0DpjLjMKwQo14ivUVTpghLpgUPBE+2bzvm4fdu+TAGcSuWQmx67lsst6vmjLKZR2Pwynx1anHr0GsQ1b4Sv6nCuSqN8+IeZcy9a/iRq+LLCO1j554gnwimFCQRw4TS33n3bCgDhJZyYsLUXJwkYOvdKdIuAMknLfzOwuRZDDmEiPDFy9cB1AIYI0vxRUQvfWsRqi9LYOCeTU6AZC1mSoQ2FOgz/vvTTmfZUpYgDR8RFw6KJ8Ufm4Zyk7B4DLyVEZ4VmxlzdENDDYAFE4HCkjHnym8yaMX/D7LA/jahT5WQIRClReOFprDGTqlyriaQiDoxXujNroiHovuNwK1+zySVqa/X4CO0dvfEDkjR3Rezzm3kVErh0uFVlPAM2aQHdS+iY89m6A/iDqfnGJ4NgqluYC+HWXmHJ74LOSKSDZtAHbDILCwDBixuglix3nTX30S97U+xls4RgE5vuMrXJZ+AoUeNfEPzzF4ghxf4pSO4i2LY/ky9IF5jfyan1U11Qrom2cXNiBfm31NCh5xQoX3f+7Dhr1At10+2ONU0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(2616005)(316002)(70206006)(6666004)(70586007)(54906003)(478600001)(6636002)(110136005)(47076005)(36860700001)(83380400001)(426003)(336012)(41300700001)(2906002)(5660300002)(8676002)(8936002)(4326008)(26005)(36756003)(82740400003)(356005)(81166007)(86362001)(40460700003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:58:53.4038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f74144b-b021-40ba-cc0c-08dc168a82c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275

From: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>

Add dt-binding documentation for Versal NET platforms.
Versal Net is a new AMD/Xilinx SoC.

The SoC and its architecture is based on the Versal ACAP device.
The Versal Net device includes more security features in the
platform management controller (PMC) and increases the number of
CPUs in the application processing unit (APU) and the real-time
processing unit (RPU).

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v2:
- Add Krzysztof acked-by tag.
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 8e584857ddd4..cd9fbbb62552 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -26,6 +26,12 @@ properties:
       - description: For implementations complying for Versal.
         const: xlnx,versal-firmware
 
+      - description: For implementations complying for Versal NET.
+        items:
+          - enum:
+              - xlnx,versal-net-firmware
+          - const: xlnx,versal-firmware
+
   method:
     description: |
                  The method of calling the PM-API firmware layer.
-- 
2.34.1


