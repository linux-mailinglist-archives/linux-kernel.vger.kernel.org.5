Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFD7D6240
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjJYHSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:18:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF352AF;
        Wed, 25 Oct 2023 00:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8mcIAO1BjGFhjgErF0NfLKG1CR8SPRYq/7LH2j5vh9n9+MmHa4H6Beohz6eL/qzFCSeDWrd3HGcVxVtqY/4UYd3KwvPLuR0oBrGWC8CHWtFwKV/XuAxyWcozhReUb18tIEcYSdHykgPITCK0gzbMirj9MzNk2H271ybns/ectgJTUUdRIO+JQuiGTtc8JG3jqKo1mx3JkdA6TurRd50L2IOEoYmHNGmQ5qi7Ez+7ZWgZ18fkYAOCIc8tqMQDB/bJutujuOiRx7thhXTIh+kkKe7AQCkES2VSGyFmqMLhbMcXidAkEIREoPIWFaeBWH30frEPSNWUkiuN/7C+fJcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqiGSVA7pcy6y6bTcaSWgBinfZkLWzxtqNOLmimsPAw=;
 b=XCcoI1tt8c6xGj1TTU7sRIAb9at784l7juyrejRKUfk/2vv/wZcN3nsapiQjfNAS/C2NsuUtVeKIx9l6x0lwEdf/4ceX1/20f/OMBRxwIKFIFE6/w07pTJaiXgYPcTTVLyNlpJ7qcW3NXWx1TTdkyGhQOxboMOEUmoNhQrQ9XJ4KPk5tLsdgt0cPd7IAb5mi4neahKlpxqF6NnWyxJeyFIrxYEAI8DeWTcnm3XJY9fm97Oq4BTSIY5/wIMuqk021FAsV47yCOJko7Cs4NSzovDO7WlIvDBChu55LwV4Y/t94ZT27ZrpuVgA2P4OjG//IUENyGCBxiw9M0eb1+e4mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqiGSVA7pcy6y6bTcaSWgBinfZkLWzxtqNOLmimsPAw=;
 b=dntqu+8pfbH4JtzPnx2gYona5c/fuZeykw0wdF/35mmpf5QqiH29TI2G3eLMWkzKL7CsLuDE6oIgmQqcTjvJ2Wu0NYc2yBOXaA0IQiFrZxGps158HwSQQZU/3CfcoWbh3q3CDqIfeApGncGFsKrkIZn8DNuDJakWzHh8D+672JM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8243.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Wed, 25 Oct
 2023 07:18:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 07:18:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: clock: support i.MX93 Analog clock module
