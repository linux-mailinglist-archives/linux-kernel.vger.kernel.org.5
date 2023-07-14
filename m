Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E5753608
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjGNJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjGNJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2630E7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyyPKSI2iaIaFZ8iOCkUKAuOdQakPRJ0CdPFMoWZCGMsuhXviRdjIDnaaont5a/eBFvVpz5iLGER0KYVoexkzeGugJjwn4+vOhiQlKwLZ2DIpH8sy7IGLl2KoJeDSGIha3PGVeJibcaR/gxNEYWGvf4Iek+0rdkgCb3DjL3Oi0yJ7jrFYj3otLs8l7oWEXbyXPMkO9etbcErX0m9yWUOVC/rX7QrsOBc1k0K19NIectgkN3hY+51zLjtt1BPVBAJz9/T10/TNapHXX/JJxHKkQuzsHaOggxm6+iqTj1sayHZQq26nxSpa58lcRrq1Y4J3glkEzQGHdThIa6yoLSY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GiivpDlMbK2t5no1+wIhaSQP00VKPs7OxHZTRhK6tI=;
 b=A58E3RsLlIhXPZrnH0OF+pDXba5w7xKgj8hJrGD1VD/nEBkLMZ/myd1vNX+E+7zxWKLimayMUkcvFzxg+KrjK9Ki/xu9gy3WqybvljQnXsSiRk4+zMqZ1yKUWcrjNQgTcndw5moLCaLbsN8TJET2Nkcd1cm2CK0v889gekrzaDH1OpAAwNWBC9Iypwf86vqV8/wxDX3hqj+OrhY1fIm2OFzSUBDQa7sY5tm4NE7mHe55I8CJrjLVzdgRvZWh6ecwiT0gZMN5PUdoNoIvJO6jLqhejPRbmPpKLxSIIc80jOlK/5sRbWnF6M5MTiHQ8E+Hn3lkxP7jY4zygpA5jws9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GiivpDlMbK2t5no1+wIhaSQP00VKPs7OxHZTRhK6tI=;
 b=D5/bYDpmTp3iIUsa58UCtFg3vYwm6k6hLjgoOFbghHaIO0DTOzvy6/lcSYrhHcHUiMtMBinon/3+UxkoDlIyiugPhgVNHkGt8Nayr8XHB/9AKNYpZAKfR37S3pWlN5XRABrTwC2H3dYtMm3XjA+NZmKZsStREMxUnf3Wo8xdpV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 14 Jul
 2023 09:05:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:05:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] firmware: imx: scu-pd: change init level to subsys_initcall
