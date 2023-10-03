Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B27B6C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjJCPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJCPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:01:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167CA7;
        Tue,  3 Oct 2023 08:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtCU5hgo2/cRF6iJF5SE4lcSiZlJBrTqtcNTho4aG3aH//czEdkiyoiKIppXTov8wkeDpaKVy8WBuMkV30VhKFBqnmAyJ2ZqfxFVpb35pIJl0f9PZJUewqwNRVWhKyDITcJwKNej6vpem1Ng+yxfD7DMPRJkmn/gGyn3EDoA2a8RxzFNKUVVW5NeYslLtZK4CCCkOuYNFlYNyHjz23tynIW47qlFLmN5T+Ov9jfhbaCl+VDDpcpwVCT3iID99tw/VUE2/r9egfUBRAYWqR3vnU4se+cgIXV9enqpawGie0fbe0b/xnwz90E+8CITjsRHVzYvfxuncDeMTvXYslP06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5ZaV21WfO0w4fWfXl7iT+qpn6Z1utACgTJCSxY9WUc=;
 b=II4v2TnrRraJinSYGD4ZKyEHraeGTUEsEA8Uid4ceOv0toLg1m+uD4cJw3t1HOGDZphU9uXa0EZ6FyWX6w6ZxWRyE2lwzEwwA3KOiT7vTQyQ2200YcoaqgUhD1F2AbaU9ACtM0hvIMzbjPG7Wu50cGWKsv49I4U7bpZgtVkLe04hIuqkaE9hZ9fhB7jC4xPr9XlSTMRT5L2QD5eGTo06iZgccMCPh5TAi2rn2tz7rt3rw33ELF/Im185822mBxOTfpR8mtmy7kofJ+qrblqMOJa1V6BvZS9lOAj2I8I6DyYfT/AptXlY6/tmBMin6YDx/3Xat2Xwfd5uTfmJYRCFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5ZaV21WfO0w4fWfXl7iT+qpn6Z1utACgTJCSxY9WUc=;
 b=HgPjeXGH3nYQG8OtqSBaeqHTJH27HYpMrUhNnOEm40CUtNpztUb4PdDw4cgKwrl1FtSDra8XLbgyBIEgs77CctRLY7ZcsN6ySxXjNDxfTxIRQeM84wCfzCyNqOwdH1hnqGI1aCHupbEevr9mVXkJOkxliviqzKxoIiWRDVO2VcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB8062.eurprd04.prod.outlook.com (2603:10a6:102:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 3 Oct
 2023 15:00:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 15:00:52 +0000
Date:   Tue, 3 Oct 2023 18:00:47 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 net-next 08/15] net: phylink: allow PCS to handle
 C73 autoneg for phy-mode = "internal"
