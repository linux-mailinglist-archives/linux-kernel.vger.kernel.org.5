Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EA7AC282
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjIWNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjIWNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17DCCD;
        Sat, 23 Sep 2023 06:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXN6sW20/KWW2Z6N/TL/cxPTap24RTwkXCYHSXNYsrhZUjNsiyVLDw47g0VzPh6WBy5ifg/RHt6psMYnXys7oXo5DTuMdQKaMMKrPCMRKgeFHKZ1CQCJMQbrsq3FKAe6/QA4VKOljcRaoYJlCiH26+5IufvxkPkseCfrOs0fGsbcUq5zYMStR8PY0NAxhhr82Y/Rig3FYbKN/vIB/NbjMHKIGBYh/rWrK8Zh0Z98F12wjtLcE7j+xMlLF/xrQ4kvLcmvgkLhjiCCtdCTppEQa97s2m7gtHMgwhHYmyPeDZs3Xiqpw1Bn6IRvSo+DwGn8jfn6WWrWHyJnEUPVH8pNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YUQpG9c5L2XJmX0f1KrxEihSueqyDJwLwUkN4nNd3I=;
 b=GGB1FAT6xXaXLbMUTptd0pcy7i9fD2VzQGHu9aCrxKWQlqagwP31dUCMKg06xO+gQmt3KDf1U38YbG6J3szeDk2hA6LQ1Ss4q1OR9Xj6moHRm4PGkfrycNbYWRxbT161Uj128y/+zeH+qB6n5/W65+zZiAGTGS6/umbuq6Z8kA/aUGfP5QdCZ9rM5dteRgSnPEBalLG3l/h3PNL0aFr0pj2Qijsvydx+7zsbFVgOypegPan1M8HSACBkaNHtzj5x1v4tprZWgpPK2LNgatuZg9yWpL4mklobNRwLPBIp59QNBGnlNbBU1x7depuu30zyObfydSZ+MjBGGvC6onExUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YUQpG9c5L2XJmX0f1KrxEihSueqyDJwLwUkN4nNd3I=;
 b=ZR5q80vIiNWs+wy82/JHJkM9wK9+Rwo8rzqfR6f1VJ72G/fwKVl7eZoMw7kDdOIJpLL8Wu1keaDxHMaNMk5ZI4Q6vv3eCEW9CTJeQQj5M+cyCSN0dmn92sRw3nAUtRcw8qZ3bdW2SbOH3z2FiS2mdA20mnpR5MJS1K0r+pDkzvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:35 +0000
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
Subject: [RFC PATCH v2 net-next 11/15] net: phylink: support the 25GBase-KR-S and 25GBase-CR-S link modes too
Date:   Sat, 23 Sep 2023 16:49:00 +0300
Message-Id: <20230923134904.3627402-12-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79fd9972-4a3a-4648-d2a7-08dbbc3bec18
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AebI+8myDC8QXg7vQ3YwSeqjZFXl7OgmhPIZy619Bts5rnaXBB6fPaWc/l7havbIZPjQi52DpPcUCAfExDo+qRr+nE7qNKO2XDz8nLCDQgmz9Zi6hHAaIuTCWm30ugf9OHIckNSRnhBaCegy7sZUgNfvuzRtTyjEVWVsoBxiKMQXIza3KykVA+DOIogoECd0ZnWGXKAM3japMZt60pRSmaZwDrGYePXEgPSdee5g7qkA+/AlThb2UrOzOgNYrfVAF5g69fGPvPVF1crazRP48nundJvpBpvibmL6t8kGtN+HOvRJ5R/Rz7dG5iC43vQe1boPXeW8EGWPCruA5+59uIZjIXZq3pbP3ZrOYvnqDUOKzGD/a2qnznvDSw2pLYcxegmCleA35mGWsh+3b6foX2nIW9W1tLnMeV9mLA5Zy7apsggzxjDe6h52hZqW8gCFuJW8mumH2EzaDOu4buHzKyBgTtjzJDUj8oMNOnxPZkWQMS8u2tJVY4NpLcAWwlrHMS7YY4SZthhhftSXfkWG2yRUnE2+1Jxo4iGxsjj6ZBTGZLHD2wbjagDtI2o3S2HQLpQWIXXyeGhtCwvVOPy2v0Z5cN2Uuv7Mdenl6zA4hRiR1HGBI+tJtG3r6/pWOYEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfM9zlXt3q1Xm3Zm7RT0h1Rf6viYdnjbpq1vqSuMSQBOU5MJ7Trhhn5mgER1?=
 =?us-ascii?Q?NaCt9kah9tvNNlL3E2MMSJDl8eVAP4zR2MIVZpgsFM0n56a+7jsL0tmRJg/Z?=
 =?us-ascii?Q?simsn/aOuNTw1NtIAGlvHUi3zB4LwIK9iZiv/S8lRzHsAod2irzYUH5a0trP?=
 =?us-ascii?Q?WiMqbZBBVX3BuGKBD5S8MovqnQKTkHCZZiHz24JRpEX6uJHXxZDPmY99e3Vu?=
 =?us-ascii?Q?Sq1Zc2SCm/5uwZM5+YKcq05V8bn718hPkIcaY9AwDebN7GnUVeTw/hZJxABs?=
 =?us-ascii?Q?RNWBEbd7rePGO+OPKjUecnQZafpDXwiYFYiWECDbcV/cbkxg/ggZxWeS9T2N?=
 =?us-ascii?Q?yTeVHdCXguHyM5OBjupM/gu4Kmeu4Cg4Rl9X2YDaAKiNEkEAJPXqVvLTZMxB?=
 =?us-ascii?Q?CC/2gCt4ZEcl6j7fGPr1kR1XNCs7MDbPb5IinalZz+OKAmAntcbtJa83lR96?=
 =?us-ascii?Q?OaS7YpH4IArTwjubjMzf21ogrQlfmEYxry1JktVrSyGoXgc+Q+RA7342bdEU?=
 =?us-ascii?Q?m17TeDKhA+Fh7A2NEt5UwR7IKCyRC0ZiQLIV1pJRDUb+khNc9777KLNc70BX?=
 =?us-ascii?Q?M9OM0iHxAbrXPpb98tMbZiQMWBjLO2yqcWoWFJ+qc1osHlHJn0t9uuS/SGTV?=
 =?us-ascii?Q?VJAOSoq5ovszd2GCT0KH628MMbwUARJSLxNRbG2ZRG+76Z7s1kYlM/IwqJf1?=
 =?us-ascii?Q?xeyTt/urV80lh86oXnXnV/RVhRTj2OuaJnzVIJfLXLkFHDfA+xEMDEr0OVTR?=
 =?us-ascii?Q?U5+tTkpU05NlW4lqm5NOBu9LX738Vt3R7wdopbMHXsT3hzTPV5aqn/IOpI60?=
 =?us-ascii?Q?Ov/zIo7GdvHwax14x/3H9PykHuDGv9mgnuGbaKmN/0Yd06vDpG/FKyUUxKxt?=
 =?us-ascii?Q?K5VExDk/Zmp05uLF6GEEvdBFBrPDKSDY60lSjej7a/z3GeknUZEtznXghp+I?=
 =?us-ascii?Q?teEcmMEYOfECfMSciyqHowGZJQxEEXtSVycT7QCI1k5HJcSKmH9TPh2tzUUh?=
 =?us-ascii?Q?mr9gnOdeod1yRy3KK1ijO8WrT0yziIl3B5tARC0uEsB+aTugivs/NJb1r2Er?=
 =?us-ascii?Q?A4v4vAJfAaY9+wEF3l+5Pb520IYWba4CG9AiCq2wrJlm5DrfJeRJFKviQzxZ?=
 =?us-ascii?Q?QoofN3Dm/rJZ/bqcVwaRp0VNQ3yOJd1uSN29H40QSER+73cXc3LoMCdR0eha?=
 =?us-ascii?Q?/kimmShNX8oDLG+T3FQSEiB9OZt8rVVm69mkG/xHc6E0ax5MD7ESzIMVnhmJ?=
 =?us-ascii?Q?ibyC6pxsTc7trvIL/ZMoSHSwXQqVlkM1CM49orlJTBC9Ck37Bg/qIydCJGaW?=
 =?us-ascii?Q?Tc2TLYOaVVhdTqToeHcJRBSjrLriB0/QG2D2No55gebMoIcTXTqmb8Xukiof?=
 =?us-ascii?Q?mlIpAzCGCJJ7A9e4wr3G7xNFvFk0JWUoRag/VfvIrabCxOc/bZFJExz8Tf5R?=
 =?us-ascii?Q?6f5cOYwhUCMVqjvuqsI2awVEhBRgXr803H+DyTuNMgsjW7c11xDTMD2WSrF6?=
 =?us-ascii?Q?uCI/yGlEwHXR5XrrkNYv6a2yx0s/s9NvVoO/YwtNEjFKL0apgxfLP3SZ61nc?=
 =?us-ascii?Q?bxK9fMw6B8x6gWRWlPTDIbR69ERbHK+Ya5gcuQmqwHD3hxmZwJIbu6jk9nW2?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd9972-4a3a-4648-d2a7-08dbbc3bec18
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:35.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY5Aq1rFDqGF7oK1Nvk9V2Hc1UtjjS65M+X6z2PBKLrVDzSzcS0EnbCE22Gp/AZ9ybcDrij3rYF5+gJVFzCw5Q==
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

