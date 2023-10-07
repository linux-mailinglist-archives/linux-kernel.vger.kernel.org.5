Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A2D7BC7DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjJGMvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbjJGMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:51:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA879D6;
        Sat,  7 Oct 2023 05:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBJxjumQZWoKCpCkEcJVtJBhDOXzIbwXQMZxzBxP5L0gRyd+nbQYGYC1fbh1TD4e7yie5EtoQD2oGAc2StIEL7BCjqkb8JzilnE75Vf9OrhK9aQCAGF6PTQyOnsoGb7OCZ7qVyN8lKz1pcjppB26tVju7Am7hDhnj+hU4HfhZzocGap9GTJr5tG/UR9AVO7Ywj3nMKGf3HN5wWpUZq0BdbsqumFWUh21PAfkzItA2zTvZ3P9siDT11J1adVy/pM5PnPCwMqqrIUOjzsso9zMl2tJnaCeu8RKlobsZVd4LLMEAs1Xxmeien22EV4GN8Rzw4WR7oJwHwOhakk9LPuwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG2M20ceQEX6xnT9QI2TfUBAOWAPd1YR2RdOYxqSp2U=;
 b=VXRRtkr9ttH5yJ0Au2Qn2ErgwHb5dOYVySdkneZW69Hv82hGZ1z2BMC+L+YxPSosFdB5ARi+k+VolSoww62Uqcw1/1YLHQrjeplOs36gYGe81l7rr7Pb9pItG4kmmpsLU16GF2Jh79tID5q4RtInueS5mI/BlAxz0FEjoXmaFkjzk9s60kUPXQ9iCqETa1fRb1+520oebM50d+9JbFZuD+1UgRbzBufdzz7aJcmnmrsHk+kQRnYjsd/OdyGayvskrpG8D8DDRs0g1zQRr82Z1gCV8DLmnJ+NsisL3N0ePDKIpajDOGrwKKVNbykvy9gHjhFVG9LPmpAsKQgYAmLLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG2M20ceQEX6xnT9QI2TfUBAOWAPd1YR2RdOYxqSp2U=;
 b=EPYUCwnkGSOCBUrwk97B+W2PoF+WIPx9SfqXuV4g1ejukl3KhP99IGnTkwgwOEHtyjb+zrXGFZCo/ZD6qt2LUS8fQemDM6AZVZ3lOZiDm20iEGiQs18aYVJO4ePmdUyMwMqFHEs5eJ5FeO1QMbLXSTD9y7xH2XWiac96Mwh3Blg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 12:51:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 12:51:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH] gpio: vf610: update comment for i.MX8ULP and i.MX93 legacy compatibles
