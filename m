Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8115C7B0C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjI0Tdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjI0Tdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:33:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2610A;
        Wed, 27 Sep 2023 12:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmSkorrYYxVu4jNLEwGogMHlHDTmkl9m1nWb8XRkytHfk/uhF4xZtKAzy47tBNjDDRlJSMmCP5w1+GA04fmUPrjHGKd2ketwz3AaKoz+r/K4I4tu7eDxqR/O9gRe3RahRJFaG23DWP0CpOZb2ApvPnsukNGOAwVxpexvI+g7/50+/dzL1+LUqJ/Pd90I8+XwIbgHxWYzKqL+f/CMzQvl5177h8fMJbQGa8nApbms1cXYhhjII0+Dv1IdFuDvbCYDOMnAMn439uM4m49QbTeOpVRWeuFu0LCYxywm3QiZhe33Q9v8n2eomoqT5K0UvMKSCM0LQyprNaswMq2MIGasJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEKXEX5NX5XP9ZwMCwPSfI6TdSgWKqvM/LNmwPCxX4k=;
 b=llqAOtVg8FJMOU7mWQWD6UiuO/1eBRsbsVEpGgftvTQmFcQ23Prh7cop4PQT3S37rqY1Jyhf9BYjDFOC3pHmJEaQBlrnDUe/+tTl0KKmPIYGCiOAXtvOGcTsvB/s/i9ehd8MsJucuLDhXBe3U6WkBdfNsMAw+Oyu0RnynZaK1bwCVHgk4nPKV5H3mcsq8d3MX2twaZP6fYHaiBiWMxll6tPkLt8VLQ3n95nhCF2rnDodW3gjqAFLsbR7HSq4a/pfC3gCvmfk9wB5xwz3dupozqNy//jU1cvwTxPFhivAOYvaycpwIQ4olQ/p/Ul+RCOk9oSW9v8sCu+qCCszwTSeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEKXEX5NX5XP9ZwMCwPSfI6TdSgWKqvM/LNmwPCxX4k=;
 b=5PUiErn+l2U4YEXPd14fMUJJN3kX5rKZYURMAFQnmU7IF52CY/F2oFnNuCQZ1/6v8XVQ/HaxNhboPj6WFD44jw9dnKRzJh+wbJi4tRG/khfTqLiqi5W8AVs8QyuAATpYXBt7lteRqa2acMf1kWKA/3SIakyuoGEUSZmgdssNeCk=
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 19:33:37 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::34) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 19:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 19:33:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:33:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 12:32:52 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:32:49 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <linux@armlinux.org.uk>
CC:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v7 1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Thu, 28 Sep 2023 01:02:29 +0530
Message-ID: <1695843151-1919509-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 74700393-9010-41ff-9b67-08dbbf90a547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lF9/A0pLqjcGn5vuMFuURHZAJVAlyssoy4Az8mqBYaVyWhdRyGCmMWm1f5CRqIwJj9roKjHnhIcR11AJUbUMLtMyR/Qy1aZ5w/YshVygSnbuAhE5xmKa7geHJ6i97LHK4SRLCTN8JifQssLSSrtFn9ZdKZdI2RlCHC6G2JMGJFI9VApdkteyDe/wACRceZQ3tF6GyTAwXo9hS/MRIoZ/DjkBzpGw9psB5G4Rk+uORfvNUVqcv3zbK0/IPd6EZK5nm2Ju8Vabxs1OAapGmnovXHnzIkodDfNLwBWX4syE625UorJ0EDtxqRrv926QlXa0Lqp9zPcNKIirKOcUSd7G7B/AUHks+y/ruWJSLvvOADeNTUMZhAeM08nPfNNkfGnAMO4rluw0G4Ds+Nxyb9SMDQTjR0X8t7USHvigQFlt+GdNpK29BooO7dGzpdKP1XWCw3NYK1W+8P/zYwl2/oVC5+mB5Mf0xfDsVKWUS0TZTyWQW/01tuu84728Mdi3UQlj8MoxbyoNOcQKXr8cmDtimp58zM08OUu7rEXarTxnDGRyKPqhL5lfwY6YAVy31y9kzai5ZYl8Xwdtl9fkGt9apVLe2DMiw5L1xxySbEGgE9mI9OMp/c4JwjtH/FtWSPv5W/LR9lCtw5KeE4vqj5/VNIOG0qVcCXkIPX/9a9SLRkHIV4/NIgwkdnqsSGAtO8V+fr12o5tldsSq/t+HlfaZk5XUmrke0hSMWtayjIRiCm6bkjApKUuNrDG/IhFCF4LUnxWp0UXEoGRnEuhX3t0GlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(336012)(478600001)(83380400001)(2616005)(426003)(26005)(81166007)(82740400003)(356005)(6666004)(36860700001)(47076005)(110136005)(70206006)(70586007)(54906003)(316002)(7416002)(5660300002)(40480700001)(2906002)(36756003)(86362001)(4326008)(8676002)(8936002)(40460700003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 19:33:37.1561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74700393-9010-41ff-9b67-08dbbf90a547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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

