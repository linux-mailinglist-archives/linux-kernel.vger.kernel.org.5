Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275517810BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378746AbjHRQom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378782AbjHRQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:44:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3444AD;
        Fri, 18 Aug 2023 09:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdhFpdZxU+mTsYYKg6HZTWcsUqPOlDulTp2AOt/CJx3so8TGiqcFZSGvBrUF6g4XmUmJejnpolokQCbrJFPHYdNFC4oNyAkh9BhwL3We6NCFSRBS7h6CwSHzArHoF11VaFnoq9zUKa+Y6ZmlY/5kHvHpDDS6bAB/LlFndPFx4N5SPiF2ShxrVSdITnrp0Dcknr7DetegehLpHhLqMeCKMvZXbEdJzi8JJ6c/MQ/aDHKejCwdtCFfnm/leN5lb8p2SgH63mVIisniR8WLMVWfFJ60Ja3/d0zVy7/OG9k7yS5p2n8x777eQEWnYxN0cWYfZhhZj4DofrTrWUE+nez+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WqQJFsLQUBYIRPZCKhAYWp2wHDjWtViNgDtgzXD+J4=;
 b=Y1pMcF9+NEXhgbL9ehrXCxP2rWhWfWw4OnIQ7zQlesLrLgmfDvpfW8D1HZ1kJVpyd71IdCf0zw45tyTIMx4BcrERbC8tomk8a5T9eZZpe5j9WfBJk+cQB4V8hLyb1yWbR75qFasOR+0I8Yy5LMCi9yG6qTKwGpgPtv59RD6tI1xrX58Xe10y1IN4+cKGWYn50gtiFWFwBAx3BVuEhb/ENLxiltT+6hGfOs+qfyqZtdzu4LOeALzaZBK+X/ANVuiQjewXOzvbWpIh/HaMpmHdyu5tQ2f6PTpKw+SFMqrQrQ19VhwvvUrxhMsQuQBNYSmLTAo8KH9ZUg5Id/TFDf+m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WqQJFsLQUBYIRPZCKhAYWp2wHDjWtViNgDtgzXD+J4=;
 b=Z+9P+ZT1xzmNh8qr3Os9m45QJdeOwY1Cw0JTKaDHcr7I1ZnnX6yszJtGlkL8m3SBr8hsWo6UK8FemAxdc1hMwW2xV7uRZ71kXWPm9/ZpfePfFlnHMQJXfyfr1FtdgWFwjo4UR8gTs+8zezYCwXBJdNDf6/ZI7PX4CxXr1hZK6uG1WDhCSHo2olbCeXBYEvzRHIGm6mKX3e9O7+M9mInGkratczkN9PGm6De9WuasQe5GPPAEDjyqt5oNZUjjFxPOpVjmTpALlMyfY9T6/aWiFg6RivhksnHIhkejDzXnuFvX2SE42sGkbeWjz61biEkbFIMVbkSjChalpFKfBfLDgA==
Received: from CY5PR19CA0085.namprd19.prod.outlook.com (2603:10b6:930:83::9)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:43:28 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::ff) by CY5PR19CA0085.outlook.office365.com
 (2603:10b6:930:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 16:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 16:43:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 09:43:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 09:43:19 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 09:43:18 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 1/2] pinctrl: mlxbf3: Remove gpio_disable_free()
