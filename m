Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD976B76A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjHAO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjHAO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E5E9;
        Tue,  1 Aug 2023 07:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjEyVEBXaG+g0n/xMnAJ/Z9v1oevlIF9mJKCAbS5LQAQwe1jXBrSu7btiSrDK/VUqiDJIslgKoXjZU9LdF8K+NLbtpUyASWok2AJbD4EjRfnptSKVlON+PE1O9I6Xo+sGtFrqwvqV5+PFseY3KibAl5NCQkIToyHl1loOz/Hy7dkkKMnCACq+dwbB4DKGd3kSqNnxRUAnPBC3QAQDL5MzsiCjSyBXaGReJmyzcdp0JIguz4B5YpyROERRC66sO8qPFxXwSTATbsyNI9e2Zwd9OSu4wrKnQIxr75kbb1+q/cEy0rO7WL1Pc8KaE4VbmW4TOZStzhkwMOnQw9fnhp+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAXdw8G53XWKHZXnukLQbZQwFnfJ6/EfBR+/S0fZrGs=;
 b=GiwvMiGXK6EkTI1byG5zcaD3Dp2ldLVfvSUw7woPbFwvFSV4YcKEplrb1U0UzJy+iMTAWfUr+JkpJiEk7W56uNKlGUpVBTmiV1oF+01jdtFDuVQ5pWpA4gs8n5Q0j+myPl5OFs7AmeQUcA3xe0HuOrFUmhtAPg3rr2oeYswRDfyAsuSAeDGVjRYDDizdRugFRH8bok+LVyn7ZNNNIR+SpXWQWIoF71bHBMIWRJBiq0tv/FmZAFvBofMl4BhK3iOgfKxpTnVuhyFUuY1QTEMwF7VvOLCTKDYzm7KGgm4NbKqqxSGk/eNJ3uRUtdKzuX/uvFPKSt5dPP3rmz+0HGh5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAXdw8G53XWKHZXnukLQbZQwFnfJ6/EfBR+/S0fZrGs=;
 b=bgk0F+4K8iKAMwqaz8IWPvqh5x5F/P8Rql+nfTg6VmEuD3ln5aHrVx47LzhujmQB62TuC2hqS8RQD1tw0oSE4rMwHj9vKxcPHuhfdu6l0JaA6Ou8b0r5gPRhBbzbkNXHAE8IeNjmoPG3Dipb63XjPplV38DZJetnYZzBF4xk1Qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:26 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:26 +0000
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
Subject: [PATCH v9 net-next 02/12] net: add hwtstamping helpers for stackable net devices
Date:   Tue,  1 Aug 2023 17:28:14 +0300
Message-Id: <20230801142824.1772134-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8aa3645-dd80-45ea-85d7-08db929bb521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp3RaGwpUhHJexYvppnSDmwrWdWMF8vPj7IUdOVJjZJ0MP5RvyEQJhlYK9bSWR3Q7Cwqzcz1SPv2VdYB4G5lWeJ/C/71q6tCw9kR8FR/YpGSi4rk3SAvsbsH+QMffVhaDSlz5aCb5dPZED4W8NCMJAnO4FcdOw3ZG3TUu5Dezas455Q8u2yxXfzES2PsRlHRPTDjuKbysPozzJGWO24lrOVzwaVZOXlYCEmAb3ZPHkHVcMkt8YP3iVkt/tOPklqAPRAHbpJCGqixe3TQlVM7h9lP1KljIP8G65BClshW3DiQOEpvIA7qttSSjFTAbT8/Nlffh2F3CMHXQKsf3MDlhbsAHB6FwsmhiXwxpsewctBSzqZOkVyOu35cuItG8znKzF6ETJPucijCuickz68garhsNWcEWzMp7tzgm1fm77oRRTKvRXnQLqzLaGw/W8n6bvHZcRx+ED/ZQQU9Mwk1amuW/ycO6g9g78f5HN5htQu9AS3BYLxQ8cs/XAVJBqKORRwui4GBu2N6wtT+wxBGAINObCCTq4F6Ax7vRJXV9tNzfYtv639GmqFZH1BnDEUMCnXWAsANf54g8AmOaXce/VBOCT4mTlD6HlHoKsDyA0+f1XrTp6tARsu9ZVazTyyN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/HBus4Mm/9cboa55boDz8mQc7ZV/rlHImBlZJ8GkPoWcgoRBUgZeRNkE+vJ?=
 =?us-ascii?Q?h2rvdeFITOZVHrSLuuvyjHiW2X0lVILG/+MmlXnTLlpiyxBOrFwnjHQsMPdD?=
 =?us-ascii?Q?3VxjPk6DKXw54dFFZzF8B1lV3jABIweNpFqEMRVRcIptGQivxu0LN5cSQ9dD?=
 =?us-ascii?Q?zYY1SVvzVbIWN7nn/6DfKzKtZ8oAPFQ8QLavIXtr4Q/jywBj4gdh7xIG49in?=
 =?us-ascii?Q?3A4JyDTSXpbJ6JOC0u6bDs6vz4Im52IQ3oB6EMicuiHEOMDdiEXKEPHyOe1J?=
 =?us-ascii?Q?Sm/N5NyUxyhFQz55cMCQHR7n7l35PXp+wtBVaqIkHPNKx0ighI/ZoBuKxZB0?=
 =?us-ascii?Q?xvdKmkwM9KDK86K7sDqucxTJDXRxO1FgmQOhQBPtE6/611gQGlZhoFsDco13?=
 =?us-ascii?Q?Ddton6LNNch16SjiQClDTMz43Z5TJRKyEydOxUuwjanfroXBkWB+gXJEIJZa?=
 =?us-ascii?Q?2a06zKGjA73YVxDY1iYtYtPkiNwaUgkgCk1e8U3j2Z8sBxP5Epgk46Ljz1xI?=
 =?us-ascii?Q?WQcQfc70vdc5p/yTQeNAAVdEMb2UTkKA+WoS5OuxW/0WxKnAeaysUKjWfFYE?=
 =?us-ascii?Q?teNfOFn+OaO0vT8kesLPg+KD62ExqFyrPt5VTt+nBU4L+HsxAJiackfEr4Po?=
 =?us-ascii?Q?Lsjhazid3cs3SiXhQ3L9cIp6KJuC3/4waAfsBegwO9OZjlYf3dmXp2b9ibBm?=
 =?us-ascii?Q?fZFWnkO8sQ4X3SFEg93jQzkqUCZ3cMCJlN7wzvMtYnFOkkQFH/vK/u64Sb19?=
 =?us-ascii?Q?S6/xki4h2ZuaP0RETSOJ6Bs3ETm7XS37R49WzoMoZNl/NB7K1+8cXuM8j+Mg?=
 =?us-ascii?Q?EjlAngiViidLZEQXFoWvT3HMUopgrEIUImTkPWD0i2wEhK874FguEc3ATSJX?=
 =?us-ascii?Q?dUfAnDMIIbDow2n/p1kOBpUGqpIlS2Flzns4HDTeuue2XXeX7hD3BWjfVp9l?=
 =?us-ascii?Q?npADeD6VG5OvH/spYqqYm0DgJ9n7btybFjsX3q6x9660k80qI09skxAluFwl?=
 =?us-ascii?Q?JqRWJ6vUich5WyPnpH2KNDg+nytY6wIACqPSOSdMS8UQJeUV3SVWhws94vMv?=
 =?us-ascii?Q?Nv1r3gW63iARxmvStLDtuwxow39azdseJSN44SJi1EaFZZNXqrGc8JliIdRx?=
 =?us-ascii?Q?PUDtBMuEmuHaFQRjKTTCpPO8BB5311vmsh3An7o/8kjkZrtMsvdfoJpGH9EB?=
 =?us-ascii?Q?ZSB1pbq6Whgk+yXIqh08DTq/eLUY6VqMWvzJw8AMKMh/W9/llCnh0DaSV0Px?=
 =?us-ascii?Q?8fWEpSudKDuEMkab7uN5vHVZ2ghXxj9JGrRCOpcm8RbW7TvfQ4f0TW+K+CjJ?=
 =?us-ascii?Q?laZ0rL2WexlQrbEwzNSSxJBRPV52xWnTQNC97N5XVWiH8YbY5vv4btxTUw3x?=
 =?us-ascii?Q?/dm7O9W3ZnkbLDtCEcLpV7pjcbf+g9GIcEHN8bG3gkJ7YVmOuYfhS7gEBmC/?=
 =?us-ascii?Q?BTilNA2OLhmq+7GE0fIh23fZr26hcG69k73s4EEiL1dPtjCM3MWQSS7OnGmb?=
 =?us-ascii?Q?XXMsdoikrC4/8QCPd0TjOtwL14jBvXRAJRsKlKlSM9tNfJDgSbsLJIGiV9YL?=
 =?us-ascii?Q?xI4/YHJMcVf5bphAPohfrq6YIGsk42U6QkE+w730SECK0NHZP3NvyTooZUzn?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aa3645-dd80-45ea-85d7-08db929bb521
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:26.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxtSo+7fnCZSlff4ehczLkpnA2dL4H47UxX5CoYE6U5XnTds3RPGz+DzLudxk+2SqDFu4ijWuABPjQ4y9O2/qw==
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8-v9:
- None
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
index 08a0b8d45dc9..23e335f245cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3950,6 +3950,11 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg);
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

