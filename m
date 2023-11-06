Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B627E2956
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjKFQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:03:33 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0C134;
        Mon,  6 Nov 2023 08:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXB7EOVUjm1lAzOGiJAKeTZnzw7i+q+BOJv1dOlnrHKcJfBZA5zccWNYg9OwjvKvbSEqrwlT9ugAeoowhgUr0ylSml+TTUcJFfPz2tZl4ToeBta0xONfyIpE8CuoWDrfIkjswLJh9/10o3Zvt3TmdK30vI2m/VbA/WwWp32A5HZGvq5L8+o73fyTjvtktsbBIsmkY3crkRXyShIdSKSTdot0L3zRjGynFtkVQmanBPzXYKO+tVKzFFZaVIuidj25qeayuDC0q8I3LOygno857idQQhgmnR9NXDUV6SrlLWv8JFyVWNcGwjQKla+ilQhtVBRggtUXT5d9QtOWvDBp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDgwUeBqwwKhmZdjN+bEofx5j1gxSJezZ4jPaMrzevM=;
 b=J5hxtnSS5+GZN7LvOyapOI6nwbG5vM/2bJdB5KlEfErNFOu8TbRfNflf+qjhcoqYc3EnxQazG9R1CQhV+eL1gPqFJXbZy1rO3aKvimMy/dbj8RivwBqcc9JnirwNWp1BvcuL5RHjptYOySK6bGzS2MHThRaxRqWXtTbnQ5ronx9CHbravqeomQjGslcSbVSUPXPUjEr+niBfcqAMXg3bgGxtpg6ecd9yxuhuxzoDcC/bPYCM2LbZQE5wOB8j4uQZs6HR/y/PoNKcJg8MD9U0SodZqxtAaw7brfHTu0TXh3VheeqYRqHvKjlYHDoM5iabpGNf7YHRdrWhwzddfZ+itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDgwUeBqwwKhmZdjN+bEofx5j1gxSJezZ4jPaMrzevM=;
 b=GBumYzC3B5dfxaBF582Wul/RimkX8psWpgH6gW/cibmcUOE8bwNiswelrdaB5UKnNiwPMPX5eY3deuOW8S8X02weQnZ9VcZ+oQUNIHPVgoAW47HAa3WjNlCwTCy8cx9hsdDoD7gXYdUWmLzNpsljXRurFSfP8hhwE1ogfN3GY4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.13; Mon, 6 Nov
 2023 16:03:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 16:03:25 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net] net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN
