Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465F7752117
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjGMMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjGMMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5C2728;
        Thu, 13 Jul 2023 05:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9Lj1FSmn46iQca72EXRctKcbd80onpCMKFbTCuESXLeeDqTN1oT1I4RRoQKmc/gECuPkadHRYBzjcDcj5gGHo5g4XGZMh9JWJJq/qXBjMfPY9gvAPyY5pGUHgEGNP8v8hLKttbmXtzp4QquftueUJZ3fDx7cdEd5eaofzF+/YBxbSbOR/ICfWySDlXotf4BwZuKCU8WYpZAuzzDCW5NqIeeQLP2aAufucWlG/YDKPd0oAtmi5gZXgQjTB+5xDnL8oGgVwPxoYbvqbainFu1zVnzUzrcPoh5MwbmjrGLZmrQg81mng1hsc2zDf5e8+vH/pLzPiTVNCs3hlvWObmlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CiXt8/qYpORRjk3gY2/uz8cHJvXxKiQHD9i9t0WgKM=;
 b=OdYWpyBdr/10gihxfZe3r24+pXy5qygWeTcDv6r8EhfEpMFsaM0cHnzkE6cZFeg67hQZXN1t21Y4KewweqCMufMqX0nCSBEhTZTLbDfl1HMzGULwX0fuH/9K4K1yebUaG17VAbS5IQFb6FFqlTmFdXsOOAZG+8VMFRFoZM4sGjS39lq+g1R3upRh3r3yBDCNEqldh/Vkc0rQiwNJOnbg8A7VLILehVsv6z0wTmyTGU4SPq0RZsfPuh3ByvnT6GWkMsd8nJuOjqNpX5NFGSFMkIGPPXE8YwDrpv0or/8bSOZBKdxxRKZngA4xbS8sY0ZnJG5Tt+O595vszMaov6hlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CiXt8/qYpORRjk3gY2/uz8cHJvXxKiQHD9i9t0WgKM=;
 b=GAlGJ9eHGiFhn90f38OmZBQ8WJewLlia8RP/wXYGm9cs1QaFTcV4o/eCgHEnCKRXBcPizf7bwcGpSvxvcIk4P8LWeta6ctTYTCAlMYajqtn5ZCCAD/ifrMf3Pdt2CaHypSdL+NdhimVCnh8tVLXqfamY6E4H1VaAr6BRUGX0vjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:31 +0000
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
Subject: [PATCH v7 net-next 01/10] net: add NDOs for configuring hardware timestamping
Date:   Thu, 13 Jul 2023 15:18:58 +0300
Message-Id: <20230713121907.3249291-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 978580c5-e89c-4b50-70fe-08db839b696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjje17W1JDfTZIDZ2rLue7Ng+qL7jg/vrRhc+aIoq+FjDtkEgrWDhsTOrdMm9ORX79FJtMEeI+PZ5IImLmUdcyFRE43a2AEgC+woRS3i2SsRr310LxOQQraqF7IwVf8QYBEXRb++1DwUJImpFh80zolDt147R1smh6wPZxzvxMtCajMMb451Wy4p+F2xCP/YfHCqW1ih+wEgymrUREQpToaqdpdaJL4V8e2oyzGqPCdqYYFPeCOGZE8ip54XRky1G+lyJGgXTOqBx7DN+OADednQD/3pyBLkhP+8uKBBUDl7D6sDUIxRc/B9wPoCsTOkkndeTLzGb+cJsFWk0Ue0aiephogboJlI8eMDcb9tFBNF83Z/EamoUHTavaGmXX9W2tC1CVyrYq2DezCZ3EmslECJQpZFheAz2Vu31mF+e6FR6GYQCyb/DyusDfNJ9kcWG/ES/Y2NHCHyxAT0pzqT8NhjzBL8Nd09AFmv3UBfIhm87g4HdR4uk5i8vvi7HBT0cviPW1rlU50FOYhV6prdwmu3KECzvblQVzzM9G1FcFV9h6OtHALztJ47JzgKvu/nwNZVH/KFiywZXj4LGSpEUUN3HPjWlvYXLH1fdNxuj09XFHuBoOboLhbW/POfdzp1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skrtnNHxhkaBpuOB0T5QT0nweBw+uqAXvMdUCfUmszOsABSTZ2KXzr/2t8S5?=
 =?us-ascii?Q?I9UGB2KJbxKW2tKOQm+BVkNy3gTcsOKWp3D+q5BqSU3I3bw7QfkK7b4Iifi7?=
 =?us-ascii?Q?VtliW4OYZHeQRzulu6FthmG/Jkgn+4ix5zq+wYm0vXY/6iMijl9+OnxoBf23?=
 =?us-ascii?Q?o8n1bM7OGqwq9Ri3P9YMBBqS8sCuNuxUdqrzh4vBlZBThkbAWzVjFiPVWY8t?=
 =?us-ascii?Q?v7jvxba6vRZGqdMurs23OSl1FCPduUqrODxhrVOqZSMtM536JjbCZ0B0s6+s?=
 =?us-ascii?Q?rRU3Su9ydsQfJMGDPuPJTB/AzioyJSKhePXb8MUsPXTkeKlky5yO7hEARZvp?=
 =?us-ascii?Q?MF5GRVsZ8IN9OBmtJNFgUjoi2JoXG4UWvVv+kovCyDa10rq36R4EhUKEK4zH?=
 =?us-ascii?Q?8bC328ly58/W/skK0yLpU5vCxFv3dq8XXbarO/OeCVHFZ6wGWVyRc0N6MvCv?=
 =?us-ascii?Q?eR1pz4O0lfudqyFl1svC+mxEw5z2YDYie886640epHH8ze0IhQ0rPqhinVJF?=
 =?us-ascii?Q?Q2r2h7akP7vLUHlczr0hA8m5hmg+xDozzoOovpgCf1S07uBxogmmlb2PgKZu?=
 =?us-ascii?Q?39pIS3JeGM1WClkZ+twavJYSNT1TZ171qXpvmxQ9pWzkGVnqCgpir9pfLFE8?=
 =?us-ascii?Q?Fen6KWi4ETk91u3iGhstbmcYQ13WOQLNM7MDZrOAnNhnAsGIP1uR0GBJd/BF?=
 =?us-ascii?Q?m7iw45+0SK6q/JgQZDYdRHovqPeWzvw0EVy+sVtTcNuZVo2Ni8GcvAEq7+IH?=
 =?us-ascii?Q?z4MEsuJTuffg/V8MFZbfgHuoURA+zvdiOQ8X5sxruOW9loGfqwySJishQUF2?=
 =?us-ascii?Q?VFFOZt1pPkeCMZBfm1S/EbawvlwbO+W0u79AT4uFVJ7UlPEehuHU4V8MUIoL?=
 =?us-ascii?Q?JLeP6/MueSgZadqwjtMo+3tS6mF8WGXmbNrV4/TR54g5gAq2E1P7owj6dFAt?=
 =?us-ascii?Q?i7J3DP4W2lL076vcX+13O/MyK2USD8K9WdrNCU0sXsS2xsmB0ajjVR+ncIJv?=
 =?us-ascii?Q?avVE4U+Y9BU7FBWvwPMsB0qQPAXhw4/QCGdBZWPlbHRC3xoMiEQc+Z+1cuw+?=
 =?us-ascii?Q?MaSwEVZ01LsZTe/1llXou9FIiCI+QNi/mKMtWbKHcLOvCz35ixGZ5jFv5XJd?=
 =?us-ascii?Q?nAKVQGQn8OvkcesFrP2ZTmvMaQmOqWRE53IYnPX8XGM7XO0llyLmhxIvH6Qd?=
 =?us-ascii?Q?AfiMmeM5yeZbm7QlWmu6PkuS4WoZRRw1Qq02UPXhTZyFqKYFj+hHhVzUV7nZ?=
 =?us-ascii?Q?uC340wocUfChLjO/RiRSVJhhjzg+M1eXm4IMYDbJD+gdb5rcxd/RKOCKg5yr?=
 =?us-ascii?Q?yyXSUjRIqDoGdPiOcInO4PkX3Y6wYQTgtsE95KLdaIw3cI+EKTU1TVw//r06?=
 =?us-ascii?Q?ugF7rsdsLX0H1aKxRM1M1H+Iz8atGQXRw9UwU/0y7fnEoRgCWOKS7foaHBmK?=
 =?us-ascii?Q?XJv49GLB38hwOoD1UV6iFekgBd92uWhKXsWrdRHzEf8/GUeP+WvHHPUlb04R?=
 =?us-ascii?Q?fjj7YRcXfV8TJGgc0vcJzdDa4UpFscV2etvLwtRJCj4PNUI2TOcTh+iKtLv/?=
 =?us-ascii?Q?j3tsaJ8HhF4fVmulXIoXSJilHu3ID0ur2rYc9KC6poThwqicT31jserdKy3V?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978580c5-e89c-4b50-70fe-08db839b696f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:31.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jg0thKYXNmrrjOvPCPlCo5Gn0lRCQ0wUuPWkSyOy8C1j1fFCvg+yMGHmOm7yiozSlODSr9NKPOuGMJjj0jrBw==
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

