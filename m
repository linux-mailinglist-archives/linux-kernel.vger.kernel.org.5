Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510976B774
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjHAOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHAOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:30:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05501724;
        Tue,  1 Aug 2023 07:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCLWwyE7R7mNHHxxUDvrTD79PqKKpzIBRZsHNW2PYyovtBzzS7I7QvBnhSFQA3OHfkeEGS0Cm2eIi7poF+D18wOutKneXEKzifmVtlN0QGRJOem9ic3qsedtK6isRn3YDCrGwhPIlthz/zO3ZaaAG2dCw6GrDpGq0pJbNTFBwxTfq/uLqwAGOhFfWRzw6phYc3tghfTEY1Lw7pzgLgpWc7G8m6XM/gWDuVRJVMFZgxb2k+yx8UZgj39UYsad6ikX1T1iy9aRZOFV10U3RyK3oyXr6TSjbd/C+CClClr2iPualQR1/ZhLASd7hxdr/RaizKiM5PdwlpZe8y4qgC1lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJcUSryWsFMQxeFJGDP+4inqyL1GXBMzoKsfMRvbbq0=;
 b=cF1uPOJhz5WYsI0LrbHiE3nXhOU8I8gdLyX1DQ9F1y1DCYQVV8+ipci5J5gOlxWD+TjmbTgAfJk5cD00tFnsy6tpjbJgmT9Q8MYljoTuiMbwOI9+9vpET7XIp42mhuMPMP8TdMsPT1ZeW9kWhci/TswWTIsIaLxWjX/xkxTaJalMgZBdM+hMdcS9PgV2psLDjSzVv8TQUR5CNyV8Y0CO3CDJ1ryoW6SzE+5IvEEq27a0edJ7Frz/oVjaSbxKyk5t6i3hguF9cwuuAyjlYQX4XnrK1nGiPfwXjkQAHM7Vg2pL9Q5VTwX5iZIql/yrpgo02VKmr2nIBECvNnw7gkS3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJcUSryWsFMQxeFJGDP+4inqyL1GXBMzoKsfMRvbbq0=;
 b=TLDuk9V9nB3sObHe7bDzT4OPHZqqujJap59sAQuF60BJnCBWEUxhI3gYvb/QlLz8l8ymEXhb9srYFqjhEd4Vqr6wj62SJSYN8YTJfembPA4wNfVpIGVcl2zERYQwhaD8GJw1iUC+B3mN1VemkomeDGAYiQd/OWEXWENEYXhxFYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:40 +0000
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
Subject: [PATCH v9 net-next 09/12] net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:21 +0300
Message-Id: <20230801142824.1772134-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5cba74d-965d-499c-f615-08db929bbd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJvZR9QrFytH90ZeZ8DYG6oOj8iBus7Ld77L0gX47ZX67JGx42LvgRFSgA2NnSv4W9jz5Ab+XsF5OTfhbJ4ZtWX2lFL4bOhC+WXB2muAQytIIG+xedI15qLb04ySdl+2/YmmChDyDKjec0+X139fdA4fr1CUQv003OtOh4Hh0U9Ofhaf3RNclna7ugNwN8VD1dBuG83ushVzcc5ta0I5XsV1sk5R31ex1mn7bp0ZDr6Vp0en9+ac6IEDQGnFaVwYQFyGd3wrjycluIWThF44GceDHL45FrdT8yQkU4qxgfAS/EGc9yPmN6oypxkxQPlzgKzYIagwfb4poo21fEfts7rZRrLNt0dzvxDAaWVHcZ8UKVwSvi7Dw3A1qdBk3/xdgKVXSxApUQSoAMEnZSMvEaSGGvx+MYSQ5ltd2Yy+Y4nDrv2PW01z9m8zvJyS8YDhCTcUo+27SnTx1oO+78xecRLWlLHrzQ7OLSI7JVH20+BNZ1r6OCygLjzj21oaxlpDagtRZBfVg+bSdkQXCFPpPF7+qZu+jWqHXLIZ5QQIG0PaW4dLZFMXJ6+ZLv0bPMqVWsTCru6XrrZBcO8aro0IVODh655nrsKagwn8Sdu4puefX8dptcQmdU1daCkdYiAlGP7FpMjhJNip4JiF0baRLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3NrxKV5fDbRV/HTOBzDKb+Cr5jcFd4w74wqAp0frMIJLDjpNdbkzc0OYD/3?=
 =?us-ascii?Q?Pi0eNZwZSs/jtN0EzYouKtTWPEthReCPbxXrGXZgD/+IvWqcnMKPIRQ5UlF4?=
 =?us-ascii?Q?KU5NQOJmJZ9U8Ap7Q5G3lQXn4nevLCoRLF4tbVyi+TcFhqDaUo1pDTJ171s6?=
 =?us-ascii?Q?A7ep1wuqupHlycWs8Cq2oorDHeW+fZMjQdILMQQHH9VmJLI/KcM5WZTnu32i?=
 =?us-ascii?Q?1iKs75XCbOKWQ000PcGpxM+taSt8sRaUyGGJwWKTz4/5duOsMB3kcZ5xatKk?=
 =?us-ascii?Q?obRKeFnpjIgxWAWnJ1l1sIlj8uRf5eWNC+TwFjXN/u15MwNIThq6M+toDIiu?=
 =?us-ascii?Q?UI7oiZJyuwHO7/CRZvWLAPoaQ1RCyPoHTNAV4fZYepv35Gd3t3tkzjjF8i2O?=
 =?us-ascii?Q?TNWmaCNAi+g4tArWybGNwdOVkhUz6yrNLLpXOhmaBM3cYmWU1fX9EA/exz66?=
 =?us-ascii?Q?XE8G3NmesyXDAcbtywmAp84CSJT3we5NXEYwKvKYvokU/uWy8oeQjRKy1tJf?=
 =?us-ascii?Q?bEdYSALZSHIwCKTq+X/S6g79uCKF3+QA2eUOSWDBnE2CBCA9aDQWWWOADJLd?=
 =?us-ascii?Q?giw1Y5o0PGE30MRmutPao1iE6cwiScVs4WtEiLGj9BkItJrncPh8CRJivw+Z?=
 =?us-ascii?Q?60K22ckduWHDXgFMCqIwyLAOcV09IvqyoJspNejdh404ombcMr3ZnhPcRvxw?=
 =?us-ascii?Q?Hx+zqToHSMe/HigGL3H60Oo9x57iFhPBgx3CEOcH9ipua5fuPEtnd+jpeHXM?=
 =?us-ascii?Q?g9SMZJELurEa7VvfXxWne/gt5OZ6fk9dUmG7VZfe41Zfl+FFFxWd5tWnIZTh?=
 =?us-ascii?Q?5fVeTTn7YISqkuZ7UDIVZejn20Zv7CZCJ+pKY0prv+eRy/P9xDfDJIBhisLn?=
 =?us-ascii?Q?EQJLW5WwiiUHQ8JkUGAbQWL1C2Jufi8fGfV3PJV1EJjlNATmulP7BjWtOcly?=
 =?us-ascii?Q?UBJgjb7Y1M+5fnweagENXPYcPbsqOVgyC6mz56//fu/BBAapx+gvyHFBDyKy?=
 =?us-ascii?Q?wpuVbusdXb/HMixS9O37aYmL05cxDs7mcHlrLxZ44KkTiZaY0LQhZGrMVTLY?=
 =?us-ascii?Q?Y2O7gXRpFNq+KFRB/JB0DKfbPSHjFHFZVn+f+MxpR1RcUMI1SC+NbUKbT8qK?=
 =?us-ascii?Q?JCbc5By3FDVhfRfstwSAKL0oOcP+MqCFkEOtfx9kVmweenA4JU/Em87Uj2J3?=
 =?us-ascii?Q?QgyPEgl4EMbSFHQqeTSf8jac/nxaJ6127W1N/7okMD2Llr8PDiqqt0ZUQDS5?=
 =?us-ascii?Q?Mj09kX9X6m6TxwTlObjGX6KyYXFngmr2A2n89VLH8sgJ3nxLET3+dNKlAWZ3?=
 =?us-ascii?Q?PUabX8gXpWWxWeb8fZosZ1zQD2W7/DcsQxGeU33XxHCBzDY3zgn1ENahcM1o?=
 =?us-ascii?Q?5GSirIF3FAeX1+SABUNe8JJO4kiBW4Qrntqv+8WdfOoMI51KHBJC5vgZifwY?=
 =?us-ascii?Q?1lowXnjM1eEiYGTNDby8qz5mdaqwCsbG9zMhcOqj08rleiFug19bXHqAXgCu?=
 =?us-ascii?Q?zDu5onDnQo2QwvEbV0OcXYmrEcT0mpRG6D0uEv6B1ElriYWprCA2KXKsUMS1?=
 =?us-ascii?Q?B6zocVoRX1zIzM/U0ztyhhDk3GqvgDbPgx2hPWEsjBaSsLgGnGIBrS2PAWlN?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cba74d-965d-499c-f615-08db929bbd68
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:40.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS6or3bFEnC3jt56m0pmdk/ace10FLO7zW6PPKhhe/HtMrXy53pWvCi7Jij5BZJ/k5YE3KN0Qh8o8EEovKIcBw==
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
Convert the lan966x driver to the new API before that can be removed.

