Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4987B716A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjJCTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJCTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:00:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91DAC;
        Tue,  3 Oct 2023 12:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTNmfuU73dGdaUTEQMDSPlS8wvUcmtlR7GLnaEVPgDJhEKff9Xt6LjSg+GCGxDqafu8EcdlFp3dKu9wuy3JsBOO04+41n/aHNH0VjP6HqIVM6HBo5JN79mJqHABK50u0JmZn5c3VoVK3ufZY4y1PXvyqSdXXPUYNbD3SgKipopdcdjXYY4sf7dFNvY/MU7m0VLkkmoUVLM4HZXEFpQhcY8H1cYmCbPbhqUdpcXDoan1oDNAx4MHrSWLvXWgYZ//qThxd1/Xn7i0uc/Pcgux2HaRHCBemIVeeTJpjerEOZXo9pBzepTz2puPCLzTQzeBsk7fnVbTqGaFLkgnuItRinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K1YIBXLpiGiaPbBgTppXChGoM10jt0oyFscOiQ7AeM=;
 b=YgsCia3fZl5Wodt2Ll4wPKwemyBV9on3u29BkmVNTm585Bdw7rN0qjPYmm1BWLaFjakX0dKaNWyvcRIf8JpYRrdGAa3VJKyhBeCp9mAKaI8cbktc8jNPBYrbMTHuNQzBelyYQMdDI/0CVx+g0en6Rx4kZ5W/Vju5uZKmsIq2lqRSzMBlXhUkUtjCqhsA5zOn9TMMHkPx9uxBuXLpm+FReKmmwRiEClA+zoVR7k93IJKJCjTJg8ULGN9oW6iWvzvRb0bUyNkTpSZRGh0CrRrrG+gDl2t+qgfHoX8qHnuy7z37NyWR5jDTi8sCpmkT0px63TkO+hfvE6pfNMqbSffBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K1YIBXLpiGiaPbBgTppXChGoM10jt0oyFscOiQ7AeM=;
 b=MOpeM6UYof0XeaQxFpbMB9thCjK0Us2kkDVIrrqcLp927p+MaSwvfWPFYFRqSD6y0zOY1mhIdLkb/6wp8MI7UJ+d5jl9SX/5TKlGU1JxjSXEeqhPCNzF+cNhZutSfze/JisLnAWSq/q7nw/oS+LPZxLLUM6L6iALv1OgV6nw5iE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 19:00:16 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 19:00:15 +0000
Date:   Tue, 3 Oct 2023 22:00:11 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
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
Subject: Re: [RFC PATCH v2 net-next 15/15] net: pcs: lynx: use MTIP AN/LT
 block for copper backplanes
