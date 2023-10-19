Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329187CF2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJSIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjJSIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:37:50 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A85A129;
        Thu, 19 Oct 2023 01:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAYuyyqQJ/oZ9wcC70z19P41z3e82bLCwXrNu7DrAvEBumTDEMBRCg8VhdQhJ9mPuStiff1mnEHk306ZmPzVh/gUQ0iY3yzfiHsUYTWFP9RbptN07xLYGq6GDLPS1tZi1hzCHr7aM2HJ5VNDaByOTmuROaqkm+uarWaXwiQMc/z1I6G70mYpHCup0gR11Y3+wfdmy4PyNJPhxKlbesK3qENWL6rKt/p7w62CWrsIyD1p3XbrNP3K9Qk/ZwhOPPWSCPWlTmvVz5xZY+FWrbupli2szPZclSIOMOB5No7f2iaV65Qup7RqOytlmTiEFpJXI+40eKrC7MkYEmd9o6kTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB247QE3/hrm6hnTc1gGfSBroLRmuEETe6HECkNCIgg=;
 b=lauPAFB19xf8XSr4Z+cnUgEGmDLmS/PNyi17tGbT/dcN4IFMF+325cgGcB8c0MERC9V8/Nq4QNaR8hbBr0IS8CS27sLsnernIGE6MxO24TPhFGID+SzP/gHfDrgRnT4AjeCo0GZbp/HhSf7tJDNNPUppNOKb2U7CgxbeE6t1F6MiLFklmGKqiirKOu6a8CMi2wtVG8ckvWtpIpoXt8lJzlBz4gag+p3F5Y9zRwRoE1RkRX98FMb4KvJRu1Kme2P9bbjN0s5523BK6QQZ68Y9WrYu2IMca4h6u7foHUPLBrm3wdYKVMnavx1y5t7M0ek9hthTDehQcw/pGqWxguFfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB247QE3/hrm6hnTc1gGfSBroLRmuEETe6HECkNCIgg=;
 b=gN/UkIjQtk0mnBLFcbbgIbKxs2/WdmUZnNCnzZTlCPc7+6euL85o7vwE5nWRswFpDYqFI7e4e0a6a/0OnHGDt6lrrWyGICk5C/zbbVoGrx6GmUBXph+v9NQ7WQviSw0EpabgjNNBAq5sHvZ9o9vhXGbaH6Gh34NVfTluCKwRT68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 08:37:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 08:37:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, ming.qian@oss.nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Remove some redundant error logs
