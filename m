Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88C7F43FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjKVKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:34:32 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB2B2;
        Wed, 22 Nov 2023 02:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjLI468Bh0QSQvIfd/ny0vHKSNX1e3L7FJMznARKrH78+SfMs+VZ6OQn4czfmleVrcK3mFZSZMm0Qmrg4maJy0rxIKcfQbJDzboPz1e5FRks+PnmI1c8OWOPHMl/n6QM1fnP43LMfiyYvB1Gin2H3Ohrzi0Pl6HurMO3ZI+dPaIzMb1bzGCDOw+pm8tsB7u0pLBFaLCTlbiiK3DUo8xmkovQGpMTPuzBcPP4HzbhiHWf6wbPDbGH1c0ljqSGpLYPPkXkNtS3dWuf9YtwwzutBD73RHu5j/fDKxiIf3u6mUvmioLj9UbOE3YUs0mUCONDlKCUJf0MWXq/7MfX0fj5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQbrDqiNS6UQeU68bP38K+jAoTk1gyy7VwrabUWCv1w=;
 b=KMWPzRYwFqPsmyawRUPZgfsQSDg2mjUaGFI9VeOsk7BDSfyQiRvSziQGmezHsP4zpFU2Uw+l6dfPrjQYf6hgLSCI1lKJFLo+eQUbAczSRaaW7G6FVRlx8mTUx16hZMp44lbF8HrMmKJNytPIcI7ZI2ACotC64tPvFjoAqJ0AAa0Yt9TFWVa+p+OiHhJI882wI/r+/Gz3Tqr/FsRgKewFUHZcJNXDIX7Ozk8wu+Xqp3/qr/5bN7RDLfDTAv1Z4+cuHx7JTkqbEFhJoef6jVjJrxuUOI9AVApqsOMkHRPxoa7ejEoj+G9iHurlTHjB+TMQe+PoP++Yag3xwoqskbQB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQbrDqiNS6UQeU68bP38K+jAoTk1gyy7VwrabUWCv1w=;
 b=BVJY6IUqRSJgMUeWyfrj3iEHU9yoZloRv0thgY4h4DSOE1/hCHa6IYEyefoMVzt0xG/CcEeN23g9rBuh4iPy9SQsJrW+yD17uHW/l1tlxNQ/mvOhwJAufubj5LRrVWHBSqmUjq3QqVWAkidXFeQFdLwcm3YOoqe0dmRkBkz6k8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:34:24 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 10:34:24 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: enetc: add ethtool::get_channels support
