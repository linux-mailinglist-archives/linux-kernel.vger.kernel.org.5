Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB57810BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378731AbjHRQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378776AbjHRQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:44:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1644AC;
        Fri, 18 Aug 2023 09:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENyWAfsHZbdP+ZNUEPQ78xIU88q9TJQ2eQ5PK4ymA311tHrI9PTRZIlA9f5s4LzGcp4MaeygjpyyOrMHN4+yPNrNT5E+8y959rMTozET9x17kQHPsgNyRVNATp8MEBw2Psj66Pv5fE9VhKDUPmAe79TZp7ds24+HPnVFCs1ZFl4Sjwx0hnKL/eUtOgj3qPkcqB/ytgW7lQFkJYKnj2AufqVnK3iW1yuNtjube+7YSARAQLZQnfP5NpSsQKWcOjCI3HNfkFgPvTbmGM5vnKQx+rx49zvsUACO3tYDgYbtuLUMrx2pfARcodX0nAhEud4Gc19rJkDvg9ri3kTY8i/W1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73CXLqmtumSMwo/EvnPe9QfD0RBLp6OunUQqzto1Dmc=;
 b=lXey+2k00qrY0Reep8aSMBcylYxuVvJQb+ppNsOBJvzy6ckGhz/V1lV3bbmdY6rDaOHDjW1i+GS4bY3gzO2Il55cxbFDZFc7ixvteQb8CorqArnT4LLZNwFoSc4Sz2Ab6xeYvXk7d60b+D/qO4646bf16/lRsLx4REF6KHe/pgrtft1AhJsb8NJ5hV6hQm5NsqOTjcyRIbJ9hf2eoNZ79RZY58cz3cC7MyRnnGPD+RUSa509y6bMJ3LxVG4DKygY8so/pvCCeWL8A7h9CbHFG1vzIUDOp7khKJ/yEeQNeiVq1W44htKf0UrI7UI8S2PChl7JpJR5XzAUm77EfHfjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73CXLqmtumSMwo/EvnPe9QfD0RBLp6OunUQqzto1Dmc=;
 b=aGl896ZFpaOLKiuB6PvaMXomZER542nBMzmymQygydgJDeEeWdYkpIFwAUEkqU20B1DiLGRhJU5ubrebLxEEB+Se9MwasERr+pBGn3innQ34cMyCEM0728IDrq2yErOvAzFOviwnezPp1MaS3HaeCGdtpU4tAO+1Wto7nnOHy43iA2Vrr3f93FiZWA7gfNJ+qSDvI19ZMiLtDHHIjMcZKHSOB4X88BK2SPo+cOZA73m4GAXFi9ir+tY14oU/gekrIf4WVyzRR9GqlDTTxGIAP9eGztACgp3LweUql3k+qAG/8mo5BqOty/Vt19h/mXR3hny+1qSLdfRg6i4sw7DhFQ==
Received: from CYXPR02CA0076.namprd02.prod.outlook.com (2603:10b6:930:ce::14)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:43:32 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::c0) by CYXPR02CA0076.outlook.office365.com
 (2603:10b6:930:ce::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 16:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 16:43:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 09:43:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 09:43:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 09:43:20 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
Date:   Fri, 18 Aug 2023 12:43:14 -0400
Message-ID: <20230818164314.8505-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818164314.8505-1-asmaa@nvidia.com>
References: <20230818164314.8505-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef31c9d-890f-47dc-f5f0-08dba00a4221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdwal9YxxMh7R8QKBmEWGYHnXLNdPUAHxqIFkWOuCgziKhSGd3x8pP+IbF41C3PC4YEjQxtufATBvvZi2DBAB1mmN3iPk09Xe63e5XCnQbucX+iWBcWmj+AsML8q6FlPR+wDaiTOKtbZuRx/6mK5kzJertfckK34AcXuPl/+r+vyOO6ysSFetNlM76Mqzg3omJrYg0HB6l0e+K/jjoPkCN0Mp7oc3FUNZ+0zj7S2zGOFP8fL1Io9CeFIUgNKjVSxZ0sv1B0PuPqEcKeta642qwz1Fwl/deZgJsTQ8Nl9jXH0YZUWK8tDoeX5pZzI8TncpfVac4KOUSo6pZpwrRjo6fFWIrETzLiCvK6slsJPKtFZN4MX9dGk1yGD32HHiuZEoiC4036tz1pOPbs/f5usdtA3JDFPA4XTw/bFocYLdMR8GdBPgpilH5tXwOaVTUhrn2VNdUfps7eccszcfbtokYHRUPgD4pGJpnAZYtNqeDTY5XIp8Q2TSoUGmS+WGKLXKKmIXAeQG9HPaS+xweShm7UuKtKmHqg6/7885DrYNh2GvSVl3asv4sifMJHE3HCCdC4c9KI0d/ykMbZAtgkpOgd3RU8fMOyTvA1lxLfiDCmDczmJTyqnLf/AzTrcT2qrGy7Y1hvDgXTum7TUwb6A0AzC8l+6VLNLnrK4bzbuDAsuGtDjs6KiF/iL9JqcShB7NWSLx+q42gto/noISsVB86BiqpPpB3wNQGwX4BArWDA7+0+rl7niCHkcGROVBG7uMwbdgJHfwOuwmkVq7yAyzw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(86362001)(7636003)(40460700003)(356005)(316002)(70206006)(478600001)(110136005)(70586007)(41300700001)(82740400003)(6666004)(47076005)(36860700001)(7696005)(26005)(426003)(1076003)(336012)(2616005)(107886003)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:43:32.1602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef31c9d-890f-47dc-f5f0-08dba00a4221
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v4->v5:
- Add "Reviewed-By" Tag
v3->v4:
- Drop the common define for MLXBF3_GPIO_MAX_PINS_BLOCK0
v2->v3:
- Replace boolean logic by clear switch statement logic in
  mlxbf3_gpio_add_pin_ranges()
v1->v2:
- Cleanup mlxbf3_gpio_add_pin_ranges()

 drivers/gpio/gpio-mlxbf3.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index e30cee108986..0a5f241a8352 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -19,6 +19,8 @@
  * gpio[1]: HOST_GPIO32->HOST_GPIO55
  */
 #define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
+#define MLXBF3_GPIO_MAX_PINS_BLOCK0    32
+#define MLXBF3_GPIO_MAX_PINS_BLOCK1    24
 
 /*
  * fw_gpio[x] block registers and their offset
@@ -158,6 +160,26 @@ static const struct irq_chip gpio_mlxbf3_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
+static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
+{
+	unsigned int id;
+
+	switch(chip->ngpio) {
+	case MLXBF3_GPIO_MAX_PINS_BLOCK0:
+		id = 0;
+		break;
+	case MLXBF3_GPIO_MAX_PINS_BLOCK1:
+		id = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return gpiochip_add_pin_range(chip, "MLNXBF34:00",
+			chip->base, id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
+			chip->ngpio);
+}
+
 static int mlxbf3_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -197,6 +219,7 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
 	gc->owner = THIS_MODULE;
+	gc->add_pin_ranges = mlxbf3_gpio_add_pin_ranges;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0) {
@@ -243,6 +266,7 @@ static struct platform_driver mlxbf3_gpio_driver = {
 };
 module_platform_driver(mlxbf3_gpio_driver);
 
+MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
 MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
 MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

