Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F96773FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjHHQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjHHQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:49:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B117A85;
        Tue,  8 Aug 2023 08:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpzd9fk/DApq0m5G2PeH+x64IPEL4srZrjwdKfZqlfCyXpEciTWAdEWH4BRnV+zMNE5JxNj2fnSeo1ulfGy5QXhJFeGnQGReahBRVf2P6rxQjR9mavLN6EZ2L+l06iMcla5nLTtcxNoWUsBjFgjIPZRZWaF4kRZ34UBMh1+CEWSQnyK096MqyilqEEzm2G4Xqmdn8nMLqg0uehJqqJtqMWxZdBZDn8wBwM/HNMVASaGBqYV0AychFGk2JmpWGp+ohdwnqGwjogEte9kOmJ3PfdMEOb9hvRb2G4MsBmAgeyWRIovPajOHParMmO/hbBoYqaK40P8FEuNavcjIoVm3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AP7aHA6hzFP91jf6S0BOR/4gut30wbF51EkRCnKf/g=;
 b=dCPYIXvZiPJ9LBhS0N7xHaUULIX49ZTT3oHoEw3okzZXrbCvUfnoNFFMVCdYsXbgr7QnEvz5V89uoEju6YA6A1zvWQMg5rtwfCX38WLh6NJ2uvSL5Op2DoX9V8XeuaOyYrSMCaTYbFOxjuRTirhGBm0dqsKbppdSbBAGuUBqoNfSziBh7Ofgb5tCASD/l+MGdE/0rXey+VOxwOo8qL3O3v51PNhWp9PQeTj1K4a6A1lcUeibRxcZvmjj+MPwsrt3Tuz3aQpB3qTXJflU7KC/pSAkGk/HbwYFcssW8bIFE49a9OzE6ZCFvO275m8vLIYY9qedEWBdv5LhG1bhyNpsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:56:50 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::3fe6:a3fc:55d:fba0%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:56:49 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, michael.wang@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V5 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Tue,  8 Aug 2023 22:55:58 +0800
