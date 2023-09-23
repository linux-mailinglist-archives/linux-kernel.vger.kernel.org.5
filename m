Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172C7AC285
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjIWNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjIWNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5291BB;
        Sat, 23 Sep 2023 06:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXuhQm6yItcgG78oL19VDcO3JBmIbONzJ5JIybQ1X3SGrZ16HfUKJJagTiFH4hXUUi9CEAiIDi4qVT1EfPSAa08kxI6JDpRsS1osMkdOVp4IlQe5MZxsYqEywF/sG1Ac2nrWZG0OnI0pw4VfiVDXu6AWAR5B5HjYOuIqp1OoqirAuFBgFNpSAeFFw7t7WWm4nZFjOC/lLppdTLNUgYq07jd5Yi5L6E7eVCa2JJlW5bYfROmNFV+gz7rUUZwGPaY4ViR5/gQKKrOHezslj9htzPb+1Rsi9W6VL9c6Wd2zOd22i56/itA9hEOBG4T428SRTZqJt54UQ+V+IQt5UifFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWTsqDWQQ5BI3+PWtN1EH7dxdWOxyeOoC1NwQtHXqCk=;
 b=L0habHwiIbR7yz6T+BErX92H5zAA43YuMHy9a4L6+8d0UVzDzPzOtEpII5DtixXx2ZkZwNY+uUqxD2ljNpVC4TCn8Xo/UCyQnuTLDoK8mZnPfCNLhojuwMBhUXF3voLxAhnAUCOyjFRi3WDjE6zThkfXpyU/gScq9SJHM5jtNSZ1KboCJcAOtsMMQ+uEx32BUbA3b+ovUriGXz95kNY9+sIYjD/3nujDtXs6Bjy2xrfVEt2T4nw6q+Fop75JRzIqcWuNl9x+qIrBDi/XRNo/VsXzM8jd58goks576M5YibIEtqL7evZA0zd5R82sMlWS75T4fl64TkiC2bbae7czmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWTsqDWQQ5BI3+PWtN1EH7dxdWOxyeOoC1NwQtHXqCk=;
 b=bus802hnN/tyRWkCaYse3Nd5PbSvRhaYddR6KDRD/Cy9w3dpl0zY6r2nxbseB6kPZ/iboxrBajlYjjcNdIbHr+4xeCc8KOQDVLaaG743b8w2PANB0w5LY513NzgWJZBR/ZSJKKu0XijnWfMbOnCIv8Hsz3MO/tF/hNnvweGf/Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:36 +0000
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
Subject: [RFC PATCH v2 net-next 12/15] net: phylink: add the 25G link modes to phylink_c73_priority_resolution[]
Date:   Sat, 23 Sep 2023 16:49:01 +0300
Message-Id: <20230923134904.3627402-13-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d8c0bb2-4be1-4f4e-eecc-08dbbc3becd9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fhpc89n4MjopHsqt6xZuLj0sJPzGxPxUbYTken7RbpiKSExaIrjB5wUzE9u2fyQd4BRswmP42ybMFbWSs7aywnrn7RXHlnYMtrXg6gMzzsolUVrBcSZzy8YhiNb06hWLR96xGYSPBF1ta5KvTYjM/72zxrcZP+HeClDSWUztcmFqvYc1QrVFgWFcOFeEE/93QRU/I0fNJCcP6yRb0Cf+syhvPPsC4JWPv99Nn+5BwiVvtxSMforOGYMKEWtJeyxk0N/agocg0zTzI8n2JYn7TRN0nEwEYP0W6HomTh13WjBA7qVbL0EQCtmNg0DxMDbzi4wIf4cyTzfbnCFJhsYjeRGxm4BBpl56ehnR2PzBO/qMLYf1neSBZblMuEROxRg4dYi4ra4Ld2L5vAyVYVh+U6knnn8Y6G/mvt4En1OESBAinLDmgFN8mqRA9GOAZOOb9h+4nfscuPYKmup8X99jffrTsT3cx5i2iHNxDikMlBshOp7WyTZMLi49GWyQPOuE7I0PhQHVBv5PXdiPC5AMDtfsUEhaYFYQk80bTvjNdHMkKUUAw12uZasw6MbPWRTGTf6DMJKb5NWFQUoIlkdXQ+s3vS8UnPrxnzCCcJxyhPvds9M44lH9rL8uQcmxwt2l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vq/d6whXlZfuFIuGDjPxul/K71D4bpu3QwE9q5wJzYQz94OFHls2tsTNQk/q?=
 =?us-ascii?Q?1SsV2fUFimQhR1FgzRJcWrucCvgN3y2+N9n3htsY+ND89jQtO98P9GIjR8wd?=
 =?us-ascii?Q?nOyj7TiQk/0p+4dOjBRKGiX7D0Mjb7yWSGWS8/DRyHOpWgN4BRJ0dc3GkgqS?=
 =?us-ascii?Q?nHwAgYKLFybSl00UAuthFD5s/xfA2IEVOZ3tbyCfM+gszxJzdGM8Ve05m8cn?=
 =?us-ascii?Q?85cbw9Gzkm3L5CBeSVwL34Cd3QleoZkOUhk1hCtblAfPHpXP+m1UvcHuWTHW?=
 =?us-ascii?Q?MgMCMxof1KZhVwvAeJyVXx9C4yFC1J0UsKbwS4GJeLxttPNgxGOCEkBOoHlE?=
 =?us-ascii?Q?7IA87rH1juS43r6DLKyFedtMzssSfbRyPHtOaTd8PUhpyv6xCeiJw+WJ4BNt?=
 =?us-ascii?Q?iNRmbkBWb1Yz82cdSl5f9sudfcG0bYQzl7LaRG0RhWL8Iasb4LmNDXXdrgCj?=
 =?us-ascii?Q?XFPDrdCOVQ+oKAB96jJp2VjuODc+T4wtFba6NJzDpI8xhQ+uvIyutJcOb9/3?=
 =?us-ascii?Q?h1ZLiv6Em56fgwLaJhVBxjBBfZlBLGsO/SuOkVIzmIfTtcCYTd2qztucXW9e?=
 =?us-ascii?Q?S09icq6MwOlg8xNdda+V2UZImjwyvNXuRB8Jrta65BsE1nqJGtrzK+enUzDI?=
 =?us-ascii?Q?1qJABMb/whCM/j/J1M3/L+hrfIGv1TyVii/QsJZZ6zkie6XOnuPPTakGeP8+?=
 =?us-ascii?Q?JCv9OJuK03x585DU3tjOpornkh5ihb0u/w81lvkzRQ4Sa7qvvwiikiEU9nFi?=
 =?us-ascii?Q?rHg0UsL6K6ceiiPwlM6oyCCFAEg9C7iqta9tDF8Te9CYs9LBLdTGyTm3xr2L?=
 =?us-ascii?Q?5WB6IbkwDlsYzVV+YE9F7xb5szY+765PbpN45iRXJA/MHY/Rg7D4ZgFLz6k6?=
 =?us-ascii?Q?Lw7kS1h+Lx6usB/7uZlBwHmUahyIs3m4E/0fHtHr6/bqUkryl7ipQOwIxbK/?=
 =?us-ascii?Q?sv9HxnRDJ+UTgwoELrkl1qPaVi1vQJb2KTYVgNPldL2Rk6ihRCg8Vi5Az+3u?=
 =?us-ascii?Q?r/6f13MCc2rYqPEJ6rEg0JzoN0fXn0NfbCueR/ChH5BvbxHKS+6y0p2pXzsw?=
 =?us-ascii?Q?iLZC8mDZznPWqCm4fIA46IaHJw3wVTI/zfhPvoT+ZoK0KlezayuM6uzpLn0a?=
 =?us-ascii?Q?zqXavyUG6fy8Tp7bfd0VjIY43rvURlZ2QV6Dj8+JJ1Ncas6c5GG2/5pUl3WU?=
 =?us-ascii?Q?TPfq5GTtmEY/hbqiNpRmpzAeHX/w1mOeXceaB8mi8MgvD3ZUBzJsiMsDVMGb?=
 =?us-ascii?Q?wrMvbIeIdlr3/Atj9EWqrTwHYJyYWKDNP0xfN83763qfGtp+TsPMqqpmBMOU?=
 =?us-ascii?Q?62SyAEK6e8yRTfMdZ0pRvbaNEcx4KG4/2Hl3XeaeJolSgZ5gyeQLxZiayeVY?=
 =?us-ascii?Q?4EHnSUilZyORh7PJlA20BSSIYWAdpGfLP6ktYnPdd8IeVHfh8OfI3zj/PbC0?=
 =?us-ascii?Q?m8+FTZYZyMsDGKiL11XQ0xjntO9XNPXW47rXSbe2G+MNlhGXBhO82LC8/2tl?=
 =?us-ascii?Q?9XlfoB1bZabIVt2bNBqj5ZgZRjD+9QlLd5Wvcak+uELxfEUnzOoajkVNKaaZ?=
 =?us-ascii?Q?PflhHBPoYtnA+RgEi3BjZIoWSkgWeT41ckL+PnoOVLpOprDRlcHN/0OAwWum?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8c0bb2-4be1-4f4e-eecc-08dbbc3becd9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:36.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxll6W073uISqac8gWohl7Jctqd9OWUSqt2th7SBN9SIZRxC+AP9aLTc1Zih5K8iPkHMQdrxXRS2WE8kKqo4nA==
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

Allow phylink_resolve_c73() to resolve backplane (KR) or SFP28 (CR)
link speeds of 25Gbps.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 157984dd81de..484db2a5b62b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3382,6 +3382,10 @@ static struct {
 	/* 100GBASE-KP4 and 100GBASE-CR10 not supported */
 	{ ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, SPEED_40000 },
 	{ ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, SPEED_40000 },
+	{ ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, SPEED_25000 },
+	{ ETHTOOL_LINK_MODE_25000baseCR_Full_BIT, SPEED_25000 },
+	{ ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT, SPEED_25000 },
+	{ ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT, SPEED_25000 },
 	{ ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, SPEED_10000 },
 	{ ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, SPEED_10000 },
 	/* 5GBASE-KR not supported */
-- 
2.34.1