Message-ID: <20231003190011.jcpahazy3uqlz7q4@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-16-vladimir.oltean@nxp.com>
 <ZRwTwd18xWczDnur@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwTwd18xWczDnur@shell.armlinux.org.uk>
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: e3499f29-f438-4a39-da89-08dbc442faab
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RN9XBr2tNe3yJaJp24cYEBWkPxzWQOEl2mp+kFFODJ/gyh7tgsK1zGGhN+Zm0GlCsgSP8O4XubpSQP2HgOdfjGa2tmYDhFzlJSc+C7UdpM4ZOL2TXBL6fQn6DT05T+ofQ3f6vvU5ojgLEQhoPIhwpJ0W7zyEGvyIq3YQpKcrnTs+6OQqReAsXX9b3V2kzBjJ+ObCocxl3x0dlbmw8j9YYFvQOSSMRoQ5Ew/kMe6q10sWG7EXsjYf4qBcrKvv1SWnWCiakvRNPJi7B6f5JgOhK1G87yindvh2h0Ipvjbs1VFoB62FWF87FZF2xqeZClSBrY8PzSpz2XxF22YOB4jBRrIdJYEPAxMwLDgMxQjQ+3umv4dgHjHUae4v6697BG+1pMvKuF3qXqvRndY8JqJletkHrpHfnO8MEgDstpXC0eefC1T76eUDGWo5cIMNJdru9VRnXgSwF7xSwPDRLW5IBi5Pg8ffGtFLH9lPBf+nZwDfcHeZDjD5OiKdkVtT1TV3McbYjHJaHQNuZtFqdnTRra8nJEStsXjowONBcpYeRFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(44832011)(83380400001)(5660300002)(38100700002)(33716001)(86362001)(2906002)(6506007)(41300700001)(66946007)(9686003)(54906003)(66476007)(6666004)(6512007)(6916009)(66556008)(316002)(8676002)(4326008)(8936002)(966005)(6486002)(1076003)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDfwsjU2b22Xbf1U4SIjfswJObCxXcVyWwW/6eKKYjLrxxho9qIIHf0JwMHb?=
 =?us-ascii?Q?4PcCqxue5jh4EnI2tCvdGOKmqWkHgPeZweBpktZD9pb1P9hM40kpdgteGGnP?=
 =?us-ascii?Q?srHIpukvDp9Psmzc8lV8lgl/pNCW3DuTKLy8rb/OYvBIKQEerQAIHSQ6ixsC?=
 =?us-ascii?Q?3kQMAP5V/QiYzYUpzcsRukhibJMSZ/E+RMvscXJ1LsjlLm2bvcyhGHDPdal6?=
 =?us-ascii?Q?qmjen5R5nR3LJ/iZJ1t5bBq/5twMkr+UH4i6fccEaC9eTm6eScLieVc7WvfU?=
 =?us-ascii?Q?jG/nkHvxQ9uxzgAwT7OWz9edENNBarUVVBqpIJyCrZTytaHisVpUDTe0pcIK?=
 =?us-ascii?Q?HisTgMIXvUrrj2mOwGQ3jKK9RajO5lrJfU4UhG++oy/s90eVO7JghfMVP125?=
 =?us-ascii?Q?wBuosbsD/VTM8OP1rJ/VDdG65JLgU0jC6JreIkz1zbkveSQ54HmOtMB3U9KV?=
 =?us-ascii?Q?Exwfu+7PcgmWYcwj3kLpOqYxxPc1l5Hepjbk5dW62jzMXPEqpxfgs0dJY/Ll?=
 =?us-ascii?Q?oramdCwb3gVQOCUPCNoLIs6cWfb+wIIRYg/ysvDYLx3wxVSaTzLHQ+oa8byd?=
 =?us-ascii?Q?e/JYHUvmh1Pl+kPzrwtCg8AriK8IZXCnN0pwmlIuQuJCPouUHTmYXflQOjoO?=
 =?us-ascii?Q?ELeFxOAUCN/+QT0u1F/YwUW3cP/1sfmXgdpJTLraQWObaFUiQqzG+/hUxVNs?=
 =?us-ascii?Q?bo1UPv1TQTfG6Zvt41sLGK/Ym5MqPdg+DXvgDOiJn8U0kLIjR/AwSAMJh9PY?=
 =?us-ascii?Q?GpCaWRCruspULvr/tC8hxKHLaACYnSc1fDjutd+UTLK5X90diG6aiqyryKUw?=
 =?us-ascii?Q?gwFJIgKGOgR+o/bmPJchG0+BjzKYYti9udftopCpi0/fZR3TwwgtD/swsDNH?=
 =?us-ascii?Q?gR0j3aMD8+JjrQu1tR7CdT4rkVWIbobUAnfcL56eJmgKN3LYHM8w5Hu0uemY?=
 =?us-ascii?Q?7WdkLcF8fEOie19k2p8lOh/Yu2WVk2eP3a7j4mt51Vod0f4ZU6dzE9DztWk1?=
 =?us-ascii?Q?vtOR3PUR5N2aQlxwD9+ZbJOGydAODkexFmUhGpc+nNakxkkbjcfc2XMz/YLJ?=
 =?us-ascii?Q?tO/MuLl63tWJScwQdqBMxLkCGTDuymGJGjNS4dgMhmjHLTmyXACsl3qkD8Ti?=
 =?us-ascii?Q?E+xnpeE74cn09wpn4i/rkWnkIvfU89jBYOA6TWaVim7qv/X1Dol8KEnbRvok?=
 =?us-ascii?Q?BUTdpEOwt1t7wTpbaKu+mLoeorMXpjGhUFAHZb7W7MZO+OtO7DBYD+B8yhDt?=
 =?us-ascii?Q?b25h4VjXbtCxAi5hhCRzUiKW92LWW1uawGNur9dZ7g7qGHAWLo3kt9YDEwY7?=
 =?us-ascii?Q?AH+V2urtJlRAaEmyxHmlFSTHc2ewy7fHBJEOY73VA29wsAO6mbaidjovH2JF?=
 =?us-ascii?Q?PVVQsdDbjHZWolueTrC88kAuZOtejzfCCirioRThzdZ3IfpfvNpO2cJC4g1J?=
 =?us-ascii?Q?eKXEh/FGe1sLvCcHTf1DGRE+JgGoKy8QaLPcUDUO/zRzkmsctVKjGD/CJ0vj?=
 =?us-ascii?Q?kuEzpKH7aZoX/TTe87Xij0ttvV7dOx6WvXpyvD+9igu8+HqiHCM+29mtWa7y?=
 =?us-ascii?Q?Zxa2HJiga/v7EwaA3zaFHZZYR9/S5YeOZWUdwDbVE7qcQ/jc2X9GOIpYWM9T?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3499f29-f438-4a39-da89-08dbc442faab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 19:00:15.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVAs5QEhdbocHkD3lvV4RWjut7gw8ydI5IVJPpJEzgOHgVSeKzgTtD4QZE77e1GcSjz6ZPGBzsPwRUYfiVdWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, Oct 03, 2023 at 02:14:41PM +0100, Russell King (Oracle) wrote:
