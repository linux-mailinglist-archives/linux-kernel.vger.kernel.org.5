Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C97DC3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjJaBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJaBvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:51:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A6E4;
        Mon, 30 Oct 2023 18:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/e99W/LDwxW/uXi6HbdE50W7QqtVu5UoWK+D2ybD8Wn3TRlltvTmbiDEBAQwsotuMNr2YdMux8H78q0HuBDgz+VJ6V1Xb8MRdeXl0bxEms4+/mzJtKGU8hq0JhX/EYKjVaQeWJWkjFrqGoNhKmfxUikA0k0AV0q9DpMv6/kBsIOdldrdEIbqHlOAJMfGNRHREO1IDJDFOWt5jBjEHv9IMbxCMY2CpuvbE5pL1tMVNACdfF3Ni0yjHWaZqx5Sychq3oXtVnA4uUqkKX5ZXARI0bnTxaxuOJj1Q9u2stCtigHG7kilb/HYRQhrANrFrGxOCtFbqM8v7My4qqZzL7Lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAlTIPzO9BqIIxEqZ0DyG9bdEusaNGjvXeo+5JDoi8o=;
 b=dHnvQZ96Cv8vf4mqjc9X0lN6DNEB/38bPsrGtymMqvooS5ZR2oF3ryY3zyWaY9suhBe4YjCgHnTydA7gvHjNN7DHBs4gAp5+3CdxGBPBk7j4Ml9pzoL9rFXxt2a86dk6eRnksRYQxg9UqorsDgQv8U3felPK+IWUfped6o0M5vVY7vMcpRzSMVHfA8VckjPPo7fvO4QEA0oXMkHNbaRckF7B0aBo9IqQKPiKQP3pN3R8H3YHsk8hemwKJCSpx8iLgouWFBEE/uVUn1vkH23zFiyigclA12rp1shMeLyiVlGfqeNs64eBg6X/LbrGA8pqMZU1xIYC5g2exIBJQHKiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by SEZPR06MB6926.apcprd06.prod.outlook.com (2603:1096:101:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:51:38 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 01:51:37 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V7 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Tue, 31 Oct 2023 09:51:16 +0800
Message-Id: <20231031015119.29756-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|SEZPR06MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 3616a9ae-82da-4e2d-b852-08dbd9b3eb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqQlIhrFTqKJEXjX40HyQz9cSXfJPgckyvjFFZ6yomwPNqVuNnlkuU6lC0uWafVDygH//uPbFWQcGnRb7TFJGBx/J4EqlunIOLKLFy62s6sY2xKcMLk6wi8w/BmmAEFYYTJsdE/fHO6NtWOkdQz9zqNJGtyKGzwJzSA/jy89ZHlCmfgez1lcSmoCVJ0PgAgxWmC9g2kUzPa7SMpAsYNzrxjgjB31/zgN0WwFp+OCpqBXGmSL0CiU1x7rfDRvjWzlHOjBZKP4bnqbHAEQasHdRDdaGmmTDFDG0lwB7i3dUgSBzwpdslczwzWcksfDFbopI9c73PpLFZA4oG2Me4MNOvF5ci/Wog0zgMHsvA5yImYBEQEvTmfgJ0CQIpBuSVE1wlnF3Ld53eVQ8hVl0iv8rkbgkb3kHSD9Wa46+BZg4sAmG3+PlhihvPSwPcNivDGa1HXmYODpaQBlWmJ6bhjVXOxcyI3WLud2f3e8bSKkc4dQo2aK/xyC4vIq+zo65qOZyEMf85jPT75MWTFpTAKRyO7tRaFrJD0/AOcdsd+qdFdIkFwPuIxYdHTGjwF5PNVPKyQltN5sShsB7e1ErIXsMmRXLIhRCV/Fpv2tHtqqtGWUh23p6X+J5+LdQ2SWpbPsSMU/5ootxZVz8CemXJyTpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39830400003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(2906002)(38100700002)(86362001)(8676002)(8936002)(38350700005)(5660300002)(36756003)(41300700001)(4326008)(66946007)(478600001)(6512007)(6666004)(6506007)(52116002)(6486002)(66556008)(66476007)(316002)(107886003)(2616005)(83380400001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Wy+0Ep1ROCA5EyVJ45+rg8c61LgQwGJEBDJGg/6Zw1GV3OIuM4i+i4nJsKq?=
 =?us-ascii?Q?8xmsOpycGv59mjOX1eIdshq0o3KhjjLhPo/enYxGzNeYsasYbQqgjegrkMJD?=
 =?us-ascii?Q?jmvy/O74GePjPvtixLfmVTTyOkESMFp7LuDMmkt1o1rfnxT5RKSVKX3ioOcs?=
 =?us-ascii?Q?07/RRC/aZtL3vW45LwaIwhExexj17Tfari8oEjsPV4Emwin0wN/wjdUZ0SCT?=
 =?us-ascii?Q?SFJoLgdkIFbzjTuXy9gn6JrQ4t5KCms+idHfp/knvE2OaWP2ji4deI5HplJd?=
 =?us-ascii?Q?JeC8EwRVOBG700uB7WFau3qzIgu35j/GEIJp9NK6zejQaM/rLefm7tDsinp3?=
 =?us-ascii?Q?vGnd9XfiIdS6GrlPfxiUSH9ZG7UMKMTo7yLuU38xOGm2PtzuFZtadzrjQs1b?=
 =?us-ascii?Q?++zm2HarcdEOj4YK/NCNMeoO4jMpbJ6zlX57IKGTEh9MDqM1zbTMhTgvzNd8?=
 =?us-ascii?Q?sRFAhvpcYW3jbN8CnZKLGaa9Ps0a+LpED0tDUpv71u1QU2ohrRcEbeke8k7m?=
 =?us-ascii?Q?7DUle6FZ0zdu0OJyJHaB75CSsg542CY6c2z1iirx9VGcfS+vQUQ/YTIR6WEW?=
 =?us-ascii?Q?WXRF+q2TrIj7vZxWaD9iXGOwXhm0fGQAx0rrArJXfBj3W67Hzg5/mcUnk1EA?=
 =?us-ascii?Q?yqIDniW5NpDyKDwhWlkWvACTPV28ohFszbgnFfzm42KR483YOOEuD4M4r5gx?=
 =?us-ascii?Q?mgCZAyXQ390UgAH6rC/glWtHZfM57smrSg4mTViybI2IgrsJh9o77zn4NK7n?=
 =?us-ascii?Q?e90Lraytmu1Ec5QoKx1bTj2eNohkuepfCa6iqcxgePwK5fJyUH6Wc7j0y1R9?=
 =?us-ascii?Q?2MUhs18HaArGJlbsq1R15ACjhsMKH57dcxL+qG9d1sAawU0VMOwg6CvchXOy?=
 =?us-ascii?Q?QT4hR8PQHa9DvkYSSJAeIZ82mVOk5M1AdelYqzc+uq0ZgAfVD//Bokk4NuWK?=
 =?us-ascii?Q?ctdj/j5Sm5Ps3+UYkSfEkJ0/BS6d8qYGDpwiGK231WXbKmHwqAwAZx+MeXv+?=
 =?us-ascii?Q?gi1W/uXJgegKXaQTzqoJpdi+Kxo3OFpZEFo4RiOe6+r7yJgze5XHhLajAEkV?=
 =?us-ascii?Q?/9V12Uom11mI/7pgF8hp1wso8T3ZjmmxluaXZLD0TlpbWHc7QKsi4tpBclwD?=
 =?us-ascii?Q?7s/hwCDhehkZ7pNpWMc5JpYpf0nUucMn/9pfX80EmOFVeqC4FDK4mcEwDBOE?=
 =?us-ascii?Q?8P9wrfQUNPjXzJXXLjR2XaRC266cvEVCBMH2dLsYSNsWAXfET88GOSqf93Wd?=
 =?us-ascii?Q?rdAVKg8aEHmQl+93uVnmZlXyCYCPfZaXG/QZ1PfpvpMn4wJc4hdkQdACm3zI?=
 =?us-ascii?Q?+lENrdid5b8PwV8q5TGjB7f1dMfKlOVcEhJ80MgjsHXktYOnj4FkmqTPkYuR?=
 =?us-ascii?Q?GQZ1W2R/97HNagtqwgGvJ/EkedVwx5iLjFcBl7yHUPGm6qpkkm/nkl5KD3kX?=
 =?us-ascii?Q?puaDcQuy7rAHwCxaWCBH0foIQQGGLLfigEJvhh502qrXrMdK1TWIdYN+0NFr?=
 =?us-ascii?Q?R500gjXBSomi4tIMKiPxdw64DKSYvucGw+ALyaCxl4/IiPngZR3McvD8pTiM?=
 =?us-ascii?Q?fLCPuAQ0yUITq/j5AsqGAAAYmgynwO/htwTcPl6HjBWGvFuBw4F9SjnIddAx?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3616a9ae-82da-4e2d-b852-08dbd9b3eb14
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:51:37.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgM39mna2imRbmsNNQK0pPkjywl0k3Xztg5flXkv1n0vaF6HRaGSbHMUq5xmpJxpyUo529g9FlX17sNg9Qsh1FXrJ9V2RoYfs3rfwtMrJIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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

This is the PATCH V7 and fixed kernel test robot compiler warning and 
addressed Lee Jones review comments.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |  154 ++++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  404 +++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1390 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   62 ++
 10 files changed, 2049 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

