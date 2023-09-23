Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCD7AC27A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjIWNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIWNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313AB1B4;
        Sat, 23 Sep 2023 06:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOzXetMLqFyYwTtjCg9f4H+o3B33cBunQY3bich9+FHDpUuw/pFx1uCLbTF4qFMgZlmZX5OJA81X+iK0dRBTkEzMrDec12/6XYtdm+k3hQY+3+1vkWpFtxyt5sUnApJQoUYnfuknH3at+B5NZpk8EKCRxuTGv85Ph8CZtbm4jWamIXacurmfsr5tYMUguLb8421LEHhrsH6czn+5SpBkBMb0PLSf2jT6Y74NzR2If5XnM3RXKbndYGQauuwwkH9NDrCRiLcNHq8+l7QQwgMC+tTUtYzydO03GEAZkE/P/voyohkVOlF5KX/zAHWGjsbTx4Kp97Z/Bk8DwjSMxlKPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwfNxp6iQHMtoGWJzG46LEBYlY49OXWm672bXR/o/pQ=;
 b=RfMGyV5/b7VtQJuy2iho6ixAdZT/zltd2x3DMYXZRZIqE8zgykCUehG3Hf9JzghY2CKarlLt1JBRBAJaKfd1RcdnbCJIHmF6nx8pWxp2PsiK9VvnVJB7qFEx52SsEmhWc8xhATzlrme21Y7jSRp5DoQIlYK2BYF7eI78wULeVdXbMFk1m4degexj/tU8ZBpQ/nu7AKvPM5O3c+pPsLRbnWeqOWrClWlGjQAI+P39MVNSGbKNZd/aPu2S6Y1QF26wnh2ee/PdJXmdyJUn/npm/n6+LPr0YssTUe02qcLdZ0MLtc3tY8blVdempOgsXHrcwPYjJ1U9Kt/OGut6NlaH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwfNxp6iQHMtoGWJzG46LEBYlY49OXWm672bXR/o/pQ=;
 b=D2d5DhHcmgir2Hf+3Ii2DKiRta3E/zqbJ6xACOgXq/bvU/o3nOFyvmPFW5ywKdbfU9TLwstr3gMwTGBnHqm9HbYE2ZWcsVH2ELk+E/1XyvekolulHJ9TCYSGvq5irPcpwHBysuSGa2Rn0UJrVRYDyEZw+3c+WBKUBcfMo0FIMN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:31 +0000
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
Subject: [RFC PATCH v2 net-next 08/15] net: phylink: allow PCS to handle C73 autoneg for phy-mode = "internal"
Date:   Sat, 23 Sep 2023 16:48:57 +0300
Message-Id: <20230923134904.3627402-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 640f6bb4-59fb-418e-defa-08dbbc3be9f6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2objuQAL6ahXAgjAbo5CP9+QfPO3EtaB4Et5hSiI44g/KBHE4AXas5QtNWi4Ve2WQJv6NMHwrIY6yAdckn43zqOTP/vAchYy+wrxoBFoaU8c7EVE+f4i/XhEkr/inXIH3sduvXQSSvYh+UjWXufxXsuji11Iqjr9KA1UG33sIL+xH10R3UmTRjBsHOf//AbJSQNGw1zwBLzP42VsFDZtvdJTnbCkOB/3eDcMSJPRUWCFdeS/U0C1SZJjaMGAku1aQEPh3fERL6scnRfWCeBXxxrhqCVfScHcV7fcmjaFdmBnC0gQLV3yn6rIKdsucCEhefQAtFB41Yu4nxTrAZVOjRHGSTldjx9UpRv4z2PMWN905QvCJLA27/76RC5s+O/A/G/q9xnybRMX/B3ftZF1b2zxjdxOhMH+YTEld5RWWlQsRF7a5ivL0ZkXJPWjU0LzsSNFvuJyvRG0gKmDxeQ7cQNoPD6K4F3URQpGCXKNk0jqGQLopbkysOhq6VhUTk9y18efVro9wtgiYtCWc+zDJkrFWdHsAfa7PSepawdzsC8x1U87hE8JdCXMtEl75TEYX4zHhpxboaAPt2BKEmmGmhDqRyBW9m8IArXgoEYKpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(19627235002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(966005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zs3oW2vLbYvWbdsAN1X2GXLHC3lc4MKfxWjwd+SIE7pXpprfeGCszgrf7lzx?=
 =?us-ascii?Q?wQlbJfBGze3EbKaZfdrLHTvjceNFWEDLcvONsn8zYDIsvoaYhppETPtFkqoz?=
 =?us-ascii?Q?8gepixM6U3J0YCb51P5MnQevmxOySdYvNBkcFVQI/oY+doSfoHPVM+p0g+kg?=
 =?us-ascii?Q?GLjLysS3P8O1mH+KpPA82Jhbj9LeDNNGbmkCsLh+oUw5X/h4x6mY3mDMBB3Q?=
 =?us-ascii?Q?kso87OGmv8OKMacu5hxj6QosZmlO+4nXORqc6sZKKyaSCOpyaOoGbgF2Y1RG?=
 =?us-ascii?Q?qlyfMFVJrMSllraqBzJFWzNX6dJiilj7Js5u+lQLVzDJewNdA1oiubFAz6gy?=
 =?us-ascii?Q?g8ywpoKG2l+cVgmO/3JXYdbIWLgVs36uMgbINV2keaBYuY+YkGo7fnGaq8hq?=
 =?us-ascii?Q?gn52jpsvLYkJX6wiV/7I2uj/wevT2IXcSDAyC2RgXQh8z1rDgQOuNNMVk/uY?=
 =?us-ascii?Q?Dv/C3xHm8ajYh2o0d+i9aZAGBftk85XV02k4joGql7neuUHa+Y1cqC7PNe6/?=
 =?us-ascii?Q?Itr59EhJYdiE2wniqh5U6FT1zNJX7gCpexIxgmevIROXQlpMnCU2hNLDVNKx?=
 =?us-ascii?Q?liEdhzeNJzBteNEXQOXWQnzCcIHMEXzH0uoKAc53YnrmCPbGiQ0TDynJ7D7V?=
 =?us-ascii?Q?I/AgJQxFYEDlFVFp0c6fqQFIwHSQqjP2etgcZyc1pVQo0Hw62j+WyrDOMbFr?=
 =?us-ascii?Q?a5/53nJf3d9vYjUMvaR2zN9cnCNq2DJyv05jKXnPS7tWJAJ93Pzl1GJH+8/H?=
 =?us-ascii?Q?6Mqcq8N0PlleAbQmql2U8VCGSHff2lCE4cTVoGN39VZMWW5cuF/wwicLUjkj?=
 =?us-ascii?Q?fMWdSAK+4+K7ERfLTfTMZSBU7FoY2BnZPkSaiRNzGby+f8IZvNVrgjDjON1k?=
 =?us-ascii?Q?BJ6+6NnE2+/WRFeXYt8bv8aXrM2/UA2u/Xc8G+ihXT0QgKS1XkhGZCRSsI2J?=
 =?us-ascii?Q?qLktT9xLZ9Q4IZjTS3gWBBn6vobSpNDDAbrv//Q6q9EDZDZbuM+hL6dYP+ry?=
 =?us-ascii?Q?BX6CZJ9oVyHrjxnQB2Q98YCaWeMF7Ca41/R232/0+KJx6P4QzrVRLAQn47g/?=
 =?us-ascii?Q?nf3qu9pTZjsvXTNvjgZ893m1GEQheFvJw5+DCi7Th/XAnwzJcWldsCDd70OH?=
 =?us-ascii?Q?RP2TkeXyQOqmUaTWgPlb2KouA6OVm+NvjHAfzoLoifjf4QwBqbPXdWxs7PDC?=
 =?us-ascii?Q?fN7lG0dEQwlmSzNEFFTeHbfoRtrqu/fv7uXJ2K3eW7/ZC8QwKzh03OUtqbQF?=
 =?us-ascii?Q?+ADnenyJ4QMK3sy4xMKHS8zt9Vte2ZhnBNG8zrmGleOwSN6ed/h4zmIa8Pw7?=
 =?us-ascii?Q?Rao/gSNB1sHH0JQpUEnZ8sC2Wm9PoTQwq8BLHloOVctJNNWrXLgSW2LDO6RO?=
 =?us-ascii?Q?QqXptE+j6s+pQHZXWKfhjosrEBOKsafSO2ZtGEjHbFWyFmEwQwgToN+n5o5m?=
 =?us-ascii?Q?fvfDvklyAuWYplBlWkHq20r1gUUSZVFLmU0YYjw6NiFExxWzalm6g/l8hpql?=
 =?us-ascii?Q?SYx1lZR2pL5B708S7cwDNV2J/1dK4MzdSWUcEWCyhm894PkZQGyM2z6pFQKE?=
 =?us-ascii?Q?Z0Xx7y3qcfW1ExtFXVmEao0Kh9VH6vScBqY5S7O0lERtOew20qAmlp900tB2?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f6bb4-59fb-418e-defa-08dbbc3be9f6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:31.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI/QFharUd/6sjfsNL3geIeLSKebTTCpy2pXpWC/fS6s8FGJuTvozPFjZoVA1/LyTBPnCrvROnAcxbuJZrGhGw==
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

