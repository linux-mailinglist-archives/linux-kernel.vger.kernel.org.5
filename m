Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1B7D2EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjJWJoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjJWJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:44:00 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF0C0;
        Mon, 23 Oct 2023 02:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhBQVRYReNXNsVkABN+dsuE1K7aPbKpkmeiALKGHh1prhjWTetulrv0Isri20QGJb39EXMatQJj2O6jpWt4PkJD5tbGo91spkRr/K4xsQ5PLsY0t0Ua5WD/WLidT+TUgitMAqwfWZfvNOUHiITK2zbcMKn1xXNHocC7182SrsE+O0oisVEXWP5iKtq3/dp1utlqPnoodKHGkFqU6Ozo5O5RfY1CyEw3d4bc3yY9gf5x4BgflRMfUux4QmhlWsARb0s/mDsN+7rm0A33RzFng6SkVPZFEODyTQUfBmaqGtJ3T/aCU5Zs5VMg4yZkxmqN1qSTeLUu5eWycnTGfKLfIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVgVqn36IdL8lVsG6BicWACXNy5Ub373JniC2JVGMws=;
 b=laohlbxYv4na3ZhBHiDv6+U33PefPZoq5lvuvcchzZGd8Y3PLZctHJTfTNpogn0U6RqUH6iTLZQ7oEmdoqeXxgwioI6GNOpyQQOwzld565DQ5oMybzvKk4ToGZHk534wwMhi9rKbJEhvQDY1pa/PTHj68zgZgOSEL0579TaHS0n4wLp4HeZJQqkB43NZaLjH9bpLRUD/cd5ZgfvGJugJE+BuzWgwn1KSIDNFgPV2HsE4aLAbFu2iWntwRMTP+7tjgFTx/Qecz9N1MzmvvSwx7uRndIQi+UJiyiwvS1DXZ2kmD3bejmJK8q2gWGwIkhcH+gRrBAtNZlFNFZgXTun8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVgVqn36IdL8lVsG6BicWACXNy5Ub373JniC2JVGMws=;
 b=biwbfZlOr8h942voazVvTyqIYFq4VdfsY+hBZ+DgziGizGohSJlm0j0cNXy48FvpOk2HvTc8XORNMMy0Y4BFgUQ4Dxxwek/3tooFdSIgQ9L8tqSlXQKqKbvR8k993+1d8HKy9kLcqFNvqE1OelTxblYcy3YFIvb8qOsFaNI6CoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:51 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:51 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 4/7] net: macsec: introduce mdo_insert_tx_tag
