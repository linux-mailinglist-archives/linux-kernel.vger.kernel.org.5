Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64D7851A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjHWHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjHWHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:34:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA2128;
        Wed, 23 Aug 2023 00:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8xWb7XLIXr8a00twgrMox2hzjtvbaPLmMkW0TSd+McWTuhscLj9x0MvYuoLiuGmvTj6Fqjk0li4KUZIBlA5UWyApJVo2nFCl09eY0E7BP1xgoK0jxGctqKB5VLMR+llWRLBKax/6aOqqtu0wcxpor0SO+2I5N8GM96lgFgHtJU5RJy7mLKLrPneXrfDesQyz6QAI9MpVxi3dVJZGVLd1znwc5+9gDFIerFjbupTjG/GF5wPlne4EmMdL7g2vQDpfoCdNXrhTW4USFj1wpQUQnrOpHBkFbnBOrT6hEq3ShgzPelcQADenLvOhGgmxovGF7QR87XXl5D4YdUxHhT0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l8TtJbn04Mdr3iI565hvFsLTBMD4GO4BsgX8qJDvDc=;
 b=cFIdVF4XSamkpSx5+G9U4t4USlJSSXKB3PItbSe8f1d19cEm/xIGG08aVmbdaQBzf8x7Wv6zLD8HTpmvZEMGQvU8E+WlgW3f/CJFUPwWg4v3YrL+vI9a9KbWd8waIkdx70e3am4oNjH1lWebl+TmGdBxLUEQDa+JU5Ua6kPUKgELGhEO31W2liG3gH9u+QI79Ps590VZWrJbjuWJiD5l18wtxo3UIf+enrj6Kh+0UTyuEfpqSxXb0+ACaNgSWo4iDwn62v0Tu6R16MrHhXwVFQVKBF/8B2P3ED0LG8Cb09tiBwijwyHrNyG00tY64M+J4tjaAPiCo2DdXDx1sHyBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8TtJbn04Mdr3iI565hvFsLTBMD4GO4BsgX8qJDvDc=;
 b=pjsexpeqWywUquGUlF3nRN29ZTAijGr0V2XVQ1DQupjMU9LHqiFj1MLOjFN/I5IT+yxk1jm61EdANodIPO0uc1qv0SZxMwIaOR9jetrnTvpZenTicHhHUGuduvxtllsZjhBiCcOGRxhhvWEBuaB9bmE9eVF6E3MTXsR9SnpuNyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 07:34:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:34:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Date:   Wed, 23 Aug 2023 13:03:20 +0530
