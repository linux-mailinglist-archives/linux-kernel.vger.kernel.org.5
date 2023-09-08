Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34C7987F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbjIHNe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243597AbjIHNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324D1BFF;
        Fri,  8 Sep 2023 06:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/MTOQQEVzTMBPUPRD7/rW/sx58t7F6E+Jz0B/htgdeMANY4sFeJCHUbsj9qQZRjrLfabLYiDhxF7S+lUEOY+OUv5iDFT4nzTQcTz6cmJFwH/vAI17KZk/gxXS6/lZ9g4VuoduwJSSeLFcRnLnSWzfbZsZ37byWpPJ9vWCqJgAD+2twN+BS/MVMoa6RageBDUli4/RNkcs4v2eyvm877YhUS/39eYbnv7s5yx/sGXRkKfTQs2EqzyM1AKpXCCmYakCSi1/2mq7EIIhEyDhlH9wag0UP7uAAeLFfaXQJIrwyqQczUuaurDvlnr0mcGoNsBjakys5aPPgtHGdnm60+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+g2IKLU2ZGJtJuDxpqLwraWi9QGxrMdy/6lHn4ydRE=;
 b=hStYqbUcs8FG8OzXNGHpLs7slYsAB7O+4DYtAu82MoDr/KrCpTN6FtBHy8VJWLE6eImlHrdx8nS4SC8E1O+QpgY6gRvteb6cP2iELJiHIoVLm05QqMdAQMS0M4VdA8LPdJ9gyHjwDn/guxFTE499qHIhWcI1hsDyzDZZBLCXxIzeA+yCmz3aGAk5z3SYQDkSYSNvwSPc7xIqMfShsDryIzVcC5yVn2hzIt5eMSjwZ+GemPHZyqo1H5n40beYpfKWTwTu49iPcB8wexsAuXy8GbDU3sqXtuKOGQ0glv5YLnh9e4pg2UUfOfS994fNzmzvJ1n9BkieXPx8lEVO+nRKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+g2IKLU2ZGJtJuDxpqLwraWi9QGxrMdy/6lHn4ydRE=;
 b=dTIblAqW93PpMtubCyxMIZ0C02czS9VZdx8/pH1hVk50Z7s63fnY6A1g0PeJwg21h3WLIAWHU65naq9uJBfbwHYEH+a3BT1xn0lLbeuDsEHmySSuXXmhqbhuq/JXx2pCPu5LBh8vptnAkzmhpqeoJq5ruGxXMe+nNmjiMW4bSqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:08 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset
