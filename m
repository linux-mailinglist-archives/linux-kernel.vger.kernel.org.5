Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1B77E320
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbjHPN7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245747AbjHPN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:58:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB82706;
        Wed, 16 Aug 2023 06:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzEltcxJWiz1PCWktKd1YY/uYG/GkIjyMRnwtMsjNPDb5eYEBiKI7v3LNCi/PwLDVtj3hCciPQoNv8sf+HQzbbKk9qufbMZJzyYpO8jc/N4e/RRNXgfAX/164Cdp0jTk3BQAOwO2zPQtcy2QE52lSGnzzH27vRxScDSSan8uCPhpClJXjcTpUoUf3nlYbghYAs0T2eqpfMXnpSyaOckhEJLL8FxjVEqw8LQHZhokB7P7f0yT7up/fueeS0cJa/Ho5Tbm6DsxPuiSgGFm5c3IMaQUm/6M03RoeEydferhbEKlLuQQBpNFCN7HhySJU8qFfE5vs5sOabXvEngsIMklSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azWKRJweerTVUH5GyahUtkzx+CcM76TsKBrPYtpBQNQ=;
 b=cXNBZ66RvWGEvfuvR/BLdV2MHz+/OYrm+WNjBODv06gTwdCX0iIlC1MXnGyFOH/SBCprrt3NSIO54cNWZiTE6JGWPeIne2/BqSQwoQCZYidsLNXEGvgd4iuHG7PHJAiEcE5Jm10aSBgsu+2zAAVlnfP+2PKyZJOha4q4aVFXsPHM4T1yYAI4PJz14pAU1nTZzCNP35IDXULR7i1R+rs3dt2d411mkzRNG+iVR+NMnRVl795utfWenQf8Xy0avRDpLSNTNt0dEOBrMfv4CZvEoc0Zhoz6jfGgfjTkriTDdKn4eDjlzE6+kVx3zTUYRb+8/BJsB6648D5Wrc283POrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azWKRJweerTVUH5GyahUtkzx+CcM76TsKBrPYtpBQNQ=;
 b=pvEnhVXn2e1/INcVGOHSi38DZEMwUNNbfpX373YtNxnByta1j8dVdVPxIRgrwhU5Fi+RRXX1Ppq4TwHe4Z/zhUHOw8P0+JRDCVRJQohsKHaOgxBvEz6Ptm2R+/7bI44EB2UPlgnIVjM9tJ5IomypHjqbuJIYln7TvRDZPEDTLUojdYIXSRRHxKYemm2x+0xj/WMIBP1EZKOIeVRBsNLXIKUSssVC7ns/hOXAhHl/e6vaApl8ITX6qiWdJT7Q1akMbkoOO3zqHBMd8QfjtsVZErDI/SGgxwHvpXNst92k9nsH8Ia7KZMCFqryND5DEAauxM6inuAis5Rs2S4euc4iBw==
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:58:56 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::c2) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 13:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 13:58:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 06:58:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 06:58:44 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 06:58:43 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/2] pinctrl: mlxbf3: Remove gpio_disable_free()
Date:   Wed, 16 Aug 2023 09:58:38 -0400
Message-ID: <20230816135839.24011-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230816135839.24011-1-asmaa@nvidia.com>
References: <20230816135839.24011-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: ed603f14-fbe2-4f51-3dac-08db9e60eed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdOF9YIRKhdmTgjmMHf0wR2wuMdfq1jmzQCuGCS55bp/oPMNBariHVgUW9SvpcSbqQN6LW9iff5hYtQMYfc3G2jAAd010CUsyxqUe8wBAUb68GPYbDZqms7XruEwc/AV3ddZBpFr1PogD+101teLgv4wiIUPrB5EYdpa38DkgUbvk64ChDgH9a2f6pRrGQnrV0l2ABRTccm4cv0kwuBA3epFzvpKOzW0fiObRGam3twhz8GLKG5Yd0dzlmOGHUtIlXsMqqS4Oa4Hw7slMqYKDh52rvKqyVCXnzislacUYrNgPZ1tjQc7aamfx4YqkN+F7y5pf588ka4YzfwOnuZHMpjTs93DV668ov/iNzYH6fpG2DPC9LkgWY5zMWBxg5c3HJg3y3unTVQ9ce1fdhbieJy3Wnoz64Fz45NGsyiRiXedHlViscoBWshPwQq9CDunAOaMOXei+rPCfXMOv3i3Cr/RudAomVW1kUKPRJD06DMoa/P2q3NwVq4ZLYfa0HGliTXWnQDDqOkRqZypPksik7TxsPbuLYJCS1RVfDjyNpT7X1/luVppzGrD4cBr7XryyLgfP87Lf0hFt7KbpVMTyiV9u6pfVIvazkP/4G84jlA1nU4s4RifcTYFwF655VsJZYDwfZhG995GdFJTgeoUcBKPUK+DQQwf2Ffh1oTfp0DWvXA2D3LSMpshih0mPlJaG97DznSXrNGDJh23hr6Lip2srebtRhjN4QpDXtoY5NcnlwmIDlJAqRHhZeWdUzOnd+yBxQjBpqDy5jI9fyLOvw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(356005)(82740400003)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(107886003)(7696005)(36756003)(6666004)(1076003)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:58:56.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed603f14-fbe2-4f51-3dac-08db9e60eed4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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
command "gpiset" is invoked. This gives the GPIO control back to hardware which
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

