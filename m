Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED391793168
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbjIEVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbjIEVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:54:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2CE61;
        Tue,  5 Sep 2023 14:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHiFZjwCVtZpZL4ZS7F3qKJNNSbt3msEYXjxEBZHJkh3rGat4Onbn5AyHc6azjCzKI2GIYH+iTOARqH6wXLFPQcknlwCQoImk2iOHIfMA0d5NSTpLufFqA8ubvQKaMPDXc7kpchZaIFvHSF++gntFvMyMZUBHMNr7T3phdd4TCDwueX5zAkCfCh1gGuCgIBi6VPAQnu9jH5nqNn5VkDIpDN76VYGZz8XsCdedQCARQLoAQNVhIAhLbe8v0/0+tWsW6sdrQIv3ixrG5an5zWJFcjDZnk/Ih7/iYBz6uj235dg+lTXKpElKQyKbhj0DVe3y1tr1vZZHpxfQOQC4j7kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdfPSZUm+yltE+KXBqLsk/Nr3ZkxQsjRhZtviSW+++g=;
 b=VAWlVIheF15jt0uik7A6+YZ8pAcSYg5CxY8U77QBd/uYIZzerixkv5Coo9PrvLD2/evTvHcnHpRVZFAEuriVyG7CNIDcYn9+Glx6uYJloxSyoM+DGqkrXqUBI3CFOHmvu38QQowKOarWi9jN62Bvj6nB5a7DDHtsR7N8s5Ziwg3oUnYd4vvSwXWDy/F9jV47FhedXXCDECkW91PICDh4tRFtISEG9IlngDnsFotRLLgAOknpoPky0mAGegiSWQs3Hr6dosFBswj75Z/erBjh1WnCwMVeNvIFDwIj0vxwy4sQUVKRKV9oRUhrYT951+TcRKRc5yKXJ+co3EUZQPo2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdfPSZUm+yltE+KXBqLsk/Nr3ZkxQsjRhZtviSW+++g=;
 b=HoUIDicxoHxrNkIn3MV32nLPv1rpGQmAITg1vPeH61TekFkcPTV/znT/3+ZQjsidTYNeL2BaNEscLWcnMhHBSaijGRF8SxBDl0vI5AxPX93ZU7vCh7f1fMjsqVcDxbjQb7KfwihQQs0+j2rZZsXdt9JMh/HHtFkUKX0BDb7dMbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 21:53:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:53:53 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
