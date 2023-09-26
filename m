Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45507AE42A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjIZD31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjIZD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE991E9;
        Mon, 25 Sep 2023 20:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcCQj1UB5cm2W1CPs5DYSUE4rd/csDoGqQXiFIgNrNS+0u9Wk+kBIwPb4yQCm94bxg/Wcn4DgxtQIzhi4x3ov39XIrOoVcTSML03Os9AuyI4Aaejnms8vMC+xi99U/m+NZmzaEgHnXXlupPo+e985qS97Niaj+N6vyAppkHAlINRjKalwB6HUXEQIjD7MxY8q+i2Yhl2m/jtGenKDHZqyeRG+rLYxIt6eM9Xy/vznY8nBB7wUcBeYZpANkFORIUNZ9tGHUbiHq3Tmvu8n8jrlI0WHz0+Nc01GJRsOTULDytQqskmnU4FVK3FKUxgEWakGiVgNT6CEsA5RZKypa1pJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x9H1Ce1qmUmynZ0C+sr8L+tCdY5jnEewoTuImSmj+c=;
 b=SYA7ltTuq6gQ2tff3oVU2184UzKHIo2F9gah/wXsdJfcF7jNyNhmUha296UKhQ3tP96vzE843Y7W2lnk2S4UUS7VNzgbybuT+rUx/U+UmyTRcFdt4+Qb7ybAXxTZkpG+tRlu7cwRJ5TrKnr/fdyNVYRoE70THB5HbetxPB0oYc9kM8cbvBxwoXoZfQhTXxFNwHI8UYmRM0mJiMMsB6xQDAjrHC0IJqxKfeCwD0z/CL4yiMBIWj1djVBzE+dwXxYdtcVa7Dk6GkUns2y9zFM9hYI+IXcSC9Fu3GM4gsCg5ba+60EFmAbd1GVRXzz969c6lJLGHBnYo8G1+egQTvr9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x9H1Ce1qmUmynZ0C+sr8L+tCdY5jnEewoTuImSmj+c=;
 b=eg5ENCGJ406G9XxUNCVvhmKcOd5Ocye+vpF2LiE4uIRnluSKy9faIIpT5OFdaSNva3DJk4hSnJiXRnGDf7w/GBJi4DT4I/xn80nsqNXlhMNxi45/YFaNEMEIoZaZ6UjEr3x4FPR+6r4qog3ntGd1rgZUQ1FMzZy3UgUm8ui/w0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:29:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:29:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:21 +0800
