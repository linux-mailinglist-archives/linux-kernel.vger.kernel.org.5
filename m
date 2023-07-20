Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496675AAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGTJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGTJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650849EB;
        Thu, 20 Jul 2023 02:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCmDaCa9QpCXDrdNZ4HsLbgFwnSOZLCfY5j44TG6vUqs4Gmu2jSoSKCG8CIAZja4zNzSqJt0LP1aqJLoLq4czWTAkQiOUhcWEzPA+uzNJtbIC33AZX0HiLORGGQ4yqjTjcprWxp03Ts2q46xcrtyvikBMjpIqjVSj51Z1tCqUDd/qz9RZl1ebXhGANa+o5Smd/u7eTrKdnhwYm6wvOKXZ3TRGULmCC1PUzZ2qZe0JW9LV/2eBdd/Om32iN7VBhXJCqZLZpFglShBuJZ2DQnUZMQT4slCyIgjm+z22xcyKkan9OipHYMymtwHlTDenjP8q75pUsmvYH6aFDKTBuqhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKvqZhdPZYTL97CjZh8MmD49uWVB6bGs67335yGHmwA=;
 b=VOxWv7FH3xwN80I4JB05iiZhFaXCowToeNxV+sW38L042hB4qeCzHormVkgNr+rNnAWi7NrUy9/KLExeBLZAuo6RF8nGXEXuA+/BntTr5V0JJnvP5A1W4TIfJpgLAz3aBctqqyfho7qT86Cvggmxm4VN/fVpxQjouBSn4Jfm/0oIhYY0IbgPvcl4kpCznyfud8xID4GFXDNjQYUpaTrpKt1ZMLpu8Q+UvQ772Z1lRHZrP+Di6D9g5RRk6tset1a//wH4IBPnutVRG5+5XxFABPzgo3Q13smgtOF1gOrBWQOe5+UBNVQdWHx/SmiBIG8Rb1vdrVPxWzZaCbBI5M7PKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKvqZhdPZYTL97CjZh8MmD49uWVB6bGs67335yGHmwA=;
 b=SwALQOsRtV7j1iIJm7f0Jtd5BV+HZybrEiPufzyWxKU24KeZQPNozhkkM1S31wnSw3iEvmQNoCtITdLIIgB9Si5DOEsJuNZaUUKoMf8q3d3ApVyt9ETxojaDAYN/i/CBGtHgFKKRE/htjcCm64y9+q8XTEYIAfr1Y022Vrm+nLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 8/8] genpd: imx: scu-pd: change init level to subsys_initcall
