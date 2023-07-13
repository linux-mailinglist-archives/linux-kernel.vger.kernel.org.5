Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3F752121
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjGMMU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjGMMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:20:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9EC2D5D;
        Thu, 13 Jul 2023 05:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heztaZIfSkg+mO+ssre+YSX90ZWJO3crpc9PDtGCH6TRxrGvbJ65d3UBRkDsQ295IoOU5aTrPN6NzyB9a9gShW4JCmVPY9detBEE6swYJEBsDw4y6Oluj8GfolUBx7b7D0rn+nucFwaK96FFflrpAAyMOEIrC5TWJAbKa0yUGh985Q8Q5ZmGwBsmQ3aidtIYYtxcUkoRODB1RVaADml9okXAJK7rVhoMfNE+fan+FQt4JDAVM9mEx9dLYkqFe+0T4uIGYqKm0YURk/mVGkr7UreiGUYy0sgTK/1GmQIi0u5zCqLGWbQVJvx2X+wwBuYyf8/4vgXjf4zI3/Uqwd3qLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLkzBOcU3Rh9goaRBRdupRrK29DioHKXaC01OtafE5c=;
 b=QnCHYXx/vcxbqawLXeSqpEz/AW6IbMdeBDAk9LfDngR2F9ojtyD5IUgyaC8e6QyF9SijdVgO2i8CO8qyl77/zNlE/3TmlgveEHzAru+YNXF1gdnbDRB9b36gTupFQMocEXHB5w7QcssFth6zq7MnRODfEwHmppIQriRVTTQZizD9Szw7alAhZOHW8fBesNfNpYjhY9h5elaZVQ5AJ1BSyhLGAFLGe9W4+9g0dumMXVW2kHPO8nhNNhO+bj7IE24ZwdBbipMlRUTNj9Ft2VMbzqxMoZYPFvcFvxflGsqlWtJiS5JFqoq1qpMH9jjYNC/mNNtlhfz8xPDWXe4bh5X53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLkzBOcU3Rh9goaRBRdupRrK29DioHKXaC01OtafE5c=;
 b=npM85y+9OQQ9m+WDRJYPYMY0QxcNZiIKZVP8UXgy1cFYyhU0JC/JKTGSzGpjuRWUPlq9INP+b1Gt/6xlxYx+EYy7nH4/IeWRKAEEn48eG1nVc0NZ1fwM6zEwl0IS6ijfo477poNQE0Kx/ebbHS9DDrehLUjgB8J6I9gpK3xGIeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:43 +0000
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
Subject: [PATCH v7 net-next 08/10] net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:05 +0300
Message-Id: <20230713121907.3249291-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e5d3c5c-3e99-414d-dfa0-08db839b708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dfuK2+Bcm8EKIj5REnCIgbfvsY2CBXLqHQTwEqJdhkDM2CgfFuqAmd7sy102drGwqDXD9+8F0MMF+33mycBqlr8HFIvSx8+qLDKQlil5ok+hdzlSWTn9PDiiHa4KwwbvLcxK3vtosInASNSpgh4O3CPhOWxgzKjRKovaj7TNMj58J8PRvDPPAkktnDpme5aKa8XsAXy/qEqz8pDmhqWbgeYXs8xud9Gv+4VQhkB2MVrXOXNJhyePah6AeyxnuC52fFpQ0ydp4vwbaflPsocDFmTZttpqKW9XJKxVi7nqJ924+0cjcjvVyY914RVmct0HUIAoQJqR9af6OV/dNxrWYbI8K+VvumzpwNQAMcuM0Ad19CNcjEAoawYHPdkrFi1w0ofbjCKEvbXaa+W56LVq8d2eykLSoIxC84LTYwGaHwQa7Hg+P2NCtzhDm9r9eqHrYSiUo5fr6HUhQc+1xkb+X3+I+jXyxnrWAEql7UySp4tOoU8cf6OX36CpPj3ZenKd42sTODvWO+dtkKD8DBwmIOqBjDACQuZZDCeUmSNrOJi2CFsrfOGYq8UTxG+AUDvpW3jCEYJqrYLgG5e+6fp1PZ5Xg9cHhhQ/g6crE0kFHiVjjOlwo3vmX09ikZ090BI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxR+Ur1KfXiqyuc+Z0iN/PUVcjvT7XMfR9JGf0TfcyE6R4KLVVi8HPVkG+D3?=
 =?us-ascii?Q?hJO878nqm6P8EPHipy0bPig8ukJRyXk7Fd9ApoWLX0TItlVgnPcEhQMmbo1p?=
 =?us-ascii?Q?9Gh5FMITy4+nwCHnOSWqQJ99TeX0mXHzaLqZAF2s7Nv+cLz2zeE6Q3HDOJ2K?=
 =?us-ascii?Q?Q6XRDnC0py7BXIt4v6FZQoriHVnDUTc7X8CMGdz8IEMCua1uXY/SJBxNxKGU?=
 =?us-ascii?Q?mMHdYYRmK6/ITjukBvzB8RUd3uFz25eo/zLYHaZb/8hRKqgsFi59hkOxDKij?=
 =?us-ascii?Q?3DwTR6KzeZsvC8D1WzfiAB6GmxM9FiHC2vGeKbURUZB0DnBSTGDvUtX1Df4N?=
 =?us-ascii?Q?ia8Y8KfGi+ZqMMceJrIf0FLvsKVhNtb73rLLt29bFYMQUIVgQykgE/Be2A7s?=
 =?us-ascii?Q?t8h4xxpTuUhoMe2GTFA999zyJ/+yHpbFOokPVO8a1OwNMWJzPZtJhtUxWf2f?=
 =?us-ascii?Q?VbWIWHoUGzY1bBcQALHwD/tkQsFQtiHBkzNUKmIOl5xmsXcpQlOJjWVgmC7P?=
 =?us-ascii?Q?l2/+3wtg5PU5x90akjf4ypBRj1qGGP8fqR/MGGmTKlJDSbRlJjvGcbSx0sdz?=
 =?us-ascii?Q?mzEqrBL4x/G6OfzpjWUTGRkpILOQRsijuNyw45qZYPBuL7FPH/itObw6NmvO?=
 =?us-ascii?Q?KbIvPuRzs61kTGD+bJZvIPrV4J1WpROcBp0sbumV0aJEHVotphQuWMaBMbws?=
 =?us-ascii?Q?u4WE+Kxrc+HAi1znFd2J8liZT/ShZF2FQCW3oyyq0ktTTNM4VYWDYQAkwtl+?=
 =?us-ascii?Q?4ekLwDB1IwGZ2MbVWDDQ9NWPHI4agZIJt8+TKXsIQZkI0fvV9q5RqasvzLLB?=
 =?us-ascii?Q?APSi8d4yYEiK4b4sSdoDP0zx/Jj/95NuY2yp/+eWLxE3Z8p3hNDoaoaA4dX0?=
 =?us-ascii?Q?ONqgLzC3/l3PwUBJscVExi1aPsllyMAYQT30QtGeUCb4AE2jKTtS6J6jWRz6?=
 =?us-ascii?Q?qlNDSKGenFI2+Q2AuHtiQAdstL8mGaHjbfCUJdENksVtYok92iKIk8LaGc08?=
 =?us-ascii?Q?Yn41d25CAauSPGE8N4WUKej3DQNMj+hgfN9xXOKh04XxZOncdyXyt3rFcuaS?=
 =?us-ascii?Q?NowHAWB4tNz5A/SnZjTRP3/XUaxtn65Mk+X4c/6aRAE7xB/Q4bmm6NPMOfWM?=
 =?us-ascii?Q?FHLqsU8xFBpcXE8ifj+UGXf7seCVJqSzlvlsNkf/pX01GUPkTcPov/ZVhABo?=
 =?us-ascii?Q?TrrvMm+kQc3CWGooj6tkM6wGWnYIda0xGedDLvKCpGoByAGM0G1nmzZJNvec?=
 =?us-ascii?Q?FAtPyBeHkdrsXD2zllxsYz+EPYJAy33jzbCeN8lxDj4ZOcV5q5cHN6s4y37t?=
 =?us-ascii?Q?HL9Q1xoLBO3/stBObdZXioX6kH70bmC/EJM1RlfASe+ejzDGDppJX8PDD14H?=
 =?us-ascii?Q?g96c8Vd60qyG6CljJWoO5+TI8QgUgt9Wggo9COdPBO3Ajnb8rKbIHxwlYgDm?=
 =?us-ascii?Q?fsVv3wiLTZj6QIWEJ6ktNfOSsy9MnyOm3OA42KMuHn7V8j0mOMPxjChaOn3i?=
 =?us-ascii?Q?Epg69F522Gby6qB3NLeMzepRbkf1iVNtyYOk1OnOSrFOfsZ0zq1uNZy6BftI?=
 =?us-ascii?Q?WOULbsvPMjj8WD4qmbw4dJF0ma94JmuWGY2TiZXQcVUbhWEfihIX9bGY4H/X?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d3c5c-3e99-414d-dfa0-08db839b708c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:43.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNuaWYfCNnxxMBNS7GDWs8VCg+UOwpy7Z3ExJtNh2gE9TXygVKjt8YHvqHp9ub1dWxtZ4Nf9+c6xsy/O/7nS2w==
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
Convert the sparx5 driver to the new API before that can be removed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Patch is new

 .../ethernet/microchip/sparx5/sparx5_main.h   |  9 ++--
 .../ethernet/microchip/sparx5/sparx5_netdev.c | 41 +++++++++++++++----
 .../ethernet/microchip/sparx5/sparx5_ptp.c    | 24 +++++------
 3 files changed, 49 insertions(+), 25 deletions(-)

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
index d078156581d5..573662d2e01a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -212,20 +212,41 @@ static int sparx5_get_port_parent_id(struct net_device *dev,
 
 static int sparx5_port_ioctl(struct net_device *dev, struct ifreq *ifr,
 			     int cmd)
+{
+	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+}
+
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
 
-	return phy_mii_ioctl(dev->phydev, ifr, cmd);
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
+
+	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
 }
 
 static const struct net_device_ops sparx5_port_netdev_ops = {
@@ -240,6 +261,8 @@ static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_get_port_parent_id = sparx5_get_port_parent_id,
 	.ndo_eth_ioctl          = sparx5_port_ioctl,
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

