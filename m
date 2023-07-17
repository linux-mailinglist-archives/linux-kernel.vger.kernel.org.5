Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915857567FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjGQP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjGQP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED7E4;
        Mon, 17 Jul 2023 08:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4+ghV72HnHWfTipIgTSdpbsfJ5spPCKE25W+4+a609e2KVaMF5IkTZ3vFyE+RrfBCIrdJFtXzmamdu3jSQmYSKjvJ3YW/kLeLwuel3Lyz1ZejM85Y+tTfvK6zepMVWD8UMECT2jf2mL+SPOkYuQxuhxXh3N6as97fxEQMPj/Umohi5gBZAmvM2SL+F3JpDJidJBnDTATs0MmxgQC6eTYTJtPSKMc0LcaREDfgUkns0CrBBCtYrcHVgSPYn5ZnoMxBqLVm9SFveI486OMDUX1jPFGqvHUUV+pAt9hNiaB0vdIyl7rmQafHaESOQ4FySZJC6G7OPuBHshOu0tIwXDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFjoeeps10qbR9+7xOMARTMAfrdxf8YZ3Yp8lRiMMMY=;
 b=KjSpBP5tGFNRzd/Qdelep8ecb9fVWPu+PqCB2WTl0eXMaQ1Y3TvGFyllAnbNsXwNxy71Tu2gHtGR2W8bgSe54YIv2nz61v7QOHuvkRlnHrUAzZLshRfYkK+U4X1IBrlEwCi5hzemhMnyIO4SHH/g8sRgMXlvuZi6PCdpyClUdpiMgFRXR49Lr0RUyDnXhfCIWuMEKEu/yaNT8NptqXlsTUDKSfshg7IslvWkuALwY780B/w8HZ9cWKl5u1f0+cl48KVuxTVNZh7ubIJtnDc9Xpbh+nZzf7MfNDyTXB8KsyUCqXa9hsIsk/hIqDS2PBYmEWjsW7Z7UrW3SPz1Vzpmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFjoeeps10qbR9+7xOMARTMAfrdxf8YZ3Yp8lRiMMMY=;
 b=BA/QaIFLHq5ws5qSsfYILQEcT3iLZ2umwoN54J9ak9rneaMAAY7L6Wmhfqph65TgbrGVHG1OncdAXwBbXC+XS6cYy/bXe7YufRQ2k4GkArG0b0L1tWPQKALtdlQQ9IGPBK+UV33hYlpuL5EZMQioSVTwdWtKmqkvwgEDWRAF3gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:39 +0000
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
Subject: [PATCH v8 net-next 08/12] net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:05 +0300
Message-Id: <20230717152709.574773-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90ee424c-ba60-4132-c81e-08db86da5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/UiUe5PCliaWuKQT+tTGviGWnTa0WjKTyszYUgJR54Y3eXt3kxu2oOQxNKLOqhvEby+ceDN3zQyCV/dzlt0CfO6E3FlKOngCTePALY+VvXa05R9FeaDVjLgXMWh6Gz+MIk0K37gCaPZsVGY+AL+3Rvf7c3l0THbaKwscY3GYDaAJBQc5iUIOnX3ER+SJIjVgJe2ifGhxqAn4WQ4UMtf9YnBEaFlweYdy2a9NClMp1FXKhug5f5y8z8NJTaPnCm1sDMwGZ/AvLfJkbUGsjMKD+v2tz92KozlTiVItZVdmOn8oeqgCTD8J/Rew2/ORWI69vhTmBuj92Iw1ttvpu1EgHUR5O7wCzcX0GhTFlKD9VxnTmH2fwgHGvPPQvC7IG4+jyhcqZuqVkfdr5ewsPJwQMF6z3bnFeQoOUijE/KAnFGtDhZfty7J3KWZYzy5VKHLBoL3JuD5PvdCCa9xxQeAkAaeB9hXlmrfhTAKHTMB3bCtLVTpPx1ccgZMtQIHQTS1k/+i6K52thL3FQPzYfy4tBWBKY+JXKPLJ1JsPDjNpMQSEKC10hx+IsmvDmxB4Ry6zCGJVdLdnM1E/uJB8lT6ZU/EzEUAunPpE/urpJ1phvxs+iE+sDBFMY0u67zhZtEX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5jY0wFkU1l2F7umdQq7URHrinA6P1FXdHEUmAa+x/6v6ozkpYxQJrHsKZ09?=
 =?us-ascii?Q?+co0z1+3net/1LPwikz27O4L0OWsOgdPp+W5+TWgg5j+NapZkBsICenOIo4U?=
 =?us-ascii?Q?KnzmoXHyClTJBYDuUfNycRx3kLiz/DTRQtjvi/qgvIXM9XL65Zkf8+DIiRBd?=
 =?us-ascii?Q?Zl30xi1tJXoW/gkD2iswQooxgx9O8FHkkPkU1nkgxCUWeqFOg/yINQJQ7IV1?=
 =?us-ascii?Q?6zE47omR7MGak30rpTQ2LkJcvm1/pRSUxyosdm91W0T9fq+XqqdbtVxLgeNr?=
 =?us-ascii?Q?R8liP4cLHrxhfCnFjnSVKBYrn0KtSZviGZYdDfTyqBjckPC/RKM206t+7xmp?=
 =?us-ascii?Q?OFXPLniSaroG07sX226+9urSfJhq8gs4A466mw55hPDAyro11AoS0XIa0keb?=
 =?us-ascii?Q?v4UVtpm4iEMvMaT0vrgujDiJT1NE9GeHJIxqC0y3QONczyuPJ46soA+8kmxB?=
 =?us-ascii?Q?m/0+N7mcQfuq6uUl869KTYoW4DEXsfof8rPIpQFYfJZBGSUhhR8G0gNGm9Qx?=
 =?us-ascii?Q?oYQpVGYl9QATCM7TAozlxzu5fHx1gvMvMMIhVXTJXcATpNfOAorKqZXSintD?=
 =?us-ascii?Q?PyMh4r0T6VuKBokxdeRIajiuj0Qcxk8sFub78B0oqY7QLHTWXncyQlVVRWtX?=
 =?us-ascii?Q?7NoJzy1ld9iyRWxq2M4Xw4ywh9uVkNCHAquTXuhGpSoRrHGRL0kmEwKgJiOE?=
 =?us-ascii?Q?bjlMKWX2M9PW9lhO6tBC0LXlImgdqduZ3BT2bjhkqjyfkWNJoW+rr6feGDif?=
 =?us-ascii?Q?RbHfZESjRIz+GZCgVaOgkf+cWrxdn76G1XVUFRxypUzBoOCZzvXnI3TELlu4?=
 =?us-ascii?Q?1JqFomCE2br8i3jpPXIu2hLS6O8jFO2fBtVX1lSRfz8JR3ia+Zle2ErGAvMY?=
 =?us-ascii?Q?BGybz+iDlCwAmGh6fp2Ywn/zptWFUzGzG9Lp8L3luy1U/qD2MX5JdjZXVHo6?=
 =?us-ascii?Q?g/9iEWrN1xdWDlmZmjIFGV0X4BJkHz2Nxv2lyLK4XPfnfh30ClsO3uBYbMYr?=
 =?us-ascii?Q?ozV+liyYCw10US1Cxm3YDKbSISEgjsBxR9XnJMs92b+Rsg9EQewVnuGxykig?=
 =?us-ascii?Q?Q4LiSJ7CIgLrXfszDUKBZ1aadK9g+Rd9rREy4WxFDeSpgmXUAcQ8ImP3MCb/?=
 =?us-ascii?Q?r12hiof74rDKC/QyIFB92AnF9FSUwstDBB0CKKS4F6jKA4bhffgxZic09qwN?=
 =?us-ascii?Q?IMuBqBM87Ddv0sGSWhOv7a1agP81mGMmzrqaZIhoR9eMhnt3TvM8OkpZ3YJW?=
 =?us-ascii?Q?CzCg06DuXXY8Wk02NZs3MTIzflwkgsaZjSnnuJgMys623j2gXGhZwis87mO4?=
 =?us-ascii?Q?ffCWQ3w/Tjg/zjYjco5+TsIi57W83QbOSquMJxow4QFKEXoCE6b+fLykefVq?=
 =?us-ascii?Q?SoqVtbk0O+iKpRi/eOBQkLvZphm9ExbFXbdj07hr+sGiExHJYZZsyXywkU52?=
 =?us-ascii?Q?vIA+cChdfOjCb9MJDM93KuER7KKhabQfkVMAI7U/e4r5lfGWPZUARcwh6+32?=
 =?us-ascii?Q?WGjdwRCvLYmRWiDcGKTcL4pi6Zq7ah1Ie7wjuBaohkuWN+JAl0onCg9Npbff?=
 =?us-ascii?Q?fcB79kziwDlGHdiKJojs58WGQRbpGTyXULQ+XTbe7Nr1bJuOv9fj6ke+fch/?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ee424c-ba60-4132-c81e-08db86da5b47
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:39.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JC25/R2OzYVS1eSId3rUx+g8UzXxhFgWah/Eu90PNj3cDsr4ui5kd7Cw9NJ7JPjZe/6euDSW7VUc/XlBEmjCQ==
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
Convert the sparx5 driver to the new API before that can be removed.

