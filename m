Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82C7B4625
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJAIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20EC2;
        Sun,  1 Oct 2023 01:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjMOy31DLwUu27mi7y4cV0XhbPY9ORAM6AnhnNIReQcKnhUfqFUTdA0voD1LZh8IO74kJ7IKIweVqV68nyakx0ElKrBUH4Tovk2j8kSjRi48MRUv5eH8h7Wo5UbK94abV2kFERi3Vr3E42xhzTuaIn7s+2YUi5lJ9GEoYTYlkSlvfqWtamm7jc05nn1LBqadDw1q9fgrgD9LtX7/CqZuFas9mOAwFumambrqjteYV/iHyqoPvJD/VoQVFyNw8CWlMil41XkTsHTShCieS6wYes4+vjnYVWlv71xctcz2fhbJIU85oHbkBKkP8X8UoEsmQl3zDthU+HbxhmJcGYRxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0IZm+RQnm7JEFt689LEm6QE500DUPU2tmomaPsJfCQ=;
 b=T55Z6JCMefXledfIZamC6+0mTH+svNvm2J9r6ojTUwEwmZBirE6Lns9xlbHCCe+GldaCwBk9MtNVdgnoov0vqT2Dc14EFVdQxoj2xlTTU+NJjEidfjY3iOJ855mPQBebS6kCzkwjlgL3qsUBFwL5KY54JF/2y/vtfj02Iqwk3XQ3g+ANbRWAfE1OcPG7zpmmAw/fi5nFSCrN/c4i3OvPNdu0SenGkAfbvhsgH2wBlat2Mg/cLQy9PwjHOkNtexSjK5N9/iiDFVkUlOZKNGzl+OFa5jt6EZ4Bi6uyWhTBfNVYdi39EksMo0kQJtpv4Xh2qVsQmj3WjlxnX9FHVVXD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0IZm+RQnm7JEFt689LEm6QE500DUPU2tmomaPsJfCQ=;
 b=VPNf8r/PuMlUMyXGoK00lF/mDEkqRoH0P53jANUU98iLVaOldq6Jog3biGQH/biymfqF2UqLlobG2x8sPYLTopw1t+UP93YFXrOVLoqnwHkjsWQi/9QmRlRR8BAWhaHsALet6AwcZtqA4LvaZTM/h17agHT8t3vvB+qHNvoFuJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:23:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/7] gpio: update i.MX93/8ULP and support i.MX95
