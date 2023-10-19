Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2227CF808
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjJSMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjJSMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308110FE;
        Thu, 19 Oct 2023 05:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYvNO7fT7KU80/DyZPBhj3h5oOddZul50o37CEY1AVvHUgrvoO4+ILNYtIuGeqehm4j2rdrM7ci2A0jq2QZfOf9jItK1qR8ONLdm1Fj+54Odr+xxI+q+i1Plsj9J8E7HJgZHtC4vEJu69jIeUUMtPYwEH/ONYnBJayTsoSq4My/abvuSh6nSYiiES8EPF3WQTah1blzX8EKQ40ypWMk24F8zRhT4z/0dns2Dtbq0MOx7EvVsv/POGbE2Jgq8OIE/kXUx+fW/j/Ip03DwgDnz3z4C+Qd8TLzDAtTgCf7UXq8u58K9TKcre7uuOWU7sVEfV02aFBxyq89E2gCdfvwhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07+UITJkCos34l0ZZDPSxIy8XokMSdr4WhkcskSbtMo=;
 b=cD27C5u9vm8cQIhHqOIqDEbw1t7uJjVNeoghXBJfTIRCox8ebldcsOq7tGtfZflslm/+JmPaItK8+3fAgsohgWO9ewx9kvMTdmskTYZM1NzZEy/fIA2a8SwDCtUfXjHbRsDB+KoltkHmW60dxsIiVN604rFyZ0SznT2J59fVkle4krNukNO5Hla69KaWIzNfkDGNdekvUOyYfZHtg0D8vhM4S+pxYbgtmB/CRVKr/q3XGY+XFnyhKqwx8W9x9fi/fDPST2ug3lHM4t6My8TtiCvG3ggna+PMlzGe1MF0QVWz8eEAGQOHSofLHRW53C0a8aYmIuqCCMwxL6yuWSgD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07+UITJkCos34l0ZZDPSxIy8XokMSdr4WhkcskSbtMo=;
 b=flgfNy2xhXnOxqDPDdBVt6wqF//ECFSj3Yi2RZG0Xv3rIH472OjFrwc7HkwHAfXi2m4t4tB+NTrltqOqXb/qwZRkkZ7kji7zFTy5xkui4K3s6p6XKPQpC37tcQlZ6nEmhPq+P/o1hHZ7XXVwlhMuKx7TvOhnHnArm9ywNpW3pCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 12:02:57 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:02:57 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 4/7] net: macsec: introduce mdo_insert_tx_tag
