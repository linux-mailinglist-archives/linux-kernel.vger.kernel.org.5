Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE46776B76C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjHAO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbjHAO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609B1712;
        Tue,  1 Aug 2023 07:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkMFAzfOXctpQclv8Rg8i2ITCrImWvZis8ndUb5CUYrk2zkdjZAyglDuOAwhHkz/mq8TgdDB5VH+rG448NQwci3oNC/2FsnCmzElBRJ4v1S2P76ACrUBsgaXMU8EgCay+eSat/wmXwibj/DItKfFNUXaM4yDTkPsaPPE9RbKJ4Dq1DpO5KCjXx3KVlas0L/xS5vC4zG6CP2VZTXwoju3cX8KXXNPug1e/30CjUz1YnF+vUihIOP21cdMF7rrKAM1iTMtuPKqfKrc9oU/Vd7C6u8+Ej40ssXNu/666eQnmFfJRCb+LkyAsep7B4x6nQwNnLOaghJCnaWwsLqXZLyArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c9L/Fs+ATK9RZ0lYPtA2VPoujgJmkcPt/5crPCivNs=;
 b=QfW6pEwm+3vX9KhiYl73k9Lr3VftjJ4aYcv98y1+djDWRmxrrHczmB1xCvfgA0iAAwJSXtr++O3d4+fhY4ULK6Ju2jlonxpn7oWe3CO8JvP5SkfMi66/ZU0mZ2uLtAkGcpyCJVpGrsnoJ7YwyG9Je13v6MSiupyEXuHSpC+omlEek5BJERHbcrBz0f9MDQjJ5C1q9vi1GC6oecwU87hEcf45iAF41jFKgl1M42Ywzk+MRkpc5lh42qpwXTdz+xEUY39si8/O+V81cgKf+4k8SYvwrwQRcYMJOrjAw07gKimSKNPYZRWIqxMwpTSEfotgE+NCyz/UIo+0DzF5J8Rk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c9L/Fs+ATK9RZ0lYPtA2VPoujgJmkcPt/5crPCivNs=;
 b=FEETcA6fVLNdAEIcA6R4rKEa4093AP9Chncfbe0T2IYSd8pxGemQl7wmynCb2K27FZTvfmUH7via9vuFfFW5ep+b07Sp58DbzuNyVy+oIobooI9Eifcuj4shxJOWlVVoYsZhLHd0KiyeFtP3ju6WfE9WG4lfnR+Rt5kaLeKV0/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:28 +0000
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
Subject: [PATCH v9 net-next 03/12] net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:15 +0300
Message-Id: <20230801142824.1772134-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfeabd0a-e6f9-4001-8818-08db929bb64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQm/qHyQro2vofnOyhRagNnMPZwWO+uQfQpMv8NqlCLOcY7nZoHxzOLtiHqCwVaWLsdBO3dDK5w+H/Oqdt/0T5GCSVr8RVbrXaAvIHGbRVxi2PFLjE+wRxzdOkkyCmMPf7v2KsKjpYnhZ0eIcMc+7DPxL9vE/17EOg9RnM0CSoBroOWBrgF9vkcWA/TXXoOG/mg0wKxxp19TxVHCVcevt7vZnMdBxD+HgoG/qAjZwQ7ls234NdNyxdko5hZDCmIaObPY6qX1y44Sd+9SX/NGOlWZWlmF/KxzOWQEN6LS5SYxEbIuvqLmJSEnKaCa/QI7klZR9NCEZ0kbvx5CAuPD5ONVsGPv9tDQHZiZ0hkoA8SCD2WAVsLwqNbSFd0/WyoLPVpyh8epHPdW0f7tVjPRtmnfZP5YE2C7gTSjrSTtG1h9rKCw//SYCa3POopTbPhK2L884f1rDxQqYKYinAG+IujuWHxqQj3b97AymH8/a3fU7J5v4EDrS/eFgvikhbS3iBHAxO8EDGVNPHnCCN59mpGprpqU8LfQbsiG4w+q6WzJ+CKEhgijSPGgApkEoRwlUahhJmyI7Qq/qxk+mmTB869ycS8XLfCqXt7Kz98BdBmfV5+oATupL+tuKUtcfZew
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewLd4ueXlPVPCSmrDhuHwopGZHe31Pn/otG+RzO6bG/PLpNy6ie5IIPmagN5?=
 =?us-ascii?Q?oOMnGcljEPaXlOe5Ga5kIoY3To5bl8oDM/dBOFuer7BI8XVwIDKErO3lyr4/?=
 =?us-ascii?Q?neo7UO6NNmb4SN97wR3tkVFPY2hg7CQm0IRRqZmZOJvp4i/7r1MjaW4WXH+b?=
 =?us-ascii?Q?gPFT4lcU8qqkxFSmaMvGc9psh14TqIUfQZ38SZA7wLU014nwrMpT2sAMThCF?=
 =?us-ascii?Q?TBH9bouwU7LHj+T7e6nRrwB34xu+kpvHWK2pIcEqlMmVrd1xRa8OgGWKkdKi?=
 =?us-ascii?Q?A9ZMsxE4YtJGxfN7WbrGNrolc9A1vJdLR6Q+tLbbHk9fAjB1uXH5glah+aHG?=
 =?us-ascii?Q?DxLTRTrh7mOsBbA2GMnFbCtXhZDqJ43AJoHNa4F49+V0Coc0oRkZQ6IDgwE0?=
 =?us-ascii?Q?RQJ659j9kpLc1E+fQSN9uLKMj98IxijajrKdmWIjCZ7aaLcKEtZzo7DBu8Xz?=
 =?us-ascii?Q?utf7uL1yNPY+8T3GOvrmLsZ+YMyGQhXTpHQUJP63bwg1PnS5PhHlj47ouF9I?=
 =?us-ascii?Q?N18ALdUfHg8Iqlr2JexRvRDze5cuZX5Y8Y8TL4pR0w1nJ7Rk73AUA/AvHFCF?=
 =?us-ascii?Q?0czFIzXxmoEmDNwplCL+kvI9ZgnePvlcpDBqH6w0KDeu49xQipvHJtJkuSAV?=
 =?us-ascii?Q?Hpo87b9qJoHNy2c/1R9/qcKMtFs6gDkVsRy83cEH+bRIEuN/R4mtXQIWPSyE?=
 =?us-ascii?Q?ltzD47wF6Z2kgZ+FiuaFPOg9eW/lC/JO6qbWAprI15yOHWVJDEr/LFw0YXps?=
 =?us-ascii?Q?vj/CKYI2H/f1/u3M2eEdhn1u6yilVz+GV9EwFK0z0tPm5pH/hyk8K558Ss8n?=
 =?us-ascii?Q?GQSsJYm5fOA3t2f7IbWckMPjRs7nuFzPO3AfEYktaQscGV19f2cfSHBCuIDD?=
 =?us-ascii?Q?w+egkBEwb0HA8EmJgQnAzXqJGRHi7sxzu30CTVmdFxDAhG1VzsfDbxFChCpE?=
 =?us-ascii?Q?MMFf2DYMY4KAKnGv9gzv9Vc8Jgr8rfrYVcYpxSrM/dKgDat+LchqEC6B605+?=
 =?us-ascii?Q?OJ39tGIQHlwCuhR5DaikARSxTjNT6C/5nPfm+nFXEK2tz9MSW3WqFWqvGOyp?=
 =?us-ascii?Q?PUjmp87Di9UGuZdoSyIM5dMIL2cxU1lp7I25VxYTLGRX2V76OQrZZ6QY6P08?=
 =?us-ascii?Q?1Zkmp2f3xCw6cC38zdrviKrqy+8Db0h1OKu+ZyecP3LSAP3jybVf2KvtQ++l?=
 =?us-ascii?Q?y+wushULT9upf8kRb7yKvCj624c7gefZ/3w0tkDl/am/kmwE+YorDVvoypV/?=
 =?us-ascii?Q?9QbTdZLZ65k3EYGWivpMK39JpBi4YrswQM6+D3tkeWPfLDtc9bluWYpF77JR?=
 =?us-ascii?Q?URAlW7sjdBUYC/Lj/CU0DWmaIRBgKfkh8nJLt+hn14dninX5NGfYc2ns6rLu?=
 =?us-ascii?Q?u+LbZc7K6wvH0B6Pw4PNF2QFCB9japHdX2WP4FwAT2qHAHqKb4zxV3i2XPqU?=
 =?us-ascii?Q?FJWlXcBdSKbQ88XHqToJg9QOLVmTD5FNISV4tEwTdJ8+OHqOZGsvxlKhqtLm?=
 =?us-ascii?Q?m26Y0er1L12FYi0+10lINSpS6mCrCIB0Os/jfbm3Lho1Zb+wD3HaO2rC53Lh?=
 =?us-ascii?Q?F+Kc+mS/HYXBju/LQS9YmkKk0Ky/g0KMXwT4INjKz7g8nEkEm8d0L/E73YQt?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeabd0a-e6f9-4001-8818-08db929bb64b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:28.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6AU7yFLOmjM2eF99jvW6u7t8yi7ccetMBHEf4aYPN6FY9WpgU64CP9HllH+Vi1icKbf/WEWlHtA2CYz/wYtRg==
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

