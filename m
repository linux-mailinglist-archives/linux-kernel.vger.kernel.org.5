Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE17DB729
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjJ3KAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjJ3KAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:18 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FC199B;
        Mon, 30 Oct 2023 02:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/jolEP+1HesFZNAFFM/atIcfHGSWRRRCP+3Vj20Jt+92C7/5xV09rLAQ7Bkp8nF1nq9VSuHiKlLFHzvvRxj9Tohfn8I+J+RxqTeHir4fw5Fbyh5bS9wKHHIhQjY8AybYXzFwC1q+YxZ8WxJ9U+Otz8gWwFqgKUsoLXiDft+SOHRurBPfecFGBST9w2pGZxzkilaQBvAQ+BOXojDPQDTttPGURY2hQlm42W8VKstrybLZTwTWXF51HntMykzDuWgcu5ZBKDGphkJO7obdqqy0mnqi70RWy7XJYiC0qHFiMo9Ywuv7Dc5CviDTvSyWYydWfCnElV2hKthdP4xS/v7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jOsfYW5YiYUH97W+EJOHzghkLPb11X94CYd1L8+SDc=;
 b=oPWb66prv1+Eb/oVTbFhL3251IHYxmS3nDzMCE/qod++wz9mAy34UnyNRYK0INUjt+w8s1H3nLZ0PF4IJ0bRzZoNAJ1wnP2jztMpIMO/IOL1nemukWLvRCCP0kt/U/+xc8X1AQmSv3Ez3Q06EWwPMcCW9bsvXF5IXyy4tRWs2oz2amJQdngZBVgd8XkPPgg7Gq0e2gY2OAQzQDG7gGpnslM/67wYT9nEIS5IVaPQuqKI3pxh8YHIwEsA77DRthKvlVFNlQaA+Ju6vDG8ziC5LnDqIgC8F+984KsqPc30PfwC+1OrYW/qKTw5bUWbdlHP5Y6PnXh5GPDBHYxy0yUNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jOsfYW5YiYUH97W+EJOHzghkLPb11X94CYd1L8+SDc=;
 b=FNHwWN745riyWT3aiWWxMQ5tGdld5UjQ5EVMakVH9/Ep/X5VPPR48tXLTh+k8hUSOKi81Q/uOejlmivt8mRPQTUZP/7Sn0Z7AOY56eyZoXBQx32/nBrBrBvORrHUGk/LWltSzspzvDdW7AMn/iLLBLiHa8XUXsb64XAW9rMcdnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 09:59:39 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 09:59:39 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 02/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Date:   Mon, 30 Oct 2023 15:28:40 +0530