After removing the timestamping logic from sparx5_port_ioctl(), the rest
is equivalent to phy_do_ioctl().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8:
- Use phy_do_ioctl()
Changes in v7:
- Patch is new

 .../ethernet/microchip/sparx5/sparx5_main.h   |  9 ++--
 .../ethernet/microchip/sparx5/sparx5_netdev.c | 41 +++++++++++++------
 .../ethernet/microchip/sparx5/sparx5_ptp.c    | 24 +++++------
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 62c85463b634..89a9a7afa32c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -205,7 +205,7 @@ enum sparx5_core_clockfreq {
 struct sparx5_phc {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct sparx5 *sparx5;
 	u8 index;
 };
@@ -388,8 +388,11 @@ void sparx5_unregister_netdevs(struct sparx5 *sparx5);
 /* sparx5_ptp.c */
 int sparx5_ptp_init(struct sparx5 *sparx5);
 void sparx5_ptp_deinit(struct sparx5 *sparx5);
-int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr);
-int sparx5_ptp_hwtstamp_get(struct sparx5_port *port, struct ifreq *ifr);
+int sparx5_ptp_hwtstamp_set(struct sparx5_port *port,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack);
+void sparx5_ptp_hwtstamp_get(struct sparx5_port *port,
+			     struct kernel_hwtstamp_config *cfg);
 void sparx5_ptp_rxtstamp(struct sparx5 *sparx5, struct sk_buff *skb,
 			 u64 timestamp);
 int sparx5_ptp_txtstamp_request(struct sparx5_port *port,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index d078156581d5..e01d3b1e17e0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -210,22 +210,37 @@ static int sparx5_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int sparx5_port_ioctl(struct net_device *dev, struct ifreq *ifr,
-			     int cmd)
+static int sparx5_port_hwtstamp_get(struct net_device *dev,
+				    struct kernel_hwtstamp_config *cfg)
 {
 	struct sparx5_port *sparx5_port = netdev_priv(dev);
 	struct sparx5 *sparx5 = sparx5_port->sparx5;
 
-	if (!phy_has_hwtstamp(dev->phydev) && sparx5->ptp) {
-		switch (cmd) {
-		case SIOCSHWTSTAMP:
-			return sparx5_ptp_hwtstamp_set(sparx5_port, ifr);
-		case SIOCGHWTSTAMP:
-			return sparx5_ptp_hwtstamp_get(sparx5_port, ifr);
-		}
-	}
+	if (phy_has_hwtstamp(dev->phydev))
+		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
+
+	if (!sparx5->ptp)
+		return -EOPNOTSUPP;
+
+	sparx5_ptp_hwtstamp_get(sparx5_port, cfg);
+
+	return 0;
+}
+
+static int sparx5_port_hwtstamp_set(struct net_device *dev,
+				    struct kernel_hwtstamp_config *cfg,
+				    struct netlink_ext_ack *extack)
+{
+	struct sparx5_port *sparx5_port = netdev_priv(dev);
+	struct sparx5 *sparx5 = sparx5_port->sparx5;
+
+	if (phy_has_hwtstamp(dev->phydev))
+		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
+
+	if (!sparx5->ptp)
+		return -EOPNOTSUPP;
 
-	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
 }
 
 static const struct net_device_ops sparx5_port_netdev_ops = {
@@ -238,8 +253,10 @@ static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_get_stats64        = sparx5_get_stats64,
 	.ndo_get_port_parent_id = sparx5_get_port_parent_id,
-	.ndo_eth_ioctl          = sparx5_port_ioctl,
+	.ndo_eth_ioctl          = phy_do_ioctl,
 	.ndo_setup_tc           = sparx5_port_setup_tc,
+	.ndo_hwtstamp_get       = sparx5_port_hwtstamp_get,
+	.ndo_hwtstamp_set       = sparx5_port_hwtstamp_set,
 };
 
 bool sparx5_netdevice_check(const struct net_device *dev)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 0edb98cef7e4..5a932460db58 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -74,10 +74,11 @@ static u64 sparx5_ptp_get_nominal_value(struct sparx5 *sparx5)
 	return res;
 }
 