Subject: [PATCH v4 5/7] gpio: vf610: simplify code by adding of_device_id
 data for vf610
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-5-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
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
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=2667;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6f39vc2cftNdy+/GaahiBhBp1bGlVPLOucytL1yIoAw=;
 b=GHK0VJqZSSbmQY15QcyO9yutCxZdbcD+4lti8idqyJIhChzz+qc79NZfDXFcp4QSQl7pTAD+C
 cGGCTjf8J2XCOTmqhDJvXZ8A2qdfL4JW1ER68DNSRWhFIKBFXp8iEq8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: bd04cf7d-522c-4dd4-2655-08dbbe40bf7e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RP8SFdOF0YBqZ/26+z+ot4RCUy36X1+LhSi+9K5AFvam9kYhNNP44e2xHvesJW9xHDJJWyPABSYbftd1LisTxNhr2lJ0dzkg7OAN3PK0Ic49ehyZ1gJQ7oGOZVM3jmGfiewUFS+0GKEEichEK08jmhLNtx/FORXzwRnM6ZXXRC6kWUtrP3VRmJMG1Q20doqlIKgTSRLDSjfdJjdZDmAj4LiTdTBIzdg7x+DglJBjx8gDyYBqnXquwseHf7X5rtX3YlfAS3BzOf79HNDQAr13IE+1mOtKtqU04jaubCDZDVlCgHoHwp7TgVpCwj48fqVUo+8un1faQdfuMvN5yH/gGKQr3MasvVVH+BNc6uLCQDGbHo34uLSugQN6pd+5zJq8pf9s+wxtPT1bANsccsLTCHLp1KB+N+vkQaNFd046AWMu1HvYTGr0Rz6fWFNPZMK34MC9MBjNNLJld8uehAyYNyNHQxwMmqiRUCxXM0up7pUCozJt9PXJEx/JrRO8se0tmzTXPtTrs6chali4jZD195+VDvYY6W2Zf9A/EY1WETsSmrnDjhuUvSXiiZB6KTGSYEz8BjV0afbkTC2VtPtAvPMvoTz6wp0JMHfAyjWYf/cXgN8YQSxM98ZUTYKqGxCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FjWlREcmVIVFBHdEtaOERIb2VjY3BXcmY1aFdVZ3EzR0dZSy9OWlRveThX?=
 =?utf-8?B?S3dBYm1UVFhmSTh3MWU2bjh1NW1zMXVIeTJRSi8wb0N0Y0hEbUxBQW5Lb3RP?=
 =?utf-8?B?bmVXYkJlenEyWlQxODBrMjNRMFJLdVBXaTdJVVFtOVViVi9LYUpyS0N3MUpW?=
 =?utf-8?B?UGN2TFpOSVRnNGgvdUdlUDJCQmZQWFl5UXA4MXpVNzRpdEhvcFBkOW9hYWor?=
 =?utf-8?B?ZEZXcnoyV3FudXk3Z00zYjZzTzBxZGF6UGdXQlJPS3IwcGdib1cvMVZLOG83?=
 =?utf-8?B?R2tLcHRLaHBidjJlcWN4Z24vbXluOXh4OXNKWm5KblZWZFVwalFRTWtrbisz?=
 =?utf-8?B?ay9ocGhiY21YYWtURnlCUkhFeG1RMkZxbmk0SkFsUjRXdDVqTGdCUlkyUG1s?=
 =?utf-8?B?UUpSTEtFakNnYkNURWVoUUMrL2FhMEo5TFVNOHJxSllEUUthSHAvcTZqMW9K?=
 =?utf-8?B?cGh5bjV1bldiWlhycDhQUVlJOFdhZjVhY21Da0tTZlg3R3VubmRYK3pSdU9Z?=
 =?utf-8?B?eEdlckdyN0VqaWQ5OWhkYU9xeVN0L1RKZW40UFRHRjI3U1ByNFZ5NElpR2dU?=
 =?utf-8?B?bmRkYmplMDBSY29LMEREUWRmcVFxR1gwTGJzVGx2Z1lOZS9wcWVFMTdiZEQ1?=
 =?utf-8?B?TDE5aXNPdlAvUmFpQWN4SDFkZkQ1V0g0ZlpvWU5nT0U0ZWM1TUlPWWU0cXda?=
 =?utf-8?B?aUh3bm9zTWxHSlJVOU83eFhwcndrVDJ6YnA1WEZSZEQzN2pnZkJRc21veGRh?=
 =?utf-8?B?bDI0WUVXcmdvMjNicFUyM3ZKbUMvMzFyNHUvOFVxclpXUzVJVGFPQmdNVmdv?=
 =?utf-8?B?dlVYTEMwcWRTczZjbmJoV0ZvWURsc1NnVlZmYlRnZ1ByNjRaV2tUSXgyWk80?=
 =?utf-8?B?VnBQT0tmWW11c3ZId0U1QUZrRGlUT3ZObEM5NzZ0eTlvQ2pBUmtSSGlYYTNy?=
 =?utf-8?B?bGMzUnVHQ1NnOXc0SVBDNTVoWGlhbGNlRVZiVWhXZy9BZ1hHNVFhTlFoYmlD?=
 =?utf-8?B?UXdZc0RGZ29JbENsV2Y3ZjBER0w5ZGNKdEdPWnBnaVhvOTdhR0xPY3U2WG53?=
 =?utf-8?B?UXY2ZTNMUGtIVDV3Rmw0Y1dEeTBvTnorc3JMSVBhdDVtVjVhTExXZ2lUSXNs?=
 =?utf-8?B?VEQwZjViNTQxWTVlSzEwOTl0RnVQVm03WXNqa0FjM21WQkVtTktxb0xVZ0J0?=
 =?utf-8?B?aVpZUHhGYXRJMThIRTgvUTVqMldlVWJNbHBiUEE5R1crMUFnNDViN3RGbVl6?=
 =?utf-8?B?MmNYRmJDWUQxdkJ6Rm9COGtpaUJmenZXM3YzZEVQZjVWdHRQR1lMUmhyWmMz?=
 =?utf-8?B?YnlhZjA1RW5JNUZ3QWdFRGM3OHE2N1NvZG41eFNoRGFWT1lwREFOZFdoaTRL?=
 =?utf-8?B?RGJKNDcxZ2YyUzE3TmNpOUJIZzZvU1FmbFFyVDVSOGFBOGZOekVNQTNLd2ZU?=
 =?utf-8?B?VmtKTUhGU0lHMFlRL0NxbUVlV3hxL2FQYWJLRk1xMExkUFJieDIrdFFoWWxY?=
 =?utf-8?B?OU5WaFd2ZHZHYlZ1Z0VTMytSaDFhelFmcFFkUWJ4T3NJcGtFTnNrYm9uY3hm?=
 =?utf-8?B?ajREQm5leGdnNHV3SkRDaXlUalNYVHgwSzlMdFZGaTNCQjhDZTd3R0svQ1l4?=
 =?utf-8?B?VEtxYUhHeEJ1SS9Zc3ozN09qT2g1NmtlL29jVmZjSmVxOEt2a2RUT2tkZUVM?=
 =?utf-8?B?M1cxZmhiQnFOUjBVWUY1KzIyTldxYnA3ZG9RNjBhU3pLVDBVWmRwbTVob2FJ?=
 =?utf-8?B?bjVucGR3UG1SMm1UQS9HWWtCdk9ITFQ2dnJ5RS9HQWZKQ2NOSmJqZHIvUUx1?=
 =?utf-8?B?WS9KTFlxWXo1TGd6N29TZ3NQYTZSSWpUMy9ja096MUxnMEh4czk5YkpFSkJj?=
 =?utf-8?B?WEplaExxcjVoeEI3OTdFUzdzdXFNQ2NSL09YUWJkSkd1VDNPRnd6Q0FyQTJH?=
 =?utf-8?B?Si94OExQMnoxY3BQVURaTkdZOTAwalQ0Z1pRakk1YjRocFhqUkFjKzNkSkhT?=
 =?utf-8?B?QTdzR1pSMTJKVFJkUE9TczlVSDVCRkh5L3JHM0hUWkVFU1FrTDVDNGtJdTdx?=
 =?utf-8?B?L3ppVTZqNmxQa3JWd0ZDajZiNHlyQkNxWnNiQVU3aGxwdFB5VXhpTTJGS0ZZ?=
 =?utf-8?Q?88SgeyAppQZLgwgE+aYV/Raz4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd04cf7d-522c-4dd4-2655-08dbbe40bf7e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:29:10.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfN0lspNCtaju7KSpxg+Jh3+FTWFLKhNBVoYhLoVx97ShjN/BnUwqnkCjZ1eSQVIhrdoGNYDvwiDHDe38PDuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add of_device_id data for devices compatible with fsl,vf610-gpio,