Message-Id: <20231030095849.3456820-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d74eea-b453-43f9-b611-08dbd92eee8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAZtpw/N2g5H2lovU5fWQK0TBM2ylQ4S6eXV0oGrjXxgAZU4WZNK582itZpETGPD/kqvl62Mk8pn7ixeXt8AUvxq2osTS3WE9etCKQ2akNciH7XCT9rNNvxH1F+1CZIOh34rclcNkDWzUHLJPv3OvncC/uC4BcN5/O+n+tM0vE4J7DfELXGmg9rs4On2CaI08D9IXyvdxQOqBfDcmmylRU3HF+4kV3RpK/qwWfeAnf4sigvVel7dCCxIFfZmaSGrVjrcMmh+tP3/5eVeFIKF5Gl+yiDVaOTx6ln/TsvUuBwaWZCi+2YIZutyfTWM24odmZZOvO3QKG49zu3mOsThkwHdPqk6mPL3ig+T/H+4RoEt+betKjvkBLbte3VRQm8emrgQ5hVZNwmcjyLDOC+c+0zQipSTaMuXpzQIG6SjOkDOX0uARrle3cqyNpLPWnw9GFzrxt7pjntO9riloy1PV1xSOhg4u2v8bhegc2QCTfyT+aGy1C7mt+PGA10nXpCE7t4sWEGHhVU38ctxHBNYcwEbD+GdjCF1bEs4XXU/1soS7YC8ISSDSu40vdsOt/Cm2scUwzC5j0nwragFUlLv7oPxeAVWCFUta/OXa6XJMHRtSr0v4wCGw4tvrbA8gI00
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(966005)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z53vTJG0RwtGr1wNtL0B79vUF9NlMRHtCuGKwny+OVY3ognefYnYI+1qOQf8?=
 =?us-ascii?Q?lw80sj5c72EXcAhPY90N+JtgNA3kwuThgnbCz3RfG8pNheO6oyN062hAy/1E?=
 =?us-ascii?Q?uckDe5cwMdOzQZTR77MCALWt4wkc+ZYC1EOwmHlFsRLt4uW/+ZNOvJ9IIoEq?=
 =?us-ascii?Q?GfAwrG1QY8ktJ5qdXiqBN274XhOW/6YRs0pfVZLgUxNicBCCLI8A4bioQIed?=
 =?us-ascii?Q?aMirzFGXjdYb8zAmi5uPzrrmn1tcK8py55QhivGa283i+e/swirMM6kJEuwU?=
 =?us-ascii?Q?reO4wjRL6XtjoL2uVnU2ws2+fwufCjI9ldIqLd6YAshBYWyqkVFmXmxpXusj?=
 =?us-ascii?Q?2oJWRhNT7SMK5gfsMiZazfumgiCUiOxU/g+sghof11HcpFNiltHDBkDktRtf?=
 =?us-ascii?Q?HvFepAPQddTUZ1dkQBEYppYROjkcgLJH5nk7kaLB+QbX43tMeeaGVUkAQk2p?=
 =?us-ascii?Q?OjX6hkMP/znRf9a/76gpeONQWavez0mk43AzxtS4ekpbGame0d7JAeYZzYA1?=
 =?us-ascii?Q?+N5jarYaI+1CW9no09yfSXXpV7kNcwbV9pxFlj7pqE7N04+gD+LfWFZi4ErZ?=
 =?us-ascii?Q?4MdX/WxfodYPKhsqI0WawmL+OwnXV6UDSQqXqo1+JSu8QvBN5XQAlXAYI8k1?=
 =?us-ascii?Q?WyeuvhDydQimNslP27WTLbLrxPgKRl2sols7yH+uhaCADEayB61tE3M13Xwf?=
 =?us-ascii?Q?iVPamKQLyAiUtIAsmLN6N/NT6haK9vHYjMKZqM9U0F9v7haCoXUcB5UGQRzi?=
 =?us-ascii?Q?QO0Kb91SWzLsg+L/ulTo6+wLF+0DLPjyb6FWRdS/73kbFulESKNiL6NWsl23?=
 =?us-ascii?Q?lICBzi2JGKAOye+Ps3h7Q392eAB6PEBG47MkTecvLx8AT2jUl4aI4oO4FmaP?=
 =?us-ascii?Q?2MdutEmqQjnkZZgNZBwFcas2RLiVLIdxTZ/Af0lZz+P0YvubJ0vuN+t3yTju?=
 =?us-ascii?Q?SG5QKYFfqH+ZW6hdiE4Qpp0B14kuZput/O1O99VNZDdYwcRT2fTiMxrROl/2?=
 =?us-ascii?Q?pDUtRIZh7kREJuE29bxHJFqU+4OkMuS1FpABGwOCkixYQY2jAg3mMYdlaOjw?=
 =?us-ascii?Q?kp6XnG0+EJ3eORp0SOx1KSot5hccUB+JLnbw8utQfNy3V6dU0nchPJpGH6kt?=
 =?us-ascii?Q?kNb9HxqtFGOxxrwkAYljsDBeZ8gNB86IcD05LTnhZrKBuat/3inta+PNpQrA?=
 =?us-ascii?Q?RblFv6NunmnjEKNvO4ZgaPUYdEh3rfHbvZitpo6H6BmdehEOepuOYfFKLYt3?=
 =?us-ascii?Q?YYnalPWbsA9ePE6zqvayoPRAAepMPrQpWk6LDU73DtTZqdH9OSVujOgoudgs?=
 =?us-ascii?Q?Qy0qJUtUuu+f4KpD73R640C7ekip4+ORDK911IqG/kNOGL4rwNy2KzdxgH+5?=
 =?us-ascii?Q?0e4hdFY7kZebKLLYv8xIwXj7uXASOKBFXTHITj7tO252wnR/4V3naKxbnTxd?=
 =?us-ascii?Q?5UWHjN6ip6HyHf5vJZwD503GKZWL7s1YsyHym2mfk2jRAChhx6EVB+JV1c6z?=
 =?us-ascii?Q?CTaBOWC7q1drD4PxLtWLzvO9wv6iOSI/eunIGCJZIR1gNYg0tKdpp0aTzDX1?=
 =?us-ascii?Q?sO0vlbLt6x8lOXNv9wxTxGgrFAA5xB5XHeHHeFDW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d74eea-b453-43f9-b611-08dbd92eee8a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:59:39.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9GBS6bPy3ClENZqCC8UoAH/l2ZcWyhDyB16wPd+d/Qo+rsVU3R+JO/MCZKu0/o/4bm6xKc08f7L1heCUw3jEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
secure enclave within the SoC boundary to enable features like
- HSM
- SHE
- V2X

Communicates via message unit with linux kernel. This driver
is enables communication ensuring well defined message sequence
protocol between Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications can communicate on single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/firmware/fsl,imx-se-fw.yaml      | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
new file mode 100644
index 000000000000..0503ea497d61
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se-fw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description:
+  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
+  secure enclave within the SoC boundary to enable features like
+  - HSM
+  - SHE
+  - V2X
+
+  It uses message unit to communicate and coordinate to pass messages
+  (e.g., data,  status and control) through its interfaces.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se-fw
+      - fsl,imx93-se-fw
+
+  mboxes:
+    description:
+      All MU channels must be within the same MU instance. Cross instances are
+      not allowed. Users need to ensure that used MU instance does not conflict
+      with other execution environments.
+    items:
+      - description: TX0 MU channel
+      - description: RX0 MU channel
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    items:
+      - description: Reserved memory region that can be accessed by firmware. Used for
+          exchanging the buffers between driver and firmware.
+
+  sram:
+    description: Phandle to the device SRAM
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-fw
+              - fsl,imx93-se-fw
+    then:
+      required:
+        - memory-region
+    else:
+      not:
+        required:
+          - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    se-fw2 {
+      compatible = "fsl,imx8ulp-se-fw";
+      mbox-names = "tx", "rx";
+      mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+    };
+
+...
-- 
2.34.1

