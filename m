Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783976BC55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHASZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjHASYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:24:55 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC72139;
        Tue,  1 Aug 2023 11:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtlWqnnuP/sQ25x5N9Ad47EtRomq4og5NCT8ZPCUYl4dPXG7IdJfG5KtFAS85LX29MfDNplCLaGO7K8c5A0y+bbgKeBH3MlleqRHh7dbFL3471OY+KdL12g772I5xmxlfYIYMsNqwrBeaO5hnQwK65qZIonVRTVjADzL+kO6t/22cuvC4aQ4K+jI0Oq2NrhtmqU8GZoiFhKBvD5JEZ6FpgxheRHn7FuEUddS0H3rRDlufXgZQQn7odxw9OPr6w6DK9uIZEK/CTWScgSm7aIT91i/uB0L1nZ4F91m28HYq+fxbgWeF+EMvOeXIVFIvRyGySYHB2EBryuX09jXP+QJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t04J+PnhrMeedST7ETnsj6KGwBzM/nxBIR3qjm9z+dk=;
 b=dxDdk9aYCzJp88E6Y986Z0wvk3Sk5CVFbYdEoEzs1DUL1/J9/081h6PHMP2cjwTGDkdknQeU3G70brO32OOH8/0hX9N8omCoATTaNyuU55bn3T3TXYkMiilKiR7c4B7N99Kw4EFIC92BmiN7Za9OLRxF0szIuJT4i8aKsSSaDwbr10A5W+L0hBtczHnpYx26thMOB1qhy7G9hSy06WF9OcZB2d3txT5NqWut8CCscaR9HSFOQ36CaQY96NwMg/q+jvw540XUwrjBPtRJxUmqFagZ0k/oEqi9IrqAmhNIXP95iQKNqiIQRsHa41RPKtgHfIKH1B7SIP9CEQ3b8V+zLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t04J+PnhrMeedST7ETnsj6KGwBzM/nxBIR3qjm9z+dk=;
 b=bTB2i3Zv+QB4Bq+rt7FqlCEHdJLeGOwqhMaZdw8lbkkt6ZmmU4ohEajjvUOPra0+KjRUN63XGKge3yqvS22CetuEIWFGZHMrdWOQMeB4qullNBfZBSJRvUA7Xg8wm1/AJRA1gH/hx3/Yd1leTwp3NG/SG30rOjoGP4N3TWktMc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 18:24:49 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:48 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v3 net-next 04/10] net/sched: taprio: delete misleading comment about preallocating child qdiscs
