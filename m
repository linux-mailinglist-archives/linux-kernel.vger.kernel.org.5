Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439676B76E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjHAOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjHAO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEE1FC6;
        Tue,  1 Aug 2023 07:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyzobIVCKnnQ95mvig8IAi8clxe6DGhPaZuvC8aAtk/BTRa3LU46+3s517Mhzbd+5h6kY2VF3MYjQUf55f43NfV5sp8sDykOJicFJi7Xypf/fF78BhZk+tanJPCy00FUyT6AmpAatKgECq3FTVWessPIDGUKCentwVuZW0RyDFOOPZX/D9D4OlDCz2we5YGr9qMl9AL0v5jtza/3vGRSNAeMrDcy7pyC8XS9BgbMlVmDdvvZkrG6JFJjO23dCMELYBGFmWQpOaWSZEqcQbrz5vFdgzkOH1BUHDSF6EWlzjtnoAw08oAgioK8fRUsMTCCTB4n5gcXwyU17CrD2HdV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQYBURbKkUTmPrffjHkBTq0TVFR/uh+Uniw/AliMY9E=;
 b=fAlqySElJdb4pNpqoCXDDoYpTI5B+Svx+lMPwEsp5O6KQ4KONH84JOXtoPPmr9GWBP/+SY1attor4PVnjffpi/d7/5WeInUUXigZfQo6EtrWgM1sEMdU2jgvHEMC23p7/YXfskhZhcscv/wQX1xrSQYS/UkqZjDYYd4vD/IMvzk3ty6tkHjORo7QMGRH6N+r0QHFCIdfjlRVgamWxIiztfXLkJE8OmYzsrlQCdgKs4P5KolLFpxjGXRR3cET9I1EsLZY/ZYSqldo8KlhawGleFSST/uSXr9kOme/xEo0T3gk+cRQ7j5J2n7KkDAvUscoVDYcCe8GHPQmciB9vuU/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQYBURbKkUTmPrffjHkBTq0TVFR/uh+Uniw/AliMY9E=;
 b=hq3KZJyBhZEPl5WcCzl0bXhGAPOB9PITY/UD2hMCoCB3jhIPYJbvp2PmJTCoppXwfrIaHkbxlZYa7IeDTdS27V8W5XkxTgMxr1Zsb8RDUs1ECX8B4qSPzIkQsyPE930EgxNa0jnecASj63JlPGTahkRBeF05zgjTrLNV1ht+F1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:32 +0000
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
Subject: [PATCH v9 net-next 05/12] net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:17 +0300
Message-Id: <20230801142824.1772134-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad8f43fa-8c9f-4d58-15e8-08db929bb8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzQUH5OfzBPLG/abrA05IwGx43r8yTc3chsrVF3yfGOLNJ3UT/aevJ/6rr49f39fqQTJRcvgM3IdZ96NIGNiUekRj6dCPEnZyui6cx0XnNK6jxiT8t4Oiuw9WtNfS6l5lD5dcIsy/vAH+8irqAr3BBIWht2dgZ56SyGppKDOUDLZ60cPhHMlAa9Re23A4Wk/7b0Q6A5aAb6pZOqwad538lKzTlQ5Rc18+n+wO332vHyKY1etO7rswHs0/5v2qgIsdsgvX4HZqjoiyb1FhS2Fh2TZswU1BT7TqylRMBLCAC4FxUr7y9G9ulnXmMkPLKdQqqTWBPntEfAlwAA7dRYS3osHtLycc/QipeHvOTWgOZRYDkEtsFlI0QXJR7XU8apHDV4XZfPQrBct07AiLyBjsyYYXg0JNxaT3S7ohxc4nOF+mSfSAbsuVdOXYsnw1XsUGO1ig9CJQKRE1FlgJxnR+ACH6oKtlVi3D7wMzmRPT5f0kX5uhiw178AoCudvfwSavPkq+AHVcLg6sj7fSqDPmoJnjReou+C6ESFLrHtDiHhjekRD0sdMgmTqZ1HJxQw0j7fo+qWrZ0JJEpcfe0P9CVipaaJKI17oCvKQAnSDhDNKwl9HEwQx/0vJfQYWjrV5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ht3CvT0P1mtOTRej/7LMRMbNvdh2LGFK7PFqxT1yQYSBCqbxgQ/Wx3AuQ9qb?=
 =?us-ascii?Q?yKgc5UxII3CyiU+e7T1TyRmZ9nWZ7VCZp/0sorJju5OLh01QAWP+NIGCJ2Bt?=
 =?us-ascii?Q?E5UHtBvlxJNzfkVJG8LTY7bIG8hysppEp3p8+7XqOSoKHlnxaqM8FicCsz6z?=
 =?us-ascii?Q?ek9NQjwZG10QJ2mrqSC892cuIvgkC1fWEF9GgLtA6rqKnWtSb8jH3I/EjqGn?=
 =?us-ascii?Q?vTohUobI2p2U9Kzx4mTl+1Mx138Q2U5G+HVNNL/c80NNek+jfYoYhfor7x1b?=
 =?us-ascii?Q?9MQC+lVzPUC+8VtFoYoHr0iK5lR8DiEAEMuqqu7+v5q/ZK5+4o/BlfDi6znJ?=
 =?us-ascii?Q?VpEcFSYBG2yaL0BaQt9sUJFEyEBdAkxH1TaKg5aoijQRaOyCG/MEE2PghZIC?=
 =?us-ascii?Q?w/xslQRFP475X78aCyULrLQuqTjQQdr76bxdYC4KFBgdk9YaaKhD/1KJipkA?=
 =?us-ascii?Q?EGZm+aq1UwI/q7XKMyfgWq1vxJGXr0//uPCnUXW2O0JhF+zHCDsHKyvfcc4g?=
 =?us-ascii?Q?htXcAN2iRikddckF/5lmPsz/6TyLSXsEVb/KSz6M/vEvjMtvlT2US0rUENIl?=
 =?us-ascii?Q?uJllwCm7rdNgM6bZA+mQlpP2t+ccb3sV0b5KENz0eOcfPClLxTnT5TDly+U+?=
 =?us-ascii?Q?xlt7I4muVpaRllAKC7iXYqtUxVCS8pPi1uHahH+NMEhwjROGxjHfzlOnlUQy?=
 =?us-ascii?Q?9BOIfOcaUQn12MlfAEhXFPiYxFGEO4QL0TVd8qBm0t1FUUAWhleqr9iJBfn9?=
 =?us-ascii?Q?V50ltoeDUHWOnaMsmpxPOokNi7v/DpEwjORwCgfig5T+KVzJZF1W3c0xIrS7?=
 =?us-ascii?Q?qBxQrj3qFIcksOXG5WAD3anmm+tOrtSpNafnbwXjg8hGnVMNe96FAZhFcVGH?=
 =?us-ascii?Q?x9FpYLVlgrEsJzlC5LMk226qxu1bQzf0LWlyAPQloH+PXVEMKnJ7Trw6WA/K?=
 =?us-ascii?Q?iypl0DrdORHBB8kXwxZ3ly924pS4MH14M6xswK/GcY0GAogNU3sec5ze4Qfg?=
 =?us-ascii?Q?qXibxZ9oI04VLQ5Xn41qJM/x99NGtOo/fgre0si3b2nWqzg2vDaGWA1dPj69?=
 =?us-ascii?Q?YYs1oXqhNF/rqvGiL3hkCPUyNIOIqs+Goc0XcadCOcwSVEDxZhrvsV4Fqq7X?=
 =?us-ascii?Q?Xv9kOir/w7atg6srOl4KIJKUhbyoAOckSnRlSu00xKORAy8muL5T8y8bMzp6?=
 =?us-ascii?Q?UzJHTKRUsr76bZ3Gf6yk9yETwSw1uSSJEN0arnMX1vHJhI0UL1T0Gs/A9xjp?=
 =?us-ascii?Q?SuC31NLBt5FGK9Rvct72vLnOjENrszsUhrsasd5rY9g5wlPc/7iVUiCuoZIS?=
 =?us-ascii?Q?nYyvjZ9OhKKF8dIklzKhDF7uLipmwysnZZ4v5lIItjo7rkaB+r4nH7zqNpwE?=
 =?us-ascii?Q?PCr+eoyCV7BCWxB1sAPjxsqJv3niS7viQSZJnwv4VHd5XDKYLNTBPAoJOCcJ?=
 =?us-ascii?Q?5qHFS4AHCuAXDe4KGWqVjpRoY6dtuqs7iuap2V4mzLUO+Y38sxaZG6VGGKTh?=
 =?us-ascii?Q?zl1pMVNJlDvTNZhNaEFeiq6rtihG6GcMcd8OS/Zq8yM/d2WcTeOYIOYJ1vI/?=
 =?us-ascii?Q?O+x3L+zFiF42pfCQzOcmVBsmRbXKPQHhcxEbpfByULgTrt92GGg6nbw6/9iJ?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8f43fa-8c9f-4d58-15e8-08db929bb8a9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:32.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJlzzGX76KyWHbETi8opeqX963bKptAI2++YaOPJY+9MG4i/kqSj9H49WZPWZE916yK0K62ajo2dnW9VsJFzFw==
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

