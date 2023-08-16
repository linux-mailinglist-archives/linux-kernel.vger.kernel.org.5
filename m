Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6277E322
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbjHPN7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbjHPN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:58:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324EE2711;
        Wed, 16 Aug 2023 06:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwwl/G/uaTbC80Uo3HS16+P7GYcTO4h2SRkyeLV9XL0BKr80b1w3siAvk2wf0kAbMSI++hKprUjV/AKRJ0h/DPjRZI2VeGOsyyJdOEGky4y9A0GUevBObKHM0WLHp4cvEzYMoGCeWWL308tULgsJXltE/HCBPwLnfqVzxUTZczjEJs8WhqI9mkrC/X9sSLsgY2IO1DcNYK7EMOpqGglb4IQvmgYvtaon/zN7eO26RMCKu8VzfQLiIkc7aI1gd73AE2CBJjf+5otCzo2XRIlFqLauZSyMqmOPzYIcXIWDLSiTjjkLuFYR2L76pTM8LwZHX/+pPtQ94GR4HI0XhGQDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzWU8BzzH3SqSYEA2LLJl30W5zFcax5iBensNa6UXCA=;
 b=UKBIARMKkCjRbJAB9Ot8YHBNtL1WsXzPEkanDAEeKorC+3aBHIQWoIrzmjI5au5AhTG5On7S0L5FeP3TOwEwTlxsg4IhAZ+r+hcXFrc26CBWQtTSAoPeDXz/0o+aZznJydbyoeiVR1JuEMcQf83Zp8y/sN8nRuGfIpIW1KL1vlmREkB4flmYUacLUYxDvQzr0BQAD+BIdXqDqQoi++RUdP+im7EJbqVxBirorkjjJTg5AEwFZ04D2GWcjpNZxUBeUq9Xh7/ZO6K2aS10dSRDg1P+GTPCf8B7Wuv1na/KUgv8GuUVvwLVHN5gv7HzHnyyHqGc12LW6w1nK85P7v7Ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzWU8BzzH3SqSYEA2LLJl30W5zFcax5iBensNa6UXCA=;
 b=DjEtAPfK18KPLw5wFgkvRXBD/0DEiHHtawW2jes7vngnyeld4VkGh5YpOec8385KqpmzDwS0TX/v7Dh8HsPG+tz19FD/OW2JZLiMI89hiEMp0guA0nurzoiPxmsl3XJpiiK6RRFDYVmu0LAm1oGLSuDDgQ5y6O8CGWIEhLSHhqqHJR+y13tKP1GJxVY/VfU6RII/S910Qp/Ux8vghixnE3w97pPtE1zPqA+qlsAQUdxbUWbF5aiP+i2gNqPhA2hNMHt6JQZTxAayowuaMqYKLn9mDmM1As73lrVhixiwJMiHw6bPP9UcD8aQXckXuzBrwTz/HP20eOc2eLho0aryqQ==
Received: from SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::25)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:58:53 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6c) by SA1P222CA0177.outlook.office365.com
 (2603:10b6:806:3c4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 13:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 13:58:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 06:58:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 06:58:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 06:58:42 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 0/2] Fix Nvidia BlueField-3 GPIO access
Date:   Wed, 16 Aug 2023 09:58:37 -0400
Message-ID: <20230816135839.24011-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a08aca7-cf5a-49ca-bd37-08db9e60ed45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfuCAuiu4UNbobkaGvO71vE+xGmpWO1HovmxpCvjPxXHpwawiHFd6Qp+fLV/PN3Qvbzy70Wp9aenxesYVkaGJDfll8HDVp5t4raNBrN7SqJu15Dbx8Gx+XWKrM6G+ClmbbvYGx6QI3vAFwFdOHoMxciJeG1Ywch6W1mms1YVPEnIFRH0kIzLoWeNHTotl2WWYu1QwL6hLpVv+vvT5vvD7i79WYZ4DFTtuu2hUjd4sd/kg1+7+KflbdPJSbkWTBmLy42NkmSfWz8LLYCIB2ox12FlT2c+/JlQj2IbAJ+gh5TCTgWHqc0g5AFjShuK4zS/VfV0ECpoaEBCTwedMWMHoQNtFyE4rxlnukI/6u/vl2peHdAwdX1b0RtGimSSSuqaOcXBzQVvaykPBT6CModgdDZNI2M7i9QUl/xAmXFwei+zfEY5YlYAYJqj+3JUvS1KvTG+2YNpUt2OXZd0fORBk/Gu1MhvK2wYxr2L/v5rpvrUBsSQJQDynZYLItF4m3vqWjLwmnNZocE2kaBBcIEmxTHoATzLAaCvpg/1+WC86TMY0qfKpTL3Kp/xoj71ZqG/P5gxO8TxyciMF8ZTchn161esnl82XiIxy+lP9wPpI1DHznJt1v/MW4gL8joy2dHyEVYOwiZ5U+rQdMHwvEluXf29P74WN1QcWlkR0A42Q13iPPm1FWTenh9ww3EZh7WHqqOMakLqtFSPp9b/2kapeB4VWAFp/k4b6I086WppiJr3PJXde960Mtcuk34ZNlFiIGRxmpGGcuNCVc0Op7D4Mw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(356005)(82740400003)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(107886003)(7696005)(36756003)(6666004)(1076003)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:58:53.6783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a08aca7-cf5a-49ca-bd37-08db9e60ed45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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

 drivers/gpio/gpio-mlxbf3.c       | 20 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-mlxbf3.c | 14 --------------
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.30.1

