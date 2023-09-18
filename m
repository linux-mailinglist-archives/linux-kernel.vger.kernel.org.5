Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBC7A4446
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbjIRIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjIRINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:13:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC9CCD;
        Mon, 18 Sep 2023 01:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXdCe7QYaA3DC0mgod3AeJkkk7E/3jg91WNxRWvKQrr4VHc9scy/JrtMM0ol65WzMMvLTvgKKe2YnhBAKbaVEFAhzCLp1lXWGb33fI1+AgkoYvhxH5XsgmEYpW6zAcPOmG5kzfWEHi1Wv1VhIOAbB4e8es2nmV4cA+EFNayOSil/sG2b9+HnyQMtaOKimmVo0CcjAHj4dH14K8aUC78E3+y2yLaqSiK9GFcHahD1LkVAKKg92gdokCotlldKz4hTic6WtQhPep7ISRdZGgoIbk1+IaInA9gVqxKC3l9/9Im8PAK9var9rSbQiifQ97O5C2rNzp49VL1fCSFeG3PLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U44AIPwM+ReyZbAGkQOUHn8DaaTMrFWFFP3j5j+CWfk=;
 b=UN/O/0fcZvB9C6MRoK3fcKk+NlDQg438wT3ElILuDI5SeMqXUcKoKcuARE561wimxxR5VKSV5OzyYNaHF8xv8oG+jiv6haleT/VjmjjHzqUUpi3AWmTrKT+BCSizYui+VrBrDdqdP418/NZS/NKLvx5PwD569McsfUomj/tkXSZcn4RQTMf4ruTjcO36hG+cTZyjoVQ9MYalWQBW/1cDyRX+O975412OzuUmXHH0jbuEPcw8UupLxYcQwb3FuNAC/fQZNDbX6DhSlJ7e8MkumY8g7GuWK9yB0KWo8q+dFU018/YbQ1yQtXStLNVmLkkXB2iqHPEh8e8ThKnL9f25sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U44AIPwM+ReyZbAGkQOUHn8DaaTMrFWFFP3j5j+CWfk=;
 b=CLt4as1O/rv4bdKIXM07vDITm0Z23H2bpK1UVsNJWvOHETwoK6RPozmWzdChnSNK2WdnTztXfAIl8WVWeu0OFydcUiKL26TgfYAtm1fSIhBUsWHGBvjJihkB1OHMhr+k7WUX4g9lgEPd491IUY1JEwfctP2aiM9m1qSfh9einz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 08:12:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:12:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:08 +0800
