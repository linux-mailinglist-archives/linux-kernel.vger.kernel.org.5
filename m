Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB47AE428
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjIZD3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjIZD3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD741C9;
        Mon, 25 Sep 2023 20:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddlsC5epuC1lyDGe6kAWgy8f5yxxwnFyH296JFS4Xm74kaqR0q2ewYHncv31TRcpKvwZLrH/7PiRUmxZeCHJJo7XhvzvA16h5G3yfVn1swCgIn+gIZZtkZBJCX14bvnzyve0GeGqJxvKUDq6TZv9HIwtwiji66+gvN540/yHoh6nWPShUM+oT6Iw4qEGLlQsBKrUgLSjkCnxOHZ8cBVhynL1xvIbTs31QVL+7ywPBRtmxZ7QJ2hCJbGBj/qNAqEToc7pggyjOmQs3bl6pq8q9zA3efw/M2NuBurAxDjwFcQQaYr2/DysN++HzeVJxIDzvhqTGDjykw+ZhGWH7pgkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF9Z9hfm1NOCcRVSQ9L+4/sD9M0C/GPIdy8+5yf3jfM=;
 b=Z8GF52P3HhK9BLrutYoDXFjSM99ymhJLmF8ZmVKedzIWhzslIm7vJxTGyEyBfnM5J213p0MhpKkImPBFPy/bduSUPBvSp60Idm6Gs0C654lpwWO4UeFtdpC4BDZnUuSLEBOsHModcCtmeXragb/OMNfTxsJz2w97MtfvZYitEbqU7jcQzmxjkIakMRS5lvomhaVOnAZ9MUviJlFuRTRKSNj4tpZyXIzBrU6oFHru1hW6YPfz2fZT30fY4SeHjyDyHpBC3uHfKcULCkaqwYRlE6jI/U2ppay8WGDaTL4RVKMekcPfh4irVVpsVeTCMWdD5FgKxH/icLrrgkcAp75nYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF9Z9hfm1NOCcRVSQ9L+4/sD9M0C/GPIdy8+5yf3jfM=;
 b=lc1YJZc/w//MF7xC6euVCWeUxz8g+6hXMt6Ygl1odR+xn82r1UJH282LUGmO/oGldC1iGrHgz0eyqC1tmxUeFm47TQtoaJB3eLrBFBleI9BTqVtdpd6J3GjHpZzmD+fcVOb/737U1gZceci/HLAykW+mWCojwawkQ7ufCdu64Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:29:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:29:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:20 +0800