Date:   Thu, 19 Oct 2023 15:02:06 +0300
Message-Id: <20231019120209.290480-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1ebaf0-6756-4003-c87f-08dbd09b54f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plY1p2wHBo2nZYxcpwwsctUTIgnaR2Jc7V2yjQIg6abvlpWBi7wZRRB5Sqyw6Mlbry59ejca6q1XNyqbLAtt13YVrIjrhO3GZh3JTe45uEEZYwFG1MYREw1nvRsRmicGQr2eoy517w6ceYaMmqdtYHRxnSBYpddOCjpP0jLYI9kxuTcSgZaikWjHzmcLxxJ8fV/nreovwal5s5WCu27MjQj0lEqD8E8T0V4IBC9RINEH9H3Tl9N/1vqmFnaieal++JswpAjBymspXl7b9THPFBL6goTE1JcWU+ytTwrWG6VZoiVkP5Pe53E2sfXGJXbQjI5lYjS2YjiHAYVQRo5a6IXCopOjFoyB93FPWT7oqLyZR0TXBGnjz00ryVM1KOtq0HTnfSMGx5UfxLfkIBm7lKCUh1O3FwuCUwHqh5J2TaInzRW2Mz97aV0oVsn0RvI/wkTjiZMCcD5B0VvmIK2mXPLmpQgqqej2fHcMxLSDK+uzKen4d8JSI9YZHFMc/d9iN7A0PRcA+NAENxAmjRBxLYp7v/yaEfIAzoAi3XCFL79vqdVW8FdrAkmHlYJfpr20zzpObZnlTD3ynK8g8QUV85VumXqBf8vbfXcHrVdNqyHNuP6MaU0TIVzk5r6C/tkD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(41300700001)(6506007)(38100700002)(4326008)(8676002)(2906002)(7416002)(86362001)(83380400001)(1076003)(26005)(6512007)(2616005)(52116002)(5660300002)(66899024)(6486002)(6666004)(478600001)(8936002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sL1GYSMduGDGHpbfOBnyK4XVabR+N34zz/7QDDoX3rJATy/5zkfcu/wnF6kM?=
 =?us-ascii?Q?DZhKm3Ec/2V0Jh3XXVhsPmMqmbWc/qy02iI2+AA2ZATxC7MJzvxjc9aA+SVk?=
 =?us-ascii?Q?2RbKeiRzaIEjrWWVrTeoqoAzpmO7Ibx5y4De50TQmcClFsx6Ez5xaO6+lROO?=
 =?us-ascii?Q?UgFBjDVSWIPHJe6NxPab7KPSGV13BIRDRMUxJeSUADz02lYVCre1awowgS6w?=
 =?us-ascii?Q?ZlejJmejLV7NffYTImpZH6yZaCQoPdh4m4wLoHST5jTL488caezZou2flYrU?=
 =?us-ascii?Q?tGsXR2mWqugAddTJalA1HdHWJlXuIT/As2+WDIvdYardnITsWfisw4YGp/UO?=
 =?us-ascii?Q?B2OMtioGe30QeXgwzh1W2H/JOkMOncU87JLVNsr58fD5b39Zcy7FHMX41agd?=
 =?us-ascii?Q?gwaYQicsjUVzCPVVSVglIkosIG+0asvCdcY8sQUwyvonlC3H5jiUaY66NFEL?=
 =?us-ascii?Q?5WAXNsU2oSCNc2JUVA54XHW99Vy2UOe3Oyo08bRlJLV+e1TJU2CjuLnB6rCH?=
 =?us-ascii?Q?aJkp4yIrDLDddh7NLmwaEXaWfjuINijrXqxQuxrkzRJ3GFK5SormcpgjtGDF?=
 =?us-ascii?Q?vHUTuKE+iItnNnCNSwQpveRj5GldvoNkPXFPRW4uPcEBzLMXR0QLStnvVHwf?=
 =?us-ascii?Q?sHsRwqVoXmsKtJ8RGeKxS0Nb8RwpdMluFrgivw3oVQJ4i6WixRLNPWtK62qc?=
 =?us-ascii?Q?T91sNd4KtutL3MwXZEokBeXkBos2fKbzzQz0v9ZS1zjAFY57itmJ5ufIKuhb?=
 =?us-ascii?Q?9YQi8Tv13kwIDLzUfRzJxbBV+Udho21DwH3MBAEaTthMKir4FQLUPXkcyV1z?=
 =?us-ascii?Q?EFB67XbjPDena+P5QAyhrou6GYw352HPJo5NZtclMivDo6Xop+4TZUktkNBu?=
 =?us-ascii?Q?rqVvnQgGxDQM8pQKQFgAXXdv1t2pYhwgXX3vJxCwbssezA30DuVWfKGBdoog?=
 =?us-ascii?Q?2h2Qimgr9xqRQ7Pmq/hkm17nyyh2oi2awgkRBPFj+8qw7ymt9K0ZIfw5g3hR?=
 =?us-ascii?Q?R4KTfs4FhgWPisErtns7qewoNLijmmq1l2E6iYE6NmQ4xyLFNA9+9Ray2WGt?=
 =?us-ascii?Q?X9TYW6zWfgJbMkyrnYQGXT0fqx0twpYaLOv4yAOSOp5Pu0xrU37QCpUoAjZq?=
 =?us-ascii?Q?u+BFem0NTjT7w8MHxtuw8P88kH/6tTkbCN0Pq/rcJEyJ/fgxZTm4k8xCSmJh?=
 =?us-ascii?Q?zBPVHOcwh0KBoYlKvdQ35CGUuauMI700I6a5h7BMJOqOAKL5YWfYCPTX+YNW?=
 =?us-ascii?Q?RH0eTfvObNc7Sy2c4TXTmLSkS7nYwK0/IfuaFboSyAEuThGtYqypfuXIa3fc?=
 =?us-ascii?Q?rZCrWigHOHHn5pdPZIMcMudr3WmerE2zNfzsy5903IkJJ2zTNnKKGD84KkIc?=
 =?us-ascii?Q?u6UokixgOv0V7bfbK0yAwdVNLhodCmDc9tJieOJUaVOKX74aWvWYUhc74fYM?=
 =?us-ascii?Q?Y1VToWgG3JuwlFpgF5r+PNNlbcokgjQV9Y+ambOeayLsWuSGxFnmjdX/Ijc8?=
 =?us-ascii?Q?uGYbrH5lsG842b1VtxEaQ5svWu1WXNiugWi7bAmhcG/ybeNCSe1/4XjRRXWB?=
 =?us-ascii?Q?zd+F+fvPyhBaGqKLw3nJR20/gPKRJ4+8vl9YDGtHZJJd9MUVbp05k8Pi3fXb?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1ebaf0-6756-4003-c87f-08dbd09b54f9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:56.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IXGDv81Lv81jvzzboTfwro9NhZpQ/8aCYhLu8pMy2h+1DmGGthrITSecFWPQsdpQql6I+zMmDoP6BpZQQwU+/XTD9dwuMD0wFjA8nXNEAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v4-v7:
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
index 569b27b2e276..57c7d34dcc13 100644
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
@@ -4160,6 +4246,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
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