Date:   Mon, 23 Oct 2023 12:43:24 +0300
Message-Id: <20231023094327.565297-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6bc82f-85f1-4d7d-fd41-08dbd3ac9039
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kH8I03oMfw8BiqdwmLQMndg8/IsvxG8ZAWf6nlbPCku1z10beFELqhgqIp8bTasBZ4j/bsaAA/b6XNLI783l0FeSy3IGQvPNN8usLKhSqZnYu8cw9DJszbHbu1650syR+U1PqcQFPNo3JaTmroFDM0194Jebh61jv+HCm1Jx6Xb1/sqz7eyFzjfewir+sGxUjsdNzR3vR8SdLz+8cZGdtw4tGEfRyQuEeiktAuNRmR+Mqm87YZiW8PRgmMWDTkf2tVkxHSQakWHiIus2PSmTDDNRrePNMlGI2cN1crreb7KT1BaP9CIEw30YQbm3vYo3O0a6s1x6XtisN0dEP+fQR2NAd6su3av8TIb0QWHM5YRSWw53e3nDzHMHBM8vrBWSucq96kwpeioMGMFdB/+DSB9mJi60T5wGjUVQceRma1i5tzGiGqqKn1Mg9/UwTao5qP8SSyGF3+LnyYaX6kPZGVPRi9Lvwpsgtyf1QQqOA2s4mAgUYr40UdankNHi7PLpfjoG43Oq1WF17MP+foGiuOQSRtWYuevQf3MxtsOYHy2eMzuISgANjeDeQpjwMmEAdlMoOogVIhrybDj7f1Uw1d4QGCilC9Ol/tJYlJbaaME/3y9ShvJGU3H7eIvAnP/1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(83380400001)(6506007)(8936002)(6666004)(66899024)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3sQrux+Cnnw1OoW3QfJrnzE9aA7nodkwoFNMhy/sPfFgyiP+Nukm+PAMgbY?=
 =?us-ascii?Q?yI9KT++fWBPOFNeAaSFspNqxCY+ZyuOcerC/Y2hg0ZOITnGxPzC+WoKXhz3J?=
 =?us-ascii?Q?ZLMjYq9OhcQVkvPOu22Euz/PnoMaACCgoOymtnkovM+V/oO7FdObTm7kRzTK?=
 =?us-ascii?Q?OutqXS/6ob2LcWne38WDPXjiVm9FCzoHgrm9jfMJOHgj+Iih13pjDsOvD829?=
 =?us-ascii?Q?4KeB4js95DIPj0rXHY+6Hpk0HfLJvMEnMyMzPfILAam0e1XZTcZPRBuI0TRq?=
 =?us-ascii?Q?t4N1B+agyJarrefbSEpfJb2/KT4rDw0aLR3W+QXtYG946hY6EzbINx0qcALF?=
 =?us-ascii?Q?+FjUemW5EtorXi0ECmdBuyKAU/WvXNET2wmXW1Hdqd3Yuf4EYG9Gj8454TIL?=
 =?us-ascii?Q?dW7OiGOQZ6+qrZm2ohVznNA8vaRMq30SJxpsYFW9LM2Cn8wVauwZkkP/2nHD?=
 =?us-ascii?Q?pJf9d2j15vHd3CTjTPYtvqY9SbgxEYKVD80jUcaapJYQrwVZoo43jNU9Z0OL?=
 =?us-ascii?Q?EA7KeWm7SYCMk8VNj5zo/edJTS7q1o7GIheSsFaW8039ob5Odz2o1+RKiBuV?=
 =?us-ascii?Q?QWVoywazAERzGh7rXvWto7N5EkiuJYCqH7acJimKPmzy1a5L2QlE1F/A7K5K?=
 =?us-ascii?Q?xAtng03x5AuasxF+kEvUfVUbtxz1NQn4UO5xBNs85sAKZX0BdeKq8gWIy3wX?=
 =?us-ascii?Q?WTg5dBtHnHGiuwU4vplYEsS9t0LXJZsUHQ6lSELBS6pyEo7Xk0p4O/uV8yh0?=
 =?us-ascii?Q?W8ddIpdWrFBOcuwYJBjxh2qnMcockicM1IbtmalAgTm0YXZyBvMpWxVcfFdw?=
 =?us-ascii?Q?PQyyq5N6Krd5XCesH7q+q2Kj0vgE6IeFxNZxzjcojZvzo5WqEvIlc3oBDWRf?=
 =?us-ascii?Q?2zitUfUbO15DwbH/itHKzt+JNXmTR/zKn0xeJX4IviBUXQyRW9CFD+dAJu5Z?=
 =?us-ascii?Q?4oiY6vmTp3bEuhZ/r9MUkPBZKpjM3MZbDf2Vaqv61sftzQO1VbjcGBGilxAB?=
 =?us-ascii?Q?iRognG2PFu770A5vy1/i2f4CLLk0sI7asrtHiSA6JPTYRtOTuaQr4knmxAjw?=
 =?us-ascii?Q?nSoU7dhU4DuWgsWUmp/o9FQr8FuHsr8LZ8Y2oAk1qgrZS2gmLuFCNI38BqF/?=
 =?us-ascii?Q?xIb/sesc7gJ4Iz0B0IBdJVFBD0wdIFmYZj1oqnmT8o9OweQEIrccWt2BKGVN?=
 =?us-ascii?Q?Bwru2KNJYqgEzyDXjhg6EmvtGns8s1fblnff3BSyZ6+OQhw7oc6VFud9qebD?=
 =?us-ascii?Q?tiOOKM7QlneiqI4sAd7mnDUvVyREAtId5eVW11oy37Y1mgtFhpr86YLVkezY?=
 =?us-ascii?Q?8ehqBoNNGEc9ZD7icEtyEEciKOCFk3iPryo39cyf8pfWTSgKvEwIkDnZYe8H?=
 =?us-ascii?Q?/533D/+W/vgbgRRzTIkNenzt5gi+Aqhu6Gw0/gwfqKSEB2MLwV42eDfUK7e3?=
 =?us-ascii?Q?5wSFWQsEvG1BGvpeuDWKcQ7eEEvgmKJ5XxSzo88cVzJieUpO5/UzO+MiV7bS?=
 =?us-ascii?Q?j152jdmTwlVv6lh+Svl6B5KfWdBeofzDysmc7Qe7VgpEMeXwJTaqz54xpPeR?=
 =?us-ascii?Q?tYNtxaWTIUdY2VNCWfFmW9qO7qS5X0bVxEwYAr5ArTYlrJL2r3FOlx3u15FT?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6bc82f-85f1-4d7d-fd41-08dbd3ac9039
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:51.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPwfvtcto8oeaekIK4aMzvnfq3aFW9yhG/8UoIc/YCJk87l8Ql43XuBK/CsItla2eLaBvs1HWk06ufE5JSuw4h2oVfWyLcoL1DDhGVPM6gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
the ethernet frame. This operation will increase the frame size with up
to 32 bytes. If the frames are sent at line rate, the PHY will not have
enough room to insert the SecTAG and the ICV.

