Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74F37F25C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKUGak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:30:39 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8983E8;
        Mon, 20 Nov 2023 22:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjprUtNuGW75w0vno+hZcIbG08Mr8PiECCxxtrU8hVV1KDulwsfYVX1D9+R0cHLArAH1+o7kIcZwbT+MCAFcOA2TlwQn+uTvVTzpAYQTDrRNXg2AIOpsA4MyPJZC0Ugj1C148tkOiZZOdj8BS45RAox6vWXKmiQ8l2ioxA4sAIt4UmAxpaJiQA6hYPjOGIeJmSrnCdeqwHujAQRS9/nYjJe5X1JgD9vfV915xyBzc72G/28L0GLRLaM6xlzrrHx6LlblOJf1qUg2hcofOM3RRnte0lAeLwo5Xuy01DLu2c2m+iYP7kbb4MrO0nkKqpUAZwZHd21YY5a6AGTZZaTxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G43pdbbacOMqBgS6Gl6zc6QrAPwhtEDRt/w015qnGGk=;
 b=mZnkZobRoZ+kHpKXcJyNoLLOQJdWAnVHwVkh2KXOmjY46txVmIDaF4etEeQif4iz/Zt8xWhqw9cLed5Vx+nSDJ/BEOKfF918QsaRd4Fn7p+rwFubJRyeI5iBpPb0/6noZyuGHq/iHPohYxYb9hoh/dL4O1ACHum9UPD9qwTqGbaqKtNyO0z5IyhwwQ9sQ34WwghtLn8OyKECHep4+z3HWoc+vkDlN+8dYSsMZaEB8jQTTxST1A7Whk887A5CM40FXLzW1+blFdrxQPsxNRcWG/gKZ7FWlS0H4cZkhA+rfNcomAjJGm1rA8CeL4mQRYn5WnGgJkhXsh6Qzwi/j289oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G43pdbbacOMqBgS6Gl6zc6QrAPwhtEDRt/w015qnGGk=;
 b=gjbzjvjpbHVbvry7J4bcj0B8YnpHspSVcsZ9nRzWlnIwACN4YoF1OWIiG5aPDIdLuddGimqPSYYXKGp+ZpYzGXYKPhXkBO7clRHKKVyyUCxq7Rk17kmk0UdmmzK4PiGpEUsqX3Jy/OxAzSYgQ28R8CVs5awOkM7ueS4ClyW/h3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 06:30:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 06:30:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V4 1/2] dt-bindings: clock: support i.MX93 Analog clock module