After removing the timestamping logic from lan966x_port_ioctl(), the
rest is equivalent to phy_do_ioctl().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
Changes in v9:
- None
Changes in v8:
- Use phy_do_ioctl()
Changes in v7:
- Patch is new

 .../ethernet/microchip/lan966x/lan966x_main.c | 59 +++++++++++--------
 .../ethernet/microchip/lan966x/lan966x_main.h | 12 ++--
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 34 +++++------
 3 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 73f20683210e..1baa94a98fe3 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -450,39 +450,44 @@ static int lan966x_port_get_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int lan966x_port_ioctl(struct net_device *dev, struct ifreq *ifr,
-			      int cmd)
+static int lan966x_port_hwtstamp_get(struct net_device *dev,
+				     struct kernel_hwtstamp_config *cfg)
 {
 	struct lan966x_port *port = netdev_priv(dev);
-	int err;
 
-	if (cmd == SIOCSHWTSTAMP) {
-		err = lan966x_ptp_setup_traps(port, ifr);
-		if (err)
-			return err;
-	}
+	if (phy_has_hwtstamp(dev->phydev))
+		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
 
-	if (!phy_has_hwtstamp(dev->phydev) && port->lan966x->ptp) {
-		switch (cmd) {
-		case SIOCSHWTSTAMP:
-			err = lan966x_ptp_hwtstamp_set(port, ifr);
-			if (err)
-				lan966x_ptp_del_traps(port);
+	if (!port->lan966x->ptp)
+		return -EOPNOTSUPP;
 
-			return err;
-		case SIOCGHWTSTAMP:
-			return lan966x_ptp_hwtstamp_get(port, ifr);
-		}
-	}
+	lan966x_ptp_hwtstamp_get(port, cfg);
 
-	if (!dev->phydev)
-		return -ENODEV;
+	return 0;
+}
 
