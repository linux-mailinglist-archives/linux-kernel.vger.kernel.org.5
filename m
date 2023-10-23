Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB17D2907
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjJWD1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:27:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F2188;
        Sun, 22 Oct 2023 20:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwBGPPWHFrd1PYWWezWmg7IA9BvGllTCt5ja9PyFiE9MhMoa6I5dB1Fiw6uDri4mK1s3M6zMoNg2OOQ1T6evvTZqY99JaiCKiOLSr1UtSpjgW3n1ZBuhzx1GMiZgBidzXsAWZCmv5sWqOd1AzGScZcyVip1WuDG823NR44EG/X7ed6upGCvgPfI4xQjpwnibIfrqqCSZI6Htizci1V4TNRkeOJ4DsSQuPf/sLLiH3cu4atjnyIuDMrFEtwMzPSv1HrE0UdBnx9zj2ur8IJY8tcRmTwuYjc5KrOE3D9KZJGtxSxlMFeGe7jYpPDXKt7dD8csPuEi1FNejJzlf93t9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ixjEEwDUzfzkTquyh05Qk7boLCEWRzfDUAMysP81u8=;
 b=YGBdmVth7t1Heq3JQzTZBmXipJ1bQQh1aXCj7pv1UjY8p14suTBkw2OL6Xqzrry4UzH00810l6SIQF1dWdtNm48hX0NDOc7BEonWTabX3lLWMJjM2WE8Yx85jau5pTvXZpXIcQrPDkksNyDTQ3NODO4Pt7uCaU1tPUFb7j9TTEKrvWADz5ygfvLJwfK4zmVjmZSv2fF3GNFi9mnAVSXxybbqgl0aEcvt1x5Qpymh25ZsilIaF/5N6ZNqrDubRqGP3bSFYFwnT6gG2NYzRdT2TJ8YG76985QAgadOEX31hsYjmpmF/WUKzZZigrMOVJiUGkTxr46meZ2Ev3NPzddHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ixjEEwDUzfzkTquyh05Qk7boLCEWRzfDUAMysP81u8=;
 b=hYla1npDid7ZbsJBqUkGwxoyPHG9LjayWjyrGjx3itX+vrEDZO+moUhjVs91oBBYY00SNNwE32h38F2ktpf1xUC2P+sUrPi3xUBzMB5rmQ8ls9x7eOnIIVPw1mUD8GII9PazbraFekJKHGlMimb5wiUw788kZ3v6ta9PW90AF54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Mon, 23 Oct
 2023 03:27:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 03:27:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: clock: support i.MX93 Analog clock module
