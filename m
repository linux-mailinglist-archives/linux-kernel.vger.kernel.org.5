Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303678300A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbjHUSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbjHUSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:14:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18AD10E;
        Mon, 21 Aug 2023 11:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH5lLd5G5zv/jg/HCmaFgzZ7DisW5bAO2fwMbtahAHjyJtJB1+Qp1QCrsceVBmQEq2cX0S+kverRYLewP8f+y8BUb82T4h4nRB/rxWhz82mTPhHNhP+CSjiDFLvRtD4ymGfczQdHDYFLNcPFTD1yHm4EPuwpZ/dmI5uIdUJ2LRCHq5q3ZDeWlwDLdQVP/raj4oPP8p3wAdacghZIHGLxJNN9gB6IIcv8AzRt/JP1rgkRHnnlrHd4Q/SsxglBKdYs9Di+W3Z1t6KMfPUWSHrYulQvoEc28xMhjEk7ItrcHCDWwhXSjERrPngEwACqiPm+iC0rzvTOR1C84XWIu5OiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJAW5hjZFPKXjr4Ef8g8Ya3pB//VHZXKmLUp/pH5Bfk=;
 b=h9LtM1na5orXntWqinQeX6DOV7p+On6zTvu0gosWXXNsWbUwBExLv1MvSwvJNw77I+nH3RhqawQH5Csz11lhqoYzN+YdhpdXv/m4L7Mwz+hM2qV9eUtcWXMiAmGI266BQywPsa3WsbOmjVkiBA5tBDPzwHs/6XEPDoAxHGeBSBavAg/TOhHpCZMTKZtdMCuKXbz23Qj8xAfRkpUL585qIJN/iLJDOY6ddh1B9LCmpcGEhEdfnYFtNyTC4elOTIHBDHnM4q7nC/GygWvoyITAwS0upQkLxfkj7yGH7gyCL8VxLUq46Qw+R4s8Ij2ByBagpZsPaTjU0hOHzW1Ve322Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJAW5hjZFPKXjr4Ef8g8Ya3pB//VHZXKmLUp/pH5Bfk=;
 b=OKXiXHlgjrKqp5OrXOkWODs0kQyxW1tOEn/f66T71kE/t4io+tEo190D/ANflcVB3jgRPpYWsxA78cwF1XE9FdK5RTC5O3fhoJXUyMuWbB2CIPOT9UJvg4M75CzjPV3ukzWKyXr/El6kDaz/fkQL6Dj/H+n1A5HQ9Lfx15Y9Y48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:13:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:13:54 +0000
Date:   Mon, 21 Aug 2023 21:13:50 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 2/8] phy: introduce the
 PHY_MODE_ETHERNET_PHY mode for phy_set_mode_ext()
