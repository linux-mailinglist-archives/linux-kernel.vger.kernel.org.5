Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731E752118
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjGMMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjGMMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:45 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67026B6;
        Thu, 13 Jul 2023 05:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8O9rArhbNuAwySIZw5FPCvdNwPyO6e5wWFsA/Ah5jhy5IxKt6hx4cvgOy+xdcmsssZBmGrvrVgYu30zE9jKowFIJFFYba1r273d71RvoqAJm7tcBWCfSTM9ttxirtL8CUhZE2tb81Sy1eSl7wx9WzldkY5X33yndNvAmX8YSAq9W4OKGMXGpCbyHSGwi/pJq5LANMNw/n1a+3l7zhvJqSfgfgsVWxz3DaLf4U81X1u5lLpkaEGV39P5xB+f489/fx+dtdgfh+VM+ux17Fyh6WGying6y6lP8IFMnT7LhnrOyVwxoskHl9zzfg7i7qIcuOZt0edKmMhXz+gbAIDyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bulMk2xGDx0dc5wKTUBgF9zvUYsD9GrtbH0qhpPtI6Q=;
 b=JtH1dP3cBSC8SlxIhNwQ5Q6ii9qrzdjpZlyiQcl96Iw7EpaG11cnDmJTI89ZXF2+dbCMLvYQtg3v9/HTnAz9X9oonDQg3+XJBt9ZuGShZtKaOn1Xb8fvX0ugQJlwsEtfsd0F+ampBMhDLoq0ssmwMB/TyBvmgzyjgwhbzouRPB3yl50phJU8u7aKQOYNQnvvBGm/hZWcShQudZSVZCtPbYcBFkYYfKEz8p+HX4A5L2dZ6nUFLJyykHBYzlKye9djMr82+3+iFdOvPajsAF3cGs+/gLUA2SNqo0j15BhLftIPnNFjjSOEEEWADbDFNfC1nTRtt7ETusVdvlCCsxzJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bulMk2xGDx0dc5wKTUBgF9zvUYsD9GrtbH0qhpPtI6Q=;
 b=POE8LHBuxJGDd/w3nDdg9nYeWXdM1s4gzurM4QGurH7aHz4Thshi6jmFKxESDZy6MXGJJvkvcGuUQr1G9SciDCem7Y/D3sEOOodsU/WFww0sKpW2hdGLjPT+2bM3lOcBndwC1VS2Ou33YkXkSudz0pql+mZoVBY2kerDBN5TLI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:33 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:33 +0000
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
Subject: [PATCH v7 net-next 02/10] net: add hwtstamping helpers for stackable net devices
Date:   Thu, 13 Jul 2023 15:18:59 +0300
Message-Id: <20230713121907.3249291-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbcf0fc9-c773-4715-ebd8-08db839b6a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJ6ZjwDwS55M+tEj3DjD+lmLMd6TCFBjceyOz2Pm97arLlAu0vQsLHToOWM/cBAKI3MeJm66xgx7jEPeu89E/QrmaGQDVi4NqI9kFLdplpzOr8o9F05ClsfCzTs4nYH4u8DMQO3TfKukjl7Pcp2HWSvQ+NNBqfrsFaYEHy1i/wywie2DkmIKRZaKHMtKQ7yEQqi9gSitDSE41zOXchBJtDxfs1mzBeBl3W4xevP/1t/4FpS0/4cNNWcLvPtkTuJX9j0krgfe59ZLoq5Fwq1BxHTSi4BOzHzMIC2DICzo1bw5jJ0qCmmhDPzNQZL4CZgYfEJLgc+ri0VaqRetglmfKNCejsRKMPtCaSgKc+Xk5XVNtzxeTCnonWNAm8oX65JV7mhnQAcNqaR5G9KiPjvqzPRnq9qL1damYcjYybOyS8gEV3ud+IW35eKsi64vY9tUQnq3LwU/hzBGOWxm54dRzF3b44EX0x9J0kPqW2bWSs05alw9lYQ+Vo13EAIszrNr+YYKKnR5A1f7MOCg/Y0nmeYMLvcy2fG7L3HrVSM8MPBVL92MU4brVLraWZ3QuW0232rkGhi93KcX56Qi2kN7y5Jh3uNg3Fz9k10N4ZKBHJIWod9B2GgwGoVrtuclB/wb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhddB65bJ9brveBH1lJJZvRW4Vnajqvn3g8zH8C9FrMSrFTVhXIWFCPs5ZMJ?=
 =?us-ascii?Q?OlGaEcMhbC1lDWtMLiEFEbres7vb3jVJKuuKDLn3sRHDuIxlJ8Lmpabwc2/T?=
 =?us-ascii?Q?YkZqsfZ9cJ9DcJXJ+LBFUu77kkOsuPlrAVIF6qbGgu0wDMpp7RgUxFnmlDaW?=
 =?us-ascii?Q?r352M2iacvyY3nW9qF5CnJnGcfYWX7JlCjd8kwfLxhrGZcvreBIDSlgoVR8d?=
 =?us-ascii?Q?8FRVH9TDPNAedFj0A9vAac5DuhuGdKhMEmGSxcx9Xys4M9rKb+tz/mIwOOko?=
 =?us-ascii?Q?YiCVOKOHTdv6NSxt+8coUI7hknyv8RHqwMaVlQmxeyJhfx470SGgCeAKstuQ?=
 =?us-ascii?Q?k6n9E2dYhy0tJrk+C9XizFJY67he4PrpxrUku20qahgnEvCwp5csNsnNGJZM?=
 =?us-ascii?Q?VhdAIDfdjaUgu+9N5IgyDAZWvcCl7rQNhwzZwgAhUJiADbLcLYHJ8fdhlUBI?=
 =?us-ascii?Q?0Q4auQMQjsk9yBbkRjZny3yCB5un5MTks8l2p49SMIo7Mp3T1yExM2VCNrh/?=
 =?us-ascii?Q?UXf8XjwI8WbHuLi8LbpdXnyRSTUnEA79OdEJ67aroM0tcwDpPkCyheL/Q4sw?=
 =?us-ascii?Q?1JEFm23V0kILQ0rMWpa7YwP7HrCn4FWJ8FLeeTMjyQBCTMWpbgM1MqYnsjhj?=
 =?us-ascii?Q?DygF+kccnZvahr52pq7eyzo24oXe3wi9n43P4NFGC8rc4HJgRY+4geqQsrZN?=
 =?us-ascii?Q?Xl1DAtSjrrEMwdnTGNT9xDmwMLAhjrt5qrvL6QzmFyzTtAvdf/tiUF9WW0Eq?=
 =?us-ascii?Q?hdNGpxRaYWY0ysjpD6rZkq5+33aN0S4uj3H37uPbs9A79EXPCy4NvyTLU5SD?=
 =?us-ascii?Q?2+5n/5A5YxtKU5hvHBSINdeNIJhRRMZTCQJkCnXv/OKahsZhTd1wYOT7r9hY?=
 =?us-ascii?Q?FJBMTZMwyakPslZvdbYKdqaHAqxBLwSs1Tn0dQWEIACCimJdJx3vI1SOTmDa?=
 =?us-ascii?Q?J5IiSflWlRLw/ZXH3vIwND6fFDwp1kiMJA90vq/0QndwH5bgyTB0G5idpvpS?=
 =?us-ascii?Q?tul49cVadUR7Ip3tzNkubCeKaYHQDU53+7UmHtoctpEgPnC3KgK4yRFs/HJ+?=
 =?us-ascii?Q?I/Tk7s6Hir7+oaGCTSiEjOXDbK/ZZrQp83H7tT3JMoXUa9dfrdOOGr9gIvWN?=
 =?us-ascii?Q?PtIXP7SbKsciXI4/ZvSsyB8CKmNQfoik0FruPEi2D/bS66ixl+RzcGkFdB75?=
 =?us-ascii?Q?jwYPYy1fda09UqBWhxRFEE+1Pv8bOvaRSkI8ADSeFBR+2mmGg/gN0uXjNY/0?=
 =?us-ascii?Q?tZiirju57YLzpS7JwkH6VKATUyhTdUz1Mpll1Shnu7Yu/z2TaRynjfO5Gk/a?=
 =?us-ascii?Q?TA+9VIbVKNEIv0l3WYlYJ36VcT7SZ8ho6Z8V6IfAAuM9XuXzT15jc7xJOfck?=
 =?us-ascii?Q?E6vzFNhoW+7EhONvnvaSDsB9LN8fq0HT/6fze4HwDEdhCLUuUHxhuP/4f4Sy?=
 =?us-ascii?Q?8oIahiWOobCi2+IUf99ojydqZi+dIt5VEX/6y/KHlmPdbxBch2QP8MmAF8F8?=
 =?us-ascii?Q?WHQysSP/qhScvAYVkdZuUMQGMrUeqbOipdX2Hln4yq4w4g8tBsUY1XATm6fv?=
 =?us-ascii?Q?sM/LgGNfNcw1jQpLUncSwS7YtNueS0zlKgFLILEgX6utcnl/EPw7imEHyBG0?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf0fc9-c773-4715-ebd8-08db839b6a70
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:33.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ppwr0rT8r/REDuzQ/SR4f2sIZuuOV0MgfwDUaPsnpLpTIdeCPhp2zDx4b4GPQV3FZmed98+nf3W+dChCy0kYQ==
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