Date:   Sun, 01 Oct 2023 16:27:51 +0800
Message-Id: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIctGWUC/23NTQ7CIBCG4asY1mL4Z3TlPYwLCrRlYduAITVN7
 y7txpK4/CZ53llQ8jH4hG6nBUWfQwrjUIY8n5DtzdB5HFzZiBHGyZUKnFtFCe6mMGKhvDPWsUZ
 SjgqYom/DvMcez7L7kN5j/OztTLfr30ymmGDunaBAgRll7sM8Xez4QlsksyNUFWQFCgKMO6MBn
 K4hP0KoIC/QOFO+UW2clTUUB8jqj6LARupGt8oDV/CD67p+AbdNxWpNAQAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=2720;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aB/2o/IpP6y0LEjZ1gBiq+TJdSHIQs0FBWeORgj7gN4=;
 b=7QXqekJhHIu92BecBUpLwCkXoOIFjfENr+pPolNY7pFtYTCsRSJXafH0glKraIvUUC3QM3DtY
 ayLFMkJAcN5CWCThUwRKuzSgEpXCqci+l8sUQ03TAJtPPAJIValVKJh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a15a20f-2b96-4086-fd66-08dbc257a947
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8bgWCRU0j4+YbUWQPvWZgDywAxW5nRUesIV63lHKqamKGdyqlZS9QIe4jJ9OjjkeDRIsC0zY5KQrp69owEtSdBiNMb4LjvrH3QkIG2E27LPB9IbOG/0wly2K5m2PPKc5LnlnU+X1f39VAbtaU15dFMOLzNczNLlOeecl3CMRxwCs+4zBTNgI/9F3ChMHyILVi6Qx/8KzfLPPZBVUK5SBVA7DhthZuaKp2c1GON/dMrLUck7SH/nzK3of91Gm1GpBxwLL9Ru5lHQaTYy6TahpPjSjv5j65iE+QOKOvA8SHKfaWOQfuhX4J98SZXU5Zdz95Lqto1OXCxiG0CIU/Vo3uWbpkCXCwBieeLHod10yuJQwvBFrxHKA15AUC4GZgeWIIqFOzemtN2B5mO3RfBD5cAjYBUnPiuSvOYrbXqh//R13ehj9UvrqqhUyUjQnM1dNiYHnlWmlUyNMAsjEoSKldfF8k6VIyq8Y69viyOYqGIi5A/XtTiZVMiQfUK13exfeEsZnso2DXEs6TEBpWWchqGM0oRWlcbBMPSNXAVyhSS6tc3q3UWteZiFYhHaibQIa4Y+mWWqmD0LBO09iJaibk6k8WQxruB5yYjiKsdaSdycG5U8jKAAY/cyOiag++HGl59qljmrYsVOSowMbGlBa4uJObrlv5T9i3wIx3ZLsc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(15650500001)(41300700001)(316002)(26005)(2906002)(110136005)(7416002)(8676002)(5660300002)(66556008)(66476007)(966005)(66946007)(8936002)(4326008)(478600001)(54906003)(6666004)(6486002)(52116002)(6506007)(9686003)(6512007)(36756003)(86362001)(83380400001)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJkVzlsbG56VkR0ck1ReTFlT3pPekUwNm12S1ZmWGxvdkZXSHZnenNQZVgr?=
 =?utf-8?B?WUE3SXo5T1ppSWIycjBEdEFPMVJUV3VTTk1PWU9xOXhqK09DNVBpdDE2c2kz?=
 =?utf-8?B?V2tnZnFYY2JtR0xuK3lBeEdyR05UQmQ0SnhrMHg2SHNMWHRpU09hbTF5bVZY?=
 =?utf-8?B?VnFsR0d0WFd2VXV1bGFpbCs2Q3lrNFYyaUgybzh2QjBHYUlnMXBRWUZpbThj?=
 =?utf-8?B?bHJYOVlpTk9QbHNISGpkMTE0QllOTjJheGZPdHYzMWxLcjJpd00yU3gydmNo?=
 =?utf-8?B?STdiT0ZvZFJrNUxoWE5sWkpTNUtYZFQrZnJHNkl6aWEveGxDSWVvRE1QTFN1?=
 =?utf-8?B?R3VsM3c0VFlaeTNvNVEyWWJyRFlzbGl1QWtGeUEzcnEwYmNHMmNSQmh0bi9r?=
 =?utf-8?B?Y0Q4SHdyRzRWeW1FakZFdmR0N0tYQzh1OVB6WmtVVUpHQm01ZWJSaW5jRWoy?=
 =?utf-8?B?TmppSWNPUmsxMzFDQlJsV2R2OWJqTzk4eHhiOS91bmFnazUxNTNYdGVCanRI?=
 =?utf-8?B?ajVWT2lnZG1uc2xCa3VvV1lqT05tZHVUNS9wbkNwMk1QYTk4dGNxcTNtT3c4?=
 =?utf-8?B?RHFERk5sRFZXNG16b0N0VHZ2TjdXY09FaUNhUU1Qb3ZMWnRCOTB0cTgyeG1R?=
 =?utf-8?B?VzhpQU9ydUhCWi9zMThzdkpkNDBSTDE4bW5WbnlLVmRYR0dKS0xBNGEwNG4y?=
 =?utf-8?B?SmdVc1ZPTEJMWXhhckdGKyt2U1pmZ3BvV0pVMTdaYjU3OFpWSXlDcnRuajgx?=
 =?utf-8?B?TzJsRnJjSE5SbEE5Ym9INGYzUDJNL2pXeXN3OE9ieWpIWTZlRC9IOHhvUDR1?=
 =?utf-8?B?YmxkcjZYbmRXZS9qTmRNeFU1THNQTkFtZ1pheDA3azlDUjY4b3pVbUl6eStp?=
 =?utf-8?B?ZWFkNXU1b3V1L3M3dGNzWnpGZ3RtNytDSU5NY2l3T1FCalBBREk0d05WUEJB?=
 =?utf-8?B?aGVGRWpyRWdrNXJkL3hHenFYc3NPcEpyWkNudjdUczJ2eTA4V2w4UFEzby9O?=
 =?utf-8?B?MEFwMHRkSjhXd3JwOERXalhzRGFpZjI1a3VDQ2FSN0NvRGNOUm5GZXRlWFk0?=
 =?utf-8?B?Mi9TQVdPV3F4dXNCK0NYWC9xeFhXQjdtVHFvQzZxYkhBREdhcHFrUGJxaDRX?=
 =?utf-8?B?QmJHOGdrc3RtU1E5dmNwYmw2MGdmYklWY1RSakN5TTBZdFh3UUplZWhlT08r?=
 =?utf-8?B?R2pDWHBMa3lpV0VLM1RlanlCVFp2eWdUbG1zS1NTM0d1b1BPZy9zVEs4MUgx?=
 =?utf-8?B?YXZhRGg4RW9idDFGM3VMKzR0SDVaTkVZaGZKWG84RkFVN0J3L3dxWVZmeEhP?=
 =?utf-8?B?cHhaKzlvQjBvcE5TZ1pHQU5mQ1F1NE9TV2Z2Z1RPREhDRU41M2NlNlJITUEy?=
 =?utf-8?B?bG5DOC90a0xyNWdkeFFaWFJsaVRDTEZFZHVuamFjcXpmbXA1NENrUGYwL2dD?=
 =?utf-8?B?OHZ6RzI2REM0VUlmcERHd09xb0srTDJwVkh6UVVWd0ZqNGNPTnBncmdZV3Ny?=
 =?utf-8?B?ZWdUMFlHWnJYb296U05RUGlFSENPb3prM0V0TVBqNVo3Mjl1bzQzeXMycEVi?=
 =?utf-8?B?em5vZU5rRnVpUmNua2VoRGtIdkFQdDFCVTlrWUpiL2YvUWsvdFJ1MTYvZEIz?=
 =?utf-8?B?bjNyRUlGTWtDdFltWnZ0VmUrSXVHM2k1cC8zVkRtWmpPSjVyVUtaYmwvZThL?=
 =?utf-8?B?Rjl2bVFsemxNdkFZU2h4WXk5cE1Ta0I1Rnd0NHpHNllJMDJCbE1NNGVzdmE5?=
 =?utf-8?B?d2MzVGtxSlU0Q2JCNFdTRjVkYTQyRWRkNEJIL0FBR2N4Ty95aTVhREZOS3l6?=
 =?utf-8?B?M2RTenY4TkNWcEV2eWFtMEpZNTA3dENoNjNjWTRvNU11TE1WN05kb0svOWtZ?=
 =?utf-8?B?WWp2QmcwTjFIOUpZOVNxZUJjQ1ovSFBFdUtvckRNUFlXUXFnR0JyTHF0UzlZ?=
 =?utf-8?B?cFovRmovcWFNL2tHMVMxQldGZHlYOVloSnJxZE1MZTRIcTlBa1BycDBzSExM?=
 =?utf-8?B?d0psYW9nb2Z2eDVqQnVobC8xOWc0ckUxVlkvd2x6dmhXQjI3L3V0RWttSGFG?=
 =?utf-8?B?V2lueG5rdWw2d1FGYXFSOEk1ampYcFZuZXAwWmtFVjh2RjR3bWliS0JLTWx0?=
 =?utf-8?Q?nK4EBikP97NP0ogqmeHZI21bm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a15a20f-2b96-4086-fd66-08dbc257a947
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:16.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL4zyF8TT5L59UAzWEoXP/nle7RzYpuISNKOlkEWbKDfWW5F8EqyTnqoMBzc0caMyhSpL7K432/7sN1f8jDdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From hardware perspective:
- i.MX8ULP/93 GPIO supports two interrupts, 1st for Trustzone non-secure irq,
  2nd for Trustzone secure irq.
