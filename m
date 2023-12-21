Return-Path: <linux-kernel+bounces-8332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745081B5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A7284782
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC5745E2;
	Thu, 21 Dec 2023 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xHJ2Wx/r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089C6EB63;
	Thu, 21 Dec 2023 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJX0QM/APKnRH3DoNEhPQyhi1SC6KzMYl8QgW7H1/Bw3TyIfA83ZMrrkLFX+hSYiNnMhsf8IjLhbfyEpcqV7bzXKTEzU+0ApoVXKG6czLKeQixFWp7CmFqQaeiNewa1BUufxrRQKPx4L/o5cHWcZj0Cr+5x4tUNuXlG9bDosz5FN2sdwp3+3CjDgwC1SEWi8fX3BlkImktl7DmlW3GIlMofiP4LQOtn59pHX/NF35iY7X4hFRhxeJnylxj2zRg8hVslhv0H/jNu+6biQ0TbHPt4f/C2FDGwg9YOw9qkJ9aDpn9UzthyQfypvKNlgn/tUHiOCrqj6eBphW1Gy33GXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VErU1fMmjlFtdD+3d4U72Q2Ps5wUhnw8CIMaxVtrXFs=;
 b=bEvWNBq+T0S426K1th0wCRMsPhomTieWPqNxXkGTPjfzy3giMq9+Tx0Ms/zEntcZf+VpDZqSO7c42bPKQsM6djBEtrDEb3GSjeOns4gMhZADvMspNcdEe454OIIfVlU2CJF4S0xO3IJD6999ddbR+XvpfVJT/sYiCjZWGp4ie+JXQekq52Afj4ki+hiqZnsPga1iH0lbAAUiZutTgmWLc4xxLOO3pBZdmYVCeeOzdAI3q3ZvT1+jiSlrHxH0BF1geTk5NAou+Z9hc7zTVQ2nFzzjVphySUuhO1o5GwaEeGwkky55Ybsg+uhj+BQUp3Fm8UZbr0KjoL/116LR1Dm5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VErU1fMmjlFtdD+3d4U72Q2Ps5wUhnw8CIMaxVtrXFs=;
 b=xHJ2Wx/rsJNnCcArvlTD30KUbjwPpKpgcQ1HP0WIKY8KU1mFYJeswIzxaQh/8fhGfcSpBbxutAxmerCxfn796p6RMKPMAOXafZ2jiLC/yr/bxS4+brp9HNly32Fezjmze59pOy0DPubmXY1QPhdWJ4LXA/qputDQ1sgh082Ecos=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Thu, 21 Dec
 2023 12:28:19 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::4c) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 12:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:28:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 06:28:08 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Mark Brown
	<broonie@kernel.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] dt-bindings: firmware: xilinx: Sort node names (clock-controller)
Date: Thu, 21 Dec 2023 13:27:55 +0100
Message-ID: <ccb6bd5f4d1d28983c73497ada596e893fece499.1703161663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703161663.git.michal.simek@amd.com>
References: <cover.1703161663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=michal.simek@amd.com; h=from:subject:message-id; bh=+AUitpSOWAFg4BQgiuXqjcE60JxElkVfG2wS4gQ0ENU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWfU+B7X+CCp/OLjpc233q/3b195fSzh3cGxC6ySnyu +VUbcbCjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR/lkMCzpW3Nx/8O+WQNkv Yjvq/p11ynANi2CYn25tyBhTWf/rmXfh3SV2YWe8TojpAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d31a156-7c52-457c-64f7-08dc02205075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nTbgs/jc6qsgTiJe87TNBBpTsVhUErAjXg0rEPDXscyRM7IY8FCTz5Cq35qdP2s3ZI8meQeySc5iowaQ0+nBp7brgNAIMkzOBHeGxSWuJ07iDcFEmhKdb4JYehenCCu8TX23Oo0KEoeBnBFb+2Mh0WWvS17JYLL6ESOjz1EhKwxvR5CnUoccccb5k+0x5Kn9gyAph0VAB7OOeYK9t//nnKhLbd1oYQwoVE2naCgiUOf6NViLsD36Z5gv1RZrpy2V/a/vPoZ/LC6nu24wImFQl0iYi8ArKUtZTTwbOUdBUxoKUyTiuMiuWUg+5cqoRsG0kSlA/nGznIZ1b9sfwcGa1nqfXWU2hytT2CRn6n7AHp1h1OuuUWwobF+apfqtUEA2LG/uh8B1oNApjW3ZqlfLoQ8PpD3v+oxFIRRcPTTFPTbTYQKCugG5gzc7Yad95pRn6+vyQc3q4aN+vgEsUnWHBZ37WH973du351cDLR4x0QAKnes6h1JCpxDtR9Vs98KCZt8XJpVkc1fRBf0zCmeVVdUwiPKrTk3sm9/k+WhvOLzShrZqqHq0BppnrZCXDNGQzKjWGtQVzoGqIufeOl2/e6S7u20ufZlWI44bOAaPgMqwP7jHsqJBPEZdsL5s4Jp93v6PIrhdehHREh85dJaMT6dCG1JHkV+SuCAZIZ4cvne/jx4MFFdU3F0AgFwEfH/FOjVeDE+UoBWqsKwTeZN4OnWpN9PKUREACNIvgEKLPpkr28zN/nSCKKzXlDUgt37GfVV/CvW2Dmgez54VHQUpkJUJVswKgwv+X4RpmmFRKlBQNF0suesYbACNEbgfrD90a7jcJcKvI/Zlj4B6wifVNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(54906003)(316002)(6666004)(478600001)(26005)(47076005)(2616005)(36860700001)(336012)(16526019)(426003)(41300700001)(7416002)(2906002)(5660300002)(70206006)(44832011)(110136005)(4326008)(8676002)(70586007)(8936002)(83380400001)(82740400003)(40460700003)(356005)(36756003)(40480700001)(86362001)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:28:18.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d31a156-7c52-457c-64f7-08dc02205075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

Nodes should be sorted that's why move clock-controller to the top of list.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch in series

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 884917edb19d..51dc4e3afd25 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -41,6 +41,15 @@ properties:
   "#power-domain-cells":
     const: 1
 
+  clock-controller:
+    $ref: /schemas/clock/xlnx,versal-clk.yaml#
+    description: The clock controller is a hardware block of Xilinx versal
+      clock tree. It reads required input clock frequencies from the devicetree
+      and acts as clock provider for all clock consumers of PS clocks.list of
+      clock specifiers which are external input clocks to the given clock
+      controller.
+    type: object
+
   gpio:
     $ref: /schemas/gpio/xlnx,zynqmp-gpio-modepin.yaml#
     description: The gpio node describes connect to PS_MODE pins via firmware
@@ -84,15 +93,6 @@ properties:
       vector.
     type: object
 
-  clock-controller:
-    $ref: /schemas/clock/xlnx,versal-clk.yaml#
-    description: The clock controller is a hardware block of Xilinx versal
-      clock tree. It reads required input clock frequencies from the devicetree
-      and acts as clock provider for all clock consumers of PS clocks.list of
-      clock specifiers which are external input clocks to the given clock
-      controller.
-    type: object
-
 required:
   - compatible
 
-- 
2.36.1