> On Sat, Sep 23, 2023 at 04:49:04PM +0300, Vladimir Oltean wrote:
> > +static int lynx_pcs_parse_fwnode(struct lynx_pcs *lynx)
> > +{
> > +	struct fwnode_handle *node = lynx->mdio->dev.fwnode;
> > +	enum mtip_model model = MTIP_MODEL_AUTODETECT;
> > +	struct device_node *np = to_of_node(node);
> > +	struct mdio_device *mdio = lynx->mdio;
> > +	struct device *dev = &mdio->dev;
> > +	struct phy *phy;
> > +	int i, err;
> > +
> > +	if (!node)
> > +		return 0;
> > +
> > +	lynx->backplane_mode = fwnode_property_present(node, "fsl,backplane-mode");
> > +	if (!lynx->backplane_mode)
> > +		return 0;
> > +
> > +	if (fwnode_device_is_compatible(node, "fsl,lx2160a-lynx-pcs"))
> > +		model = MTIP_MODEL_LX2160A;
> > +
> > +	lynx->num_lanes = of_count_phandle_with_args(np, "phys", "#phy-cells");
> > +	if (lynx->num_lanes < 0)
> > +		return lynx->num_lanes;
> 
> Is it possible for ->num_lanes to be zero at this point? If that is
> possible, then ->anlt[PRIMARY_LANE] will be NULL but ->backplane_mode
> will be set, so won't that cause the mtip_* calls above to pass a
> NULL pointer into those functions? Is that safe? Should we trap that
> case here?

Assuming the dt-bindings as proposed here, that case would be an invalid
device tree ("fsl,backplane-mode" present but "phys" isn't present),
which I indeed failed to catch.

But in my reply to Krzysztof here:
https://lore.kernel.org/netdev/20231002121958.xybzovgjzldfiae2@skbuf/

I said that for v3, I'm looking to move the "phys" property from the PCS
to the MAC (it's already in the MAC for the non-backplane use cases).

On LS1028A (ENETC, Felix), the lynx-pcs is not OF-based (we use
lynx_pcs_create_mdiodev()), but it would be good to support the
1000Base-KX link mode there also. As I'm starting to look beyond
LX2160A, I'm starting to see why adding extra dt-bindings to the
lynx-pcs (both "phys" and "fsl,backplane-mode") will be problematic
if there is no OF node to speak of.

I will leave a separate comment with some new ideas.

> If that's correct, then I don't see any point in storing
> ->backplane_mode, since we can then use ->num_lanes > PRIMARY_LANE
> or similar instead.

Well, in v3, my plan is for the caller of lynx_pcs_create() (aka the MAC)
to always pass an array of phys (the ones from its own OF node). In that
case, we would indeed need the "fsl,backplane-mode" property in the PCS,
because otherwise, with your proposal, the PCS would instantiate the
AN/LT block even when it's not expected.

> > +
> > +	if (WARN_ON(lynx->num_lanes > MAX_NUM_LANES))
> > +		return -EINVAL;
> 
> Do we need to use WARN_ON() here, or would it be better to print a short
> error-level message?

Admittedly I may not have the best intuition here, but I didn't want to
over-complicate the code with error messages that can only be triggered
with invalid device trees.

> > +
> > +	for (i = 0; i < lynx->num_lanes; i++) {
> > +		phy = devm_of_phy_get_by_index(dev, np, i);
> > +		if (IS_ERR(phy))
> > +			return dev_err_probe(dev, PTR_ERR(phy),
> > +					     "Failed to get SerDes PHY %d\n", i);
> > +
> > +		lynx->anlt[i] = mtip_backplane_create(mdio, phy, model);
> > +		if (IS_ERR(lynx->anlt[i])) {
> > +			err = PTR_ERR(lynx->anlt[i]);
> > +
> > +			while (i-- > 0)
> > +				mtip_backplane_destroy(lynx->anlt[i]);
> > +
> > +			return err;
> > +		}
> > +	}
> > +
> > +	for (i = 1; i < lynx->num_lanes; i++) {
> > +		err = mtip_backplane_add_subordinate(lynx->anlt[PRIMARY_LANE],
> > +						     lynx->anlt[i]);
> > +		if (WARN_ON(err)) {
> 
> Again, does this need to be a backtrace-producing WARN_ON()?

mtip_backplane_add_subordinate() will only return -ERANGE if called too
many times (more than MTIP_MAX_NUM_SUBORDINATES times, aka more than
"MAX_NUM_LANES - 1" times).

Given the way that the code is constructed, it is technically impossible
for that to happen, but only because MTIP_MAX_NUM_SUBORDINATES is
hand-crafted to be 3 and MAX_NUM_LANES to be 4. I think that if I define
MTIP_MAX_NUM_SUBORDINATES in terms of MAX_NUM_LANES - 1, I can simply
make mtip_backplane_add_subordinate() return void.

What I want to avoid is to add error handling for errors which cannot
take place. Which is where the WARN_ON() came from.

> > +			/* Too many SerDes lanes in the device tree? */
> > +			for (i = 0; i < lynx->num_lanes; i++)
> > +				mtip_backplane_destroy(lynx->anlt[i]);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
> >  {
> >  	struct lynx_pcs *lynx;
> > +	int err;
> >  
> >  	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
> >  	if (!lynx)
> > @@ -327,6 +451,12 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
> >  	lynx->pcs.neg_mode = true;
> >  	lynx->pcs.poll = true;
> >  
> > +	err = lynx_pcs_parse_fwnode(lynx);
> > +	if (err) {
> > +		kfree(lynx);
> > +		return ERR_PTR(err);
> > +	}
> > +
> >  	return lynx_to_phylink_pcs(lynx);
> >  }
> >  
> > @@ -392,6 +522,11 @@ EXPORT_SYMBOL_GPL(lynx_pcs_create_fwnode);
> >  void lynx_pcs_destroy(struct phylink_pcs *pcs)
> >  {
> >  	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> > +	int i;
> > +
> > +	if (lynx->backplane_mode)
> > +		for (i = 0; i < lynx->num_lanes; i++)
> > +			mtip_backplane_destroy(lynx->anlt[i]);
> 
> Won't ->num_lanes only be non-zero when ->backplane_mode is set, so
> isn't the test for ->backplane_mode redundant here?

I think it won't be redundant anymore once the series reaches a less
"WIP" state.

> >  
> >  	mdio_device_put(lynx->mdio);
> >  	kfree(lynx);
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