Date:   Sat,  7 Oct 2023 20:55:50 +0800
Message-Id: <20231007125550.529700-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: d1eccf59-4e80-4397-43e8-08dbc73419a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPlw9kp6WtNY0eIKda2X0WEaBubSU2xO3k7BxUhioAtbBlryi5fSPZfrcbZeAHlnuOOZ/hksKrNxKb+YGTSSTnYbssoJOY7O7GvBTg7Hn7mkA0En87Aq1N51QzR3EhPRUqdNh1cg30DTuybGF7k7qesHUFC/0W+a4DUCUrMhVuz/uz2OraUCdiepIpOQLuEgX2NvIo8SIv/IsxsQyCF1saBGD9+BWL0odM9U1AEVpaQWZe5dk4BchGEPOgRqm/tcVRNWcAplqaU6f8kCPuXhA/tVlA8u8eHhAUI9/Iw9tt3vUkDdfi2GPFCUnjXyxkTWW52QShXlXCvq7H6DgyInhdLZRN6Fi5Po53/1WLV7dg379QTAjlCQcMF57qaexSFE3wgQxjOF2a3YPipyKfLWjoQw8tkVrWjlBbDPhliGh0cDdsowxOaYHTIFweR0HDTrkzWuu4SzgnLGWzrqP3iXVNmtrxAUDr5PDkD15heNn6qiervFbOx3uMmYqQiKweb5PJU2G28/XBtyYKA4B9nmvtoWZ+5+PQMKZFetndYT7Dlts0MXGOXZ+czAQSdby1zz/iDCllX3g2+IjPui4L3qrb8xiiFVIifIz3NaGGlHMgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(6512007)(6506007)(6666004)(6486002)(966005)(478600001)(86362001)(38350700002)(38100700002)(15650500001)(2906002)(83380400001)(1076003)(26005)(2616005)(66946007)(8936002)(54906003)(66476007)(316002)(66556008)(41300700001)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCylYT7Zs/Kj/Bw+Z06pZZacMJPU8YCJARqAZo/98wzIMF+ZwdeeOn03Dp7E?=
 =?us-ascii?Q?gs7QD0+TG8uTwqPn+dY1bEW6Kx/LHcFob1HXUXQNbAMIckqVYQB6bHgNTMvm?=
 =?us-ascii?Q?46by+nhALxTp7aoWgMimbFI84UdODvbWIw/9foKhRDLd4kWAZxcHIj5MYkj5?=
 =?us-ascii?Q?YEgA9rV+8hV6fao5oaNijsDirtnaP5HbSNnBWWRA7icdp5qTRPG+Y6M/Hwco?=
 =?us-ascii?Q?4JREq8iXkos/eNQpUtPlQyXnCSSdaTLHU+oAtc7pTtIoeFTqns3lpu2ihs81?=
 =?us-ascii?Q?Nb1k2DEuiran3brYA9XtDbj7XwTkvejVXWwfbFBAtj7nmF83eB+L4OKGxjBy?=
 =?us-ascii?Q?2rkjJUDwnLIS/ONiKYFMVtZ1K9NDZhyilIytkk2fLaRL8fPlFif85vmp/vNh?=
 =?us-ascii?Q?HFsIHIjROUoqAvXueUXSZXnyVNrgcvM9TTUyX8IOljGo1LroyetLfhxF3mZj?=
 =?us-ascii?Q?nfSiOoHKNb6aBZG9q957+IA6SFN4NkCGgEnDoMgSQwI9pE6QwZiQcfZ3rOxv?=
 =?us-ascii?Q?kp4zHSgpClTb+z9qXwOzrbFwGLFETqT7oa4zrso67X5o0CFUKX4p3jBREu87?=
 =?us-ascii?Q?4uAPsZA8eNwByKG3lmUC8ohPDDP9A+sPhWFD2gA0oIJcGgNtZ0KUvCMsMM/i?=
 =?us-ascii?Q?OBKujwOOKDStaA1m0tKn12nyvLgUQF/CwnZkZLG88a82AWFvu5btdnM6C0LO?=
 =?us-ascii?Q?GPzaruLLTEEW9fdwpU/eOLT8cMCUB2cefeZ8t2mJ6cqbJRS9KP/vrR5pqvzZ?=
 =?us-ascii?Q?5fqHm0posd2/JY3B2/gRkJIKVHysCKmlTQbjHc5/HRqbWhxh4pRFPJVGx5rV?=
 =?us-ascii?Q?iT2hqIG7sFVrodwWPcmL42bbVIvrOm3+hvGSoGKNj4tczrxLfyGHPK1FQhFb?=
 =?us-ascii?Q?j04oRVDSUl45ku3VNHtmrj/U4FJaHW4mU+RVLXTJNpxaCE406L7DR7IG/U6y?=
 =?us-ascii?Q?MrGtl2oIpDeBOx9sZy6prjv/mXl7bHFw4V8comJT2KyLJ761FhK/JX3bJ9sA?=
 =?us-ascii?Q?LAZx17ELTgc7rH+heY8oyq+oAiBS3o07qQd0XBKr+0nri0/RPeWubnv9fCMy?=
 =?us-ascii?Q?N1FDGERNmz9eW3TjX4hUjV7cf/b4p21m5K/og/snmN/ns9L5aBWyPRjlKEkW?=
 =?us-ascii?Q?GY5JOyWpJUYFfWvYPdk6DhBR0nsJ0fxYFiy6omxYC0u/NpW1Vic9nsidXwVw?=
 =?us-ascii?Q?bA+WPwI9Ug2WHT4N1YpqXkrLJZ9uOa3simZc8sdXK6L++DdKO8t8JUNm8+Zm?=
 =?us-ascii?Q?DiiUFx51GR3GpXczxb2wqQ3UnZcR31uW88y0AZJlBU7+t3K2NsedoluVLrKO?=
 =?us-ascii?Q?IfCAPumUhI+Gcfr+2p42Sb6MFbCYASSshgZPDymEyXbRGlYQQ5k+VIGNxRjY?=
 =?us-ascii?Q?uQalgIlT4JAs1XCJjPfyj11z+YxA1+nKBD4SYEUjFshpPm5YcqquzdpEWK2k?=
 =?us-ascii?Q?zT57CaGJMkcPc7thx0X0iJK2YrgY7EAL/48pGTwKcFn5xbZByq6uXZ8sGRBV?=
 =?us-ascii?Q?N6AoE+6UrH8TQXugnBUvn3tRIt8v4QZkfT2UN/j6M+H60MqjdBFE8gsNlulo?=
 =?us-ascii?Q?yBADXA0husn5R16/SoVtQHL0zy6XpiDKN/TKJAoO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1eccf59-4e80-4397-43e8-08dbc73419a0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 12:51:19.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mLKnG3cHjFSXjyc58oU9H/z/Hs6JAHXyPE2L5PBGIYE9yv6HBdZph+SEIrq93yitTiUGtBrmPRl2eHVYE2/8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP and i.MX93 legacy compatible strings use dual regs, while
new compatible strings use one reg. The "support old compatible strings"
is not clear to reflect the fact, so update it.

Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

To address:
 https://lore.kernel.org/all/20231004050428.o7l2e23xjcjkzzck@pengutronix.de/
Marco:
 I added your tag with Suggested-by, since you suggested this.

 drivers/gpio/gpio-vf610.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c03dfda41d4c..a89ae84a1fa0 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -287,7 +287,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 
 	dual_base = port->sdata->have_dual_base;
 
-	/* support old compatible strings */
+	/*
+	 * Handle legacy compatible combinations which used two reg values
+	 * for the i.MX8ULP and i.MX93.
+	 */
 	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
 	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
 	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
-- 
2.37.1

