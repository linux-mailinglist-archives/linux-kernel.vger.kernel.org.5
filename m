Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A117768C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGaGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGaGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECB1BE;
        Sun, 30 Jul 2023 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu4Vt6zL/wesRN+RAAfMKAZtPcome3k+B9OCPf/IKwEk8QQckmuAwLKBBf9QdCbhxGuPndWH0STyubK+bIin5KLrbiS863HwcvJDxpIT6/oHolUkr4YeIqvJ/nbWr2sOgSBRTdxJ5avDQ5XzuhzIRBW9iUEOl+L/h4MpTXRlDjg5FI8he8qXFbBOaV9N8yZTgKsaBuFG4Q2b3iKoBK81uZcXteBoBgXmXLPI5sEfh58LDuI7ir4uXS3CVeKJ9Izv97CtNFaU0Uo5Jcyn4aZ0OpH8RwXI90Via4Fuafg66eLnAprrtuM1H4rPFGSBR3GZrzCghWyu/QKvUwRx783CVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=BfrsCSnPIkViZ8AngTYE7U06WeSYtbpILHYoq4A1GPWz+NSETT4Ksx4YjWAZdk1ZVD1RUnQBDF6Fg7EPv4rxWUOPqAlUpwbTWLgSHaFTNd2uQsl8JIEHgp8tQh7suR38WZH+wG5MRGH9NbSUT3yGBc5JvopVxZRuwRGPJRAr3UO54h74BoO/+uXrXYsWT3PYLfMVAF7sInoHPD0Y0hB+TXSeHaqmu5rDHjkQ+Cw5jzOTkq8i13ObMeltH92w90bE8UZTrbSSSKpcO9MO96uRd7I/nrKAfyJOvH/Cwn3ohszr/0OTRlIXOkHDPvQ+n3Aeh/zgNlt/QRN/d1vUTKGWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=lsSNDm/taMWHZK9tJauXeStykHwBXiRMcVY1uBgRH+9Giul0/fjKf+pUmg9prNwkgxviTvLVfZ0n9QWf/YrxfS/XNOCFPEzYttSaYvnjl5lE1RpQeoLGoKd2uMu9Yj8mS99kJPnhdWYR4KyuMvq9yVRfw/10q+cE/jKA+MY3NQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/8] genpd: imx: relocate scu-pd under genpd