-	err = phy_mii_ioctl(dev->phydev, ifr, cmd);
-	if (err && cmd == SIOCSHWTSTAMP)
-		lan966x_ptp_del_traps(port);
+static int lan966x_port_hwtstamp_set(struct net_device *dev,
+				     struct kernel_hwtstamp_config *cfg,
+				     struct netlink_ext_ack *extack)
+{
+	struct lan966x_port *port = netdev_priv(dev);
+	int err;
 
-	return err;
+	err = lan966x_ptp_setup_traps(port, cfg);
+	if (err)
+		return err;
+
+	if (phy_has_hwtstamp(dev->phydev)) {
+		err = phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
+		if (err)
+			lan966x_ptp_del_traps(port);
+		return err;
+	}
+
+	if (!port->lan966x->ptp)
+		return -EOPNOTSUPP;
+
+	return lan966x_ptp_hwtstamp_set(port, cfg, extack);
 }
 
 static const struct net_device_ops lan966x_port_netdev_ops = {
@@ -495,10 +500,12 @@ static const struct net_device_ops lan966x_port_netdev_ops = {
 	.ndo_get_stats64		= lan966x_stats_get,
 	.ndo_set_mac_address		= lan966x_port_set_mac_address,
 	.ndo_get_port_parent_id		= lan966x_port_get_parent_id,
-	.ndo_eth_ioctl			= lan966x_port_ioctl,
+	.ndo_eth_ioctl			= phy_do_ioctl,
 	.ndo_setup_tc			= lan966x_tc_setup,
 	.ndo_bpf			= lan966x_xdp,
 	.ndo_xdp_xmit			= lan966x_xdp_xmit,
+	.ndo_hwtstamp_get		= lan966x_port_hwtstamp_get,
+	.ndo_hwtstamp_set		= lan966x_port_hwtstamp_set,
 };
 
 bool lan966x_netdevice_check(const struct net_device *dev)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 27f272831ea5..b538d496e8d7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -298,7 +298,7 @@ struct lan966x_phc {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
 	struct ptp_pin_desc pins[LAN966X_PHC_PINS_NUM];
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct lan966x *lan966x;
 	u8 index;
 };
@@ -578,8 +578,11 @@ void lan966x_mdb_restore_entries(struct lan966x *lan966x);
 
 int lan966x_ptp_init(struct lan966x *lan966x);
 void lan966x_ptp_deinit(struct lan966x *lan966x);
-int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr);
-int lan966x_ptp_hwtstamp_get(struct lan966x_port *port, struct ifreq *ifr);
+int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack);
+void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
+			      struct kernel_hwtstamp_config *cfg);
 void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 			  u64 src_port, u64 timestamp);
 int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
