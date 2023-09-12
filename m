Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A317979D1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjILNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjILNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:12:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B010CA;
        Tue, 12 Sep 2023 06:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0FYs/8PT845/vmsp9klKLDKob9U5/41hoN6mmzY+kN9ujUBRPutZMvGjli7PdHYJ/bw66eP1CWSl7I2dFV1TwLGITrrvfBws79ZF7Axzg2pOgnzQlT8v0ILHNgyhATHTvtUkrerdDu8eZ8B5e3bf4yoXbpfeVZvzqVJqgks21gC5DG7NEHosSlJd+FYohK5lMFYsfKz6L+cNxlQz0j3Hwdnlee38z6LNB27GuAyj04rZEBOXDOqPeTb3eQVoGwlZ/YGE4/PF2DZi0H84qGiXlFyrZRZpYDPWHoNOk5gfOdgoTRWcrcI8pOIj0Zi+CDPnnzNgtfCZUTMzSKBoqUduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgMLgWSwF3aXUq+tK1GvxdjjgKWz68rrcAG+9mh5DA8=;
 b=odd6bMtTlUVtRVWCV5m9HWsRL99bAcYMNSpJWGI47bfkao0rhD/0sFcln6CF8JQDI4SUPhPEQQz6VEgF0/JmNeC2Xnp9bnPe5m8jEoGn2zlVmU9wKOP63oQpmd+i0Upy5BWq1orCgQVRt2EnMKRc8uMWpPQKlEUZBiN4Jz70+CBzKpgK+Ll9UWWWbEG9pe6ix+e2yyZy2bzCMdGbfazo7XdQbLXbO/FDjB8e/350uuzd75dgl0g5sBom9BS5VE8j0VAu30Kl6YDI25HPDrx68qj64Zczrq+c4Cb4GIbAO2nhj8a8QEsshJB39CaGmxGJjTscLVw7QK9Wc8MExXTSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgMLgWSwF3aXUq+tK1GvxdjjgKWz68rrcAG+9mh5DA8=;
 b=SoYOuIEyA/NK5IV3O90w49mwhDaNTqnzD4PvqHdUNwE6EyHkbzyFbM2Ak0MVo/xQRFs4R1j5oQZqFlgex+GrDfDfJw3F8OeE/FSM+L2wXgU351Vkgu95jhYowl5X4AKE3qlK8Fh4PBdNIGmDlwB55cmMFlRdthscuBsryZ+WCJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:12:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:12:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] clk: imx: Add 1039.5MHz frequency support for imx9 pll