Message-Id: <20230808145601.9401-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|KL1PR06MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 86aae575-296e-43f1-be5c-08db981fb195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4WRLS1ll/+KmUZpuw8n+u29r7Vwcmx+BiTSy4rQeJCcaP3pcSbgpTwTx/cIG8LCkZG3W1ACmrbAxoJrZtjCsUmI2nBj5LuqDfWg5xQW6wEc9E14DRE5Idbw7RYsW/Fjb2+QDdDk3byT+/ie+LGqszGJxsZ4N/YIlY15yKiseSJV5S/VXEJLBBak6VvSjWFr9/oROibWMI4rQcijfnitB4QALfMozCs7N+mm3unysIHQ24FRvvrVLIeIFK2z/z2WJIlMv5LMCCpKtejrXBSbFuThHESa7SHBjVM+cM3PJjuMJysTPEEBfW0C7o4Ki8nWaEPqnVhwQX0fm7n56EPKVQUBclElGgUn1QMSssrsgm1YYQdsMsyyffb6So6RdedEvhICZAR2fsxktyLSS5U0X4LvgqghmgEqhAcG7sFNbXTRMUrrKryPDcGe+sz81r+Qq1uS1RPJYyxgTsxT5o1yzBBYfzRODcCR3gy+SeiY+LsLdK2RI+ei58e2I+5U+vHzD+1ImC3Jc7apMXpqZ7uQ3rLuPC12ziz1SgplK6Zcq0jkMYnPWGO2UAa9K9hk3TmIEZOYvHCbWCmYYxvAKqnVkQJTaIoLvKiTT8uWG+NvBLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39830400003)(451199021)(186006)(1800799003)(2616005)(36756003)(4326008)(6512007)(316002)(478600001)(38100700002)(52116002)(38350700002)(66946007)(86362001)(6666004)(66556008)(66476007)(6486002)(6506007)(1076003)(26005)(107886003)(8676002)(8936002)(41300700001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3IyMg1KF3+JN1e3EQ6jCKtcKKOULH3M4T8iClqlXzwVx/ylBB1EM+Wx3gYl?=
 =?us-ascii?Q?KL0x3fR8hTkP0HFvRSDvDNQaQHH+Ovt1hq6IyVGLFPhtBbSFVtH1kwSh2ACu?=
 =?us-ascii?Q?1pLe6/qGZytkHiAfH0m8cFaKtDUMKDeEYl9xHAfwA65gtbTzlzGp2ZTvlqDr?=
 =?us-ascii?Q?cNghA8eK2+qwopcAG1fqshXF9OzaqtiH/4goBLe5j6bP4nqNP+Czp3txjP77?=
 =?us-ascii?Q?wRDnVMKbpbeIM4YNKtbyUZ+zWxrerm3NwVla7Dv9vx3s1gZmIpLn9tjTobKu?=
 =?us-ascii?Q?l+TW2JdVIluB30Ok/eeuGCgpVs+bxAO9g2hCEboLXDLxG2DRs/Ajp//b/LkD?=
 =?us-ascii?Q?99Z3b0+xUf7yWzm50potp4K2G7KOUbg17VVqLCeyGoRbx9218VZUPKAo7X5R?=
 =?us-ascii?Q?GZ9Yo4jFgi8zHJSBT8qgNNG6Kmp0lJuul/df+5uoHuh8kr65px6DzMOco/ip?=
 =?us-ascii?Q?cFfmHpeugVt+jeQxgxCMtKZbOh9Z5gnrp88qIB1PgI3VkQZ+ooT/QG92d/vn?=
 =?us-ascii?Q?FCbWlHdKcAq91bJp/OK9pQtH63wiIOnbl0R3qERv8OO78aYSLhiIXJypXS/J?=
 =?us-ascii?Q?HeIdWgFNrE3pUgJ/GQ6+G8XKv0Xwyl/PwxyMeGe8KjKPpDebt5/WQjQovJ++?=
 =?us-ascii?Q?z0IFA0EXl88v+8eJgyzLJW9powylY0fKUoDievT3tk4k/PErtBp9fS98ZKM0?=
 =?us-ascii?Q?ldMR6EAYwZw1plnSC50J67XsDPl6fqyBdtgVX4b3UuYKkDUAOuC7KXdnkind?=
 =?us-ascii?Q?OtWPoTL7voO3svJMwA+PoJHWxbrRokVp27G8VApj+SfPUWxlI4yrCN4OfdX0?=
 =?us-ascii?Q?gIX4/rUclGUt4LJZZ+33oRy1cUe0DpDe7G6Zwb517YPlCuG9QRlQXQIMZjI8?=
 =?us-ascii?Q?yAafCIH7SKHU+p1SS9dAJJoe+SAqA+eLTcESz4Ycx13kKu8AEdSQ3ZQNRasd?=
 =?us-ascii?Q?lZ57vqZ9KksG4CscHOQ0O2BRpv+EgbouYaqjQx+hyTzJWQ9bMFkp1ZjyZsMy?=
 =?us-ascii?Q?WKCyxt4FpK3zAXvJvRWQkUufFiD79qlbq5Etn32dMoH3BiV7Qf+xPtiF4PwC?=
 =?us-ascii?Q?IOKO8tW5yjTIOw+g1SKC1F8/ztfdD3n/m4lgfX1Az3mLE0P2Xy7qEb86lBM/?=
 =?us-ascii?Q?Qi331Vt6cdJYAqUyCchmG71G4+kmxfF6ZduZA0hxbZUrsOUIARi5eZK7oS42?=
 =?us-ascii?Q?QsufyQPDkwSDsrsXURaqyI58K7QWCfc2+u8sJxyUB0pn59dpOwAvDDKqd6kC?=
 =?us-ascii?Q?61M9bEP4tWnuFDMUTYjjaoIj6jcJfmnp8m5ddilnu61azncAbjcf+ETdk4nf?=
 =?us-ascii?Q?I0kaiVDTRxYaT52QqGMOzosFVLeidh58/OFQJAKELSsMgWNpdK6MJEyy+XyB?=
 =?us-ascii?Q?eOVz8IumbVoRaJUBtzVIMLlP6/DNBJfvVePJa6hKV6DqrpMulsBYSiaDIYhy?=
 =?us-ascii?Q?h7m2zXeYQjOkc9qWvybbeOveRImd0/F3fcM022ji/cpsm0ejh/V2DTJQd0LQ?=
 =?us-ascii?Q?h/IQhfqMZ36QsJuPA0NFv48ChQA9e4dZG13MDpW9tPmQ7k/d0+aniYrttCes?=
 =?us-ascii?Q?2SH5lzs6169XK9foAjUtxjmKKSdnHX4FRhCD5RUUAoAZJacrAk+FUDMKKYH0?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aae575-296e-43f1-be5c-08db981fb195
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:56:49.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXZRBbFLBWCdvYpiOj+RVJ0AU8URXXPGWoqe8t75judigELlANtoG/EU2Q7q+678QwquVe7D2f8HPSnngB8OwkpgzN6hLEy7cKVz1OPFwto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <https://up-board.org/> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

This is the PATCH V5 and fixed kernel test robot compiler warning and 
addressed Lee Jones review comments.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   79 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  492 +++++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1377 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   55 ++
 10 files changed, 2042 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

-- 
2.17.1

