Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06079E953
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbjIMNcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMNce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87119B6;
        Wed, 13 Sep 2023 06:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGLRfSREmuUiShwnk+fZk1MmzKgrO67/qoR91+oEAM9rNAro959hIN0xj7QNP3D34Tp6DahdCSaV02uJpHO0SDSKgXlrGqvCCtxHuKMibabNgE+UweeqpDi8x6HOIHUDGLUS6icT7wTmmAOAfCVw+kOuRuRfSJBRVYDPPa6GSycQzIx/iVkFhJZ1lD+rrNNxhVYsrhytEGjnwNDoYfsBcuoDSdL61F4EN9F80nNpJx7v4vRGtlpDUQFAgsfQYA4LHKuIPGeQG1yatQF8/RmID6vUOoTLdGegD2BYwJUiles1/WOWkm6mh08xA584lGbNVg1XrXgVIPss0PNa8mX3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCJFzeM5hn9SM3X/q8TaJ373ExmxEulapH+Jc4MUHFQ=;
 b=JwRRqwbSLoud/yXZmPieHAnAuEO+7k1FUUCVDlM/3TLAog1ehP9rWmDtCwkpofBNIoQRDGRBt09CpCxlbfMgl7sL8uKF5L7ZP9/rnQiSphnwPta2ftMs8O99QoYRMIhoma0ItWM8Iy9FSlK4W/1flZO+TpypcVA3gu/bwsekQpzAjIJGhSDCT9mucCPoSadpPU2dUOrdWsG009mAVTyc61mEk91ytdK1A5RMWRiS2e7UnQAI1yJekDb9SJmGmfdNvCFNN7Op7giAJbREPQYKgBIiv0kG+ia5uvASZL28frAPIty5mzAlr5aGrtdaYLPEdATgR5R59+MGYYflN5uxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCJFzeM5hn9SM3X/q8TaJ373ExmxEulapH+Jc4MUHFQ=;
 b=l3QlsPGYMjnC9wkTTqlQiHhEkNtrW258h99/rS5YcmhKgxOGW6BUYSjz7X6O8+kiz6tRrsG2/oDP7KUn+qPcCrJbbAPDfENT90PWljMuoIdqiPds9y1tK9rLw7np9nkj8XMAiuSKN4+TRKom4e9TNm6dEG2lEaoo5rP5DghFr9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:25 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:25 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 4/7] net: macsec: introduce mdo_insert_tx_tag
