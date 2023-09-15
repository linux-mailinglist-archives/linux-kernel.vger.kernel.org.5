Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3417A1433
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjIODMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIODMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:12:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F82270B;
        Thu, 14 Sep 2023 20:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvRe1NYUrjuZuHouYIrHPMwws+8jLEiDYCWrpJhw03NKN7lxLuXaJvy8k6b8c9iC9ySgA+sXQc/twoowbJ99x1EGphd9lL0uQGVEdSz8RJmYnhvI8W1Qqm+odJPRrGB3jJxEIU1Tqs/rzV09FJlCi+gVRKUA99Sg/AAKnxryQIQfwCEXR8tRnwdSocH3Xi4bU7o5woL40uIGXJWGMNvyMoSlQaz3sWJWB4FwsZx0AFRMRw7X11aCDmu3aegnXy+6KR7t/KsGjsIrhNnVcDZZxy8oV5fjvkrRg1MfjoQ0fRMY73Swx2kY9tFsfjICPRhL/F2+4wahD1HZgIcOMElRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6iwr2T8qCeHg7iDYQct+tqMHGlHto6EU2sE7I5fC7Y=;
 b=N+WtadfjZpoD9hcosyIRxj+gSZdn7Gef4GSKS2xXJ4Rn8RILibXuQMeS8OdMvWvIdm3+l6d16K3U+PPIHCz85aH+sHmnPtIOpCt0GucoNHWJHgjAtX9vlCUACZWEd3gt10gyNR0YcMrzGNZQLd1zx9jyBKDV9KiXzs3Gj6oTDRRd03vyCB4drpF4pQB3PB+MwsR/gOV94vpOyQX0QZWnsLfJfzxk4MIv4t6alf32WWAXOFAR31B8qlSXCmhd/hxJyPVsncLKfkFLmqa+dFiw0ia1OvZlf1MH7tj+huhb9xoYrPK22JmCPw4XB+6TrBlhHJtTEG5rJjDLkM5sxHaLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by JH0PR06MB6654.apcprd06.prod.outlook.com (2603:1096:990:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:12:04 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 03:12:03 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V6 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Fri, 15 Sep 2023 11:11:20 +0800
Message-Id: <20230915031123.14515-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|JH0PR06MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2bdad6-4dcb-43c7-4f65-08dbb5998894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uU1yRpB437NDa/at3mX9pu+d3OaUJUimPyDYMLs0TF/GUAiYBTL5SrGgQJOCMQyIRDs/0r0Pr/7yETHAeV/J6575zPRx7qNo15ENIo3TaH0aQr5JkScALCgWVgi2IpcWmZxbvF37/5+QXAAtBRhct8iPrR9U8K3KDhxirbAM/yjug+5ZoU0M9X9BEUoFwowOifFTf3XqLdlE5jxkbL8QcOPK3AYo0m/i6IsgWnKopsVM3KDjOlSTlm8iA7F0FTwt3QJVYdfHz3hU+DRcnb+gSamZ0ImXJLEcxXXiJmk0YQRp1KDPTtwcIZwADCPsRjAzzQBUc/jJYEqQgYetPTZ8vSyF+dJlk0jByoXfUXWe71V7cL/Cb2ekwH2bEnFfTYpbkvDN65EByiVrtf/CC6L9k67KgisQV+7En8GNAbysPM2qN3Ydr1mt7S7lv+5vtlN80PNWrIiZAud0d/nqmOcd/uEmKeZletVUdeSJYPPebxCoOXKNQKpgYEoj7bk8Jrw426/AD/wscmiy//l105Iskj/bYzTdoC9oMuuqYMbCtEfUZVINPjEI6ZppFyK2UtgWv/8n4dx8VoIFH9GxGkgTYpahd+JsDgHhCuGvxj13Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(451199024)(1800799009)(186009)(36756003)(38350700002)(38100700002)(86362001)(52116002)(6666004)(4326008)(6486002)(478600001)(2906002)(8936002)(8676002)(41300700001)(5660300002)(6512007)(6506007)(83380400001)(316002)(66556008)(66946007)(66476007)(1076003)(2616005)(26005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJxbDAJFAx27Nud3nah4u7OuPu6The1SYc2+DNTbgnxnANWNwgvdse5fwZES?=
 =?us-ascii?Q?YpEIgtP8IP7zCNBleO++9gD50n5Z4iNFQKZWm9tl56LUaUiGze2G32LuN+Ko?=
 =?us-ascii?Q?tz3zcowUuODOcAecBtRMJxqqOikSZTEvhT8L+HL5sDR7vbNk+zpdQ2Lfw28D?=
 =?us-ascii?Q?toE8OexuV6vwsWMk9y/jaxQ2XSYycuoeJ7s7KaEcMcjTUR9mYq7Ghpb+pI9+?=
 =?us-ascii?Q?xXPZC/lNFMUCudvnnM55cKpAHHIokJdeLuyvBU7gHb/JZHizwZiA3rXPU2HU?=
 =?us-ascii?Q?PFtX+PL5XSSz5osDYfWrnWnXlYPZKMCtc5ZALyPx7yIRg3/nhCnNTA5oQSPh?=
 =?us-ascii?Q?nmrgK67yOAZuobw/d301LaX2QVKCvNuhJejoPa91mhj+HhZ77raa88vNdmyf?=
 =?us-ascii?Q?PdJSWO7CyiKAc9KRLAzpHDlEw69oeNzzOSzNqJBF0byf/ruNffyD4qHEyXLW?=
 =?us-ascii?Q?OoBuYowdacyBwl3XI+0XTlWKBnHF9uUJcVn2oNCEsYbqPo6zXsw5PSBsesok?=
 =?us-ascii?Q?G22o8CAdNBwXeQj5nm7VEf/WRRGuTkAIAzbvSCfmUZDxboWyklbYYif/cDgT?=
 =?us-ascii?Q?xhUg9v6BLrmifZo1PG7+k2aw7TcldexWqTJlnl6swfR4fw2AxrpRnFo8ZsMM?=
 =?us-ascii?Q?KLSd9otlX3j8iANBO/c/Pefoj4NcReTjiqbSB7HrjWaZxPOlcIognb4FYMSv?=
 =?us-ascii?Q?IdJiDkj2zb9ZT0i2rd+qhCnB5mlptiTEUAcR81dSvA1XpjIJWU10szo4JNTZ?=
 =?us-ascii?Q?yoEjPusK0qoEtQizFOcWMaHzsvbk3feCAOYPZ7KxrjXxU8clZZdQzn2YoDtB?=
 =?us-ascii?Q?1jRRl75rOuk14tQqPWgHSwLDwkO1dWuJY4BgWXJC9jItc3YcgGXzDTOHcD1w?=
 =?us-ascii?Q?YSQAxOxMYMiFzVXBq9sSA2/J/FdWX1X4JIT1YFEpZfh1Iljj/NDBNl98vR9w?=
 =?us-ascii?Q?LjXwmPXViKEOnc2QPymARYKyGBqqTQ+ZDi3Fn3pLpyX2UNHmtbTki/tJJvZJ?=
 =?us-ascii?Q?u6WcgENSmXNqO4BQ4xOzhmmmh7XbxEiqDknTd4S4uD+wukLJVDGa1dcCOYPj?=
 =?us-ascii?Q?3Lr9T6S1SRMlg7XRMEe35NScaVmTQq6D/tCWMnFeUuOZt4O3SB8Jr4QB1kLQ?=
 =?us-ascii?Q?gVsz1DTWKPOcuWGPCZV4Nu4Ne+NSqgYERwOv0n/X/aMYyQbW0sFeWu6A/2/V?=
 =?us-ascii?Q?SKwdot6kUt/ZIlSLqlIT9V0nsW6DtaSvNzyO9f89Sn8/n9zu0cfDajIiADQ+?=
 =?us-ascii?Q?JoVC6x3HUsZIIZgVvuCLmn1znfF+pygaotRN8OlHf42g+Fgy7BPG2GL83nfw?=
 =?us-ascii?Q?PMeNYGxKEZTPIxH8mL6SDdNYNF2BTXAs8ogrcqmq857+/sviYaTlmySXoTA+?=
 =?us-ascii?Q?F7WWALRh0QKZCP/A22lVffgVJXO2/JONX0cgoKTTr2c+QCQOjBpkeVeSJfz7?=
 =?us-ascii?Q?STV0w11CyHMXieCAM+3kuQXhUAzfdmnGxso7H6IHzFE9E9zveZ2vgbiOmNxV?=
 =?us-ascii?Q?/0Vnu/Uv84OxAvI85tA3zK01huN5CyYZak/HZQaLXc60SG4aaSBsV64JU1lm?=
 =?us-ascii?Q?S3HzeVGze/vPAtc72NCnNz/3Jsy5dZBabwMhg2WoFZOHuAKz+brIf1AMpyD2?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2bdad6-4dcb-43c7-4f65-08dbb5998894
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:12:03.1254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKCkUQbAwbCxVhdfsHIhGsN91CMJgRWDMayX8dbhESNIWwpzdy4EBUotWOKgGOEXBmxZ2/BN4GHhggFS1UXhstR6bDQBmCT1cM92idLGa+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6654
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <https://up-board.org/> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

This is the PATCH V6 and fixed kernel test robot compiler warning and 
addressed Linus Walleij review comments.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   79 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  492 ++++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1390 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   55 ++
 10 files changed, 2055 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