Date:   Tue, 12 Sep 2023 21:16:46 +0800
Message-Id: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: cf55f7f7-8118-4373-f9a2-08dbb391e3ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiEMziSCUYMDRjceD7Qhv3JMNmNw+PhxOtq89CPIfSiNraE5/eLRn5Go2wj2gpLFQeJUdoZVqpJwcIERW3s4va1mVlboRfW9S5m92YGdbdOsn1gBgaF8k4NjY7XN+ZcDKypp0qafuT3rwdSXXw/Oo7utbsn7WRg8yhmFO03JSvg0YqErs/uTPLhu2NrLxPyBmrJrS4N1ghHB2IELoUPZOezbZvUsPZsH3SBUdVA2FXs/400jaKqvVyYgMcQ/H7FShaMcSsZjhv6N1JMw4AbyW5ddbyFcw8q/61l6RucK49dLh9khGPGVQfwLkbPsfSA47dKP82mRef7/QHS3eMVfmFrYMvAQRlwIzTaUE8pBzOYj4C5U2TTnuhgY0fBn49GkbCurGiMLLQnDTitzMOf1lD0pLZa9hTdLY4wmmDN6xMoYVUE2axpcW1Hfz8kidtjuJgVN8qzWNr95ZJTg3BanZQVcvKNURRJ9SaQYsDek44wT1V19U4KOrcR2vCS90OtTj9Gm7Hx6kDIWMotTO+klvoebCW0WypNu+wtOVbfAFX5pC9IMVnIsNeDHYYHnWTtbgXt7WPu3DgbBqsua+FC7p7QJVq8Lkmoj386dVfrJLS99UavbA7gYsdLeEj+Hn4yN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(52116002)(2616005)(478600001)(66946007)(316002)(54906003)(66476007)(41300700001)(66556008)(86362001)(2906002)(4744005)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6lpO1zx+NzyxXi4DomsDidxSXLwlSbYLQfm3LymxT+U+W9QdpBjxuKqe82U?=
 =?us-ascii?Q?ywwgyyh5jinZgGrcIxRO6p+vif9RRccE2U8unE36z4kJRYF8WQShEULp56QX?=
 =?us-ascii?Q?VKFcmjUMJUhbY/Iz1IUOGVW8KNrU9qlyqH02MA7FrDszPjNdIXuhm1qprqIF?=
 =?us-ascii?Q?T55Xx16R04Tu5GxIkvf6rJOPOVR7LD06bjY23KQQTdDNki8N2X1VggATIUPR?=
 =?us-ascii?Q?CG/0C4KgJ30aNhT1qjC93oH4xqFsz+KBQxYA9rnNdzM2e39sb9i+tsYgXI7i?=
 =?us-ascii?Q?66YHr0zw4oA7XFaVU39XOqCBF5+CfK1mY5tX1VplyF6echqFzWTWV4V8PulR?=
 =?us-ascii?Q?DYmELQra3dlQxPm2+BziFfUFvuHZuBhDPwcs2lfB0DDlPlDLFLnSOJ2az0it?=
 =?us-ascii?Q?P8wIjHOI0YQQx4+jUJx8HdKQ3gi7AHxXk1/d2TzRS84YrZnAr0BtbU+JGiVw?=
 =?us-ascii?Q?7krlj26Fu3Flq9QvU7mZwyBI0wPUpLyiGgeGVL6iveHSq837YRY04WBOrDDk?=
 =?us-ascii?Q?rTnjI94VPVkYWmKo4fgd0Ljl/dLHTljM9qej/eqHHk0MPyZ0kJigCA09m7Rq?=
 =?us-ascii?Q?FiNWLw/HXsQaVR+Nh8t99ItLWDTbyHo+ndxQE6vTnZXXDDExP3jVSNpwU0al?=
 =?us-ascii?Q?VwaWj1SPSqlVZLLW0X4YG7ACt32OodDNADo6XtgUyALgjH1w7XfHHrf3PZgj?=
 =?us-ascii?Q?NbmCZz9Fxu42exgRu2eemV6HYXczePDZNMvI0hvgeNEBtBaX4bthcGdB2Qbj?=
 =?us-ascii?Q?iIGwgA7C/Ii5bNlYF2Fs5Vt+wNqefp5DmtDZ+XeQym9gRWTItcjlO4f8A5sn?=
 =?us-ascii?Q?d0xzMf9MFlj/IL4JaBlgek1Py9Fcb7w4D9am7esy8wTj9fyYIPZta5cpyctp?=
 =?us-ascii?Q?OBbjYabhLtL2FvOOa59k1M8HHA0NT7dXvczB0FuvKwxlB6yN/QWp1npGFz7P?=
 =?us-ascii?Q?jj25dvN62vyh6F3w2rwNCoSqH1CmNe9ncGxSlI5B4UG78KcbpCPyOfSWUOiU?=
 =?us-ascii?Q?Ggr6GF6uoPbzK/pKdGF9zGtAJoqKGe2j9hZJHmObSQzSN94k1l6ZlumTGSgZ?=
 =?us-ascii?Q?VcYitF/S/49kIEmIErLGos+6Okx58aVixucTKPO+MYJHJ+I+lww6nCe/e9Sk?=
 =?us-ascii?Q?6KKN0eFd7lTPJwX3geMvwgoTV8zPVZ4hvCIrvdwDWCkl3WQrrdd/3pH6lvS5?=
 =?us-ascii?Q?tkcd1CRPzaKKBkRwvnbiKgRPrjonSkDVDiE7vjfgELWP2/h7CPnyv5JXunji?=
 =?us-ascii?Q?MPjB7UgdvThIWlv9FExYWJLVMKV3vZLSe+KZUoUt3ysdcEwSUF0egjFxaDTp?=
 =?us-ascii?Q?uNEtkkelQ1RqCnWBXiqW4wLlQadpvswz2bTPIPRFhJLtLj/1EsPa4dvwxyEU?=
 =?us-ascii?Q?JMSfn0BtzsKlSruGgBZn93oHCXqA6gcSheKna7skMg4ufAkTaxXMV0AuJLlj?=
 =?us-ascii?Q?1ZtzZrhLXVHo9J4hAdZDmHXhWZH9ioVaAgHO86dSGIvdHWnrdP6L1+TagfRt?=
 =?us-ascii?Q?6H5s0QZRCE061lugw1ZJGUdj2zV+hT/BdljBrhRiL8fP6XCqQgmjbOx3Rt9M?=
 =?us-ascii?Q?78Zjg8w+Wz4+eINjaPPwYdFRvL5APuwEp38OCu+F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf55f7f7-8118-4373-f9a2-08dbb391e3ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:12:18.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2KV9vQSmYf6eFO5P0zPTd1gBO32bii01yVQeLDBnZwMgsQnBfPM6BpaTja/XsYrTwvWvBCN5RlVrx1bOkDeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

For video pll, it may need to 1039.5MHz clock to fulfill
the LVDS display 148.5MHz * 7 requirement. So add 1039.5MHz
frequency config support for i.MX9 video PLL.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..96105ee4d9ef 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -78,6 +78,7 @@ struct clk_fracn_gppll {
  * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(1039500000U, 173, 25, 100, 1, 4),
 	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
 	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
-- 
2.37.1

