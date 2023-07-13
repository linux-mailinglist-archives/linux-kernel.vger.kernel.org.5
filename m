Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE475211E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjGMMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjGMMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:59 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A7272A;
        Thu, 13 Jul 2023 05:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHKMIsxVFuWv+u1FlgV36epDugR5lm2g1g81ryFSnms7RRtxedATJbony0keivdRthk2RxaZbm6CctG3ZXb/kKpYxSswxsJdNs6HZ6PFDJu8U6CWc/O7z8prJ9ruiYa0n9EbkzI/3PBPjzLmE8dod1lwTQmLsPvp1p0tFG2RWCEksB8mqKhsQ63RyNM1G/Pw+SWstXOc62TDbZD2icCA78iyiCSzf/3NAal+bvsG0rnhott9rWjBLB8d3bXjvRVcKcUMnvcdDTIpV59jBcNLFSYdejWBZVvwWwAaW7NIb1v74zV2Ns3qsC64ara4klXBKZPwJ4o3948q8/WRp10o8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAt9jn4u8b6uI1uKhfP0bkrH/svMOBmv1bRyEkomSGo=;
 b=hOeO0I5RhRVynyO4NeMUPhTF1HzXP2MYac6//8hH1ZR/VlBXPOhrlbBrLZgcg9j7VEhxJJen67iV3JVMAsjnwV3rzfQYuqh9E6vtedu7RNO4ZSHzOPMWq5E6logons/HxaIqmz+m7KlkLJCwHMw4fElExAffp7KGpIo/CcpO7wA187mqfkLy2Q8cHHyII2Nxb60DZzT9Frag8T0NQiQMlsvNQILu68B/z4KshWElCcvxpciqhnVWsGVLmwIStOjmJSEKTEHK3XDSY2sr7XuS4xaFySygNJSx7/fBFyqlia3YW8SUmUoxWj8pw6wgLRCFHB+n7/nNgy1CM4iMrrpL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAt9jn4u8b6uI1uKhfP0bkrH/svMOBmv1bRyEkomSGo=;
 b=aCjoZoWxhU9uuzvntqi0Zox1q60nbKEr9Xn7LJnKTzrLk0DrI16H6U+xukh2edaZJNCzVvZZgv6+sorWQBdRICH7cbp980FHLgpES7tukETp57BVBEjMZxYgU4DI113zqyfO1tXsehMFcozSSNrUTdKyvpiMImCaOBt9PTP2Aq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:40 +0000
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 06/10] net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:03 +0300
Message-Id: <20230713121907.3249291-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 30727cc3-e684-4c56-60a3-08db839b6e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2+wSp5p/SiA7e8bky5EVt3yXTcFmzagHgHSJpZtX2Y7iZrz9J9/4wezXlXuW5zI91vo0u2wsQVtv95JVuds7po2LFDApbX4MbCDN8tA6Ii5gZ0mu3Sqx0iyJ1GuVaG+0WlMVOy6hKYJ07PHgb78hdLBMpvV/Lp+sG8Yyusq+pslxioaAQPieouFhwRsF78HSPtS1ghMhxwGP29Y/djuFJYM3MYyDRw7fqROQUdMBhflcMbMiJ9pMlvmg15ikishOiNoksmZmeAwxpep+vTahTaEEAXDc61SHLe6V+rEuxubwG+157SjySJltdUs55+YuV0YWfCI08LqazedsBtlhOrD7gtbadwCviPVNapueYxSVL0gCgNk22gVVtGOIYKSTqWDcEM+eN9YPvSBxpq3sK4tqIyc6CiVO5JhwHeW66UJlGHoAjS/aIBlpRSyaOyOCs6vgKZDzSGa8+kMFuAzAUp7QuC2x23k8QaH9NJ/8XSUoSf7WMt+3XuwJZEuUvAVCBIOyP7FK5GvzzVXZUXxL1nfOAs1BZHS/7Z7tkFnEFu9lXXyye9mxAyx697XGJPUySw5EwqtDEcuuXrYf1XGINzAY9jLbAciY5KvXrNDNuTv173/XR5FuGbBZ1Tq+qtp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtMPoGsiJyQgNRQsSonMqcpmujqFUBVc+X2Tg5rlLK3jQYtWQYmgdIgS3XAx?=
 =?us-ascii?Q?+wU+4w8gMr2XQj5ki+2aZRvn1Q+Gt8bHT1AYGtT2/Py5KV074Vjvl6+a8k6T?=
 =?us-ascii?Q?riVKJrbJsqkKUEHRC+WUz3VvFbt0nLyeiMo0qt0n80Q8NSmj+ZT10gMkQ2f+?=
 =?us-ascii?Q?jNhTlb9RNPE+bhMJ2w5DlcpDwRQONEKs7lqAeFR1skCYMikqyC6uKmdsxERa?=
 =?us-ascii?Q?WAAobLzFrXmqRjUkAL1R0VLu3q4NrwBLm1BbLY1rhI1fnq6uKkEuMAjibuQm?=
 =?us-ascii?Q?kWukDJ7O1gQENJTKydAGYXzNOaBLFKLrxqv4pxH8Tkq7lMdpB3geqp4WEtaM?=
 =?us-ascii?Q?a72d1i/+S17ESnyAcHKMmjpFljki81duCmO2mKsaa7P5Dwxdv4roXf1QRJrQ?=
 =?us-ascii?Q?k2azAgv+twCtfF5pfvB2R6prBp4EVAUsp5FI7btJ+y1SrMdvUuTUwt3rzz/f?=
 =?us-ascii?Q?wheyJS0czAmg+anyLlg1rq5wnJ91l8t7eORPdo0ibTWHawdWF5DHBfpTPUUM?=
 =?us-ascii?Q?G7DYQ9EALf+G/ctZtlCPGApj5F++rIxC4cF4dua8Daw7rpEOS8mlqSbGodX/?=
 =?us-ascii?Q?J5vMDuFJ0ijHMtHNZrfKdmrYwmsgoctO1wAYpLe84/uONMacu5OnRQwFVRyp?=
 =?us-ascii?Q?L9QwFnznfVj3ed1Hpihhgj77uCeCEmlf3ov0zInDCQk5bcOGZHmZqtHpKTmO?=
 =?us-ascii?Q?YWho2TY4bUSYiSzIOvBM8mbg+iTIyfTPbVxA02YVIvMPatWixBzIn5Om645E?=
 =?us-ascii?Q?mjgoei3Nykc40Xjh4vi0WVVR4i81x5ju53BuWzwCulbnBNM15AdMYdUlHCxs?=
 =?us-ascii?Q?3GJhSarvzvOXrGXBWLdMdDc5c8SAjz7tbSJJvs4yjafHWciY/36n5P2Wb1E0?=
 =?us-ascii?Q?eyoy049G8uPVsYu2YthsxVhnM3bwzdlc4HM759JdZfaUy1OYVWMsbiaBZyEc?=
 =?us-ascii?Q?CBn9rJClAiHFIIRWp/n5kDYCoWnhoKLwl2utrPR2GVgKd0HxDqdPLegXF0AA?=
 =?us-ascii?Q?0XbmJSde33DMTD3l7Ijywa3OJYKOx0Elr4FlkN2RO/Bj0Ynuu1GY51m4SOo5?=
 =?us-ascii?Q?UMhbWr+ij0tD9QNhADeV7Y9cT+RWCslBUv8KGpKH3RtxfUO9nHigCD/zquEF?=
 =?us-ascii?Q?trG1Uh+YefnDmusHkm2wOZXSQ7WCKBQaul03KqO/X39UUV7heRV5pT5xxK5c?=
 =?us-ascii?Q?7rrib/r+PfvyJi0AbCY/JmM1GDz+89r9H+Z4CGBPxA/9zATKq9+4pLZD0vK4?=
 =?us-ascii?Q?C06Ox1H8UVG0yn7wKd6l5eFRmIREQDm3/Fnk3UZRDBhqSEH1ny31GOFpBQS0?=
 =?us-ascii?Q?rgz1vMRAOdus/+Fjk4q1Mq7LgxpmoGrNtD+aWjIU9o4qdDqh9waggAnyRhKT?=
 =?us-ascii?Q?gOrZI1wqLvzM8QiS3bl9cwrwCpR3gjBCZXc+32qfMEjO+lslwRsGFFRRF3TK?=
 =?us-ascii?Q?tOBOHrIaWfnNjip8o7fm/zJAU0BMZoBZJ8VBWRZLhDTnTt5MUyIqQveo9U94?=
 =?us-ascii?Q?pIVtt45t2rM5bZm/GqcnkJ499a1+tBjgdFDBWzvrUkIILgpmyXRk2+sdtBfE?=
 =?us-ascii?Q?aMTT5VsX4GLhzjGpezx/mQUlIbuBiNJi7+VaCSTNnEwPlhxPFxs6/7QpNVWo?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30727cc3-e684-4c56-60a3-08db839b6e80
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:40.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYUvwGL+e/loYarrmwALywTFUMMaD+Mqd0uHddnZNNLwOAhzm7V42zclADX/R5no5Fz+jQg6sQ3J2wkmsbngZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the FEC driver to the new API before that can be removed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  5 ++-
 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++++++++------
 drivers/net/ethernet/freescale/fec_ptp.c  | 31 +++++---------
 3 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 9939ccafb556..d4ae0e7c0a44 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -691,8 +691,9 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx);
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
index 1280da699fa3..c0b68fc3ec8b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3196,7 +3196,6 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 
 static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
 
 	if (!netif_running(ndev))
@@ -3205,19 +3204,6 @@ static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 	if (!phydev)
 		return -ENODEV;
 
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
 	return phy_mii_ioctl(phydev, rq, cmd);
 }
 
@@ -3868,6 +3854,42 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
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
@@ -3884,6 +3906,8 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_hwtstamp_get	= fec_hwtstamp_get,
+	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
 
 static const unsigned short offset_des_active_rxq[] = {
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index ab86bb8562ef..3f53b8ae57dd 100644
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

