Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253EE769151
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGaJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjGaJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:48 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0AF3;
        Mon, 31 Jul 2023 02:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKEXx3G/IC0virILT2aOy2jjcgWc3BJlLiwzOc7anTlitaDyj0shFbZLLLgzQ9ia260XvRoFZ0LvoTOd0AG/zuF0O6Nmqy6ifQOouPHL2WjpzXdhjZyaj2HDSEbzpO6xPTnyG3HHtoXyUGir4YHtoVV5j9Cks6kWmppOxsbQfMXeDwxSnHupzrBgCdvr8Dszu2l/d8GK7lDJROcu2otoNwfAVBrEVcFddhTI6l38YVDFHuwcjnwjUL9j4NqEU+7j7fchIKkciT3ALpeqZZWfbVVNh1tWoF50avIM2k4hba30UeRe1cdxOW/o4fv1TvGsRTjBc0sQzj+JBiOG95UvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hao4PWCFcSVtFyw4hWYkar5C6PYt2VCDFPjoIP92X4I=;
 b=LatYGKX5NDLT9bh3cp8KDsHADv97hwDet0LYAYTNbmCkftMdcEIc/dUBYefZp6ZwaGgJTDRa7S/HFr9mfO9KEEHuR+W5zmreX2V03mqRIBQO8uB844xsdeabEMe/XZJhJz47/1RZZrbB1ykvWnTdHSerEoCAS56SARgfxOMf6DSzVWzJmIgtBby3RwTl7AWr65lL8lhTJZGB81QCu9IkfFBHvoh5WPXkHTSTlPOVbvRy/UNjgEsVvESomrfJ7iqpMkVLjCWSw+9Mtf4qi3/NU3vksV9ly+tZAPFFqZmmaCrqyHf4EVJE+Ie/seu0xVy9/oGaFgnrboEk4h7USigs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hao4PWCFcSVtFyw4hWYkar5C6PYt2VCDFPjoIP92X4I=;
 b=igH55+pECsxVaDxDNF2FkoJxEj9Ua7moAYTAWPRq8+aG6AUuDIEh8gX5k2RrtsQ5jvBuOB2DPAPA/3z9y57aZH+Oaouks8GQG6nbm9jnY1YjhPXzzoF7QHrwsocYh4WhyENReBOg4RRBva53WA2iJXAFTYOSAkjpiN+xF6LAuHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:41 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:41 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 04/11] net: phy: nxp-c45-tja11xx: use get_features