Message-Id: <20230823073330.1712721-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: f73e00a1-8837-467c-f516-08dba3ab6f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLccNkR8/6ilDEOzQKI1GfAUGy+h7krOUYW9Bbs/WRXvtNkj4RYiN5paWfGWoo723NNMfNUj3fNx9AuRpqkRf2ONGsF8bDx7UW11aIN++z9ZhXnsuSNtJzQY1Ea4oJTmt2IbzMgNJ8HhhKKTHb+3pENddYrDsD8R7aXTzcfvy/09GAjewcbhWKCI7XszW9aWGzYHiYsdyCAYjKFIZucFUQNZaUAXlumPVD8LhFDLl5PyvwRp6r6kDOk0hZTlUBpW5MxTzpYf0jkJ7MKdWbUPk+W2FCgkHRbGMX6ECoRLwfIk2IO2C/Ik+/8vG45yVqzbLTA75LCHq/zQJo7i1CEuYsAP1RNsK3f7cfVUv34g/GcDyOuG95khmGc0oQ7KfSiI6wTHspv58R9ckuIjiQtsGHhtT28MsNEi2dhZe1LZDmOyfhXIwDUNOx1W4VjvjlkbmMkF8HxXPEP6Py2ExvDwWeoiIK5X3q/Md9doGkj8W4AfXwT2w1lA/MOYHDsxqOZ+vROjxQqH0h559NlSl77hyH3LLnQC8t9+8x1SOOXyjEem15dnDTb7J1OaMd6KwmSaRLUBND4lk7gCXtuq3Trx6dKv+FoiiRTkkQwYXsvebrwuPND/d/uR23vtOOGBUBzkwVygFpqNhGudZu6RxdapbxtI58pm8z6mvJeXWCNtDGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(2906002)(7416002)(38350700002)(52116002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(966005)(316002)(66946007)(6512007)(66556008)(66476007)(6636002)(478600001)(921005)(6666004)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpup1Lox3c3Xqt/hI8LwMEQ1HBhs2087cCU+YLpXHhEjzfBmpLqq3WY2KVWp?=
 =?us-ascii?Q?Dver2HKRRbcQYcsvmmxG3EoyQ86MPUIa/+yrqVRi1Pt+9puPg23IKNB1dHB7?=
 =?us-ascii?Q?riFxA6owJ+x4GN5rmydB8no0gn291LBJ961g6ZWac4W1I08NVavSdTHXMhVY?=
 =?us-ascii?Q?ooY2ibELUFWa87hNBrquGpeNiAdMNV7W+udfZFLUwrrjDXxA5xEfJHXotbZ/?=
 =?us-ascii?Q?xW43Ef1Bsg6IaLqvENHPtrZ0IW4tphpdrd1tGgT3UlPwwT0PjJsKmKKZXOk1?=
 =?us-ascii?Q?b5aVxYJ9wWWTl+CpqVAe7dfqeSvt4g1vwYH0FZ4Z+WN8UzNXDVUmaO3JAO5E?=
 =?us-ascii?Q?S/BGzvBtxN2o1yMDn3Q2E3WHFe45SyjTmoJqX+zEekEgjA9BKaNITFdJnLGh?=
 =?us-ascii?Q?x2tyTphL+ZBzPoqkuAbQeUVDQ7F/zNBPA+yugzv3+5cmcTHbDReIbYomBuEQ?=
 =?us-ascii?Q?vMA2Sz6ojfLxA4XJH5ZaB5Gm/dfZi7/B9jZw1CCCuJ/o8yrSbKg/D4MlFowi?=
 =?us-ascii?Q?Rcg4MIWzjFY75mjigQHh3W8PpgQP12xpuhMQjVugWIhj9u4xP48QMagx2Ojp?=
 =?us-ascii?Q?rM6plcXF96J8sGjc7iHWLlKBx31VgJTsULwjUDV5nIbJYYvOreMy3glJ39JX?=
 =?us-ascii?Q?rpWJQG+lLp6NNgKLITEfBZm0JujyF0tFwC6T7v5Zj4L9fe9RWVt1MAjvSvjs?=
 =?us-ascii?Q?QaMTjEZKtgGY9CIOCLy6qRphGYU3hWdb8c0giFW6ZQSbYwRgsS11wKNdZMPg?=
 =?us-ascii?Q?w6C2MGaQ0UAbd1dN5/+lok3O1uVg6ViHfL+/zgAUa5YBLq/D2CcKBmdxS47q?=
 =?us-ascii?Q?R3obUStk9+xBpFxnuxQFdkWxhPVsbcqjx47ceLXFfflqYv37C5zv4sMF2MDn?=
 =?us-ascii?Q?Dqoc+0NufX8bhpDgMqkhMhd7+goBJdXk/NQ4nusxlmKx94D6gL1rbKmFgWcR?=
 =?us-ascii?Q?C31uts0XTpDQAiHiyH59KyHT78PrIPs/IeMn9Pyl0zeas6UAIYOZyJ//SMqu?=
 =?us-ascii?Q?g/LAD+zIYE4u3xwhQznvxc4MToFrQRvCq1tqUkFVV4OyUd1OB1dJ5yC6c71t?=
 =?us-ascii?Q?KFcBJ6SSMi9sUzV98tR5so5zNSyacxXC3ud9DYOzaFvPiTFY4gGpTXaeVRbe?=
 =?us-ascii?Q?ScavlJy/YNx4ns+JCD8Gmoh4j0sHRfDNRIWrUb5nJuLjxxVNGt2RVUM/tOac?=
 =?us-ascii?Q?CVQkFSRoglNbAwcPDp7NBAoNE9TTfhnybWA57ppOxu0bYiGqHZYylhUtnUtS?=
 =?us-ascii?Q?yL4WgJh5W2NeXijE6GOhrJJrn1MdsG1k4ftKAVYj9v69BzaD2hnRgFY4nn3f?=
 =?us-ascii?Q?wjBUf/Gpvl5jR8r2kiiRLFvoDE2O1o0UkLmmpwfFyJ70alIyAggRrhhISrUo?=
 =?us-ascii?Q?UwIwG+OqNxwJomm6XsEIufJwX3ZTCoUxJLU9yAqTJv03inYVk3gP5PBa52WO?=
 =?us-ascii?Q?1OVdr//WMHSky6MnNgoyOps0kSAL04Mbcn+CB+B8ksBaCI5Lc6llG1sPLNEh?=
 =?us-ascii?Q?lWa3L2B1jq4P6c+9FsBoVVa5PQTmuxPMru5n4dkMyIyUajYM+DUlsoVm7+ry?=
 =?us-ascii?Q?iXsFM0zTARr5SqB2PgL17Pd+69N2AbQ9cASxf1Gp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e00a1-8837-467c-f516-08dba3ab6f7f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:34:51.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+kAUc8Eah6YQDLQHEVwWxorGhNkz9h9h47XpP6ckbmANfXjjP5NumgiTy1tOZ7DRS0Un6MyAWFAbBV3AxM3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 .../bindings/firmware/fsl,imx-se-fw.yaml      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
new file mode 100644
index 000000000000..f7230f93e56d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
@@ -0,0 +1,121 @@
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
+  This driver configures multiple misc-devices on the MU, to exchange
+  messages from User-space application and NXP's Edgelocke Enclave firmware.
+  The driver ensures that the messages must follow the following protocol
+  defined.
+
+                                     Non-Secure           +   Secure
+                                                          |
+                                                          |
+                   +---------+      +-------------+       |
+                   | ele_mu.c+<---->+imx-mailbox.c|       |
+                   |         |      |  mailbox.c  +<-->+------+    +------+
+                   +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                       |                               +------+    +------+
+                       +----------------+                 |
+                       |                |                 |
+                       v                v                 |
+                   logical           logical              |
+                   receiver          waiter               |
+                      +                 +                 |
+                      |                 |                 |
+                      |                 |                 |
+                      |            +----+------+          |
+                      |            |           |          |
+                      |            |           |          |
+               device_ctx     device_ctx     device_ctx   |
+                                                          |
+                 User 0        User 1       User Y        |
+                 +------+      +------+     +------+      |
+                 |misc.c|      |misc.c|     |misc.c|      |
+  kernel space   +------+      +------+     +------+      |
+                                                          |
+  +------------------------------------------------------ |
+                     |             |           |          |
+  userspace     /dev/ele_muXch0    |           |          |
+                           /dev/ele_muXch1     |          |
+                                         /dev/ele_muXchY  |
+                                                          |
+
+  When a user sends a command to the firmware, it registers its device_ctx
+  as waiter of a response from firmware.
+
+  A user can be registered as receiver of command from the ELE.
+  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
+  the id of the driver and Y for each users. It allows to send and receive
+  messages to the NXP EdgeLock Enclave IP firmware on NXP SoC, where current
+  possible value, i.e., supported SoC(s) are imx8ulp, imx93.
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
+  fsl,mu-did:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      By design, Domain is a clean separated processing island with separate power,
+      clocking and peripheral; but with a tightly integrated bus fabric for efficient
+      communication. The Domain to which this message-unit is associated, is identified
+      via Domain ID or did.
+
+  sram-pool:
+    items:
+      - description: SRAM memory instance.
+
+  memory-region:
+    items:
+      - description: Reserved memory region that can be accessed by firmware. Used for
+          exchanging the buffers between driver and firmware.
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+  - mu-id
+
+additionalProperties: false
+
+examples:
+  - |
+    ele_fw: se-fw {
+      compatible = "fsl,imx8ulp-se-fw";
+      mbox-names = "tx", "rx";
+      mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+      fsl,mu-id = <2>;
+    };
-- 
2.34.1

