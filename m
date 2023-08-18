Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD2780320
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356934AbjHRBX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356925AbjHRBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:23:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196533AA7;
        Thu, 17 Aug 2023 18:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/VFNtvj084tfXodUJ/y9998g0btRFTPkn06fqoxOeIYTOM/PSE44BXFBfroios0ugiQm29r5ovoV7DRlXQRmKTx/5nQmp+3yizhe3yHeagdQU1eC18t20QC9y6vm9MwdBZdO0pTDvDAUgclh3xsdq/9bLbbqBLNEnb9qNylictSEQHg3c1EGo/x3AtgreXQU9cf+4Qf/b366AmONNsuPGSu9Dgn1JDudQ5COA2za5RTlQDT1KnkWgSYl5yYIHX51me/9zRNFt6Sxs+Ocv8NO8UAvIwamfc/30Fz359JAGTOQpTGarmGiDEfa0JC0f+bsCrRK63UtdyoIGx5+cyLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np6GiFX81T/RHJV6jQbXfSMVQJL57SGa+zW7fLsi7YU=;
 b=MBIhEWNf2RolBowGK4CP23Kwdu2lyj9lP6ABmXEmddN+JPje/5GRQSb4XwmzMDRWh1usnn/aZ62JpuL2DqKOB9hbdFxfPDFUJjpX7QwGXQ2zTzDy+Vci/+QYDI5eMhARTdtj3cii1UnWsFMvphZkA0K/6bxQkyAMQlXwOpbdHafv2PGgJHlRtQ6IWpVcnDT1o0IrXZDal7jvtSmIzIvIf24k6c78b+1x/lYV9SqiAYiijkFQWDuzdnpUC5ZjVgihGkbg7hATeAYLH9yuKeGSYStum06AccYYbqs3Xs7WrEZiRYfIU0SJiTufE7h34LKqUjhagpz9nQ3dfMRFt/GI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np6GiFX81T/RHJV6jQbXfSMVQJL57SGa+zW7fLsi7YU=;
 b=qvLYZRd0MrOiw8BQdiTEwBgflQdgM9jV+5JiJqepk5NJJ1ux5LxCJkbw4liSTQ4wb3BfO2l/vbGoyiJjLrP/HmFaCarqRyBGINeCvFzoXOQ7AxdmtDtgyond5LyZNajVXeS2d+EFh62fVMDKkq1F9t2wkb0k3zfbK8MfI1Owj7E07K6qXRoGreO/dciul5AH7bYeju0EHRuQFai0N9as+4CZyUin3mrmgT0emEhdndTbIf4bjE6KT5NdiTr8ZeTiW3k+HDjx24roRptjdA+Uz7F1TZSd6pDmSvQMQzfWlWezdgVV/9b9oVIp07Pd1dx0UjbfYLYPXr2lgrqszd6gQw==
Received: from PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:21:37 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::7) by PH0PR07CA0012.outlook.office365.com
 (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 01:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 01:21:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 18:21:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 18:21:19 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 17 Aug
 2023 18:21:19 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 2/2] gpio: mlxbf3: Support add_pin_ranges()
Date:   Thu, 17 Aug 2023 21:21:11 -0400
Message-ID: <20230818012111.22947-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818012111.22947-1-asmaa@nvidia.com>
References: <20230818012111.22947-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM4PR12MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf8cf55-3397-4e49-5d08-08db9f897794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2S+0r3Agirg1hZ8TowpJ8VZTikXfGkPi0B0wXUZ3AvAIwaOfLMhdkxch7XGTKcoUlEIx4EOj4Quuf2sv1+vIp6iZMQB7IrH97XbdWgqiT8Wyd3+q01DsnDdeK0r4D1e+2OkEGL/geDelklrX2GUD17xoFM1Vu2Wuq0tyRm4jETAryDWb5nzrhR/PimGzahHtH7ongICZplvZtyL+XgRT2Ul5qogLxQWxwLUbrbQaAl3acOdYUDIjVAyKMVxgFPharQxoGPc6VbgGusWs2SYIcQ/BDS2HvFmaiZPf1Sru/5UsYR+irND471605pyTtZO9SvTp11PrIp/D8pSZt+u8uIBPF8hxKmmMMC0Zi24THrOBzKiywqAk0t11KKg9E3PY7Po2jLioo0aSehPU6qgX+nzYEYXUDmjR1J2HEtYkKEz7Rxwa79HOcF4cFl3Ta6vXZbB6gDCya+gMrlONdtECnqDvuuHN4wtdnF4wSJvXsNI6e6MFvt5ooUSnXhFcRJ2hWYEy+g7V48Vyh8pNAmsVBouPfU5pBxyOi/P1z46DvUeWusCN2tmIJrFOnW7G9F9LtTlhuIChz0enHMJZt82/o5Depb0iNUbmHNjxFQNXJTjVV/IV+YITPm/JWeN/8E+4V3RZpUfTg+DMTSQM2iVGZPTDD5p4OmqT3Pm3s1WLgwD3wRBXYvRD8tCjxF4PF49fVWDtXcnH3pxT59JgrU0/ErV/IYBdHD6VSjrMAWQ/5cPq7PEFS68PJLF9N11A7vw35IiP6N361NPVCMbxk0xUdg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(478600001)(5660300002)(107886003)(2616005)(110136005)(70206006)(70586007)(26005)(6666004)(7696005)(316002)(1076003)(4326008)(8676002)(41300700001)(8936002)(40460700003)(47076005)(336012)(36860700001)(2906002)(426003)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:21:36.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8cf55-3397-4e49-5d08-08db9f897794
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
v2->v3:
- Replace boolean logic by clear switch statement logic in
  mlxbf3_gpio_add_pin_ranges()
v1->v2:
- Cleanup mlxbf3_gpio_add_pin_ranges()

 drivers/gpio/gpio-mlxbf3.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index e30cee108986..436b0bb5ebb1 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -19,6 +19,8 @@
  * gpio[1]: HOST_GPIO32->HOST_GPIO55
  */
 #define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
+#define MLXBF3_GPIO_MAX_PINS_BLOCK0    MLXBF3_GPIO_MAX_PINS_PER_BLOCK
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