From: Maxim Georgiev <glipus@gmail.com>

Current hardware timestamping API for NICs requires implementing
.ndo_eth_ioctl() for SIOCGHWTSTAMP and SIOCSHWTSTAMP.

That API has some boilerplate such as request parameter translation
between user and kernel address spaces, handling possible translation
failures correctly, etc. Since it is the same all across the board, it
would be desirable to handle it through generic code.

Here we introduce .ndo_hwtstamp_get() and .ndo_hwtstamp_set(), which
implement that boilerplate and allow drivers to just act upon requests.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Remove extack from ndo_hwtstamp_get()
- Reword commit message
Changes in v6:
- The patch title was updated. No code changes.
Changes in v4:
- Renamed hwtstamp_kernel_to_config() function to
  hwtstamp_config_from_kernel().
- Added struct kernel_hwtstamp_config zero initialization
  in dev_get_hwtstamp() and in dev_get_hwtstamp().
Changes in v3:
- Moved individual driver conversions to separate patches
Changes in v2:
- Introduced kernel_hwtstamp_config structure
- Added netlink_ext_ack* and kernel_hwtstamp_config* as NDO hw timestamp
  function parameters
- Reodered function variable declarations in dev_hwtstamp()
- Refactored error handling logic in dev_hwtstamp()
- Split dev_hwtstamp() into GET and SET versions
- Changed net_hwtstamp_validate() to accept struct hwtstamp_config *
  as a parameter

 include/linux/net_tstamp.h |  8 +++++++
 include/linux/netdevice.h  | 16 +++++++++++++
 net/core/dev_ioctl.c       | 46 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index fd67f3cc0c4b..7c59824f43f5 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -30,4 +30,12 @@ static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kern
 	kernel_cfg->rx_filter = cfg->rx_filter;
 }
 