Date:   Fri, 18 Aug 2023 12:43:13 -0400
Message-ID: <20230818164314.8505-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818164314.8505-1-asmaa@nvidia.com>
References: <20230818164314.8505-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b763b2-2ff3-4738-28fb-08dba00a3fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kV2aYZS4kKiMZcOe/z9SnZlQTAl797WyMjloLHg3MDGeiSGbOACybhFFTBTf1Wc4Q3ycxFIBWLWT2aaGGk/s6ctrV7z4bexdvHuivZhPkPsWH6vHXdy1JXp362U8G+ESMTWjUVQ4AC+1pD/KsXST5BkVzFeybEO3Lt9nJWcvwLUenMkwSLce725Ey8pbOYF+KHheOctGengnLYr/F1nc+RzyB0RppSevjj/RMWSPJzGyFkY2ZzwGLXWhbOIXJ3Di6cuYK+Ab0em66TjXGPVXXyGXNgURRd7wHCcIzsUxhCePUYxLioyc1TRGFxEMQQqoxBnmX2E5SCpOzvsJDg50Mwwb5gZWbG0rAkw5mO4X98I6aU6ZjGA6YhsbLOOk3DSn6kPFouwTkhWAtKuoqwHG2nFcPNBOJ1frHt7fky2vmerL/ppLPvBJ/DNlSSEZk7WmU2dJ4s+RzYkUEU+cQ+Cm3D+pcRhCTmIFQQ5mWiL6XKelimOUoKAm7mK3jYxVMm3ByMGX/l9wKIlc8wJwXjJaMfkXCfJmJ+7Kjx60qkj+RG63OTthK5oKuk9IOSfD1VK7nzlBgXlV5iecvGnGJH1x9cFqJWl5nrUt3e6F4Irij0S7kyDhAKmHynhqYhTrZgXIW7QTprYUGPIoZ9jiR1p5wPHbs56WgZU45seO6fuUtD9n96mgp0fpiBvRxanTryPdOr44pZfJZxTfzFJaxBE2bDH0s4RH8aVkuaPpfUW9eq7MgAFGesDSv1G7PHxoHav/nKVz0nGfgYOw+KiHz/wH2g==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(86362001)(426003)(336012)(107886003)(26005)(40480700001)(1076003)(83380400001)(36860700001)(47076005)(36756003)(7636003)(82740400003)(356005)(2616005)(2906002)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(8676002)(4326008)(8936002)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:43:28.3695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b763b2-2ff3-4738-28fb-08dba00a3fdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for gpio_disable_free() because it is called when the libgpiod
command "gpioset" is invoked. This gives the GPIO control back to hardware which
cancels out the effort to set the GPIO value.

Reminder of the code flow to change a GPIO value from software:
1) All GPIOs are controlled by hardware by default
2) To change the GPIO value, enable software control via a mux.
3) Once software has control over the GPIO pin, the gpio-mlxbf3 driver
   will be able to change the direction and value of the GPIO.

When the user runs "gpioset gpiochip0 0=0" for example, the gpio
pin value should change from 1 to 0. In this case, mlxbf3_gpio_request_enable()
is called via gpiochip_generic_request(). The latter switches GPIO control from
hardware to software. Then the GPIO value is changed from 1 to 0. However,
gpio_disable_free() is also called which changes control back to hardware
which changes the GPIO value back to 1.

Fixes: d11f932808d ("pinctrl: mlxbf3: Add pinctrl driver support")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v4->v5:
- No changes
v3->v4:
- No changes
v2->v3:
- No changes
v1->v2:
- No changes 

 drivers/pinctrl/pinctrl-mlxbf3.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
index d9944e6a0af9..0e852a0d5ec2 100644
--- a/drivers/pinctrl/pinctrl-mlxbf3.c
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -223,26 +223,12 @@ static int mlxbf3_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static void mlxbf3_gpio_disable_free(struct pinctrl_dev *pctldev,
-				    struct pinctrl_gpio_range *range,
-				    unsigned int offset)
-{
-	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
-
-	/* disable GPIO functionality by giving control back to hardware */
-	if (offset < MLXBF3_NGPIOS_GPIO0)
-		writel(BIT(offset), priv->fw_ctrl_clr0);
-	else
-		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
-}
-
 static const struct pinmux_ops mlxbf3_pmx_ops = {
 	.get_functions_count = mlxbf3_pmx_get_funcs_count,
 	.get_function_name = mlxbf3_pmx_get_func_name,
 	.get_function_groups = mlxbf3_pmx_get_groups,
 	.set_mux = mlxbf3_pmx_set,
 	.gpio_request_enable = mlxbf3_gpio_request_enable,
-	.gpio_disable_free = mlxbf3_gpio_disable_free,
 };
 
 static struct pinctrl_desc mlxbf3_pin_desc = {
-- 
2.30.1

