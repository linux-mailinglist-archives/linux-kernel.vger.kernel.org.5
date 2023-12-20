Return-Path: <linux-kernel+bounces-6671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B497819BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500FC1C225A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAB200C9;
	Wed, 20 Dec 2023 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMdelYMA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0120B0B;
	Wed, 20 Dec 2023 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdKGmpuY0NWfPoIFo/JszWeyyJKXDMn4HucBQxTuCHVldrJTANaPSNfOmGWBGSp/oiSM9tBhkNcCs1C2Gt4yDqsniGV2v36GGrYqNtv37arjBqLdfuvKICd7gbcHgEEVOjVgVDeRzQno/Oa9PsVb1YlBWeDZzYwwBCRzW5byekga31bJvBXI3Xxk36lJjTtnd/8GqzWKbFVrt+ya/oh/Gn2x5fDOwF6o/oCMbSpO+CDDWcVywtRmKTwVLXSRYKW8buptUIAHDpP5IFvit2o/5zfyDXhwyRy9si+mVcQLJda72zdG7p7tQdLhmsQobyUO/IxS8b5zvq6xQvukhxPbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eE2Qeqxp/oaa32udWbI0rI/ZAHBNCVUnrjEA+35UoE=;
 b=JNA6AyK4vN7x0S8Y7wutvFKYahjzkl+imVSbXjb9vepzcFzS8BSBACJ5O8F+nF/pw2jI7MzwcDHil88royXLDi2hSJuInXLJmhWau4JXEK0rTBWMyVbfrR3CMVps0KQxhWoeRcesrEFNTXmRYTYIelCJ6AhveseHUfyUq7wPOHcSAoVF2/iYs+rdqjO+PNeZlKTfHvgqPSv7wUqAu3J5av4iv2nu3nYz1Fn/hK3WRGxbMXpFjt6N76r4B1Q/H6gnqhJWwnfkJG9yxSnrGjLsWPOEUCR2ASJaRehci6pWCJlv08UYWL/j+7ElANvMQGNpLt5UB2il2WiJ9ixoTq50bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eE2Qeqxp/oaa32udWbI0rI/ZAHBNCVUnrjEA+35UoE=;
 b=jMdelYMAXJHhqCA3UXzNQRGPYd+niZ7vEGYVF26G5yH3R46Qj7/d6h+E8vr/EGDVJ47DfkFIFc0NCnBOOgkkMDdym8nRQU8RB5TgC08U5MdE6jF4aaBvd3N3TC6OBd70xd+m/+MI0+AEilCuGp/Q3uj2K2cPH9y0Nc81pUp71NI=
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:00:57 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ab) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:00:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 04:00:48 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>, Rob Herring <robh+dt@kernel.org>,
	"Sebastian Reichel" <sebastian.reichel@collabora.com>,
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/4] dt-bindings: firmware: xilinx: Sort node names (clock-controller)
Date: Wed, 20 Dec 2023 11:00:28 +0100
Message-ID: <9f21ffd8018637c879bc4417e5f1de773412218d.1703066422.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703066422.git.michal.simek@amd.com>
References: <cover.1703066422.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=michal.simek@amd.com; h=from:subject:message-id; bh=5gnHnv3Cuvq9k6M2tQKGUhiZwaFql452UVFoI71Hm1s=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm3dadbgoXItxzj8Qa7PTMZTFruiChm+0qMEHn/r638 1VsZzd2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIm8e8KwYLLk2XxLp+N6K3f9 3ihks2Fjw7FjixkWzHz99WXrdo4XykIPKjfeMtOaqvEjEgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 672db7e7-cf28-4390-a44a-08dc01428fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	anPhqkStC6HzlZyHcZHqy8Dnxf5hLESKaakT/keWHv7TB9d869cURu8nWFNATSVmgIqR2RYr6iRulMw9KYnBCRJRgZwjqan4KM6N+baFUz76XXbgcaSOVxQEtswcgTAhX/2xYYJxpCXuoPk1MvkGTEayuQTD1Mpm5hFyAAXatimnYPnLf2fz4jTlXY+vKpeF1aWrasG8dmdA//x8cS3WClgS5hF0Co+RctGtZRbRr2rr0uq9FLFuXH/ohj1/WU+kubTBKzaBjIZsP1fPmz07kPZLR2vu0AhppgMpme9lPFbCmxGaIQYaevoKo5uattR0bqQoAIOHFhHc1YaxiBlMh6Kl8aF1Kqhv0roLSK1Jsq5trt+SrC1fI6Rr7r7RZjG0ec14CyOceiyQuoDykDA52kOxNGIMApGMN5XljlkfMEfBFfjKLGddaqM3CWGqKs+4KagyJrGWz2hHzreiDidj1NnA9tWzQNccJF37fOtFYPnkhiPqaT7gm5IzGnJ6tYTvv7b/PrSI0iEsf2CgMw+ikyyqQ1Nr2XM8fOzPqgef0Z9+/BpjB04j7hrlQlalihh2cNTemv5ifvQq0T9V/Qr+ohOaxBzZ/9lP0sWCif8OO6lVZ4evbjrYNaIbob64/H5B66jCmGr+KeIBpjoawl8rUzfcCaNNRp197DNNK84njX1qmMFEY3X+37PNwxy5IhtHGCfEqvt6UiZj74Wj+TBv4gNvEWvZfahRFODdz6OInP4s5qtlcc0wpqhF+yjEGEbPKCtRxprfRdk+8YO6Pyvyt5Has/9gxUA/uLnl/t2Y+/8r3ijfLBr7QbXduXZ9HfBMB9VWj27u2SdNdedlv0kfLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230273577357003)(230922051799003)(230173577357003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(82740400003)(336012)(26005)(426003)(2616005)(16526019)(6666004)(5660300002)(47076005)(7416002)(8936002)(110136005)(4326008)(478600001)(41300700001)(8676002)(36860700001)(54906003)(44832011)(70206006)(70586007)(316002)(81166007)(356005)(36756003)(86362001)(2906002)(40480700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:00:56.8518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672db7e7-cf28-4390-a44a-08dc01428fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

Nodes should be sorted that's why move clock-controller to the top of list.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch in series

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 310c334e88a2..d64033140c53 100644
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