- i.MX8ULP/93 only has one register base

The current linux gpio-vf610.c could work with i.MX8ULP/i.MX93, it is
because some trick did in device tree node with offset added to base:
  reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
But actually the register base should be 0x2d010000.

So i.MX8ULP/93 is not HW compatible with i.MX7ULP.

i.MX93 GPIO is directly derived from i.MX8ULP, so make i.MX93 compatible
with i.MX8ULP. i.MX95 GPIO is same as i.MX93, so also compatible with
i.MX8ULP

There maybe dtbs_check failure if only test the 1st patch. After
the patchset applied, no failure.

To make avoid break old bindings from work, update the driver
to support both old/new bindings.

---
Changes in v5:
- Add R-b for patch 1, 2
- Simplify code a bit more in patch 4 pPer Marco's comments
- Update patch 5 to only drop port->sdata check, since patch 4 is changed.
- Link to v4: https://lore.kernel.org/r/20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com

Changes in v4:
 Change to minItems for allOf: else: interrupts 
 Update commit log for patch 4/6
 Follow Marco's comments for patch 4/6
 Add a new patch 5/6 Per Marco's comments.

Changes in v3:
Update patch v2 2/6
Update commit log in patch v2 5/6
Add A-b from DT maintainer for patch v2 1/6, 3/6
- Link to v2: https://lore.kernel.org/r/20230916-vf610-gpio-v2-0-40823da788d7@nxp.com

Changes in v2:
- Update bindings with describe items, add one reg base for i.MX8ULP/93
- Update driver to support one reg base, support both new/old bindings
- Add a new patch 1 to update gpio-ranges found in dtbs_check
- Link to v1: https://lore.kernel.org/r/20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com

---
Peng Fan (7):
      dt-bindings: gpio: vf610: update gpio-ranges
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      gpio: vf610: simplify code by dropping data check
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 40 +++++++++++++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 21 +++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 28 +++++++-----
 drivers/gpio/gpio-vf610.c                          | 53 ++++++++++++++++++----
 4 files changed, 105 insertions(+), 37 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-vf610-gpio-46edacd2b513

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