Date:   Thu, 19 Oct 2023 16:37:35 +0800
Message-Id: <20231019083735.10876-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS8PR04MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: e871eb35-4d76-4199-48b4-08dbd07eaaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4St3Wg4o5vaholA/JzWRQUsKJxy6TffB6K4Gu0WJ5y2a3JoX4tvuoB2dLlOdPknawtOXVJcCJp9bQzkZ5xnR3ZW2EJyrTXx5bWg2d8L55l/+MGJzq6MCyqV/MEPjeVIyu+vCtb58MUjRPK+7+Q5hCCIdgPf0sjVCLuYlsy7dTBLKRDxJ8li7+ZJCxs7hYJqnu1RkAgPbCX/Dr4FYnRxe7fwblFyXp23Dauu8we6hqL+T3K8cN0UhK7T4Qqm9tMYn9Sw2VHBMEYaxtx8CpcY4a53BEcNjAldcX2+NkvVKlB/V76kxdFig7HpqYuOmLE7MDwR/FmPahkxwp2p81d9vgn1mlozbKjZZ4IsXyoJTOJo2A4C6FfrBXeIlABjqfxRfjEV2g88jrdHYWdrRJdlwAzerd4+ctwAuuOI6ck/Xzs9pmxnGbtpfwN7Vfeb1TAQaHFJFGtsBJ3TRjmP0TeS2Ue40vt4uPEAZtNcULeBZcRhLr/UDyntOQWd/vSW2z2EVn0Fgr0f2LKPUepJptezbBZIi/9MpGa5LPTuIsx6vqdu6gQ6gYgk3vIhdJxhg2ZqZvFwoaH6bMs6knZpTddDiPnK5RqE2rqI1J+1tjt9iffj0gipcwLjMxI/oSSEk4be
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6506007)(86362001)(41300700001)(4326008)(36756003)(2906002)(38100700002)(1076003)(83380400001)(6512007)(26005)(2616005)(52116002)(44832011)(5660300002)(8676002)(6666004)(478600001)(6486002)(8936002)(66556008)(66476007)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZT8OsLAhhLfdcx2dgk7aN++773y+Svp1G0HBs+5bdcjijfcBMrVT5kAbMZ7E?=
 =?us-ascii?Q?6wdHDiv0tNqGmdrfo4ed8NPQSmzz2nj4ALKud+0QT6BsnYfl9THq6QT8bWal?=
 =?us-ascii?Q?tvKts7vREl9tqJ2U2bbdckfV4gdkfJN1YVdxmOk6YGKZy7PMs12axWt9Tq5o?=
 =?us-ascii?Q?WDKkuQb762KeoBj34Ugbesi80McdGvwb+qsoTmWhxVe7GwUwojBhLB/zHNXT?=
 =?us-ascii?Q?19OdA88xMUL25+ayDKP7nnYxPrWXvxBhCX1+W3LWjUI8MR8+UEnUxj5NuBCb?=
 =?us-ascii?Q?ZolgPHHqsxSeY/UNaZAHn4nPXGUV5H4Dxu+qlqivfgr1lcz7p9ZKaQRw9J1j?=
 =?us-ascii?Q?nIFx4vXj2wO/rU6wiy9RftClsj1a2YjDmKq6Nge7bw7crTgMpxErKDCm7k3p?=
 =?us-ascii?Q?IIrfKP5Ikin8vdHoh+UAEH20yyJMJhpsuQYPn3TyFszt53N9e7ILk1siw45V?=
 =?us-ascii?Q?GLwKjNAaSa/7mkX5UfOmrwVD+YbTTH91HHz3qW80pkAc3fufE8hV8cp7sxwT?=
 =?us-ascii?Q?odnNegNXCvNRUAAOab1NAgNPm97q+iKoMcX+WB19jvTnHgPI+dlkGpkDDl0b?=
 =?us-ascii?Q?u38Ht5dg9gHz5Uns8lCmy2AJC3EovH/9IGzkzSZbmCEnvKNhCIFK6FI4Winx?=
 =?us-ascii?Q?TBnxlYWNNx0+ClXc7vBpAd0luS9Fu4bEeo8SFvWRe8sv8pCx/uM+RkzRPPB0?=
 =?us-ascii?Q?xo/1/wDX+aZZPI5Yn+TZWqLSvyimaU6egadeyiJFl03oxJtP+cFO2gtijspK?=
 =?us-ascii?Q?nwkhV9jItSmabTI3LMGNQhToRX/Mmwv/xrjbdDsz7c0dE+gaE+HRpCEKtJDE?=
 =?us-ascii?Q?HnUyBrLcpSZsU77f0lPGA2HZF3XGQRlPU5iFDxfNzcJiZeKrn9ey9zN8QW3+?=
 =?us-ascii?Q?zJli2sUSV4+9bekE0RvmgP5oi5YngFW2ubklCq4yzskHZtmGSUyfVvcWptcv?=
 =?us-ascii?Q?x9RannHqKqbdZxSzpiuxp0dgKl+r9o0E3RJvo5APXmBuEHsO/lazlwnIcXnM?=
 =?us-ascii?Q?1zKsd2bR2L5T9WHXDzkcaLisp5yl938OJ4j4Xa1LniKH0SE1n0c0CkjXtHaX?=
 =?us-ascii?Q?gHfQOZvSEnuJZc+OqxZUCOGwd3UcGZsEABd8dlMJjrdaKSEksBdQivSSjHvK?=
 =?us-ascii?Q?X77/cVpdBo14CDiys3b8wzN8U//n6rV/qMyjAz5uIbqhuKumwCXa511RfFW9?=
 =?us-ascii?Q?5rQpwjEWvAi9wyCQqvIOm2kjv7+AqglbWUmNf8rm+TzTQm2RLJEDWmtdSU2t?=
 =?us-ascii?Q?FcLUHHlm8UXRS75p3wt7HcdX+9r5i46IdegvOxKShQxrsT3Z25GnoJWlIAFB?=
 =?us-ascii?Q?KGOanIe0aH1odaf4BjAuM4rXW83qjYVkf268lVmEfHzj+gj68PXwJjmwX51a?=
 =?us-ascii?Q?kpzvaJ0RzrlcyjuJXEXQ+F9iFyX8uY6ruhgz7rvNysrElVyYIkWsjihBSnGp?=
 =?us-ascii?Q?Y+oRaQe9j2wBQ6yZSuo3wGrm99s9WvpBSrjtVLfWAIWvCBVuxtv2msG6cmep?=
 =?us-ascii?Q?XxiB+/zB/EOfDGGHCOm/GNIg1dJKJGXn69du+BocLjV8+XmwpWbhAKiT0xiC?=
 =?us-ascii?Q?O/NgZUrG99cBkBwS7HKw8VwDWo7uzr9SEMZ36yqD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871eb35-4d76-4199-48b4-08dbd07eaaca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:37:45.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdq8+ZBdLJUbSret7HtkzpuFEGAgWubybUe0MQCN5vRGky2dMp2hdqbKQBxQPW8NlTt/VoFmeGSgDyi65bjMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the picture size parsed by decoder is different from those previously
established, it's a normal flow of dynamic resolution change, not an
error case, the log may mislead that some error occurs in decoding, so
remove the error log in this case.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index c87603cb4a6f..9fe6424758f8 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1827,17 +1827,6 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 
 	q_data_out = mxc_jpeg_get_q_data(ctx,
 					 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
-	if (q_data_out->w == 0 && q_data_out->h == 0) {
-		dev_warn(dev, "Invalid user resolution 0x0");
-		dev_warn(dev, "Keeping resolution from JPEG: %dx%d",
-			 header.frame.width, header.frame.height);
-	} else if (header.frame.width != q_data_out->w ||
-		   header.frame.height != q_data_out->h) {
-		dev_err(dev,
-			"Resolution mismatch: %dx%d (JPEG) versus %dx%d(user)",
-			header.frame.width, header.frame.height,
-			q_data_out->w, q_data_out->h);
-	}
 	q_data_out->w = header.frame.width;
 	q_data_out->h = header.frame.height;
 	if (header.frame.width > MXC_JPEG_MAX_WIDTH ||
-- 
2.38.1

