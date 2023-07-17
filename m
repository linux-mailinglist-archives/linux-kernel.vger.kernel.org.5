Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1327567FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGQP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGQP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37561706;
        Mon, 17 Jul 2023 08:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMAMLXZxEEC7kOpk2jigCwSzKZjphsJ7XfU0+8OZYHwINfQSMb/3e1O6YXcav/CeF/sq5+IrskNe3Hp1dzhio0Q6vZ0q+nubtHFohdUTGm3f58sJ+wtHYzm3feBnixd4ITam4Rm9bzQdPhj9gahBbl6C+am5Q0JDmKo51gQX77miHpy6Zsi7ApVwsGYEoXGiYECjNwI7W/QPd2EUZ2GW6EreczPDnoDETY9eGB/2WRFCLXN1Y/PEfkkmoro7i11zlwgS6yZoOSiKMV5y9wR8WZaUy0EodfsuUQWQdCr2BG+/hZEk4trsEjkfbpndka4OSO7EHfnGam9OL+8yIngBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg1jOIHnGJBPpcL37o66qFLzpD0P64Qc0aaKn6Ccix8=;
 b=CKKMUncGw31rfVFsnOxhbfwrm7qT/tJKvGK68chfDMrlpcQSlYHaCJa5v4C8gV4tSKEIwP3Yd1r1VS3FEPl7m1C8mvVXcFnq3jJfMsLMXHKGzzOXWSLvoTxHV2gCN3u7qitM/EcI6mtgBnRk0yYZZXv8Tuwj6mYl3fymaW1VkX/Rod1kwIvZD9aniYkjqSEn7izFhe1sk1iaNLBDEYq2qz8ZWcAMscxOoa699PFgIek/3WKBkmyz+Qn62bz2CdLZ5mZPqLis+zSRdwmbxhPsxkEvnZnm/gf1E9mN9kZJW+4i6fjdYiDxuZVLsSi3ofKUo8cU8n1gaLYoSVhYAZ7CZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg1jOIHnGJBPpcL37o66qFLzpD0P64Qc0aaKn6Ccix8=;
 b=PPgqA39hiIOcg29GB42Mkd+YDh7WPzeEvl079C+dGqAG/yd46orjS1EzuvuORRsdcSlcRTRmtwz3YbZk3H2fTSrk1If/2bdV4LJwFWTcvsejwl8K1xLso92iXsGKfi60ChpoZz1pZknUiM/mDES6pvM36R9quyfzYNL0VZJTQSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:27 +0000
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
Subject: [PATCH v8 net-next 02/12] net: add hwtstamping helpers for stackable net devices
Date:   Mon, 17 Jul 2023 18:26:59 +0300
Message-Id: <20230717152709.574773-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 152cfac5-63eb-4296-9a37-08db86da53e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBajpWVH52AkleSFmYQ/L7VKC/drm7qEms8GyBN5ESXKrcPRAZsMzo35xjJBJNaxtRtCHMI2WLpAkmO+rt5hZcOweqsRm7yanDMfwS6S5MFpVe+yEnA6d2YMEz/EDzAVPHLnWSeQmqetP4Imr3wTJaHI9tzaGzdDe00uTBdp/2obLJX7AhMOqmTaGRVIfrHb3IoGs08vGFFF0Wkt6XbGc43Bcon00fC8HYGEhRz2u3BcWmG9E9CZKSX/n9YW+ySo2A9SEO76JDsJj6wG6H5Q+W+NgshPMgTI4hkOJmExcsAr9LMM3EwyF9E5ly2FgeeyzCA26OLjlGudXyo+f93uRDbmxdt5CZ3DPJ4Nq11de6cJ6ljswZwCgtOWFQiny8DwPCRfNwVYByFpeGeoPHRu8EjYThNwCCTlPhmT92/aWG5tKBzSo3TcnoUoBW3DRBMYg8A/cNzu78maVSIfpZ0z/EFcYYuU0ya7a6GIK5VS55vNbTKPTUU4aedjhDBMh4biJFwKGCaJWu2mHceGz2LUfbycCFKPS7XvkCdXMoRl+9GAjSduS3wa8Udcw+2+5f6il91n6Qd8Ol42LI7gRAFn8CqWkPiZJTIP4BE2dCS+ee+CpoTfRAVjgpfwSufM28xV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTQsUsF2OPax+fTpsmH3OhwC7iKeamqtyuGy9Ixtro6C1u66m6ODa5Hkt4DS?=
 =?us-ascii?Q?D4rZaAvbA9ZcxvIR90/gFvM/7oNKjsW1aDmLTkAv8zeOcvzR/IjyW+yHAxML?=
 =?us-ascii?Q?BUZgv01Pz/E1wHpWv4HLQWvNJOK8ao/MWnyVbMG1MFGG/r4IM7YpK/jQfEG8?=
 =?us-ascii?Q?BJhDV6l1s3dHNsmiopwvAyoWf5epa5tkLrIoJmDkAR6zj0SW1CGvJecxI+Lw?=
 =?us-ascii?Q?5fZhz4xx3zIrUmYHAf6e2uWzgW+9V3RKlDdli9JLWxezck/WER0Z2bWoOglS?=
 =?us-ascii?Q?OXGvWfJWBEtsbJ7EiPHpXJuvJIZz8a+1SeafDfMz+2C11Xgt7jwK0dP0OK+W?=
 =?us-ascii?Q?JJ8+cXOnlvPbY1B28uzFGoXLWKKqLCTgUsBN4ZfP9kN1J8fABpRylLX4FSw7?=
 =?us-ascii?Q?8xxJPr73VPMd4tMtOZEKccY143aFfpv9uBvhmcaHGnaFggo6JMl8nSpQa+Xl?=
 =?us-ascii?Q?vXPxEw3Vsv8zReXAgN8uiyCKQFx3jGCkQcl+w7jltuUB8GMHYNPfH8RFZ4IK?=
 =?us-ascii?Q?XMH4WiIPS38Vm7X0S3WPEQl9Vlxnd9ZiPDJs7uVpiLq0GITSgr8HyaKP0peL?=
 =?us-ascii?Q?eVuRtUERFxpaqfoBdnmxw/Ifm3YZB79ADtaPO5pZkwT82kfn0N2yrqJBnkjl?=
 =?us-ascii?Q?DTPf2hGZsdmIO0VTZc3jeLCZFccZbXAbOyT+FRebcRX3W1UyTBDPuxOQmByA?=
 =?us-ascii?Q?Z/VsvN1kguJRMPI8jM+SOgGC8kjrHXi0yGx9OHJoSTpZP/T/aIQuQPvQMXLP?=
 =?us-ascii?Q?wQ7SbH33Yk2mXe6jLPihYNzwOFUVvtwTR70yqPXNYrvIZay75JDFP8LtHm0N?=
 =?us-ascii?Q?rMY1QSCaKF/rL7yDyATvH/4roGKHi+XM2/+RBUZGIHwHii9vKNCjnK+KIqzj?=
 =?us-ascii?Q?HsVVAFsC666eL2si7Ih7zdBBMo6ki4dLQW2bnnOlHJxL/ULljKrXLsBtPa9X?=
 =?us-ascii?Q?52PoN2DErbznrzeBPKwUCNMGbBEad6x2B4Bl24PQYkSDPI+f3C4jXbxNY5b2?=
 =?us-ascii?Q?btiNyDYIVMmyf2YsEn1H6lCmt17mSn0h3ge3T0xvglIOce+HyEYpk3oFiKF6?=
 =?us-ascii?Q?G2x4x1G9Yme7Zv0/B+voYejy9xy94z9Zu0yiOvNozbPf0KBwGG/0Ew/L1WC0?=
 =?us-ascii?Q?sGcw4+UslRIKdpj6L5FbE3NVTxIyKQAMyBPYb0cFahV2HLwXIKu2KGIGGEt9?=
 =?us-ascii?Q?Psdbdv2Svjy2c4+vaD832gQUr1N9FvaSKmwCnjwGpzZDc5A6Feyvsw6Wt4Jm?=
 =?us-ascii?Q?lEE7wGw1Fs+keQVQ6BZSjhNHMOk6FVGSgOIlHgN13ZQm0JXH0wyISNx5iZJu?=
 =?us-ascii?Q?3DLIys2kEen3xX4FW+NgJ9vdxlDjAIGN+ZTh49Xnuisb404bQ3+OdroOfubC?=
 =?us-ascii?Q?NHyrdrLUqGr/Vt8/YTqgdPCsaKPI2+ofyzlRaBD/s9ogzzb29qt5w+NWM1UI?=
 =?us-ascii?Q?kj9zeUtDqWZGs+KAcTK1SY/6Hpvzqm0x3y8xBmYw1FybqK4XWMWU7xKGtsLM?=
 =?us-ascii?Q?M5QwoQis1WP2sJFIGO6aYDwJpDRpyZ+AienV3zweDoNao0SSnUlyIH518Nty?=
 =?us-ascii?Q?H5I9f5xCNnFcL8sxQFNdZvbsFAtDc41Gtq9j3HkWPRpuPLpLnje+3/S4lPPY?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152cfac5-63eb-4296-9a37-08db86da53e7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:27.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHKLlL+bpwufBmaZ4Nty+DpyKgBeQw+nVoUAbjbdo+oP+s0dTCZtivHG2goNc50+I6ibM6n5zuLv8pDxfgFi9g==
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
Changes in v8:
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

