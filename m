Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5A77E57E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjHPPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbjHPPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:45:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC8526A6;
        Wed, 16 Aug 2023 08:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7V3CNPHLoHjBjSUwaDpUSKwln/zTpzBnOqYrxyKKsdHmL1GbWllI/31bp2nYCkV7oJRMihQw9zBhHzoyelRUkS534HIBInbaN55L5cuINVz21H+jsSQ5AGKl5TMJCf9DPZ453w2YJY+S0NJzPKkwsOwo+fC9lutcXNL2BDu0+YknwD6dGB3LKj6WCrOwgYDYzQ9TEGX6aP+4q4rMfAIL/XwKJyF+WQ0fZhRTKr1kj/sRazKZx5JQWqCGGxL6QyAtCTAnmv4CdN1GsKXYy4vx4x4KBn+t2s6Qdkhggu6Cmkhgh8/5f6cf4WBGJz1bTKxVUAXO44jxr4THG4zscD7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaDK6wBt86w2J8zSRN6V9bQpmmEuwOUnA0aqYPsNw70=;
 b=IHfMIDpxYdkHPq11gC3XBRGJtGCBACbYsWiw8vw7w/JXlb0Rjg983kgyEibafXzwmBLXofEMs8kdd0c1w5gpU5YiNhOR6lQLJg3XqB4r4twfYBg7ewV7hFD3Dg0GuB/tw4HeG1/I37C/Bb83R8tAHRToaeQW4bymLnPzs/ftUQpABykzv13XbYFa9VQODaL+odjCfF0m8ErMmWe14amX2xys21dSAnkKUuAU7bJ78KDBBCvHLRJK7rJhLNqEogJ3owy33B/sFRdmrO8syEIWwBRn+Iy1dcme10NwKMfpDwoDHuoIt5cH110SNV6KXgshFhenArGQaucEcQIVOGf47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaDK6wBt86w2J8zSRN6V9bQpmmEuwOUnA0aqYPsNw70=;
 b=GX/CQEuM+xBKyqGuuDwOX9lBLFgVO7G9cm00VoA/gOiLQ772HwmXWuP0DkoyzEgKx/SSYrFUCA6uNCZvKlQYuwmE8X+p6Sxq6+VeUclcL/zYMknpt8m5bfiKSlUQ/pl3667RmPtqDdtBuf4L0K+5VNEOYSSUbHiKekeYOXJ2b/rnQkv1Uw4OqtMXY5OcgY7uLRJQ6qcfKvgfdXf8AHrwAgzHsVeCL0mFzXHTvrul5OtuJ3DFRgBJo1JvHFqs3wUDbMXXh62Dwi3dHY5dkkbCoG8OhY9Fma/BzTWEUvArHxa17W9jBzUOcx3t+0hbDPe4MO18I8Wm+UeUQskeCDTmdw==
Received: from SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 15:44:59 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::53) by SJ0PR03CA0193.outlook.office365.com
 (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 15:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 15:44:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 08:44:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 08:44:45 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 16 Aug
 2023 08:44:44 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 0/2] Fix Nvidia BlueField-3 GPIO access
Date:   Wed, 16 Aug 2023 11:44:40 -0400
Message-ID: <20230816154442.8417-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: eb122b75-9eb0-48b6-f677-08db9e6fbf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFPU4SdwwZgXfwwrotupNhtS1Ue88omLO+3kWq+xtok7GfoahWXEdlKvrBsPT7hjGaM98ISkrb2YxPPPrXHvKS6Hi502UiYYXXGqDuzAbXRNZ0JyVPC3wYNCdm2+yA8yurKzQLQHZqyf3lLjRhWku5LQ5n8EeiU2smpYIDWDdoxzC+Ja0cn7xqqxIJXpYqynVs/7x0XU8ROLsrXx4ceeFpEAAa36vlBAwKS0Iv8wQw9iRaRQH+XB2efS6Y6/HXcClp1nTQHQ8OX1BhuXvL3KHYskMBtMhs5j4cNk+g85c9rwcENg2Dz75RI3noeiKtshUjq0x1X6i9UqqiIzCsQQQlWFx7JuPQAZniqmIe8MeFMVQF0AvHjY//bI+8mElyu5X3Yz8QxDPAxdLSuFfmE7hIwyuEmwdF9z+wE0QaELhHNCXm4fd3pd3vEDmJkHFV7uELOE+jpE+CIwZGf6674jGYMfNerTvCZaYfCpBkA9VWnY/Ju+yTKYwn/6Z/OczV6oHK1trB+dqvqs1noAI14iormDAjgE2DMFwk0WM96icJf6aYDmjZ3uZTvd3m9Iy0MhnQb+ODsbHOsmpYPs5MomeU4Pzy4ngZBi/8VWm7qmWFwtmn+D1tB6D4gcKN0+3ol2bn6CJ6B3nH633hfIGtxX2dmeMtyLGpJqez8ymZhbAYeLUUC8C8xN36cP3X82LK+vxM0IDvvazyIDtLJdRAAc4nVZQFKgM7rfIWN8YkpjpIUIE+9e1y49m2Q2mvU9Q3y266ppSzeivxDvjE8dNglnqQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(40460700003)(40480700001)(83380400001)(8936002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(36860700001)(1076003)(26005)(6666004)(7696005)(2616005)(107886003)(426003)(47076005)(336012)(110136005)(316002)(478600001)(7636003)(82740400003)(356005)(70586007)(70206006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:44:58.8728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb122b75-9eb0-48b6-f677-08db9e6fbf36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
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

 drivers/gpio/gpio-mlxbf3.c       | 15 +++++++++++++++
 drivers/pinctrl/pinctrl-mlxbf3.c | 14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.30.1