Date:   Mon,  6 Nov 2023 18:03:11 +0200
Message-Id: <20231106160311.616118-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::48) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acec5ef-60c0-43d3-8928-08dbdee1e855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qGsMGmmyBlR41ChUSRUggqPlNH6D/Z/p+iBBW4Y18lsCeWeDWMI+F/nj1UAGrRK3St7tCEKOIL5GDOsBSwUDn+zx49ZUtkiwLSQC57VZbO2uXXEISyegFtQ11PaZyGs1rdda64wjIkgA+yVJwzS/kfbE975gkV14V/259tzmG0GtAi5OK7avjinmqI4cANfLy1kiMGRN/emKYSmCDTO/Ni09eqxnMMJeuVPO+wSabNM9WqtUQ/sVNTpifIoHyKgmKqIGKe8mbGDTlNFYQ7k6WPjgZ/cZnzYFV1ntmrg57RT+FeUV55TX6ZbbwNaNkD4D5iBfCa1v6Bkrl5/d07NSIKni3mYhqx2JHuhMpQPwM9Hp70g/Xu/xjCm0cWEgBl5/7/Nk7XqpRPweUnOOa4HjWB1Eh5VqEpDeBrVoYwCIoINmwxGgKmUw9Odq71HLMAKC97Kpw0Oy53rBzre6rbazrEmk4HoiuyMyddQkXQyQTvfiwnQecaLSPcKk5uI4uWKomM6e26kHzcocqCT0nuAUJj8VITaXgaV+IBjN/oeeytvaaX3lrMdTXGUyJr7sfIuaNdcCMxxT4NrAsSYuRQSL8f12GxuYIMVO9cMRGhrsaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(1076003)(6506007)(52116002)(2616005)(6666004)(8676002)(6512007)(83380400001)(8936002)(966005)(4326008)(5660300002)(6486002)(41300700001)(2906002)(44832011)(478600001)(316002)(6916009)(66946007)(66476007)(54906003)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqEx/Ed4N3WEcJ0eRuAZ8n6biEQJ9ygNtRJ+2GwK1ONiiRIIze1fpQWOdH1L?=
 =?us-ascii?Q?HQLJj8yZsOAGK9xrPxtAg6Sk9SG8G0X8d/zz65EVf5E3S0FRqGZi9Ca5MU7/?=
 =?us-ascii?Q?sPeJl+XKii8ioyv+vRuNkRwkGOUBdNGidxbjN+bXFIBqN7Zv8ejOU8oGRfhK?=
 =?us-ascii?Q?8vgdysrfMXqr8ciuX/tEfeSSTwGJl0RMiwwWdGbKcnEo9/yteD0QeBDPFEO0?=
 =?us-ascii?Q?Icrj6oBj+HkzlNw9cYjqMAcjl2aKjfK2GpQb5EPFa2sBl6fehk7rr8TuZSnn?=
 =?us-ascii?Q?t5sVlu/9Nvo6Y1DvMfvqXTACxQzIP3mIsl5GdoB33oaZZ8u99xULUB4B3+BK?=
 =?us-ascii?Q?Oogh9EipfXndtusm+dia36MZkFuugPxHa3udXDnEoldU9NTYCM7rKLExO8DN?=
 =?us-ascii?Q?LgmzPmMSgtsxA2BpW844wRrhNtf0YpYMnj6D8ATeTEgYXoWgh2X+78d9rzJD?=
 =?us-ascii?Q?Zm3KUbKFR64LjqgSC3WnS1bSwgmKm2XX2bhh/PqSurR7mTYeL50zZqf3HF/K?=
 =?us-ascii?Q?i7DbiBmEafKn1U5urQ7knDB9eRpx88XhO1VZY2bKXb+Kfny7cLZxGe/cv1ZB?=
 =?us-ascii?Q?/CztIU6L7yhQq/ehTTEOmAKvYdK7W7OtjOhnk1D8CGLzit0uT3yU/kD8ZA02?=
 =?us-ascii?Q?RlQ4SyHm0ml+HICp6hPSCDibw3SqLiEOb+5hJqnmD36P+pmdXP/NJ4R+PzXF?=
 =?us-ascii?Q?2fuu4n7jszjj3sy2SHgrR/P1blYEn4Z5u5HL+RawXYGCUspMa1ZLoKtiOnJD?=
 =?us-ascii?Q?CHtAMjvGXHi57V1dTFphu095lngsztfSE6VDJUv03xZ5dT/rtoEtvn3pM01b?=
 =?us-ascii?Q?oNQilkL+LW9eiSFXWvnqfvYoKEr0t1HXSMsRKp+IF5+vC8+xvFKJylIFv1DZ?=
 =?us-ascii?Q?sU3nbEvjjVT56yIAH1aI9arpDYSHJ5qC5IyjuAuvkIIkr5yBUC1XxGExqjoH?=
 =?us-ascii?Q?u7wIhZp288VioK2PkuzciDnQdCFYUNlQimIdQW8u+HL3xCQms5QMTKTBUpvT?=
 =?us-ascii?Q?ABFlX7z9jT5aPb7WwgqxAPc4Jfkn/yWDraegfBTWSG4QlgXVJTbTOTBKZU+N?=
 =?us-ascii?Q?JvsLPHq1Mp9BKAn9uyUhFJHwSBhA5y+beskkaWGTcJ5/qQ80CJWXe19i48tn?=
 =?us-ascii?Q?S1ydHwX55gPQbYkRuRWmahhiQ65yOE8ihVHXgwc02dtDeKizpp/WXjtxmsLE?=
 =?us-ascii?Q?mOdqv4YDmIaxhhSsrt6vA7Ucs9pK85es2IIIeIJE8tqIHoi6+AAz2/+GHw5+?=
 =?us-ascii?Q?TgydnQ84x4mGcJnq8RKqhZF6NV5NxVvzgzvsxYR4pgjTjHB6zXtAZ4IMAHfv?=
 =?us-ascii?Q?F6am25+aWAUgVgeAar8nrpRVBJlPZrFyGP9wpfO/bqgYTGfoZAItHMBywo41?=
 =?us-ascii?Q?+MP2dNqBuIfUwwAhQjLA73VD1PDYmPB8DggOVfv4xjc9T95L5M4qlnhKwYWf?=
 =?us-ascii?Q?GRlWaYx0smMlesS/1IiwQdmyoWp599lhhhlb2g799TeXIwbfCK6qLltyKIDJ?=
 =?us-ascii?Q?2010R+XeCzMkegKQ22eXznhPxXX0+zPCiJhUx4b8kpeJYtUXLXvMOk7dva6o?=
 =?us-ascii?Q?QovYDrNEq40E2TTgiGvDz7MKuRiAgoAMx9pRRAFCvOIl5EWTRoK7OGcC6z7Y?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acec5ef-60c0-43d3-8928-08dbdee1e855
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:03:25.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37xWTL9nRVyK+VzFCn5ui8bG9H4nnhT4HVV0AeJsSjqcW18Bd4ei+6FRyoi3xQqWwfR45zRHeDKx1cBo784C5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NETLINK_MAX_FMTMSG_LEN is currently hardcoded to 80, and we provide an
error printf-formatted string having 96 characters including the
terminating \0. Assuming each %d (representing a queue) gets replaced by
a number having at most 2 digits (a reasonable assumption), the final
string is also 96 characters wide, which is too much.

Reduce the verbiage a bit by removing some (partially) redundant words,
which makes the new printf-formatted string be 73 characters wide with
the trailing newline.

Fixes: 800db2d125c2 ("net: enetc: ensure we always have a minimum number of TXQs for stack")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202311061336.4dsWMT1h-lkp@intel.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 30bec47bc665..cffbf27c4656 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2769,7 +2769,7 @@ static int enetc_setup_xdp_prog(struct net_device *ndev, struct bpf_prog *prog,
 	if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
 	    priv->num_tx_rings) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Reserving %d XDP TXQs does not leave a minimum of %d TXQs for network stack (total %d available)",
+				       "Reserving %d XDP TXQs does not leave a minimum of %d for stack (total %d)",
 				       num_xdp_tx_queues,
 				       priv->min_num_stack_tx_queues,
 				       priv->num_tx_rings);
-- 
2.34.1

