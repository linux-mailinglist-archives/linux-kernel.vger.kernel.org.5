Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118FA7A4429
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbjIRIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIRIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:12:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7A114;
        Mon, 18 Sep 2023 01:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+/0WR14RbxSa42c+m550G/L2UTwb5W+tkgNmtybhDkVouS/9eIENd/XfHiTaGoE4qFpduBKCsTkmNqSRwAC///NsR75eJ9oy2tek+6/q6Ftft/tItThl7QCekEPls+tTyqEPPJkPqx19Cqdmkj9DH1RFtolcpX/hR8iGLCm7DOsMrR93so7ISHPYAaLv+zxNvddkVnP8qj5RT3+1XZ2H7bt6abzWXsnHPfLXiztbuGdk2TlS6SO11eW5MgibU/kELixjs0ZF6VCHm96rHvC3XnytoOA66kv5Erf2KbiYCHMLFDDP5xuR2qQSZdFND2kGJPhWXPIDKNZVKoSFIe6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7kt5GqVNgkKPMfO/ZrK0zFOvDpKeARkxYuEhrS5Z1g=;
 b=aCLDpbj3LyJh1v17KlmF/GxrCgxfm2j7d9PKeFhuFByuwwmyyXNahpIiUNMhMOqtw2J5UqE2ehEkSv4q09tn1EKZ8voW4p21sWDe0zoy5ny5clB/Sfof2YaKX6B/fiG5QhD+pjj6E/ejHkX/Gr6lqxDGJ3XOgfRLxlHJxNYheDcth6gZKrRPj6PdZ77qTqbej3VI2j2bj7E4xoZIgSrBv+ZwhpdsdlFi4MYQH6nwSH6z5jgsseu8UIsKF0kIgvwJuPr8lXQ0R5Oo0TdoBF4I5w0OyQiTN3ULE4PQuadZGRVorAeuR3CaRalYTmp0MFcRelZV5FuuWLddhmZ4Kot5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7kt5GqVNgkKPMfO/ZrK0zFOvDpKeARkxYuEhrS5Z1g=;
 b=T8321xfenQRR/FTqMF89v5aL0wi4zFXZLWBMoPfcFq28tum/Ob5glDFIKCVn9XOpMigBPP97KuUIhZ4bADPcIyXE9Xi9OozJ9B28i89R7lAu7PIoVEj7p6UOjHo5xymapm8ft9l3tDhSLg9rIYqobSGgdI+mKwwcU/j5b/z1ARU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:11:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:11:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/6] gpio: update i.MX93/8ULP and support i.MX95