Date:   Tue, 21 Nov 2023 14:34:45 +0800
Message-Id: <20231121063446.155300-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 818ead90-d3bb-4b6a-5c85-08dbea5b5bcb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djGOaRRfN2hU3LgerbSVvWYj5s8quDznUzJeEhm3bqFDeeUr0eTwqbPr37ClzAr6dAMIrGjv4Yo7MQ8LrT6CouqNi/lDCOJmg4KJMB+x6o1zaMEg2Yv6EWjFVJNhFXQgxFUeMuARt6Y8bRc+cUfWlXp2yR9szxeb65rky0Qn+SojYcdRk5ITz6cOeFiq62s0kghGeWUJZZ31AXAYrigfBCtZE5okXfNL1bd/27hxFgoEJCeZ03z282c0+L7mSthMc42hqz897cp3uqc178pnR/iquefQWUQaB+chjheY0D2YRZ/W/UIUHsABByk6f++/04vUeyXVRDBB6gd/fyI13MNRXY1mipewIzHMX3Yca4rFDfnO0QAtV87PgDehsheB6rWGhCcSFwGgNzx2XUN9gtFF6cgsqLMZbgNjyE7udz5YdGQHDmo+r33QbGbk+oBY/CTvX7GnUn6kalB/ADo9DhO4flu7STR7s1MrrBVl7/BGElVW4np+JtTCpNUyXk4Ec+3dLhtvca8G/tKhmCLPu/E9H0sVs5MaQl1WG4veRS3sbiQYbQFXK95F6NDLCtIyqn/JjTZMT7s/7vAnaJuc850HUqaHvVWk6VEL36G2ZRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(4326008)(7416002)(8936002)(26005)(38100700002)(6666004)(66946007)(2906002)(54906003)(66476007)(66556008)(316002)(86362001)(478600001)(5660300002)(966005)(6486002)(52116002)(6506007)(2616005)(1076003)(38350700005)(83380400001)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Bj4f7eb2Z4fZ8zoVxaOcu1OIbRL4HegumR8pt5GVZEqBosh764OhBe2yTOb?=
 =?us-ascii?Q?5uee2cKVD6b2Cq1TCB2JbRM8Rem1MxbF9kd1FwIDbKnHHE1Hx0VN7Kv0xGm3?=
 =?us-ascii?Q?Yxm0ujBFRp4as7d3xiq8ktJiOylzSw850FdfgR0CitMYSmFbV5gY/Bxz0tm2?=
 =?us-ascii?Q?2IApiCPUyPXT1KYpJjQ76mb6YmgOzhDXzsSyW5MwzTmp6yGNpxIFFVmrAtec?=
 =?us-ascii?Q?4ib8RWBhaqmzYatyTY0MwltS5xc994Ytv5D/6PB8f0PEnT+5ES+mt9w+O1p1?=
 =?us-ascii?Q?ocjLm0EYz39nTKnR+IlmZLaiSka/13dlGgMrl/G9KfnvFkhdKH0FBlDelsWJ?=
 =?us-ascii?Q?Q+MHp9Pfor3O55ZHoPx8DkidURIbxOfLfTgQ7+4nEoLkxa7GGw1zOrOWf+l/?=
 =?us-ascii?Q?w703kUZi/QAgDnIWwHN9WhfbnTAPiRCZKJ0H20X6jQAxYsKPn4F3q9t2QfhR?=
 =?us-ascii?Q?SGTPvq+QPsmKye8nqHdOhSKIh/BtURm2bDEYcGn8fP656jws02iF9kcRhaQb?=
 =?us-ascii?Q?7wZkDc7SESoEiOFj4D811V/R6TFoYmnHmRg0EMghDJqajIrDASpuKmT4Pdrv?=
 =?us-ascii?Q?9FO6iPOrlyOot//15iLTC0NMCoPgtRAv8wqPYTPPtgySpE6Oaq/sS20u6VPo?=
 =?us-ascii?Q?ahXYLo4O6yyz6bDmzRVoZiY3to1NFA59iA6w47NpzwDtzhBhF1g2yEx+5x4T?=
 =?us-ascii?Q?UnudMG36STnBcj7DWawvKhksBC8XIyTnuGY4Oxu/FomMVSLmBaG5oSQPpDxd?=
 =?us-ascii?Q?BmB6jqbpeYExTwGjCqC9zjFE9lmV7ByHKzFSl7NKiWXLACPdad1oH5WfSlHW?=
 =?us-ascii?Q?FqvpQ5sk1Ev/YzrnzMoO1KcnHH/EAttXsV/SmSCxXaz007d34zg4Kuj7/yI/?=
 =?us-ascii?Q?XoGKhW+TFgpOG4Rsl1qers9vqBz6Y2ZKdqz84xDhSYmK8ysJMyvo+c7EDDeJ?=
 =?us-ascii?Q?ifFHJ9Ad3nzb6y5QC89frm9ZImPGpy+9yvV1nlK/npz50kX1pbolP+TCQqTY?=
 =?us-ascii?Q?CpFAoQEfcYjzhtMO0D+wagqKHcDBiip8kYbTAwTJnDax2wJ+mVsLqql+cqF+?=
 =?us-ascii?Q?ARdFi21SoDD8DlaGb+yaG7MKNV9oJbhsyhjk4qRHuILzcuYHTGlOYyCT4f/U?=
 =?us-ascii?Q?ADRNa0RlEAViq0/V/WfM8bdkXL0m/VoY3/VacE+M3Igns1szueXI1ybG1wM6?=
 =?us-ascii?Q?zgw42fzaDK/KV8dkumaPjZiyHNHOhVJlfzCTAIhj86Nb3YMfAA0GEIUw9nG0?=
 =?us-ascii?Q?zHHJy2tGe5lMQzpRdDDr4Nep84jM17iw8LtKhErGS42cF+LMxIUkbR2J7O2i?=
 =?us-ascii?Q?O5zC+Dlohp1WHYGcNfEuemGhHVLOPTDB553OQ2J8CLHyjvVUFhnvJEIrXFAI?=
 =?us-ascii?Q?N9rzH22nOOLdi/QE39G8/xQX008GDflgYaSUTWreljYkeWmB95CLV4u0zhOn?=
 =?us-ascii?Q?GY1QxIEk+jiBZWYInuDQx0r7bGv9E8yM12owEsEdZG7l8Kn0DLYJG3N4iAOz?=
 =?us-ascii?Q?UL8BXimWoDIqnEtWGygClL25G8XMkZNsu91MkYGrRN+GvUCi6X+HmyfIdX2g?=
 =?us-ascii?Q?cuhRTZLZQMvWiCYPOcMuI+yK1dLE+/EWVo4lsbpl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818ead90-d3bb-4b6a-5c85-08dbea5b5bcb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:30:30.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vtDnCkefuWSfZQaZcY4V8ExVn0j8LPnfT4AmsiloWImRlzZHl0u6XgD2ihaIxt3tf/a0oWHHrdK935TecEebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support i.MX93 Analog module which contains PLL and OSC for Clock
Controller Module

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Add R-b, typo update.
V3:
 Rename back to fsl,imx93-anatop.yaml
V2:
 Update subject and commit, rename file to fsl,imx93-analog.yaml

 .../bindings/clock/fsl,imx93-anatop.yaml      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
new file mode 100644
index 000000000000..253ed6c1c771
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx93-anatop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Analog Clock Module
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  NXP i.MX93 Analog module which contains PLL and OSC to Clock Controller
+  Module.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-anatop
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@44480000 {
+        compatible = "fsl,imx93-anatop";
+        reg = <0x44480000 0x2000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.37.1