Some PHYs use a hardware buffer to store a number of ethernet frames and,
if it fills up, a pause frame is sent to the MAC to control the flow.
This HW implementation does not need any modification in the stack.

Other PHYs might offer to use a specific ethertype with some padding
bytes present in the ethernet frame. This ethertype and its associated
bytes will be replaced by the SecTAG and ICV.

mdo_insert_tx_tag allows the PHY drivers to add any specific tag in the
skb.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4-v8:
- none

Changes in v3:
- improved insert_tx_tag flag description
- macsec_adjust_room uses the difference between MACsec room and 
device room to adjust the macsec netdev room.
- macsec_update_offload return error instead of goto
- macsec_can_insert_tx_tag renamed to macsec_needs_tx_tag
- insert_tx_tag flag is checked in macsec_start_xmit
- "TX offload tag" replaced with "TX tag"

Changes in v2:
- added new fields documentation
- removed unnecesary checks in insert_tx_tag
- adjusted mdo_insert_tx_tag parameters. macsec_context replaced with 
phy_device and sk_buff
- statistiscs incremented with DEV_STATS_INC
- improved patch description

 drivers/net/macsec.c | 92 +++++++++++++++++++++++++++++++++++++++++++-
 include/net/macsec.h | 10 +++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 87ae7e1ff99f..83df54518df9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,8 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @insert_tx_tag: when offloading, device requires to insert an
+ *	additional tag
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +104,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool insert_tx_tag;
 };
 
 /**
@@ -2583,6 +2586,29 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
 	return false;
 }
 
+static bool macsec_needs_tx_tag(struct macsec_dev *macsec,
+				const struct macsec_ops *ops)
+{
+	return macsec->offload == MACSEC_OFFLOAD_PHY &&
+		ops->mdo_insert_tx_tag;
+}
+
+static void macsec_adjust_room(struct net_device *dev,
+			       const struct macsec_ops *ops)
+{
+	int diff_headroom = MACSEC_NEEDED_HEADROOM - ops->needed_headroom;
+	int diff_tailroom = MACSEC_NEEDED_TAILROOM - ops->needed_tailroom;
+	struct macsec_dev *macsec = macsec_priv(dev);
+
+	if (macsec_is_offloaded(macsec)) {
+		dev->needed_headroom -= diff_headroom;
+		dev->needed_tailroom -= diff_tailroom;
+	} else {
+		dev->needed_headroom += diff_headroom;
+		dev->needed_tailroom += diff_tailroom;
+	}
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2620,8 +2646,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret)
+	if (ret) {
 		macsec->offload = prev_offload;
+		return ret;
+	}
+
+	macsec_adjust_room(dev, ops);
+	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
 	return ret;
 }
@@ -3379,6 +3410,52 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct phy_device *phydev;
+	struct macsec_context ctx;
+	int err;
+
+	ops = macsec_get_ops(macsec, &ctx);
+	phydev = macsec->real_dev->phydev;
+
+	if (unlikely(skb_headroom(skb) < ops->needed_headroom ||
+		     skb_tailroom(skb) < ops->needed_tailroom)) {
+		struct sk_buff *nskb = skb_copy_expand(skb,
+						       ops->needed_headroom,
+						       ops->needed_tailroom,
+						       GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	err = ops->mdo_insert_tx_tag(phydev, skb);
+	if (unlikely(err))
+		goto cleanup;
+
+	if (unlikely(skb->len - ETH_HLEN > macsec_priv(dev)->real_dev->mtu)) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	return skb;
+cleanup:
+	kfree_skb(skb);
+	return ERR_PTR(err);
+}
+
 static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
@@ -3393,6 +3470,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		if (macsec->insert_tx_tag) {
+			skb = macsec_insert_tx_tag(skb, dev);
+			if (IS_ERR(skb)) {
+				DEV_STATS_INC(dev, tx_dropped);
+				return NETDEV_TX_OK;
+			}
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -4140,6 +4226,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
 				goto del_dev;
+
+			macsec_adjust_room(dev, ops);
+			macsec->insert_tx_tag =
+				macsec_needs_tx_tag(macsec, ops);
 		}
 	}
 
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 0821fa5088c0..dbd22180cc5c 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -316,6 +316,11 @@ struct macsec_context {
  * @mdo_get_tx_sa_stats: called when TX SA stats are read
  * @mdo_get_rx_sc_stats: called when RX SC stats are read
  * @mdo_get_rx_sa_stats: called when RX SA stats are read
+ * @mdo_insert_tx_tag: called to insert the TX tag
+ * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
+ *	for the TX tag
+ * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
+ *	TX tag
  */
 struct macsec_ops {
 	/* Device wide */
@@ -342,6 +347,11 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	/* Offload tag */
+	int (*mdo_insert_tx_tag)(struct phy_device *phydev,
+				 struct sk_buff *skb);
+	unsigned int needed_headroom;
+	unsigned int needed_tailroom;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.34.1

