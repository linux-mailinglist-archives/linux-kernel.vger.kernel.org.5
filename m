Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023F7CCC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjJQTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjJQTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:18:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5EAF7;
        Tue, 17 Oct 2023 12:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu/zzrz1RtfHuk9yc7uREz8Olt4BY4cxhevckNQslsYYUehqDqPPMrsn0XIANjS+euSOh7C6cFKDq5ew4G78OsVGUvu1NAVRFUKL/nib86nOxIHyZbu7/AD8twLsxLh/iwv/khp5Ps2Os5qMszJrSSf/2gNR7yAUPbWkiM2UHGI6zJtIYUVhnDxwN5pi0gWAHS6Vqe9eFoG58m9MLCBLU+tldFNzrSBK3j2RsSJefKmOKwf/fIrPhi0cBf05kT6i7C5HCOJyXFSz5CrKh9jpO0fcwYUGI+oSZIjEcFVWb5Umuolsb5JxbfacB7/dnL2AXvDKgSzNTHceMQ+ZzrwdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqx+k4pTVjoEdFH6iSQ6tE1E4+YUtZ56XErOo2z3TWE=;
 b=VVbXU3K3mSEXLkqhJ98pEo+pMe7zxOrqEo6BR0WsWTanM7PpKrVPmXXS+WtuDBsJc3388a0kajYc3mO4aGsd+3gipBtgZ/vtPknX0MatsbvcLNyymktznVRb6xWu+5xK9XOqM39YOKv3prEgdDI526YmXSC8rmZnfzXTf1WfRdvtdgq3Q0nilPWfemXyQL7tw/fXA3yF3m8xfZX+amh7xjkflEurAJJrIaLP5h/nRyeeEE1dKCxW4ZPS/hYz5lm6VFPq5fndWSO7Ic8IgJIO4KrovVEPOO0fDe2j6kKOVKwAtEopnmhhgrokby03CpsJT5E83KdDEZXQ/lg51GrXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqx+k4pTVjoEdFH6iSQ6tE1E4+YUtZ56XErOo2z3TWE=;
 b=kGwObfjotdNI3c4T18VSqBkVYgnrGm9UFim/Cf0PQ3QGzruS2r34QwUp87AlpUoIXxXzOftUn1HTH9I48cvmtvnIcVKO3rraP+CDtME6PyV2E36pjw+3HZRzfjfjTkw8Mn9FZRg4NZZ+FGP9a3gBVk37o3eckODt7TsPEseFh8o=
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:18:43 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::97) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:18:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:41 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:18:37 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <linux@armlinux.org.uk>,
        <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v8 1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Wed, 18 Oct 2023 00:47:52 +0530
Message-ID: <1697570274-798170-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: e06da152-fbcf-44b0-254d-08dbcf45e069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iC7X5gXBK3YXHRBTvd4LMrACTMaST8bqZ7d1+Sm6gRyrcSP+Fe01vfumo9N9/srZZSd/aNg8a9wFweVyLWDtN6oO/2sX+J9UZIRzA2RYWY8bZFnhlpyjGxGXkhNHb5/0AhkB6fOPjeH5mqn3oQr4RvV0dvTh/oIZ8Jp4f+zcP99O1Mre0LvLoub2F71ZJ5pyaV69DyhmaCYgDbYAU+TgqcPxZF15MidSl971i1KJytuhY+doYEP6sLnhId4v3E8xnzyiljNS+ZoQrWNyyYIzdD7BkrnKcnrxRjPCEUbsXqtYVYOL8LJwRadiKiIFQyA3QJoS1B0kgz0dCG/hZ1YKeYmarQV/sp0RLLASUXXSQv7D/NmDkpDLyFcCoEPaOoEr1VeRbkFmvY85RTbdjul6WgQBjhjE9LVdksruco0fpQuL244HTjPT5HWzoZjXPADW/LDZHEEeMcFtixWc/JRgHkSr7QB5w9zCTVe0sXOKh+ZQhUkme1s0PqSRGicpBOzJkGmywa2rrnIwCuYYJrVcfVId8/OsKfBvZ3PajaW2x8pzjNu4hzEksHlxHggK5Fl7wNe1TKSkAVmcCg46jFfVU6B+kfvWVtcwCrXCrwRjGInPVgwV+hbhxdxgnJwlNnAadRbZEVHUmebbGxpnlOb/vHfJNe/zCBRnXJSQ4OU8fUjLkElavsbIUb6fQMolRAqRvy+XiVsg80Ha/9+9ODf6fSpdlf8QNngTsfgmvFrrbYVVb07S/+5QLrYHK1vTzUhj+7Xj3WDv8ebKz5pIdsFZZ3yGSnJvRTWRHhbQX725t6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(2616005)(40460700003)(40480700001)(478600001)(54906003)(110136005)(70206006)(70586007)(6666004)(83380400001)(47076005)(36860700001)(921005)(86362001)(82740400003)(356005)(316002)(426003)(41300700001)(26005)(336012)(5660300002)(7416002)(81166007)(36756003)(4326008)(8676002)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:18:42.6956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06da152-fbcf-44b0-254d-08dbcf45e069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx 1G/2.5G Ethernet Subsystem provides 32-bit AXI4-Stream buses to
move transmit and receive Ethernet data to and from the subsystem.