+static inline void hwtstamp_config_from_kernel(struct hwtstamp_config *cfg,
+					       const struct kernel_hwtstamp_config *kernel_cfg)
+{
+	cfg->flags = kernel_cfg->flags;
+	cfg->tx_type = kernel_cfg->tx_type;
+	cfg->rx_filter = kernel_cfg->rx_filter;
+}
+
 #endif /* _LINUX_NET_TIMESTAMPING_H_ */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..17a442ed683b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -57,6 +57,7 @@
 struct netpoll_info;
 struct device;
 struct ethtool_ops;
+struct kernel_hwtstamp_config;
 struct phy_device;
 struct dsa_port;
 struct ip_tunnel_parm;
@@ -1418,6 +1419,16 @@ struct netdev_net_notifier {
  *	Get hardware timestamp based on normal/adjustable time or free running
  *	cycle counter. This function is required if physical clock supports a
  *	free running cycle counter.
+ *
+ * int (*ndo_hwtstamp_get)(struct net_device *dev,
+ *			   struct kernel_hwtstamp_config *kernel_config);
+ *	Get the currently configured hardware timestamping parameters for the
+ *	NIC device.
+ *
+ * int (*ndo_hwtstamp_set)(struct net_device *dev,
+ *			   struct kernel_hwtstamp_config *kernel_config,
+ *			   struct netlink_ext_ack *extack);
+ *	Change the hardware timestamping parameters for NIC device.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1652,6 +1663,11 @@ struct net_device_ops {
 	ktime_t			(*ndo_get_tstamp)(struct net_device *dev,
 						  const struct skb_shared_hwtstamps *hwtstamps,
 						  bool cycles);
+	int			(*ndo_hwtstamp_get)(struct net_device *dev,
+						    struct kernel_hwtstamp_config *kernel_config);
+	int			(*ndo_hwtstamp_set)(struct net_device *dev,
+						    struct kernel_hwtstamp_config *kernel_config,
+						    struct netlink_ext_ack *extack);
 };
 
 struct xdp_metadata_ops {
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 3730945ee294..10c0e173b38b 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -254,11 +254,32 @@ static int dev_eth_ioctl(struct net_device *dev,
 
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
-	return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP);
+	const struct net_device_ops *ops = dev->netdev_ops;
+	struct kernel_hwtstamp_config kernel_cfg = {};
+	struct hwtstamp_config cfg;
+	int err;
+
+	if (!ops->ndo_hwtstamp_get)
+		return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	err = ops->ndo_hwtstamp_get(dev, &kernel_cfg);
+	if (err)
+		return err;
+
+	hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
+
+	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
+	const struct net_device_ops *ops = dev->netdev_ops;
 	struct kernel_hwtstamp_config kernel_cfg;
 	struct netlink_ext_ack extack = {};
 	struct hwtstamp_config cfg;
@@ -280,7 +301,28 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return err;
 	}
 
-	return dev_eth_ioctl(dev, ifr, SIOCSHWTSTAMP);
+	if (!ops->ndo_hwtstamp_set)
+		return dev_eth_ioctl(dev, ifr, SIOCSHWTSTAMP); /* legacy */
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	err = ops->ndo_hwtstamp_set(dev, &kernel_cfg, &extack);
+	if (err) {
+		if (extack._msg)
+			netdev_err(dev, "%s\n", extack._msg);
+		return err;
+	}
+
+	/* The driver may have modified the configuration, so copy the
+	 * updated version of it back to user space
+	 */
+	hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
+
+	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int dev_siocbond(struct net_device *dev,
-- 
2.34.1

