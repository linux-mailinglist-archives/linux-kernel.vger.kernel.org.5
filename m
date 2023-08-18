Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4979780318
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356874AbjHRBXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbjHRBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:23:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E94215;
        Thu, 17 Aug 2023 18:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFztLpspfTjzzac72oDf4hP/WEBvmueI0MfZCeL0u7bNzfSWpyePMkPRRfg9apukplvO/um0EF1JoUsr3fs2COmQbJxpOPD18YQbmENbJSqA/uAlIeAEzqQ6jaKzkXAQd5Nj3vRPPxAoUJSpB2ZkLZ4BF1hOplebxw0i0Znvqu5Mt6hFnQiQHQI0C9JfhFvVjtCnMRyg7pO1ZpeZRZ5rZIKcqvs0kSBv9bOI4oDoJ+Bv4jJKpgARw0Tji5Qi8U765ARkgR5TBLl8wpF3BNLPgUH8HRBWV/+aZkSXtI38Ll6uZbA0g7VLNJ6GCbXfk+9K9gHQu/iwF6AqmfUVDyfXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/iZaryNLztfTGt3qzPitwcZQLRQn1x+idkmw0Ip8Ks=;
 b=c2Iz2MmUXiNvs2EVIKcZWsADoYuODghUAFH0Yg7BXPZTLj4RZcfASl/IzNsICDCF8wZsh92qNHerK3fwLD/zsuFOwIjhVebIY/cvPgFmpml6P1KCSyLVlUNryJuVNiNF5rgX22SOzleyNWOOwLvyy5YaYiwRo+9mgwnYRoY12s36wqfokep5B9usrDyT7OOnqx2p6mvGHOh+zrENmMWLZLWmM+eYqWOWzqM7gdf/faxNxcvSSqRURsb1E5aPlwTMKJPlGTb7sB8ai4EfRCbp/0Xguv77dgX7Ih8arlEu10wr3O50+gdeL8j1fFx86Alp7HYTF4BiZ3V6F8YIbmPRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/iZaryNLztfTGt3qzPitwcZQLRQn1x+idkmw0Ip8Ks=;
 b=CflddFBQsaBKRQdOv9xl21t/kt4THAaTeQvQqff+Fe66QH0vWWUJ/BlMfdhh06B/WbSTpLJVLWXOmtXhZAI0M6eHFcshvtIGqCn7PPL0gS4fNlp0eDV4c190xKulhgJKysLa75lgVlF9oGqHj/XWKCJqO/nbUI3xhf2P18LuHi5zGXr6CUSgIRKjIa4gYR7uuzTbiLL9NS3Ob9P5Tn3WOJI66Fa8jt35dEAUd7mzSKtNoCTxEBQho/cj24TYjTfmVx4g713xuK6tQWnTSsWkS6iM0BJOGIool6l/3vMq+NoyjDHyz5+FEoK7oPu41VtbnW074PZdqGZL9P3YynDWRQ==
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:21:30 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::41) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 01:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 01:21:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 18:21:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 18:21:15 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 17 Aug
 2023 18:21:14 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 0/2] Fix Nvidia BlueField-3 GPIO access
Date:   Thu, 17 Aug 2023 21:21:09 -0400
Message-ID: <20230818012111.22947-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 785b90b4-09a4-4ec4-5ab5-08db9f8973db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bPwOwJdli7qArQc2TxMC880Dfr9FHNeKnQ33qvdNvQbntP74ueRVJwg7oOsEKUG2QP7gLGjBd5ELhOiZNzghXQZHLObxdkz1z4dhqg1gZXtZmqxwwNRbIwFhCjymnwKl6CeUHzjH0qhqNW5YDhzWmfGsY6B/vqe3fX2UpxfgH+pfpRb/JL4WNXXSN6my/V0zJgOq8RPEFcgdSCJDYWsCLmd/52bQZsXmDtxZToArokfywPOj1lSe2kGq0hO3YrjRVI/SoMFqAL8PWfwEgEeGnjFRD86RBVtVRnmErnsrv52/+WsdKsMjQ79c20qOMimCGAZm96oF0PO3eg7OYtT/NkDy/9f9kHJz5atNU8LOgfKmlnR5W5BDqdy1uZlVCt/qosFBH6DA4FU10Pu8YhdvfK2NSkXgHwgdGJxq4fRNk/zAhY3FWPlQYB1pVFR+W42VEnBbkd4sGQ4vHOeAJVtdLM9YjcHWqDmi1FWqOC2+ZUAfZLOzuCcoXYkqUOb+69jliw3qThFJw6cZyvGO5wI2950buY3RilXbJx7s44YL8YaHDJHRx6M2/e/+NpwEJyIaSitut5ee0db43E/3s7AyIS0yLW0cYz8Jh+IZp/1jrxTrDV253gnwGrawHWxylwkRMEnE+78gXYZF5l+hGiA6XAzLdjkxpQ6U9p6dRUMQYG87xaF9aXortOd0z++ljdKo3QuDPk39ODB/kaT5MtxpOymWSU6GpIGAieeZbvPHMQIpUrMYOlkG2HEso4n6bQiY/VTttdWuVXH4T2GAlPaNA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(478600001)(5660300002)(107886003)(2616005)(110136005)(70206006)(70586007)(26005)(6666004)(7696005)(316002)(1076003)(4326008)(8676002)(41300700001)(8936002)(40460700003)(47076005)(336012)(36860700001)(2906002)(426003)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:21:30.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785b90b4-09a4-4ec4-5ab5-08db9f8973db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Nvidia BlueField-3 GPIO access via libgpiod gpioset tool.
gpioset tool fails to modify the GPIO value due to the following:
1) the pinctrl-mlxbf3 driver defines mlxbf3_gpio_request_enable()
   to enable software to take control over a gpio. Only then can
   the gpio-mlxbf3 driver modify the direction and value of the
   gpio. mlxbf3_gpio_disable_free() gives control back to hardware
   and is called when the "gpioset" command is invoked.
   This cancels out the effort to change the GPIO value and
   direction. So mlxbf3_gpio_disable_free() needs to be removed.
2) the gpio-mlxbf3 driver calls gpiochip_generic_request() which
   calls mlxbf3_gpio_request_enable(). "pin_ranges" needs not to be
   empty for mlxbf3_gpio_request_enable() to be invoked. So
   gpio-mlxbf3 needs to populate "pin_ranges".

Asmaa Mnebhi (2):
  pinctrl: mlxbf3: Remove gpio_disable_free()
  gpio: mlxbf3: Support add_pin_ranges()

 drivers/gpio/gpio-mlxbf3.c       | 24 ++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-mlxbf3.c | 14 --------------
 2 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.30.1

