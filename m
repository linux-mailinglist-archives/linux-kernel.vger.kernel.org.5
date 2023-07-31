Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4F769107
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGaJCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGaJCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:02:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223751726
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTU0g113XIbfhpADm5NCXjfkyG/yYxY13n1/zEZeTEVBsWLKrZ9kdEuuyMxuo55YFwUa60fqAUzxQ/Rz9h8+iy9YGrB1IjbH/f2ZIf7Ty/LTNh9Nync+RtSOxAyrKpGW0JyLsCxYoLFx7xBxdoPOw0VXqOE8/UOyNQ2s8yaJNV/+DL+3wgth+5MTOhnNGSLOb5Ftw7Hl7lRkLYIM7z89TmoDGLtErTiUysvbYzMYQmYnhbUfUgPDJNGeKQacAa0Cht8IGCveTLQrRoW8pABa7SEC4zdqeKAsriZXdjFhZlR5OlAZvxFtfKjmJhwpBEMo01q0LSUCRL8FlH7CVtMU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=J1kUbEHAqfuS8ySh6PWIeXNSfV6Q3c9uEV5kuJBSCvsQF/XOVNkG8C3Ri6Kp0J7AI2jmEC1atZLMwpy/SB9IEZv94ENE7Hgs0nRLgMQLanYhmmjA94tE+1n+T9ZakjaXRVUTvwYq1nPS5XX7VXhL1wbNMFWLPtRlY4E0WOIpvbp9pnuemy6mN/geKJf4PrBvkvjtvFAnt90uBi/610RkO3PjEw/KDXucyrFcQ49vUb0H/nMPbLmZBSlGWmu7Ot0xRchsDQNo5u4hGtuNVD2zjra/SZOAcv6bjgiHABy5Z/pyUfZREyAB3nQZhgjdq8NWtYsGfTZvoszo3PRo+7ahiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=NCrquj2qy/YWTV2Jnc9HLPEC3H+WwC0LHQbgmgqRQXrYwgL0YjvQQ5DOUDaOSxmUmZ2Vuz5n40NYWmnwT/Em5ONNyqVKRCa4CFsJpHCFM+lc3zEpftzNT998v4linHXgkZ+SNUaSRdSFYx/2JcHrkem5IM8bRVIaMOwuamuyyyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 8/9] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Mon, 31 Jul 2023 17:04:48 +0800
Message-Id: <20230731090449.2845997-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: b484ad21-89ea-4a63-ff60-08db91a49894
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bshFb8SKmlTzL2CD5P64DDsPnMWw5eR7Blpo9Oj2TeXx+5ARzSqSBXU9jvmWhYsrEDCpxaAd7jsN3G6f3JPbBB/BC5oS6wTsm2xKrMzl46XebqW1rr4Paax6YXdWlmHUlJw5xzs/tRv9Knhq1qRSVIkdBoOfHGnUo+28d1PkBZHJEOq8d7x3tlhEfACGTvoTtPZ4jgXjkT/52R85ReoVeHf+T/UAd5ZvXC+p+TblgHecL09Uj877Bv9+SMX99Gts1XQsVececHtnpo8AyNR7KTGsor8Hjb9thQqZarCXOnDnQiuD/pXNrn9t3usMOPrLxZr4lxe/47NPlc7/GFEmRF+C+dLDufV/TekMsBI34p42wZcjTkLn2I/GGuX0rka4bq5LgFGzlKKLogvmUOIfnhXwO3nlOJph7VH9LLnOnIWY2UJTJZ6Vl0x6bVtsYbygoi+fCWf/bJDnSQ4DyrgxGkr9vlQ6l6XOpJ+82lh79OmckAj2XUQSYAbSG3iH2orDsUJxxWsBPcwtFaD6Rt50+yM/keB+WVCH3FnrZiOg+I/b9l/oMoI4Q6yz8v5bstelYwFIExSppBE1w77TefmAsLzeGvzDXSY3bvpQ8vFD6asugPE9OivSsPgmxbCDKFDtLoNw4L0PMeDbu58/lroqyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001)(4744005)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyuT4wNA0EFlcc79zmzA8+rPS1czxAXhYeviUkxklAwQe1ZQGp1GYUjT3h7W?=
 =?us-ascii?Q?D000gCmBDKe6DtJAEwvanbncAVi3PMgrLuT2qY88Rn/wUX+NGgMgIRW1FBm5?=
 =?us-ascii?Q?AnV3fE9sh/bsMoM0mgGXDGPSuVONT4j9MejHPsSAAvWNRLNXcmhIqmvTLpgi?=
 =?us-ascii?Q?BzHLQlkq51WvTND2BJCrugoJxJBYssKnBTOZLDRncUrtxhQtOLYikoWsnCuT?=
 =?us-ascii?Q?HRRTmKMz6QJ4oD9K3kKwM3Eu/WYkcHf4N3WiMjm5PzsgWqWWz/ieRxSDmgAn?=
 =?us-ascii?Q?aLFfCWtA3LZ/Uww17jycWvHDcIWPaAPUXLrgk/cVB/TGpaktXXAKMwrZ2yQY?=
 =?us-ascii?Q?AVgzpxxQtg525zT/Xqe6Ccj5Z8ncSIafUgoxM9fTivFxF8ze4EcmfvOmjJa0?=
 =?us-ascii?Q?eyjBpYYj8QWb/QjTeh2pf4d51Q5FAln9JVIoVBQin3fIl2fUtzix7ufsKZuk?=
 =?us-ascii?Q?ISeZnX6g1zVrcTyRSNKZftjRvhJnKgURaZ1eJi55ypaCnw54VOED2SE5BytS?=
 =?us-ascii?Q?vmbezPRFpELiLe8uUC1bsRuUkWiLVULpQDuLjbwe2vF618hVHXaO4SpNff3m?=
 =?us-ascii?Q?Np4FZDjMcSTwdpp1WGQRG1Mjv01sdiaqyost7FvMUjn2lO8tJn8Frnj+Dy6Y?=
 =?us-ascii?Q?wicE7xk5yXzseLslj5P+D8wi9vZaYg3w6g4mF7mLSSvgZDcAxhcxJlbutAcM?=
 =?us-ascii?Q?eaeMVlKm3HkhvHj4O+lqEm/FoM5xtrEMx2DoA0RiJEgnwXYb791lV3V8DvUo?=
 =?us-ascii?Q?EsXEe+t0rQwZNVucT95vQJD4OhFDG92s3oLt84wX7bnNXmMPElyaCP+bFDo3?=
 =?us-ascii?Q?x5y2thA+xk7v3yCrs6ZonuGZI0Rj4q5jMtXwnDp4XMWfYjuRoFQASrvT3lhT?=
 =?us-ascii?Q?aPR4b51hjSj92kzMeXMQtkcPD42fgG6AXK3763oTawyPKucoP5cTx0np0w0z?=
 =?us-ascii?Q?zJl/iema70UCcelpcJJDAjBEtLizKS18ouuPLe3MGJTVGyC2DrFZm1UlPtSp?=
 =?us-ascii?Q?aRaR3ByGYRvs2kX2RJbw6g7hJOM6Xf7CfooKcaHkFqPQ3zShUFghfuoLKyZi?=
 =?us-ascii?Q?Rf2OMdNm2smthvWuJAjxXBXpR412xh+p5NL8tPHrLEZrvV7GiuMiCnKgYIO/?=
 =?us-ascii?Q?srXJG15t+ICictK8QR5q7XhsaIJrWnfhvWp68tX78CVJi0wPQHigBN9W73jp?=
 =?us-ascii?Q?LVElVEeBI9SeBSCMRRRlMR33lv1HsUnLG5MzNb1V2jPi93YEfRa4dMRLt6ya?=
 =?us-ascii?Q?PIIeiddVW+WhO1YP6QbFGAgWWbKSvMoWS1ihUDmFg2dDYAp4558NSCdJKA2D?=
 =?us-ascii?Q?QXPMicMp9Xtceq9aA2sn8sBcYYDNvW0Ibn/cRZrSC2L7PGxU1RBUeV17gugP?=
 =?us-ascii?Q?VwTfRVytO+DcMYHU3USxXikMHxNstMftnFz1TggAH85sPP5HATiKJ5c6VKJd?=
 =?us-ascii?Q?2abJKv1fsCyuH+bwgd+xxED6M5aPQwyrrEPGb9pJpesTaed3aNHBRVIATwNR?=
 =?us-ascii?Q?79VHZRLQ/hx8JFnujrK1lGMCJL9eEK2e6GaACYLHp9X4SgTBX8m7jTwcXF8i?=
 =?us-ascii?Q?Los42fS59VEBgDx9KQiOn1UwisNq7PIrjKShHmNI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b484ad21-89ea-4a63-ff60-08db91a49894
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:32.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSvNgzXZMXR33cTLIJYfzwYx+nPKyKWx3afTkftJy+VKqFRlrKXpwYv68jZFNMAi1ZbwaxC5afuWkCQnE0rr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
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

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1