Some phylink and phylib based systems might want to operate on backplane
media types ("K" in the name), and thus, picking a phy_interface_t for
them becomes a challenge.

phy_interface_t is a description of the connection between the MAC and
the PHY, or if a MAC-side PCS is present, the connection between that
and the next link segment (which can be remote).

A MAC-side PCS is so far considered to be a PCS handling link modes with
optional C37 autoneg. But C73 autoneg (for backplanes and SFP28 modules)
is not at the same level in the OSI layering, so that existing model may
or may not apply.

(a) If we say that the PCS is MAC-side for C73 modes as well, the
    implication seems to be that the phy-mode should be one of
    PHY_INTERFACE_MODE_10GBASEKR, PHY_INTERFACE_MODE_1000BASEKX, etc.
    Similar to PHY_INTERFACE_MODE_1000BASEX which imitates the link mode
    ETHTOOL_LINK_MODE_1000baseX_Full_BIT.

(b) If we say that the PCS is not MAC-side, but rather that the
    phylink_pcs represents an entire non-phylib backplane PHY which may
    negotiate one of many link modes (like a copper phylib PHY), then
    the phy-mode should probably be one of PHY_INTERFACE_MODE_XGMII,
    XLGMII etc. Or rather, because there is no MII pinout per se and the
    backplane PHY / phylink_pcs is internal, we can also use
    PHY_INTERFACE_MODE_INTERNAL.