Date:   Mon, 18 Sep 2023 16:16:04 +0800
Message-Id: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQHCGUC/23MQQ7CIBCF4as0sxYDA1LsynsYF1imLQtLA4bUN
 L27tBs1cfle8v0LJIqeEjTVApGyTz6MZchDBe1gx56Yd2UDcpT8LBTLnRac9ZMPTGlytnV4Pwk
 JBUyROj/vseut7MGnZ4ivvZ3F9v7NZME4k+SUMMKg1fYyztOxDQ/YIhm/of6BWKDiBqWztTGu/
 sB1Xd/Y+UUm2wAAAA==
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
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=2208;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=sxgXILD2ARPemFAsJUEMj+cbKFrRm3cKMX1Bs0wa14o=;
 b=iZR4Jw0HMrltQfVOtaScWmttrJMjyVFPaXajCefukRDA9ll6xUix5Ho0DHiqY/mWUaPkiF8Xa
 65rXLUFNVXxCcoG3IzT2Wn6etvaw+MBXEVpJ7ITwpW39P86j/N347O0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: f268b00b-be63-4537-594e-08dbb81ee498
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOxscuC1+mOuP42bnazfT/glu8m57tkcECVPjKb/47L8xUtvZ8FlZ25fh3hh6pNxPbuM1zFHdccMWKDGq9Yc0vDH6YGVO/ZL+hz6cNn/05Wb1Y3mtBF9viJum+IkxjvYll0XdqW/WxPBoQwPzr965znz6xpqKGO3wyOxCrxpPrsBrgzL/qbv6R77caS2N9vLO3rTmoTAUsEleE90XxaKCuceoCzmrSuP6pPd8KIIqoDdI74ntOwB/QuveFrOJjeaIO17fPyKmx1PPGfEFfkpe6tWI1/3uHOy2D4g6pwk0BV/AdVKV9Bx9wRrVjxHXi6bHWP6blWmV2QWwEsqTx4Zsbzu0oNLN6wbk9K644XYAnvvqfX1qIdJODqh7XAOkz6aJfj5WZd0DXiv1sA23nOFkIJh3k2Dbr6Ba7MsHjXIbfArs2wVmQo9pmkQvG4SkIIJ9qczDvsNjsMulNggzibr/qYwd8Kp+r4K4w7ZaQ7cYDllr+PCbX//UtsdGz2wmUaaeEjyBa0E5DvosjHH9cVKzHT8C1kSJcf1Tl/USe42pH6o/YpPhF6n5Q9x0KQLu21nDbr2FaXvSoUMWr0NkG9+CNlO6xB+BpBRQRyH4qx5d1U2hV68gr7B9raYIGAify0XA0kKTyVOnAxwHk5o8BEF2tnPKMtfsMEamAWxukbcPFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(966005)(8936002)(8676002)(4326008)(921005)(86362001)(26005)(38100700002)(7416002)(15650500001)(38350700002)(5660300002)(66556008)(66946007)(66476007)(54906003)(83380400001)(110136005)(2906002)(316002)(6512007)(9686003)(41300700001)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjBCMnRrT29Tc1FPakxwcDJtODBOYUQyY0xOS0F2cmFQNmRVV3VxSE1seXB6?=
 =?utf-8?B?K25pN0R6eGdWTDY4dWxLVHVpeHd5WUdLcTZPTmlKcyt1dGNOMDRoQmxFeGw3?=
 =?utf-8?B?ZnRPd2JpYm8yWXU1SWRKVUJyZ1BlWGxKOEp1a0ZSMW5lQVFjaWw5QkMvWDBQ?=
 =?utf-8?B?bm5uTTlIU3cvV3NFTHJpTFg0WXJkYnVaS1JueUtqT0kyd2hia3VpQWY5d2w1?=
 =?utf-8?B?ZnFZOVdkMzJ5MFNyM1V1d0tsMGsvWkJkWWlPdE5scFc3OW9iN1lkWUp3M0hF?=
 =?utf-8?B?a1IvYnhWditabWVEN1ZJLzBuL0dycFphZjIwY3N5UHBFNG45M3hlQmVXRXIy?=
 =?utf-8?B?TUJDMWYxdG9RZ2lrL0lFWXJqK2NBVWhmaDZ5ZTlWTWZjbEtTYlo5eTBuMEg3?=
 =?utf-8?B?dUdOdjl0cTBBcm9SR2RiVGFQZHNSL3U2SUtPMkhQZDE0QmhSOFltVkRJZHlh?=
 =?utf-8?B?eFVpYkxaMUJPZzk0aFFXYThDN21kVGliT3dXay9zd0hlR1pZWERIL2xiWk8w?=
 =?utf-8?B?K3dteEZKQkpxdm9CVUxBL1pIUUc4ZFAweEcyMWt5STZvaUVTZUlHOVdYSThw?=
 =?utf-8?B?VEpZbTFYeEppMzMrSWRtcXRydU9hbzJhRUNhZHBRZXhibFY0azFmRUo1dkJP?=
 =?utf-8?B?SFkyMTJhZzF2OFB0UUROaHRMTVd6dlE0Q0VzZ1JiWmQyMEN2ZVA1WWp1N09m?=
 =?utf-8?B?WExSdTFOK0tuQ2NreEVWV0xsWHFLTUE2YVc2UFBoenRJaHhtbEppNW9naTZ5?=
 =?utf-8?B?ZmFqZk1odXJyMUVCUi9Kcjg3UUcvR0xWTm9qTmVoUEFucVpHWHZyU29qU096?=
 =?utf-8?B?cmJjek5wS2tGTWltM0REWXo0TVIzVHBhdW1tSTBFSDN6YkNzY1VJemtrRTVh?=
 =?utf-8?B?L1lVNGF6Mnh5Umo0WXcrTVFVd0ZUeFY1MUduTjc1bXFBMVVneHJHbmxwY21M?=
 =?utf-8?B?SU1lWU1HQnIwemtNcy9vekVaYUY3NmF1VXJ1eEZqN1FMYVVna2VXWVRqRFZ6?=
 =?utf-8?B?VG8yQmtUL21tUE1OU1Foc1Z3ZzhNa0F5UVcwS0xOZS83SVk4MDUzQm03T0FU?=
 =?utf-8?B?RXY5TTZzN1B3aUVzbGNlRE5DcUhCdEUzcEVhbU5WVUt3bnR3eGhrOWROL0xE?=
 =?utf-8?B?Z1VpODJzWWVabHc1NUlNZGhhYUZUKzQvTVNZWXZ2dmljUjVkZitjbkFwNTVm?=
 =?utf-8?B?cG1sVXI4R2pvZUJTajdNUVY5QzVyTFpLZy9BaW9QTGZKVURSbDRZRlE4SG1r?=
 =?utf-8?B?bFFQMjBsZ0ZIVXpvNHdta01reXpCUWFsR1ppbTRJVTdhMHhQc20yN3BLOWRx?=
 =?utf-8?B?SDZmVlcvdTFaNXlaNm9EMTZJZVVybEwyd3lBVW91OVNZaWNkYmRlbDV2aVhK?=
 =?utf-8?B?UHdEQVlZOGY2VWZGeDd6MmtTREtzbUYzNWRlbk9vWWNoTUY5VXgzVEJOeThz?=
 =?utf-8?B?YUlvZllTZU5CcW9jNUR1WURLRXIzemFkL2hFTVYvblN5VzBxbUhnL05CSFBD?=
 =?utf-8?B?Y1Q5c3Vqcnk0Vm1xV0ZiQWpPc1RXSTNKTmZtL1lISzdoSVpTMFNrQlBqVnNn?=
 =?utf-8?B?SUFENTVReVIwOW9qM2FQSlhJOTVPUEtPeEV0OFgxWmVCd1RnR1pmOXUyOTdt?=
 =?utf-8?B?bXVaTitpZi9SQzlRZlRnaG40VnBxbCs3MTJhT3kxNjg1a0F5L1VPcnJESnky?=
 =?utf-8?B?UEc3dlVHRDdZNVZxYUhFdmFhQlN1SDB6eXBqbW5sakVscVJoUTJqSTZxQWJm?=
 =?utf-8?B?bGh4RndHeEoxeUg4dGFRZEZMM3krRFhERW9nQmRaTmpMcjArZWxRdjhMOXhI?=
 =?utf-8?B?TGxpSnJkcDBkSHZwelFmMkFGcjN5eWQyaXVoVXpmeTFWdVZreWRkUmFsNVRv?=
 =?utf-8?B?dWhlb2FNVVJyK0ZuTzI1K1hxNXlCbExveGtxQ3hnMHZPYlZvSzBrQi8ySVk3?=
 =?utf-8?B?RWNJeENIckJiVCtZbEFNTk1VQzR1Mk9yaHpwU2hENXFIb1Bpd1BNcnMyLzZo?=
 =?utf-8?B?c0Z5c21jamd2aFVVME5wQkJHQ2o5NlQvQjhhaXp4VUU2OUVDSTJuYXlQNGNl?=
 =?utf-8?B?R0NpQ3Z0M0p0ZXhwcTFjMjcwemJabWdWM2U3WHJzVHhJRmV6ZlZmUlJXOVdI?=
 =?utf-8?Q?VxmwvJDGt+YEEebmNiWCf84fv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f268b00b-be63-4537-594e-08dbb81ee498
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:11:42.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EZP7C+QZSLklGRxPXnuUpoIvZXCEQhy930uQiioehTuUH7n5TraHxq4GqovKK9eZDQW+nDwnyHoF+Prqc22pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Peng Fan (6):
      dt-bindings: gpio: vf610: update gpio-ranges
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 40 +++++++++++++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 21 +++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 28 ++++++-----
 drivers/gpio/gpio-vf610.c                          | 55 +++++++++++++++++++---
 4 files changed, 111 insertions(+), 33 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-vf610-gpio-46edacd2b513

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

