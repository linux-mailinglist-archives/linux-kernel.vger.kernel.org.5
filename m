Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFA7689B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGaB5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGaB5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:57:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41888E71;
        Sun, 30 Jul 2023 18:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxFayl2ml60QVKzuk/5roO/FutHwFkCslBtA8IRRTqlCkt83ZqMtvOduDr6l2G+MyvxecNEI6dGbrhN0vGhgJ6gKY8BYHAg/7Wn4LsPI37XMT3/C7ap60/sDEh9+zu5ZFChhHqX0LfA81fChktFuHu5beVGk+Nsah2EOi4CbQTFFPpsa4vacs9IFSuCFIOOfjKp8mZ0xU7Iy/UKfaQ6S0fqn0cGj+Bw0R8AYQEEA9OfjYzAlFuudCIEtHmVOo4IHYvfegmjoWiYjTqORhdlDOiyUDk+VZocHbEDkqc0RNu+wHW3UoK4BXm0eyf+RBvr3Rigp6FnocQpfsoClqyLrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b11rbqzZJGo5I3vuNbcpyeZlU8te3DZlzaEwQA9wgqw=;
 b=USE7M6C+O1e7lR4/UmV/yxfv+3Xof2afIcyef2hnGB/zClhUqNNUS+VvZgAc8NBFbckjWFhHfKO/jiJM4VeKtgIxc+Zhdw9EWTuK6ystxT5ACZBMyOU3fllQVnOTthaQzdan3TCRCj60c7bPHWyQL+aLxog2kQFZRe5Uig54RZLGuOMyJ2Ek6WzjBk+A7MIJKnSskIcu2MziKJYB1c/zc+InrbTlrk0owkbk6CRunQI3oipx2bCuo177wGw6L95nV1J2r5AlzfGA/isFnUDxyZOvGFdPJO719Bfgvt4HxP3D4B+cBYqEiD6UCiqjet/ud4DpiShvSx8Sr2PCmV1gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b11rbqzZJGo5I3vuNbcpyeZlU8te3DZlzaEwQA9wgqw=;
 b=q6+EM/e1Ci+oLv8SobLpMo2g1ytPn45ISNLLoAwQGz8eUqZqCJXWRZMehpvzccF5DwMzuDZ4F8d6q5OpYHk/8ACr1amepNKRjfHHsILopVcWQJiGtxl4dq6pegLEQjpnmbvk5uRdNRRbijE0zqoJKQcAWf7igHdMg/TRmHl5HqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 01:57:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:57:30 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
