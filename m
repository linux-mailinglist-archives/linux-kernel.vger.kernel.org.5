Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8277B6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjHNKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjHNKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB012D;
        Mon, 14 Aug 2023 03:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uok+Wr196tBvo+cgyly5jjwxuA1ZOVsltyTgpzfejNL6WP+p5ydVBOsVy5nxQiIZQes5JppdtUks53xFbcHrcyMdd8PCFqv1xkn+v2kQlJYHPLWEOPTzgFDWNlJF2FPnrscB52vIYTAaSK4JspuvFtA3AAGE2nj85j2X3mbl/fZ30cKcsOZQAzVgL+YyOXzk8Oan4uoc9ptwh6r28mZni7PbxxrZD3JFDGcRfQQV6c/CNn4ivaSxEWhYXSteMzkmBWI8JjVXzV/xwvvcVEkEo4Zu7Y+DCD/lx8QXXIbrFBrpRKjsVidX+KBGylUlhRl3A65JVhc7T/gjRfL/OeDISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egD3H43VB+M29WT3I9pdzG/iYCx3+8lbdwgTclArnN4=;
 b=RydN9DHxJAfRiLPrbzI9/kFy+Rb7jLxwO5MktCSXDJNFnJ/qZzlnIh8EfvkrzuKU0aFjZgYKJd5bX656xZDRVG0KEqaSlRtJ7LdeTDf18mcNjWWxONH2Eby7k79MdH11aczGkIKxK6J+gPCJlpLElJ+ntdxUBqj/22/SW/O4ye5og2TDKqvB9XG/4Gju8WI22OwM52+vNyTwaDlVr/p8DyqJDiPCKGHXVKgStyGZ6LBuFQVdFet/KoJIgH5VlPYrCp0U3BETNHEZNofXzxgkxzqc0zkpFx9QggHrBPFvOV9jlX6e/wMJ0Yxc4zI0JaNWBDP/tGz7iSpKMZEs2VRpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egD3H43VB+M29WT3I9pdzG/iYCx3+8lbdwgTclArnN4=;
 b=ZvwjZmgvmxUtDHoqK8IfD7WV4JaT6YTnkusdejOqSJVaZ5rcdIAkLrHZKeATXeKdtT3Bq5mLgXdU5CE3VE6HYB+tuyyManPfIS6tkkgFJ641HJkg2/vCJOaSYgQG4yhQHeTHdjGsLfefBMkOcVK2ky+Np7PRQvhHIdqJb4MdQgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/8] genpd: imx: scu-pd: Suppress bind attrs
