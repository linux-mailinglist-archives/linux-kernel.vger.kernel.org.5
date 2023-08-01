Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2BC76B76F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjHAOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjHAO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CFF1FEE;
        Tue,  1 Aug 2023 07:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSI32wWaMSAbOZK0me8eZENRrwhzvazQaPYpNCixx6mV+z9bmTqXBTAoiygdr7kYqIHdwPudGVlhJWs+pasRUd0ji/Jz1b04eIlDg/+KZ4JR/8MDY+THe2BCEKb5tuHv8tartemT1CfXjviTQw0OyZuArX61zcVj/ZhIWRwX6q9MyUxKjTNC+rSkPWd7Pj1un02ckHvdpzpj4UlAvU4jdj4pZ3GtXO+JIBRxUoehDc3OBETudv0VxRyCiGH7ERqGJuac3fc9bYX5tq5aRMGBWAiDJ1NOd/4MQ4wfoBdhlFo+4KV7rhO0SuE3UcGx52UQ+UThOJNn8xRxhUCZ3Tglbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fSV6n6ByWaBUFa/PhwXrGfebNqxoJ6b+fUOA+eKRH8=;
 b=UsPmR2jHlnmmbuYC1akyqEwAAtlWRCaSMokzCSsficRPq9QYlfiPu7QHmHNVyAjLAK89/DJHvB/S8FUJuQ+MJIFG2WyfzBj0d4trk1EqxajHaLfyFBDEFIyLBSfqVdNau9QxNp0SQDjTEESKxk2XSBUXJAhiW5Bm9JbbELx0Jt2NyaVZS0YCj0eWrNYnAxGw/VqW+vFscrCymtE9+b5xyrHKUgmMGiPqcbevKuytYk+AHrl9ATfrbqrk9g1LB9+g73e6YsaDgMTp0UjP+6Iyb+LD3sddYpDSlm2wgnk7WwAM0jlOE4O2XWlzbpBmiFQOL7FDSdFkvPgwhSuLIgjwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fSV6n6ByWaBUFa/PhwXrGfebNqxoJ6b+fUOA+eKRH8=;
 b=HE60ZLJ7K7wXUx1yQ5Zvq6oZqltDoejM1HH4vlcZG/UnIt64CZPC662AiqxoFv1hXbvpQ89OtdzlguL6/EEZYx2iwob8soMQbDy3KzF00tTYhx4bVb7/u3Fsc3i9Kb0ja4MfI7EaJpesFr0vR2swc+yUhLU9SONNyAx4D29CtVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:34 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:34 +0000
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
Subject: [PATCH v9 net-next 06/12] net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:18 +0300
Message-Id: <20230801142824.1772134-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:208:122::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 97031a46-46ee-436c-7a73-08db929bb9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8hXUXeMORx4TSgKiu6YZ7b9DEKyD0Wh3xJAjrGaMWYu/2tlzSNFAZSdnf9jszgvQRhWvCsFs53z9WgTXLEEivAC791DiIUx8S8eZ1I8IU869cFss/L0kRUfoKefRUe8tEFhOYpiOQayLCGbJuPYpXGtRu2Dvt0JI533atwvR0cUCV8uMOFGaTq8NITyc7GdVZvffG5aNVyfHIpkDhoZGrq/zMG6H1OrYcAeeQBrdGPdI2cnt6g06ko8R2UrjYuukWALXKVWSZJloMhkTBNfrfHEJFYyPPeh9Zpmo0i0jyl0yglrEp5xKc7XotfIcniq9WxufbBHu25bD4af3WqePdvBkoVzrJFGUAt7+Mc7B8l2g3S2DRPds8BFFeEvSgVfz+znZ/qzd9+mMSByFQb3so0OdbIAfQKg4BtJohBWSi0eumcXdxdttv2WUEJXmY58lGqzr5jHTWDCt70qDGzXMnywyfQTtlEDpb/KPdovwH9XYC44EJh2TBFc4Z0/FHUBhG8YVmc8H5PtT7sgzQmy9G8DyNFlfkyd9S9l7n0+s/8DZMfpYVu41o3eV08IitUcR0FcEPunsfRRQl6yiBcFccO0H7CfQZ85hzTFuMjflNCPX28SEkEZOzEsWy1B6knf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8h9gb4wO5jMbK3BPxjqg33vZBQGrBgq9HNMdKV0QuMCYNhRzSdS4DrBsZMhN?=
 =?us-ascii?Q?IkOp09WVjkYskKVlUrL87K3kllbajB8MiMgWf8jKEodqBkt/lDegNEo/jkBb?=
 =?us-ascii?Q?N62lR+IpU2asXe37nbGTcKlkslSYSbQMws6SR0L+p+rMvf8VrtMNBr96OInr?=
 =?us-ascii?Q?RfuEGU2pNKajMiGPuqQI1peH8v51jL9F1s1wuZt72Kh3FQFQglHWLyEkwaKm?=
 =?us-ascii?Q?nkJVAMMmsem96AuEh/UQQa6hfEIPBVmFi8I0WjlATbzZjLraFI3er/gciEqy?=
 =?us-ascii?Q?+lBQ1N4JEqQchcaLO85XLyLODiPExPtRXA9fGjkldAzc3AAc7OdIVcqHgVH8?=
 =?us-ascii?Q?scAVV3IAF+fmOu1OX7mWBnDZdusz4sJIXbcqt7/vQf27JQoT7k1w/DDkwtSY?=
 =?us-ascii?Q?CdnvoDGM2X3DmabV16xpp/IK/a10Uf8NJrV/tQ6R2n4zhRfATg0Tf39lv5eX?=
 =?us-ascii?Q?Rhy96LbpsPlUP7h595q3gDQJnf/nMYILSNvrJqyXsMI1pdmRGVfrPmRHpkOy?=
 =?us-ascii?Q?Yb96T6uSBRIO94W+7bfVFfRmUPv1GFAsN8RXAMk3nAFjgo4HompppcohiT5p?=
 =?us-ascii?Q?JjLB40acwUFX7Il9GIujaj72iVM7Aq+h5FAsSn0FrGBNpgCKuVBPCX70itNK?=
 =?us-ascii?Q?H7Eq5nclB31sDc2x8RioZ5u542lgJxSwYiXlckvCkFjk1WdOb3n2iFdLLK7F?=
 =?us-ascii?Q?xQ5+YSG2dU3YYXPHOQcwJBBmW1pCN4u49A+WKmBVkRToR+5Utl+CCzNpe4hy?=
 =?us-ascii?Q?95jVJGmOBlsuR+mj14OaOz/998DVPWMZ2KMWZdpxy69h58UoUyPWoGg0VOlp?=
 =?us-ascii?Q?GmT6lrSEk+D2VfmzRQskCZS4seZcTXAinxzyeS6GCEJuOEYLT8Qf38A6iBUe?=
 =?us-ascii?Q?bA2KbU/AcKI2qzS46f/guDtVvGzp1IZI6paRvUjTk6jpgq4olddbodcZbjKe?=
 =?us-ascii?Q?80A7H8n7lhAogiYvm2s6/YYUoQqWLZ8MnCKsbauc3gq8pAXNkoWVDRgxPE94?=
 =?us-ascii?Q?6XqHtCt1zVLvImzrxu2BmAhWXLJYnHkbx9UWCFYnnq/EXtyIxxI3mLM1MDqt?=
 =?us-ascii?Q?IP7jPljeeWc/tolKbbgZhV7bN6seAS+RC631Q1T1Om40w3o6vjp9zFk1Tcue?=
 =?us-ascii?Q?42ojv5IlLn/iRNwcgLqydzr2iFGHP+igX/aTijYginbBc0R31dXS+e5xP3pD?=
 =?us-ascii?Q?O2CnGIaz/Jl+bl6yqVI31r083Fh+p4imMbVmZ/87iTjjqc6e3LLr0jSBkNh/?=
 =?us-ascii?Q?WtxgvFMIuEqPnWEU/W0LGaxP1L4zfRmrTJzV7gc/TGqXadkOIy0fVMC0HrH0?=
 =?us-ascii?Q?Sw9ao9XDDz/+6bDb+nWvte8G7MZf0/spovU9C7tcY7GWGHO5PZL+TkXNGCyB?=
 =?us-ascii?Q?CgGPSQ5s3zK/vAXvRU8bmDK8ICMqAF5ekasf28ufwAe9XTne3TCVuwIvRTHQ?=
 =?us-ascii?Q?qi4hVICOy6F9OIl5KkMEKdmSdIPRfz9P7EdHKOD2qBdlsdcnKILmA02H0HL+?=
 =?us-ascii?Q?K50JWfmxsoFUNuJ0nQAporcWKe6JTXGeKFGLuCroIOZ5d/qmd3gjwkXi91rv?=
 =?us-ascii?Q?X/HCSWpzZBpo/rP46gVPvKjBfKV82schJqGmuZ2W8QEGJPAQgcwuqdDQmG29?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97031a46-46ee-436c-7a73-08db929bb9d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:34.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RIW8uerCeAGf4eh3Nw/ethfHnFrGa89g5L3aoYjxudd+dOjt0AyRLEahrOYOz9FrLgl94mmKMgdVKKBbEikYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v9:
- Add back netif_running() checks
Changes in v8:
- Use phy_do_ioctl_running()
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  5 +-
 drivers/net/ethernet/freescale/fec_main.c | 73 ++++++++++++++---------
 drivers/net/ethernet/freescale/fec_ptp.c  | 31 ++++------
 3 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8f1edcca96c4..ec64067ca782 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -699,8 +699,9 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx);
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
index 14d0dc7ba3c9..bbd0cc97905a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3203,33 +3203,6 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
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
@@ -3895,6 +3868,48 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
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
+	if (!netif_running(ndev))
+		return -EINVAL;
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
+	if (!netif_running(ndev))
+		return -EINVAL;
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
@@ -3904,13 +3919,15 @@ static const struct net_device_ops fec_netdev_ops = {
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
index fc4674cb65be..befd49b8bd71 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -617,16 +617,12 @@ void fec_ptp_disable_hwts(struct net_device *ndev)
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
@@ -637,33 +633,28 @@ int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
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