Date:   Wed, 25 Oct 2023 15:22:41 +0800
Message-Id: <20231025072242.1134090-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c696348-a680-44e4-1b06-08dbd52a8dde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIEBShzJKXumJevry0QdB/Hq4IYDo/vRuo+u2/GnOSEY5kh/WOQ5m+AeFzUUe6aF0+1t+W9HvSBYh4jao/9+iXyBVf6nB3QRt1Mqbgpxw+3EASbfaCIOhgRZBm35WKBqS2vNIaYw/GCbQ+jaJcLMgBew4WLqH/HJfDHM6Fxo38GTH7Z4sZ9u31kMgaApLS4++U/AX0QMLJKV8wHXOD/mkdGAbcHcVzuvmXIkY3S9Pc7CkOLUU15DCSglBRzKCucBy1QNbmNNwnM9BehCRWG2su8idNjMx9x5FNGjO9BKT7k3vAJ/vqxODEDye5BIq12ZgtJnJWaiSObbiUECnXsUW8SZbuIzhdbLLJtujTJntO1vOhqUxoTwCC7/pwsFIVwKqAwaLbE42WWA2LtkqSK5XCgi9YVglWzSoUKJD8k2nuWiq+4i5As7PDP6H7maFtQK9GKfeH0dEv+hXrYps5NvbDR1EuVKldKHHlViYKkvsDwg23VpByentgTvZjz5bVUk7KXu7BiaHaS23SpPA+Kb8ymGQejK/t8NDKUvnND6Rp6pH4XxeAfe7V2CfBZsC1TtY1hjJRhy2u3KO6G6/7eIscUcgVH/QTxO7BY76fJdbTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(478600001)(1076003)(6512007)(6666004)(86362001)(6506007)(316002)(66476007)(66946007)(66556008)(38100700002)(38350700005)(2616005)(966005)(6486002)(2906002)(8676002)(83380400001)(7416002)(4326008)(8936002)(5660300002)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89xaCMVsOoUFOmwq7Sy7BLxq6v0cKiVYzhyGAavT+uX7NNpBOzDTMOoDfsM6?=
 =?us-ascii?Q?MxuqW/mq0XXKadL+PVy/f8XcshLA+XYE1EX7u8mgJSciZDUqypPKTH84J23Y?=
 =?us-ascii?Q?Sdr1fstB7g3dctcQJCq/vwWkTTT0AS9ARYUe0XUpeC0Va8q4kstqeYM4o24s?=
 =?us-ascii?Q?eTsn37nmZLXHXDLyRwYpFkT/2dop1Ak1ckE0LsD6uod2mF+wnG8rjgzLMH15?=
 =?us-ascii?Q?Rn1/Pm8b2VMnVv/R1fN/mkgdxAKOd7CqQ4FXXUw/QIFaojqPeC9qgC1xcofX?=
 =?us-ascii?Q?gFpEkIsjktBdIaVby76aiScgPYaBBd+Cb2TKQpNKH3IjIQRluKSaiq0g7/wo?=
 =?us-ascii?Q?X2sd0P2WioppVIzKDwfQj+C5rqaTLzFUZQnHWMs5gnaUNQ/bZm0sMfCB71yD?=
 =?us-ascii?Q?EZGBRYoeCicdQeA6n4Kt/rBJNmiskDOIpIksWLTz4Kze90krVTd9DhKyUKq9?=
 =?us-ascii?Q?8HXRD52KWbQUY+efK8n3Aeb1zTGC9LbQMGHrOFuS6fabu6hP4MLw5OqcHGRD?=
 =?us-ascii?Q?QJyK9ZVJCV+0UvgsmDYwXsJ1XB53qFAWTCUqMNSxBAuMi10bKopNS53eiA+1?=
 =?us-ascii?Q?J8T2bPvssvcxHrdX3QGRcizHWOK3VOJysROnH2B3WnwYUWOXaSg9FSNRgmVN?=
 =?us-ascii?Q?O6oHC5jDOTVcgfMyCDb2hd3rEq5m1TdEnw4N3508tE9BfqIv4xPZVbX07r31?=
 =?us-ascii?Q?7u6JlKONMlNNnxAygWw688ekTLqMu7m6gFOVdeHpic5yMQBy6yCN+yuOUa/3?=
 =?us-ascii?Q?GSlyQhbVBwHwsjk5xguIURtcGk8+ElM783lkJYHa0UhOfXNx2VQ14GmqbqB1?=
 =?us-ascii?Q?7sO+k5eLeyS8zMDpsY8yhyxb4otBRpDNmlxEjGWeTd0sH9g6j523s7un+QDP?=
 =?us-ascii?Q?6OpNk5AXOr30k6uW5kssS8wC/A5J0Llcecmq6rvL4BT7VLp9cgXYsqMMYTSj?=
 =?us-ascii?Q?8TOqWwGkeh+ErHCVsQ3yFXyXJ6FPr7+k5aCfTEQH3bEnxjIjDtDZ5KXjHhDZ?=
 =?us-ascii?Q?mgn+bny5koTPxeY12czwQc2JkxBWg9E4L5KyiUqtdNrIATZ4IzKzAO2nJVhY?=
 =?us-ascii?Q?9Q1w8F/qLJ7+5n1g5B1lrP0rxG80TqlYmc0pxaVMytk5yCGsdCcv7Zv4FAPY?=
 =?us-ascii?Q?WIbS/XNohbIOHy4KDoqa6kzuB9YuGsoNkjc4OccwNltEbB3/H0Jf0S6ao182?=
 =?us-ascii?Q?rRMG1ey0+fwrrWdqi8cjYjdunULqXmivxNs2wcwLRhBmu/v2Y8pvRU5R/UzF?=
 =?us-ascii?Q?Q02OjYmrW95INt3HW1hh2tAxDWFIdy6gdxRAJJ2QXnrJJb1fKbF3v5+5qNQn?=
 =?us-ascii?Q?b+HW12adCGZHYrEoTlDloOnYs07xZXHG9XdCUXWzejBua0iCjG3IF12zBlgi?=
 =?us-ascii?Q?jbH5Q9MssKxJnjcy/5wviZ+zNDxit1lcpCBI3L2uNt34Ib61X53fPKJzAW/j?=
 =?us-ascii?Q?yuE2umR2VAeIVhr5SxYyvKL6vsGR6qWHXuJvFOsu5GYfpf007N7gm6XdKsgH?=
 =?us-ascii?Q?Ir0UUaNvNypwxkwjRFBz0Za1bNXlZ4QBulKY6ZG8c5juEiNJOlAFhadVgXH9?=
 =?us-ascii?Q?PoW4IGkX6wwfMIBDDg0kWipIZRmcBVSU0D9Jq+oP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c696348-a680-44e4-1b06-08dbd52a8dde
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:18:15.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNrPxMh6FjyH3ncHo5Udj/Dl1lVhT1uUTDRlFhFwzMMQHfIQd/8X/EKIZQzPy7llRkgulRCNFsQ6EYi//pVs6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support i.MX93 Analog module which produces PLL and OSC for Clock
Controller Module

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V3:
 Rename back to fsl,imx93-anatop.yaml

V2:
 Update subject and commit, rename file to fsl,imx93-analog.yaml

 .../bindings/clock/fsl,imx93-anatop.yaml      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
new file mode 100644
index 000000000000..5d696ccc8986
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
+  NXP i.MX93 Analog module which produces PLL and OSC to Clock Controller
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

