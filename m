Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA340777665
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjHJLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHJLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:01:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C0F92;
        Thu, 10 Aug 2023 04:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDWQQfMPaBAo5Rf1tyJ1DHE83cORz3ebWF3LrlCKNHnuxcJjKdF7bT/brs4Gcf2Nm6jpLdFKTav+VZLWD/FXVmAKFcC/MrjjXQmJJu5Csm67hCACZRGcQpwhZ3BfhaKuj93VO5gzBF6AXZEs1IIJudXpqw1bzFY5apYh2LxDgp2rhVJ+Ek5OXMJT3PiGp3cmuEKApiKLJGrK4T1+fbPBjO0F2z/3jwk3RFi/4p19LIbTs6CaLN/vNaeJFSPK2w6na36BBVW7vSeBy+eGHo8rLKbxlnL4vjrirnqeUDLIHPhHZVktWC9Ws28ZFOH6a+6tHcbBj+J04zZWm3/+5bykaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8+BZ5N0pl0iXf/8ngsmHCD/4gLo0MKPHyM7ZTQNoM4=;
 b=RbY+tVDZTCs4qzhXbL8wGseACfL93mJqfI7op+aQmdX4me1WFRld4U6aBfwRVOxU+hEIw23pzOG2cuH1yxCM1CAXVWOOwXz07wQfUKwDHgMvIeX64dYApxmBUHi6m4jD/q1lnh/zyZFXo1d4MO6vmI9xqzV3rrtGq1viK9UjTSy9zy9eO6xptjsxo1dU9hQRPo+ZzYaibH8kYKBmAnhUDgc6HTuiSqgHAJf3yRsJSJJjNmief/DqSgRa8mf+UvPU/sR0DXQOYlK0Q6WI1+vxYH1WcsmDHI830pmGM52jvKbbARpidQ88CJPyYr2tOZg62AhJQK5lv2NPAON5IuRDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+BZ5N0pl0iXf/8ngsmHCD/4gLo0MKPHyM7ZTQNoM4=;
 b=njqBdejUnLBzGljZ7AtWBVuzx15C7Etdx3T/1YbgUlyYpEzxHeguN7LXu6XyxYHajhcNz2qaheytgIfrUdT1EWac7wYCa1JmkJpMusR95qDWcYTD2AEZWnpZmOmZ6nU6GdkWrmR5xhNP1v2lk71VUV/s5fyZyJy7sTDN/p3UGmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:01:08 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:01:08 +0000
