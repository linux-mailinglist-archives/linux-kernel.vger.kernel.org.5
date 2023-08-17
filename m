Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565277FA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbjHQPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbjHQPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEC92;
        Thu, 17 Aug 2023 08:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGlzW37DRm1mk31Y6u73RcN8kWtktpOwZtQV3zuog93/vNUbolrmagqTtWhYwkcnFlDpxFC5mLf0ODq3DQg10hLtz6L/mT4njAT5O7g2oeksq2MuwXFMoXHybacFld+I9okL67rE64VCpdEdc7eEWD1+oPZfvLiRGQg5XKMGNNIAjKLrfJT1oGmQaN3/PqaQmUYuaEaEJ/+/+vu3stfiNB6H9CmMDfr7QcRNGQTjnB/4D7b1dopJzoO4BVoJH/RKtXASYqfFQYlzZlqeYcfRm9srzgSWKspjvZSbHDMjZy4buWtMNjKt5iSU965SCk0XR+iQKgTkx2sOQcajIHjndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtMXMXTrvmhJf6JiAf6KWMq0iskweAUwgb17gMNT1Wo=;
 b=VdEQsVaneZPQ4Me3oZhMcj3vr8hZK90Aol+PwMXAoOk09IEk6R66hZRN6O/2uTJieGxIUhf1ByDZ8ShQnuoZoXtitj6kVKQGlLzglRWCE88EVrcNdVnZ+BUITAxDWqppEKCUaIpXXSjHpCLRqz7Yfi2Ys2vqun11tVakQKnlJeRmhPTZiGXXEt4sQVydOdP6s6K4SEpPc4PnLn1NItEoeg8Atbr5WM5COQpmJe/hOHCLKuc6I3QgTUWSGeE0GIeEvr+GTMErQG1TEQgj8DIiL0r1xLAvqpOUxwrPdQU3gdBlLDrmhPiSiHcBy2uTVwPpPTtxWXpXFywZz1WcYdHekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtMXMXTrvmhJf6JiAf6KWMq0iskweAUwgb17gMNT1Wo=;
 b=AwL6HdCZyPoFOkfDWrDNbQK5USynBY+/jQPx1jIcXiyH8omeyfDAEAE+ARNA5M0oaXTpEIKONwML8NPyefcROhMkPcnrAGy1C24dlzOpEDGpykF1ylK4F1rI2lZR0uXqZG3lQs/xctcjGDLGbCqIROp5G+57nSJfnOiWCXgxdjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:07:01 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:07:01 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH net-next 4/8] net: phy: add C73 base page helpers
