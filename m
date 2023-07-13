Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8D75211B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjGMMUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjGMMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777C268F;
        Thu, 13 Jul 2023 05:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaHIim9c2u45E9sCEN3TIbMLqSONX/ZNgKx1g6ZC851wsIvlHBOHj+EpvF0kYfkNtsFC9LwUy7wqIYcSUakLjF1oK1Z+qRc7Ih8wnTETUbWefOq4TG3IikSKN5TE3MjEyy06wl6cyM/WtdnKeeKdud0n8JwHLKBHh7rauaAOenvKWMZHLY2GsPjp8dh5effJ5EtLBHCP32JDlZTMiaqjoPHvXffIVhuk3HxfC4jvwnAktPhyHQ3TJYdRHAxvi6FCdrQ2LxUwbfhXxr0ASIWP8dY11Afflnsru6jLOyFrWiJNufC78h+ceHj04RxvLzQuiFl4Fu30WQgDbJ+OGAm9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzv1QQHSPaR13TxtFe64iUOelDgDCSZdcFx+VbkWXy8=;
 b=LrTWS4WMz9RQjKchYpGV40YHmBzZktGbWaOuaFm7kqrzCQweXO+NfmXh3rGkeaECWgxRGEvX0JUfD6cXnF02wv9mYRtOwcQYj2HJ562Gw7W2IXRV5tYXIPNn22UPEdL4BtDlvS1nose/uoiUqE9ONabFgtgM3q9+oBgWgLAPRub2OoUnkeAf/XDW89inBoJbCeDOVCwkBqRKf7NKwihaxOWV3pXDVxhoPrbn/exsIRAYx56qSG0mNhgpj6CVwNdcktPqYDoOwRDsMLLtE4LBAdHMcpRGEyJa3ZsFGfcn1yWlLG3o70motwES2oLodAC1ydpktgWh3yB3wZ++wbqaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzv1QQHSPaR13TxtFe64iUOelDgDCSZdcFx+VbkWXy8=;
 b=gUN1vDTtha8D56YCWmFx6Sv7nTiVTOjuepqhi/IZ6Ra5fClIIL0VIcosbx968J6vFSgf2F6WDv25XAEfM+4H3cPM/+YV+vf2HSjmJOOWCwH7DeGLW9YnuyMzJkS8ffyHr2A5IuljutSPoFswP5vBUJ15iQ0bgheSOOZm0N7oieQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:36 +0000
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
Subject: [PATCH v7 net-next 04/10] net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:01 +0300
Message-Id: <20230713121907.3249291-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8fd8661-c4b2-4af1-7f41-08db839b6c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2HuRdMb50bnRi/KabfCibyoBdfeLRxU55QlDeV1tD4Yg+IozNzfCp0UfBtCdsZWZNy1cqy7XdZC3OmQROuv8sfxynGAuJDg3RUSc9vaCvDGxDJJZYvDPaYrJ9axlLGPjuSuq3F3lSFfMsdglj/WTyHw13WtzL0Wf/RiNTE07DZHgZjhc3fv1lFiTUOTDDP7TRCqtBaUn6k+JndQmNaTYF4KFZJdg95E0ikjlYF5sG2eVaLZH6NyXyTLormrfeAutVjjgrENzM37mbd/fFc32srflJrrXMz7Cfg+AK8A+fa4XQkcuSXLDgyNKbc0K1uxRVp3BHHD6A0p95P8eJ5AMFNHFq0aCDJ84p1DaUn0gh+WwCrq8fNe1XyXY8Y/H6+rOgqbqzlEqPNQyoUhUe0O2T741vOtIOy+JUGMdYhA2Yzl0oAuXhNNF+DBtnf/HMTAY0vdQGM4Fph3/L1Jg/TtqGKgfvVKFFVIjKL4F7pq6v7wGcfIVynnlETW8cqqJOfw8DCMdeWJM6Z+BaiffQjgx/JHz5rw5EO+u0OFv6RmHKKTs7Arn5sgyrdSrAlCnKmv+Pto9f9ixZ2RFppdPeqTrxpGH3YiH22Ea0LIBf+T1qlXspDCxI1DWF1onpony5BD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbY2+gdIQ79670ZxEgF2QxFDJSJYyrSAE1QKpOv3e8Ew27EYefAYzFNumeOS?=
 =?us-ascii?Q?Fw0AtnNPUqYqh35R8DdIW3eBnJLCgtiynQ744DVKgQG0visBJEe9+wj6S4uG?=
 =?us-ascii?Q?f76pQ86Y10wAITcHrvyGReCoOOZy5KuRBSIWjy6bpiyEZohUBnj2oA3tOvF0?=
 =?us-ascii?Q?8RmiJa30B+LfRODRTygzBd/ABkFVHISoJ9kKBoo90UeJkGijr/SmbYRZzoWR?=
 =?us-ascii?Q?Dr89vSEvX3zfFehBlPUNqI+7Ea0cCLfxuDFx3Gwbef8TSls0ScLtj+5f6tnu?=
 =?us-ascii?Q?5W2CpKdDJm5+2lthqnJx7mzur9w0OmpYoQX4nLdtxLwhS1HGw0ztTQ3NhA8o?=
 =?us-ascii?Q?BHkkLG81b7HSbQwqn3cIWuvS2vP77Itsayc8N+Tn6VPXbqF4l1HrRodFHsGV?=
 =?us-ascii?Q?6RCJ3p59Viv+Aj2X3uokDDAvfMzgSrpPpnLTys/QSMKpiwDJ9JnmQVy4H6k5?=
 =?us-ascii?Q?uDbHaGxncWvXjP5esq2jRq2Eaip6Ba/tY2/t2KtJJQvJrduwIwVfQLfATs67?=
 =?us-ascii?Q?t1FSAo8/pLNdkbxL0o6pOPlF/SjxmKy145JitBYVjs4rcDzWxlk6YIjT2xAf?=
 =?us-ascii?Q?MdXfWnmgyYcOyid8c+JKmwbSLQMIp9K/ICCP/ufth4/aU/MQ/vwPC6EVr0nX?=
 =?us-ascii?Q?3trGreDa27bTycRCin18U0gsknUBmckulcT5pe0WHBDXWNMDtu6CP73rFOXO?=
 =?us-ascii?Q?lqPg80058wxaB31cFfvE7qIS8PY1VLg2toPDr1m9sh5KRBwWhY/YKWmhWkKs?=
 =?us-ascii?Q?hlAGlqAstYO1KuvdTJ35TOEVwYQGe5+eQqAUTnVxQiz8AIPpAJFiNxnKtueK?=
 =?us-ascii?Q?Cg8pYnzH/E0NEcuuxCMkmu1K9Mhe7XbTzUn1Dgcg9IBkon0LMH+MQ70CWCAp?=
 =?us-ascii?Q?A1eXBU7FdxVtC909mP/DWwjWXoreBejBnGwWk6OzrNKXcA72fvYOSrl1FkHv?=
 =?us-ascii?Q?B22FlSD6IAwBfBrJaM5HlwVrpAMk7ijvD1JfRIaoo351D1VpaLQO6AGdGsTg?=
 =?us-ascii?Q?MzwomLDmJ0RPlUAd2quM4PkAlxwcXctOF56T8Z2sUo6+7JecOM6FvIinWR4H?=
 =?us-ascii?Q?7YK+OYEL01XKHQuLL8sh8Vn1aH8FLvaEhKsTiIp4w6zUJEd65fOgVgnGEmln?=
 =?us-ascii?Q?yyVVvwR1qeHhliqYgewSZTWvXskqXyvQdA+irpo9O/17cQGmLGw7GQqClWoY?=
 =?us-ascii?Q?6s0oGcrKra7F95wO2YMF3MjfXt/geM0W+71ujXvvRCGTCaxpXoYBzXUX4Peg?=
 =?us-ascii?Q?Frz3bJq1QTNXxX3xXHS7PtFZH8aY2yJY081xOgWuBJrqaoML0E30Dyl1JGPK?=
 =?us-ascii?Q?ncnqap3q1m7O1FLalda0i7coPx1KKO6Q5e4Ch84Kb8oNAYVdHqrqYkQj0WrN?=
 =?us-ascii?Q?GJzJhe5hXcrorQkWh3mufcWVTtGhDAmNtEgMTGMfXieAilFcwnXIYJEtk8FF?=
 =?us-ascii?Q?iJAle1huMJgeODfqeMm5Ylv/diFdRGgEEGTVV2pePotZxPAA7l3LsWTfyL2l?=
 =?us-ascii?Q?FpcQqUbbNovE5Wd66r4S7zCIbGSYmevnSgvyqFSks+mRFNXA0Xa1lCPFArTW?=
 =?us-ascii?Q?0DzJLx3/Q9u2YuqgXPcyx2V5M7f+tLB968xOJGMdcPHv/pIsLue5pT0betYh?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fd8661-c4b2-4af1-7f41-08db839b6c71
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:36.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIekbsl4WnA1+1d3HKh5Ik9s4hTwhrXN9GbOnZu+2PSBksmQmKyty1CO9spUgmVUhCujYpE9aRa1GjP04bwnqg==
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

