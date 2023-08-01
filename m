Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78A76B769
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjHAO3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjHAO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA97E5C;
        Tue,  1 Aug 2023 07:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhuuL3uJ5J1hHoeNjriaNq3FvFNzLHVb3pcPmM7/5bMcqU+G+7nkmL1FHJ5o56WG3wNWeMYXjbaEn2ujoIN8Q83yfFQGe96zgeZTSBZs32KuAa5E8PD8Gqb+CFXsx4JvkxTa3YsmXq5ImDz+BVwkTcUICxHdxu9CPKx3dN7RC78VNSzkMUn69GG4u7+paF54VQw+dSVAZJHCToaNKHTTdTC3fGInzR4WRCZp+rsLjoxctpu4EPqaYQRPS+aQDysANB8Fui1fnpjn2rvfMxRvMn6eK6ujen5xmYLqp2FIyKUAWf+bkFGhZ1raXEel5N1xWaYtSU+s1Trv909powjXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ylq0sfzWLDkaSID0Mg92hITOUDERT7QxQB0JI0eAZ7U=;
 b=hsFtzC+Hkxz4GDucJw3p+h3gKbUUEAA6GbofujTTEmf5Q7VtY3V8phEL+1Qop3r1VK0IukWRehvOi/UiouFMK49HVmaKDPBpYJjdRwDzgKciXCLxh6td4yJwvlPVnXpadcaKKTz2JfJWWcMsBhkhbeJKRMMGBaW0a4rDyGAqaKZ+2DxSgMz5pi5v/L0b+zu4XHfrmsLamAgKTq1SdP6htMZTYUHCvF8Ye0yZPedK4HkpbJFkyct994vTOnsbIaN8l7PnO/hYxU0/kr614cQ6tGzjcItjVdD9jf4WpE4dUtVtf2XwCtIlntiQjNrfYeD6fXzbVmwIDbeTc855BNvoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ylq0sfzWLDkaSID0Mg92hITOUDERT7QxQB0JI0eAZ7U=;
 b=pN+sZgONW3UmnACNGGb5Po7nYlIgYx60Fl2M2jOHlfh13dTUXmqc80KSZEpp98zc1epmd2JCmey3l5UNYNc4CiIi9A471hQmGgsoAvoXLdXeY0m/d+HRKyr+2/X/XiBKAd82UzMLJPhFd9ODyAPZpXnPLasxJdXl1gVboTd3naA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:24 +0000
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
Subject: [PATCH v9 net-next 01/12] net: add NDOs for configuring hardware timestamping
Date:   Tue,  1 Aug 2023 17:28:13 +0300
Message-Id: <20230801142824.1772134-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aff70993-8e65-462b-fa59-08db929bb3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlwZXPKkx0VN9eJ0vIhhrKYtubWHxIF1zuiKNWVU7qVU2TNHxoWEIfQpS0CWyrgoVApPOVwbx/+/Ep/HZdbFnnjeDqguo3mQrpKUMpWDeaZdEn2iDyFt3IyUSP4ziFBllnT94f6oElfSOC3xp3ttEeLKfkrdKlQJii1/uMZVL0rNudUYwZPi1WSWAwvQNyJeTEkCXgwlRr3+TCQ4B+VlPDSEa0HyoFzvXA0iDijZAJXD2zx22B5yyrQ7fsxw1FczUlws7s6jMJg3reSDIOyFpBFgTiGtmqLMJQXLXke3nh4PjBMc12Cc9JJkoYNKGBr2KwDUvW3pfiV2o3ncwaGeu1yMf47cc5PdzP169rtSR/ozbPRmrFhjuPCMgpL7qDTMF7VWI3TS9Y10AZrTwKqvhSUuEsFCL/URYElADWEMr5LYJH5UNf597tn7SPSwE/ezh9y+4saChO/CpzwVLObbKN+/W+siOnOQFqHoDhNUJOg9CPo77yLbyb+mQl/05IMp92b+QVpXvK/IPJtlXSfYgLAqc+P1SEo47rCezOihhULYKSkwhBW9D+Llq71LZYHn0l9DZSW+qGvtFxTMdtFAeUxjg8ZKBiEISBt2frtZF53OQJEkGeEZWyBEtE76aDH/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4Bdi8LGrQ7opcv9m+mfIwDQxCgJr+Hcv10iAOHLZofoG4W6fW+slDPVhvTS?=
 =?us-ascii?Q?seCX3r8GJPVk3WJlUe6i5m7H+eHtNOQ/T5ti7sXBprU2HbeOAnPcsJgHJv9p?=
 =?us-ascii?Q?YxoycW1wrFFTinuYDmNgkMirQXk9iFFeAIv4x3hsS88+FaoQK/wwqrtsfSAQ?=
 =?us-ascii?Q?PrNuluxqGXNTdXtlA/tLngdIJxX5jWKfJm1+JT0sFJyPhWb2kxL8vBZJekmt?=
 =?us-ascii?Q?rPG2MEPvSbpmA21TUjACralvpBjkcv1ASeqUnnrMWpz7BW/jwPfzfl8P0vpN?=
 =?us-ascii?Q?WS87aKkja6t3tARVVYyenAC5weHYxP0+2u9Z1Jhf1kAGbPHmTjP3TuCKhP96?=
 =?us-ascii?Q?C+B+KUJIJUl9iNAYftSKV00g7RGjQtk1luNK44T1pY6nlfIifcBziWkKC3dh?=
 =?us-ascii?Q?h8To7O6Bl27seY0Fpb/CwNymjs2S1Xjmn5rw5i8S2/uwLioG8U6xEqdG4qjF?=
 =?us-ascii?Q?D2n+a87nbnoJAXut602r1JgjknFHs3+Tep8CL59065k/ZtRRMpoi4s0FnQtY?=
 =?us-ascii?Q?Puzhs+Tpsb1qiWgNLLVOUJREn+6w0H8rk8zW4Uz+x6mJ3esLWFeZBiF3vpi0?=
 =?us-ascii?Q?YCIBWgpEBQqy9DN3/Odl0KSQt7CaUomUiDPeksxx3zPWiKiGxjIUv3IGACwd?=
 =?us-ascii?Q?dvizaAhwB6r+rtM6F3FixAjIRVJU32L3YnybqRyhvU4gF+KysM7MJiQFeRmI?=
 =?us-ascii?Q?b58iDdyD0t8Wj1I6kCNqeyEk94sl8K2xsuhrQwCPj8yXl/Znyp43jl2vmYWe?=
 =?us-ascii?Q?7BAZToQggJ3VnwlVql5uH06jVu5l5AWg5UpyaSJhD2y9qnhwL3O5m+idlNo0?=
 =?us-ascii?Q?KO9ZBJlPGzMK56kvO0z+Y6IJGf9EP0JbsYEBDwOj73XfCceAsnPOgB2qAgTx?=
 =?us-ascii?Q?7uPPND2tiTUpHQ8S0cia++26BUmU0GOcFdPqIf8zf91sLbp/NeSgtn4cWI4t?=
 =?us-ascii?Q?Ntc+KfLFolOMAKHdg72c16eDJfvcx8x09IEktrsgzDvMCGbMkvQUi/o25JAn?=
 =?us-ascii?Q?I9D3dTmIkV6dA9gpnrChawlhSJy/4/TH7lM8sfKtuJZI0Ut/1y2EpxrcfntA?=
 =?us-ascii?Q?6vPs9+YOTzs11N8B5xqFz846nLcZe+y7My/q1Z994gCEzipOnAgdbjRLNRdv?=
 =?us-ascii?Q?cPU52+wV+yvL7tpAUb7X6J5zErQK7V1kUZOYITg68V0+0kD7VI9ASLdchXhf?=
 =?us-ascii?Q?P3edct9w0T3ix7LhICH8zJkQKOcju29YqckD5gbS9Q3NaZcsetvWOnKYdnZa?=
 =?us-ascii?Q?mof/HLQSPYIsYMcqmjfHjllcjTB6qSuI24MHSOlVQ0l890UMv1la0TzoPpUZ?=
 =?us-ascii?Q?h+hnHkspLcaaDw6M2jy6EHhnxER9hH5b+vzXJ+AIckv4MsrGlapDxp94aoPL?=
 =?us-ascii?Q?sAsZpc6Bpc770lVDieG5crYzwQp3cgqnAH6osG0jb5iRFhE7jKKPxhHMDaWb?=
 =?us-ascii?Q?xK1IK72J7y8xesK9O0Q66Fukpx8z+kabvTa2yBhpTEN3dGfefy61v3QtTTFU?=
 =?us-ascii?Q?O9rX/EwCYQ63RltOwB2j9Q2XmpC75d5fZ/zP2qGY3B6a/w/ns5FOT/s6SXfQ?=
 =?us-ascii?Q?ZKyfq7IhtnEkO71984cIsDh7iBozSfkwZK6qQ/qXnyJR7/rP51P4AK4rSI8l?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff70993-8e65-462b-fa59-08db929bb3ed
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:24.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUubJpm3LlonceTa+eJjz3nQn1aDXmIqeKkK6Ni5aY44cVPqMGwmHA4hIX/LTGcfEf51/L4jpZSg++KUVE1h7w==
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
Changes in v8-v9:
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
index 84c36a7f873f..08a0b8d45dc9 100644
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