Date:   Thu, 20 Jul 2023 17:17:01 +0800
Message-Id: <20230720091701.517197-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720091701.517197-1-peng.fan@oss.nxp.com>
References: <20230720091701.517197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 15497467-8b1e-40f9-cee8-08db89017a27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLLEaTx3SHexndN36SKGhEh285+TFTQ4tsndQP2qcjQsbSP2V22Ea2tKkD31rYzczdKnII+TKmR49go85dVdPYPEkLwRymm8hJIrnby5rlyyefs7WH7SrxJ2PMaborh8iGt5ka+ancvsKaf2QxV2b7nZcvifVwc8D9+u5FyKNyttL+XNcMTgL/BsnFMR5SAXWSDjWayPPZIZ8IMYJpB+VQ3NvwVfee1fw2l6DctJ/fAGEvaqoBHTNUP4e04040Jt6ozWkIsXBWFhyihK+pjhHFCc+ovaPLP+J8d/TErlUXkQz/zyOpCgh/ie7w22OV179Wcvaa7yazAr5e8Cb69/xSxlmvyERKZ3m4sMfXyLN6V4Qt19K/KNtajzkjO0xemj9pH2tYN//HacucorrxcKmy8L2Z1FMNB72pzLFImEXeUjUHqG5aFDPzbntTiT7T5byXV9sEj78PZof63In3EuByXAcWICeWomCOE2a3QphTyL92WbGBmUXiqQOkzxyTqWywERzHkV0zVh9Ok74px/Wm29fPagKHa2groJ1Y7E+ANDv/IM1oQH+RAjN4M+5l/kySnweaNvmvQUPpC3g+PCF97ed7B5/Ym1JwSq/oB+BFTNf5n/lEXvELbJq5LBA197
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(54906003)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(4744005)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ew1b+UL6AhuAnWurNUdN1e8Mx72T9TvKLWNip6p5GqSS/mkDo/+dla1jtl6?=
 =?us-ascii?Q?5dkYaXaE/j7Z4hAanMCEey2QLKlt41tfNWnLMfGXGP7r7Cz9pqd2ZwnxPChx?=
 =?us-ascii?Q?ccFozQDvgbnb/MeSRxBTqVHqNwE49/qhVgme07E0ZHXIzBVE1+ziSgU1hgUI?=
 =?us-ascii?Q?FArNAf52fuUpRM/RI4M5N0Tvi2soGVqZNGZEvhGyzVEWMYC8IwSfGn+slaAe?=
 =?us-ascii?Q?R4sIqGlFQku+xrKrXkoBUH/9hHlUymvi1sBkBwAUcoqHT0rQmJWcMgs1ad9/?=
 =?us-ascii?Q?14vr72H28bf/D5UEolTAwF2ARk1Hp7kDrSqtJA4eY/cz/h0BBtWQb5R0JJ8W?=
 =?us-ascii?Q?OLqtO4ivz7FhyWNLhSMD5j53kgVsm5jojad/KEppxGYtnGeQHe6txferBPWg?=
 =?us-ascii?Q?ITmVVt13qyI2yK179O9CBwfIVnE0ntwFKkDQ/5DQjHn9DMXXfn+2ovyru5jv?=
 =?us-ascii?Q?GegaK9o8KHqO1ULltzRM9+eeEFdgk3bunRGIX9u9bMUwnE1+R3zSGPCN6IH+?=
 =?us-ascii?Q?oyclXnnX4LrKGKVSmjeBbgqluISH+oZ8SMLYuKr0OsS+yrnI+JACATIU9o7a?=
 =?us-ascii?Q?rs9lph56a6ShWSJ1dnGqIcsbJZP/nDK3UbU7IXf8UUrGAaQnegQ24l2FzVHw?=
 =?us-ascii?Q?Nmxj3pyo7bRfSyLMb0VwXjh2fDWOtxXu/YU2G8FroWuk/P+Vt82QXPLBYyfx?=
 =?us-ascii?Q?yQS3rCb2vW7+hRVpRBeOeWvm89DgSLgvOzFK/hrjAUueofB/4e36nFHFs9a/?=
 =?us-ascii?Q?COSfBxeTasiR1Kp4nTn6IQWdA91VKsuZGIIWjWQ9ualjy6lSuNuD/ByfrZ3c?=
 =?us-ascii?Q?MZ409geMEXqWM2qkoqsVs2ddmRrhRW2+XCl6Cuszyhc7tWPeAZzKUdSYpOFx?=
 =?us-ascii?Q?8B5vJYJ1bfB8NMR8vQfDbrk271hSDJtPSIqwAl25Wkxe7bbFBT2FC4knAwe9?=
 =?us-ascii?Q?Wu+d6/K5ZKw6hzAM/MIpGAK+wqoz35WfvIgugbZOFJaHEG/Lbm3vRAVsnotX?=
 =?us-ascii?Q?Ad7sMkQjlBGzYPA+76xQBh1kF3o2S8bUTMLbgXdgrA7JG9V3kf8vhkYdyzs4?=
 =?us-ascii?Q?nZF4V8vMdraLbID4GI45YRN7jOGTfN+dsYlg7TXoi54gDy9KOqKD3jAcYTMq?=
 =?us-ascii?Q?UClVjyY8vwXqFUMOztIw2xjTLef5Lg0eE/gxa2zof9c3LHHAmxhLMybch/fH?=
 =?us-ascii?Q?+tqNcJSJ+rxLKHEAa3MSYPDu35nq+xA+Psze4sG7RwPwdcn/NMgCuVsLEhKM?=
 =?us-ascii?Q?0vgxmoJsBTKSoMrjMYJUY+Djl3jhEm9CO5llXr9k3Ce57hjNEYXn/J6NM4QF?=
 =?us-ascii?Q?Tac2aZCt+AB64xUcLc0LgvEEbN4iGTuKJYhmxKMQDSO3vElQoAR1ZPovStdi?=
 =?us-ascii?Q?NjahIpd5jvfqpvVZ+p1XMWkgTx0QRTTf4VcHCIcVgJgBzooo4hTEQcTlGilw?=
 =?us-ascii?Q?ir34ducI4/dUF6YQhePK/ehZDN2PaOvc686zDpDT2fDDVDNsVGZAbLychCZW?=
 =?us-ascii?Q?xkVHPn1clQ/eVAEi7sMI0foR61Zs51JKCAEazmQJ7tpLFJkKmBRdhRvDeiI7?=
 =?us-ascii?Q?6I25P2qDxaldadEuARO9ZD3OjUtEixIDp1Ny+oe8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15497467-8b1e-40f9-cee8-08db89017a27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:44.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQUyKq3MKltBDCyblqsXzYpJ0SCKBjcjcG0yGaV4pb6uRnQVIlNyRPojOkAFBBnHtBoK+Bqeap3w/DifNXb4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 31de56366a50..5e6dbadb43ae 100644
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