Treat the newly introduced subsets of 25GBase-KR and 25GBase-CR the same
way as the fully-featured link modes. The difference only consists in
RS-FEC support.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6415c7b91053..157984dd81de 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -321,6 +321,8 @@ void phylink_caps_to_linkmodes(unsigned long *linkmodes, unsigned long caps)
 	if (caps & MAC_25000FD) {
 		__set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT, linkmodes);
 		__set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT, linkmodes);
 		__set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT, linkmodes);
 	}
 
@@ -919,6 +921,8 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_25GBASER:
 			phylink_set(pl->supported, 25000baseCR_Full);
 			phylink_set(pl->supported, 25000baseKR_Full);
+			phylink_set(pl->supported, 25000baseCR_S_Full);
+			phylink_set(pl->supported, 25000baseKR_S_Full);
 			phylink_set(pl->supported, 25000baseSR_Full);
 			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
@@ -948,6 +952,8 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_XLGMII:
 			phylink_set(pl->supported, 25000baseCR_Full);
 			phylink_set(pl->supported, 25000baseKR_Full);
+			phylink_set(pl->supported, 25000baseCR_S_Full);
+			phylink_set(pl->supported, 25000baseKR_S_Full);
 			phylink_set(pl->supported, 25000baseSR_Full);
 			phylink_set(pl->supported, 40000baseKR4_Full);
 			phylink_set(pl->supported, 40000baseCR4_Full);
-- 
2.34.1