then no need to check port->sdata is NULL or not. So code simplified
a bit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 49867d5db642..c48a3bdfb942 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -64,6 +64,10 @@ struct vf610_gpio_port {
 #define IMX8ULP_GPIO_BASE_OFF	0x40
 #define IMX8ULP_BASE_OFF	0x80
 
+static const struct fsl_gpio_soc_data vf610_data = {
+	.have_dual_base = true,
+};
+
 static const struct fsl_gpio_soc_data imx_data = {
 	.have_paddr = true,
 	.have_dual_base = true,
@@ -74,7 +78,7 @@ static const struct fsl_gpio_soc_data imx8ulp_data = {
 };
 
 static const struct of_device_id vf610_gpio_dt_ids[] = {
-	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
+	{ .compatible = "fsl,vf610-gpio",	.data = &vf610_data },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
 	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
 	{ /* sentinel */ }
@@ -96,7 +100,7 @@ static int vf610_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	unsigned long mask = BIT(gpio);
 	unsigned long offset = GPIO_PDIR;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		mask &= vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		if (mask)
 			offset = GPIO_PDOR;
@@ -120,7 +124,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -136,7 +140,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -287,7 +291,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
 		dual_base = true;
 
-	if ((port->sdata && port->sdata->have_dual_base) || dual_base) {
+	if (port->sdata->have_dual_base || dual_base) {
 		port->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(port->base))
 			return PTR_ERR(port->base);

-- 
2.37.1

