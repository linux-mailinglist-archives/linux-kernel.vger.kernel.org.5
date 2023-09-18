Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C7A52D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIRTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjIRTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:17:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9763111;
        Mon, 18 Sep 2023 12:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAIjX6jQgOYsvNhJFN6xgwHlCKRDmjApf84JW57dd5dS6o/t/ghS9x8HwTDx4EeZwonTAvDnCTMjkkXIEM7RsXJ9zrVo36PlVz++OVZkftO/56B+Ax3onwVwPoX1l+wG5ZUzl24YxxwTFlVbO20ofrZz8uQnG7Z2lHHfToTgr25FxmJRcLewCB8h2Fp96Tj/UBocWzcp/n9ATvTbAYd+i+y4KkJ59n9q4SvD54VnlSJII+lzX+Acaoup2WjQc5Zd4S2usHPXuxAg6N7Vx5e+mszjAMYt4EXThuVa2taIST5Rj0JmFcsQgUwM9jNF7ni8yIJc2g7rA1QuBdCgBZnMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97WTCv3UYjCYVPRgCYQ0Ht/wulFsAr29ySQMWBkAy7I=;
 b=XbjNRCntbz+e0uOs/DlgBCOOYU1rdZx9Y4ONfRD0psMuFa6HzK0NmZsb/WxzrquBGZlzodfgR8bGUprHu97OpNkNPi3/rVLoi2RmpsBI2bJzXn9HMB+zaUre/JxxPerup/xfLY2FCHr+IbDzC4QwsZnnrv+/C7DXdirGR2Cd0W6Y/r/fFmL1M6VQLv/pJQ86LMYLPgnywSwlIw6KK1/NpIT5D0UgAXM/7phFlr7orOtPLla+dUJjD8wtKj3Qpj9K9mlyeja4Uc4AyzVsarfoqncgr2kprrcw02U/QGRK6/ZngXma+uNkyCIzD+aBi8KMDT+TmkUpMOddc2nIVGS2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97WTCv3UYjCYVPRgCYQ0Ht/wulFsAr29ySQMWBkAy7I=;
 b=HdLXyFZw5cK7IdBYHRE50Mq95GOQnq5ket26wwE3pi0HcaMu13wjztKuAcilI05LVwYwkQsE+wY5shICmVooDjODYw+cg9qmsqA8CXqTbTr/dw3Qp1zzdy/ZUohDShDT5ANrmWkAQ8fHWJKYUCWpikkQArs/WzX5VeoG7YA63fA=
Received: from BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 19:17:51 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::bf) by BYAPR11CA0053.outlook.office365.com
 (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 19:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 19:17:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 14:17:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 12:17:30 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:17:26 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH net-next v6 1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Tue, 19 Sep 2023 00:46:53 +0530
Message-ID: <1695064615-3164315-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 04294eaa-85f3-4a0b-1642-08dbb87bf3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIC3fEHTrFmPxKYf6MhoY8R30jcnCxevW/v+0AtLhgWpX9mW2R1OO598ikks0EHFU0RI4K1poEfU50KEZbUfmceSEufR80kJ0zTvNd348xZWkXJgtkFZF22AHgXLQm3t+2UYD5LQ1h/q9LEN0SV0PlA7A46s2XYTxz+0jEiXi0tvPYjhAkt/4iVNF6reELfZvth1XWYr/Hh8enVmUH9Zfwz2A/qLVl5MssEdZkhKM23VONAtLBalLrdJC9pfHXT9OCq26mOO5h9OaVlqJ4btHf+cynKiBv+i1Q7iKFJVA6pSWiY7UwaF9V6ijR4FbXX9cPdzgJSfw3GJB6vqdo5VJTC0IN+40IyqvszrrEQQ727T1U2kDnn+XPviceqeV44Y2Kwv2JKZVqwwnTe+d6/beSz+yd9K6OXdJiKOqqaA7gXxVcUSFcu4JW70LMirysgaRrpJHtv8v8jdYpMxESQwjjAGdwuV6nN8Y/BEeLtCOt7dMMgJJZSoJq4aXKD5NBNIfd75x+MrKSjScvQYeXnT6HPiVk1hwjWaGbsZ1Ch3BeU7bB9zjNGvIPEMUBODJkwefwK337KhSPcnFeKRW701xQ0m2K6bpzJixA4MgGD/vK6NE04sHuZPaclmHYa364VhmmtzZ8z9wpOOprnWJGu3K+jL4bOmz9cZ4d/NUzvbDONP0JoJXIb405P0rd9xLLqEjNa1Uw/xo8u9jV3cjHoKG3Vsin9AfSnqyw/6hfzcnYR++4UcX+TQ1gduSWkJrPEIZ5/AW8wlSzUBOEfLeOjUFWgdN27XkqH3afZcbPYZiEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(70206006)(70586007)(36860700001)(47076005)(316002)(8676002)(4326008)(8936002)(41300700001)(356005)(921005)(81166007)(478600001)(6666004)(83380400001)(110136005)(82740400003)(2616005)(426003)(26005)(336012)(7416002)(86362001)(2906002)(5660300002)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 19:17:51.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04294eaa-85f3-4a0b-1642-08dbb87bf3c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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

