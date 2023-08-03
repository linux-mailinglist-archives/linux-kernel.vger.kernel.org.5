Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E476E5AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjHCK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHCK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:29:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB38211F;
        Thu,  3 Aug 2023 03:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN3WvaecnPS5Z0iYOH5xFLMY4+Ji84UfRa0yxHqTD6tMoVqHEgD1eGvIOp3n4QHJmW0girS97AEfnYyYqBqtllSAT4HSvWXPyXGEApg1Qrxdq+hNK5zHul8x8PgJrACZNEyr6RZ9jd7BCsleNrekOXci3w02WjS7HMRYGFqXR3zv6mZ69ojbx67xXnSpb5iNE6V33Z6L77RmfXj1g1rOeUlsF1hIHxEX5SkehrztYTgNVUjBXJ+skxtkQjOCFfo6OHPsQUzGBJLwkvPy/sGtCE5AUVs/0qKc8oxwyt1IgaHmO6gQCJCykg3VzOiniJ0134vD3tOJwykGbev+I0rnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4wn/7zdFiJ8gv5A8XwGroh43oYdO67afkvahNfXSsg=;
 b=Spl5Xg2GbAOtOr2gNl9E9ohqyV+qMftvC70nVAgg6R022om/llhtMN9HuiQXczvqvk4n8Ts5fcP0cJ1h55lIGIRJrEBzEyMcrRtocRdhvsQTGtmJdyxKx7Mpj8wtPSkkuDVEtmtOnr/YvvM6VRGBbgvRJLmV7HudpuTISJSIGilUBhvV26IfS7HarrizGNtHzudtVcVtL1eC40Gt8r08htMrLHhDJqjAERms6PYShB2K/5u8+Sd3iAXsc0j/ENJp4QWMXI8c/4gaxic/M2HUwjwfS3rcQ3Yq0NVn8GfpTbmWl/0ElrVQrqAaqv1o95XHpiyusBETOEdZQMYseAx0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4wn/7zdFiJ8gv5A8XwGroh43oYdO67afkvahNfXSsg=;
 b=Ljl4pfrMUrgMaXyMOVrSdT2GDWNAd4iLFuIr/lpody7c7nbZHNYZPsrxRLGqfjCAJZ3q2C6PN11u1eRnnaV96qI+tIQ6vwBL5DQBAa0QJHN0CvFRbcnkHPyF6CRPwQb+sxLS7GGeRaTJTGoQ9wApO9XGj+/LRyr0zPZ5Xo5Ayfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AS8PR04MB8086.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 10:29:23 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 10:29:23 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam: use dma align for crypt tfm ctx