Date:   Thu, 17 Aug 2023 18:06:40 +0300
Message-Id: <20230817150644.3605105-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 920dcccf-b08d-452f-d83f-08db9f339c3a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQ9XT3CNbI+1XxVx+E2Iex+ZXv7XoG+8cieweE4WWhYnY+zk5oirLryABVyVgqvhENnU4XL1Zs8FrZuy+dnAVYJKBkDBJES2wWlZlyX4smxI/U2NnTFt+V8YBIS8IPsw0toeykHOZqytx7meVPBqqPCG+o4mHLghR6NWQ8oTxbFfT6Ix6ENsdikSCwCYxM0PXFZbHDivwYdiDjrkgXwkhlSOAt8GrgsAm0fblnBy2B9cRLbsKPljQlAp4DVR922FjxiXmNnO8v3kfj6G08hZWxOSAbvdQyW+KVUZiwjpQXYnS7hgj6WsWjqhoF9M/Ohwp+lqWk5UDSYHGDPdeqwMOOxVNOaKLPt4KQ0oA9/Rb8DQt8X4kITClo0nPKwozDJPwttHMSOcm6+pfAPCtNs036StOGczmpax/Uf/jDmx056gSWTlLop9fF3lIn9RfbI/CeDk0v1cQQ9cX57qs8Xon++1KnC2Qdv5pUQmJ+pqUqLxBMexC3c17zj5zgiGsPLdItWJ8bXHWESj5uUurwrycNHNy6Zdjkr2aiRvPTe+YcnRDp7wEVYSQEDKo0+aSx4nxuZmDNyccgG9LQwM9Z7zU9H7UzR1NbRCjsRYlb6wkTCUQ/Opb1CeVAPD51A9lLxe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(19627235002)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZLuUbsvYePfYwXStt+YF2VHNKmaRAaFlNre0kPHn0/V7WlkQKFRlOxidXSV?=
 =?us-ascii?Q?fvCsjK6uPZbZYhlF1GgNsQb3T7vtc37mwRrolSt2mXopN6x8rahSCoGTx+2i?=
 =?us-ascii?Q?GhNhPTLMkGfm0pw2oLb2i77FfgWVAZDPfFeeOKDW5Ot0mLl3UdQqN3+GZaal?=
 =?us-ascii?Q?F7yrRa87CUQoIKHwtBv57z1UzPGdZ5JVvqCFRsmSfdvRx9cSHkJ6HNa2mHhR?=
 =?us-ascii?Q?rqR0nx0UYMOvmUGy+leB3OuhnNJ4on+88tm6BuBcVg+C0mJXk/9+l9ntfUJz?=
 =?us-ascii?Q?7fA1UriVcH47WsJdQlnVPvuBzep0tkaq8VJefP108gC7sAKbGcQvD3ZYauFS?=
 =?us-ascii?Q?xZQCdAmHBVv6Zh5ek/vg79kayxhvKSWixq3A0LdwyIS6LDbXw6QcY/jcSb6z?=
 =?us-ascii?Q?svoM6ofbAA0X1EbyDHbTLgrLLFkB5PMPZCKk07Pq8toTsvL9BjnhjGVAkZjp?=
 =?us-ascii?Q?wN5tt1fzwM4BetfwEr2oOOrTnHPm72R+D5hRMm9+wOW3tKcb1Wt+66JK55qw?=
 =?us-ascii?Q?/Q1Mv/5bgIjNYYl2fNiyCcwVcBatQ6CBqEljHuYRth98oylmhAoVNw1PQJXx?=
 =?us-ascii?Q?NkBt0o8WvtJrCy0SswHtoO/3xCNLOujBep2xfGrDXJC7FHgYBHUryBRflWZT?=
 =?us-ascii?Q?7UxaUOQCaqbQc558UVw2BsrkfH+q2jkGbHqDtFeNLUZOcU2L379OelMIbAEj?=
 =?us-ascii?Q?bqGKmzyxUwyFXJeByHtcJPmO0NCObowEtzcRtdzPyaJeZag221Bj2EBmhoVl?=
 =?us-ascii?Q?yK51n5q1PCn5pTl/tdc4PIx5Y9DpxPV4tFjprrLQA5q88XinciTbR/Tg5esA?=
 =?us-ascii?Q?r2Qj0qz9RXwzXZRbAHg1D9BwD9XNYpBmoT0jFK/0AxBUOdRUEkANKHNF4zFN?=
 =?us-ascii?Q?eM1sOG2QgzF6sBILHulTjXEMekB+7Pu8gKQTpzihzQ5UolBIHiDkxzmuRwL4?=
 =?us-ascii?Q?N6SY6FlF0ViodmlHJCBWxP88XPXx+1hS6kfIO0gzMwU/0M3PlCsCCu+857Nf?=
 =?us-ascii?Q?GQrBdxRNSTvZYDwTgbZXovelTs38qNTAVIe4Oj7UtWY9xd3KyjyykV3vGkyM?=
 =?us-ascii?Q?2oOcqdEZ1ck1Ql6hmS3i4eZCXljHR7oApWYcQT5o0WSqJTZqQNuABNqKDbbI?=
 =?us-ascii?Q?vdUTFmDgaPjUYNM5P+M8dbJXNCBcxeIufrsCBJ8ODg0r7Fkj2mRv/YlXHQ8l?=
 =?us-ascii?Q?k9YzDrD3SwwFJFxEvFtxg1GH8NswiwufhhkH7D5YvM6DkV5PFY82KxdY2/ap?=
 =?us-ascii?Q?URZ93SaFcotc2ZyJ3D9lAXW/w/7nSE95KspTE1lrxLRA96oi29A/Ka+UoWRY?=
 =?us-ascii?Q?HJYgEZn/h2WrMNKsBAiycCuP0K0NM95qyU0AkxtLYy3ciu7ZfRR1rOnYfnUM?=
 =?us-ascii?Q?dx/RWDl6TNWhuDp716Jgo0Q375eq6/zmU75uC7+vWH/zWpH3QB+eAQPYif4d?=
 =?us-ascii?Q?KDLg2r6SVnt87cECFyFz6ZV0bYOjciF/ebt0N6ywtavEhnxJtFxeVv/DgjaY?=
 =?us-ascii?Q?s9zySjfWAsp9cO8FrDK1RUDkeYa6uRCe8pKSIrS1IqDPpzA0FOktcJlqECr1?=
 =?us-ascii?Q?2NfjubIi8FKJ9PzYoIpP+8Ht2dsUVGriyn+7RVlJHq4HqxpA26v7kfOB9DMm?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920dcccf-b08d-452f-d83f-08db9f339c3a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:07:01.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwzkWoFgNnAB1TFSlIsGI8O8E+tsqnObNNYvMTL9AMYwU0JAdlgrv+cdnzU2e9oWdRSuxMEspkRSZX/khPAMdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEEE 802.3 clause 73 defines auto-negotiation for backplanes and copper