Date:   Mon, 31 Jul 2023 09:50:53 +0800
Message-Id: <20230731015053.15150-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 5112a0af-a7bd-46c8-921f-08db91697f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw9ZscR36EsDaowzk5mbi/iqpQwcJX+kzyQmCRx3zCIlIEmIcTVuXaHO6ZYIDDNRV79k9ImmSxP7iYoR1Qv3KfLQDfPIHmhPei4uq3bzMOY4oflE4XD1EDQBvaPLCA17Gaho5XcQh63YGK6SKmxTsC1NziedHWFFc5gRILzlX30n4Q2SJC15CqImk6gWQGwILhcUgHLCFXoHUyMaHQLEgsCGWI9t55jgcUlqP/YV8Q2dJk6gG2aB2rJF6SldZRsf3N3k5EN67VJPmTFDxBUoAv+h86ZPVIltzUV6eGmXKsGCnE0h4VAfiCulJkjRjtMRBhPAuOTd3wNGYWMvaIfU0YQ473u4SJIYbsTspwGeDecxqOlgvhOTHY1JOt9KRowCaF59DHw/K+lyUZlJxjbTy7dSPdCSKWdSzFJcV+BTLCkoXcFUaNPfVpak3/e/D65CrOxJds7BzNaibpScoPodBcxzIFIKvmaT8KbF+EJ8g5LpIq6pQ1hhk8a4xuHBNiJ/puOsLYAvcDEGHHByRqyV8+LegIwc/qHU1ECtuWXNbhpYt43Urv506q24uUnotFhwpgbv5E0wi/EgNP+xgweVejm1li9aXnMGy1VI3nIzvqcp8Ei7kmwQ4t8T4qLpI1Kf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(6486002)(52116002)(36756003)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUjNX4rqQlg6MXRJkKEpz61iGDySRbh5uirwpV4VcrGv+nuXureGr2gcLH46?=
 =?us-ascii?Q?OWR267vmaTv0xUVwkAS4JiO++5vIgIiPrZh8lK/j0V/ffKoY4T7cY7JqsW1V?=
 =?us-ascii?Q?+og8Tilsp00oYpq6EtXtbsT0FpDwQg1qbUDombmbaq+IsNqGwF7csejaNYto?=
 =?us-ascii?Q?eJGG0TiRiD+iz8FBfsi4jqHPKVyeNoTtM0eNiRSrvu8qrgzRu9y8sYbegjQ4?=
 =?us-ascii?Q?ljeu0xDb0NQH9WIfPU/Siym2iW/tsVDBuILh9FnOzutU+GRuxbiBs7vf6BT+?=
 =?us-ascii?Q?UNUT/FgVG1YEGSIju2Ld6VY24b7TbBcMab1W57UQGO949/c4V8IrRS+l0SCU?=
 =?us-ascii?Q?0iyLKqcF54sCcbl1KLiKTo2J+uyVEvpf0CEnzsosrRDbV7WGaWSc1DLfu8i9?=
 =?us-ascii?Q?LXqMDtZBfmF2+MZUcB1KqDa+R8hluHZQPfVxTBrCeVx0LMGM/5LRO7RrKLPD?=
 =?us-ascii?Q?OZOVk0/TkADaAW7lvMjjtMlBActdTXv9K1IV4RAQBlN/sU4e0ztjgaXsTvzh?=
 =?us-ascii?Q?1EUEvv37bAJWOz77oywwyoGVtCdt8OxhPQq+VyTZfMBravG/dz43c9CP2d2B?=
 =?us-ascii?Q?oBgqoU9sAjCu0xSc1hS3NfjDvniuUZUoDETcZBZIQVSCyonJd5ufv1ERp3Bc?=
 =?us-ascii?Q?pgQUm0rF8Bo5HyLwDv7b+Il0xJuHu+fYQgj6hp6fBGhZuK28J9yzkQB2NNDw?=
 =?us-ascii?Q?OzCriDir98MmJpvIxg+8OCjjnDZO4YSoFQr06k4i+AV1Xq0tU+iN/77xFKft?=
 =?us-ascii?Q?fnv9tqWEKzIDJbtnRKINdtYnQUtLNjgxygCZHwbZYNyck3RKgn7+/+GmyA/5?=
 =?us-ascii?Q?Hb9qmEk1hRgBix5Ij96QixiBKFUaTDdiK2riz0MpK4KeaWEZnCxPulz4cu9a?=
 =?us-ascii?Q?Lap1OET5e5QnPcBQ+cxHhppvPPr14DOMx/tajpu1Q/tucQmIvRlidCCIE+nQ?=
 =?us-ascii?Q?aRyjSP/3NfFtKm6Xf2Fcf+wINnPwlKBGGgmLEOe3S2QCzYsVd2mTFvxfkiWh?=
 =?us-ascii?Q?saAGi8UKO+A07C6DXkWv73nFEDVj/UwmoZmIu8UjtQfp28WkwR5//5p7Bobz?=
 =?us-ascii?Q?I37X4m3C9gwwNiSmYbX2aM/ZBsGKBQYGwoSXclK/tfgRgpjXSUxQENmM2wUo?=
 =?us-ascii?Q?XgV48iSr+HZUiJeNAJxhRoDdkdehpOSgacCsZaPkyPqMxjKdlsGAPqYIOaK5?=
 =?us-ascii?Q?mh42MvpwSiIhjnb0HFapnGJ9X2zIQL4ArA/Hr2WaCXtNwvowHx24cTVyqJQC?=
 =?us-ascii?Q?Tt8SNosbMDs4wozTAA8/yuWtREfueIsPluoV2l+p+TgTLXtjOXsJb741zlFj?=
 =?us-ascii?Q?jeVUsjvgJZQCh0u9BOrNhfwGP3IjfO1e4piQkRczn8skOQHh1Msy72HbdqQ3?=
 =?us-ascii?Q?DsG2mLRSfIQ4nZN0UioKoOFVKcAtckjNvVahWUd1gEQCKqoE9QWl1eawZ7kn?=
 =?us-ascii?Q?hIycEiPLCGH6cuKqE4w1Bh7VL/IBr9t828yfbZZdrRsxrhywa1ecKzzz17r9?=
 =?us-ascii?Q?27XiKIAb8Chu0y/giOYvRRTcg9jqqNDoQAvAk/gbpEZZFFwX0A5OZj6ubB8l?=
 =?us-ascii?Q?J8hFP7cO8Pw4wDVQXMisBOw0z3wOkA5QF/uOt7jp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5112a0af-a7bd-46c8-921f-08db91697f70
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 01:57:30.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj5Z+rr2KUC0vThFPGSfkZC30M3qlNK60DY1LSgdcPeCKY1kPSCF+ZUFEPJ2z2it3pDb6BrlitE/vMuX5SwxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not read the data register to clear the error flags for lpuart32
platforms, the additional read may cause the receive FIFO underflow
since the DMA has already read the data register.
Now all lpuart32 platforms support write 1 to clear those error bits,
let's use this method to better clear the error flags.

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6644c5989d3..f72e1340b47d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1120,8 +1120,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;
-- 
2.17.1