Date:   Thu,  3 Aug 2023 15:59:01 +0530
Message-Id: <20230803102901.3116858-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To AM0PR04MB6004.eurprd04.prod.outlook.com
 (2603:10a6:208:11a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6004:EE_|AS8PR04MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2d3c23-12ad-4b46-7bab-08db940c80ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axWt/SQ+Nt6OIGml275Get4jVslM9JksocMDpHtenzmIDEg4XZnPztmqKnAYndAIWCLXHGsByBsCeaTrjHwHiTo6qFYc0DOVhWnNq5qIFNffMzys/liribbKAayaZ1Du4BEdzLNeJRSKDEtmfo5qaEmf2BNKVd9V4eASJ8fHhqBLRzkOSp6+QGi8LBdTacOA8sjmx2nP6DPzj9MaNgMHkjKsZtJnOFWA/uAo23rnrkm7EBO7+8/7dFiBDxkI3x7UJsgfTRVHYSmgRykE7ph6DDEzjBOmCcmc2sLGcLIxNG/99LQd/Lvv8VHmODpByBg5iWSOKokZhJsnoJxGtjvDcWJNloTApbqeJ36vuiRAAizs0hnqf5gAXWBHjwLHPAiID8uyNi66DCxhFJH+PjGUB3lHm+6UlEKMXkO6iQtSmqhHTBw/crpIjUySeii+jWkIHuBcyZ6oztYfdmTiL6kl9k5ZvCXTNbcIabmsJ5XFe29HseLdglzicEI0i6b99z+atG3T1U31wChHApnkGlb7wktcSxvcQORSakBMs6oFifDBLvNSjwkgle09u9c/pJC5tk3KnR5dq/Q5sClmP1lYq+DhJjyOmOyBwhoiMuhZnopjNfrn432znxb6p1jO/TMPqcmNueHZwga6BOd775eyNWINaXWln69zTTHcUPjEwpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(52116002)(2616005)(1076003)(83380400001)(6506007)(26005)(186003)(41300700001)(4744005)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(44832011)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(110136005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bql4EgEMj3nsTRI+rFDHqwLb1RP/WI3DPt+Z/aAaT8gfhlalr/akKea/m8rc?=
 =?us-ascii?Q?UIpW47QllTeDi9mjCIM4z5O8zW9G3hPnDwV2Q6G0U3NoKEk5vou2wB7DMsNt?=
 =?us-ascii?Q?idXNN795vDaywl7sPXq1KWpwJUjaBgzktZNmPoWYh858tRoPtgbby0NIVygB?=
 =?us-ascii?Q?fcppB0/D6tWp4c2tncaEhmxOTogLsdGn8qM9crhRMhjGCf7xKibYZKnys/8o?=
 =?us-ascii?Q?u1ygWy+FwJE2wm+hwrE9mzjcXX9rN7Juqu6SfCrb5Gs1LNLpOOQiBNLtuU/4?=
 =?us-ascii?Q?2D99xuOTEZFW9PBYx5Bx7iTW9jBF7fmh9jtnCKYrredS7gLobkOUEoSgwXb6?=
 =?us-ascii?Q?KwzZAw+KjeW/37mo0tjb5/+O5Qh4tP6Uv4nflOUyRZYCYFL2sk70fRkA5oRq?=
 =?us-ascii?Q?VT0xXaDSFI4Q/7O+4wacPGEl6N7/+OqvPf5wIl1WwYU+mEz9MolTDUfGlBIm?=
 =?us-ascii?Q?wILWD3pCDZ/0a9JMC0IjmXqZsmn4zq8YZFQWztgfjZBMqL0WemS/6WUJgp+G?=
 =?us-ascii?Q?EbXfULU2m+vQdLbY5iUKeJez6BBPVPec76qRnZPI6WizOgGsAc+WzieJYE2U?=
 =?us-ascii?Q?PkCEVgFahiM5a3qLyXCLNq8NkDgDcnkJpqD1XgGp3wlGB08Gkvds+WiUEjiY?=
 =?us-ascii?Q?Oec688BIRx0nZtZic95TuO77HtO4Q9vpEMSwEVxMbqvobQOYn5CyxskDkJOQ?=
 =?us-ascii?Q?RcvYbtkvtLfLEzBGOkwZ1P8jPwE2FCswGIBNJ9wXn+wZceC6XLI16NePFs2/?=
 =?us-ascii?Q?/bZGcjWJ1rklm29GV0AGe5dnM/QupO/7hIWO7d4lO2jwPiDYCA0fSZBtX5ju?=
 =?us-ascii?Q?64TXESc9uSrstn8Jn7pBr6PMDjZbhKelT2xVnqa6fvVTn5fdpyyj2yogkAbK?=
 =?us-ascii?Q?fkEED8NEMftzm6/cXORjZk1H1EiiRAl+rRpQCrrjARTcFtFzPEHiONHOz+nt?=
 =?us-ascii?Q?Dhfltyy/E6BFuMWjCiYAXOdNOpsPE2cV8aHxxco2AxvIYIx8TVRYMP43Lvhd?=
 =?us-ascii?Q?Mo91ihTcfbfE5NFSGeu7elexVaAD8hqDm4s40oY+Exoyu0xHFp9KK3CKMlMA?=
 =?us-ascii?Q?0i6qxhNmHOPbP/4CQqjnbxnaQoYV5CPXtxwgFHmOF6N5t7Hxa5hoe1zDEkcu?=
 =?us-ascii?Q?0JdEHSBALppn1v9hz2YHigJyZhQZe/u6Cjzy+nW2CUwvvb14kQmliWRwDWhy?=
 =?us-ascii?Q?X477F8LOUpr7uUtNgmE0CbMeuEJHzrxiY8aT7PZv8VZTJhA3jFnCQbkeR8eo?=
 =?us-ascii?Q?Cu9+e3tcmrbVF02oWJFEUg5G63MWPqcFJMACJSI3W8bRcW/usjiATwsmEuj+?=
 =?us-ascii?Q?B+1uRSRZy4bkDVRR0M7rNQKROUHCkxtMfSZpknUuJJDN90HTlgldpsuASUQs?=
 =?us-ascii?Q?WuIY6OA2PVqEsfrL4IRWnpDQrDwFHQspvdTYEZ+0hdy8ClhewzzXuGiSZgLe?=
 =?us-ascii?Q?e/rYFc98QZlMNzAjeOBrZP9MAK/GDlQ3W9FRwNI67Azx2BB/suwUOGnnFCJk?=
 =?us-ascii?Q?WWeIXIDcAnDXMorL6CO4dhve1f2ZxPCjJMXv2zie0HfyDj8BIRDG6go0q2yF?=
 =?us-ascii?Q?9lZJ+mC8/Bk20cpexxpH7sZn51DJGpxgRkju9cYJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2d3c23-12ad-4b46-7bab-08db940c80ee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 10:29:23.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEZgMUs/qbtqyWsBXwSqeFtFlvKs3X/lUsbJFHoN68NLYFRJGyeKyhEn31tZWb0BocQQ6jildehxvfGDRHRb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enginectx is not set when use crypto_tfm_ctx.
fixing this by modifying to crypto_tfm_ctx_dma

Fixes: 4cb4f7c11dee ("crypto: caam - Set DMA alignment explicitly")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 crypto/crypto_engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 74fcc0897041..ea1f41cbefe3 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -145,7 +145,7 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 		}
 	}
 
-	enginectx = crypto_tfm_ctx(async_req->tfm);
+	enginectx = crypto_tfm_ctx_dma(async_req->tfm);
 
 	if (enginectx->op.prepare_request) {
 		ret = enginectx->op.prepare_request(engine, async_req);
-- 
2.25.1

