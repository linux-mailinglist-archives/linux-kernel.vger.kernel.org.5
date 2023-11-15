Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9456E7ECB00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjKOTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjKOS5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:57:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C524BB;
        Wed, 15 Nov 2023 10:57:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgJoRJSn/qTaCC9HmMdXks0qs7cyJ842H2Ny6oe40L0JrlIvLJdJxIffG0m2MPRCDfMgSVA/sXRFWeIQPFaIHWyFD3MFksiDfiKHOSju3VbNYSJTqlkZKH3RNQ+a7HVO2ixCudh0OxoN38QxfGZfRG+1nuwvQPsUj7REy3ZGKIq0WXmdY9Q1olZriJCJOud/qZJCUHjT3DgLPmCEUID0olFjH/iFNr4AZJFANlCmjVD/i1qtPiKkbepOLlGjz4wHatDRVi0Nztc9RIRAQtu/Fuh0LQbJuxPQ76YCX0RR6cxzF9pyUkGgJhBCbMI2a/6P2I4rqSB0SLSpOfY0zii3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCeq9rYC60MvE27UBiXBedCCgAAHf07j36Ar1CRR1Hk=;
 b=C9lqBa6yQYgDecesu3IPa6rGAHryHdI9qyyKhUiqz44jsUOutH9WyDvXQL1wf9v6Q1cqprSEXbAzy/JbWM5eHrHwDpzRQ9A5X+wjoeFSVKqYx0sGC17vI7XCj3yXmyyeQHoibTehwiY/4/dJg96giVVXGFEHZjMXE8deVGWENQ8d4Xn0iBXH8y90m/mjqBw0egOmOdZ6ZVEKVH5kL0a6IWfM3KHG8PHm0l6eIyN9Q/HyX2qP/R12KDvcfY58PPt1ac4JA8YbKT3Wwji8slQYhj1OS5FZycJu5W+3m7WTVxTHsPKWW2Zx31QB1JX/vAXHs/AcM1rJJTO+QdbhNX/PMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCeq9rYC60MvE27UBiXBedCCgAAHf07j36Ar1CRR1Hk=;
 b=mooNw/q9UdNwRHbgwLw+aUXitvYQY7DvnQ4EvS6foalhWu1sNyKJ4IemtBE/vyP4LROtHGKEK0kZ3ySOQiNASZ+ERw446UpFzHxLPTmF0BvFa2Ar6+wr1yPYxaBoaPwZmj/Olj1xSBuZKT9oYG1wysPnTo8a+AUTUPtCb2FzFpc=
Received: from BL6PEPF00013E03.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1b) by SA1PR12MB6775.namprd12.prod.outlook.com
 (2603:10b6:806:25a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 18:57:15 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2a01:111:f403:f901::) by BL6PEPF00013E03.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 15 Nov 2023 18:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 18:57:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 12:57:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 10:57:13 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 12:57:09 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v9 1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Thu, 16 Nov 2023 00:26:51 +0530
Message-ID: <1700074613-1977070-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bb6ddf-06e7-462f-4291-08dbe60cae5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OPVpEpMinL2swoEyGy9JJ0GG7qbJ65Gf0ROIyokGkBrituxSuO+wG2D7FZq6e4wxydZJrRxgOwvRqjL5nb61L0ac2c1JCBEclqF2gNlRwTHLVLYWM+Oqnk3mjLZPfia69Pi7A4PmXKGUG4ObCrWm5b6CxHhHSGcQ5e2u+5vm2M0jb9T29nGs4bCBSbqecz7zNwX19IX61hiSh29xXKU9JyfB+pHujP6tWOR7m+OB/2rqHE1llbcgBoAhuGNHSTztXhtE7JKAiJR1ok04vPkVChUyEy5uQYZgDZqsKulZpKCrXhXAvU5MX1s/BzSMBKYQugenrCoy5WIW0P0+Sgbar6MjMDY2zvFl7SiJkqIzedMBt+UKP/pg3qX+Zw5TzFAXwH8dedgB5xzt90uNAAK6m8PQnIF4/c8EaY1NW5oKqYWRaef+oVCKjrYuwv4mKN6sw1pctAtca4eUmlUgZIgr+fRy7ytIAXn0zNPYeHtrqmfUiLqGeGZzclHazVtjGZeNKpsLdAphMKwLo4Cha3ld4ogOvZVrpJaeFgqVD2bD2oeFvco2JuzVoTSoZsegd+3Wito3Q8em4WSyqQ8AMxdmVADsYFROv/RBTpiRgXqUQ/L5skTvewBn/uMnB3jPUu4qrBsLd314q4FfPqSFLy69s3Kqe6UMtQp7+l5HPtlQv1fojuS2DuD5A9RS9KSBhL/Is8aVmLfjboQ7CXnGrmTYK+krqJtl4+PzoCQ3vwrqDdeofRfwbtvlxqrjL8MirxzaVbRNqe6WWods13uw6mOnLPE6ZuxA4BhliBL9u22CP4sLxU2h27L8DrRpWhxg9fkLzM9DRLZ/ZL9T+B5KAyzQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(8936002)(8676002)(7416002)(4326008)(5660300002)(40460700003)(6636002)(110136005)(70206006)(316002)(70586007)(54906003)(921008)(2906002)(36756003)(41300700001)(47076005)(36860700001)(26005)(2616005)(83380400001)(81166007)(40480700001)(336012)(426003)(356005)(82740400003)(86362001)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:57:14.1594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bb6ddf-06e7-462f-4291-08dbe60cae5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Changes for v9:
- None

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