Date:   Mon, 23 Oct 2023 11:31:43 +0800
Message-Id: <20231023033144.3694131-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd9d9f9-76fb-4e1a-4763-08dbd377f8fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmO6oZaTCenuXpSIR4sqmoQ+V3Cpy1e4e7iH11QZq44N0ME3LQR/yYqkQqa6hxkzIcAO6qh2mPTLWS9R3sE4Q9P7ESYm8m0wdpkke3FsBzyv3HnO2VIrWR8G3F8EfP6D/34DmnY0PSDLMX6xOPcgEfaB6INZJZatMmi+rFsdrjoMBTpi6R68vz/2RR542dK+DnxS6U6ih1qhNAIM7UouwpGabsMrnC/QAiwJ4jWq7cxhsR3oYdTrl9oWKLN26swu5OvoNHb7Y05ExB6UydYTdi5rsyZMMiGzkI4yF2Rnawn7BMJCEsULFTZRDuD/zEqiJfW1zzltNDu6kBInvbaigR8du/xvcbnXeRF4dbZE71oc0bXfvIu8cIon9kRe4Av8TPhD+haOEcq+9w77wdSJsZbx2WQ6p1U+Zntp4zuKwBbE68Iv3RPwkeu3P7mGJTz4r+z6XvBy2M4eqzQayPieVwGbwSOFAP6glBW6VkUxkvPfrEpDFQao3JOZQDaFp1qXGxuS0TIha+bV90W4YlyZvYzC2euG4ADcTg4Yb7oUvzGWNtzinte4jIDferrPVP/SpdCGKw7vPhkqZDhepRSfVwq+a8NRhRb6IUXDQs5sBEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(38100700002)(316002)(66946007)(66556008)(66476007)(2616005)(26005)(1076003)(478600001)(6506007)(6666004)(6512007)(52116002)(966005)(6486002)(83380400001)(41300700001)(5660300002)(7416002)(86362001)(8936002)(8676002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEDiWluUQ+SCQfXuKqxSNHp3HAQzsnc0Ng5oWf5fWkauYhLBjAgTzWMD3UgG?=
 =?us-ascii?Q?AvBHCbMeIJFmDPNV9xhwNGJEyO8w/k/l5juaFX0tIibQFgGuotsLl0cDt4Lf?=
 =?us-ascii?Q?IBUmlojJrGN41p9l6D/srLj6BIPxIjraaj5bAR5hDQZuyfqH66Y1XsTaRHII?=
 =?us-ascii?Q?jwjqL+3kcP5VAAUV5kS5ib312H3HjYdSMnEWTHUhWoOzuIDw4D/ZW2ZDRTI9?=
 =?us-ascii?Q?S+4x1+F71LcvCWm/540yyQq1ShLioKcEiFxTxwsCV/OJKYq37RN2mspfvg0I?=
 =?us-ascii?Q?hPzu13/Pjz0MftbhoC7zgTtPQRlex3JLC5yYHhq16B2tWzn0DTv7PfLDNjjZ?=
 =?us-ascii?Q?7QEukgzct/Jg0tZgtJwZ+3J+hbqiw9INKDRWdpXEL7IDfC6QyMpQqfBOaakJ?=
 =?us-ascii?Q?xUHVOYIBuLv/R0Ds02FCvbxJwFfVdS2+4XZYwS1SxXuz+mxyMkzJTb2uHZmm?=
 =?us-ascii?Q?gwOKVZk8qf72k3Oyb+j6uhMMUCBZVNhjPhoziUgp89jl7/c+cy9O9zm+V/Zn?=
 =?us-ascii?Q?wfpg14ECoU1MLVwRcWVyl6QcmK5pOvPoeWNEw2qzeTefVEFZ35LckeqNNZwW?=
 =?us-ascii?Q?mYbjwpKmNu1EWSB95RpFw2qYo4zbBj6PpBgMislsEkS2YMquMAn7eS8l83Qs?=
 =?us-ascii?Q?uk3bGFr78ir4oEw7PtkHCFqSZm02jILpekigm/khQVnFfyJYsJ2TZwm2tX/l?=
 =?us-ascii?Q?8dZ835bHq38anOWTIr7ME0SjDXPz2wEy7FqN6yBD4er0nS0JOuPY2kQyl6DY?=
 =?us-ascii?Q?i/+pd6tGUHDF/IRFQ7B7d1BI86XIKt5gfpanC5nzQf9u1B/clxUWyE+IjWE2?=
 =?us-ascii?Q?x//Lt20dcl/soaFpd56a8g1aA91TA2PLJvwhzxO5oqIpPnc2zRbAhcAUbOWw?=
 =?us-ascii?Q?fbBGP0FuksAqCAx5jvKcDnxqTVjeozoTrVC7luiT2f4bdORd0a82I6+WrP4/?=
 =?us-ascii?Q?vrAl5EMk0wQm/Ed4UvszCoOeTKKrAyg6xPkKjmWknhEIav3lpe+fJyaA3t3f?=
 =?us-ascii?Q?YQcYX63C549JgYqvaKSS/Boxa8uI0FYqL/wG8LOWt8B+n8nF63bNJ7wS9Eq8?=
 =?us-ascii?Q?5Ie4CSJf0C7AkFBi+PgVTvtI2rmGaDBiVns5ntDipJEWKqF9HyN4uXb4vBez?=
 =?us-ascii?Q?Py6qXIY4Xr/59QfOlrD2VKIrR5BrOSUzSx7mHmUaYzLK/xZC7xtLSo+fkcun?=
 =?us-ascii?Q?/SgndnfgjufpByekfw1C24ZEUzS/wbNfnOGQ9b4VN1KCYENThWoM9GQkbQgT?=
 =?us-ascii?Q?HwIMq0T8gMaw7W+NaeTT2epeRdbvRsqqPHxvhTmIjzAt9ndQSgCIInlgxU94?=
 =?us-ascii?Q?+Llx6kItF1GiCysPwLQPJCx84Z04pdNWqV8AxJCodgM2SIXo5LTQzoBEf+12?=
 =?us-ascii?Q?HlFtoMHldhNSrUMEIDJcasTbmAtg1OjMqgSNJttE4Cfyu+cv3PoowG3lsfT5?=
 =?us-ascii?Q?NM9aTqRhnl+fHuVH1bvB/bdu3axdDqqXV/vRcSRY97DUvenpLvsZtWyuVxZZ?=
 =?us-ascii?Q?2Vsjq815lcOtDNSo3Nj87JM3BC14uJgyRWwFyWa2Ar4rYt796B+U5cB6qkOc?=
 =?us-ascii?Q?6ltjWWCSv4CM9ArgVN7z4v4OV0LcH9zKPQ1/FTyL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd9d9f9-76fb-4e1a-4763-08dbd377f8fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:27:23.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6peImR9L7z4orl+vYDE/TYDg5VJAHB/+O/e4r0d6maAu2CdEI2YSTBh+/+TPBOiyNtvLZ+ng4N8PDCL2hAj3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

V2:
 Update subject and commit, rename file to fsl,imx93-analog.yaml

 .../bindings/clock/fsl,imx93-analog.yaml      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx93-analog.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx93-analog.yaml b/Documentation/devicetree/bindings/clock/fsl,imx93-analog.yaml
new file mode 100644
index 000000000000..c026639fefa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx93-analog.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx93-analog.yaml#
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