Date:   Mon, 31 Jul 2023 12:16:12 +0300
Message-Id: <20230731091619.77961-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 10750761-c33a-43b0-7f16-08db91a6d9d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7Z7hpWdKKwQs748a05DIU8Af3ai3C9B2h97xoJCFC9v06Nj/sYZ744GdVhBERhhxCH0efPr7JjbHxkV8CPj5iQFh9bCh52KLExef9hKXeA8owzXag/RCPntDYNtgtp/Cx2rFQpuoV/XCvrHlDkXfdv0XkhzSb73yrtzsLo2Oy8J2C/o81yK5+55oBnq6rslTMMAAUoYAaSZvl17z4iT+2x5USaxYqsusdR/p+NZX6lg3R1FbJQ+CIz3wktB/isejKvM5lBqMSWqgGYufOWKC9+QnBszv/eW+PgvRVQ4P2U6y/68Yd6AsK5zfZ3fFutGuTOn/NdzlhxHUietwyUA46qlCHPQ8KRoITn6MlgKMLrWQWc9oa9YGrh8lDIfC1QACUvxSjz7HsKFioYSyeao163EKTAgwz0BeJvV+jXz76j9nWEyOuoIO/Qr7zFvo7DSaV/EoRsGgZJcOcTHSi9c7VOaGKZEBVAY0hHqy3i0nVXiMINUmeEiT8xTBG5rnGHb4o3aMnbyPk2YSZ47svjo9ntPBsqGC6MQkA2QANOfL4F4s6vVNpmbSLyX2yP/+9OJVE1CxQuX7cp5O8rWlCj+Uya1jdm4xMu3fINV1Taiwbnh317JBcgWMk6MBoF/rHzK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(66946007)(66556008)(66476007)(2906002)(4326008)(7416002)(316002)(41300700001)(2616005)(6486002)(478600001)(6666004)(52116002)(8936002)(8676002)(1076003)(26005)(6506007)(186003)(83380400001)(38100700002)(38350700002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9lfkwWjiPxMnGNl+MUIZR0ChkFOV9pAAGh7YFVpY8gQB0/BzhRQ9PJtvnDz?=
 =?us-ascii?Q?dvCJoy74P+7Gc1aHFz6sTF1ACWTgdi5mExEXPOhZT/WJWvrpGAMDZnEXcIeb?=
 =?us-ascii?Q?sLhG4n3bKm/TRweOdULfZtQBiw3MXPgzsJLLA+FoQh0UlIDAEgDYD2V4XPoa?=
 =?us-ascii?Q?BhbsJljRu5IC5uSAuTwc4c26GjGpI68SBrwRBzRWyWUN/fVDY59bIrGxPcip?=
 =?us-ascii?Q?dB03EYH5yniKG4gTVXuec7V1LSu0LyDD3NSVi5ojwV+YoR6Jcy8HN45i7eKY?=
 =?us-ascii?Q?MUNdUC5PTIQhHbCvoR0Jq1oVNlmxGd9T7wpGDo1JIF3XNblK3pAKwe6HzZPe?=
 =?us-ascii?Q?Lk88zzxSBbm+ZUjYPR09EIqFsHaKuI64McGgyRxcnzSJiiDKd7gzcdi6idHb?=
 =?us-ascii?Q?zu7Czsi0Q2OfWsjwEDZmOFDcUMpKzibM2OKaptNvieVEErWVH+TpXHlXlCSZ?=
 =?us-ascii?Q?rek/idpi8cPgq3gK1mimCnwgXRo0GOwx0G0w4WXrCMYYEz9MkqVvmrqZN0f1?=
 =?us-ascii?Q?rmLz+VPVhcOlQ3hlNsQ4muBINCtfXxDBS7vqBgax+v2SPfnqh0YaQ2M+5L7P?=
 =?us-ascii?Q?DD2V2QcIYrPQ0SyAd7ex+BWRxw7O5pilPB3BXL2aN/nEUwXtSfnOuhM7KHuA?=
 =?us-ascii?Q?V4pqmDr0CRDruI0frIL6U7SNRzIW4nNlVcblgd582br0DfL7lvcQFT1psPPn?=
 =?us-ascii?Q?HZ9b/i0pYwJDs+2C6HbKbk+3wXtThtBWS6DGYzYFUmTw9hItaO00dm2eUejk?=
 =?us-ascii?Q?ipTOcETwy6bMQd7wjAqRJDKH9wZnFkTC41m7m8WDzRSjf5Z8MMLaWDbeFWwD?=
 =?us-ascii?Q?dSd9+Ucnjmt8x0dw9DYcWtLjCpcp3vl31HukkkKmx2Tp1NBMvGbkyBC7l7qg?=
 =?us-ascii?Q?Dp84RruVp430KKGc7mHVN2Sri6nrDKTkPyIrkjygbVwSQD/elRxBPAg/xE57?=
 =?us-ascii?Q?PH7NHs6WP0zS0Ioa7UW4TH3A+EkKynIXn5fvMWS1cTC3x4zLEp7yBm3ne3GC?=
 =?us-ascii?Q?qUGuLn+HZbdreY+JyKGAjFUZKrGeQQ+XEEhMJu7z9doFT+jT+iXpz957kQb0?=
 =?us-ascii?Q?NifjV2of4VCk1nZ2CGHU+6guWmfKWPPVeHWx2MFw5KywaWi9gfMI/HG3/Q9R?=
 =?us-ascii?Q?MiyB8DpQP+TeCX1RD+QikFChgbW3SdVvkLtk+t8e0fiWF4CY5aMZAwxaQ1H0?=
 =?us-ascii?Q?eiX3TY77+Ga8HG0n1BCSv027hQFiVkxEcEke01BH+fZb8aCGMs+DQMDNJbhR?=
 =?us-ascii?Q?XK6YzwxjK7paqsHvJTsDQ4x2KQqOWICH/k27gDeWIEbzpSV18WYRplIyHBtF?=
 =?us-ascii?Q?ketyDn8wToIZfQDYWcV95Z/j+RsQtxR0Rz7fh5MvBVzN4pKg8DOA0y6Gb8Iu?=
 =?us-ascii?Q?OuFmGieyvXKj4mwyFw3C0i5BAdBbY02HWT7qb1Pk5Hc1utZ6qAK0DSyDaY2r?=
 =?us-ascii?Q?k37GiYCdstoBLetSSeVwgf8u26KyAvjLCmSbAQVzssyO/EUgB1VS9Ue/gGYm?=
 =?us-ascii?Q?9GXP0MCq8rvYJy43xWR89QXdhi/XU+sZm1/tT2pDAPH2YbJyoxP9pDRxZj0m?=
 =?us-ascii?Q?celIafOJxUAM3xCHffLTwlBf1svTru7HV6Xlcys0MGv5lxxo17i1Iq+AE+OJ?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10750761-c33a-43b0-7f16-08db91a6d9d9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:41.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PsfiNpylx94fgcidj/4Ts5MR5OPj4bpnlE2Mck+sF6N5WLJqlHEf7p1zlTpZZh//1UDM9VUOVRH8Jp0JT+PoDJ8xTa98PQBFjoy+lvOkvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY_BASIC_T1_FEATURES are not the right features supported by TJA1103
anymore.
For example ethtool reports:
	[root@alarm ~]# ethtool end0
	Settings for end0:
	        Supported ports: [ TP ]
	        Supported link modes:   100baseT1/Full
	                                10baseT1L/Full

10baseT1L/Full is not supported by TJA1103 and supported ports list is
not completed. The PHY also have a MII port.

genphy_c45_pma_read_abilities implementation can detect the PHY features
and they look like this.
[root@alarm ~]# ethtool end0
Settings for end0:
        Supported ports: [ TP    MII ]
        Supported link modes:   100baseT1/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced master
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes
        SQI: 7/7

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index d5981985b320..573083f0550f 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1353,6 +1353,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	return nxp_c45_start_op(phydev);
 }
 
+static int nxp_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1507,7 +1515,7 @@ static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
-		.features		= PHY_BASIC_T1_FEATURES,
+		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-- 
2.34.1