The trouble with (a), in my opinion, is that if we let the phy_interface_t
follow the link mode like in the case of Base-X fiber modes, we have to
consider the fact that C73 PHYs can advertise multiple link modes, so
the phy_interface_t selection will be arbitrary, and any phy_interface_t
selection will have to leave in the "supported" and "advertised" masks
of link modes all the other backplane modes. This may be hard to justify.

That is the reasoning based on which I selected this phy-mode to
describe the setup in Layerscape SoCs which have integrated backplane
autoneg support. The changes in phylink permit the managed =
"in-band-status" fwnode property to be extended for C73 autoneg, which
is then controllable through ethtool. With phy-mode = "internal" in an
in-band autoneg mode, we advertise all backplane link modes. The list is
not exhaustive and may be extended in the future.

Link: https://lore.kernel.org/netdev/ZOXlpkbcAZ4okric@shell.armlinux.org.uk/
Link: https://lore.kernel.org/netdev/ZGIkGmyL8yL1q1zp@shell.armlinux.org.uk/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 19 ++++++++++++++++++-
 include/linux/phylink.h   |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 548130d77302..88ace7e203c3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -972,6 +972,21 @@ static int phylink_parse_mode(struct phylink *pl,
 			phylink_set(pl->supported, 100000baseDR2_Full);
 			break;
 
+		case PHY_INTERFACE_MODE_INTERNAL:
+			phylink_set(pl->supported, 1000baseKX_Full);
+			phylink_set(pl->supported, 10000baseKX4_Full);
+			phylink_set(pl->supported, 10000baseKR_Full);
+			phylink_set(pl->supported, 25000baseCR_Full);
+			phylink_set(pl->supported, 25000baseKR_Full);
+			phylink_set(pl->supported, 25000baseCR_S_Full);
+			phylink_set(pl->supported, 25000baseKR_S_Full);
+			phylink_set(pl->supported, 40000baseKR4_Full);
+			phylink_set(pl->supported, 50000baseKR2_Full);
+			phylink_set(pl->supported, 50000baseKR_Full);
+			phylink_set(pl->supported, 100000baseKR4_Full);
+			phylink_set(pl->supported, 100000baseKR2_Full);
+			break;
+
 		default:
 			phylink_err(pl,
 				    "incorrect link mode %s for in-band status\n",
@@ -1109,7 +1124,9 @@ static void phylink_mac_config(struct phylink *pl,
 
 static bool phylink_pcs_handles_an(phy_interface_t iface, unsigned int mode)
 {
-	return phy_interface_mode_is_8023z(iface) && phylink_autoneg_inband(mode);
+	return (phy_interface_mode_is_8023z(iface) ||
+		iface == PHY_INTERFACE_MODE_INTERNAL) &&
+	       phylink_autoneg_inband(mode);
 }
 
 static void phylink_pcs_an_restart(struct phylink *pl)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2b886ea654bb..7e8e26001587 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -141,6 +141,7 @@ static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
 
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_INTERNAL:
 		/* 1000base-X is designed for use media-side for Fibre
 		 * connections, and thus the Autoneg bit needs to be
 		 * taken into account. We also do this for 2500base-X
-- 
2.34.1

