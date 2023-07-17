Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A487567FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjGQP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGQP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DB1723;
        Mon, 17 Jul 2023 08:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2ujHbdLyh/N3FWAP454bZ21cbFBQEghfZxx3YvgTxUXkOKwEicSvBnPdMV8MYRBwJxjA4fwUVV4AiK9EW+CuyzJeUDKIxhQ6zPB5BT3DWe4/IHC5F82VJwXYPp9NspdN1B0b7xXNrkwpIiqLLok2AyJ1t3JJzX8FZ2jcc/APyPdetADlT6D4rC8CnvwWLXKbCUBDlr2+pq8fGyG4xak/Y2v1wkDX1k6RVKgskz6sWjdLqDQfaeJvs8Nuj1QUIZQwj3zh5RK1HKY4KgXKpHvVfc7S95rqtL2YHFRAHwTidSQwEWq0CxW7/iTygsBKkmGwO+bTb21rw2MnAe5TotuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf3LGB//DyDswjAN7ULL/qkbov8wZz/8LILpVHSu5No=;
 b=dRHylKNTyuaNVgTWEbAekn77xRhZYYtlvj/RgusjycRw7SoSoE3PLgb8OsM+fYv18mdDITdTr7QSeK932+0gP9c6an/gdSYjeDwjztQP2xvwiX9b6+Jy/sYN72HpC3KQFcboqqf2+UgFtLfK2T64+FL5kAI/ChHelrHgaM5PicnocbMMRtNwI35dLFu+n+t+aSszsK938gNzJAuHfeYKrUoZFn0Bpn4ijqrTSe6F1m4zx38MUTG7bisDyvaDLSgLO2+gA6Qbtn1JMhnPpgg5V7KcQX7/rgw9CBScME6Ct0Q/cjRfl/BvGL8DMe09xPTjctMYHktyg84ot8AcUeHqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf3LGB//DyDswjAN7ULL/qkbov8wZz/8LILpVHSu5No=;
 b=ccJMkTnUpaMymeHqWagh4KcDXaWt/qiqriPePP2+TYseZcbi0rLCxK7A1vY4D3zDAtjj7+/6+ozDBNQAngdRcffSujBiOo/i8abRTiu7TdlJbTxRGP7l5an02tsRJnqJNTPotie39HyAC9hLph4n6Lsg8t4TqsnW0ydMK2XgMmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:35 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 net-next 06/12] net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:03 +0300