Date:   Thu, 10 Aug 2023 14:01:03 +0300
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?utf-8?B?S2xlaW5lLUvilJzDgm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <20230810110103.4suwzsziks4thy7b@LXL00007.wbi.nxp.com>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
 <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
 <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
 <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
 <ZNPlzyxYqgpPUn6K@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNPlzyxYqgpPUn6K@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR06CA0194.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::15) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd79958-cba4-445c-e334-08db9991198b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZDxhvzPvac1lKV/JSYGKJpgjRQMgPYHjzBOGxDoMpwLme4B+oYtyzYQ6HDxiEITXa6iFA8J9o7oTXtLNfjq5TBlwwS4mvxXX2LaCUdO9t7RtDOLXXyeGc5whgRq5ns7+77ZhhcW/+Qsl8HqUz4/i5um7GzEd3pjbKmjGpGmVEZiVb6EGm5o8En0KSGecctntCJxwWGZzVoJy+V6bQxkKEinbSRIK5drNJWKaj1dkJvPlFL8+AnCQghQ+/jdummBv7yScVtRr6YT79EPzzqKe+4dqwL5sDS/fJwyg548XAlY+yz4M11VCECau80CiCa6vq4qzsRG+UmThSKnV7tWNul9pZDR5KZnNvDGXYL1kv++Mebh+pwXsM+8lk+HvadnIGMK0wbfUCuKQ7u41OfwU1RHa1CRKLYUF2aOp6o53avQreO7Y6EDb+eQrNIBnzCA+PrI43JJ1G2kqKOaJzlwYPFK4VQ6qeG9NsEFhmss/nwU44Kdboi523zdjSCLbJVi1gnoLVmM0n6CvJLcXc3S5PvazgjR+0J9GHj7labsTXRV8aQNl9+erJayNcsjuvd/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(186006)(1800799006)(451199021)(6506007)(1076003)(26005)(83380400001)(2906002)(38100700002)(54906003)(7416002)(7406005)(44832011)(6486002)(6666004)(5660300002)(316002)(6512007)(478600001)(41300700001)(8676002)(8936002)(86362001)(6916009)(66476007)(4326008)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCX4S/NGIFTWkRagQ91cF3ahYTep/PA0DwC4j8fgZJr2nzp6xT5pRq+RushO?=
 =?us-ascii?Q?EX/PXyog1DUyqQUw1oWi8b6UAPaOsRfvCAt8bNPnn28KJykH19zTEZnhMo8w?=
 =?us-ascii?Q?Ipl2Aut1AeeUabUpAnGDPi5+zMsHb4hPqA7zzlI/jYdKR0qw+2+gXMbdtAZk?=
 =?us-ascii?Q?ZH7YPWJm+lGiL0ssWfEkwIcLbB5rR5WTYBfYWc68yVsBhJlgkj1Gl2iFbZF5?=
 =?us-ascii?Q?yG0qvcvfxyaf8pwG7ivunXn88yeclyRQdvhLabSVsT73D6ost4l12nL0IcYo?=
 =?us-ascii?Q?Q82x9jTp06pZ6/t7/opbuepQ2/+y9gM321UqbUYcAG65ZW8i0bL4dR2pBBBX?=
 =?us-ascii?Q?ULOqICTv89ElhBrwCY2mgiZr+nXozD2Yaw/AUap8Dq1XbFHLkj6Qwu6j1dr2?=
 =?us-ascii?Q?klkszs2lsU6xF+xDJ2eckEd76lKdTmsFPMeqo7DFlB+aaTqTfRVisrpz6df0?=
 =?us-ascii?Q?qyfRnHyWgxQHYdWQrqYtnNUf+y9K6OzUr2220MrjUM3RnfpOK6l7u3goH/ih?=
 =?us-ascii?Q?N2ne5gl8gNtxq/2/yei3F5G0LmS6JWM9WnaUs5w+LgdoVMLwEjoIuxTdLcG+?=
 =?us-ascii?Q?XVL9RLx/D2+xi1VtCinnU66lDLkg2nsTggZXO5GpjALsz3pwxRDRD2N76fQz?=
 =?us-ascii?Q?PeaIUth7MTOP3eXxuDyaZ5JYSBbXdTo+j0IgyvUkhMGHQ1yR+6fESmFI9AG2?=
 =?us-ascii?Q?DOdzGOyoJQqaL04A7AugyqeJfsuP4H0ze2T4dKG5fk47NChxtEHJkuERiBOJ?=
 =?us-ascii?Q?PcWSBOKluRhdACeD0acX/HeRGVJTXA/IWv5ZfkRB9AkoD0UR/m0yHuCFCD5P?=
 =?us-ascii?Q?DHRckMoJXNY5Z2qyxPt7IQj/g3CnA6+cqSjz9KJsqGWxTu2BU0xD46xeBd5w?=
 =?us-ascii?Q?csevog080kjjnFqrLahNL5AaG4ITMQReA/rcs/Afpbz24e66MmbS4Gfene5K?=
 =?us-ascii?Q?9vQsK7tULtyMswrUxAtjy7Ald9n5stR/zv0xFPZE87nh0Ug9fAN0rf84mfZ0?=
 =?us-ascii?Q?oPlId025IkApOKDqHWWBzrfVMqtWsIiosc6wkQeEPmJWxQj2ddLgfYT6zdFS?=
 =?us-ascii?Q?5wWyvqxNBdEM/R+Y3akADthNDHt5hcGhsWrVhMesXvo1MGkhAQuA6rSGvVm6?=
 =?us-ascii?Q?t7Dg+htNWR6EvFXIqRXMcLT3liBasnTjKPnIoZDJN9vr8qVn/OM1xJ4hPiUA?=
 =?us-ascii?Q?fjqNHCPJORy5UFbsSB9fiMqzZVbFWXAppXNHpJQxNdTTDQpjfLU1fcAjmRPG?=
 =?us-ascii?Q?Gvl5IFd/ukGKiiFYQChZrbjc3zmDooprmok5C0YSDiCBjPcslKfCefq4EBsa?=
 =?us-ascii?Q?VsQpgRQZjTMdleLid+dqL9/OCGhrrfdkGqtj/rHg3GyiQgucupCaP39dHdkz?=
 =?us-ascii?Q?0yKnqoOzXf3PCDXkev97iaBstbY3U+FmJ6HJXfOX/P0cwsLxiiZQ257IGD5f?=
 =?us-ascii?Q?Q9S57MCgrqZozYlOm9DW0X6ImFWpzwAupwWDutkxj2O1jMKLxaR/V4PE+Ai6?=
 =?us-ascii?Q?3oMSH195LXIqJab+0FeCQ65zEEX9Mr4h9RE8sXuQiXhddnopTRag7GTo70CY?=
 =?us-ascii?Q?ioGOiILKsMye67eoXA36uz01NBwh0qejX3X4G7CXXUaI2LhAdDQ4T/XMprQh?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd79958-cba4-445c-e334-08db9991198b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:01:08.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPPtHVRNHfp01RqMNd6SKmQnScsHhOU6RIB6416vZeZ7/23PCsyOuyBRl9TaaDPM3enifIkc+t+5FnkQyCCK2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:15:27PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 09, 2023 at 06:21:58PM +0200, Andrew Lunn wrote:
