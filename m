Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0675779A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGRJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGRJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:16:11 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89F10C4;
        Tue, 18 Jul 2023 02:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7w8d05Pf1A7pN7lopUOrI32IVbK5DELLcf4RWK7GZLkN4j14FH0KFNTim6nkhlk9JcyMsCdpmzqgoFujNdTmuaNlpxvbvpwvGQ5LY0EN9AW/o/3mk6pXNspm+Rp/c9e6SMkZNsI7DwpzHHmKdcyoFyC6ea5bqbAefG+41bNUI7u+nqJLW9s3Jd2h3oaPRnMXE34Q+g0Ev50F5mODp4fXvAc+ox9oJQlJM/FXssv2zAlEGxBgx8dA4/Yi/aquwUO+vO75DoXyHNX7zQr82eSSTYrL8wLsh7+9m2zwwCWhDtoU1eDZFZg5AQm1Xwa8Ga3Ri2pVS1UTVFyhJrlGeMI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4mjbKivz+LL02DbYultiLe/mQihV1fCGeOOdCUq7W8=;
 b=B1TPPPj7Lyw1TERYkwcTKgOeIvJ0feCcs34jLNaVjS6uU+F9xZvwFmQnFa+cXnzHL+8T5LSQKmgya7FwbyHlX5cXrVYEvlhdwCgQ8CPn4sAfepdb5KO4mYW93TnDhU46nCExVEmJiTouNh+3WLBNxkThPXGFONDODgddFizHzvn4Pt00F7XkhSU+tXWOsTgV2OB6JwUqvx+aTR/vi3YQsyl1kswZiPGAkFwv41vnc3wveD6H8rzWY5oPV+ChzIoUhwY0I/oLy5jL7NHcPeApzA4i0pOuf5+hVovJJAw4NDPvU9PE+kXx04AAG5Z5SWtk9JMwfMiFCELN9s1k981OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4mjbKivz+LL02DbYultiLe/mQihV1fCGeOOdCUq7W8=;
 b=dQOk9tmB4/DAwUMeOR/tHsnAkhpnpgkYkJ6Wn3yEPNZFvlABM5BDXcfU+FDmWyxylZ5ZX3QZYFELtsplBulqJ0fzpvrrBmZ7LZ8aXvw0xQdsAdxgOmv1Ljp1yKyxx4GQypy+KhOgnelD6+evsLcnZ//mRx0FvqTJZ/zzP3/1xhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:16:07 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:16:07 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next 1/3] net: fec: remove the remaining code of rx copybreak