Date:   Fri,  8 Sep 2023 16:33:52 +0300
Message-Id: <20230908133352.2007218-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea46e1a-ad03-4e7c-d3ef-08dbb07046c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHxjuhmzc8fVMrM3bOBzstp58MS1m24wvyDzjQL9X66A1n29ZZGB33IJ+rDmu38xlr7VrB6whEWlx6t23f/P00KEHA0Hs/qZoxIBjcXxhlV9q10Mh73JiJGdF83RPj5Evj4acsGrwvCHDzT/f/e2+a6PmMRDNld+rKXcLNVQqU2LM9s6hqiJwoVten9VadFHBg4+SLk2raBpB0WZzkZbZEUql/Y84DxI/yyvVgSxAcRY7yIQR15p6FauXvld5sEpdRVBHvuyFQPo7oW3Eg8VaYhh6itP3YNKu8jWB61cz0dYxjj/+1OoGgcpU+MvlFEqR/GQeVho+nnpxtez5w7gO6txNNGUKkfbPDszhOkf2kNndGHrUVkWFDKU31gPLR7Z2sA2iGWsuTPiPHayUyWdLlI1R5WO5p8PUcbTFRVGpwUQ/lRq/c3SMoOkWhcqaRSsZJhx3+SUslNuD5fCs39Zfaso+NycTqRkZG7PJll+VoJKHiEvm607e5/ORp5Nsw9hbuG92+ImTg1jJu1ZhNXz/WNJ10RTVVh8aO+bmri+gtyxOt6QlufVBA/6dSaQA2f7YdCKJnD/e5qI56V41QyYfNsnFGwF3gWu1I6nVO3yTb2ojBFFhdvlrRHX/GTrU4xI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+eRUpHYgTYf5EgvQN28s7bMWUTmJ+iI2l5VY42XDkzlJjz1K1xn1PP8IRF5?=
 =?us-ascii?Q?ea+mnbh87jrj0Uch6cE18mrl0PW1mSQDj3Cf/7cH6hfPclHpnANLgYgTMIyw?=
 =?us-ascii?Q?RLyFr2ikC2V+b2D4C/2+inUBHZMdPwnLh/earBfT5aymx6nvmOxHchvgjC7t?=
 =?us-ascii?Q?X3vti+/+sPoojgMTnoQV0gUrt0PXwma9xAMLG3EvyJBSzoXpoZBEgU6g8z3P?=
 =?us-ascii?Q?fpes5RvULwiUcnJEdP59YC+W2/RMuUrzzk/na4SsXtQYMNyROmcWCbxtBl8S?=
 =?us-ascii?Q?9oI15b38pYnfN2PJ23KY7uiQr1f+bC4iDmuCLxn/9i6lr+bhmuK/hEyVtA3l?=
 =?us-ascii?Q?KsufYIyCxVkqMMM9pLbstop7nVNzAXkwnto7LxZawbAsIvj6bB5i2OaiC2Bs?=
 =?us-ascii?Q?YfdKRDu1D5+e6FjV0BlmRy5x+KIfmRar1+IhEuZsPyLDC8ozjB+yIELp5t3M?=
 =?us-ascii?Q?1+LxSXPjTqZfoyPCQpasPWN+CEhVVE4i/KKFdQxsxBPFJ8yBmxmfXJ70F3/p?=
 =?us-ascii?Q?H3q6/YbyYPMg5VKR3yXyXxe3ve7idN1q78nOHPE3DwpqjhWHUUfugmr2f9mH?=
 =?us-ascii?Q?LGWrts2DNCHkGmVBivQQ0IOAhNwTslKR/o+KkeFkZp+OHl/9LYaHnCu3fhCk?=
 =?us-ascii?Q?cVc4bWwctVRdupvxWbX7oOF5LJmXV0UDKkbTCRWtrzU6PHvRelrEyAPu3cUJ?=
 =?us-ascii?Q?NRkQi1Q7FbwhmVzYhvSSxh5hMyuw8QtH4DrNysxqYEIm8XOfukv5yWjaDjWJ?=
 =?us-ascii?Q?Eh9g2CLPwTXgcoztFpfq9Z9NGbj69boleFwGZzO5ZjXukVwMGOyENMGhz4hq?=
 =?us-ascii?Q?mL6Dtzb4x1nsF/hwdyepjtYu4eY0BfnCyM/y8zOl01303Q6W01ifeX1W2oLh?=
 =?us-ascii?Q?XgjaSVdSObm9ABJIZ2jGKe1Tiqm1TZwMb5cD8iZRnt88oFApiZzP4UhVtLKv?=
 =?us-ascii?Q?Tt0HvgolEXNf19tGmTH5kXjeGxui3YKx1ru1uNgzYhfjU85YMV+fgWUtu5hz?=
 =?us-ascii?Q?vK6sqcoiiadBY3rIIVILpCd8SeK14wxq7TDD0ZgWowp57z0i/pob5W/PG4ks?=
 =?us-ascii?Q?NfKfNx0ec8kgLukY1myxj/GCFpoZ+TSlMBP2DS+BobT89vmVU+V5F0cJ+lKu?=
 =?us-ascii?Q?vXQWFGGm+Yf9QS3uyPi/JLFjjMTlOjaU8WkvO1vhTGdWSVTUE7IeIE/Nrqbd?=
 =?us-ascii?Q?ithmAI1gFNBP8CoXYmymDJW8qAPEdfJn3YCiOVmZ/NOB2bInIW1mmsma5NFv?=
 =?us-ascii?Q?pv8Xus5hpsNt+jf+NBO4Wka/C1txWAhZ/D785MsNacQE4675RhhXe8BFQRYl?=
 =?us-ascii?Q?iSCIhy8hq40pg46cuQM1skUAwA0wGEQwJwEs44tDRs5Rl8tIrvfc0kOiRTn6?=
 =?us-ascii?Q?jF7RJYFPysVJpDX/Kq8HDlSYEJtuHMZCNGfktidP6F1HIak03f5Jan2e+Z94?=
 =?us-ascii?Q?ZhHN/k6+NPnMUeVWLeLgJQO1B7nmuII3h9YO548ga7gYCAs7p2hnWkjpq6iA?=
 =?us-ascii?Q?vbRZ+jOIVR5zDZg4z+3mjgdPqLgLTiVW2EOZ5KWjUYRgxnG8kNfwH5NT0QPm?=
 =?us-ascii?Q?vh+H9bExA0Mi7w5QOa65MEOxWPKv4GACAEBpQ1L1A+xBnZ/wQSjKMcb2IY/1?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea46e1a-ad03-4e7c-d3ef-08dbb07046c7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:07.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuCpCcH02MhjZG+jnhlffbciM9fTNEkgSrcpaK7LKL68rxeB94ITAN4peO0jdaZXtKsbkdFMLSBTxl5LjcL/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when we add the first sja1105 port to a bridge with
vlan_filtering 1, then we sometimes see this output:

sja1105 spi2.2: port 4 failed to read back entry for be:79:b4:9e:9e:96 vid 3088: -ENOENT
sja1105 spi2.2: Reset switch and programmed static config. Reason: VLAN filtering
sja1105 spi2.2: port 0 failed to add be:79:b4:9e:9e:96 vid 0 to fdb: -2

It is because sja1105_fdb_add() runs from the dsa_owq which is no longer
serialized with switch resets since it dropped the rtnl_lock() in the
blamed commit.

Either performing the FDB accesses before the reset, or after the reset,
is equally fine, because sja1105_static_fdb_change() backs up those
changes in the static config, but FDB access during reset isn't ok.

Make sja1105_static_config_reload() take the fdb_lock to fix that.

Fixes: 0faf890fc519 ("net: dsa: drop rtnl_lock from dsa_slave_switchdev_event_work")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index cefd72617af4..1a367e64bc3b 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2297,6 +2297,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	int rc, i;
 	s64 now;
 
+	mutex_lock(&priv->fdb_lock);
 	mutex_lock(&priv->mgmt_lock);
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
@@ -2409,6 +2410,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		goto out;
 out:
 	mutex_unlock(&priv->mgmt_lock);
+	mutex_unlock(&priv->fdb_lock);
 
 	return rc;
 }
-- 
2.34.1

