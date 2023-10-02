Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFE7B552A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjJBOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbjJBORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:17:54 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA028B8;
        Mon,  2 Oct 2023 07:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmVtV1rkK2tm1a6Yn03WG6rxQaWMtwijDS5+GbjQNS+H2q7s48oFQP9BqF1uBdwSEpZ7q5Q2fbxiIPFNrvCZBQiVMWwXT+lcSsNjfTm/0GoPN5Zoopcqgf0JZRGLxZ+Fwn/X4D4wTVnTIpX8fpR0Hj/BO8tICdsRsiy3mLUWy/EEpg8Py8W8I/26izrfA72ZfTJ7LUMhEMlRhwGuEirBRhOO372jZJoWmj/ElW0iIfpAIcgERFXDyH6qvESXN0ZeaGr+C27siV6M7qRfV12jOS3aIGXngonoALXTAIKOX7c3eTUZL4m4D+6RErRamg6cAgwpMm44rkeXnM9aTqig9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkW5rQEpz9ByPpH0Ovd5WBwSu3H5nZ9FRIsaPdpQW30=;
 b=TGsjoGQLT4KMYGCGu0VpILHtIV5Uq0PzVP+mPABH2gtJG4j57duXeoHIF1SqNs4JclWGTR6z7Q2AeZU+3WbjBbpD6XRY6Wka5I9FaiJLJCh08P2hTyRAjjPAtghPMqOOJVm1HptddP9aOvcO4BH028fO+CJ7h3fFhVlzL2lwZjYunXe6Qv4JDBquBIYKe8RqTXhUrwjpkg0akNrm9huSifBGDmh46cqyOg5igiuQc5SMP6xyrophge5TZnoByEkSMc8toAfiiqSr3CfWbUUJbjFaT9Iv5e7yLf4sIBypV5IOi+3MlZEKHNflXsT7SUTNz/ygZRAjs8Rn4NlhkSVhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkW5rQEpz9ByPpH0Ovd5WBwSu3H5nZ9FRIsaPdpQW30=;
 b=VMFGmu6n06c5dyVIAK2/I420jOt8m2zF1PM93BumQKPHF8YKkAEbZX+9EsksxUIh0fDqr+8xGcOWEEMtNRLIzLhHC2ZjN2hP8l6Mh1CvqsK+HGojNH/A6E2kQW6G5sZr6gwAq+g43y+4JTECKqxiJBLSKgQiDLFpPyT07wFNzR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 14:17:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 14:17:47 +0000
