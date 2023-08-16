Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636777E323
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbjHPN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbjHPN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:59:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F22717;
        Wed, 16 Aug 2023 06:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CisoKJcQwQih3L+GN0iCB0zqnMgsgRzvGKPVQu/SV8+qQgows9aXuYm2QjN3GTJgkBTUpQC7D/5w5z/OS6Cn0PPUuSk7vZGspNdjBQlQYT5Bvz0SNXWwTSsk4lhNi5V2IDhCDg37YmDVXFJ5BAk4nCE/SDgyTfBjFrslMXmrGRMQxQmU12KGurP8znoKpuzmnhVJVJ5eoyWMk6jgqr1bNrloFUFn6BCYoQJdA9Z0uGsBJtkhDk2uR4WbZWOz6ibKqh1FedlX+PmgYoFmCqUcMfRrKxX7hFfKShxXsH+JBC6oeMzzedqw0ToZQTXNOswR9TGPGbV2XoPtmPhH3UdeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnPncU7GpsKVHBUZ21L7VOD2DTea5LuRVaBzezbTyIY=;
 b=GnH6kGsc7a7VBVt2/I1087+Ol+NN4o3gM1e7pLK13uTASJ88suZZb/6xXKhGsmViqoiTVKXONjSE2X7rbN2hFhnhuAQMdMuTk29ffCC78DE9hlichKhnUyL5fzul+tLS7eUrjclTKIH+j1NaDB0NjjepB8J/+EBhXUIoZq/r41bi2iHGlmjx84Gphuv2Qd3Y/KuUF7K3Jkh0W/ZJwyJl2FLUyV0aHkC0AgDrk4nPLtPgtLYYvoG8neGh7Ef7IVGYQq2aJ4GdQL2BlmeczHiTSq8o41acsRZU+2QffG8UIBmRT13KiZXNIGHzAS+gxhmFoiH/xqkzBypSWPQAqAv/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnPncU7GpsKVHBUZ21L7VOD2DTea5LuRVaBzezbTyIY=;
 b=Tzj0pQBBsXdynxIUG9ESbOHIIiF7GsrP87xKWgjQuF46vqQB38VL9cFlRr24HFOayaL3vB9qwcsuzN2SG7qGmf8XY7DrZ9ol/o+4c7srmuOJFMgRZgal4bxulszQRsm24UDtEvR4ReslfV+TQdmvEzab6xnE1PhsMy8amf/HNU4rTNwyw+nSvV9EUvzGnQ4saiC1QRpvwlSIVQ/Y0d47e716/r+FhrdQPmdauuhcbz80/EsC/opb77VceLUw9wHKnxmFFnnOdZmXl59djbpjNmdP/0mAU9N8d7YK8aYBGVCWQ+wEaNZCK69/utEiZeWIOhG0ZeRbGiGz21pfKbN9Nw==
Received: from SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::26)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 13:58:57 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::c3) by SA1P222CA0178.outlook.office365.com
 (2603:10b6:806:3c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 13:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 13:58:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 06:58:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 06:58:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 06:58:45 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 2/2] gpio: mlxbf3: Support add_pin_ranges()
Date:   Wed, 16 Aug 2023 09:58:39 -0400
Message-ID: <20230816135839.24011-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230816135839.24011-1-asmaa@nvidia.com>
References: <20230816135839.24011-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 5146b2b5-ff3d-4486-2f4f-08db9e60ef5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtVlpA9iYGwFGXajdiqWSj5zCUll69DmZOnayTitFKAiP2cxpBLVA7/tVt2ugLbYE3+rFOOO/+zJnGrO23iLlm6h4QZxJMCBShWYVQB1mp5wsOYs7Sf8CGV5jT3K2/n4qDl+a2+dcynYJMm/sLFz5/mqEL9Zojk4vHMvoHAbBTqzrtDhB4sr/UR/YFNx/EcxobU3QaK4JLJvaEdcXyXB9k/gzpNT3NM3EVJ3YryfhycoE14PCZJjUs3MMNqRBfgJfBNtFqVgGZ8ilrpedCQ89IbJCI8eNwI65eS9lcMHms/Txkotf28Uo/KIlfzi9RImglllmbRkHg733E84vh73Arn8Vgoz6TTtmshaRqzjaqLrU90CsvTcnnmzlWNPQeligbZBVQscuw/9+tdYmHHMcehu74T0JMeLhvaii47Jf2Ihc/jsrfSdg7lGQ+aMPKNLAb5QfDGairddddGmckwFkcA8a5kll9F2ax6oEeMs8kgThN+1+weX/flc7ZIw94O4FILNAL8XXe33xXd3l5/9IQUMtcS6BGcz6qrzw9OkhgNqWUx2ofHd+SGtOlUTvaP77GbGlZ8VnxW4QH3jdsPBfZ0+Xf6qAYZ02FOcWlSryMZtaMmmEr9QYBhFXkXigdxtJMMQXzAmFgBDXlJyZyEZNgrmQWu8b26YQ/uc/X/hAt5OzbIRikRy5QviCSh0+sqeP/l53GQz258OXAM/ZnGlBl1HCSgLmrSfvNc9o5AhOpDT/jx1gvgoqU5NiSGAzKFH
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(356005)(82740400003)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(107886003)(7696005)(36756003)(6666004)(1076003)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:58:57.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5146b2b5-ff3d-4486-2f4f-08db9e60ef5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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
 drivers/gpio/gpio-mlxbf3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index e30cee108986..3828f5282b17 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -158,6 +158,24 @@ static const struct irq_chip gpio_mlxbf3_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
+static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
+{
+	int ret;
+	int id = 0;
+
+	id = !!(chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK);
+
+	ret = gpiochip_add_pin_range(chip,
+			"MLNXBF34:00",
+			chip->base,
+			id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
+			chip->ngpio);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mlxbf3_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -197,6 +215,7 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
 	gc->owner = THIS_MODULE;
+	gc->add_pin_ranges = mlxbf3_gpio_add_pin_ranges;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0) {
@@ -243,6 +262,7 @@ static struct platform_driver mlxbf3_gpio_driver = {
 };
 module_platform_driver(mlxbf3_gpio_driver);
 
+MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
 MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
 MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