Subject: [PATCH v3 4/6] gpio: vf610: add i.MX8ULP of_device_id entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-4-ada82a17adc5@nxp.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
In-Reply-To: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
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
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=3349;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KIwUQXLlZAXkxFxtSdDA1eXGhBoOZN8UxphNKaoctdo=;
 b=mTPX5KPAlBjMnK0Y0+bWHGDEiHXY82PTK0EyR6zz39BLQXOZ3GPVQLn3/oMtdmTMCwXSbGHRM
 6AI3ni4tvl+DJvfcdhLmc1LW0pPZelFuVT4f4plSvyCnXFMWLziVSLU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b6d033-be69-4447-8f9d-08dbb81ef150
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WjqIuLTAAoZKtaXw448QH20EBKaftx8oFqSOfoTnhqAYfuEoTPC0GJE8qWhpdWzC/cyhbzRJuT6g4lB94rpMWZWnZDItT0KL8brhth7h72CRI7k3P5zcc0K1paLiIzx2ORaEX9BWTZE/9c73NUaVvUA6YTOVCyglYzA57KtpdpkBsFtmkyn7p6CIDLMDvl3FE0fVv1+GBeJHXHSUwSSfGf8ESCsdydhVTCjCwST8xVu3DN2ct+3Bj4ORW4zWek9EjBvf/KH5k+2rtRIiJ6VT1xslXuvOGxXxYLUnrwdtP9aRA5wQfkx3B74puo/3tnPd0Ns6vVdXEr78SVCvvfUptWYV0BdPp0JvY9Bnj3GZWAGhn+D3EuvvEmhttiIH1sb99W6McnJdnl6ZlDx3bSmprxvf0LWGWHL0R3EKU5wdqvXPK4uVm+WqAlHFjNFnSAGV8YcaVWkxYfhrFWOyDA25orjNVSDJtg3+OaRRbpspOhZioMOx1lxAZLf0iwotfqWKCzgeGB35tcdzpWXl5Xh8zX5irYuDErDVHSLbDEoROtWBpOHuJt805mpwPd3LZJCIoidUb2PqmJBaLKzb21DSt5hFixRu0xmsYKQbWkhBGizuUtPFKCAcDinjz9pbnLhnru0IEJ6RkUURzjNKAj//A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(2906002)(7416002)(5660300002)(8936002)(4326008)(8676002)(26005)(41300700001)(316002)(66476007)(66946007)(66556008)(110136005)(478600001)(36756003)(52116002)(6486002)(6506007)(83380400001)(6512007)(9686003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElkS1NGS3BKWS9tbkhPeDNaci8zRGN3czZYclhkb1BKck1EbVZRUWk3SWU1?=
 =?utf-8?B?YXlXRUlic2V1U2Fpb01aMklsREozN04xd1V6Z21jdm9YOVgzWUN0U2Flb1gy?=
 =?utf-8?B?bWRwUDlIbzNkdVo2TnNOZTR1TDFNRWlLUVNxdmIxaGxsNkUwcXZZS3JLMGlS?=
 =?utf-8?B?cWpXZUlWWnhjeG1TSWNOTzl2N3krKzhBVXJncUFva3RoVXh0RlNQR1dVS215?=
 =?utf-8?B?cjl2OUtDMjR4NEFZSjNHL0E1ZEtJNXdLb0VBUHJ2cVMxSXZDcWdTMFZQYjJB?=
 =?utf-8?B?UWg1U0IrKzFQMkhSLytQWitFMTY4U3J5elRkNmZ6L05QOGJOSzZkTlJtbHVQ?=
 =?utf-8?B?MkxLZTlVRjlXUDdNdXh1ejhWQUl1dmVqYVl6MjNwL21sZ1lKS09hdFNrbk9R?=
 =?utf-8?B?QmV0b2dESmhIUjhnWGNFNm1pcVVYaThOVnRvQUhtQmVSOFFQdUJsVnpVUDRV?=
 =?utf-8?B?T1FJTUtmaHZ3OUpEcFZkNzJkUTV0ZXhuWVA2WU1XcE1rZTRtdU9hWHRzZjE1?=
 =?utf-8?B?S0RBU2Uzd0UwaDRKR2x0amFJUHNUcmhwSlNOMEFvYUdHMzg1cWhpN0M3V3Bv?=
 =?utf-8?B?Tm45b25pcDEzci8vQWJTRUVxMkZUdGRnTHc4QXlBRkMzOERjc1krS2krenpB?=
 =?utf-8?B?MzVTTnVwRVhDRjJWMTJ2ZjhhM2xRMzFuQlRGdWhnK3JCOU1zVmhlbDdFRWo4?=
 =?utf-8?B?Y2REalh2NjBzZzBSWEI0bFFTRk1kOG41L1JaQXJLMjV1eUcyeVFLMHdXK2NT?=
 =?utf-8?B?MkpDbDArLzU4QTZ5NUJOMFVQbU1xbTVERmRta20ybFMyTG5YYXdreHJsUE5l?=
 =?utf-8?B?ajNVN1liN25xcFlwdHgrMHV4c1lHSURoQmVDUG5wOW1HOStCWUVKbFQveXRu?=
 =?utf-8?B?a2hvWVQ4TGJSdVY0Z0ZBbHZyZEZYQ0NBQUlqVGRmNXBsajErM0lHdEVXOXRZ?=
 =?utf-8?B?dTlsQkowKzZHTFFpRFJiZDFWT05KQ2V5VzlPOWRZdkpxdk9INC9tVVNNelN4?=
 =?utf-8?B?WlhuSlZqODVPeHJoMDJkbk14MldwaEhGM1UwTEF1NHFucGRoUDZPckVQZG5a?=
 =?utf-8?B?RVpyVVQ4STMyRkd3YVBPZ3ZybnFGRityK2djMkdCYXFjeVFOQW51cURQZWxj?=
 =?utf-8?B?R3FsMXM5THdlWUR3TWtvRm1lMVkwSEZzVmNaSExsbnZIcGhDZDlGT2xXck8x?=
 =?utf-8?B?cFlncDVBV3ViTmRVTlROQ1dlSUFNNjlITGozdUl6dkNnb3NoOGdOSFhLYjRO?=
 =?utf-8?B?ZDd3bG5wWEJIeHJ3dDBJWXNYcnZ5Z1lUK0JYbit0V1k3WEw5L0NKSmUyOTV0?=
 =?utf-8?B?cmlBV3BjSnV3WTg5UXhvczJXaGdibU5XRmJjQ3doeGVPTVhiTTgzbDh5WEw1?=
 =?utf-8?B?djdxWHRhRUtUODBSQ0ZlT2RtWVFkbXpCOFV4RWdOOWc0Q0xxYmJtTzdUZFYr?=
 =?utf-8?B?WXRQSk1RWkNFZE1rOVdYM2V1UmYrT29BUU5YTHl0dUtpd2ErRXhNS21UcTQ1?=
 =?utf-8?B?dDY1L0Q2eFVHTjNSQkk0c0IvbWR5N2xwN0hiQVdxcU9TV1VwQVowWG1pZHJT?=
 =?utf-8?B?bEUreVplSUVsSUt2OE5iSURhOW16eVNFRmZISVROazFMY1NoN3o3QzFyd0dB?=
 =?utf-8?B?TmQxSUErYmM2Y2dpYXMzQ04rU0V0UEtDYlphcUdMVjNpYkc3akV1OXowblNT?=
 =?utf-8?B?b2VkQnk3Z0hFOTNTRVpVRjV2d2VkSGFOOEFGdFBUYXJiUEdObXJ1N1BPL0dB?=
 =?utf-8?B?ZjdiczFsQ1p3TzdnKzBtWnhITlJFR1h4Wmc0a1lpaEZ1YnAyYWtEUzJFeTlJ?=
 =?utf-8?B?K1F4SkpTRi85VUFIREkveWxUbFV2TnI2ODhyeXYvOSsxc2tZaWtJM2tWMThP?=
 =?utf-8?B?VGUzQkx0a3lhS0FMc0JjTUIrQVpsTWlnRUp2M3ZxbmI2OUQrejdNMVV1Q0hv?=
 =?utf-8?B?Y3Awc0ZVT1FJaTlIWmUwOXMzU1ltU3ZiVkJYWmVyamFYSHJ5aGV3WjM2ZHNX?=
 =?utf-8?B?NTVYbHdsSGllK0hTUFZrREdycEhaUGYyRzlQalRic25PK0xETDl3VWdzWWxM?=
 =?utf-8?B?MWRlYXpjaFloZHpCUko0T0d5NDNUMlJVc0M5T0o2RXZPS2JMMmYzTFg5d2tM?=
 =?utf-8?Q?Yjuldwi9fBnzza8F+XfpDYzke?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b6d033-be69-4447-8f9d-08dbb81ef150
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:12:04.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/lmeqamCOyBvFwx78/9xnFsJEUbtt9I6bYQnEHcflzo4GpF3vYGgAU9sCztOFS6en5chs7Uz5h5HFui/Sl0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
not compatible with i.MX7ULP per binding doc. i.MX8ULP only has one
register base, not two base.