Message-ID: <20230821181350.akn5mir2woj2ioke@skbuf>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-3-vladimir.oltean@nxp.com>
 <2c8cb48c-5b0f-5712-8c50-ea285df829ec@seco.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8cb48c-5b0f-5712-8c50-ea285df829ec@seco.com>
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf2dfbb-8a44-4ee6-028c-08dba272610c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tbg5ZjxzUmxbIBhKaFd8+k662j8v4eEM56sl/J+LRoGQTQXuRfXR0LG2F1/wVTMEXnc3J1trGo2+EogM9BIUeJBT4yYw55q8qyngTWPTPBaJ4nVGKy7sQ7g4waM7qYpfL46ppXD/MeiZ8n5EMwT0E2SXF68f41D3UtD2qaVc3qYL2YRhllOqo+JmiA6Kt2xjEXu4QPNnIfcKf6R/+wtTk+6YO4xAZ0flgq7A4sL0ZNWMDciPsiFxW0deVcR6kjWTaKd1gdJWBlX4K9Nu3UBIq7gLXbuggwvULK9PVa4ofOqMs7VHepGKdFRDSIfv9pi3DQ+eQsttO6byA+N8O9mILLZl2cHq8KHv+LohFkH7FIxRzIlZpa5orQk6u29kUq6PScO0YIH+z+YtGs7c/gOV0aVXB8H6uon+jfbs2IZoCc4a5lG10ayrYzbRbfl4qGOzoxokv9ggHY8aDaenOQdR01vdXa8SWT4KcjW2hULriuJllUshtKGQinA+N2USo3cWb+E4S2zcYeOJLYCT/RKH8ZcKSFVE02n9SiIgXFF+Pd4gm/W3CH+jenhIiTQoQmkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(8676002)(8936002)(4326008)(1076003)(33716001)(41300700001)(478600001)(19627235002)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpTIKJRwAnvo40WREUICZBxqA4YOaVrItBNZ0l4xtCMIIqV9eWCZK8O+YixQ?=
 =?us-ascii?Q?ZZvZ5Gjt0MSzahza/q3VusqhdXl4iLh34sjdY4XMtuu5p4a+K7ZjZNx0kcGI?=
 =?us-ascii?Q?vCY/kzEP5D9GaXgZ/CEWsU5LJZS7wiKZmLbpMYlnFcUdhSBtqlnHyexvNAkJ?=
 =?us-ascii?Q?iF5dP2OGDlOwj3N9lDERYEGlgdUVPuXOezXNgSnxqx7Kdv43KEnFl5TuAqcR?=
 =?us-ascii?Q?WmS+LURq3VDPolw+fI952R72N3uQK+v0hbRtF6mqfXXkZVUWKNpZmFRTyS/B?=
 =?us-ascii?Q?F7OOb1evPhWd5jNl8p7LsEyOLNpiCQ3PpvoUZWyFTb/S449me0vfwkrXtSVS?=
 =?us-ascii?Q?qG6nQxlyIVjq/W5cvVKZIbgcuvvK29/eklTrWHq1BaNiqdfmM2Tg59D+1b6E?=
 =?us-ascii?Q?4UeDblfvtUhCjG/pr/6pGJ0LYwPcUrqCrAhbUo9SSctQOcmT38hKVCpMhOHg?=
 =?us-ascii?Q?cqNuh44/ccFUIs5EFgN1J2z0FUj1SbTAPJXKfWm5NEhKCmvPr2kg6SoYhBAf?=
 =?us-ascii?Q?ieRFy7FVdv5CEKQgmHUuW265+GjU24bUj5REkgb1vnn0FKeiKMPh2u5/XUvV?=
 =?us-ascii?Q?rCGsfkN9IxkX+EoF7ZnkMbKNe5+i5G8/OGDjggswGmaBhQwV5W6ZsCtkULqC?=
 =?us-ascii?Q?My6I0CMjcumCnFZyi2Pz69mldeTeQ9tcEI/EvUyzZ5rlEwiwuZwWu0bomTQE?=
 =?us-ascii?Q?vLzc9RsFDxnqL1V1swjJXwJAbIm1ZhexxT8OpsD6gYaeJbBHT8RXc2sv/kHc?=
 =?us-ascii?Q?NrXXoNNoOIFwBsmtMMYz8mKbqKC0PP7zvdA7diyBt2K3jwj1AvQiMjksu4nO?=
 =?us-ascii?Q?QKD19nlKn0231LK36IiWcHCWonBw8lvjgV5fA+7JPnpgRt39IRbs1qhhoB+p?=
 =?us-ascii?Q?Nv/8/uJyEQFcl6qCLw/NGR78SrM49ge9icz9huepwkX2mcCsW03VpJxgPpyr?=
 =?us-ascii?Q?At3YMbTP9BwcNoSqlI9FH/6RbEK3DihnAZyT83lGwq+Y44k5aePcl21qF7I2?=
 =?us-ascii?Q?eax7wO9NX8mIgAM8sUro2CMc5s/cQver3ncvzGemBr9Jnl1WzQnyZx6o/b0N?=
 =?us-ascii?Q?Pbgc7DR2SOjfjJDLySMZQGEZqglOSDE5XxvFdpNcWgo5hwL0v74YjzuzY1+P?=
 =?us-ascii?Q?AROnGBWd3jEcPVIdzhoHqF50XiQ4axXehH2r15ghx9pogTZdMlQs7qdahIey?=
 =?us-ascii?Q?Y4ay/Kau4cmlO2HCw0Ps6nA8erHzpgkolCnyhLKMJ7r/SqzS1G+jG1Tc5YEt?=
 =?us-ascii?Q?JF5qP3Q/cT9x2Gh2Por2FiEJCYb1Tn07EdvkX9mUwjk/PR64eU11gm5iGDd8?=
 =?us-ascii?Q?kwcECAv5933GThK+a5wCm8y1XamrC7cej1NnqQSCjcaxs7TRAWoEsaUweL4e?=
 =?us-ascii?Q?qxKlZlQuALzyoZMMJfqrLPL8s8daLE+mSU6TakqY3/dRf7JKii6UaTTGTYsb?=
 =?us-ascii?Q?DwHRnOlvj0imEtW9c7rhH3DXPQSPvu8uzY3beyAlpL3T8wwxsUPdUU0nIqKf?=
 =?us-ascii?Q?pYzdWVjrRj5FTF2pDPiPl0XGjXNuebL9HI9mEkilxgXS4u0lAaA5SshKpFKz?=
 =?us-ascii?Q?GYDwlf+LUR2CpiCFlpUq7kVSkz45UasDGeiWi0P+C2q1MSH8F9cqsh5I4Zc2?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf2dfbb-8a44-4ee6-028c-08dba272610c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:13:54.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj5pxyznjiL18bonQR2pX9eJY0cSKxpk1fVD17rkv2rF0K10if4LlRsmQ2FagjIP76GlW9Fdq4D6impfSA4+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Mon, Aug 21, 2023 at 01:30:46PM -0400, Sean Anderson wrote:
