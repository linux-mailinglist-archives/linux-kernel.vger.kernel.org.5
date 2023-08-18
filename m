Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6889D780BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376949AbjHRM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376913AbjHRM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:29:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31497103;
        Fri, 18 Aug 2023 05:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn7aHubHqxOZx56qnfQH+FLv+1wU9KrsQcNHODndJB6kOZ0b7TB5nN25qJfzIOqJUt4dIs2sKaxIPePmRbVLeO/0okeE8YkjgxH61+w3ZXlGMb4XpY15fra2CEs1Q1IY9WsjeUvCZHH0ckisg4uoJgCSIuXw7IRNFS4dUgyoIjRuIX9qFStmJod+jneTHoUmT7crvJDADHlMyBPaj9tLJDclyfvvtrxMhCoCsZFgxWIknmZecLiP4fbORU5tqg2J/Pbwk8rfA7K93LS994t0czmMg6+hBLa8f8Owz33lpTFfkeXva5Cuy+FZ0whAEv241Jou4Oico/HDa4N6zHLY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjBwYiph4etV2B9Vdc5eX4K4JXtHxtTh3G6AZBB0VLI=;
 b=Ny6w/tHjGF20I1ydAFPOGrUVBztnKuDA74PrIvdhfn2V7Sgc+bMxd2i83dlIk3IgWp+UhnGf7HFwLczhnn7js3mm3h1yZadfVc8Q2Diu4dQrmKz9ltHBWVlBab/NXbZ3jDx92vmCpBRMbNnBzQe++G1b3gh4tyJHuW3Xm3D93v141yZMdtj+PFFcecyBgT+w9rzHMHJfq2XemSRiyQM+7tYATXRnCuMAvx5g1OMfDjUx7OtFnzpHb+N+6W0CDAAcVCA/JovNzfq9EG1HQLcV85hCcBfhnvkp0vR4R8gHFS72OEUkJHqZjGlemYv42m6TXD4L4j0D1puo+KyX1W/b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjBwYiph4etV2B9Vdc5eX4K4JXtHxtTh3G6AZBB0VLI=;
 b=bs6R+d1VWfdRwhylkpeQ+g5wiglgxfOfbaxT7Mk4C3YMwGkS24b+JUr40EF9iJRBc1rs/lh4CT+WcTW6GMng9xHX6DgHq9aGcnq/VAKv46igRZCUid2WJUxbT0oN4f/XtuIUULkdkLXKzdj2tgnwQ09qCh4p6to253wBdvtkiyPYPDYWjrWXCH/9h1LPh0EE3Y+LdGShnJi7TyqAIioAO/SMwxobZ4q+8NeATMWThLGjxf1ZZVssRTmcxBaCVOWZHrEce26JGWOr7XjEx1reILqx0qD4rQLLerrGiAKCKucy8rw6Ozb2Q6np/adayXPhMJaPjHn90uI/pZPEM3ibOg==
Received: from CY5PR19CA0025.namprd19.prod.outlook.com (2603:10b6:930:15::28)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 12:29:26 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::ed) by CY5PR19CA0025.outlook.office365.com
 (2603:10b6:930:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 12:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 12:29:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 05:29:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 05:29:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 18 Aug
 2023 05:29:13 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4 1/2] pinctrl: mlxbf3: Remove gpio_disable_free()
Date:   Fri, 18 Aug 2023 08:29:08 -0400
Message-ID: <20230818122909.7122-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818122909.7122-1-asmaa@nvidia.com>
References: <20230818122909.7122-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3cf9b6-3b5d-4702-74b3-08db9fe6c2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnxLoPVn7KdODGLQcOmV9kWiISzn5//kaXn8RiDUY4iRmHzsiHhUM7Lntj8wI8N/hRpIyopbbEHphuTTDL9IXJw0oJH5Ex8k8DuJE8dANuaRs+R7BbBL80JHZuQ0Bwn7rKZXDNGt2Hn7ZbqQ4ZgcBVkrEwRlwcN2X5zv6n1SlZbp/I4GfxknfDz6qDn6keD2s6xQQH6UtEbd8dfbkkHNeVgXXsqX4IlNRq3uyelstCgMnGEYoPeXxl8kASHJKy0usme2VzyG+xfBTvaKWBAulx7VLI8kwUp8CyCYywAgQfvrGxG0h1H40na+h58K6hLxwNg/xDYc8lqWz9huGavBSJrxRoaAs+DxiTZzwDiS1Bqg1mxqsnUD3hYCvrkVjPCRuEPX/14OPT0Mq5wpjJhH+5shKB86f0TyAf61nqz481xzzRmAoGVilN8x5J3RNqsELMxOBcgXV5ZoxefyWuI8Z/zc4F2nE/D6bKjgQj779dawvvyPMZBjXC1ZeDVtR83g6zwsAOKstFE+IHt6Ys8qM7hxPw5kteVHGnJzTTOBMMtey2078mmxW9/g40dOQqb0XII6Nccb3QOdQ/AkymXljvK7OvcEZk0KAaComxAsb/8jxuAu5ktvqp4z4a2cs1Keur1Rx+g2/uYSVu8oILVAL8viC0xVEgyEw2n/XK8Rg1dGINnktODJcWMW+oDIrwUb/lWMQbb8cj5hXKkSEnTjNsfSXFcdjMT0D9GRPOyLVpwa/639poxAoG9w1zR7d/CODvctwAAFZmuwnuSBPAXfJA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(86362001)(40460700003)(83380400001)(40480700001)(4326008)(8676002)(5660300002)(8936002)(2906002)(36860700001)(41300700001)(26005)(1076003)(6666004)(7696005)(2616005)(107886003)(336012)(47076005)(426003)(478600001)(356005)(82740400003)(316002)(70586007)(70206006)(110136005)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 12:29:26.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3cf9b6-3b5d-4702-74b3-08db9fe6c2d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