cable assemblies. This is a medium type (link mode) just like Ethernet
over twisted pairs (BASE-T / BASE-TX) and over two wires for automotive
(BASE-T1) for which the PHY library currently contains support.

As a minimal framework for backplane PHY drivers, introduce a set of
helpers that parse and interpret the base pages that are exchanged by
PHYs during the clause 73 negotiation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mii.c   |  34 +++++++++++++-
 include/linux/mii.h | 105 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 22680f47385d..c8a1df5d52a9 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -648,6 +648,38 @@ int generic_mii_ioctl(struct mii_if_info *mii_if,
 	return rc;
 }
 
+static const enum ethtool_link_mode_bit_indices c73_linkmodes[] = {
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	/* ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT not supported */
+	/* ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT not supported */
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	/* ETHTOOL_LINK_MODE_25000baseKRS_Full_BIT not supported */
+	/* ETHTOOL_LINK_MODE_25000baseCRS_Full_BIT not supported */
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+};
+
+int
+linkmode_c73_priority_resolution(const unsigned long *modes,
+				 enum ethtool_link_mode_bit_indices *resolved)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(c73_linkmodes); i++) {
+		if (linkmode_test_bit(c73_linkmodes[i], modes)) {
+			*resolved = c73_linkmodes[i];
+			return 0;
+		}
+	}
+
+	return -ENOPROTOOPT;
+}
+
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("MII hardware support library");
 MODULE_LICENSE("GPL");
@@ -662,4 +694,4 @@ EXPORT_SYMBOL(mii_check_link);
 EXPORT_SYMBOL(mii_check_media);
 EXPORT_SYMBOL(mii_check_gmii_support);
 EXPORT_SYMBOL(generic_mii_ioctl);
-
+EXPORT_SYMBOL(linkmode_c73_priority_resolution);
diff --git a/include/linux/mii.h b/include/linux/mii.h
index d5a959ce4877..4b141e9acd08 100644
--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -13,6 +13,36 @@
 #include <linux/linkmode.h>
 #include <uapi/linux/mii.h>
 
