Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4F7567F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGQP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjGQP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77502199A;
        Mon, 17 Jul 2023 08:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGYA+ukNocGvDMWY78smGK7pb6DWLzb3MUAJKEjZDadKxcj6iSzK3HqS61nLyGdneOUK4sJUK4v+wl5UEXYMdP4JoPZHdNtIGE/z7sUeTt97zJrO+xnlk261dwcr5MViGOwMm4SoSdmROqPES8fb46CJuw5FHVHGSOrwk+toTXnoGBxBfFn89A8G8/LVeUhNYBYX5a5pXxQdqRQmGQ0xlRn6hX2I3otHimuoBzHxcTPdAoB3qtFH+o13Q1McPmIyUkMf3K+Sozotsit2i65Fvg1gorSxy1OyK0pI0Ksx2lpEJxcEk1Iv7nmiReysFv7I175M0MdTqc2Cw98QDVBSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg+A9fEjh0+r0lOpQqoLdNZpxQ6zFhDo6POuUhc0S3c=;
 b=k3ME6uaxi7CZYZ7NMFswceR03bq9swjgk9djyYdY5WmQ5FBqBgTNNX5FeHw5MpO13o01M7D3BtAuktMZtEABV1h0cf7wwJ3KUc2aDxbUvF4fCx1fjMzVReSwP6xiihXl/F81kK5niIApqGXYUWqVKeaKI1NMy6CK0N83D7s31WO/YJ3AVX3vOeQ/PtAtZ/5x8SJNF3DRGbyM54YyPwG+yAfVOrV3qvW0oCP/biT/0vbH7J7c4QYz6l9cPQkw4UtSkPS40tBXOQBqogbKQSBZgvuPBo6G+INmmWcUcQWRCo1uDbCSlC5RxND+XBB1ioFrMVgb8eplFP7W2dP8+auDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg+A9fEjh0+r0lOpQqoLdNZpxQ6zFhDo6POuUhc0S3c=;
 b=fX6+8xokXiJztKDUDFoJfoYnE1cOAk9ZGu0whYkxl8U03TrPC6idvzd9Yff6n//YoOQpeLYspQdZiRo/HTEKVyD57ohlgP/MggcKGXPt4naWNJDVM1dNXlZCZGfu9I7U+0u4DGwIYa+YzE/lsSgo/ajwaZhOLKEgfTfvdtYJ7ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:25 +0000
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
Subject: [PATCH v8 net-next 01/12] net: add NDOs for configuring hardware timestamping
Date:   Mon, 17 Jul 2023 18:26:58 +0300
Message-Id: <20230717152709.574773-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4728be3b-995a-4790-5f30-08db86da52a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Qfk1JDc9bDxkMsclpPhA0H154cBYq7QikJCIX4TbmBeEuasEKJy9OkezKJ2Fcv8St9cjMQ2HcEDFpH8mfXbT/dLykuA3MNXQBmV88RR8S/JMVHuE42DxOVJuZUVTEXEqryaYcmYf4zX5wkjEfQs02cRbAERARb5cuVCUTuGFbDezs1XO28f/G0qEJ2wX4m35I9QCgmLuI5EKyh0aHi62s6zchboWO9sDbBrS/NSonxpYGVtUhBlf5Ufz7sbzDrDJcGwK91T7DI0IvpphzrmdFW4rUje17exTssJOKjtd/MKY/5x/CPUzJKxDJ3VQRDXP7L7gcGNbB8pvV6TtF1IY8h4FNGK7aIMQXP08JhIPoJJsGjY40PMCcTNZH5/erCmaOUMJnQiwYlmtgvcrhOQBYvPb/fhzcYAuakunOukEUIaVCKfPYVdAjIcBskHgQiPFTcOvGo/6L2uqeJqqc4xSh9Y9sL5gRbjayfv3GwCed28YkFdp8B601sCJWHFqoyjUZ9AKrKaJy0B6krNlfLakEhP5+yzGtcVwQqtLdwkarlvkOTryUqoM+ACImUJ6WKY9Wd38UZrKNlEgVQBvj4kbQLXNOQ8HxO8kfeVdGja0HU15EQ6FYlyAS4VwdGY+qAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohYdY1r7rUbbX/woGuRow0xfEMtZXXDC78UVz+x2wYxbpHgExP6AgdpMQtZe?=
 =?us-ascii?Q?waRcoQU30SC7CCPc539jUKFywOA4rpMOut0uiFZ+5nP+1sRGytorglqLSac5?=
 =?us-ascii?Q?HzSW1+3PTrxJejQRJxhf5bk19PNBbh+OLJ7g5TgvG2WBJNXA879gMip2qoq2?=
 =?us-ascii?Q?twSmSja1snisq7NXJg0t65l44weAD7IibMq2HbvXJUSwgP81G6j256tHeAba?=
 =?us-ascii?Q?SiU7sulXDhfFU4kUBHW2DoHL0zYwh8ARjxahs6imR09QOrCKOexladjJ405o?=
 =?us-ascii?Q?8T7h11XbF7h5/a6lwNpQCNOLqCB48veItJ1hThqhwEV+Sv5oVgNl7yBKeqjA?=
 =?us-ascii?Q?pVLNrvSgwZI9N0MXOKZuKNHEqoEGlegL02HNiRTzxRhPoASD8Fuv9F19N+cr?=
 =?us-ascii?Q?xlOZYP7fAbxOwzaypLsqWLfIhzxHVn1dxFjXgKcBTB9/ROgrumiOrjdoNXtS?=
 =?us-ascii?Q?Bsoz9aeEI1EjA7vCWwOJZnFTlFtzCZrdzO9Twla64CdUE/vRRAFe5072NKEG?=
 =?us-ascii?Q?fjPb2VZPsxrw2OcNdKDAr1sZjuMNTg485UXYePv1ffQ3Nicx5HBupjKVFMNL?=
 =?us-ascii?Q?0YCVivqIV4a36ua7CV6L8e0ee5zrdn3JJOnNx1tw5NeV889+P8MqEFFt2z2g?=
 =?us-ascii?Q?E9BgC1fNmt8ToGbyiDXQ+TDDKJX71g3xf2IUKAjciOmpLGYfpNDpxk9YBKUi?=
 =?us-ascii?Q?u65iDlsF7kfColkxIShHK1H4hSb6L0K7w0BIL6J7OLdywQrQhz0jCnXrDrpj?=
 =?us-ascii?Q?JfAOZKBb0CapE0ckjezUKo/LFJXc/OSOZJxoR9Pt9tepkuyV5Lw6GU18g/Ww?=
 =?us-ascii?Q?zls3N3Wp4q2ALkUrKtzvZshsa71vooeMcGlIra552lmBbQUdeLvBivlnrXQl?=
 =?us-ascii?Q?4iNbwuZB+MGIaeGvBrC2effli9aUC3l/z4DsHamEMos4YMqvZxiqAbAxoJ6L?=
 =?us-ascii?Q?Aw2lFVIbASgtz5S3WJhG128zMjLaJPSNB7m17TIW9sYyI9G2lc/GrjVYRPom?=
 =?us-ascii?Q?X27awHD1VcuqPqeTTt6ALvOR36nEWPgS1/H2JGWm6+jaOQAwH/ET673CQDqT?=
 =?us-ascii?Q?fVwjQQ9duzrV05RRwXUAwCoc/l2zA+0kqi1dU94rBLJio01Iisyt1SrnvHuv?=
 =?us-ascii?Q?SwEfLUsMay6pmfnpKsTlMbKbXlrAB+x8k21PiC/HLLjX6Wyu9X8B2lGF7lKn?=
 =?us-ascii?Q?iHB/5zOfPJ3RCjlwE6sfSNDHJP2MdDqdGV3C9szuCI8YnbBQMOpSabWipzg3?=
 =?us-ascii?Q?eAUQ/dYIyMgcjyf6dI5MrNaXIvKNqHBd5VgWOdMuEzqaas5INLKQJxXCiMpq?=
 =?us-ascii?Q?imbo66ZnyS5JhUY+Hxafv3JRV+cjkDyplNpJg7m9hQSF3L6WizeooxrZnJYb?=
 =?us-ascii?Q?kZA5SVbVU1f6LTrvfREhe5/q++cSy5lxOHyiBLhkAqHbFlf0jQwROupCg9in?=
 =?us-ascii?Q?hwYeZq7l0AwWr1Ujh+gUuDZVsznCXqPI13ydHuqVb8sIY3aisFc5cWh935y8?=
 =?us-ascii?Q?O4q2bSgYlXcnZQntdg3Qb0geo+jPm6bb/zG+0p3ITH+Nedlm7eQZ6jxGR6Df?=
 =?us-ascii?Q?41FfdEhfj82ujsPc/Rr34eRmsc8R2jBlGte6xsuEsZu6sdE7kqbLa8nDz0CZ?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4728be3b-995a-4790-5f30-08db86da52a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:25.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeMSB4LdHuzOTLOQw8Hjpjy3SEVVts3UfIJpTzZ1hEhYJzJli8SiiVAy0cxNvxCbNo5sn6a/HFjoTjDGKtz3XA==
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
Changes in v8:
- None
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