Subject: [PATCH v4 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-4-b57b7f6e8368@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=3299;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JDd/Dfh0RICGNA6i4o6IJd1MoixG0t2bjL+zQLo9U4s=;
 b=nrW/tDIP9VbgW1pBB9/EU4ERbUoTBcnJsHotxlbehtLsZNixjI8Jl7jSiuF5ILDsQAEodBL9+
 edhEzraSX/4BDz4At6G6n8swoBGgaZxI3pghlUHe8tWh2O9Cy3saw9T
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2e9388-bb6a-4564-e6ec-08dbbe40bc6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vw67pzaXgPgDe8GxM+1/jZd1R7t0QfGa7BNFXSyWVGOx3Lh7Ve7cvSesAxL2iZxY9hkI+yfkm6i+Y0V5e+Lt3NnYzs8qO2fVnOJnlH3iLNq8F4+miPDQVfm5PsDdXzaKuuBWeIWIXcKEJuh6fWSGES+FN9BEtP7DQMigzpOoxY0OdAUPVrfcqpDChDvRBSdpnGnXzdc5/MiiSarapMvG0jHcXxLMJgmcREJCATDX2cVc/IQ4d2J/EU1l5/eZs0nNIg1o9ndaQeOa21pS/GqeJPJi+TDEoqUPk/kMQwXkUoPa7Wz9aP8G5bzmb9lV92M5Bd8VPKohg1l+g6Jkt3ohu1YJNPFBCqQoJZQ0vscpceQyOOI2OphoDUZfAdv9N0wIJ+O9Sh93XNX/zHdadviePUHZeOWCm8369WuvTpV0PZZydcZWPUdHC+cLEid8TSxcqzgG1Qywk0b4Yf4G3miRdsfbhY0szst2o3LWTnCzrjrU4XeQtP2MegxUo9GUoL+mbxTRdrin/ejs0ZOLU7CImhRUercgw8wNRvtOClx9ij8c4xjAotbHu2bsVszOY85cue9NP2GsCz8UZRG6euliOO4u8qleC9YrybfEDlNQHSwAlZXZ1dCdLWzmXRfoqRIHctIULAyPbU8QSvPoWeytRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0F5MnMrZWZVWE5NQ3daSlM3ZHVkL0JiS1l0K1VNdkFvQjJUQjAzOVRwcDd5?=
 =?utf-8?B?b25xWXEzZ0NqWkE5NnVVSXB6RHZQYjJqcUZWaHVnOWovRmNKSmlxdExoN1Zt?=
 =?utf-8?B?S0VwdlYwajI4MzEraFhENzFrUldiTVNTeG4rTU1LUXQrRzMvdS9oRzZuWlc3?=
 =?utf-8?B?QVNra1VQQUlmYVhQTnEzRGx1ZXZDczE2eVphbUJmdGdVRmhjMFZLOUZXTG4y?=
 =?utf-8?B?MnZoR0hUdDArZmp1L2lpMDcvS0p1OXRHMm52dEI5dURVSHY0R3RTeFRaMTNE?=
 =?utf-8?B?Zm90RzJiNEdRQ3BPOW9aSUQ0WFVnbzZCbFVsSU1YK1A2UE1UOFZYRmlsajlI?=
 =?utf-8?B?c3NuQ1BGN2d6ZE9COEpHYUJ0SGYwWVN3OTNJQ1RzZmxmZ1g3YjdhRGZvWmhC?=
 =?utf-8?B?Y3FRTndjWi9uMzFuaXo5VWJZcFNOMEdtUlBxKzdsZVQxVHp1RXcyOVFhVDZK?=
 =?utf-8?B?eUNZNW9OMkxCaHkyc3BvV0VTZDI5WFBId3R1QmY2ZW9GZ2VDMkZ2TjR6RFZK?=
 =?utf-8?B?N1BDL2RyeDMrcGQrcWUxMFZ3bkNjb1RSTE9mT01HNmNoVlFnUnduc2h4bEF1?=
 =?utf-8?B?elRHMk16eHZhZVlQeDBoNXFMeXdyWkVVTWRUbU5WWVlzMUZLb25BQSs3eXVk?=
 =?utf-8?B?MWkvbm9NUnh6R0REbUVhcWhSV2V4M01LZEMvRzRBbFRueXc1aDBQYXhTWTBQ?=
 =?utf-8?B?TUViVXg0NUdpallzR0E4ZEJGZzFvWEFtbEtGS25zTGgwUzlvVFc4cHVQcGFx?=
 =?utf-8?B?MTZUSCtsYnlJblFpWDB4aVl0dkZjaE93V3FyL2xSZUU3M1ZNM2UvZk11ZVhX?=
 =?utf-8?B?Q0pPVjFvbVFiUXNRQkN0TWNJNXNJSU9tcHRKdldQTFp6QXJoKzVFbXFDREZX?=
 =?utf-8?B?bkRHYjFxc3RaenM1R3FRd3J6RExtL2FPT2V5NGE4RWRzbVI4QTRZMWt3Skts?=
 =?utf-8?B?T1AzVWhVdXJqbkhGb0YvUVJTWFE3SUwxOGh2K0xaaHh0aC9OU1lDQUVMSUwy?=
 =?utf-8?B?UHVVMjNyZEFBTU42VDlqNzcrNmh5TkxrZUVsUm0wNmpWNjlqU1RSK0VubFk5?=
 =?utf-8?B?Lyt6VHhHdzVmZCtvbURwVXdDOGVqVzVZdzYveWpWWGVWbXhIL0tsRFlJeDl0?=
 =?utf-8?B?dlFSWC9QRExpWW9UdGdPSkY2UUtxWEplcXVVTlcxR2hwZFFlZGZuYnNlYUF5?=
 =?utf-8?B?SWY3U2NtaU9XNkw2U2p6ZnVxbGkwa0hLOFliaVpJeWkwcTJtNW1rbjdmUjJo?=
 =?utf-8?B?QWYwcUlQY3NuN1ZPMWROQXUxR1R0REVQdGFPQk9vOUxmYUlNZXd5SFp0QlFP?=
 =?utf-8?B?TmFUSFZKZ043bGwwNGVVdzlvQm55S2xES2JLUnI4ZmFQN1dzR2ZzVnZZcnRr?=
 =?utf-8?B?VjF2K1gvOWNReGJiK2NkZ2VPV1BjUHNhU2FvT1g3KzJZTFZFc0RIR3pkRERr?=
 =?utf-8?B?WGpUWC84N1locE95Nm5wWm0rblZWamEyZmtuTEp6ZkJjMTVTdG9pOVduelB3?=
 =?utf-8?B?dG5rMy9LdHRUUG9tS3dPU1V6RE9xZzZXbzNianBqUCtIaFBXa0ZxM2c0Tkor?=
 =?utf-8?B?VFBlenRZTVNxZ2ZKaTN3RkxSZ3ZGRzRLaEIyaU5HcUVvWURlRUlOa2FET2kx?=
 =?utf-8?B?eW1xd0dGSWwyWkxIWGRvc3ZPcHpoOHM3dk9ncCtVTnpmVWZlZXZUU0d2Z252?=
 =?utf-8?B?ZW1XUFE5d2pLQk9kQUh0UFBFV1BlbDM2U2E5dUo5UzNIekp1UWlsa0lBNGNl?=
 =?utf-8?B?ckhxSlQwbXBmajRGTi9mZmtxRStxeHU3TnJkQ1pzaFFPVVE3cjVUby9PUEQr?=
 =?utf-8?B?Z3oxVjJ4RWxVK09TUll6ZjhFU21hK2NLNVpETS9tVnF2WWhMa2x0QTVRZ2dm?=
 =?utf-8?B?RjFhL3lCR3llOTIxQ3M1VDdSd1U2azJQY253ak9FdU9ydzVvaXhjOTdXVEkv?=
 =?utf-8?B?R1JGb1V5VXljcmlta3dEakZDWWtnbXJKdUxnYWxSWlNvcjA3Rm53QTVIcjUr?=
 =?utf-8?B?YjREZE80UXByTS9YR01sQlZPaDRmbVV4Sk50NWZESmROQVdmeVVxWEppSmRG?=
 =?utf-8?B?VjJDZzB3VG4zcWZsZjRTRk1TR3U3NlUrdGNTakZxb3hpeFBsejVZM0ZhS1FY?=
 =?utf-8?Q?sj87eD6ZQVOXSc6YFEtsL/sbH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2e9388-bb6a-4564-e6ec-08dbbe40bc6d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:29:05.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v35RK5Qdo+wJH5CX2GlQvj5hVOIE27rrabEeKzsAsDOFKtRyqWZPttnChHGqim+FtqtFvv71TkRNQ8uMkvCfkw==
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

i.MX8ULP/93 GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
actually not hardware compatible with i.MX7ULP. i.MX8ULP only has one
register base, not two bases. i.MX8ULP and i.MX93 actually has two interrupts
for each gpio controller, one for Trustzone non-secure world, one for
secure world.

Although the Linux Kernel driver gpio-vf610.c could work with
fsl,imx7ulp-gpio compatible, it is based on some tricks did in device tree
with some offset added to base address.

Add a new of_device_id entry for i.MX8ULP. But to make the driver could
also support old bindings, check the compatible string first, before
check the device data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..49867d5db642 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -25,6 +25,7 @@
 struct fsl_gpio_soc_data {
 	/* SoCs has a Port Data Direction Register (PDDR) */
 	bool have_paddr;
+	bool have_dual_base;
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
+	.have_dual_base = true,
+};
+
+static const struct fsl_gpio_soc_data imx8ulp_data = {
+	.have_paddr = true,
 };
 
 static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
 	{ /* sentinel */ }
 };
 
@@ -263,19 +273,37 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *girq;
 	int i;
 	int ret;
+	bool dual_base = false;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
 	port->sdata = of_device_get_match_data(dev);
-	port->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
 
-	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->gpio_base))
-		return PTR_ERR(port->gpio_base);
+	/* support old compatible strings */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
+		dual_base = true;
+
+	if ((port->sdata && port->sdata->have_dual_base) || dual_base) {
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
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)

-- 
2.37.1