Date:   Fri, 14 Jul 2023 17:09:36 +0800
Message-Id: <20230714090936.937344-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 566ecdda-e303-4c64-46db-08db84497124
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5dVqFU7gxw1EUuuThM5+q0KaglKrCPRp6EgRoaKSzi1QdrUVmHRO7pzGcpk56hX+FC8Bclu/PETmLj2QKG56EEQAa3up9d3/m3xsm2FjQGkcWHhZ9+/elfwS7H8eSKA0Ctw2nFRbSjwVzGpS9kNXZHjk/bSVDOqpuPyGoJ8T26xylPfZrIJHgNIC10vjDQR7DL3Q1s+q7Sp6+DsSJVu8UdPnXXRuevpHinXuJWi83lLz0Ne/k1PUk+2KV1LG04JQBmam7lqXbvtwRg+JaBRfMPuGpgOwGWvmUPJBK+O/uxcLON2HHtG3jgF8DPKAewz1DFZ7c5VprveZw29s1Bmd2Hc6IpflWuQnlEGc6BC3jOdxA876MleuWrD+EGC0GwskB581VdbKC0S/dAjES8MTEKcqPoeFpCLlyZJqvj1Ffc8Cj4tQdkNUW547X5GwLM65ND9QCSHTgegpOPUKeKozV5zMnFaGIhV7Z0i8AIjqZeNlA37Wm0yrF8/3ax6LZjbRp5IZG5YkRb+WJhLcVlEIBPo4dTQZXk9WaQAVzr0o3MQQ9KDj/ibyBuHZccnmvdzZhidPhDLKvGOjd0q+gp0y7ZODRw/HdK6q8oEhQyOfrLsskWuLbI7ECyld9HZV8Tw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(2906002)(4744005)(41300700001)(478600001)(6486002)(8676002)(6666004)(86362001)(8936002)(52116002)(5660300002)(316002)(4326008)(66946007)(38100700002)(66556008)(38350700002)(26005)(1076003)(6506007)(186003)(66476007)(2616005)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?673mf2zXoZO+2I1deANH1sfHhRU2jol1Z46naUrqE70i1UOs0RwiGl3KPr8G?=
 =?us-ascii?Q?NlmLa209iKcHjxLAM7nTTKDpMvZTYbzwAMz7PBxDxsp68yUOcSETyDkZrjwu?=
 =?us-ascii?Q?zCPEGnm9bkcU6jlZECO6iwEB9hBko8WEVI3fXhipR/h9bYW6m8S4Mfd6A+Hr?=
 =?us-ascii?Q?zF1SfSOO8DF6q7ubQddOpR8z066Yx8vo0WOg3N8Dai97uwPj2Vc0Bbx3ATyO?=
 =?us-ascii?Q?hCDxUlrwdkKg30cYxBljT0XdNabOAWmnS1HoXnzpXd2MeD709adL4E+5UOo2?=
 =?us-ascii?Q?vhwVKiOhy2bidKuuz1vylzSJwKSS16RAR5/K/UgV/qeEpwL009KhlFOyPs3R?=
 =?us-ascii?Q?zS7zW7qtMmQdfj9MsSJtaU67AGq7tKA8trBj6xn72rA9tNDJjnDtvewamTnr?=
 =?us-ascii?Q?YzuZHCFOlSy7tdfJnYh7C62/zXeUnvnX7R8MDa51MOQQsvtqQ1FlQ8uLop0d?=
 =?us-ascii?Q?A79VJYZKqknkkJzng0RASio83IpBx+BGA1bqfwqqMf0+f00RWg8UyEvYjzRr?=
 =?us-ascii?Q?SsCDVc/lmAqqBQhRYZdAf5hlXpzJdTR/r2EOTaqOy1qbnXMdM1eqPWZq2lYj?=
 =?us-ascii?Q?ms9TubzQhDJcGePjdPanD+QTYy0inzt609UADTePI30tmkb4Sdv5DngAKrL2?=
 =?us-ascii?Q?HnQhO1LJcR0jpxoZttS3XaaZnOFwThIqr9MaDOfGe6zbgy80xdYPMRRVI3/N?=
 =?us-ascii?Q?BEOGwtgV1q9jMTu3qRmvMVU+RNbL1l58Rog98NJZW1KDmfw3iBiDcnQUalOG?=
 =?us-ascii?Q?4DjO2fgIYoJqk6f3Q70YVZ4HzBGxaPngc/PBk8+irzHuHQe7qS2XUN2wxNWj?=
 =?us-ascii?Q?VaxOn6igkLqZGiBh6fMRKah9Vl/+4KxjUmEXm55Bs2/d34X18IjzhSgmH/VM?=
 =?us-ascii?Q?sUXdVrT/54C7Yj2y7n3wIcR2Q4f+vtjxmkSLfCp2MCVlBgaNtfYZK+e0KhZp?=
 =?us-ascii?Q?sLT2swsoHA8cLo6ZtTXra00NFnny7hrPgnextUTmGLLMCTk+2L7EZG/QAbNT?=
 =?us-ascii?Q?qkJh5GyykyOJgiq2XDqfm5a9uR7/AkHivhXEdl30H/nPrpAFUyZhKbhdePU8?=
 =?us-ascii?Q?rZlApsi9EGY+6O9PTGAUpsUQfKK+W3H/AEoFr5e6Ektkhh8+c8MYOTocrPXn?=
 =?us-ascii?Q?XN1r7GYR+HgXoGsyNotlT0N2RUeRj1JQks2nD0mqy32pd/bZLf6lenRZ2Qu4?=
 =?us-ascii?Q?GlOjEUhyg96ihzmmA1ANzh0IMhQh4vh+H2M5IWHYpt4EskNOZwctB1gqSg1H?=
 =?us-ascii?Q?1WG5yvjjM4Wkv5fWfE6yDUeqHFLEAm2/j0eq0umeKGsBO8a22OH1jbe6aKbi?=
 =?us-ascii?Q?CXJnSSxyrynz71MfpBozHQBdGyCrzmZ5jGOlUPAMp7vcKrRXoad6fg2Vhj+0?=
 =?us-ascii?Q?hjUjx1BQQahHdH4erxsejNYvD71sJQmpcfnXn54yBADjVl+a2ThHzSTVuREl?=
 =?us-ascii?Q?NbloV3p9KZKPTVLuOyIzTsDcb2qcdAreRdOA5G9fX6uK5Ivayex4SjKAzDel?=
 =?us-ascii?Q?pIvmiZIXa4bqs8xdXjBG/Y4soOIB+8PlzL/H0aFWmJTJwV/FUSv+2v5HW7zn?=
 =?us-ascii?Q?wgEIuHdGGMT5IKMlN8YwyMifP7q9dnVfELYVGjA7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566ecdda-e303-4c64-46db-08db84497124
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:05:17.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTOgqQUT5lCSXmAtesQlFS3Gy51nJvshLvmBDnmuVJ3dAzlbcAAogvMmfWps5d5PqmjoxQFf2MzvhjgLEsPRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Change power domain init level to subsys_initcall to ensure it's probed
before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 31de56366a50..5e6dbadb43ae 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -587,7 +587,12 @@ static struct platform_driver imx_sc_pd_driver = {
 	},
 	.probe = imx_sc_pd_probe,
 };
-builtin_platform_driver(imx_sc_pd_driver);
+
+static int __init imx_sc_pd_driver_init(void)
+{
+	return platform_driver_register(&imx_sc_pd_driver);
+}
+subsys_initcall(imx_sc_pd_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-- 
2.37.1