> > > Thinking about this, I wonder whether we could solve your issue by
> > > disabling interrupts when the PHY is probed, rather than disabling
> > > them on shutdown - something like this? (not build tested)
> > > 
> > > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > > index 3e9909b30938..4d1a37487923 100644
> > > --- a/drivers/net/phy/phy_device.c
> > > +++ b/drivers/net/phy/phy_device.c
> > > @@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
> > >  			goto out;
> > >  	}
> > >  
> > > +        phy_disable_interrupts(phydev);
> > > +
> > >  	/* Start out supporting everything. Eventually,
> > >  	 * a controller will attach, and may modify one
> > >  	 * or both of these values
> > 
> > At some point, the interrupt is going to be enabled again. And then
> > the WoL interrupt will fire. I think some PHY drivers actually need to
> > see that WoL interrupt. e.g. the marvell driver has this comment:
> > 
> > static int m88e1318_set_wol(struct phy_device *phydev,
> >                             struct ethtool_wolinfo *wol)
> > {
> > ....
> >                 /* If WOL event happened once, the LED[2] interrupt pin
> >                  * will not be cleared unless we reading the interrupt status
> >                  * register. If interrupts are in use, the normal interrupt
> >                  * handling will clear the WOL event. Clear the WOL event
> >                  * before enabling it if !phy_interrupt_is_valid()
> >                  */
> > 
> > So it seems like just probing the marvell PHY is not enough to clear
> > the WoL interrupt.
> > 
> > Can we be sure that the other PHY has reached a state it can handle
> > and clear an interrupt when we come to enable the interrupt? I think
> > not, especially in cases like NFS root, where the interface will be
> > put into use as soon as it exists, maybe before the other interface
> > has probed.
> 
> I suppose the question to Ioana would be - are the two AR8031 PHYs on
> the same MDIO bus? If they are, then we're safe, because both will be
> probed consecutively (because they're using the same driver.)
> 

Yes, the two AR8031 PHYs are on the same MDIO bus.

I just tested your approach to disable the interrupts at phy_probe() and
it seems to be working. I also tested with NFS boot using one of the
PHYs and it's behaving ok.

I think I'm ok with this approach as long as Uwe's problem is also
fixed. I don't know how a wake-on-lan procedure works and if it matters
if the WoL interrupt is lost before the PHY driver gets to know about
it.

Ioana