The stackable net devices with hwtstamping support (vlan, macvlan,
bonding) only pass the hwtstamping ops to the lower (real) device.

These drivers are the first that need to be converted to the new
timestamping API, because if they aren't prepared to handle that,
then no real device driver cannot be converted to the new API either.

After studying what vlan_dev_ioctl(), macvlan_eth_ioctl() and
bond_eth_ioctl() have in common, here we propose two generic
implementations of ndo_hwtstamp_get() and ndo_hwtstamp_set() which
can be called by those 3 drivers, with "dev" being their lower device.

These helpers cover both cases, when the lower driver is converted to
the new API or unconverted.

We need some hacks in case of an unconverted driver, namely to stuff
some pointers in struct kernel_hwtstamp_config which shouldn't have
been there (since the new API isn't supposed to need it). These will
be removed when all drivers will have been converted to the new API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Reword commit message
- Convert "int kernel_flags" to "bool copied_to_user"
- Minor style fixups, and a refactor of duplicated code into a common
  generic_hwtstamp_ioctl_lower()
Changes in v6:
- Patch title was updated. No code changes.
Changes in v5:
- kernel_hwtstamp_config kdoc is updated with the new field
  descriptions.
Changes in V4:
- Introducing KERNEL_HWTSTAMP_FLAG_IFR_RESULT flag indicating that
  the operation results are returned in the ifr referred by
  struct kernel_hwtstamp_config instead of kernel_hwtstamp_config
  glags/tx_type/rx_filter fields.
- Implementing generic_hwtstamp_set/set_lower() functions
  which will be used by vlan, maxvlan, bond and potentially
  other drivers translating ndo_hwtstamp_set/set calls to
  lower level drivers.

 include/linux/net_tstamp.h |  6 +++
 include/linux/netdevice.h  |  5 +++
 net/core/dev_ioctl.c       | 75 ++++++++++++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 7c59824f43f5..03e922814851 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -11,6 +11,10 @@
  * @flags: see struct hwtstamp_config
  * @tx_type: see struct hwtstamp_config
  * @rx_filter: see struct hwtstamp_config
+ * @ifr: pointer to ifreq structure from the original ioctl request, to pass to
+ *	a legacy implementation of a lower driver
+ * @copied_to_user: request was passed to a legacy implementation which already
+ *	copied the ioctl request back to user space
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -20,6 +24,8 @@ struct kernel_hwtstamp_config {
 	int flags;
 	int tx_type;
 	int rx_filter;
+	struct ifreq *ifr;
+	bool copied_to_user;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 17a442ed683b..ca3bcf2257c0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3949,6 +3949,11 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		void __user *data, bool *need_copyout);
 int dev_ifconf(struct net *net, struct ifconf __user *ifc);
+int generic_hwtstamp_get_lower(struct net_device *dev,
+			       struct kernel_hwtstamp_config *kernel_cfg);
+int generic_hwtstamp_set_lower(struct net_device *dev,
+			       struct kernel_hwtstamp_config *kernel_cfg,
+			       struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 10c0e173b38b..d0223ecd6f6f 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -265,14 +265,20 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
+	kernel_cfg.ifr = ifr;
 	err = ops->ndo_hwtstamp_get(dev, &kernel_cfg);
 	if (err)
 		return err;
 
-	hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
+	/* If the request was resolved through an unconverted driver, omit
+	 * the copy_to_user(), since the implementation has already done that
+	 */
+	if (!kernel_cfg.copied_to_user) {
+		hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
 
-	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
-		return -EFAULT;
+		if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+			return -EFAULT;
+	}
 
 	return 0;
 }
@@ -280,7 +286,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	struct kernel_hwtstamp_config kernel_cfg;
+	struct kernel_hwtstamp_config kernel_cfg = {};
 	struct netlink_ext_ack extack = {};
 	struct hwtstamp_config cfg;
 	int err;
@@ -289,6 +295,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return -EFAULT;
 
 	hwtstamp_config_to_kernel(&kernel_cfg, &cfg);
+	kernel_cfg.ifr = ifr;
 
 	err = net_hwtstamp_validate(&kernel_cfg);
 	if (err)
@@ -317,14 +324,68 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	/* The driver may have modified the configuration, so copy the
 	 * updated version of it back to user space
 	 */
-	hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
+	if (!kernel_cfg.copied_to_user) {
+		hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
 
-	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
-		return -EFAULT;
+		if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int generic_hwtstamp_ioctl_lower(struct net_device *dev, int cmd,
+					struct kernel_hwtstamp_config *kernel_cfg)
+{
+	struct ifreq ifrr;
+	int err;
+
+	strscpy_pad(ifrr.ifr_name, dev->name, IFNAMSIZ);
+	ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;
+
+	err = dev_eth_ioctl(dev, &ifrr, cmd);
+	if (err)
+		return err;
+
+	kernel_cfg->ifr->ifr_ifru = ifrr.ifr_ifru;
+	kernel_cfg->copied_to_user = true;
 
 	return 0;
 }
 
+int generic_hwtstamp_get_lower(struct net_device *dev,
+			       struct kernel_hwtstamp_config *kernel_cfg)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	if (ops->ndo_hwtstamp_get)
+		return ops->ndo_hwtstamp_get(dev, kernel_cfg);
+
+	/* Legacy path: unconverted lower driver */
+	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
+}
+EXPORT_SYMBOL(generic_hwtstamp_get_lower);
+
+int generic_hwtstamp_set_lower(struct net_device *dev,
+			       struct kernel_hwtstamp_config *kernel_cfg,
+			       struct netlink_ext_ack *extack)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	if (ops->ndo_hwtstamp_set)
+		return ops->ndo_hwtstamp_set(dev, kernel_cfg, extack);
+
+	/* Legacy path: unconverted lower driver */
+	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
+}
+EXPORT_SYMBOL(generic_hwtstamp_set_lower);
+
 static int dev_siocbond(struct net_device *dev,
 			struct ifreq *ifr, unsigned int cmd)
 {
-- 
2.34.1

