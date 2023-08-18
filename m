Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA647810C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378784AbjHRQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378771AbjHRQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:44:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F784231;
        Fri, 18 Aug 2023 09:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhbi3c8Gca0V1SevU+OLoRIVYka2/2mZAEazcEkrR4acoz1c4UI39BE7/3WvkBi4kHPOehkLX2MGH/tZSKAI+NyAIo1Sr6wPzNDjcsDBMbrgFyL+Q+S9Av890MHyH2VGoGvMhv0qEvTGryHVoEs08+OagGhWaAL5rudRgIC6TBSZ/aIvEpH7RfRgD8kRxsS/ag4YmESol1R3qNx4HMfhZemku/c7gt9FarTfUvz1ahjNdYI6J+L2KwJwKNtEiLPfU0vD+qqG//7BgPw8/QfyHgcyuE4cbAfqqAC+WbJwNFev50tj5CnOoHXOljbPQBnf+IMIgRLtLJ2GRBDBYVNh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krxY6QhpVllUulAtkPTsOp7RmFWVc6T9u8OKw5J4FX4=;
 b=hf+8AzeR554NthI5KoarFWErH57RUKmmqmpFZ6fxzECqF65kgwOA90Bx0p0ABa0YWGZcEPBR8cSCrBI6znGxjnskX4Oow9Tj88Y2NIw5pBTfBdSE7MCI+sz9BPrhunpC8BgaEKrnvhlGCfyBxuZYrUemxVC6hF0oLCb88Ju7AdxZ0Q1RmkhnOmvtUBbLSy116LnYBhggI4WGLi0As4Gabs2I1zqGKgJjjM556WUitw8Lyuhzk6EiKL8jDwGq8EbsfJoiHKO9NrcUDjS61q+H4eLBF3HFtAV6oBye1taRcRHCvy1ppgdZyGjO91xwMamBo7f5D5k9QX4wtjqD8ItJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krxY6QhpVllUulAtkPTsOp7RmFWVc6T9u8OKw5J4FX4=;
 b=Dd/F4HBWfJgmqcMw66vbjHk4LQNRFZ5LuhQQ4bw37TOMSfWRYoyf2xGZGLP/5aEtlTtzi83A1qMicrx4gtJ/I80I/65S4v/I8Iiyv+/X11U9d+ywPjf2zIs5tPWC/cEZwmC1lff1gfKuZpeBt9tqDQNXXCnYjZVw+lluU3u8uMWjBVo2+GLNHsRK7dSdiCTi5jCFRs22us7fkmX582dXPTr26ZeK7JdIgbPTqHudSkbixD1FgULLLNjOVLBUooT1N+OFmp0ccxEhNIHoRaW362fTufxQ9nLhnWj/7VT6Q3mgnoPPThkbaOFD1NCXjpOb4R74DEVwt3QZRPoz94aAqQ==
Received: from CY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:930:1e::21)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 16:43:27 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::e0) by CY5PR04CA0026.outlook.office365.com
 (2603:10b6:930:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 16:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 16:43:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 09:43:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 09:43:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 09:43:16 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 0/2] Fix Nvidia BlueField-3 GPIO access
Date:   Fri, 18 Aug 2023 12:43:12 -0400
Message-ID: <20230818164314.8505-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: f00eec9b-07e0-4ce1-6402-08dba00a3f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZAanHLSdAGxrGnPfKrVH7XaYj8Wrpq5A7YFR8FIOcjehZi7TkncCRz6+PXGJoJfXiDqcDhUI61HodsP/sucXHkEIqvK10ioRF+vdJZtB3vzXpdyM2xgvIUqGZncJISDEXf9S1J9kwmyzy/6cGSl/dWxmdsGw1s5EY7GCMPvMjifRRnuyqg8Gjas+fw6ySIfdMwS2yVwJNMhCQgOlxB2GgvPepA7o7HSnBS+TEZV3YdK1r8pVwf6BfzcpeG2cYEqxM2GUhbD91A1O1VdGvmNIlLN3tEDyL6mkvAX802zP7G8jajIjTs9PWf9DogN4Hv6mA6RaTowbd2/4F/KaUBzG6IzpaxgFhmoZBER7t98kjzxMo+iV8JejEdKRgsGO2nV5ZgfBl5wV2DJT1XAARE3KbZ5ZRWcq63RdMlQogsxu1bd/u2Kucefh72MUScRFC+a5f0b9EFdWbnf8lNjEtpaMUEWXY9bt1fnhMLwPp8grltQ9ClAvmu+LZPN6tJ5mqSBIzWYKonVJQ/ruU7RW2SsKyy+Aaxj5mK77IlhcAOFKSVhNI0MoJ3FdVtOXBf6jTldqauCU5VXZPUr1a1vq7YQBW7+/5H+UtmBvChQVWjFfqlP2GWO1+UmX4+tPOCyZDjrEDjJ1IJhcKihkZOfK6zt4JrnvHlyH7H3DlADtn9DaQ1u72O9mbSf2p3ng4gh+odvF3+YJkkxGt6lMQsRFlzXE1Q2gphqnx7MWGycRzd02J/RUhc0wu0kTySCwJUvQEfg7PaLECMRJZKhahBSiCof5Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(86362001)(426003)(336012)(107886003)(26005)(40480700001)(1076003)(83380400001)(36860700001)(47076005)(36756003)(7636003)(82740400003)(356005)(2616005)(2906002)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(8676002)(4326008)(8936002)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:43:27.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f00eec9b-07e0-4ce1-6402-08dba00a3f45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