8021q is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in the vlan driver by using the newly introduced
helpers for timestamping through lower devices, that handle both the new
and the old driver API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8-v9:
- None.
Changes in v7:
- Split vlan and macvlan to separate patches
- Reword commit message
Changes in v6:
- Patch title was updated. No code changes.
Changes in v5:
- Re-introduced the net namespace check which
  was dropped in v4.
Changes in v4:
- Moved hw timestamp get/set request processing logic
  from vlan_dev_ioctl() to .ndo_hwtstamp_get/set callbacks.
- Use the shared generic_hwtstamp_get/set_lower() functions
  to handle ndo_hwtstamp_get/set requests.
- Apply the same changes to macvlan driver.

 net/8021q/vlan_dev.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b90781b9ece6..2a7f1b15714a 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -354,6 +354,26 @@ static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 	return 0;
 }
 
+static int vlan_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+	return generic_hwtstamp_get_lower(real_dev, cfg);
+}
+
+static int vlan_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+	if (!net_eq(dev_net(dev), dev_net(real_dev)))
+		return -EOPNOTSUPP;
+
+	return generic_hwtstamp_set_lower(real_dev, cfg, extack);
+}
+
 static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
@@ -365,14 +385,9 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), dev_net(real_dev)))
-			break;
-		fallthrough;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
-	case SIOCGHWTSTAMP:
 		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl)
 			err = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
 		break;
@@ -1081,6 +1096,8 @@ static const struct net_device_ops vlan_netdev_ops = {
 	.ndo_fix_features	= vlan_dev_fix_features,
 	.ndo_get_iflink		= vlan_dev_get_iflink,
 	.ndo_fill_forward_path	= vlan_dev_fill_forward_path,
+	.ndo_hwtstamp_get	= vlan_hwtstamp_get,
+	.ndo_hwtstamp_set	= vlan_hwtstamp_set,
 };
 
 static void vlan_dev_free(struct net_device *dev)
-- 
2.34.1

