Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF37AC268
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjIWNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjIWNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBA819E;
        Sat, 23 Sep 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX19dRYCCAvt+C31gYhl6SEeH0e8k66R0BeQTWoKL+CaRdgxNG8Dot0pBmLXpV1TeC3eDi+GnIjoexFJN0RWOL1EWpcHkmZYEGqpGds+kJB697+MYHw4vz4caWqtsQUr3L59MllAffbTzzHW+VbQMLc3MNijfUfMWxUo11JRnqKmDj/ERYYlhwx8mIJOFQXyFPZHNrOtZW5g3cBzTqnT+4wq2y/g16XCaFDbq0Mq4pI0giHIu9rVz0GAT7rPgyw5X3jza7AhIRHVcZKy236zMq3jkYXB95Y3VZm2EzaYteN2D0yR5SOkW8tjCEmGkYvodiTbvm17IGIDWzTEK4osUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGVOAf2flIf4A1Jltg+syV089a2DDSocHMXzvwBipd4=;
 b=MIjIAXE8EfCJgUhycXjzLDS/MXzO8k5lUOcPT0Ai3a9Kq6skbc1p4tWoLZedI+7/ABvxfMvUOmxFsNtFl3gxvHiJlL1cdXQqLxXlQBCAYuidj+rCG4XsTYm4j6bvh1N95GAxqjAKjxcp+IWwLv24k2cpCLEtujNpWjDdNcUXs5IdNQ0djRqfczOZICzjeM9ijUx4wR6cUNNcY/Hr1eDkFLHzD7HD67kmRQhTFAI22/CjtWaQ+nM8CmtBb1Y/0RiN30uCsSR/kmnrDvvRz5e1Zdrq4zfgg7z1qG+M7Xk/ziOLj1gKA2ZLvjPjxinnFsnCFOx351OOhRRXaijLfS5Ncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGVOAf2flIf4A1Jltg+syV089a2DDSocHMXzvwBipd4=;
 b=bzBZwSUVEU7E0WsOJKZsw9Y6RivIxT8HpeUYwReY0mhFbeTfmZPPI4g2F5ksS/d2vYYivG5Hu46M/+VetJVw/JebdEUYo9pKlDJqmKuhC3twsNtxiqDminGyHP/fuVy+86EZvigMJp5wMQrNUFiyNmx9SgzbYnQx5dRK4GbVOlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:28 +0000
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
Subject: [RFC PATCH v2 net-next 05/15] net: add 25GBase-KR-S and 25GBase-CR-S to ethtool link mode UAPI
Date:   Sat, 23 Sep 2023 16:48:54 +0300
Message-Id: <20230923134904.3627402-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: beb9c323-d5aa-413c-ffad-08dbbc3be7c8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aScDlhiZPYZZWaIqMboVwCNoi/PnzVoRpL0fQyBc1lqLuhn38r++tZv8F5F0JkWcojut6WCJii16XSKl9ojzAAGGEAZYdWktth8X7FRGr4rzrok09sjTQqSj+etEN3e3NJ2kTaM3hpzh3xWdhRXwWNNZ5MhRkWbz0kGWIG18mqESG7xLhLcB7RFX7hlQdy0AzSfC8GFDs3wbxD4U+C6xNbZEVn4bw9/QOPpji43vpUsRhotnBGw9fF5qKFn861ovXoO9mPoWgabCTnOdqeZXhyhjGN9xaxgEjiw+oz2gj1MnMJ+fk3YEUODDvizg8PoHyhTQnI7MVRxux8vj9DRZYuquhnYpVuZ6NSHovxaZQMlIse0I8ROM/kaVVZi+TE5Omat1sIZlnosMkSEcdKq1EMioTzjraWUujreoytZ05ZmqEv72DhIUAy/CtjIBCj9RhMti5Irsf9ytPfKdit0VFgZ+BAbcdjT8PnSsj824QGyAcNwSHADWcuatgolv7aDf0OzS+qIQlolL+CR+52obyb6UUox+lwiW2zTqp2oQCCUiBCrct4ktnuOkHLTQuJ+3Gp9afFSt9OVb92zSdqXqxDgMpOLgdbtMS+PuleSPi2kcgbP654SlbIO39/0hY46T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(19627235002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKAqdbXgjELMXUcx5HeY9DyqHUXLmjzZ5DMNg9+IDPomuv6e1YwkMYu3AQhf?=
 =?us-ascii?Q?1XQ8aa/b+ulWUOX8HJlDxsLZfMoOiCHjJcsCbtEaEIB4pu9X9a9cG/V6yIpU?=
 =?us-ascii?Q?CQ2RQLmHcXtAe/befk1SYQ0X28KUlSSgcXKF9O0QuUkDPBTA/FjP8zIFs0X0?=
 =?us-ascii?Q?zSVozlj00Pd8vSRRJGVKjKX9CT2ju7YM4xbyJ60zCTL5Am2BXI9aG/lGOfYr?=
 =?us-ascii?Q?tP+MGpHVT5MCEDKqk7UV84+7ebJ3WY93HN0RVWX71jUfvsUUDqkVfut064f4?=
 =?us-ascii?Q?Uv/VVF+CMGDxrmuAQDHwZWZfqZ03quzV5+CzB0fMlEEzQUEU0+XJvp2W22ey?=
 =?us-ascii?Q?JwKmp5p9pXV8X8p7+PnQDfYhzQG656cz7wa3cn/0wdUWk3s6cgU77k9N5c9g?=
 =?us-ascii?Q?SjyM6enBhbba8/ED4cDCrr4t7TImCiF7Y7fSgPClm5D58s6atu05CQFqyuPj?=
 =?us-ascii?Q?c4RG2t2KdEGbjJYN1U63QhoNOpxlZOS9P8Y+729PRYY5D+BuiiYEpVoxS9zq?=
 =?us-ascii?Q?aM5iTzQzKG8OdZywdHhsyRaVVOsT0A6pDGuQbFRQRmZxTyIXlnppKWr7cbIY?=
 =?us-ascii?Q?XXZOrC7Yug/3AlC9Im2CkfhUqPIaawbuwMefrHOXd8wT4+ySNu/4CFRkrBNZ?=
 =?us-ascii?Q?yDijXoGi6uacve8iUQYD3cnhBSG//kwtw/VK4dsOvJLolAhNnJ9NoxfoiFpv?=
 =?us-ascii?Q?wB5G79SAXehO033tkDjmY6lWDEXgu3c6B/Vc39Iqv0CcP8MsCHTqUDdUSDRH?=
 =?us-ascii?Q?P4Vhmtos8p1PcsLSmISjUmFCn84BtNft6x0mdI71amIGdEZaMbOSPXb6JU4x?=
 =?us-ascii?Q?/tkOdgORJ15qmYZw6OSh4Gee6kx32jPnO87Zo76XK6JeZ+YON34mhoOVQrv/?=
 =?us-ascii?Q?ymsj9OA41hwB6yv2iLzmJKjSNSiyYtzLJ75svh4/c4x0fl5MIOe1kUoisYlS?=
 =?us-ascii?Q?+TLychoVMyk1EHkOmwOKVDvH29GctbwSWCHczWnJVRcQ8NUDyMFfEe3bWiJe?=
 =?us-ascii?Q?cT9070Hsc83Gvu4F/8O4tR6lx2QtHEmwFdzGLPVT5H2LL06VVYLRcFg/3JNq?=
 =?us-ascii?Q?Nxsuna/OmAXr5CqSxdWmE4/cHj1L59L7hO97PHcXyWcjPK+mZsPDl6kxIDo9?=
 =?us-ascii?Q?pUh62dAyHBIGWTcpfTYyrVQUJtZ0ULk+nckoER3TBEW6MqQ2PhwHTBZr2t8r?=
 =?us-ascii?Q?neMggfiNUteEmPzAP6Etc2GCOa+EthNHZGs4mjLQ8K5KyGSKrEROdh1pP4xT?=
 =?us-ascii?Q?9YGkojFaKqU83fNv63YxM7IRKYkOn+x6721rAedg226Dzt9iBqYaUJwIz1yX?=
 =?us-ascii?Q?8xJ6EUDA1z8zF0JFWxWkRVhV83jFnHVc3mJ0fpn3q7r5/a2hD2X7Xu1B0bmH?=
 =?us-ascii?Q?AAdarvdDRWGkQEiOxI5bhCwEMYXkhAOBQUn1q79Rto/iV9AhexztAULNH+Ez?=
 =?us-ascii?Q?egeuJpGJRE0TJiH+047dHEefVt3HAOQSrbVtp+NwCjCW5utCcuAqso20kuIQ?=
 =?us-ascii?Q?j1xbHj7JIsY8A+5SKWfT7Ub3xLG5jZr+upwg+RFHwkc2e2/uBso0Hhv+DQEt?=
 =?us-ascii?Q?i1HJpiY4CQ4L+b7HSwP8/3XEJHr7I4Z8OEfkDiVbYGdqIrQYDNHeym/qnlHH?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb9c323-d5aa-413c-ffad-08dbbc3be7c8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:28.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUlkhqZ2XSs7POPSSZt2fx10qTxsAgZtjBOhFxrGYbKhGc46NaJnh6Y0DvKvXDzHYvp0t5v4cGculQDD5nAzVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some relevant quotes from IEEE 802.3-2018:

Clause 73.6.4 Technology Ability Field:

| 25GBASE-KR-S abilities are a subset of 25GBASE-KR abilities, and
| likewise 25GBASE-CR-S abilities are a subset of 25GBASE-CR abilities.
| To allow interoperation between 25GBASE-KR-S and 25GBASE-KR PHY types,
| and between 25GBASE-CR-S and 25GBASE-CR PHY types, a device that
| supports 25GBASE-KR or 25GBASE-CR should advertise both A9 and A10
| ability bits during auto-negotiation.

Definition 1.4.93 25GBASE-CR-S:

| IEEE 802.3 Physical Layer specification equivalent to 25GBASE-CR without
| support for the RS-FEC sublayer specified in Clause 108.

Definition 1.4.96 25GBASE-KR-S:

| IEEE 802.3 Physical Layer specification equivalent to 25GBASE-KR
| without support for the RS-FEC sublayer specified in Clause 108.

Because Linux already has link modes for the full 25GBase-CR and
25GBase-KR, it makes a lot more sense to increase interoperability in
the way that IEEE recommends, by being able to advertise the subsets
too.

Some of the existing drivers which could make use of this, based on
a keyword search, are:

NFP_MEDIA_25GBASE_KR_S, NFP_MEDIA_25GBASE_CR_S
HINIC_25GE_BASE_KR_S, HINIC_25GE_BASE_CR_S
ICE_PHY_TYPE_LOW_25GBASE_KR_S, ICE_PHY_TYPE_LOW_25GBASE_CR_S

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy-core.c   | 2 +-
 include/uapi/linux/ethtool.h | 2 ++
 net/ethtool/common.c         | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..5f4e2a120abb 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,7 +13,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 102,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 104,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..421eb57fb6e9 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1787,6 +1787,8 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
+	ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT	 = 102,
+	ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT	 = 103,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..2b3ddea465af 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -211,10 +211,13 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_NAME(25000, CR_S, Full),
+	__DEFINE_LINK_MODE_NAME(25000, KR_S, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
 #define __LINK_MODE_LANES_CR		1
+#define __LINK_MODE_LANES_CR_S		1
 #define __LINK_MODE_LANES_CR2		2
 #define __LINK_MODE_LANES_CR4		4
 #define __LINK_MODE_LANES_CR8		8
@@ -223,6 +226,7 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_DR4		4
 #define __LINK_MODE_LANES_DR8		8
 #define __LINK_MODE_LANES_KR		1
+#define __LINK_MODE_LANES_KR_S		1
 #define __LINK_MODE_LANES_KR2		2
 #define __LINK_MODE_LANES_KR4		4
 #define __LINK_MODE_LANES_KR8		8
@@ -374,6 +378,8 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_PARAMS(25000, CR_S, Full),
+	__DEFINE_LINK_MODE_PARAMS(25000, KR_S, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
-- 
2.34.1

