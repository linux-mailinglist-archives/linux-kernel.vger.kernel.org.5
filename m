Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41975AB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGTJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGTJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BE3A99
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVT29MBdrAeZS1D1RLphqLQwRGgwwMVi/RmEGCHm68SYKvHTQRUczb51j2ofk3cSpTl5mZKFdV2Jm2+SsU1pkyXpGWqWBhb//8lAGPuRzokTsgRfyxsnBaRYF7t9Q337WE8uVNK9Vx11YDp7grOBB/EABTUL9g8B46bmvMBAomx80bvtystSvwkFeL0lqu6sfLTKIIt7/m8Z2bGgjStp9gKhmdjK7w1mQkTTutFN2yyzR1FtBPfJeKgmT+C2Mb1+IpZbNzoTOrlggpL5i5rW49ZkxodL9RgUDtUjwmlYWaKBA5gsdf2vWugQvGoIaJuuMXKELV4IZubpjCrG+nCD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=SJ94VND7Cq775JJPh7V3O7DDo+z0XNQdSF3K68c8RBCwIMYusK5x76FQ93GqEocb8LaqEb2B4opWIjBYtk6g6whEI9lCJIbiKop3xC73Tv2qYUNmlAwloxXO5dvpemewHk3/UdaxCgfh0sn/OlNAfirBSiddC83EelPZblgfxY+k9o6Sf5grB35rQac4bGjpid+/ud/hClUuZfrsTSQ1HYwFP4w9c+wdcdM4pLlDKfUqJwftMWaB5qJy04Sb7qXk5uP5fks8tqes1XaE6raqJG3DXRU5m6P232BSDBBAtvwusxUGy8QS0JnmhsRQbn0tttwpzhRWEQDtPDflsucCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=j6kMinNTRomikpVSSDfBVjq8/Glp9MZao/FMDPA1jVjqMXe2tva9HKH5RMVIo78s9eN7xJKSuD70utcReInn6vmUoI616135C6C/7vrXkfFKKJwYILXBkouMG6JLcsTvqeAmWEilkGIGEop1Ogdjj/e8QgafTyWkzAskl3REdTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:36:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:36:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/8] firmware: imx: scu: use soc name for soc_id
Date:   Thu, 20 Jul 2023 17:41:24 +0800
Message-Id: <20230720094128.536388-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0247ef-5c0c-4484-ca05-08db8904dd27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWvp04fyUcUZFBSOzY5W6JoEUB2rfDc4+Os2FLeWKoMEeoUNTo6LWvwhAh8ir7GAZF/S9rxBcsQ/WYf6j6MClxjFsjjRnRJJw/VQtB7unXf6y2UigR0IchcHcDScaqwtxNmPBTP3Wm5nHC2dmW8/oR2Yj3lYabZfzAtF5WyK+/4z1Wu/9Nlhc3VAyTOECvhCD56IH9XW4nKhbGZawqgPBCrouLH4f9TrSoQahST/afhB+e8YI7jJx8rMraSBxjr8LQnxL/qDkgf7tDezCureoObycXWZBdKAclEv3beJZXuoJKu3FnmC5bigefgxchg3GbRMIaSX+stH2tl5fGFPUvOEpOEAiK3ptqybQtXlVo0bt96rFT+mvGqRKEvhXZO7d0UOiEVtLmjpEFypvYPphKcJFp8FDBNXmASg7QTcd8bMNPRrcZ+dth/hpPUAIBthuvzaOHsGf6kDM7oE7v6L309JqhtaXF4eXEUtMRx1HVtiQZCZBk61fQEa7qyAD7WGTPp/Vtjtr1/UyMivBzSETL/eb7mqwdqoHdymbD59fTLpebhiqGw/BtkKONZJ3Af5HMQ1nNYdt2MBs4C2hBlIh1i+x4vNKtYG+YpjJP+yvjiL4vZFioerFFyeJdBYawSM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4WfVb5CBZueyptXLk+B8PrExQBZ5iSjxj+5aoH+stWewvVpgZQwjkPTkSzT?=
 =?us-ascii?Q?l1tlAuaiKAqPF3iO/aBCrNb9pKK3VP/7G8/OrMKvUImaYYmHC2QRAgwJHr+k?=
 =?us-ascii?Q?LgXKqpaMCDzYivYwe9JOcFehvFfB2efwZZu6oAb2WCC/3B2bCk1N4p7nhQs/?=
 =?us-ascii?Q?iuxysizSeMH41sHNUialZww0Z/VL/zeJjl+OHfdRr66vyjqCvfArTZt75feC?=
 =?us-ascii?Q?R0m4B6iIQ9PcWkja0gJ9wXWQtlHZpSy4xgLM9D/3x8cNYU18ctxdJfLaX+w+?=
 =?us-ascii?Q?EarVDl5QFalcQjQ1xS88NjCIDES4mOTB6Uqx+6FqIE4cYxhxweNXlZHupfN1?=
 =?us-ascii?Q?QdXohR1dv+I5PmG5uGWgieQD2gCfDNGcXoIaCULkY3LOOmIXDo76QUBSkVxU?=
 =?us-ascii?Q?4jISn1vTdt8hScmIU1YI7aC1Ff4JYzhmoYTa2nNOqM/P54MiommAr1CRBQCP?=
 =?us-ascii?Q?FBkcMTv9ZzZz7kKvkXO4rA6HAX/3CS42XFHjErxfWpwuP1+cNQ0SnwXh9jS7?=
 =?us-ascii?Q?snw92Os0hgnAxN5hhsCUKs0l3PD8Il64ZnwqrtEq5MiW/aSEJIhE19vP+GWz?=
 =?us-ascii?Q?QZZuEZaZaHrUtAkCNQlTuiisvGQt9VV32W7HiEdTDK2YrInw7W5BppwDuIin?=
 =?us-ascii?Q?sJdstJEKnHyN7Gg1bt9Nk6N7agSdgVuyys9laaz6Fo6FlOaqWfZ+MgmFvRBX?=
 =?us-ascii?Q?Em+8Y1UBSuAr5DmLCsLtarF1IVa9aaHTPSw61xst/kl+Q9/z2Qmwy5vvCoRr?=
 =?us-ascii?Q?rp8MkzgYJLVQbZHyrAD8v9H9QJ1JczZjhXHrZbo6mXCYLD6AgDsKGWhIceGw?=
 =?us-ascii?Q?QKWJjAbUgCIYNnMwOpYoGTkweURVTn5hNzsPGHKy9FO3mlFL0IQ4/t1pNzzc?=
 =?us-ascii?Q?avk3oR6KpYV/JLQjspbqVNKjpARUZyIMWsHcTJtgzn4n/NBP4hMB/k07XRgz?=
 =?us-ascii?Q?P65zlhC/cBsewyE/1iGipp2hSuVXgIJjJQccRosBCgwSOkYPniwC2H/esXZk?=
 =?us-ascii?Q?JtTU8FahTfdD0hmTI+2n2FnZ5Eu617eXMPmutcX/BAPUdSnCq7j5FpwhgC2G?=
 =?us-ascii?Q?0yiHKSwzYkLv4U8en3f8YROXP2SSEBKNt91wxJG4XAqI770Ga7XCkORv0U3N?=
 =?us-ascii?Q?abBhERaw7EYqHPvq2kFzwMXNU/2ITT2M4Z+RDOc0iekewuhcpzPIEpho1Itf?=
 =?us-ascii?Q?dV7WpFGXtvnxRn11X4CMrl1BDyD2WOZUC17HwEIbNPPcj8hfBSv12s/guL3Y?=
 =?us-ascii?Q?68qHKXFRVzhOrYsKp+WAuXSsPUg/1w5sDzI1ZrSfUN4EO+f1IQpi20Bp0SzP?=
 =?us-ascii?Q?nDnyO6zB5s7wrgtj4TPV9myrBi6JnGfrgiSeBg0Ut/g5zrxpTKv3SEz7btCl?=
 =?us-ascii?Q?liSrB/6hGZpvmryud85XkSLuMWSlKDav/rz5akgUV8ZGZcNzNcOC7zVsut2W?=
 =?us-ascii?Q?o83TJzvGn8kOWVL4o52bxywtz3kDvw4HiL8+Dwfy/kFODhO1RMWcjMi30r7g?=
 =?us-ascii?Q?vQ3QyrIr9YjAhx+qA83/QyzUBHQoZtpW49/26PXMmKF12BEqh3fTfCGN4iG4?=
 =?us-ascii?Q?Wu+4gS2exzO+5tyD9Ej74PtAUb31rU0iW76eoE9y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0247ef-5c0c-4484-ca05-08db8904dd27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:36:58.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5vbHcAWw8pfkW/hJ9Y+BSioWKLOhJj6R0lExBXtrCDYKRmjRLKAbt+NwLSCNiYrrrtjpGNCnbjyi3ipeqMr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same as soc-imx8m and soc-imx driver, use soc name for soc_id

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index ef9103987e76..cb8377670a7d 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -107,10 +107,12 @@ int imx_scu_soc_init(struct device *dev)
 		return -EINVAL;
 
 	/* format soc_id value passed from SCU firmware */
-	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
+	if (of_machine_is_compatible("fsl,imx8qm"))
+		soc_dev_attr->soc_id = "i.MX8QM";
+	else if (of_machine_is_compatible("fsl,imx8qxp"))
+		soc_dev_attr->soc_id = "i.MX8QXP";
+	else if (of_machine_is_compatible("fsl,imx8dxl"))
+		soc_dev_attr->soc_id = "i.MX8DXL";
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
-- 
2.37.1

