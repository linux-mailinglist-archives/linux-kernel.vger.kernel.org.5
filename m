Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168277E580
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjHPPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344306AbjHPPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:45:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABE26A8;
        Wed, 16 Aug 2023 08:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCPqro1oIFTSsma4Pg8Ob1bdDCfpA9xk5JUwc6zYWGTogTytj8WsLtgDDny3+U+uzkvhiZQjr2VSM/FR4/8XTe0hcdnK7PA+Xp7Ns48D6KAalz4Gsc2SEcSn1o71ZlHo8e/Olb7A34VgcnF9xBN6uhOMLL03ccSZf+81oyLsi3EW+TzMyAm3sj6fTbjtF5+8BEnjZBd3bvruaQ+OLElcCsE0NHOsWRIyaYIGsfrIPdcJ2+9otPsvr7iF9UQfMeOrsqmaibm80vTSNFGMHZqEG3j4ctC3dN1IqcrpkoSYnt0dzH0/HksmtLTtSHQ7EDdUbmETkUadlO1BdpheGGGyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUFPab6ouFtH31Rd1bTU4F3NzcN2RXNlTtoxCd874jE=;
 b=ip370owApbkU4PavwEjxjdHrTruUOSecesnd0HWCEAHCsBwWS6n5kwIeRf0Nsq33+Nr6X5olzhsTo03oyu71PBQ4QZOIIGqPZdr8JEs7MBuDWc2Jk3FVNWjxWdmtB6UpB+ps2dDTfFQFmCNXe+Ivtdv3JolquFhewJdXQt2OHuT/skdZTjTvAmIhenslpEfUuqc6RnIPyp+Mc/ZLJguzoBMwiSIXGZ90xsbR1i4VlPT++XoIGQsrDOzSIOK7bWIN0mMOsg0jGwpbebyhuJfLAXfCmfRDwSeJqYI8Rj71w0G+5v2+3zX3nM+WqTU8wJnvpJgVyS+5QZbQt+ufKVITDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUFPab6ouFtH31Rd1bTU4F3NzcN2RXNlTtoxCd874jE=;
 b=mszHOdVwH3dx1TB+5r3Re9vVicTbRvAAX4HmimDEURiLAFDa3yPPwTL8MwRbZ0R+Vl6yRr9PPFANbzxnpFcLBLAuGkFstwD4maDG2DxdrmuRolEjvIKV2GWZqhGySZU0S15YT8g3fmC/Z8BMcaMuGQdky2s3Gy7MbJrCpkyJ/5HsPP2jIy5UY32R4qCQNNDam4XqWR+klRHzuJluO+GvPPvQ/UWzjVwe6VV+voUNujVLtdhNYlPLT8xeCDrTTAkjjimEiaVKDvKNjzBwbznxl4ss32B+oPPodBUAmjNJRzrZifrfwDIGqytt6kmVWKCGmKW7060Munv/US1jVxE1Aw==
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 15:44:59 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::e2) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 15:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 15:44:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 08:44:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 08:44:47 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 16 Aug
 2023 08:44:46 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 1/2] pinctrl: mlxbf3: Remove gpio_disable_free()
Date:   Wed, 16 Aug 2023 11:44:41 -0400
Message-ID: <20230816154442.8417-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230816154442.8417-1-asmaa@nvidia.com>
References: <20230816154442.8417-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: a81ba836-c75e-44d3-273b-08db9e6fbf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jEw7OhA3FeQey61gVbXy55zzmj3ecGL6mlbTslvB/F0y+gO300Bcl/j1ZqIWstrjF1gtnMyWrKeEm46LhgMRDS2N+8P3CbFuE6+B24jpZIcu7Ohf9byMcG+rKzPHvPauTeBzkXLNG0SpP8E2ed7y35BPbOipBMtcVnumewq1wt4ErVyy2TIbNYli6C6A2xX1mRtx5QXGQ9aOzK2P3nX7TnB9niBE8RgQaRzCKt0XHRvOU6syp7Rqqqikz0mzkN5stlNVG1INlHSconSgcgsTWu7peomwDiKNLJBtXhvy2rLP8LO9MTxFQMsiJ/FXZ/rbCkLl0DLb/B5z1vBLmCv7N4RcjKw4zAfbPjtA12nN1VYLHi42qkmPzJ21ebO/cn/XWU1y7Az1R68kflGfLjcobo7vimnMpw4sBrZbl7BBWR9AmgvfMXjQx+ZcnfKf11vUsQ2U/BD9oFpc7D3sw2kdZumGl+owBNtqlIG4TsHtsK3OLwkfit3HmGwhAKO4WUNQNDKy+KEsCQ4J31sdiwFp5fQG6vAgdifx/zqcrUKNVquT1gqrf3yOlEAzDMaC94Dz61n8IKLTJeK+uwg3eWFowiMytnwJLdbl4aQ/5x8qlCMf0lhjgynVvEWhRGZUKjyA45omeTgFo5d3hAqbUB5nHLoEXR9JXjSAU/FShtKmiT8GuiuAFzpCkDp1wg3c9XLVVvp+LqOMr0puByeNdNVHTqkHweHxEzz6lkM02U48GjRQz45Kwj4ZGWPaSDL2S1VSjDs/5PCpVJOLc+KyLmf/w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70206006)(70586007)(110136005)(316002)(478600001)(82740400003)(356005)(7636003)(2906002)(41300700001)(8936002)(8676002)(4326008)(83380400001)(5660300002)(36860700001)(47076005)(336012)(6666004)(7696005)(1076003)(26005)(107886003)(426003)(2616005)(86362001)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:44:59.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ba836-c75e-44d3-273b-08db9e6fbf9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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
v1->v2:
- Clean up mlxbf3_gpio_add_pin_ranges

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