Date:   Wed, 13 Sep 2023 16:32:02 +0300
Message-Id: <20230913133205.3749628-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: d98542cb-c88a-43fd-b22f-08dbb45dde07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfGeWcvyIgQuoj/FLqTLB5ezoGHHuwNQVyHQivSpCnHgsmNN5qADZj9jbdsaRG0+QZOs2UaJOPq02GPD/HO5yFUe0rXltHJ8wRD1r9EefohnBw+Y0o8dVY4pag+7eEOyQtj3uMWajgmyInDGcI0PyKKhKae6+bISz3mSwxLLWw8uuN7XnM5mJyw8zelA35J9d05T1ss6hlVqEi+Un7kfNELmsxtcSZwedWSAnbUH5tgWoSpFwJyc1xBGEjoLnDR3ZWfC5xo/53njqE4agD8cLSJYPkeAwm4fqt5e3HwjoPRbwl5oL6yKkRk4Ckgl/HqNUlUIx66qf7QWOqNOj6FBPuzmyPgBMx4ToBS1HAwgZLfkqojiyqbywOhFOhOALpZ86tn1FfndXCBLuxWSzZ09JNghJ7ZNsqtzoA6p0wYuYpgYamV6IuwrFtyKBosU6x/YeG7yanF5lwNMd/+pfNTSuN/r0ioTIe1rca87l46kWN6Pxpy1VyiqD+zQjwXRTRzDQgdIY0J3tKy7P0GsgQhVGTXM2ENFHFsC6kv0ecPtWAJBOkU2xFPM6shCMYRgAsm74TeBuJc6kLrt9Jc6WMB1Jl/RVI3Fa/FWSbknUjEeDEfanADgT3XrBra3ANLpn01rti+44QEbwV6bstdBaYFQ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(2906002)(66899024)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?auAxlS1VWNHpqXXWKTBE1emLqNJMDxj+MOYGdcbezapNESoV2J7kps3zWOUg?=
 =?us-ascii?Q?HzKNhFh9YtH64AFWfrultfQpXKSNkwDlRJ6chs66U7pF58defsjwN6Rk+mck?=
 =?us-ascii?Q?/EmkccIXr1Ww/moAQFCgLfiScdtRVjsLB7xmNbg9dY7UmFUhKzn4j6QSrVbq?=
 =?us-ascii?Q?a6X/ZxWJZe0DSlbqxdQCCJjQ4Plk4ZKKnt3cgCOjlvx3YFf7I6tq2A6GXgoX?=
 =?us-ascii?Q?ctf0iUFRyyMRAL5T3AhXNMWrW92kbOnQJVhQiz6IdSzAusacZxgjo3rxrIM2?=
 =?us-ascii?Q?+4VLW6TW2c00S8Uy1rcsGIvN/q3i84QziWEg/E4rH9S6Okp2NYtv9wjOrxPC?=
 =?us-ascii?Q?hjaUrLTGozDI8SDCO4crjJnRdmLFOAMr6bipB3uOsXJ1qvyJ6nF5wuluivkg?=
 =?us-ascii?Q?Vhrs57CgyShI7F7uN5MBmYsvJt5yf7kdCqVzALcfMooyT/c8F/RTLpUXJjCL?=
 =?us-ascii?Q?4rIrj1vwgzXopMVk157/wjS6xZ/xuI/yPPK4/JJILWfge0+5ij4nFZ0Q5c2J?=
 =?us-ascii?Q?ZKpr9J13ej/DemlroHmczbaPQdqi/UYG3GfNsZnCs7TBYfd0TlCyH5xmQ+U1?=
 =?us-ascii?Q?WjSNSkXE+s85/1/ufJUggYgg8x/gZPkSeDojdkZiCaAWzzHgWI/gNbI/R8qf?=
 =?us-ascii?Q?4VOEkFXj5qvX3xbkBn5e+B2mMxwsu2qFt0lXWLmJNQQJMmD2+756My8kaVaM?=
 =?us-ascii?Q?SH/hQja6hG0LVpeXLcEJL3FJKDNmmZOVOSMlan6bVkCTeSeM0fDKKFUVBc85?=
 =?us-ascii?Q?bp/w3t30t6aM9MPY2Vo+TlJ608zh1A1cCEB53tSje0Jo+gI4rTVvtEqr/uWh?=
 =?us-ascii?Q?eM1D25NF4hJI0LWnjp6W6RKo2N/K1iU+FPOtHdwU812hIHp7Lh3oQbJaFBcw?=
 =?us-ascii?Q?IlXHEIGi74jdN3U62JnysTGgEQMgyJCf6/2+oIJnY69TPwdLqrcr+APKGQpL?=
 =?us-ascii?Q?peAxgcJmDHyPO1ymWWmsJftTlieejA5eJjemYZ902sC87D0K+ez2EJtR5LkK?=
 =?us-ascii?Q?wtkaxeUo7ndKxZUx5pxO6yguCwHphWIAx6CCMpDBBwzRQCbmeIchzQo55wyd?=
 =?us-ascii?Q?dO3+wttX56iZUByPgfbRIYM/aB3O0DtbGeNqo/TyAO/9NTFsRPkIyy231wWk?=
 =?us-ascii?Q?HJVzpYXRWrT10/5Yrz49MytQfDnLfjG+NQog964AicsfWKLeSUudSgU70m7s?=
 =?us-ascii?Q?5RGJl5qFE5F5SIZ8WOV0ft1tI5wQ9zfglJbYH4F/Hff6xkVJnyIx5RuwNfAl?=
 =?us-ascii?Q?CsFDw4P6ReOT31spdtxrEDNS/YEYG+Kaxhl0e5nd6GEb4nRlSImBqllhKxkc?=
 =?us-ascii?Q?ue97As3g4uNCCO3FvakjU5CFb+hzE3mN6AWYLgZeIcFF75APsGYszzlYWHxf?=
 =?us-ascii?Q?B4cM1IpVQ8xBtaVB0ATbEvtgf/lx+I3Cu994bJm00D8lyisrE1u0zYYqvFyK?=
 =?us-ascii?Q?tMsdUPsBfHSkja3oqShBeTWs/mMFWp0Ns5jF7JwQggw8NQCfTWjRYgZB+zlL?=
 =?us-ascii?Q?UVI32sHy0qFQeFihuZ05I2PtziADKxh6QMTWOeddRO/rQTrqQsxJB1Mvmk48?=
 =?us-ascii?Q?7xrdxlq2Wmn3GyOAsiYGyxPiTnXYZ9c4pJOrn92PnWazloGlHhojahb7NEvQ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98542cb-c88a-43fd-b22f-08dbb45dde07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:25.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwXgVwI4wDp3sOr6IcPvGjug+X1N10zvLkHl3owhKKJjKYdafksFu3KV3pwZjHijnMTMK3oWxveRzqDBY5jjf/WruvmOHImUGNzCk0oEntI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
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
Changes in v4:
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
index 2dde22e01fc1..eb26c1aa9b0f 100644
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
@@ -2584,6 +2587,29 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
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
@@ -2621,8 +2647,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
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
@@ -3380,6 +3411,52 @@ static struct genl_family macsec_fam __ro_after_init = {
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
@@ -3394,6 +3471,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
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
@@ -4127,6 +4213,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
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
index 5e0b24a2f49c..9fd1103e1d36 100644
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