+/* 802.3-2018 clause 73.6 Link codeword encoding */
+#define C73_BASE_PAGE_SELECTOR(x)		((x) & GENMASK(4, 0))
+#define C73_BASE_PAGE_ECHOED_NONCE(x)		(((x) << 5) & GENMASK(9, 5))
+#define C73_BASE_PAGE_ECHOED_NONCE_X(x)		(((x) & GENMASK(9, 5)) >> 5)
+#define C73_BASE_PAGE_ECHOED_NONCE_MSK		GENMASK(9, 5)
+#define C73_BASE_PAGE_PAUSE			BIT(10)
+#define C73_BASE_PAGE_ASM_DIR			BIT(11)
+#define C73_BASE_PAGE_RF			BIT(13)
+#define C73_BASE_PAGE_ACK			BIT(14)
+#define C73_BASE_PAGE_NP			BIT(15)
+#define C73_BASE_PAGE_TRANSMITTED_NONCE(x)	(((x) << 16) & GENMASK(20, 16))
+#define C73_BASE_PAGE_TRANSMITTED_NONCE_X(x)	(((x) & GENMASK(20, 16)) >> 16)
+#define C73_BASE_PAGE_TRANSMITTED_NONCE_MSK	GENMASK(20, 16)
+#define C73_BASE_PAGE_A(x)			BIT(21 + (x))
+#define C73_BASE_PAGE_TECH_ABL_1000BASEKX	C73_BASE_PAGE_A(0)
+#define C73_BASE_PAGE_TECH_ABL_10GBASEKX4	C73_BASE_PAGE_A(1)
+#define C73_BASE_PAGE_TECH_ABL_10GBASEKR	C73_BASE_PAGE_A(2)
+#define C73_BASE_PAGE_TECH_ABL_40GBASEKR4	C73_BASE_PAGE_A(3)
+#define C73_BASE_PAGE_TECH_ABL_40GBASECR4	C73_BASE_PAGE_A(4)
+#define C73_BASE_PAGE_TECH_ABL_100GBASECR10	C73_BASE_PAGE_A(5)
+#define C73_BASE_PAGE_TECH_ABL_100GBASEKP4	C73_BASE_PAGE_A(6)
+#define C73_BASE_PAGE_TECH_ABL_100GBASEKR4	C73_BASE_PAGE_A(7)
+#define C73_BASE_PAGE_TECH_ABL_100GBASECR4	C73_BASE_PAGE_A(8)
+#define C73_BASE_PAGE_TECH_ABL_25GBASEKRS	C73_BASE_PAGE_A(9)
+#define C73_BASE_PAGE_TECH_ABL_25GBASEKR	C73_BASE_PAGE_A(10)
+#define C73_BASE_PAGE_25G_RS_FEC_REQ		BIT_ULL(44)
+#define C73_BASE_PAGE_25G_BASER_FEC_REQ		BIT_ULL(45)
+#define C73_BASE_PAGE_10G_BASER_FEC_ABL		BIT_ULL(46)
+#define C73_BASE_PAGE_10G_BASER_FEC_REQ		BIT_ULL(47)
+
 struct ethtool_cmd;
 
 struct mii_if_info {
@@ -47,6 +77,10 @@ extern int generic_mii_ioctl(struct mii_if_info *mii_if,
 			     struct mii_ioctl_data *mii_data, int cmd,
 			     unsigned int *duplex_changed);
 
+extern int
+linkmode_c73_priority_resolution(const unsigned long *modes,
+				 enum ethtool_link_mode_bit_indices *resolved);
+
 
 static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
 {
@@ -506,6 +540,77 @@ static inline u16 linkmode_adv_to_mii_adv_x(const unsigned long *linkmodes,
 	return adv;
 }
 
+static inline u64 linkmode_adv_to_c73_base_page(const unsigned long *advertising)
+{
+	u64 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_1000BASEKX;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_10GBASEKX4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_10GBASEKR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_40GBASEKR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_40GBASECR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_100GBASEKR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_100GBASECR4;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+			      advertising))
+		result |= C73_BASE_PAGE_TECH_ABL_25GBASEKR;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		result |= C73_BASE_PAGE_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		result |= C73_BASE_PAGE_ASM_DIR;
+
+	return result;
+}
+
+static inline void mii_c73_mod_linkmode_lpa_t(unsigned long *advertising,
+					      u64 base_page)
+{
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_1000BASEKX);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_10GBASEKX4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_10GBASEKR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_40GBASEKR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_40GBASECR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_100GBASEKR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_100GBASECR4);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, advertising,
+			 base_page & C73_BASE_PAGE_TECH_ABL_25GBASEKR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising,
+			 base_page & C73_BASE_PAGE_PAUSE);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising,
+			 base_page & C73_BASE_PAGE_ASM_DIR);
+}
+
 /**
  * mii_advertise_flowctrl - get flow control advertisement flags
  * @cap: Flow control capabilities (FLOW_CTRL_RX, FLOW_CTRL_TX or both)
-- 
2.34.1