Date:   Mon, 2 Oct 2023 17:17:43 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Message-ID: <20231002141743.lbmb66q22dmuyi6f@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-9-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-9-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BE1P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e852864-3730-4902-991c-08dbc35259ff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLINLyk0ecOXMr+KT6e7mO7/8lKjO34Tv2I1OLxe/13YwtEVH6i73HSzNtFA/bfYCA9IbXpj4dOns5MC0ehO8BAP+e9vWChnpQ0weMs5t1aWxkISA9OfMqZMycc/iGrppU+bPWBLGFZMY4oOym2MfhNn7eD1RU9oqcrzbhPd5TSzNUeoL3pQyLuDWEwro8niFzWbeZZEczki3Ol+HjTQKmiapIDUuw+6c/lzppMrMenKvKUafMNRZhT4sLp4bKn4Ro8G9hb4nHVVhhmKtWF+xHtRhE0SSI+Iqtd+S5Q0S7QrM1p74l+PXI7SQw7AMFZ6rHaSl5YuvlvokRUx4B0IotWOvS4EvKyHp7lmyQPWkhbdaiTFL+yhgnF1PUMK3R52f/RRCK03yC4lI9LoATaWT30jk8Qsg/gUfjohqidly1xSubFk2DDDybilpsFIhgBTKMdNjAnwuGTzS7u6J2gSjSljRPq7IJMQAh8sWlL40szYVS77TZdan1Q6RpuE7OWgf+QO0HsO3f9Sf8KwMqcdMwKTUa1xQQ7G4H2tZrkE7s8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(9686003)(19627235002)(4326008)(1076003)(38100700002)(86362001)(83380400001)(2906002)(7416002)(6506007)(478600001)(6512007)(8936002)(966005)(316002)(41300700001)(6666004)(8676002)(44832011)(33716001)(66946007)(6486002)(54906003)(66556008)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nm+WNycursyGMmuqogr404BbmbGYImxbq55Nh/IheJ7rH1CpP+0OGQL8ywJY?=
 =?us-ascii?Q?TolEgSbZoyabmXWNTLvvv/tpgaZOnLfZwNvDD3TQqkQXcUvduMfjTwN4qelm?=
 =?us-ascii?Q?xhGPXy2rWrgElHG/OR5EEAisrGHmlss79+5Mc89TueEWRrWknTaXTKHWC+bt?=
 =?us-ascii?Q?Y6EXtlI6v0tQoDW1d631EEDu1TjvxaDmmmf1FUP4Et2eeUCYUQOYl8EUxNq2?=
 =?us-ascii?Q?HZ6rpSTGYp6GXuKzAo5TGL93Uvk+K2o844wQn4Kpumc5GIG6AtE+G4EHyPJ7?=
 =?us-ascii?Q?fWaeV5zGhczhzSo49Jvnh17sP49lxt7ZgXz92E0g+zWXQq4IccL74C/BysVR?=
 =?us-ascii?Q?vZ5rcjCQewPSwqkK/lHxut/59YFrB89ilB2PRBrOmM6xmcV1SrN0pK7oEY1m?=
 =?us-ascii?Q?7mK2pHjKlHdvhNkxbLffXWW0OSaLwBz96NZC5xicK7w74FhKuP9aY9AirrCQ?=
 =?us-ascii?Q?vnwHMs86qStOORhZBHQcv6Ks+rWYnXrvRH1MX+04S/yB15J6LrRVP4KBDrIX?=
 =?us-ascii?Q?r30YAZIZhT54d/L6U1xR2CtTaEyvDiLya9IitJH9TZcAIZ8Sehjp4xiiVScR?=
 =?us-ascii?Q?Fhq5WGyF2c/8pyYo51mYJlswB/39PqMcyXSMhLVqt5eZc+AURPYq5Pw50O8B?=
 =?us-ascii?Q?E+6xTqaGAa8kte1Pje9byDQfw3yebAX8nKj6B1FGNaSAVevVv/NxRjmVdU9F?=
 =?us-ascii?Q?akhSd0g0lXlaj1q5D5dEoaiYl3o/jAKSA3JBp/7Y0dL/5DIJh4gyoIC8JxN5?=
 =?us-ascii?Q?rZD4AI+SnHG3osBOFE1s9Sl32dpxH75ASyGuZN/FDnCQpIc6uK1RsGQr52od?=
 =?us-ascii?Q?sza7FaTzl7DQnhmZQS6UXzc4bg7Or9BRVTv2Zys2ihNBKLhxoZUiALVDZsVo?=
 =?us-ascii?Q?mUx+A/JmFSwW6xWNucgmZwv6/szdollQbervatgX1Sjx3hobja5NviIr0FXn?=
 =?us-ascii?Q?YXVc5OvzhENI0MMqIJ+fJhdMxQxGf4NDduKhfkLLBBfYKUu18+sFtsqJFMAY?=
 =?us-ascii?Q?Rqw9Lp26dtVSlCMbC2XVl2aBdi7joT/wXHlDAatsUW5wvkB9LEnqpK1CRXxL?=
 =?us-ascii?Q?K03LaGR0/wjUVpye/J3KXaJOjHp6FIHHq6k/waLVKlUUf1WtfKZFYbG0fOj2?=
 =?us-ascii?Q?Kg3DdHfxpOrKK3GOX7+INzcPfa17xA8QEv8lHv8c1ao+g/ObwwYD7FOxg6Gn?=
 =?us-ascii?Q?jddQdJoiIuQ5feQgMVpfCHNFzOrpzmn+ofd3Lj+sCzVnE0f0gJ0PbawawHri?=
 =?us-ascii?Q?mtIDYMRIgnYqjHDtAJ+n1P73aglgafm8oLiWo/B3AE1ULgwg7lE2YVTXPT+P?=
 =?us-ascii?Q?+rOja1eBz6P3++IGrjaCcLq7pTTIEkUV2kiP+68WW+yQy7EcRXtAoZ2CdrIz?=
 =?us-ascii?Q?Faf/8bH05UvRebqAHMWKnGJfEj+2DrGiYTBeuK7cDigSj8mbMBxsYL4N3z4U?=
 =?us-ascii?Q?tbfgz/1F8tcZ1Qcy9w7LYXUnsZdzh0JYHHWeW/aTTC0iHwni7HojLaRWR/F8?=
 =?us-ascii?Q?n5se9bMU6fAAWIrzQ6ZvvCC34WdyzTpna7hHBAO2SA/AEfxPl2nTvIz2LkQ4?=
 =?us-ascii?Q?zoFifWDsg0P6fB++4H3rKbhVpBhFXmshlFj+y6oBFklsslJNaEXELSbmC7yb?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e852864-3730-4902-991c-08dbc35259ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:17:46.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwdxKyNADi6P5RaipMkyHAF8jK6CCT0YWXZg1tEs591lmtQuXeCJPU22naheRJrS+6iUXNu8jbui1ihfCAlmww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241
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

