Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26AC77B6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHNKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjHNKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927FFB;
        Mon, 14 Aug 2023 03:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afd9/GcM9zeuJezVqdkDL7Kp7KcXljSKjZ2SzQcrPDKXOFex59biG9+kVDkydu9WuO/jMLORxkbSTNDLAdvPE7pFi8NOTDjKFuY4+0jn2D4rJ3TqG04vWYBrQdDiBN5JtkFh/2jJMRdgqiMWr5/0r6ldHB6yOQ7id4HQYbgT8PUxsRMXOaJQ/81SkTsysUj8NxXbkbjvgi0bO9QraGo5++HJHzOJuCk6h3mHVFgH1030hVOUDi/HQU15JPOMWuZNQCq6XcR2eWigeJutDygIaI+7TelslhuiOA66QO3CAhwAaNdSTVnUp7Ujz9AqMThbjaYV01Th4uIaU4aK+aE6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6eZg2SXpnwBey6uGP5mOAlS2QAU13HzikrGZ4cybSU=;
 b=mG/R+dFvUjYklPeqMGohwuj24Z+9hLua1r7I3T1D7eFXbIQXKXEW+RFu6rpuOMCfB+QHZAOdAqV0VnxgqSt2eS9BOJPvTmNDe3jz6lay3rlOhzwx5FnYeBixVrWBV/gQCdlRw4excmDv/Xg+aUmhn2WeCCLAg5L6rpe9yJmu2XUiWvp4wHE4a/1CjuXW/cJ1N67ylEAhlyzFlAReMb9rDQMcvwE9FO47NJpyvI0WtR7o0Hv8bCJEgWA3XePXIQxlWpTBu1zHXMJ7raxbNlzp2IT/rI0GT2FZoyg+HDFjwnwUMs3xbQGlm1sW2Bk8aRj0G5nPnjea9wRwTdb86iucAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6eZg2SXpnwBey6uGP5mOAlS2QAU13HzikrGZ4cybSU=;
 b=chpBoZ7c0SX0mXqorfoXl3rOw8ARC9tQyRTKST7khB//BJMTJJdKVH6aY2aqauQaM/Flwpyqv4ovAjvzYirM52GDULb5ZhEjN3rSi/CKo3SB+VdnWvbYV4amDxcRwMIAvgQ/v0AszKWVOVLn8traLFs/+GhMAtfgUL3KIpPLOmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 8/8] genpd: imx: scu-pd: change init level to subsys_initcall
