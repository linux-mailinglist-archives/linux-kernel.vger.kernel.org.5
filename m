Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA3780BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376928AbjHRM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376912AbjHRM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:29:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFD103;
        Fri, 18 Aug 2023 05:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPSj20XsnvcHfQVS3fnGXSuCuP9Mbxbc+ZqVc9F4CchLZjGnXBwujNb3kjn5ISsBUo2jtp9TWpVIEwz2SDZI0QE9I+9K1Wo+fxEOyFpDpMgHuwrBPh4KtZRoqhNJecCX4WDI1BbEBltHSRjjTiznPeX6qTbF909ulf1w5qxv/k6TFXBcgKlwiuopyp9sSJBDgu6nI/SSb6lSD7pUaHkysR/eSl9O/pAU33UetiJteUPRXRtS2DOOOn77I1cr73T2XG6N8zEKlflmP51MBYAIA1JDLtwlnVR7VGuf4KTF/CDxt9xq9HF1Bwf0KmDwRcF3689X+oAJxb9vRQwyxILRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/iZaryNLztfTGt3qzPitwcZQLRQn1x+idkmw0Ip8Ks=;
 b=lsmBjA86qSz606zhGlCZjPODMh651bCF3pfT3MJGpsndhbfyaEYlAn7moQyYVdOfgQHq0aRo5klsmg7wdi5Sh04saC8trzj9J9ZCUt1u6k5Jz4MCm2YHre8/39hpOJjZgX0SA6fB/UTwCncmn39ET5Wfo4RpT6WGMo9Nyy82NqAa1MxsRswLPMC1EyR0uKrcGgZE9x8DQiY0J2nbTl9O2ZbUUtn6sbJJeT/tofv31I0531eameK833wA8ivWMuErFDM/WjZZmcixrByYvJw3oWiPQotRRNInh74AbelejjnuIAfkdrec0yEKIdpg463uPjmhYIpEAqP8X3pA4MBEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/iZaryNLztfTGt3qzPitwcZQLRQn1x+idkmw0Ip8Ks=;
 b=pmkwI26Zd2kXoZaw3a4GAne4dTuGOhxzKQOdacYL4YxMi9GW05kNRpgAGEQztUNI3lh9vwZgi4dEu7vuuu3vINdNv6pHNc98wKeFNYzYL1fsLfVdVISPK1VOp8+NqBdLHFg2TBSIxZnkaWWu/gb0Y2Ld3ty/vCX7EaKvGY0416CIKYH1MOy0L6GQkBKTLpQDCrzITVluAiCPn+zqhMRfEym6cW/N1uOLEwqsDsoq6op/62sNkwdrbTyny8Gkg/DirFt7vWLJugFVV6eK1iKsskFnOa/CtJeEVLShJGBe4r4//+f5+wXk7ogCtWZjCGXCG5YE+zFvOXWMPoMrypq6tA==
Received: from CY5PR15CA0222.namprd15.prod.outlook.com (2603:10b6:930:88::17)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 12:29:22 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::35) by CY5PR15CA0222.outlook.office365.com
 (2603:10b6:930:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 12:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 12:29:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 05:29:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 05:29:11 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 18 Aug
 2023 05:29:11 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4 0/2] Fix Nvidia BlueField-3 GPIO access
Date:   Fri, 18 Aug 2023 08:29:07 -0400
Message-ID: <20230818122909.7122-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: c7885ee7-f9c5-41b8-ed74-08db9fe6c0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIsdEZRtLWWd24HGM+ScZ8Tfooi9QNYFQqNCNmrvUFXcTe6WgrQwlt1UR0IHW21qSPrVUzogg44l6EbaN2TfGNmqeDR5Mu/K4NHdevFvxeop+PZx/D21wmWokyXDD3cMPuk28F3ANKYR27oRNyXRDTrvcjZZFf6iA+4kOB+I9nqUx4tVyJAJqOuSDRfUJXxFgu2Mpy9X0+q5j53JIChdWynIKtchw6NbQIBUq4novMZ5nHM391rSxBaxlbx2upaCAGtjV4cblt4nOHgDDdRnsLilGwsIvskFIGS6mA1j/dJIS0Oc2yJMDmsT/OSwdGRojTxLeBbg4C5AudeQ8aJyGTFLS6gp2GisdL0q23NCYzgQm2rpNvZi/3KX5GdTc2FHR7SRD1liKvW4Mob0jwb91LU7Fl0Ct3nQLXPogUbcj7nG92p6tlm21OL4EIEHoWB9QBxQgZODXTapJGKYL86ZvUo0eACxTKGxM1i5Z94WZXPVHe2LZDkciSD/vs5DIv2iYOZgTt7hAFGJ2l7fxSMChYsJGJ/XfPSUgekfHXOoxD8zYTy/x6ITsE6JwXbdZ9KwvmusDTVhNoiuJ1J0XDf/8EHYlSWKyKgP/UO7qhJqY3gJS1WYk9o3XNXlnulue1GKA0v3sixEO2tbXOSdPShmt845eHZdXslA0VWLNlw/zMsy1zG1Dt+jc9oKkZ0k7WzYZtydgY+cRMUh6PXDiGzoLc+tdLfJt5ZLp2MhfNZrL39L8+emmDoZbJsRliqBzBu/JQOR2I6+5ksajLIT3K1N0w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(7636003)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(316002)(478600001)(110136005)(356005)(82740400003)(2906002)(41300700001)(8676002)(4326008)(5660300002)(8936002)(36860700001)(426003)(2616005)(47076005)(7696005)(6666004)(107886003)(1076003)(26005)(336012)(86362001)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 12:29:22.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7885ee7-f9c5-41b8-ed74-08db9fe6c0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
