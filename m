Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647B57AC281
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjIWNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjIWNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC55CC7;
        Sat, 23 Sep 2023 06:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYOt2smFwsLNOXpJtlKG9auOote6smGUEYZwYgfoRblngBu7t6M8Hpwqu5JvEDDHGKwGdJE0v0ywQ0QgAq+d55yy2KSBS1Cb9MhVF8sBfpYoj1KzH3MMS9NU7q0xum+eANZYTm73BXLdnjIJNWNsFT1KVK2zFwlcxxplrC5LMBMwwRlxryXSWgFeHGVr7XkE9PK4ZjNXdR4YVOB2//7iNAjwfAAn31F2zMNSr5ZSzMXUGIaulcQn5vMr6nj8BzWPygy9XTMbVtr6Eh8/5CdsnumamIqa1LsIESwCqWZHnLmYatn9rJNn9lFVQcicKh5Kq2PG3X4ylGIKsB7ploK4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2SciGmlkCgzOy99iuFcgQ8/NUtI7USZSQUF0JH52F4=;
 b=YTEwFrGmifKe3Kh+Ktvald9CeUsR9jHZromRtzmmTM82W41WwDTle2V1kkbQ4lJ0sS9zP6/+RnmL/rRDmEH0rMFYAW8x0QRRCbU5/cfy12KM6qKu+8Srwp0TGerXzq++3jVikef06uZl6VCF6twHopdqVVn5p8L1KwjhUqXS3Db4UEEr9hoAr7smT653pZXxnCRZ5ZN3MTfs63FSMA37NjVPwfzt3lCdYIeu7jByZK5zEmoXNGVEmeC95ml8V97TK7//Lz8BRwbQn3+gXMvPOilZ9oeQdw3AIfCb4HgBv7izNYuYCUbZMMCXAKLuwXGHXXaR8jC+MpPtvaNG/HD//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2SciGmlkCgzOy99iuFcgQ8/NUtI7USZSQUF0JH52F4=;
 b=r4+Ua2HMWh50mgmwuEw5gNlwlMe/ehCD9Soi66crh67ewps1Aso/R8FTnujp90Z6byJOKyY+tvma7Ch2nJVI1iLT9IvukxAgrutATmJpUJGWxZfU34vBHriNE5jFTzMnZFw4kc8aW2pxe+WEl9LaRne5uRgji3resJqcQ8wfHYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:34 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:34 +0000
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
Subject: [RFC PATCH v2 net-next 10/15] net: phylink: support all ethtool port modes with inband modes
Date:   Sat, 23 Sep 2023 16:48:59 +0300
Message-Id: <20230923134904.3627402-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d32c1671-df61-4eb9-3fdd-08dbbc3beb61
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Jhxud0XyVF7/5WqN8gNU5QOkshPkIX5frQm1uAEzUy+KdHigRbWhCrfJc5PgXB8LQ/IutCnBFhAjiQCAbvRCiD5ojXiUSWjtzfCq5hsXN+9svhe7cXEvE0OGo3gmjvIxV/NDEQLRADiic8PJWjfYGugtbx0JM1o/FMdASo2Wfxya64llcOw4iQjsNq/5zEpUyAg3yVH3vHU7B15eHEDcOG6CPq21EKZOSGFlta93uVvzd/wExL1auOWldRlzvax8DP7yDOk19tiIz5/Jy3QslJDWr8PbHoV7oYJRostAXxT/gav1pCd9bGinrBH/8eZeh+Pu6yQlSEmHNZm7ucR0dyVsuYTaszfW96bbxtMq27kdknAx0WG3/fPoLID0oHtP18RWJmIQEVzDMSKdoB3o/9tFCxB3GuXJ7xoE63wPkFKLhvcllDVEPeDjTMKHQU23H+XMmAv28O96KdOvozITx0sdFDjHJcB3FrSjFGaqLRiN8eLZ48cHeAOybCE3Gwiaocd2QGPjYqv+YO/o3wRBa11A8tH6Nt9KA3+WFxoIH+X2/eD47TZUrfT3Ihbfi7PgIVWeOThv24NicNqo2rPhwQGfxVnL9SpxIGOLSH8O1VSW47HhIs+P5a+Ogwawmi2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAoeq/OoZgtICxCbhF2Rmx0lgXWWUbgkYK7W8liZQprq/RlYrmV0zpUOUsmW?=
 =?us-ascii?Q?QohXKxx0WIKe3O/8H9yqRy16vldE39ZxgW+/AfQjVfv5UYM3DrMm0q25q6gt?=
 =?us-ascii?Q?zgbN4+BeM+Y7JytAPpUw574bx5nZu5HloGNyaCeqLbBY00D0GgFgvnesh9VE?=
 =?us-ascii?Q?aE4iKiWJfOwkwFSUZZXU7sXhQisDRcKXzdpwo8BO6QGAIxZOtNem9mgjb94R?=
 =?us-ascii?Q?f91j9ONEcL0W1K9I+fYLvy/yX/6+iSVlWE9CQkmRNWGbyLhGc+TkwBG65qB7?=
 =?us-ascii?Q?LDN2qPGW3t9VZdnJm6afhvcwXGToM29cF9JT7xZlw3QsMlyskQ6Z3ykF9+F3?=
 =?us-ascii?Q?5Eb+sCEeYzmzNRAXUEnracczOAo73W8eUglobbMUKU63pBNZWmTSJ7kvqvWM?=
 =?us-ascii?Q?umq1lvP+DMaYW8EXd4imzapPMWFl8MpSUkwcAb6u+LDz4R5e9ERtRkFMkWXN?=
 =?us-ascii?Q?GOUDcI9Ul42GlHn4BRcP2leR6Udneh0vXgpeV8Sd44J6BRH59i4etKyFJDKH?=
 =?us-ascii?Q?YYtGNZTs2u+7Y1pOyKYYQKO49C7fd2/0GzWRidv3QNf4bEF0vbjsRQzz9vyE?=
 =?us-ascii?Q?gyqpE6zLvyENReaFoFpJDws7ReXvo1G7Qy3psXkHd25NhuiFzEv+lHDGA4wv?=
 =?us-ascii?Q?unhA/K57CaKTpr2ZKriLQVlF0nkIYYVJHuAbTUYK2fnSa6AkaVw7V/7IZox3?=
 =?us-ascii?Q?iVd9Bc9/ImEywIZgJTfwkBx0RzZhpNPz+jcLJ24AxBwSd+iC4tXP56w5iX0n?=
 =?us-ascii?Q?JFjdqSCYQXDLpZIcZk2lCpttjPrlktVnCV5Dj8pwRFqGOFEx0MeekWg/KW/L?=
 =?us-ascii?Q?9Aupjuo4JwqmbGxq+hVdPmV6wfqDNurW3EJu9dT+vcfnmUEurdcLl4FUoAAj?=
 =?us-ascii?Q?pmiCMuIlBzdgPej7RNXHW7Y3Ul89GQX53p1Ua5K1mFz+X6VRiJxyKa3q9P5o?=
 =?us-ascii?Q?MKPyDdLcqWJuax5N48OkvGVzigFmdIAFVTXW5FLKEoTdQ3knWtgDs04X33m7?=
 =?us-ascii?Q?V0dMdivi5aN4llPlMPmfu7lBdST5oAEzA97gs/3e3LxOlGB8f0AOJ5LoDy0/?=
 =?us-ascii?Q?nBzV2tlV4Gscw3dUkHo+4li98rdUuTFx0KStrmv3NTgMTunQYNLb+BQYr80u?=
 =?us-ascii?Q?gGOMIpy7g8hH3aXZ5VJ89q2LyZHJzrAjPr/s2svEA/wz4WRWiGA9ZauoSk73?=
 =?us-ascii?Q?84IEwKslyb0apNrK4IRAE5PXp6t+NGLDddJmsC1AGKr6PhzSmKqrhVfBMriQ?=
 =?us-ascii?Q?ZMbcJVI344G7tFxpyj8WN2UmTkimPRRmakkTXKwqo0qH0V1PhgXMkeFufO2H?=
 =?us-ascii?Q?mqkQlhTBFdLFcS+TS0FF/bLbhxnm8PmHR35n6I5O+n3nQBMtuHA1npZZYaB3?=
 =?us-ascii?Q?Ke4V8jq67Yt0SYMt7By7jXZNRX1hHVBTioszzqHESHd1AFQ8Tv6BTp2eUvbH?=
 =?us-ascii?Q?VVw+qZx3yviG17jJonALZCzRRzVazVtCbux2X18MkEea36Oo1vsjcBidv/hF?=
 =?us-ascii?Q?Gk19z64wHSmD1FbEtAGXAv3nNSgbySHLWDv0IDbEI55I8cM2nM9as9Qv/2KJ?=
 =?us-ascii?Q?FwQFNlL5yJ1Ls89W68g9H8NvQ2iViWO3SSBLsSs6qlDsWuHl3+E1PhOWr3fw?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c1671-df61-4eb9-3fdd-08dbbc3beb61
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:34.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4W2km6SRx4VPXYBATJ8UPAsGXSfUv5Ae6ghCuytEvKXLSwbuavVyf7UONE/44K5a9nat9R8/fc0KvhzakweWw==
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

Currently, phylink_parse_mode() filters out all port modes except
ETHTOOL_LINK_MODE_MII_BIT for in-band link modes. But if we're going to
accept backplane port modes with inband autoneg, then we should also
allow ETHTOOL_LINK_MODE_Backplane_BIT.

Use phylink_set_port_modes() to just allow them all, and let the
validate() functions of the MAC and phylink_pcs restrict what they don't
support.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 88ace7e203c3..6415c7b91053 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -880,7 +880,7 @@ static int phylink_parse_mode(struct phylink *pl,
 		}
 
 		linkmode_zero(pl->supported);
-		phylink_set(pl->supported, MII);
+		phylink_set_port_modes(pl->supported);
 		phylink_set(pl->supported, Autoneg);
 		phylink_set(pl->supported, Asym_Pause);
 		phylink_set(pl->supported, Pause);
-- 
2.34.1