Message-Id: <20230717152709.574773-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717152709.574773-1-vladimir.oltean@nxp.com>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 84679f55-7588-4837-c5be-08db86da58d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcMI+Eo45zZ6BAmmUxWWuMOaCVEHmlaMvmpxvuFlQK2mMEMaGjtrz77t0BnYHF5qQAzybAeMvb29FjFsC7FAmxTYR3ok7Qp+rVo0c/XmzMfJAOtoB8L/XK+Dz3ldh4pAfdIEzn8Doc67TRtS5gCeBLrsIuWpf2Gu0brE34pw3SeDTfq5smBTSLf2L3vIYZhc6+vuSLWMMb7Y7vyODoSBiijMa0ugJH3sSqINyH18Jcelrf0M60RCTk5M5mzW38/O80WrzMi4KOYQ6nhlcp1+hqczG7Qp7iGxUaunkm9QdMkb4KXLAD5zTw4d5oHCl97Msac15vsdg6HQGqB7PaTrCiiaL9nybWr7VeUe5LmPuLkO+a8m5p1j4BcH2CjTCqnsBssEdknD0CNATnLCENbs6jTljLkgarULA0baNF8b+kG5BsPl04LWKbdUEaVxlhwJhwNWIUwSVpFBsSxJyAaCokCuQzKLD/uaI2tiDVpCQeoOkfH2yuZqQ34BkypFoaVBtpl+HuDau2WxbxfYLUlP8xN5SfSYeBd02Phxy6tmG9Sp3AGZhQlLtz2vYzFwiEbVNzPdEKfGYsRG31eyLwpepFfnaBZ6PCibEcdMEifBUsUxx+/Oz3wDVkF/m90FyDHm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ngKcg8eXkDc0QKCwzubSDJrV1neSMgEyMRSrWCk+L6erCggaSyq/OqfP48LJ?=
 =?us-ascii?Q?6rdZURtmAPrUmvR5zSNoPiPJqzcfhLnM6HBvL013Mi5I3wuhNLF1MZst9HWu?=
 =?us-ascii?Q?/q7jMJBGkCH6cgwd9cPaoDQTsUd+SWc6O0HjFyd4Eemb7q9wcupckTbP8akV?=
 =?us-ascii?Q?PDrHfxRrK/kPi8SFiSVYCbW3c4f3xr0RHsSnufTPqa+pQEVsGvzZx7p3PzS9?=
 =?us-ascii?Q?JWsabufe+Zc4uUnD79dgHSiGf6WXXZTNj8gY9YNPWIAVwcSHrrtqw/NOHizC?=
 =?us-ascii?Q?RW4aFLZ3KaiRi5ZUBFx9/F6/uSZFuI6pfHlhFtmwFqmqJmRWRR5gdRGXiFmT?=
 =?us-ascii?Q?DvvofYk1KQXL3LhMx2qGJGTUlND+cf1kFrSGnDJowKgdfM70kkMNdmCQPCj1?=
 =?us-ascii?Q?W0uHest645d8s0EFYgl7l0niiLfRo+Q9+MlqUC+76X08EyImYlKBitIHanaZ?=
 =?us-ascii?Q?ujs7BYkld8I+mvzBfJsA3tojahwQnVcXWvxmZ/OKAHs3k5MDuaKViAyFiZcw?=
 =?us-ascii?Q?j/UdWx9nUa22mBpOD6XAmZA265CdKy9wskYEdUOrWv+v0L7ODRm5QPBdt0JC?=
 =?us-ascii?Q?xkIy0eTQJvCJJbhb8fo1gJ2Dmy4YKBGxW01u4DX0YE+SULW3fqeJV5gK1dge?=
 =?us-ascii?Q?SGkqw6woML6LtpC6Ixrkxegkk7F6jvYPpYPCwFUhfobeLPpZdbdWlJQz4fN4?=
 =?us-ascii?Q?NGU0kdEyQfqbp8SHzqO3qJG8d/aJpcJdg4sZN7wvwEWlQfX/EGflVqE1+/ll?=
 =?us-ascii?Q?W67sKp5CXOwUL3dDNx/EYPC6UzO9UpIm6Luu8zNE4QHdrwNOI7kiApIbeQJ2?=
 =?us-ascii?Q?JyhbAuWBKccSTaK+J6nUyuPTFHUGk+0VtonYmEI6d8x3z9dC8DXVNf9w3Hsu?=
 =?us-ascii?Q?ojm8nziR53ExsOJ0cxIrzI+Ub2DeBLXKi3ZCAQKE1BxR1LmlgVCH8O8Z4M/x?=
 =?us-ascii?Q?ZsYfsW2XojlqI+ObmWm8Ot2qNNdzR+hKwBJus2CicC8ZKmF7ocuDIVkmRr3F?=
 =?us-ascii?Q?gSFKpPLmUEJ3Iqu+pmzmW66fuexA2OBZhAkk6UD0MjTgxPSO1IrsGK8TQ2UQ?=
 =?us-ascii?Q?/PSytOk6KOgKUVMVsLewZxnmN7xZLxT7NedGAtqQpgos+Q0yI23c7q9NdBL3?=
 =?us-ascii?Q?b9prrdYJUNynVF/E8/3b/nbTkpUPYn1r+ocqCs/PX5MSindXB7lyO8L8WerK?=
 =?us-ascii?Q?GEip+//fl06oOP9+9JprkvxWkDRZCnTN8vasxIZFMd+iWxSZYKUgkq5+W55D?=
 =?us-ascii?Q?jymYfDuYniGvwZf0AxI3r3no9U4zdV8W+3iM9eZCtKGpSejLgV8KXDHq7uFS?=
 =?us-ascii?Q?hqZS8qcpgbMMAHvsGiPpIPZSKvhywzInCjDstgS1653k32JQQs9QIp5jZvgt?=
 =?us-ascii?Q?yv6QBX9tWl5I52zrs6FKIVquOG89Zj/FOl5YN5f6loG2OBcBnYKTxDLtjGyF?=
 =?us-ascii?Q?mG8YSc9HyDMUUg2knYQZ8HnKNmCFAa3Xrj4u8UIjLB1DqzoTXKYl9Bu43iDb?=
 =?us-ascii?Q?H1p5slZwV1DewgZM+NzLNlXkts+jmeXyioAEXN94jK0/SWsZ0eMQfTIoC5ld?=
 =?us-ascii?Q?BiZmsyHCXPgtc7sbuvCun90FNADi5PfO6wVcx0JKy6LzWDjLuQ8E5SDUBbMT?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84679f55-7588-4837-c5be-08db86da58d4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:35.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ7krIKwAYXpNkp43T8nOdDeXQZ3HChNGjtKUQMRaAH89rhpfcl5Ql/GpwEWkx4xz7wDK7lRZZcSRsaPnsCo7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the FEC driver to the new API before that can be removed.