Message-ID: <20231003150047.qyzbe4gwtdgcw474@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-9-vladimir.oltean@nxp.com>
 <20231002141743.lbmb66q22dmuyi6f@skbuf>
 <ZRv1qt7+WbQd457L@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRv1qt7+WbQd457L@shell.armlinux.org.uk>
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: aca0eada-0433-4c4f-c38c-08dbc4218947
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1gioOXNdixXldikfZ/ZJ6rzhvrcrdbLN2Df0vgLjRo4eEN74uSEESlodFQwx46Nj2MtOV+c5G3uoBvblpqUpQv3Tg0e7LrRL/OosyXHi6IEwDGjYXke7ndhylTyMNjHo+CPbBrF3GPeIonjnqr9BwwI9miNryHMklzSz45idUuU4FRRzZm3uZ1dkUjw0UipSGd/5Xu4+LPWAB3JvHKGObkWCMdo0SapEWe2kMjThojfei3RzuxBGEj0Iy5xz23xigrGRwyyuMaGTvCK9xh2knZOsCUZoeKM2q2HmGqt3SKC+mt1lrzY3W36YiHD6KPKb5btHI1FX1lYoO0rKrvK/Et1DHLaJwLiRPL1dSVBMPYAMwfcXplCGdvkKH3ryAt+Sp7XnqQbxskvLgAxEQBbwg+Ni6zNEFj9JRX53W7i91+9i3TKruUbDQl/WsUjC42+adDxVCDoM06LyheFMNC8mW6dvQrdZWb7gqJUs86ydS+EhAw407fRgw9/yuVrLwgUyfeb1pPMZv/Wz92DGaknGCqqIIQMPKM8Ygvx8nBsRolU5UEJhQVDoL5ScwO/JMF+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33716001)(4326008)(83380400001)(5660300002)(38100700002)(44832011)(86362001)(7416002)(54906003)(6916009)(316002)(478600001)(41300700001)(66476007)(66556008)(66946007)(8676002)(8936002)(2906002)(6512007)(26005)(1076003)(9686003)(6486002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jqAMcoQrW74V4BWs9umGLxvw611emGMr/3E20y/jJEuamXkdzvA2F8aIaJT?=
 =?us-ascii?Q?XSk6RecjzHVYtOwmU1mplLfDppxWvgg1Ax8R47VGKxf6qTo/dLSKIfebhQN3?=
 =?us-ascii?Q?23CBiInhnsRKgYoPFZ+71Q5fDyfN4PR9KhBZ0bE9UY81AAO/fuluqZbAh+Wa?=
 =?us-ascii?Q?Li5GCMdQC0yPS3OT1SqwIgVZVNR/jofy1Mr/QOvQIJAIxIh1NwJE5WwI3PDp?=
 =?us-ascii?Q?kkodKNx3HJswfOq+0OMZIugHz4xuEMR/nBcOMHaEhzNExO0M0/cG4YXiyYp4?=
 =?us-ascii?Q?Oj4ag+oFUMHe2X1uD3lwv7/mz0CnD7EtSkSqCH9xARdv2K5w4whIEw32BJBi?=
 =?us-ascii?Q?3WbLuH/40IBMB/qll1I8iPLwSWy5SlUXJSzGMhVhvcB6WWz4lVHvzuVAgkMs?=
 =?us-ascii?Q?FwupHNmrOzwi1yxuocJzXCrXbdS+EjwbTqgzHOtT20O9uiwL3f8okeERIvMO?=
 =?us-ascii?Q?XHaelHchr4xOdfJdeOODUD6/w0WIiOS+PzXyFF7qnIm9WG60OsjoUFeO+dS7?=
 =?us-ascii?Q?uiEhvcTlkcmv3xpcFPB6duBRb+rrYIJ3720RfEvmmFh9SnQJlZbS3EHz4Uvt?=
 =?us-ascii?Q?8IePn9DZcPV6om1Qse8gWeEEJ7+Otcpd9Jw/XZeImTTfjK96xGa7TEfVYPSq?=
 =?us-ascii?Q?GyFr0PCudML1/FV/aTmagAGAAOKr/OsFIOHekqX4FWYkBPaKUIGu6pR/ZZ7a?=
 =?us-ascii?Q?Lxv8OCoKekIq6nvtTpOTdN6I0Hz5psvhqtJ6wQg+VA7q9b2LQX9GG48bcko9?=
 =?us-ascii?Q?1ZTusQ/7XmrN4s/+GKRnc58w2A8JwX/ggBEwlM7qu8zCbjGHWSBeiiVNLr4a?=
 =?us-ascii?Q?QQ4P7KcO6RIpUzFSdUbXbaz9N1jdnG4O9LU3umLP4BXhSlPEDHIeOhrVcTvE?=
 =?us-ascii?Q?QsIsKFGXoWH4/iJ02ccCiXUsV4zPEnV+XHEcT9rGr8xPsUBIj+p1fcFTL6n0?=
 =?us-ascii?Q?RL1FQfW6tAhWHH0dcoPVo6/hWRLAOR/4EHucxYDSOA5kF+a98+N+iVutlXN9?=
 =?us-ascii?Q?vGI2Ua35gWEALu71kAsRw8vG0mRmeeypTJKVKa4nKc5UJK8yXrX+G8Hbm9fX?=
 =?us-ascii?Q?Zwm8WGlD7FhllvhqPGDzb6ayWvXEjhkJdZqruarGlF8vqsFZnRaztMmr9ZzA?=
 =?us-ascii?Q?QBoYTC/CBPf4dedva/yfg0Hy6C7DVgMTYRVAs3FGTz1qrmK0SUg9J7ZnnTuK?=
 =?us-ascii?Q?sPuEG0C0YnEv0VFo04kd1ITclmtJRqFQvo2iAB/7Ovc/tZCdkA7rw6XZ510U?=
 =?us-ascii?Q?ZLwU0haNJwwJlh8NWzRp9PbVsi8uIShwEiiLD3rK6Zwiy9s8KjjEld+EMaYo?=
 =?us-ascii?Q?CHDLPGbYKbI64D3DZAYjgxScdXWNDsDvPAi06hFH5LijCOccxhUm8KbjhdaR?=
 =?us-ascii?Q?5XE35aZDK8DcxoYux6/EuNiK3NNg+fV6X+WjYnkPKFCyS+ByuHElhDl5o32R?=
 =?us-ascii?Q?wAVrKlyQxN8tGc5IPDbfrNowa+Qpj7FnmMsF+/bsGQz8CUXBLvVpvC0/9ScL?=
 =?us-ascii?Q?jVE+S6vCdQaOB3CpFZ0ns2NR/z2JQW8brcH/KJg96J53O4MlaawcRtok1xu6?=
 =?us-ascii?Q?J56gYBvMExMKTIRJDRrJSLhJr1Qt2wTlXLKrST8OYRo5hv7sDtkHSRpeLMgX?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca0eada-0433-4c4f-c38c-08dbc4218947
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 15:00:52.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJerrem/A9lfmpRbfIi0rSPSFz2bZln192u/dM5CWUEoMqe9ycTOXOqTLuuSMtOvykpIBeueQl0rbT+bd5PPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, Oct 03, 2023 at 12:06:18PM +0100, Russell King (Oracle) wrote:
> I wonder whether this should just set all link modes, much like
> phylink_get_capabilities() allows.
> 
> I'm also wondering whether the contents of this switch() statement
> should now just do:
> 
> 		case PHY_INTERFACE_... (for each supported mode):
> 			cals = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> 			caps = phylink_get_capabilities(interface, caps,
> 							RATE_MATCH_NONE);
> 			phylink_caps_to_linkmodes(pl->supported, caps);
> 			break;
> 
> rather than duplicating the logic.

You mean something like this?

[PATCH] net: phylink: reimplement population of pl->supported for in-band

phylink_parse_mode() populates all possible supported link modes for a
given phy_interface_t, for the case where a phylib phy may be absent and
we can't retrieve the supported link modes from that.

Russell points out that since the introduction of the generic validation
helpers phylink_get_capabilities() and phylink_caps_to_linkmodes(), we
can rewrite this procedure to populate the pl->supported mask, so that
instead of spelling out the link modes, we derive an intermediary
mac_capabilities bit field, and we convert that to the equivalent link
modes.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 71 +++------------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 548130d77302..88a4b726a9fc 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -864,6 +864,7 @@ static int phylink_parse_mode(struct phylink *pl,
 {
 	struct fwnode_handle *dn;
 	const char *managed;
+	unsigned long caps;
 
 	dn = fwnode_get_named_child_node(fwnode, "fixed-link");
 	if (dn || fwnode_property_present(fwnode, "fixed-link"))
@@ -896,80 +897,18 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_RGMII_RXID:
 		case PHY_INTERFACE_MODE_RGMII_TXID:
 		case PHY_INTERFACE_MODE_RTBI:
-			phylink_set(pl->supported, 10baseT_Half);
-			phylink_set(pl->supported, 10baseT_Full);
-			phylink_set(pl->supported, 100baseT_Half);
-			phylink_set(pl->supported, 100baseT_Full);
-			phylink_set(pl->supported, 1000baseT_Half);
-			phylink_set(pl->supported, 1000baseT_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_1000BASEX:
-			phylink_set(pl->supported, 1000baseX_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_2500BASEX:
-			phylink_set(pl->supported, 2500baseX_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_5GBASER:
-			phylink_set(pl->supported, 5000baseT_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_25GBASER:
-			phylink_set(pl->supported, 25000baseCR_Full);
-			phylink_set(pl->supported, 25000baseKR_Full);
-			phylink_set(pl->supported, 25000baseSR_Full);
-			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
-			phylink_set(pl->supported, 10baseT_Half);
-			phylink_set(pl->supported, 10baseT_Full);
-			phylink_set(pl->supported, 100baseT_Half);
-			phylink_set(pl->supported, 100baseT_Full);
-			phylink_set(pl->supported, 1000baseT_Half);
-			phylink_set(pl->supported, 1000baseT_Full);
-			phylink_set(pl->supported, 1000baseX_Full);
-			phylink_set(pl->supported, 1000baseKX_Full);
-			phylink_set(pl->supported, 2500baseT_Full);
-			phylink_set(pl->supported, 2500baseX_Full);
-			phylink_set(pl->supported, 5000baseT_Full);
-			phylink_set(pl->supported, 10000baseT_Full);
-			phylink_set(pl->supported, 10000baseKR_Full);
-			phylink_set(pl->supported, 10000baseKX4_Full);
-			phylink_set(pl->supported, 10000baseCR_Full);
-			phylink_set(pl->supported, 10000baseSR_Full);
-			phylink_set(pl->supported, 10000baseLR_Full);
-			phylink_set(pl->supported, 10000baseLRM_Full);
-			phylink_set(pl->supported, 10000baseER_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_XLGMII:
-			phylink_set(pl->supported, 25000baseCR_Full);
-			phylink_set(pl->supported, 25000baseKR_Full);
-			phylink_set(pl->supported, 25000baseSR_Full);
-			phylink_set(pl->supported, 40000baseKR4_Full);
-			phylink_set(pl->supported, 40000baseCR4_Full);
-			phylink_set(pl->supported, 40000baseSR4_Full);
-			phylink_set(pl->supported, 40000baseLR4_Full);
-			phylink_set(pl->supported, 50000baseCR2_Full);
-			phylink_set(pl->supported, 50000baseKR2_Full);
-			phylink_set(pl->supported, 50000baseSR2_Full);
-			phylink_set(pl->supported, 50000baseKR_Full);
-			phylink_set(pl->supported, 50000baseSR_Full);
-			phylink_set(pl->supported, 50000baseCR_Full);
-			phylink_set(pl->supported, 50000baseLR_ER_FR_Full);
-			phylink_set(pl->supported, 50000baseDR_Full);
-			phylink_set(pl->supported, 100000baseKR4_Full);
-			phylink_set(pl->supported, 100000baseSR4_Full);
-			phylink_set(pl->supported, 100000baseCR4_Full);
-			phylink_set(pl->supported, 100000baseLR4_ER4_Full);
-			phylink_set(pl->supported, 100000baseKR2_Full);
-			phylink_set(pl->supported, 100000baseSR2_Full);
-			phylink_set(pl->supported, 100000baseCR2_Full);
-			phylink_set(pl->supported, 100000baseLR2_ER2_FR2_Full);
-			phylink_set(pl->supported, 100000baseDR2_Full);
+			caps = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
+			caps = phylink_get_capabilities(pl->link_config.interface, caps,
+							RATE_MATCH_NONE);
+			phylink_caps_to_linkmodes(pl->supported, caps);
 			break;
 
 		default:

I've superficially tested it on 2 boards (LS1028A-RDB and Turris MOX)
and I didn't notice regressions.

But...

> That said, 10GBASER and 10GKR are treated slightly differently because
> of the problem with PHYs like 88x3310, and I think it's now difficult
> to undo that bit of history.

I don't really understand this. Can you please show me where and how
PHY_INTERFACE_MODE_10GBASER and PHY_INTERFACE_MODE_10GKR are treated
differently in the kernel?

> > > +
> > >  		default:
> > >  			phylink_err(pl,
> > >  				    "incorrect link mode %s for in-band status\n",
> > > @@ -1109,7 +1124,9 @@ static void phylink_mac_config(struct phylink *pl,
> > >  
> > >  static bool phylink_pcs_handles_an(phy_interface_t iface, unsigned int mode)
> > >  {
> > > -	return phy_interface_mode_is_8023z(iface) && phylink_autoneg_inband(mode);
> > > +	return (phy_interface_mode_is_8023z(iface) ||
> > > +		iface == PHY_INTERFACE_MODE_INTERNAL) &&
> > > +	       phylink_autoneg_inband(mode);
> 
> Is this true also for DSA devices that use "internal" mode? I'm
> wondering whether this will cause the PHY to be ignored/remain
> unattached in DSA switches because of the changes in patch 7.

phylink_pcs_handles_an() shouldn't return true for those, no. For that
to happen, phylink_autoneg_inband() should also return true for that link.

Which I believe it never does, because prior to this change, phylink_parse_mode()
would have errored out with -EINVAL and the "incorrect link mode %s for in-band status\n"
text for phy-mode = "internal".

> > >  }
> > >  
> > >  static void phylink_pcs_an_restart(struct phylink *pl)
> > > diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> > > index 2b886ea654bb..7e8e26001587 100644
> > > --- a/include/linux/phylink.h
> > > +++ b/include/linux/phylink.h
> > > @@ -141,6 +141,7 @@ static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
> > >  
> > >  	case PHY_INTERFACE_MODE_1000BASEX:
> > >  	case PHY_INTERFACE_MODE_2500BASEX:
> > > +	case PHY_INTERFACE_MODE_INTERNAL:
> > >  		/* 1000base-X is designed for use media-side for Fibre
> > >  		 * connections, and thus the Autoneg bit needs to be
> > >  		 * taken into account. We also do this for 2500base-X
> 
> Thinking about DSA cases, I don't think this change would be an issue
> because where DSA uses "internal" there isn't a PCS, so this won't
> matter.

I agree, and also see the justification above.

> Note that as there is now no need for anything outside phylink.c to
> reference this function, I have plans at some point to move it into
> the .c file rather than keeping it as an inline in the header file.
> It was temporarily necessary while introducing it to be in the
> header.

Ok. Do you want me to move phylink_pcs_neg_mode() to phylink.c as part
of this series?