Date:   Tue,  1 Aug 2023 21:24:15 +0300
Message-Id: <20230801182421.1997560-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:208:14::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 22557206-a4f5-44ea-c2bf-08db92bc96f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRmZ4VQle2hIc61cAqpq6kNpadh/XVlKoyeZRu/cdAkHzMNQQhAb2kR1y2D9ScUceH/NIuz/PNU7j416P+X8NCkHgpkpaKyb3a0hIrS3ZleFh4XTclLMShv1HuSCapwidY6yOALCdzGUWEQWVfkyuUUU8iCs8b7km9A6sNxZeFoD2ATTnmJwqqXaYInS04ykhIBSuLL/jgtHSCidisJLVvymBh0qtkdCtp2t0YPlcTs3oApJebSnQxHrz7gPX9zqUgD846QmS8c/H35Sls9Loo3qarjF+gGyOHj4GBdZSwKISA4HPp2VeOxap/pqw0xWFQXXwqo/qqNwUCTcNmmCTK+Ma7A2jOhstnD245grfaZb+kxL/RX7UaU++uDATLMVvOsnlMBzYV64qpR5opzN2n15KhFcCjJPQLEVLMIFT18SEnzeGNQ610agPSH4xtgdbHap9p0GzWGnKA11er9RhAeWeHXwu4rfMq1FCwVrZvYryUv1HKH29KZESDCBoEp9f51DeFD4aHBxtKmXdifKzCqoE3F1NIEE/Smcvsd/odNor1FdDLwtZ57e2DQb7PLOGjmI81qXWe3c1dvfxQ+sLNm8mExmki5LsjOnzKqcxYZo/Aaez0ejkgf/h+WcWTfk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(6486002)(52116002)(8936002)(8676002)(478600001)(6666004)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(4326008)(83380400001)(6512007)(38350700002)(38100700002)(41300700001)(44832011)(186003)(7416002)(26005)(6506007)(5660300002)(36756003)(1076003)(2906002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91+Wh0SroYw752px8ThXk98RiPsZzwb2J+xz/6WAx3Mq/YiRi8pLZFmw9gKr?=
 =?us-ascii?Q?w/1DYhnbJ948QbsMudfCo37gYLSmTIuCjYBuCTKRAvhYeDE5o58f/OKvhxAR?=
 =?us-ascii?Q?lx66ZAG85VrRh6thQX1y1qIJ9i7NcgNiDCOEi3aoE5YIwaQVH0hZN+bEjDk9?=
 =?us-ascii?Q?Crz4CiAyPy1nyahP850NJlat4q1nJtkP1Pjbk8fqGSPBh0CvzVvoXQu9EyWa?=
 =?us-ascii?Q?PHEKgOn2mqAHIR6zBVOsCMPlFP6GMaKdh9jumbH/mtXGhBhCJWUAWKPgtLmV?=
 =?us-ascii?Q?93b0PzRH5OZOdJv92Gc1e82bajxOZqZvU//ibY8ywUUyNQHQ7+O5wR72Srnd?=
 =?us-ascii?Q?8qzjE5QK7uQ54CyyGKIjHqkltJ6edphsdDKRzIAeujCc/OMYBKwoafWcUhzY?=
 =?us-ascii?Q?6esJRja8f9c4w/H6bRMWvOxIiDKOFTiaUuf7NmlxU5x8IOLYV6woJFykixAj?=
 =?us-ascii?Q?cniRXIECSMjW3zBSkxzvhIofOKF36Kjih1Q1QSfy26ISPSi4pDuAmrO35hZ/?=
 =?us-ascii?Q?HqCi4HjpkXB1p1+/0OVwOegDQKoxGB5l6SvS7t+/FZwn5JkPELt+2drtaCfS?=
 =?us-ascii?Q?jk9cman5CV9t63fgOtpRgzD6Ym/nDeDwDD6FIv6dhy8JFs7w2MTnBaYTc/4D?=
 =?us-ascii?Q?qXI1gRQfbbtEZySN+cqgzTSzaI0DottChkslLgCMeVkmV61YbBhcuRadKlNw?=
 =?us-ascii?Q?/h/lquZVzPAGDjmGk6OEJsEPqeCIi7B3qgS2Sav6WwM65V+ZqFWPKy/sYbLM?=
 =?us-ascii?Q?ER8r4ezyllcjcUytMnwuDnILe6M+BsQtQRstPKjBbiCvszlC5P7yFudcve40?=
 =?us-ascii?Q?DlWc//Xsvb+opbOvZzBzviENvT7A559nBaDRT+VJ5/xm0p7EIB8wNn2N9jlr?=
 =?us-ascii?Q?2ERRWt+TsSStO8mNmrl8l4ReBpN+vPlUaPzfaV4yXAe5JLqScvndjnTevoyn?=
 =?us-ascii?Q?m5msiANC+mdjW5XlSs8q+FT6Xh5RrJSWiAkCDQEvYt9GhNszyiDC0G8ozJus?=
 =?us-ascii?Q?zZhU+kghJ9aHTx2zZxU7xraeOi7CchkUIAHGi7VMuxPBY2iOSoOE7h40059/?=
 =?us-ascii?Q?lOwjvz3iHD4dw3chzpGBHG0D6/o+1guXIrToOFfg3+aAanSB9pFM9C53RcHX?=
 =?us-ascii?Q?LrlEyu1q98/jCYox0PAahuhGDVD9rq095aJ3+j+roSmUauYKkVjTxO70qLYM?=
 =?us-ascii?Q?N7QjnDlQO3PqMaTTI9/LQsnQ60Sq+ZPPbwzoJF0kBDRWQHY9KDCXHLQFtfpx?=
 =?us-ascii?Q?1LhpfiEmD9XxD9+I53bLTS5n/Kf3yBBfks4nEyR3dv/PrkUgPpOkuP011TnE?=
 =?us-ascii?Q?7z7wyHUiUcmUV4dmHAw9iHyfMvlI9kH7ItcxDPefKfl/VQysOobZplTDe7Hu?=
 =?us-ascii?Q?ElaoSO1SbdWiNcckPpmg/eesd8udPkqOwcDuO9oGrPiRPAt7L0g/eWzWyJZ4?=
 =?us-ascii?Q?MZwMG9ypSQ/m/ZqSXP0FA91tCYFVYAA9pSVcG3uih7Ef/fi5uMmWwNKFRzRo?=
 =?us-ascii?Q?b763d6OMUnh4nyfTUkP7patFTggBr9lORrPX5J8b7wvrD8XKxBRoTzdPmlBT?=
 =?us-ascii?Q?q4AVGqAZZ8FyAVIwqDnGF0FWTXoAuLn7amSZMYsMB28XocgPKXTo5EKja5P3?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22557206-a4f5-44ea-c2bf-08db92bc96f9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:48.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYO3GYIXL9MctvIr8ToFHs9wHWQUOWzadawLMUTrjGNhkF9pH9i1iKJxEfprgLHWF/epxymuVLeeAdm7x0wQPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in commit af7b29b1deaa ("Revert "net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"") - unlike
mqprio, taprio doesn't use q->qdiscs[] only as a temporary transport
between Qdisc_ops :: init() and Qdisc_ops :: attach().

Delete the comment, which is just stolen from mqprio, but there, the
usage patterns are a lot different, and this is nothing but confusing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none

 net/sched/sch_taprio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index c9ad585b5dc7..06397300b40e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2088,11 +2088,8 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
-	/* pre-allocate qdisc, attachment can't fail */
-	q->qdiscs = kcalloc(dev->num_tx_queues,
-			    sizeof(q->qdiscs[0]),
+	q->qdiscs = kcalloc(dev->num_tx_queues, sizeof(q->qdiscs[0]),
 			    GFP_KERNEL);
-
 	if (!q->qdiscs)
 		return -ENOMEM;
 
-- 
2.34.1

