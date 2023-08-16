Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4646277E581
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjHPPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbjHPPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:45:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FA26A6;
        Wed, 16 Aug 2023 08:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndi8/GRF5bPW5bKZr7fyuP0EOiVKfrWdD7pNmXephqhRElX6i7Ve/W7JiXlnkQr7zSmbCQkcGKW3vnH8v4jCavADTM7z7qZjoL11N/OLagavQIk0wU8e/Nllnzk6ICBpaXxSmWSF7d6VGtaJZgnxXVbsooqUMndWbYGeKrjZm5QjRrjy4xzAc8nwb8L7+cwxOYJ/CF1r9fgrPCiq92xC//Ztvsloj7ztYQ5qDa3JDGudtaVXkweEp4UOjXYVYsRCqWyzLTMDC4AIHkbpZaJ6sQEPApUsbgzdxtFGEudDooNLvzGksY4vN41HUSRV+BUU0f/53FNR2u7I/qM0SRz2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1AUDZ07OfA4mRMXb+yVaAgJ1tmbYJMdNc2O7Ul5Fhs=;
 b=cVfyB7qkyMbU4rup9rpReUIcaVc6VzVrY+JxMRFhmOfOx3izWeRnkQzKfvIXkA+3QAIsgwxThLpXy8uxU+M94q9IiQJPp5E0vcLjE4OG/zJ66M8FY7eV2kFxkgserbI5ILOZWluifptpgNggrMMAuUVn9e1RUk4uXyYcdaZfk/k5j7UQLwZH934VitWGMIlu1FoBl7DfYXwn1cVTvklwghTr+l8O0USEZ+rcHGjjoe2Vs17rb8d0rOKAstiX31PZnIKxaIMAg4+ifKrX3SlfVKtbPbSVWbXHi1gusqqwZe57gJNC6megzztdRZ/O/UGe/PM2WXY7SCOJ0nsgPv4exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1AUDZ07OfA4mRMXb+yVaAgJ1tmbYJMdNc2O7Ul5Fhs=;
 b=sKK1HvTCeoDCF/jQC0PzuUdx4B818HINHxnY7IUx7wi0aKCVEvw2ZCmIpYXADsZxZ8rX0qsLcyYVYqoNvUdbOGRfiUTKfuYGQfO/6jFRdIPO0d/vHiyw7REPgLAtyNi/2pShWeEiQWjnLvaUMIKaGjTnHZ5HGlw7QG3TLdFQ58iRZVEdybR30KO8m4hzpOPsMvk1w22MKaoBEAwPTd0mR3XAJI38gVMKEuiL1j6yA8BjqOPXq0pANtWAjG0p30nU5znzYINAlegBrk4Y+Xmo86QRYlbLuzhQeL4tRLeOgNtJU5iuzL4RplvPw5ov3eSURcXWK3wJcfb1X+a+WWVPRA==
Received: from CYZPR17CA0013.namprd17.prod.outlook.com (2603:10b6:930:8c::14)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:45:01 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::53) by CYZPR17CA0013.outlook.office365.com
 (2603:10b6:930:8c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 15:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 15:45:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 08:44:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 08:44:50 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 16 Aug
 2023 08:44:49 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Date:   Wed, 16 Aug 2023 11:44:42 -0400
Message-ID: <20230816154442.8417-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230816154442.8417-1-asmaa@nvidia.com>
References: <20230816154442.8417-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: a28b9db6-fd7c-44b7-4904-08db9e6fc0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVNTy4w0gPdt9pso/he5GoOtvEgniU+d/PnMkYgIV1EoDzDVy/L0nUrpKRTSNZa95Y+W0wg3kohl5s6MS2D1Vg7p06VX9MoP/Okgl1NYUcoUqI6iVn3ZleluWSCyztMZjucmG3h5vMtSJK8qpNNlsL2U2Pq98e5YGaJpeC+64/4SQSRbjYb+aSiASFmyIVmOoI58CnUQhO2TW9yKNMde3nU4qvexChqnOah6K9s86l5lHnkpikOP1Ub/ofrw9YtzVRqVZi2Q2w5w91O6b920veCb8EuGeTzudffnnRr+AysdFeIBgkXREAzQN0VJYtTrXBrPlZtYWqrRskmHJ65cQh6S8zf/Hs9LnqqlfZ2gB1hAgdEPICYy4AOL7nOX9bhy378Bqoiia6P30wJgYFrWUysGsamcZWEdaif0TI+61y2QSAWp8lzEdrbDrgb5pHqcZYnrSMaX8PaRvQnx9OaWdV7Ja6DyqaCJ89D0aL9iTWenp09dvFQ4PTruEDMYjwP7AXzoSIPBZWyN93Cx3yOROD72Bjfmpu/n+21Y8avkUlJDvWDdp3ZsBBF+1eqD4u5lmL/PfBz6hr/eQiGgk4SkUQa3/amz1KqnuKX3sGAe2xex1GhKLF3vp2zhaLTVVF7IFeQOj03i0MHMAC+Qsz4zmCjCB30tkCj4vvOVjk0X633Xo3+7W5BP4b13vY5/6zGhxvhivytuvu7aqbEgMcO6aGnm8QucIDYaR4A2IZEaP1fWtkbDmNCrpgIO8L5JW13x
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(356005)(82740400003)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(107886003)(7696005)(36756003)(6666004)(1076003)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:45:01.3602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28b9db6-fd7c-44b7-4904-08db9e6fc0b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support add_pin_ranges() so that pinctrl_gpio_request() can be called.
The GPIO value is not modified when the user runs the "gpioset" tool.
This is because when gpiochip_generic_request is invoked by the gpio-mlxbf3
driver, "pin_ranges" is empty so it skips "pinctrl_gpio_request()".
pinctrl_gpio_request() is essential in the code flow because it changes the
mux value so that software has control over modifying the GPIO value.
Adding add_pin_ranges() creates a dependency on the pinctrl-mlxbf3.c driver.

Fixes: cd33f216d24 ("gpio: mlxbf3: Add gpio driver support")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v1->v2:
- No changes.

 drivers/gpio/gpio-mlxbf3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index e30cee108986..d00cc61ea7b8 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -158,6 +158,19 @@ static const struct irq_chip gpio_mlxbf3_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
+static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
+{
+	unsigned int id = 0;
+	int ret;
+
+	if (chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK)
+		id = 1;
+
+	return gpiochip_add_pin_range(chip, "MLNXBF34:00",
+			chip->base, id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
+			chip->ngpio);
+}
+
 static int mlxbf3_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -197,6 +210,7 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
 	gc->owner = THIS_MODULE;
+	gc->add_pin_ranges = mlxbf3_gpio_add_pin_ranges;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0) {
@@ -243,6 +257,7 @@ static struct platform_driver mlxbf3_gpio_driver = {
 };
 module_platform_driver(mlxbf3_gpio_driver);
 
+MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
 MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
 MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