macvlan is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in macvlan by using the newly introduced helpers
for timestamping through lower devices, that handle both the new and the
old driver API.

macvlan only implements ndo_eth_ioctl() for these 2 operations, so
delete that method.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
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

 drivers/net/macvlan.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4a53debf9d7c..01acb57aa40c 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -868,31 +868,24 @@ static int macvlan_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static int macvlan_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int macvlan_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *cfg)
 {
 	struct net_device *real_dev = macvlan_dev_real_dev(dev);
-	const struct net_device_ops *ops = real_dev->netdev_ops;
-	struct ifreq ifrr;
-	int err = -EOPNOTSUPP;
 
-	strscpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
-	ifrr.ifr_ifru = ifr->ifr_ifru;
+	return generic_hwtstamp_get_lower(real_dev, cfg);
+}
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
-			break;
-		fallthrough;
-	case SIOCGHWTSTAMP:
-		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl)
-			err = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
-		break;
-	}
+static int macvlan_hwtstamp_set(struct net_device *dev,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev = macvlan_dev_real_dev(dev);
 
-	if (!err)
-		ifr->ifr_ifru = ifrr.ifr_ifru;
+	if (!net_eq(dev_net(dev), &init_net))
+		return -EOPNOTSUPP;
 
-	return err;
+	return generic_hwtstamp_set_lower(real_dev, cfg, extack);
 }
 
 /*
@@ -1193,7 +1186,6 @@ static const struct net_device_ops macvlan_netdev_ops = {
 	.ndo_stop		= macvlan_stop,
 	.ndo_start_xmit		= macvlan_start_xmit,
 	.ndo_change_mtu		= macvlan_change_mtu,
-	.ndo_eth_ioctl		= macvlan_eth_ioctl,
 	.ndo_fix_features	= macvlan_fix_features,
 	.ndo_change_rx_flags	= macvlan_change_rx_flags,
 	.ndo_set_mac_address	= macvlan_set_mac_address,
@@ -1212,6 +1204,8 @@ static const struct net_device_ops macvlan_netdev_ops = {
 #endif
 	.ndo_get_iflink		= macvlan_dev_get_iflink,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_hwtstamp_get	= macvlan_hwtstamp_get,
+	.ndo_hwtstamp_set	= macvlan_hwtstamp_set,
 };
 
 static void macvlan_dev_free(struct net_device *dev)
-- 
2.34.1