On Sat, Sep 23, 2023 at 04:48:57PM +0300, Vladimir Oltean wrote:
> Some phylink and phylib based systems might want to operate on backplane
> media types ("K" in the name), and thus, picking a phy_interface_t for
> them becomes a challenge.
> 
> phy_interface_t is a description of the connection between the MAC and
> the PHY, or if a MAC-side PCS is present, the connection between that
> and the next link segment (which can be remote).
> 
> A MAC-side PCS is so far considered to be a PCS handling link modes with
> optional C37 autoneg. But C73 autoneg (for backplanes and SFP28 modules)
> is not at the same level in the OSI layering, so that existing model may
> or may not apply.
> 
> (a) If we say that the PCS is MAC-side for C73 modes as well, the
>     implication seems to be that the phy-mode should be one of
>     PHY_INTERFACE_MODE_10GBASEKR, PHY_INTERFACE_MODE_1000BASEKX, etc.
>     Similar to PHY_INTERFACE_MODE_1000BASEX which imitates the link mode
>     ETHTOOL_LINK_MODE_1000baseX_Full_BIT.
> 
> (b) If we say that the PCS is not MAC-side, but rather that the
>     phylink_pcs represents an entire non-phylib backplane PHY which may
>     negotiate one of many link modes (like a copper phylib PHY), then
>     the phy-mode should probably be one of PHY_INTERFACE_MODE_XGMII,
>     XLGMII etc. Or rather, because there is no MII pinout per se and the
>     backplane PHY / phylink_pcs is internal, we can also use
>     PHY_INTERFACE_MODE_INTERNAL.
> 
> The trouble with (a), in my opinion, is that if we let the phy_interface_t
> follow the link mode like in the case of Base-X fiber modes, we have to
> consider the fact that C73 PHYs can advertise multiple link modes, so
> the phy_interface_t selection will be arbitrary, and any phy_interface_t
> selection will have to leave in the "supported" and "advertised" masks
> of link modes all the other backplane modes. This may be hard to justify.
> 
> That is the reasoning based on which I selected this phy-mode to
> describe the setup in Layerscape SoCs which have integrated backplane
> autoneg support. The changes in phylink permit the managed =
> "in-band-status" fwnode property to be extended for C73 autoneg, which
> is then controllable through ethtool. With phy-mode = "internal" in an
> in-band autoneg mode, we advertise all backplane link modes. The list is
> not exhaustive and may be extended in the future.
> 
> Link: https://lore.kernel.org/netdev/ZOXlpkbcAZ4okric@shell.armlinux.org.uk/
> Link: https://lore.kernel.org/netdev/ZGIkGmyL8yL1q1zp@shell.armlinux.org.uk/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: patch is new
> 
>  drivers/net/phy/phylink.c | 19 ++++++++++++++++++-
>  include/linux/phylink.h   |  1 +
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 548130d77302..88ace7e203c3 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -972,6 +972,21 @@ static int phylink_parse_mode(struct phylink *pl,
>  			phylink_set(pl->supported, 100000baseDR2_Full);
>  			break;
>  
> +		case PHY_INTERFACE_MODE_INTERNAL:
> +			phylink_set(pl->supported, 1000baseKX_Full);
> +			phylink_set(pl->supported, 10000baseKX4_Full);
> +			phylink_set(pl->supported, 10000baseKR_Full);
> +			phylink_set(pl->supported, 25000baseCR_Full);
> +			phylink_set(pl->supported, 25000baseKR_Full);
> +			phylink_set(pl->supported, 25000baseCR_S_Full);
> +			phylink_set(pl->supported, 25000baseKR_S_Full);
> +			phylink_set(pl->supported, 40000baseKR4_Full);
> +			phylink_set(pl->supported, 50000baseKR2_Full);
> +			phylink_set(pl->supported, 50000baseKR_Full);
> +			phylink_set(pl->supported, 100000baseKR4_Full);
> +			phylink_set(pl->supported, 100000baseKR2_Full);
> +			break;
> +
>  		default:
>  			phylink_err(pl,
>  				    "incorrect link mode %s for in-band status\n",
> @@ -1109,7 +1124,9 @@ static void phylink_mac_config(struct phylink *pl,
>  
>  static bool phylink_pcs_handles_an(phy_interface_t iface, unsigned int mode)
>  {
> -	return phy_interface_mode_is_8023z(iface) && phylink_autoneg_inband(mode);
> +	return (phy_interface_mode_is_8023z(iface) ||
> +		iface == PHY_INTERFACE_MODE_INTERNAL) &&
> +	       phylink_autoneg_inband(mode);
>  }
>  
>  static void phylink_pcs_an_restart(struct phylink *pl)
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 2b886ea654bb..7e8e26001587 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -141,6 +141,7 @@ static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
>  
>  	case PHY_INTERFACE_MODE_1000BASEX:
>  	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_INTERNAL:
>  		/* 1000base-X is designed for use media-side for Fibre
>  		 * connections, and thus the Autoneg bit needs to be
>  		 * taken into account. We also do this for 2500base-X
> -- 
> 2.34.1
>

What do you think about this change?