Date:   Mon, 14 Aug 2023 18:41:27 +0800
Message-Id: <20230814104127.1929-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf200120-b06e-430a-83c5-08db9cb26ef1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvSVuvishrQOEYV5bK58SHTBstcg/ELd+j+UgpNfT5H1+FCfhFdtFJCZo8+aXBC2MrEgMC78ERWT9biZSvApmZjjOy+8N7EjlHPxcnNKtYQoS1f3CuT1Y5S+7WgoV/sMWOT2Go/AG82BXCoQ9cnBjTTRiM8zX/mk5N9JCFzApbO/1pUc9yB4oZgC5VUbZHdDiCT/sUT5GF3QFDhJ7ke4hr0cTiP0LAbTPfedWpggJoKe7c50jQP2+CWmvayM7bjVbj2H1LVG7sa2HgHy8XWAsvuS07mEw3PWDeNOrQGrVghFwdarJ7uCwssfPLkw5f3dYmXIVnUMqsMx7fy3jl2QRPFKKCZ4dPnQE8CU98swcmut+4Y3AfpQ24Kc9e7QDldQU9BxHYM1+Ff54Eb6C2006zVPc8O77XAzaKGTV+fBBNsAggHAyoM/+aeGB4hDI0hZfShbth606BFMtAk8y8rDen+Ynxwg9bQ9sPUiTcMAFRrIBfQgjzJo9+Eo0AGG7qYw2Ng6h9S2XkniGBfuxYut3EfVN2sFLp6lZCu5oRrNzkq1V9Q2iPnF0neQbQX9vEdZMhpIP4v5LzNZS6hgh5ZpsyRkzGOuf5E+CGNeb2Fn62QpSTV8spwlCf3YMYcPkit4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(4744005)(66946007)(66556008)(54906003)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9tQDGADz9iLVfqeHM345Ff6GK7ggBVyPKULdTaDiAd3ZWxBeqK1rb9jCQR3?=
 =?us-ascii?Q?b6c6vfbOvIEt1djzU0LWpxZTiSnvF6zTqn1dqWe6DC6k+44mFi7KPE1oZVpY?=
 =?us-ascii?Q?9Axf8av+JP7GR52q2IY0mtslzOb1aI5Z7W9MUwLjFTgYls7YMbZItlUZE+Vg?=
 =?us-ascii?Q?XtQX9NqJsP+bNzr8Tu/GhkGOCr7R57rTG7jN+PTTybR0/8rcLx+4hvIL0OC5?=
 =?us-ascii?Q?+3Qt5/aek8wUQk6/YZtFDB0qkIQhUQ4ksB7yZNpI+0Y9qXh4Nezb3lpjyLfZ?=
 =?us-ascii?Q?e3foMrM3VhbgieDt96xLUFwzYbcnwRJS+6ZpbSrs2+SWXpQ3xk2SQa/8SQ1o?=
 =?us-ascii?Q?kz2bka2d3c5mGpsyCwtN6IW2uzirQ86PITKdwwihh6O/D7UY9pUHCD83EVe2?=
 =?us-ascii?Q?MiqH0FT+o07kI37na+gP2urSwAMRY28p7mrOCpb548o40aJ+OjkPU6lkkyvM?=
 =?us-ascii?Q?QsCx5I5aqRBKhDTqU7BudHInrjkkIGf73aolt5tTf78NsCwSSJ+7cclvKYHN?=
 =?us-ascii?Q?0aXrxoIGLzd/Fe00R02VOo/hhNzadTyIkfRgSw8uBQucSRxsRQKqWJs3t6KA?=
 =?us-ascii?Q?MD/9uZI+rH9joO0W/M/B34kQ1N7NJSUAmYkjRZATujtSmJ0qmjBFE3qYK4ND?=
 =?us-ascii?Q?ol3LUxD/hn/40BZV8N65Kl4583FOO1K0ISSFeT9hBFE+YwuxZLMsywS05Jr5?=
 =?us-ascii?Q?BtJMNEworRp91uuMC3tUxJnH2iIkGCR4LqOBJltmr3eBr1qEcZFEIYzgPoNK?=
 =?us-ascii?Q?hLRn5n5ZK//FpQtN7/1YrNIOq0GkwpnfD3WQ5K4rirE2sPwLS2VsL8sL+QUr?=
 =?us-ascii?Q?Y2OAp/m3boTqkMQORIEeQA2K+B7iPoN4vVcGfSEViSDXqkhqYdwg+cQ3D2k3?=
 =?us-ascii?Q?L3AQ23pvZ4Lk8m5AA2ZHf2FH8BEqVFHayXhAe8R16/+bbvu+78rf1HITu+Bp?=
 =?us-ascii?Q?AP1XWw0AYF1y7jEKpiTAqyh97X5Fha9qvecw2iNfNui6wvoWp/mhi2NUFjcR?=
 =?us-ascii?Q?510kKoqi/oPTOsvXF1LZq6+99Ns/J7S3B9lWeEuCcTRHguvZXiOlYaVHz7It?=
 =?us-ascii?Q?/RqYfonSlVzIAnJqXqcYCwVS2XmdZFNEVIa3rIhLrdtgF4EmaTmvyCKMAZvJ?=
 =?us-ascii?Q?DbBfxpxPNxofD9CMXON/r15hSRCCRH3YdiqBysxR8T8LAjVB0SJyFhMVGp2h?=
 =?us-ascii?Q?Gx6g2Puh4m/sEiFSaz2ADsqqXkSL4I4EjhrZ7IGuY4kOlIxoSn4hwaI0ZnUP?=
 =?us-ascii?Q?8aOZP7g93KW5XnvI4VLVscuPQ8dJ7dqqaurjGDLshMOFblhKfTzjcQG2BOcD?=
 =?us-ascii?Q?Wok41pv1ytcq9Ih7LCLC6/IHtX71K+76BgF6h+pFa7yeyzuo9+r82vco0ozt?=
 =?us-ascii?Q?HfYfFXm0rirG3STcXzjyEN82KuD8vbs/neCVyZwUr/deez3NLGr6YxY9Ey7F?=
 =?us-ascii?Q?WhfEmnEBqLE8HyUt9jTfwAASR2wPcf6SSmsydfWOoMxK4crjBhsTEgalPY4V?=
 =?us-ascii?Q?UDaR4N2r4rfPARG7iR2S0R/p39iZNmTBqTIzSYeKeEj2sK9FK3jPCJELs8TN?=
 =?us-ascii?Q?vpIODi1DjH9sBvKx0i7y4/YoBYT8QxTsi2VRVg/b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf200120-b06e-430a-83c5-08db9cb26ef1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:18.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgodOTTgttqra7XFToHWeE+HEdNxc50+LW5LpAtvIBo/waPCJxPlsLmFi66UYU0h/8GYV7+RlKaaA7sTib1ZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/genpd/imx/scu-pd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 30da101119eb..0cda0999a1f2 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
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