bonding is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in bonding by using the newly introduced helpers
for timestamping through lower devices, that handle both the new and the
old driver API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8-v9:
- None.
Changes in v7:
- Use copied_to_user instead of KERNEL_HWTSTAMP_FLAG_IFR_RESULT
- Reword commit message
Changes in v6:
- Patch title was updated. No code changes.

 drivers/net/bonding/bond_main.c | 105 ++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 484c9e3e5e82..f04d4f28eb1a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4446,11 +4446,6 @@ static int bond_eth_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cm
 {
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct mii_ioctl_data *mii = NULL;
-	const struct net_device_ops *ops;
-	struct net_device *real_dev;
-	struct hwtstamp_config cfg;
-	struct ifreq ifrr;
-	int res = 0;
 
 	netdev_dbg(bond_dev, "bond_eth_ioctl: cmd=%d\n", cmd);
 
@@ -4477,44 +4472,11 @@ static int bond_eth_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cm
 		}
 
 		break;
-	case SIOCSHWTSTAMP:
-		if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-			return -EFAULT;
-
-		if (!(cfg.flags & HWTSTAMP_FLAG_BONDED_PHC_INDEX))
-			return -EOPNOTSUPP;
-
-		fallthrough;
-	case SIOCGHWTSTAMP:
-		real_dev = bond_option_active_slave_get_rcu(bond);
-		if (!real_dev)
-			return -EOPNOTSUPP;
-
-		strscpy_pad(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
-		ifrr.ifr_ifru = ifr->ifr_ifru;
-
-		ops = real_dev->netdev_ops;
-		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl) {
-			res = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
-			if (res)
-				return res;
-
-			ifr->ifr_ifru = ifrr.ifr_ifru;
-			if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-				return -EFAULT;
-
-			/* Set the BOND_PHC_INDEX flag to notify user space */
-			cfg.flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
-
-			return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ?
-				-EFAULT : 0;
-		}
-		fallthrough;
 	default:
