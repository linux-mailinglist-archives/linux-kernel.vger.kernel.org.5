Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F4780BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376919AbjHRM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376920AbjHRM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:29:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F75DE7C;
        Fri, 18 Aug 2023 05:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+oXsxnvJN7e3+YFSKiYKoZl8e9EjeNfEmXf5GpsNYdoAtEtyY6+m70KL/9aqZ4oJQVD20V8MYzs0XKSQhzTZWMMej2qiOicfz0D0pDVDIqXEPfkiKciAGwpgZp1ZJo7+vnTc/eNJT2fpJJQw4Lfp4eQ+1m7TBshVToiIGaDEWaDyauXYFO4eQPpXoLT/AzhomssuRLWCE7u04C7eq+AathBxp05X8tILwxD2tPjpiCEb3kTltuPiEYqkRQcnKzxiMFUePc/EpShgzD8YvoLjj8vTxL3j/0uiqvRmt+v8jc4rYk3m+xtNdwKk2poQQSXFO+1krRv7dpvqbzVIcI8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cseW6TYr8yjAHcNDcsyHCTCQjfA4v5VRStqp+uI1syQ=;
 b=gv9Pa1YoCeBBaY8oj14UU4OrEgsO+ZMVL08q2XRUZk+PdGLbypN13Iw+MHy9XkuZZ1VUSD34xVARgyS+40LP7C+V7w3iSNi+ShV0IzYlhLy4NgCrFG771gbAs/olneRah2aUoYstYdsfBeY+MCGEo/rm89l/UzJNuaa3CD/R7C7MQL2pKi+T85IzGNUhU/gPZ3KzcBh7a05n9q4RUr2ywWCypKCQFsr/Zb3r2socRvLrYzFZBmUrjuJOwIhDQ8YAhuavmWsSr3JPZv7eNVlwt5cm43yqKYp7Rnw0mkN/sPhqQl65CE7vEGlgg6n8vKeIrvgEMOt7mcjkNUhbOghQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseW6TYr8yjAHcNDcsyHCTCQjfA4v5VRStqp+uI1syQ=;
 b=l94JrAnb94UoKIETkKO27JZKSV7hwCTs5OeAa84pqXTq0lSk3EtqvcIBHaGux7n3s9Ca0GqAv5BTMTrOxPINPB/TJP8bE3ubCmGOJDofMp0I9a1cT1QSVYGn08/2td+Dq7rfaNbF98Ly2PEv8pV5rU32/y66rprF7pCrQtDbA5reBaoMu37I5qBN6tXGLiTssgv1p+Sd/Nh0NaiDVMawBQnrjxICfl1Q40p/31vAa5HVdiweuHGXVWwti16ejrVz+zQJJM+hq5yozwFzTcCHmifeWM8e9k9W9r/nwHhUgRa+wg3jehskir97G6sCN7Arc5IBD/70hltvHW3zszfdCQ==
Received: from MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 12:29:37 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::7) by MW4PR04CA0367.outlook.office365.com
 (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 12:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 12:29:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 05:29:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 05:29:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 18 Aug
 2023 05:29:15 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4 2/2] gpio: mlxbf3: Support add_pin_ranges()
Date:   Fri, 18 Aug 2023 08:29:09 -0400
Message-ID: <20230818122909.7122-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818122909.7122-1-asmaa@nvidia.com>
References: <20230818122909.7122-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e4324e-668b-4cff-d9ff-08db9fe6c95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgVu/ypDgXQ5uh5iWaW4Y3qcqBTCW2l0g0Nw42Zie1sCflRkgoEFwBCwV8oW8xLDqXQdH3ZgNc9CxHl+xbVk1RJVyDaXWITsD4szftxxaDlXGTONkJ31EW+EFlbe8F6/pCB0GDSr7ATJMzyOypgDHVBFxJrfk0DqZxKiy+uK62dB6hHnWd17Crz7ZDEshyZ2g0ytLKtQtP82PxRvxteGM/D05YU08rzVlaxTPvDGrQI8LaL/LxyDzVnYPNr/HuACI/1CkXCcmKem63GcSHLaWO3OhyvOlwj9kYT9Mp5974KmsfunjoOswVMB4e/1qEvAYcyrA/B2iQWKAuts0Q/ulg+d4iXQ6AUkMRd1bjbJtAZv1bf79rsIf8xXEJ3AO2OUdxM1MQXCLdAt2pQ9FqhYc6GH0GxPiH+v4z9Vp0aQqstM7rKfUK5qG2ByIRsFxxtun7zGB9HL49PakLkdXK52t3Kv7Gc3LhWYnQNEBMFxxJpXW7SxC/bqoQbNUp444Xh9QViw70OOcI2ClzDzjT6kCT+/6uNLuTyumSma8ZbFvAtLQvL4zKVwCCtdv7aBrnZaokxKIebEmpqlbNUoZGzdcfE+xtX+LRRmYZJszoQggV+08NBs/gKdGjVTC90rnUPs4p6mnswhE4L5nFyOslkWbGWz3+H4h7IA+P76VVzyIavRi7jT/sfjsSJHwX/oRzGPC+ol3nD+lIzsBDiieKlYl6YZcm3XlKEH6uklkeI5WzKkzmcJ7e4nfdssLuzFMZd9jmqgoqY9H2MtdkeNzuvTrQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(356005)(40460700003)(316002)(2616005)(36860700001)(107886003)(426003)(1076003)(336012)(6666004)(26005)(7696005)(47076005)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(70586007)(110136005)(70206006)(82740400003)(36756003)(40480700001)(86362001)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 12:29:37.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e4324e-668b-4cff-d9ff-08db9fe6c95b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
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

