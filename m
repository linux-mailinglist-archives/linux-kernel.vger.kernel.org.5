Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1576B772
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjHAOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjHAOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:30:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78BF269A;
        Tue,  1 Aug 2023 07:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4P6lN1Cb58UazrCRXrIMzMYYcvnp1rkc+icivsk/6eaGqXuKH08uQNqsnpxVDKOmOUd7v1AUC7hfi9nRFRuCT2DfAwESuyaRRkrz04xz5DCp8AayI85X65e3TZgmt9bPyD44/4hc6t4+pM+4NBiBwRtR/Pvw9plXRo5tPqvJrNEm0xPp5gEczqvpJWBo+Mh9CoR/gVS6dd4L48JdKaDwjTjd7Z2yjq4+xh4XQAfnNWDFVb90sTDZ9mDrd/QPASwkiTYlm+SrMYtVMFnXFSuM8XAkXSUyIoYdlwKGzT2HesgGqj1ElgKxUIBE07mZrP6Yr3JYmqkOtipMDU72lQJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pichTHHeLsSFWH+QItuhd8YCT5oT6qjBwvnWA/KbH0=;
 b=Y5jophNkN+zZTd3HEvebC/AAhj/nD7lnYQ+12bek1OzBOMLBYP7zT2TvJYFNQ4xNcNu5qlJ33A+JDhWXFgBEKRjt18qfYUrWTGysFtpDnE7Ncm7cfMyx/0kbMhPHkh2D0e3rizMFWQapDBMF07Hjl0xXJLegDrANcER89JkZMgVFZYNJn3BJkiinpIn0pMIOviW+StyEBT3IIlkEYev79DQUXed+9Eqi8mTGtxA7qp+vS4fgkADhGwZdP/taf1aYk7dsxO4bA5bPTyMlsUYtt6TOqo4WhSQI5XaTyYQRH/fKfeEXDP+0ZKqEZPJt7jZlLPmWEuuiBdotpBtYEhZ+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pichTHHeLsSFWH+QItuhd8YCT5oT6qjBwvnWA/KbH0=;
 b=inqs3SkhdJrJO40liPBQWEGLPO3WAnCgNuHEMxE4JOkPH1bVLnN2NHzrrYgVBPFNRbSggk4WPVjuaQiJ/RitwOGOpH9vh7LoW6v3jGTCW6Afhd+jj/qDnQsfrbqQN+V923rQBVFOAWDispX87BCaKMDRHnZU6L4OQBeRx/ZvuzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:38 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:38 +0000
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
Subject: [PATCH v9 net-next 08/12] net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:20 +0300
Message-Id: <20230801142824.1772134-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 190f4958-7887-466f-ccee-08db929bbc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArCD4cm078Dz5HoGDrBzsWTYtY8DwsSMqvvf/8fCqMHT//bsv8tHBgbA3Ps0FGzTmi4dwoMJIXFFbwUDLpd9wgWoxIG5WQHyt3Zl1lGkM1OLIN3iSkhotYTcbHmDNvuVoH7EY/ALJPbb/eeHeJfEw+/rac2ciQGwdYjk4VF8IdlOdYufJ7dAPGAW1ihxq7MYGo3N2ePvyQ8SVDieg5YClxBvuwwIneWRQzsO9TWD7F76U8BnLI8zeR/Fwvx5o3ov1wF31hnv9HSECJ6HdrP2wkwvZGpZ0ISzrBnI73sxTKJ+xu9Lj+xk/BaRpb6vBreCRjfY1A4scmL478VLdUzs+BX1bYbDd8Lx6CgKZblC8qtW5Fslm7z3FRjKen3L9dAJYWsKgZ4zFgPyxdXe3Z2Hnb27MHa84bV3H3T8d+CSxGekuntvOEAUW5rhze5rRMaH9US0R4mmurlzpvNe2WOuDLM9eJYOPuGtWkuCMWl4Y1S5M7oyyVLhCitjcia3rnek+EP8Rd/fzq2Dl2sRgp9UhSyBVD2hHw1sb89wiXZM2DweJp3JvoxLQOoQsF65Kbj78kGNnEnEX/K454QD1vS4lua0vK9vWpXu336is/d8JxYlC6bxCGFGceaHMgjMfX6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfPbjETot53t8weMrhuqAwuj/HF65MuSwzxUW+P4YyhLPeuEYXVqbn4JImp9?=
 =?us-ascii?Q?iONzwQH5aiNPDy+uAO/+N2POaXc1MH4b/qILPg5JG0RvgeEnO/0y84tj6tGN?=
 =?us-ascii?Q?/X7wCskgPtrTwvR18TwKAHe9q/tDWaBclbFT1/Y8ljCTt+afEBmrJbyUzIX+?=
 =?us-ascii?Q?D0w2yz9O+vAqo8WF7oj8Y0YIbHD5Vef90TZZTVer67/kUn0cwS8O1pkJIHrh?=
 =?us-ascii?Q?RS8lvfwwa6ytAsPO4cQXoPXfORdKVmDZ+s4SrRAEPIFUTNdS+rkXmZFEHPBA?=
 =?us-ascii?Q?SJzRQeMJ3zmJ6XKW3usE7izmYdPltI1Rr9uLPjqVb9w1c/F+iOvzFGfMGPoJ?=
 =?us-ascii?Q?LCMrZQUndjxsuGd4QK1ptv9JokiTn0UfBT7GtGOAXEzgtXwM996ih87r4YPN?=
 =?us-ascii?Q?MsxQLo2LRtdmPu4jNqsFIDZ9nme86fqyq83AHbqbAMFTVI79X3ps2ycytdaA?=
 =?us-ascii?Q?fMuht1bfl1z356aDTX6Ig6K6t6eYkL5DuspaxNMxRE7/ehdFRfXgH3I1RnaZ?=
 =?us-ascii?Q?b2AQrYdMSZ9UuyIgbbVseUZ6Zq1TY4ZVb4p35J+/5pFkebEeSFo5KD6YhzKK?=
 =?us-ascii?Q?UYnDM6iB2mo8gye+fQ204fD9jwAiQjqY53jij9Ql2Um5uXrVhcXmJh8ilDDw?=
 =?us-ascii?Q?Kyp+rWg+fCZEmfwtGZT9toi97guzHeRE+MKm0UolzVHTh3MV2XU/x6uPGyjh?=
 =?us-ascii?Q?HRaNPSX5T6x/pqen0mNPKTsqneB8A5gR7WGzUBtHf5SBQwg8qEOk7noVgMi6?=
 =?us-ascii?Q?cEV0bT3GJ7be9vNlhvt2QvIq2sykMMeA+tmq8ARJ/lBP7ywt+/2WblHbVWbk?=
 =?us-ascii?Q?EFj+hWVV6UCvuS75JmtwoqP8O01KQDBUM649n84iyDgLXvUpeCkgEzENtTf2?=
 =?us-ascii?Q?fkH3BkVHKUHLhX77EboU5qSBcIT6qz7HmfBaYI/MtZZNb4xP36abMxnBxatO?=
 =?us-ascii?Q?TE0hUvbfjSnLcD3vAg4m+labd5xPR0xTjKDU/zOyzhXfRvWPd/GiQ5lKIOE4?=
 =?us-ascii?Q?HKPhi18N4K+4L/zu6AkVprWUAiZW5/01xC+4MKfvnxBu9dHG2h2KxCcPx6S7?=
 =?us-ascii?Q?lnCMKP+ahWE3QInHKb+A1LWQtr6WGcLSKuyNtEp2GjxuLwifokuHBBp9TvYc?=
 =?us-ascii?Q?AYgjqqozHgNeumDNtLwMqnIdyWaicwkhxwUCUH7w+Ym5OgDMp1PQYsCD2YrC?=
 =?us-ascii?Q?uLtgFG1e6puHG6dgIH/VFYr1BBXc+Neg0hLi59yfOTawbiQGyVN5kK8ONhps?=
 =?us-ascii?Q?WlJTmhzR6pYHTALC0ASeBE8sS39YU34EN8aOPz7kex+w4Ce/EKGSOiQYu+nO?=
 =?us-ascii?Q?j0dOON5Exv3TghmoEqb26NuGf/liQkAX8BLfDQAVglJ711zZBURR+c2gE2FV?=
 =?us-ascii?Q?clkAuYoES0v/YgweD5sHMQ9TQN+UhL45QleQpbchMso2rWR+PuZ+aO0cjSb5?=
 =?us-ascii?Q?NkgRvFOK5frMQw1x96efFDXYbSVbynuL62DMsJzSUmxZWvfjMOhAEOPHnReH?=
 =?us-ascii?Q?zP+PxON3WZQ/BdzoJOmqGj1CdjdGcbavWzIRS3hytRst/387ai+80owSpro1?=
 =?us-ascii?Q?aDwKCdtm8Ag+NlpgzbwAIuiUh1IzRRlQ2GZgnZSHWDPIMF75UHXucviFQJ+f?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190f4958-7887-466f-ccee-08db929bbc37
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:38.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJJCkaLQZEBNR7u3mLFdOSFJhGphXFa25dB2x7BuwUGReXbnoe37MhJrLNCqckzJj03BnC6ikZiQVHun8vTnPw==
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
Convert the sparx5 driver to the new API before that can be removed.

After removing the timestamping logic from sparx5_port_ioctl(), the rest
is equivalent to phy_do_ioctl().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
Changes in v9:
- None
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