Date:   Mon, 14 Aug 2023 18:41:24 +0800
Message-Id: <20230814104127.1929-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: cec30aa3-ba4f-4717-1531-08db9cb268c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKyGAR2mY51PYFLY+Io/MySSkSYkz6P2rRt0QovEP2ijYi4oYUPgxmoukakEwTZR3ZaaZ1rg6Bcd1GA2Bcgc2xq6IfbeEH5lfySETE/VnZeSlU+qRBYUjpYCZN4vQWyAkqJcEzsPDiEy2Xaw6hv0SLs2NkFH/EXeOLXFlpWhlkGba5amNT1eNRZeYuZo0iqjxUpRx+gBfRHe2OZWfViVWJN48ogA9vRY8yT3WJw6vYb2N0/5LiCXCYC+rvVTLeG5RydzjdReNg7eS0wsFSk+u63TfnBdhd9dej+sGpAtImtJKAL6NKp5laDaUC4jAGhT2aQhuP0fddJpLQXP84boKOWEaCKR9kly+9W0UvkW3iNy86gtihT6x37RV7iterdJFRo59i+z05MumeQJfC2NrzA8j+bTuUTJJ8A38KXrK7IWCWk7ebm3+/tyue9NLRZ45iyawJP2L4UOknE2BAy9smEFHK9l5cZCCd1fPIfwW5s87BX7NUkNT14L1kesQcAJsVxIGIKQKRIQlSzuJFipMUUggp4R0QUKdQNLPuE7dIlqyCBGrfbvgpZyB3ttaH4F0QljQClxswwcN2EFJJuaufaOe4+INF1yABpdd/UOXO3kXI5xfcB90qakgE3+iqaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(4744005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eh4UHQM4gK0qOhptoQu0Z9YCnoL0C/jnURKK5RDR7ZB0Y7WMIRLV7fJy3nmU?=
 =?us-ascii?Q?HbHinzTw9FNibgthvrS6H2JcDt5v7IfA5Yqn2wr9Pi6Nvk6zeTREAa3PB4F+?=
 =?us-ascii?Q?pyplwCYaGvgRACSXyaLmrLo/fSFi5NqADC8zb7YTr6TJRAqqt7qa8+8N92pi?=
 =?us-ascii?Q?4Fpe99pL37ee2Qi7W9Z4qsLO5psrPvg7A41pPQT3EkjMFBxwlGQnBvPXZZca?=
 =?us-ascii?Q?i//eRXieKWbHDil/GZ2O2iwGh7aYXkxlpWAwt0qdMD2v8rsbjZNsGqAyVuIR?=
 =?us-ascii?Q?tRQRsL9ParMHRBXgdyZmrOYiLZES3TXGfQXL3zsrCoXrsEZi4jDhbVejCXQZ?=
 =?us-ascii?Q?vUCnwNfKewH7HYtgMJ0RohGFEkLNY/TjPR6PD5TthFMvhuZMhLbsZYvpkACD?=
 =?us-ascii?Q?NbVOa9DlDy+nsqoUuWMH2COtFwuc0Og/H/F017nE34Ub3oYAINZ0o4p5veEr?=
 =?us-ascii?Q?nE3PPA9Womgh0qao7Nlo63Yl1DlH/8gw1qBxGLtIDsBZjkQpAnSl/GGKALTD?=
 =?us-ascii?Q?JA6Nyce5EvaX7SGvk1azFzBFh2ibBw2K38oZt9G3Ixtyo0nJuINmo/VgOu46?=
 =?us-ascii?Q?1cJMG2pbLjGQ2YYB/T8EFvHYqdvGvtIZdPvTu9rvuRJHg7eTx6Lm08MIlIDJ?=
 =?us-ascii?Q?QmpfNdGhLZpE6d0hrZYe/onf8CiKZWoppNgXW/1VBUwJyFxTOD2qthylfM0j?=
 =?us-ascii?Q?QGE4Jtp7HZwsb9TNEfx/PSMRA3MCpkDZMJiULv4/pQxo63K8+Jw0lTr5HTac?=
 =?us-ascii?Q?b20T+p8XAg4wZSimys/CztTm4dYLDSy4I4EOayHnJtbaHG0xP2oteWnyfaLx?=
 =?us-ascii?Q?d+ZhIXNXfxL3AicUaaOOZxLTTcDUClWtqfXHxWLsHgfdhU4jh2Xx3F9/pc3Y?=
 =?us-ascii?Q?krGrLdvQJEj/qoWXYKfF/iAzwvOMvKytH3tiabagWupWDm+GQMpLtdKUtwOx?=
 =?us-ascii?Q?M35yo0YlirbwTEl6jrNnkzLP8v6tpNc8KLoiljifPaCRivlwnAn1s6GvIXBg?=
 =?us-ascii?Q?mvD4EswCK98JB4lZQVCir74NDjHt6+Mn3TgsSMdC9a2ew4Fyp5Oo7p3SLdG7?=
 =?us-ascii?Q?YuDlaCbICuTsQha/XYSyP2CEo5s/l/zyFlWG2Zu3A2bm9SPwwveKq3apHt76?=
 =?us-ascii?Q?tlKAmS7fAig4TlkmDstEdSv3ahVxzTDdEyFM2mvmBLG/lCZGcAXLNA+PHF/h?=
 =?us-ascii?Q?qvkvmNXxcNDIZzoTYQJOKIPz/8kzrxuL5IedQtZM9xeY+mGA5zZ9gbaO5EEr?=
 =?us-ascii?Q?cx8Lbm+cZ02Oj3ZVjQtNs0AhgANfWnPFYMZV7ABsU+mbb49b+67tdfSHNejc?=
 =?us-ascii?Q?6RQx+PF1jGBOaqGtW6d+p4Bq5EUeZEFVsIaddNHZgLirYP8917hj2ejdnNtu?=
 =?us-ascii?Q?cR/wQzqskVOlFJY5InQ+Lk1LcCV4RG1Xd7UW9ACajSDbaJYxDQbqj5fcNcIz?=
 =?us-ascii?Q?ZCQI1GUWXJYzCYY558y6X84Ah20DrjYGUfxkadX33mRGsRBImJYQMFnF9+c8?=
 =?us-ascii?Q?7uiSqrUc9zKFaD73ZRCMi/Ubg6SZf5A1iOj6fMfdUtqe+/T4vinAzw4lpu2X?=
 =?us-ascii?Q?n1dbUsoUVR9b6Of9BH//i/uCjFMsNGdyLmc1Qs5E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec30aa3-ba4f-4717-1531-08db9cb268c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:08.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ4yCzlKrXFkTr+uyv4wr2t+CkSbreK3Y2wvgdEHAmGRjcHFX6DJbHY9ZAgXfomBQjWSCHGCt5AFpbvFSHfCAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This driver is registered as platform driver, but removing and binding
again would cause system not workable. So suppress bind attrs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index d69da79d3130..fa840ebe38c5 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -488,6 +488,7 @@ static struct platform_driver imx_sc_pd_driver = {
 	.driver = {
 		.name = "imx-scu-pd",
 		.of_match_table = imx_sc_pd_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = imx_sc_pd_probe,
 };
-- 
2.37.1