These buses are designed to be used with an AXI Direct Memory Access(DMA)
IP or AXI Multichannel Direct Memory Access (MCDMA) IP core, AXI4-Stream
Data FIFO, or any other custom logic in any supported device.

Primary high-speed DMA data movement between system memory and stream
target is through the AXI4 Read Master to AXI4 memory-mapped to stream
(MM2S) Master, and AXI stream to memory-mapped (S2MM) Slave to AXI4
Write Master. AXI DMA/MCDMA enables channel of data movement on both
MM2S and S2MM paths in scatter/gather mode.

AXI DMA has two channels where as MCDMA has 16 Tx and 16 Rx channels.
To uniquely identify each channel use 'chan' suffix. Depending on the
usecase AXI ethernet driver can request any combination of multichannel
DMA channels using generic dmas, dma-names properties.

Example:
dma-names = tx_chan0, rx_chan0, tx_chan1, rx_chan1;

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v8:
- None

Changes for v7:
- None

Changes for v6:
- Added Krzysztof reviewed-by tag.

Changes for v5:
- Modified commit description to remove dmaengine framework references
  and instead describe how axiethernet IP uses DMA channels.
- Fix "^[tr]x_chan[0-9]|1[0-5]$" -> "^[tr]x_chan([0-9]|1[0-5])$"
- Drop generic dmas description.
- Use amd.com email address.

Changes for v4:
- Updated commit description about tx/rx channels name.
- Removed "dt-bindings" and "dmaengine" strings in subject.
- Extended dmas and dma-names to support MCDMA channel names.
- Remove "driver" from commit message.
- Use pattern/regex for dma-names property.

Changes for v3:
- Reverted reg and interrupts property to support backward compatibility.
- Moved dmas and dma-names properties from Required properties.

Changes for v2:
- None.
---
 .../bindings/net/xlnx,axi-ethernet.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index 1d33d80af11c..bbe89ea9590c 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -122,6 +122,20 @@ properties:
       and "phy-handle" should point to an external PHY if exists.
     maxItems: 1
 
+  dmas:
+    minItems: 2
+    maxItems: 32
+    description: TX and RX DMA channel phandle
+
+  dma-names:
+    items:
+      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
+    description:
+      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel
+      Should be "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel
+    minItems: 2
+    maxItems: 32
+
 required:
   - compatible
   - interrupts
@@ -143,6 +157,8 @@ examples:
         clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
         phy-mode = "mii";
         reg = <0x40c00000 0x40000>,<0x50c00000 0x40000>;
+        dmas = <&xilinx_dma 0>, <&xilinx_dma 1>;
+        dma-names = "tx_chan0", "rx_chan0";
         xlnx,rxcsum = <0x2>;
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;
-- 
2.34.1