> On 8/17/23 11:06, Vladimir Oltean wrote:
> > As opposed to PHY_MODE_ETHERNET which takes a phy_interface_t as is
> > expected to be used by an Ethernet MAC driver, PHY_MODE_ETHERNET takes
> > an enum ethtool_link_mode_bit_indices and expects to be used by an
> > Ethernet PHY driver.
> > 
> > It is true that the phy_interface_t type also contains definitions for
> > PHY_INTERFACE_MODE_10GKR and PHY_INTERFACE_MODE_1000BASEKX, but those
> > were deemed to be mistakes, and shouldn't be used going forward, when
> > 10GBase-KR and 1GBase-KX are really link modes. Thus, I believe that the
> > distinction is necessary, rather than hacking more improper PHY modes.
> 
> 10GBase-KR and 1000Base-KX are both electrically (e.g. link mode) and
> functionally (e.g. phy mode) different from 10GBase-R and 1000Base-X due
> to differing autonegotiation. So the phy modes are still relevant, and
> should still be used to ensure the correct form of autonegotiation is
> selected.
> 
> That said, I do agree that from the phy's (serdes's) point of view,
> there are only electrical differences between these modes.
> 
> However, I'm not sure we need to have a separate mode here. I think this
> would only be necessary if there were electrically-incompatible modes
> which shared the same signalling. E.g. if 802.3 decided that they wanted
> a "long range backplane ethernet" or somesuch with different
> drive/equalization requirements from 1000BASE-KX et al. but with the
> same signalling. Otherwise, we can infer the link mode from the phy
> mode.
> 
> --Sean

Thanks for taking the time to look at this RFC.

I will ask a clarification question. When you say "I'm not sure we need
to have a separate mode here", what do you mean?

The lynx-28g implementation (not shown here) will need to distinguish
between 1000Base-X and 1000Base-KX, and between 10GBase-R and 10GBase-KR
respectively, to configure the number of electrical equalization taps in
the LNmTECR registers, and to allocate memory for the ("K"-specific)
link training algorithm. Also, in the particular case of BaseX vs
BaseKX, we need to modify the PCCR8 register depending on whether the
C22 BaseX PCS or the C45 PCS + AN/LT blocks need to be available over
MDIO.

So, passing PHY_INTERFACE_MODE_1000BASEX when we intend 1000Base-KX is
simply not possible, because the dpaa2-mac consumer already uses
PHY_INTERFACE_MODE_1000BASEX to mean a very different (and legit) thing.

Do you mean instead that we could use the PHY_INTERFACE_MODE_1000BASEKX
that you've added to phy_interface_t? It's not clear that this is what
you're suggesting, so feel free to stop reading here if it isn't.

But mtip_backplane uses linkmode_c73_priority_resolution() (a function
added by me, sure, but nonetheless, it operates in the linkmode namespace,
as a PHY driver helper should) to figure out the proper argument to pass
to phy_set_mode_ext(). That argument has the enum ethtool_link_mode_bit_indices.

So, a translation between enum ethtool_link_mode_bit_indices and
phy_interface_t would be needed. That would be more or less doable for
1000Base-KX and 10GBase-KR, but it needs more phy_interface_t additions
for:

static const enum ethtool_link_mode_bit_indices c73_linkmodes[] = {
	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
	/* ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT not supported */
	/* ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT not supported */
	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
	/* ETHTOOL_LINK_MODE_25000baseKRS_Full_BIT not supported */
	/* ETHTOOL_LINK_MODE_25000baseCRS_Full_BIT not supported */
	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
};

I guess that network PHY maintainers will need to chime in and say
whether that's the path forward or not.