@@ -590,7 +593,8 @@ irqreturn_t lan966x_ptp_irq_handler(int irq, void *args);
 irqreturn_t lan966x_ptp_ext_irq_handler(int irq, void *args);
 u32 lan966x_ptp_get_period_ps(void);
 int lan966x_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts);
-int lan966x_ptp_setup_traps(struct lan966x_port *port, struct ifreq *ifr);
+int lan966x_ptp_setup_traps(struct lan966x_port *port,
+			    struct kernel_hwtstamp_config *cfg);
 int lan966x_ptp_del_traps(struct lan966x_port *port);
 
 int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d124..60bd0cff6677 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -248,29 +248,23 @@ int lan966x_ptp_del_traps(struct lan966x_port *port)
 	return err;
 }
 
-int lan966x_ptp_setup_traps(struct lan966x_port *port, struct ifreq *ifr)
+int lan966x_ptp_setup_traps(struct lan966x_port *port,
+			    struct kernel_hwtstamp_config *cfg)
 {
-	struct hwtstamp_config cfg;
-
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	if (cfg.rx_filter == HWTSTAMP_FILTER_NONE)
+	if (cfg->rx_filter == HWTSTAMP_FILTER_NONE)
 		return lan966x_ptp_del_traps(port);
 	else
 		return lan966x_ptp_add_traps(port);
 }
 
-int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
+int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
 {
 	struct lan966x *lan966x = port->lan966x;
-	struct hwtstamp_config cfg;
 	struct lan966x_phc *phc;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	switch (cfg.tx_type) {
+	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_ON:
 		port->ptp_tx_cmd = IFH_REW_OP_TWO_STEP_PTP;
 		break;
@@ -284,7 +278,7 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		port->ptp_rx_cmd = false;
 		break;
@@ -303,7 +297,7 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 		port->ptp_rx_cmd = true;
-		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		cfg->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
@@ -312,20 +306,20 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 	/* Commit back the result & save it */
 	mutex_lock(&lan966x->ptp_lock);
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
-	memcpy(&phc->hwtstamp_config, &cfg, sizeof(cfg));
+	phc->hwtstamp_config = *cfg;
 	mutex_unlock(&lan966x->ptp_lock);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
-int lan966x_ptp_hwtstamp_get(struct lan966x_port *port, struct ifreq *ifr)
+void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
+			      struct kernel_hwtstamp_config *cfg)
 {
 	struct lan966x *lan966x = port->lan966x;
 	struct lan966x_phc *phc;
 
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
-	return copy_to_user(ifr->ifr_data, &phc->hwtstamp_config,
-			    sizeof(phc->hwtstamp_config)) ? -EFAULT : 0;
+	*cfg = phc->hwtstamp_config;
 }
 
 static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
-- 
2.34.1