After removing the timestamping logic from fec_enet_ioctl(), the rest
is equivalent to phy_do_ioctl_running().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
Changes in v8:
- Use phy_do_ioctl_running()
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  5 +-
 drivers/net/ethernet/freescale/fec_main.c | 67 +++++++++++++----------
 drivers/net/ethernet/freescale/fec_ptp.c  | 31 ++++-------
 3 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 63a053dea819..5d7b76f0c829 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -704,8 +704,9 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 void fec_ptp_disable_hwts(struct net_device *ndev);
-int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr);
-int fec_ptp_get(struct net_device *ndev, struct ifreq *ifr);
+int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
+		struct netlink_ext_ack *extack);
+void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
 
 /****************************************************************************/
 #endif /* FEC_H */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b990a486059..c35b569d848a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3237,33 +3237,6 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
-static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (!netif_running(ndev))
-		return -EINVAL;
-
-	if (!phydev)
-		return -ENODEV;
-
-	if (fep->bufdesc_ex) {
-		bool use_fec_hwts = !phy_has_hwtstamp(phydev);
-
-		if (cmd == SIOCSHWTSTAMP) {
-			if (use_fec_hwts)
-				return fec_ptp_set(ndev, rq);
-			fec_ptp_disable_hwts(ndev);
-		} else if (cmd == SIOCGHWTSTAMP) {
-			if (use_fec_hwts)
-				return fec_ptp_get(ndev, rq);
-		}
-	}
-
-	return phy_mii_ioctl(phydev, rq, cmd);
-}
-
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3927,6 +3900,42 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	return sent_frames;
 }
 
+static int fec_hwtstamp_get(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+
+	if (phy_has_hwtstamp(phydev))
+		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
+
+	if (!fep->bufdesc_ex)
+		return -EOPNOTSUPP;
+
+	fec_ptp_get(ndev, config);
+
+	return 0;
+}
+
+static int fec_hwtstamp_set(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+
+	if (phy_has_hwtstamp(phydev)) {
+		fec_ptp_disable_hwts(ndev);
+
+		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
+	}
+
+	if (!fep->bufdesc_ex)
+		return -EOPNOTSUPP;
+
+	return fec_ptp_set(ndev, config, extack);
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -3936,13 +3945,15 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
-	.ndo_eth_ioctl		= fec_enet_ioctl,
+	.ndo_eth_ioctl		= phy_do_ioctl_running,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= fec_poll_controller,
 #endif
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_hwtstamp_get	= fec_hwtstamp_get,
+	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
 
 static const unsigned short offset_des_active_rxq[] = {
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index afc658d2c271..50943db40f2d 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -618,16 +618,12 @@ void fec_ptp_disable_hwts(struct net_device *ndev)
 	fep->hwts_rx_en = 0;
 }
 
-int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
+int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
+		struct netlink_ext_ack *extack)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	struct hwtstamp_config config;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		fep->hwts_tx_en = 0;
 		break;
@@ -638,33 +634,28 @@ int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		fep->hwts_rx_en = 0;
 		break;
 
 	default:
 		fep->hwts_rx_en = 1;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	}
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	    -EFAULT : 0;
+	return 0;
 }
 
-int fec_ptp_get(struct net_device *ndev, struct ifreq *ifr)
+void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct hwtstamp_config config;
-
-	config.flags = 0;
-	config.tx_type = fep->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	config.rx_filter = (fep->hwts_rx_en ?
-			    HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE);
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	config->flags = 0;
+	config->tx_type = fep->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config->rx_filter = (fep->hwts_rx_en ?
+			     HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE);
 }
 
 /*
-- 
2.34.1