Date:   Mon, 31 Jul 2023 14:47:39 +0800
Message-Id: <20230731064746.2717684-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f501607-0b14-4311-6b30-08db9191658b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYhGdEws3g87K5ckxi29Skx5dEOV/rGGkYU9BMIkTBqabvaOdq3uQSz8l6uGxH3lB0vTpg0xVKTvPim0gKyjCPa+aM3Ffxyqf5dJiroWMJkzbJ8AECxlk2NZpoVvV4z1e9KpI6DUyIkXQxzhtS5cAR9yDA2PQC0aUyolgi01nlue3N3CvT5f/Xyd+MeyHOLmLZ6WoGtNYCc60M1TQmtjXWVLXha+iZRG1AlAVZRugphigXHsvYwKXkT07rpk92qusbTTqmJrqtBMIEWnS98FljD79EvOE6gS1ZaexCO1BFpVysnnI6swBIn3Yv0a1Mp8i7HJNZhwWv0HHaEorFAFMoLd3g83+M2LYqeWpHGCkallThXHG4bkhPATtNyqHgHEHNBbwNDgCGukc3Srr/jDzidreZkjRzDJhWR7rF2mRmRP6a2vSaAAnDB2TB3Pt7v7EuB2y4P72/9UupRdW7pskT36uO9zF5YRfw34N/4Dzn2uHgy7RIqQ2bKDroHPV5YBZSsbY5akwMuLCmmGWAqY0bIBtx66OmssQwbFKcGQjuCsYfnOTbSkvDGcAn1ANBqa8HnlEZTsA36OTiBJ/pMJPFCoQ8qaWdlEf6Yi3lG3tB/BwSaCj/Y7OpA4mSX4ae0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WyyBrzoVUhemvMHMCDnj3nZZi5cdYgg8Dcy1EhwG81kkKK4D7CNBok54spNJ?=
 =?us-ascii?Q?XTWHE56fW1eau/qdHWHo5II5qOjv9DTO+fSrNY5sExFQQGumJFGFQjjO1r30?=
 =?us-ascii?Q?2h/vncInGhMaF3FxUmi/r60NkWLZowaD2/51jHVifHdZDuZ9hGsNOygN1BLZ?=
 =?us-ascii?Q?mqfKvyZE+BV7ydcNSL4/xJs9jV+PeB0Q8mF7lqTlnIBp9nmBI74oG73bFMgV?=
 =?us-ascii?Q?Oefm3fmTB1/o8rQyKsM8kgD9SEcJheAecJA1/U2suQrHiYCXP/FV8mGvm3cP?=
 =?us-ascii?Q?TAppKuNNKUrX6AomqiTlTV0CKpz6pmAEuDJ+dONpSWR4oFplQKNZWMQqIxzp?=
 =?us-ascii?Q?9rl1THrdHvLHHFa7nVlLpAGwcmpOkCFNJwMIqkZYakNyZ7qS+zE38qeK50IM?=
 =?us-ascii?Q?CRUIHJv6DURF8hBNj5/l9HKY3raxnZOTytD6ivs74WeATo5l8N8hOHClQ1Yr?=
 =?us-ascii?Q?fJLSb/dtIwd3wNftIIe8WmYzDY+wNSc9sMgQdOETm2srlqGwbzkqOZDssLHL?=
 =?us-ascii?Q?GBlSjeE7l0rbgMARhtWRxdqxQSEdR180xO6i19FwIf+6RVAjNgWPPqrhkaxF?=
 =?us-ascii?Q?qoZQkiDAv4NZCk/8Kd2Ht1h0FqRwfXjrq2PVjWf+0JJ2BA+PDV/AxnMGf7U2?=
 =?us-ascii?Q?s5YwW7R1kuu7rGiSdgq8HZyoDbbiq0K9JtmvF2I0ssxPvwOJAUT56JqkMozB?=
 =?us-ascii?Q?RMkSVYFiKRgWSLZDT2Q8+cFu5b/d+tr0k4GgfKdhstp7U1uHrdm7Fuq+0Ccx?=
 =?us-ascii?Q?xTFq1R3XQ5EJtqRzILrKuBzImczm6Sw8QnsvNL8D7aPfl9I63/0BftONa3hY?=
 =?us-ascii?Q?626kRKj2luNBfRGhTRfEpkNwpSqVXly8SYOW/OGksuiAcy3Lxdi/IDlnBd0V?=
 =?us-ascii?Q?hnU4no8JdZDjRExu/mWS5jK1meFTi1cPLWt56K9G9igkLQyuuweNv4iIt5uE?=
 =?us-ascii?Q?6srbJW25HISm6SLSBx7urDugwB0uwlZapfuc7c+YSD0HFBjBsCftTDdK74d1?=
 =?us-ascii?Q?vgBIVJozgwZKVgPNosyFr1FmiLiExBMLtS2Lm+9Gr0SVxdxDAmvPjHmA7RCn?=
 =?us-ascii?Q?7vQcqc1K2fd+MS451vY8kYcll7wZVAvyDxVwvA21BK2RwCcZpfHMNVgjBnFU?=
 =?us-ascii?Q?5jN40LGvXXBHgui23T+A0BDFhbs8Sa/h8oU4g3WHATPyX/TnB/Bb7rOyRpCM?=
 =?us-ascii?Q?RaufLltd8fWlw4tocrwwnxSmfHAYgr0FwjjKt00FQxaqTnDO1H03DHjH74Im?=
 =?us-ascii?Q?liVGX+6QZVxbQa877aLvAy1cI2ykiUKEhL09nQ3UumXG8U/6IStJlBUkyQaR?=
 =?us-ascii?Q?fG0KyGj6b0hXmk/Y4GxlODpNBwxPHLEe3I1bygrUugmTdIPsyo8ZF7JUTJgy?=
 =?us-ascii?Q?Rh/rw9qcmLbjipmbyBwCegtr2rJqYR3aFn/rg2SUb9PwYlwFvpmpNwIqKL90?=
 =?us-ascii?Q?L71Hq4uC3tCe5VYOxapb5NcXnTE+1sOHmQjgfWhCM3dfM2q2Rb+1Z0nT3RqH?=
 =?us-ascii?Q?0MoUZk2oWRI400E0fT0GwrazUfurvoiXZfO5ngg/JFdLmNDILnvXnZ9VmXAZ?=
 =?us-ascii?Q?+IcWsUZ50AIy4jalHvKfcfP+ah1fYqB6JGIqbUVF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f501607-0b14-4311-6b30-08db9191658b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:06.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+0QLnO+I+IHhD6IwXQmbEQbww3iYZAo4PPy9oqogxj+1XJa2BOk6oCyLAbNTscnj/ZQtL8hcm803UMSgUYbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Move scu-pd driver under genpd directory where the driver
should be.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile            | 1 -
 drivers/genpd/imx/Makefile               | 1 +
 drivers/{firmware => genpd}/imx/scu-pd.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (100%)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acbade2a0..8f9f04a513a8 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
-obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/genpd/imx/Makefile b/drivers/genpd/imx/Makefile
index 5f012717a666..52d2629014a7 100644
--- a/drivers/genpd/imx/Makefile
+++ b/drivers/genpd/imx/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX_SCU_PD) += scu-pd.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
similarity index 100%
rename from drivers/firmware/imx/scu-pd.c
rename to drivers/genpd/imx/scu-pd.c
-- 
2.37.1