Date:   Wed, 22 Nov 2023 18:25:40 +0800
Message-Id: <20231122102540.3766699-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d123d44-147c-40a3-c973-08dbeb469855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xOqbWUALe6ob3ITDd1Z2n26w/EBXdkcMQRvE2SS8SsoN7Fhxso80Ai2eVCtmMBr4+MIjAGuaZr/4R18sUIeOum3FovkQqXUwu2KlgvMt78yllVvgbl1BoVWQdfHv6G/l3OmBoceQsqbgrmL6veC0jhHpzJhL/Lrnm9Z5QyqX7F8PoD7nax04YEscbgGDh+HcX5gdjkAIyILHaa2NOPIC9JXY/533WVWEiflyRUAeb79K2dS9TvMGEnJ6hTVFjMvYZSb3blu0QiGFbAV1lIB3T44Uiy+pgigTyYG+/AQlap7HSXnsbCoD7NUyT5X2mnllbTmP6Vl/JBalTZqoibCR9Lh6NOd6X0cjkQb/uKh0kqaPshN9ajpkXla1rneDd9NvSiWQ1e1BXRYmy/ZSejkDI5aWakqF0BNeSXJbGkg7B0XagBEDEdTT/4kE0GXfkkdLX4g/Fx4fZR+jgOKMNzCspU49cwfaXOpDM9IEE3GLUN9jlGtOByaF04PD08no5phZ8kpnmziDBM+i/qCdUziUz8ZLTmsrfpfzDsf9MpT3D6aWrkSDbPLxCCuwNdAOxnSQxrJiK7EDIHvTTcckBAM6kJ+fDAm/bp0gK+648Yvs84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(66476007)(66946007)(316002)(8676002)(8936002)(6486002)(4326008)(44832011)(478600001)(966005)(6666004)(6512007)(2906002)(6506007)(83380400001)(2616005)(1076003)(26005)(41300700001)(38100700002)(86362001)(38350700005)(36756003)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDtjftm5WFYRyoFmKLh80TAeH5HhXOKbgt/HeUjAgerxTMm17fLYDl8FG1/s?=
 =?us-ascii?Q?E7fHeYo15XYV3ee8pWU+OYROq3P8WFJf/QdRvzen2Apxzh0f7FcyMCnJxtcp?=
 =?us-ascii?Q?/qwBc3SWk980y25SWwQvUG5sWOSR3SD/Nd5YHlgNmbnnQ3fuKWQsohRopEIX?=
 =?us-ascii?Q?EWkjBoDzdLblyipEVgAYAwMwbaxj3nfXZXi74aYoNZcB4Vlhu/PWxxpx8Kq8?=
 =?us-ascii?Q?GZLnrB2ts2DY5UWcEE9xyp+DW8LRZxLVmnRms6t2+BpOGAjkMUPT28AI7hcl?=
 =?us-ascii?Q?lmWKCgvdeVK1Zc9bdwvVSXZfHoD0PeT+pBjnEw9LRc0LMeLwAf4VwmrJTYoE?=
 =?us-ascii?Q?zMpME48c7EyF3+6NUcX7jxHG0EmSx1o3+mdr1/b1QCIHjzErUlnmgcLv0BqK?=
 =?us-ascii?Q?w0YPsu3p2D0a4G2yD38nI1+ywfVL0S60GFp5QcqnXZScXZRsHszwlwb2aQGu?=
 =?us-ascii?Q?hlUS57uP7zQfYTc1+GxYJXJOigoMhijn5U+Maxs8l1ibPcjxPL7vP66Is7ct?=
 =?us-ascii?Q?t/jrRbwhAB49EFB33KcfXYMGvjS9xUgJzZaICDt+CMoc46auln1f9JkM1SM3?=
 =?us-ascii?Q?OOkyicoJ+PzjMAgkAvzUgliWyI+3B7RqMy0rTNHOc/RJdhHfG2ixzmfWpo5b?=
 =?us-ascii?Q?rLj0xwDlev0W7Bo9L2G/iFVhgUZ8lEXYhYwZcC1bqxmP0LUkEz86AqJ6wVeS?=
 =?us-ascii?Q?aihbl16mCtl5VTitYN4+EkuBtxRu4YoWAn2PF80UP/fV4NKCkPJBbGMe1DQI?=
 =?us-ascii?Q?fLzNZ0Oa5kTmR//6+esNnPghTuuEBaZBnzt6qs6TjEcrJcwXyzIRklkSzZ+N?=
 =?us-ascii?Q?YYiruhuG2dhdf30utFdd5Gelym6FfB/72ZLcdhJotFfrZvatcwkWNBua4i01?=
 =?us-ascii?Q?WRvO62GqNRTXGkKl2Iofwonz4P6vchrM7Qr2xfgXzX9Arw+scsNNrWwqlKQ6?=
 =?us-ascii?Q?PMtraUcqCjvGNgCOWD6JWqrIqtg019EpbgI68oNVoXaVnC73eDTmYau9U9WJ?=
 =?us-ascii?Q?Zw80gmo228RrlWtuAwdQST15lcunka1/2l+gFXKwnNMe0uoP+M65+6aPG1zA?=
 =?us-ascii?Q?PSV1pZM673nZSqXftAUqSffDoAjBqhO9ejit5MieO5Ngq174o+lez2xw+WGH?=
 =?us-ascii?Q?TT80gPUIlUdIKsl3bZ8bVl9KGYfsGAh2BY6Ez+eTOs010ZpxQVJnKfxMh/Y1?=
 =?us-ascii?Q?3/yK9Hpl3dnt/NcRwG83EVb+2T3fon6PZavAB92wjStZeTeFgCPsnmtkbIyt?=
 =?us-ascii?Q?kHwRhO8PuQHyj3CaljCVNLOPuIZbOBulaAkF1RuosUCRc6Ev6k2IjW4ChsGN?=
 =?us-ascii?Q?7VCnXcyr9wgGsR8EoulnU3svTizkP1bEHnTUMS8QJ/wd0srJyxjyArrEYio9?=
 =?us-ascii?Q?gNkjYisznS7dv0dXVxvCZcXujbGrorHrnLrJJwLMw/cbFLmPrr3zvHtotdEg?=
 =?us-ascii?Q?t4VmguH5rWcOWwK1sKkV4k2iM7uliT8wKwu+NKUW4GREKXb2/sjJpwX/2URh?=
 =?us-ascii?Q?YdJJj3bnb4RURO9IlXW+e4bR+Eln34VsQljY3qbtM7Akho01b/AL0eiqs8gQ?=
 =?us-ascii?Q?ZpSvn7cJpshTqDefwPRYREcVY3N51WEwtW1Dtqjf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d123d44-147c-40a3-c973-08dbeb469855
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:34:24.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHhsRh9KUV7uD8IOMDdy6JltA8yYYXcAeRjnRn80BZjusC7uCoXFKHpopDTFqlonbwhnCqSGZTHk4G+ogc7S1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ETHTOOL_MSG_RSS_GET netlink message [1] has been applied to
ethtool tree, there is a netlink error when using "ethtool -x eno0"
command to get RSS information from fsl-enetc driver, and the user
cannot get the information, the error logs are as follows:

root@ls1028ardb:~# ./ethtool -x eno0
netlink error: Operation not supported

The rationale is that ethtool will issue a ETHTOOL_MSG_CHANNELS_GET
netlink message to get the number of Rx ring. However, the fsl-enetc
driver doesn't support ethtool::get_channels, so it directly returns
-EOPNOTSUPP error.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/ethtool.git/commit/?id=ffab99c1f3820e21d65686e030dcf2c4fd0a8bd0

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index e993ed04ab57..5fa1000b9b83 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -740,6 +740,17 @@ static int enetc_set_rxfh(struct net_device *ndev, const u32 *indir,
 	return err;
 }
 
+static void enetc_get_channels(struct net_device *ndev,
+			       struct ethtool_channels *ch)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	ch->max_rx = priv->num_rx_rings;
+	ch->max_tx = priv->num_tx_rings;
+	ch->rx_count = priv->num_rx_rings;
+	ch->tx_count = priv->num_tx_rings;
+}
+
 static void enetc_get_ringparam(struct net_device *ndev,
 				struct ethtool_ringparam *ring,
 				struct kernel_ethtool_ringparam *kernel_ring,
@@ -1196,6 +1207,7 @@ static const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
+	.get_channels = enetc_get_channels,
 	.get_ringparam = enetc_get_ringparam,
 	.get_coalesce = enetc_get_coalesce,
 	.set_coalesce = enetc_set_coalesce,
@@ -1226,6 +1238,7 @@ static const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
+	.get_channels = enetc_get_channels,
 	.get_ringparam = enetc_get_ringparam,
 	.get_coalesce = enetc_get_coalesce,
 	.set_coalesce = enetc_set_coalesce,
-- 
2.25.1