Add a new of_device_id entry for i.MX8ULP. But to make the driver could
also support old bindings, check the compatible string first, before
check the device data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..ef2455093708 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -25,6 +25,7 @@
 struct fsl_gpio_soc_data {
 	/* SoCs has a Port Data Direction Register (PDDR) */
 	bool have_paddr;
+	bool is_imx8ulp;
 };
 
 struct vf610_gpio_port {
@@ -60,13 +61,22 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
+#define IMX8ULP_GPIO_BASE_OFF	0x40
+#define IMX8ULP_BASE_OFF	0x80
+
 static const struct fsl_gpio_soc_data imx_data = {
 	.have_paddr = true,
 };
 
+static const struct fsl_gpio_soc_data imx8ulp_data = {
+	.have_paddr = true,
+	.is_imx8ulp = true,
+};
+
 static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
 	{ /* sentinel */ }
 };
 
@@ -255,6 +265,42 @@ static void vf610_gpio_disable_clk(void *data)
 	clk_disable_unprepare(data);
 }
 
+static int vf610_gpio_map_base(struct platform_device *pdev, struct vf610_gpio_port *port)
+{
+	struct device *dev = &pdev->dev;
+	bool dual_base;
+
+	/* support old compatible strings */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio")))) {
+		dual_base = true;
+	} else if (port->sdata && port->sdata->is_imx8ulp) {
+		dual_base = false;
+	} else {
+		dual_base = true;
+	};
+
+	if (dual_base) {
+		port->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(port->base))
+			return PTR_ERR(port->base);
+
+		port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(port->gpio_base))
+			return PTR_ERR(port->gpio_base);
+	} else {
+		port->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(port->base))
+			return PTR_ERR(port->base);
+
+		port->gpio_base = port->base + IMX8ULP_GPIO_BASE_OFF;
+		port->base = port->base + IMX8ULP_BASE_OFF;
+	}
+
+	return 0;
+}
+
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -269,13 +315,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = of_device_get_match_data(dev);
-	port->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
 
-	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->gpio_base))
-		return PTR_ERR(port->gpio_base);
+	ret = vf610_gpio_map_base(pdev, port);
+	if (ret)
+		return ret;
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)

-- 
2.37.1