Date:   Tue, 18 Jul 2023 17:09:26 +0800
Message-Id: <20230718090928.2654347-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718090928.2654347-1-wei.fang@nxp.com>
References: <20230718090928.2654347-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: d716ef09-30e1-4050-a2bb-08db876f9e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2zBp8sJ6oY6Zr5ywN+Y2a3M7YicGh3+NVBgbrpSeby5SqXpYSe9G+RNUFGfmyuqldkdCjmHvXgBfJNW6MEHuRMPCFI5P0uEgh99BTqtFI4xGQb1g5v6K/V7z/DgFdwi4aPyOLTT1gSexRwM6gfFrDBgoJSCCPd//LfamDRYPLfi6T+lWgt8N+iOupHyBrb7Lpka9148Thy8mYZdJfamvXsqXC4nCjv6sbk5O53P5h5bnNjZhZvpkWsJ7BQ/BtPZFn1JMGgbhaaFgo9a0kDsi6oj4Yi3oLs3L0n0z2GGoUrfBK0Qu3zdyw7k1B9QhM4YQfkhf2dk7ybp9vtekL0CC4dm3by8X1TagIgqfqaTCCP6bFjbB1GBfkflAFDzujiGvt/z5jgZRXYEv4amWU6JvuVpYyEAbvr3pI2q15HMZCbPO641k2QWni6SlB+XfpZZhQxEIt4B8zswlrCiMTEVP89TwLXmWHKs59FFsy0yrKbEY/bYAzD0a7wI/4Q82KFvGHW2K+h9N7NlCS8AkBa6KicV0pzhJiKLLqwQ234eT4c5DNY6AtFhou8mG07ag6/5VcYMVvyjJOZBWLfJSLEdB09XpJEV2dGbE0ShJNACqfJUF6TqeKc0LhVFQiqcjqVd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(66556008)(83380400001)(2616005)(41300700001)(5660300002)(36756003)(86362001)(44832011)(8676002)(8936002)(38350700002)(38100700002)(6666004)(6512007)(316002)(52116002)(6486002)(66476007)(66946007)(4326008)(478600001)(2906002)(186003)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnzKrugysw8uc21sYRA3ZQQCWN9z/npCbbW7lrLylSL4neE6iwUzidWqE1/L?=
 =?us-ascii?Q?geH3nKJDk5tcybul7easwVpra1JhQ1jsRuRFTPSYszr4yJTPS3jDXeoUAYIr?=
 =?us-ascii?Q?Tzgn2hgxbddOCNRGhbqCt3s6HEgwav8BnrdnXXbe29pQrpj+40+YUTkLS1jz?=
 =?us-ascii?Q?AHAG9PKM29DGC48rV/Z9FfQs8MVBQkdllY31hrll4Df/MPY8GwOE+aLs5uxf?=
 =?us-ascii?Q?HfoGID9I1+2Nd6t7vaesgGdxXlkP9jyUk2AIZQ6/pQtpi8ObKSffTK4Aw6tZ?=
 =?us-ascii?Q?EoTtPyY4a90+H9TuzNTnU//5NAh5y3ZtEfJp61kwiddw6SrcQDcIRxplTspe?=
 =?us-ascii?Q?ODnPCIPfuDxt0daE58SIV8ONkxc2YQioJqj7M2pmgSZJ+uTiX4XDpkK7+t7A?=
 =?us-ascii?Q?H9w8AM9LnukUbSNtqHEI8uZ0eQm74SSDIiBF83nYndXW3FjHrKJO/SYtbET4?=
 =?us-ascii?Q?iT7LvU+OF0diByhjSj58ZfhELK0B3uL8oKogcosjII3hBmqVmmQSYwxLUjG5?=
 =?us-ascii?Q?amWjg+gCxm98mDksgkjtO8DJRac5tG5aC58ZIfTeMO9plsL9OscLdTe9dWJN?=
 =?us-ascii?Q?iiMb0U1KvQXUZx1qYNt91/v4KWopWjFI9+o+YLbL3lG6xv+JOWAoymrbVHWn?=
 =?us-ascii?Q?k79y9kDnBr6plNSVkb7LKOQNMYlGoVTq5DIh4d9rYza3o9152tlMkS1hsqWC?=
 =?us-ascii?Q?R/txQVtibryi1cuvUcasT7LeWbWdioNgj4usnHGzaeqCyaFQ+qoEY07RCbkp?=
 =?us-ascii?Q?guIyLJbobpDUMO+5/iAG/omr3LBoos4rsJBsSXlfCzDYGEogy91SzfZFrcR0?=
 =?us-ascii?Q?NoK+gDYR5ovP/il6lhAvtfOsUaxfBFQCmC4YThtjVCBtFlInKNqfFdsw3HBJ?=
 =?us-ascii?Q?KxfqaV4kaEPUmryR7ku03bffHk7mi0Q7NTycFwIfDGJteK37MCJD85+Q+nLS?=
 =?us-ascii?Q?dFnFGRzbTEZGkNVQBtgRG8VWVR/EHqxRNC4AuAjTHBGfr+KeUDmK3SXKgN34?=
 =?us-ascii?Q?bLYM5hMLBHhPDi5990YEsykPeaKosTSVss+0Z/SLrzr/5kdkM+mL4C9sZTML?=
 =?us-ascii?Q?El4RF621ILv4UG/UXvtPJKQ+0wtYZEKJjJ2n0+VH6SWFffPyYfwlO8Ufn91Y?=
 =?us-ascii?Q?23buDDIg2j85Uwb5ZUwejkn0K5KFXT9vNLz2PB/o6B5Ms+hoyre/tc6T6iA7?=
 =?us-ascii?Q?U54rQMXNf6SZ0dC9S1rFHKbSDyzCLnQyXQfgyOJYFGvTv1bo9U0egOoni3Ui?=
 =?us-ascii?Q?AKGqSngbPmKePu+fUZn8CWCrxr0g1BXoS/xdR85O8Z2+JlXoO0YGNk1kjAlu?=
 =?us-ascii?Q?idFAnMJdf6alJ14St3yohAN95U/v7hwSZVemv3ofcFaHj0xnNnk/F7BPU1o/?=
 =?us-ascii?Q?ox/r2nOcbFxTyzhIUwzkI4ppzxGKEvjWpYlGmAC+tH88C30/SJUZCkUvEiJS?=
 =?us-ascii?Q?4F5Loam/szSoiOCnxYCLS+JQ9WR2evxs8Rda4hTNwZYQK+fRCuFGLJu34GKm?=
 =?us-ascii?Q?uWYsK9z7n+3tonAbqhvwCMjbsbRoLtN8Vkt7YGVuDTuSF6r3+GM/po/tkR+h?=
 =?us-ascii?Q?cPOYKcO5nBvuR3tiA5xH4mZXTpi3sBDPMMzbLAyU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d716ef09-30e1-4050-a2bb-08db876f9e40
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:16:07.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYyv6pnQIuA8V2vZuPSscP3X8VDZ84vWCyPmjKA6i67Giuyzsyaxv7pkuiJ4ywUqLG8Q/tKEHBNfGuqTU7rskA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 95698ff6177b ("net: fec: using page pool to manage
RX buffers") has been applied, all the rx packets, no matter small
packets or large packets are put directly into the kernel networking
buffers. That is to say, the rx copybreak function has been removed
since then, but the related code has not been completely cleaned up.
So the purpose of this patch is to clean up the remaining related
code of rx copybreak.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  2 --
 drivers/net/ethernet/freescale/fec_main.c | 43 -----------------------
 2 files changed, 45 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index e4b5ae4884d9..90de14975837 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -680,8 +680,6 @@ struct fec_enet_private {
 	struct ethtool_eee eee;
 	unsigned int clk_ref_rate;
 
-	u32 rx_copybreak;
-
 	/* ptp clock period in ns*/
 	unsigned int ptp_inc;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1063552980bc..d33bf7979430 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -327,8 +327,6 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_WOL_FLAG_ENABLE		(0x1 << 1)
 #define FEC_WOL_FLAG_SLEEP_ON		(0x1 << 2)
 
-#define COPYBREAK_DEFAULT	256
-
 /* Max number of allowed TCP segments for software TSO */
 #define FEC_MAX_TSO_SEGS	100
 #define FEC_MAX_SKB_DESCS	(FEC_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
@@ -3065,44 +3063,6 @@ static int fec_enet_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int fec_enet_get_tunable(struct net_device *netdev,
-				const struct ethtool_tunable *tuna,
-				void *data)
-{
-	struct fec_enet_private *fep = netdev_priv(netdev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		*(u32 *)data = fep->rx_copybreak;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int fec_enet_set_tunable(struct net_device *netdev,
-				const struct ethtool_tunable *tuna,
-				const void *data)
-{
-	struct fec_enet_private *fep = netdev_priv(netdev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		fep->rx_copybreak = *(u32 *)data;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 /* LPI Sleep Ts count base on tx clk (clk_ref).
  * The lpi sleep cnt value = X us / (cycle_ns).
  */
@@ -3240,8 +3200,6 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.get_sset_count		= fec_enet_get_sset_count,
 #endif
 	.get_ts_info		= fec_enet_get_ts_info,
-	.get_tunable		= fec_enet_get_tunable,
-	.set_tunable		= fec_enet_set_tunable,
 	.get_wol		= fec_enet_get_wol,
 	.set_wol		= fec_enet_set_wol,
 	.get_eee		= fec_enet_get_eee,
@@ -4525,7 +4483,6 @@ fec_probe(struct platform_device *pdev)
 	if (fep->bufdesc_ex && fep->ptp_clock)
 		netdev_info(ndev, "registered PHC device %d\n", fep->dev_id);
 
-	fep->rx_copybreak = COPYBREAK_DEFAULT;
 	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-- 
2.25.1