-		res = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
-	return res;
+	return 0;
 }
 
 static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd)
@@ -5688,6 +5650,67 @@ static u32 bond_mode_bcast_speed(struct slave *slave, u32 speed)
 	return speed;
 }
 
+/* Set the BOND_PHC_INDEX flag to notify user space */
+static int bond_set_phc_index_flag(struct kernel_hwtstamp_config *kernel_cfg)
+{
+	struct ifreq *ifr = kernel_cfg->ifr;
+	struct hwtstamp_config cfg;
+
+	if (kernel_cfg->copied_to_user) {
+		/* Lower device has a legacy implementation */
+		if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
+			return -EFAULT;
+
+		cfg.flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
+		if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+			return -EFAULT;
+	} else {
+		kernel_cfg->flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
+	}
+
+	return 0;
+}
+
+static int bond_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *real_dev;
+	int err;
+
+	real_dev = bond_option_active_slave_get_rcu(bond);
+	if (!real_dev)
+		return -EOPNOTSUPP;
+
+	err = generic_hwtstamp_get_lower(real_dev, cfg);
+	if (err)
+		return err;
+
+	return bond_set_phc_index_flag(cfg);
+}
+
+static int bond_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *real_dev;
+	int err;
+
+	if (!(cfg->flags & HWTSTAMP_FLAG_BONDED_PHC_INDEX))
+		return -EOPNOTSUPP;
+
+	real_dev = bond_option_active_slave_get_rcu(bond);
+	if (!real_dev)
+		return -EOPNOTSUPP;
+
+	err = generic_hwtstamp_set_lower(real_dev, cfg, extack);
+	if (err)
+		return err;
+
+	return bond_set_phc_index_flag(cfg);
+}
+
 static int bond_ethtool_get_link_ksettings(struct net_device *bond_dev,
 					   struct ethtool_link_ksettings *cmd)
 {
@@ -5836,6 +5859,8 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_bpf		= bond_xdp,
 	.ndo_xdp_xmit           = bond_xdp_xmit,
 	.ndo_xdp_get_xmit_slave = bond_xdp_get_xmit_slave,
+	.ndo_hwtstamp_get	= bond_hwtstamp_get,
+	.ndo_hwtstamp_set	= bond_hwtstamp_set,
 };
 
 static const struct device_type bond_type = {
-- 
2.34.1