Date:   Wed,  6 Sep 2023 00:53:37 +0300
Message-Id: <20230905215338.4027793-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
References: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1db77d-30e3-40b0-3780-08dbae5a98bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du+nF1R6iNo2PkTcfddoHHoHQN049omP3FI2TzJXZUUiMwAGeEbI5c45dRg7AVMe3JU9cVAduQQSRz1cOXB9CIXbdwHUXsZbU0RYpLgPNm/Cn8wE/ZFM3ptcbRTkvsVgLPlSgBehhOgBf0DU4sUKm/RLnryV2BXEYSP9/4Hw3+o1cyhPvaTnR3PiNESwsV3f2H/tq98uvdx1carJhMa+1u/GaaN6d1/l0fSIq9lkBJTPxrUnogGin1VnjcE/LYnYwaRdiJIINT05McFTVgX/L59i6JKiG/0fEALnkhzJpsNfbg4CGuh4XOzXp1zowu0tsZkLWfWM2cS3Mudr2F7kD3DaEOWg+sEfiajPdJIfSa1+U8gb71oL7iIKAitP4p3ZXg+qVqB4ovED/SdVa/dyUJkGjNU0SXK6YxICtWbPNXvdBTAgL1p/8sBfx434rJNOgYNWZ56ok3bxZ7NezrxH8aNUYKnib7DY9d+Zr9QJ+5Zk2/yCJzs0cbykigJBkGpcrcrcg/xJWghkbZ74Nqia9WsaZJNhACZEz71tizLvoT8y3UY4uMU+oFDLPaCZdc69iNlLnzznp8Xpgu7hmxfVyPJyVYlLuZAr99t/KSqaXnDE5IlIJSr2k6oMB94mxSDy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(38100700002)(38350700002)(44832011)(83380400001)(5660300002)(36756003)(86362001)(41300700001)(6666004)(66476007)(66946007)(1076003)(66556008)(478600001)(2616005)(6512007)(8936002)(4326008)(6486002)(8676002)(26005)(316002)(52116002)(54906003)(6916009)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBSRR4QEET3r/58fD+XtvnTfcER81/zZOl1qVktQ1lygcoI/a/YdMy1w1Bjz?=
 =?us-ascii?Q?0TTanjOaC9TczmjUJlaSBQJ2NzudGM+9yL5XdAa9RmejNhNSEZiUcNO7bJYn?=
 =?us-ascii?Q?3bmQ02M0WNitnRZ1VuE/8f5FWuIiEYUO8P8ycjPCjojrTUWaxc8D2Dy4o6Hc?=
 =?us-ascii?Q?3wT26RoHo141SChBdZJTRsMqG2vpbJC56THJ3lksE7U8ZQ2qQsmdw8HrM7tv?=
 =?us-ascii?Q?cJz6QzuYWPKsC2VsKXyPrZWFmUcUOfGgrAPvs8jmJNPJw1aT3PL9qxMEkEVu?=
 =?us-ascii?Q?J6LSEPEtQIstVibRqImJINFs/2u11kJA6cXV7sfejDwfHN5K4swFOGi7uMsq?=
 =?us-ascii?Q?7YmDlc6ZEi86lqCjqJwd6iMrmatvEA8Vvxw/QkAqZ4EQtJnwZgKRmrTFCqUW?=
 =?us-ascii?Q?r4+0wpKKvoxZ73Ux7LoE5/97FE3b3PxnTc7cdCmCS8v3BcoQs4CeeLQ7XpvX?=
 =?us-ascii?Q?PPAPJ9WSfcTz8DND5GtvD8Tb0eXVHNlSgrX1MCwwcA/MT3e2C33iYJjSlHGj?=
 =?us-ascii?Q?Sff8OeLMidIusHIrYXwB3L5Z2zrHtvIay1U6o8bJlDSBmfT9mV/q6z1RgONw?=
 =?us-ascii?Q?MliVSoyNxpvBKOmck05Bn04ZUrD18LY1oypIHVt8m05uENtjZqzTLw9+S6hw?=
 =?us-ascii?Q?rGmFn2SrVPxjWEGwmVFTt2PhKeSzqZDOjIoJhz9QVMAraotTbBPgti+Alsu6?=
 =?us-ascii?Q?peaQtVM1dE+a5RsSEcUJijBKGlcqpQVw5JUPO3h+EWmVkKE5SvhYS3CjfRAv?=
 =?us-ascii?Q?T4Ov5asLC3rpc6wm2EdwcuqYF4An/Nh3ExDPh8cxkP2iCUjD95vDRNSLTWoi?=
 =?us-ascii?Q?WL8sGXD7bl/wuGL36U82Md6mAfR3aBs+/Qe10fz9DqcjPNbQ/46Yuzc0kW8b?=
 =?us-ascii?Q?JcLdCURsJo4KSwe0IGo57aAP6OcRop4VdQNPbMOjr1rF2QjFvhEblHMMiTF/?=
 =?us-ascii?Q?xHY3AT68PctamZvaclfmMeYckcluAE32Hbvj/22fDVHE0W01DmEY4TTgmzU3?=
 =?us-ascii?Q?GH27tE+bPhZN9rzG36MD6DSemzzHZRFUHMSy/j+j3TrXy6VeRvpDF0GDniL3?=
 =?us-ascii?Q?vu4nwF9kztOinW1iqdd+aeC2EPksnXgWjiQwt/246gJUWFunp+Zz3K75wFrM?=
 =?us-ascii?Q?mhu6vXWb4qXpcb52Xtf9Im0jaAuPE7Y+dd6l97gd14jTk1fX65E6TfO/fHu/?=
 =?us-ascii?Q?+S6C3H0Dwm3+X6L83bRB39GLfbYo5hGF3T81hHDr63mZ5HCXZeX1U+fBH15a?=
 =?us-ascii?Q?mOosXsJoz9m+JTDRB18WeGdcQzA/rKjgLJ3UnQDCWdcRGq5XjHwFHkc1uIKR?=
 =?us-ascii?Q?DSpq4ByF7a68VyJp/hGK2AT/g2Goo6K/327ZCdvkraEegWm7Xa4376Ondyqd?=
 =?us-ascii?Q?ucP5nmJv/SYGGpA9fF4XvND38UGgRxX3hdyczlqCiYecKVhbiN6zChycdOPm?=
 =?us-ascii?Q?YQg7PukKMtR6aXswdQyqVPIy+2/Vrgu5GXqtVGvn6yY1gcTXQeyATl+PNW+l?=
 =?us-ascii?Q?E2ZCKd9uDclFkgSVBk97lifEvH360wTZsLsafkwxYXi8z6QKCSdQz4KK6mMT?=
 =?us-ascii?Q?hSsoFv7Onlg4CUEZvek9b8/TjmW7ZcZlCWf+TjMCk/GNK6OV2MPqsFZt7U63?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1db77d-30e3-40b0-3780-08dbae5a98bc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:53:53.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yHiBRZNaxVO/+M7o1tC8J+APRXmQKSilJi1QyyxzcDLcXjfhrB1Re1iMGYqQfkfGsqNVRqIxGT0lFyHqbL3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running command [2] too many times in a row:

[1] $ tc qdisc add dev sw2p0 root handle 1: mqprio num_tc 8 \
	map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 hw 0
[2] $ tc qdisc replace dev sw2p0 parent 1:1 cbs offload 1 \
	idleslope 120000 sendslope -880000 locredit -1320 hicredit 180

(aka more than priv->info->num_cbs_shapers times)

we start seeing the following error message:

Error: Specified device failed to setup cbs hardware offload.

This comes from the fact that ndo_setup_tc(TC_SETUP_QDISC_CBS) presents
the same API for the qdisc create and replace cases, and the sja1105
driver fails to distinguish between the 2. Thus, it always thinks that
it must allocate the same shaper for a {port, queue} pair, when it may
instead have to replace an existing one.

Fixes: 4d7525085a9b ("net: dsa: sja1105: offload the Credit-Based Shaper qdisc")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 3f17c17ff636..d7f57f223031 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2116,6 +2116,18 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 
 #define BYTES_PER_KBIT (1000LL / 8)
 
+static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
+				   int port, int prio)
+{
+	int i;
+
+	for (i = 0; i < priv->info->num_cbs_shapers; i++)
+		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
+			return i;
+
+	return -1;
+}
+
 static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
@@ -2156,9 +2168,14 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 	if (!offload->enable)
 		return sja1105_delete_cbs_shaper(priv, port, offload->queue);
 
-	index = sja1105_find_unused_cbs_shaper(priv);
-	if (index < 0)
-		return -ENOSPC;
+	/* The user may be replacing an existing shaper */
+	index = sja1105_find_cbs_shaper(priv, port, offload->queue);
+	if (index < 0) {
+		/* That isn't the case - see if we can allocate a new one */
+		index = sja1105_find_unused_cbs_shaper(priv);
+		if (index < 0)
+			return -ENOSPC;
+	}
 
 	cbs = &priv->cbs[index];
 	cbs->port = port;
-- 
2.34.1