-int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr)
+int sparx5_ptp_hwtstamp_set(struct sparx5_port *port,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack)
 {
 	struct sparx5 *sparx5 = port->sparx5;
-	struct hwtstamp_config cfg;
 	struct sparx5_phc *phc;
 
 	/* For now don't allow to run ptp on ports that are part of a bridge,
@@ -88,10 +89,7 @@ int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr)
 	if (test_bit(port->portno, sparx5->bridge_mask))
 		return -EINVAL;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	switch (cfg.tx_type) {
+	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_ON:
 		port->ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
 		break;
@@ -105,7 +103,7 @@ int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_ALL:
@@ -122,7 +120,7 @@ int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		cfg->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
@@ -131,20 +129,20 @@ int sparx5_ptp_hwtstamp_set(struct sparx5_port *port, struct ifreq *ifr)
 	/* Commit back the result & save it */
 	mutex_lock(&sparx5->ptp_lock);
 	phc = &sparx5->phc[SPARX5_PHC_PORT];
-	memcpy(&phc->hwtstamp_config, &cfg, sizeof(cfg));
+	phc->hwtstamp_config = *cfg;
 	mutex_unlock(&sparx5->ptp_lock);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
-int sparx5_ptp_hwtstamp_get(struct sparx5_port *port, struct ifreq *ifr)
+void sparx5_ptp_hwtstamp_get(struct sparx5_port *port,
+			     struct kernel_hwtstamp_config *cfg)
 {
 	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_phc *phc;
 
 	phc = &sparx5->phc[SPARX5_PHC_PORT];
-	return copy_to_user(ifr->ifr_data, &phc->hwtstamp_config,
-			    sizeof(phc->hwtstamp_config)) ? -EFAULT : 0;
+	*cfg = phc->hwtstamp_config;
 }
 
 static void sparx5_ptp_classify(struct sparx5_port *port, struct sk_buff *skb,
-- 
2.34.1

