Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A60C77FA48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352779AbjHQPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbjHQPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7326A4;
        Thu, 17 Aug 2023 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzWzzSONZL0MaEmSDIH5Cl8aEbgwsx6rqRugM1v2e9heSsxpTAusfK5U6OM1khYMH1eDjOFDpuzYdk0ZcpbDEmkl3WE3ryu27c8xadh4wY+zAXoTJQaEmhHo3xfT+wdpz8kNIBWm/wqfgjupWxw8L8uLsFpMp/06x5htZKOmwSD3Jr9Yzsaxuouy0z4V4tVHJvVUgaybgeCE+lYOVpCckKzNb9ebtnr5Y9VLw5acgqs+GVgnRX1U8+MiPstUJyUUTh2jLrPWZnDSKf4MKsZBGTA5h/vaV4LHdtYQKJvIX5X13DKY0mJMMY62wvvLuaCdpy+v5XGTYeVzG7Ib+e4JZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeRasjUOC0jOPhEMv1SmtPUBGl2kUlI2lAccRTDXIeA=;
 b=bUIyxwPEDtY48ljX0SMUn6Q4efEtkFzmWjo7eVMwqEGs9+c5RjxQyAvKNOABqQr0yLCBf0pRR9gHTl9vhkXfpysBxcBGCmjJlzRJdZPCr67aOM/ZxJstZM955LEthJXfQZWRt31MkUhcrWd2gTI302ziktCQ6zcc9LkDoGSgzo48Edo4bHnUdOsNJeU2CBZ148WpYzI6XK+UyYBGG4pqIMyRGkISuVYTt8cK2v044MwyFt41Xny8zV5TA8k5p3hWSr/K2Law9gn4WpY1yTSlBY1flNvkFd7FihAENm6e0F9hC4zuN5dUbmwZSclUfeQMwyZEdHC5/DMg4/sjl0V7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeRasjUOC0jOPhEMv1SmtPUBGl2kUlI2lAccRTDXIeA=;
 b=WR5iFc2Vj5ihO98/WwV1OBZPGI/qwp8/q6K8fFws+0r/MTDiUfnVl0VF476Z5Wyjd0zOkrCeW1IZI795R4ZjALmPQdvnPC5YYQJxiKK2ZK5LuEKRWqizumDqMboHN2Kn1iQ9VA25RVhA+vrFaSou8MMx09j9VE1lkLZg4Gb029o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:06:56 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:06:56 +0000
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
Subject: [RFC PATCH net-next 0/8] Add C72/C73 copper backplane support for LX2160
Date:   Thu, 17 Aug 2023 18:06:36 +0300
Message-Id: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 9970c896-5126-4c63-5af8-08db9f3398c6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/1k1geKfKuKUS00F8nloABf/BEp9CLrwUZ2rU2CqAxTb1rUSgvuxLiaZMU75fDzd9d9E5F91RNR2x8LJ+3TkR0DWSjCC1zDvh7Nk2R6lG4debNNkEMSozQmDEqp2SUtOOsaLScpxUgC6+hZ3KhO6gtSwLDt79HPfoH34Q+FhfbGtBxFxnv60EoUsXN/gm4Yj5yRtZRLCrlMonXUitkGp+WhFAHuG+Z9dE0QPpLGnRcLBN2pExx8dhDm8HTMftC5kxTAuUDd5N8TR5pXK75e0R4KhviTMYmlV9xnBQ6TXRXg2xp92vUPvrq8kpVWS992ABtArXyiVGajmazylI9+67Df0TYi/ZuG2m+JH0eJRQGRTDpAoqIAT+8BQCEhMwJBbENqngMRfN9Fha4catA2CgBFiwtXMP8EQZytHTcg1N5PhdkhWMzer0+HLXIyT5TD0MVqPxloKezUdIpoQG9zZlBBTWRkYneSuJa5Znl5I+K5Y/89bhC8Yiyu8HMVoStYOVxaPCtdxwiipkB+TtLBEau/qxt3qxQFq10kYxe0ypPM2G95+pEmaKRLLW805x+2DgymD17wVthJxZPAU3qXhbF+3H5cjCjw3WANZOkwFKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(966005)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BgxYsmOykrLJ/jOdpQvIKawyvS8o9NpSysBcOMrLYfxc0bVnnnHHrh7/jOJ?=
 =?us-ascii?Q?FhPdUp3wuoMBcBz5bOqHeChGceDuGpioPm7OTf9d2hRNbVetsn9mka5WNaEK?=
 =?us-ascii?Q?zhgLyZixlc9KqIaHEzrh6kGBVn39gua/fWc7R1sm+px+pRY8hoK48GUb0FS4?=
 =?us-ascii?Q?ye5ns37NQXpwg9OQFJsuIJc+Y696cBZKdOkwE4zg91qI5kpotHyk6eCkSbma?=
 =?us-ascii?Q?qTlTvXN5zygT8j1HDO8zhkrKElo5DT4LC6HAbbo3Xkzqkeew+BzV0CZGo83V?=
 =?us-ascii?Q?5LRdV6NybhN+YcD4K2IYH5EmjONGKt7bkMsu3ymioArGeTkDyW4Eu00blbbb?=
 =?us-ascii?Q?SXKAwxMW5/oT3EROIUwPL1ijjT5As3+vr3OMneJ4S8ALC3IMyd0QXoXJiGz+?=
 =?us-ascii?Q?v+h+7wi7uhg73+WMa6F5SczHdOACD+FxGZuMbb+HeaURbyQlgBXQHp78Bqv/?=
 =?us-ascii?Q?CVl0plXSJRHfAlIU3ZjT3wVD9GfNIHVF+5w6tRI1ldMO2zPwW7TYXE6HTbtG?=
 =?us-ascii?Q?tSMwWATOmd6oyaojG56QiR6eeP0H/n677ktEir0ZPDbWn+7WOhy6QS2gcwbT?=
 =?us-ascii?Q?b53OzDL95V7WfFOclgAb3sfu+MSAFuBQAH9UhEDkWqC6LE1ZhrkdqMvMKqGr?=
 =?us-ascii?Q?m7A8VsNMmdHSEMui/PJZ2o5Ua5j+O2vGXJdroA6khr4+n5eymGgRbx1N979w?=
 =?us-ascii?Q?TeZr8POBe6x2A5FGI4N2YmHCOApoSMa3mDl1Wn2YdmXNrXjBT9/QKgf1ZPLm?=
 =?us-ascii?Q?/+5J2ykbTvzXY+0bkF191OzS9EFa19fMsZPPERo262zH9RdaUPmcvwIP/pxJ?=
 =?us-ascii?Q?ejVlbtobaQuYMKylqxNIYgrPf0nvEquqR46efBW9m7JCg5//FOEEzT52m/4T?=
 =?us-ascii?Q?KpiFSY1B/U0nflnGCkLOTjvAlNsmnb6ArWpcbnkduV6rBi7wjBY3jOluA3Wa?=
 =?us-ascii?Q?JFmqM7wszWN891WNjLMrf9XnSexZvIDV0BRW09B5gfKXbYk6CxVFSWlZZpJI?=
 =?us-ascii?Q?vRrySdSuTwJ/NbD5ugF/kkPULaRDX6Vq9AEd2s9Jy6J7oW2nA8nQzD53adCv?=
 =?us-ascii?Q?v6jKU1pQ6L0B3Z0O6p6M6W3jYv4NGFBtkE7mnsZYVAjyeABk6SgVVdCWqr//?=
 =?us-ascii?Q?WS7+XmZ8+ne5duCmVkMyl3TNNl2V4VhtxXcAdckSZlvaVzaENPtdh7ZSarLp?=
 =?us-ascii?Q?ztglzPj7A14t0Xz2kfuYdNRWhkHs7xAQW0hyzuBzIbg/MM3Ru9d28bJMaf9o?=
 =?us-ascii?Q?p3PdGcAWg2ve5EP6vXRH9k8lZV5wxGz0OI//ezY3a1FIk2DPRLpQqz3/1EEn?=
 =?us-ascii?Q?5beWl95j/Z+rAY7Xoxd2juca5rNyE1C0gC4QzDILxZq0H9Z2QstVfVmEx98B?=
 =?us-ascii?Q?HtKzsjb0YsMRXbXeclMfjPMtFG7LJ8jpHEnfJDygx7T8WfahJBI1SKF+SYZy?=
 =?us-ascii?Q?o5T6B6R/xZ/pJJGG58vBb0Uxqc85BZfVljRBlonKbgZQrvBYCa8AAnRS40Z+?=
 =?us-ascii?Q?VuXIsS1nz4OWaXmEVf/RLmwNoPeFKBQgcjxKWT3IeJ7XDeeB2CrTNyWZYL6f?=
 =?us-ascii?Q?A9d4kuHPbJ0DrOTaaHVVN/34JA7xYSKLhxT8DgAheQV+RQqJ5Wcy5kJfOti8?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9970c896-5126-4c63-5af8-08db9f3398c6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:06:56.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPf6NDESaYFfh8An2Q3L8hfyOlcgwvRE/SrEZimDKukp6mH7Hfgdt+Ove4YpH+SU0lDSoOg3dMNX3s3vRVZHiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THIS PATCH SET DOES NOT WORK, AND IT ISN'T INTENDED TO WORK.

I've been tasked with maintaining the copper backplane support on
Layerscape SoCs. There was a previous attempt to upstream that, which is
located here:
https://lore.kernel.org/lkml/1587732391-3374-1-git-send-email-florinel.iordache@nxp.com/

Nonetheless, I am presenting here a complete rewrite based on my
understanding. The quality of implementation is not great, and there are
probably bugs which I've yet to identify. The reason for this RFC is to
collect feedback for the overall design from networking PHY and generic
PHY maintainers.

The newly proposed generic PHY API has the mtip_backplane.c driver as a
user (a consumer), but its actual hardware implementation (which should
go in drivers/phy/freescale/phy-fsl-lynx-28g.c), is not included in this
patch set. That would just have just uselessly distracted the reviewers'
attention. This is why the patch set, as posted, does not work.

I recommend reviewing from the bottom up - dt-bindings first, those give
an overall picture of the AN/LT block and its integration in the SoC.

Future work consists of:

- supporting multi-lane link modes

- advertising more than a single link mode, and performing dynamic
  SerDes protocol switching towards that link mode. Strictly speaking,
  the hardware was intended to be used with a single link mode advertised
  over C73 (the link mode pre-configured through the RCW - Reset
  Configuration Word), and that is quite apparent in its design. With
  some inventive workarounds which I've yet to try out, it might be
  possible to circumvent the design limitations and advertise any link
  mode that the SerDes PLLs can sustain. This is in an exploratory stage
  and in the end it might not come to fruition, but I've identified some
  aspects which require forethought in the driver's design.

Both these features hit a wall given the current driver design, which is
"how do we access the AN/LT block's registers?".

The hardware designers were inconsistent in the way that they've
integrated this AN/LT blocks for 1G/10G ports, vs how they did it for
25G/40G/50G/100G ports. There is always one single AN/LT block per
SerDes lane, but for 1G/10G modes, hardware design wanted to make it
appear as if the AN/LT is part of the PCS. So it inherently responds to
the same MDIO address as the PCS. Whereas in the >25G modes, it responds
to an MDIO address defined by a different control register, and that
address is also different from the PCS' MDIO address.

In the current dt-bindings, I am requesting DT writers to put a
phy-handle towards the MDIO address of the AN/LT block (which depends on
a lot of things, see the dt-bindings document for details).

As opposed to regular ports where the PCS and SerDes PHY are controlled
by the MAC driver (drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c),
with backplane, those same components are controlled by the
mtip_backplane.c driver. The backplane AN/LT driver has a pcs-handle
towards the PCS, and it treats it as a raw MDIO device when polling for
link status.

This gets obviously problematic when switching SerDes protocols, because
the location of the backplane AN/LT block changes on the MDIO bus with
the new SerDes protocol, and what's in the device tree becomes invalid
(the phydev->mdio.addr would need to be updated). It's the same AN/LT
block, and after a SerDes protocol change it has been reset, but it moved.

The SerDes control registers for the MDIO addresses of the PCS and AN/LT blocks:
- SGMIInCR1[MDEV_PORT]
- SXGMIInCR1[MDEV_PORT]
- ANLTnCR1[MDEV_PORT]
- E25GnCR1[MDEV_PORT]
- E40GnCR1[MDEV_PORT]
- E50GnCR1[MDEV_PORT]
- E100GnCR1[MDEV_PORT]

are in premise all configurable, but it's an open question to me as to
how Linux should configure them. Currently, we treat all those addresses
as read-only and populate the device trees based on their default values.

There's an additional (related) problem for 1000base-KX. The lane starts
up at power-on reset in 1000base-X mode (non-backplane) and this means
that the PCS which responds to MDIO commands is the one used for
SGMII/1000Base-X by drivers/net/pcs/pcs-lynx.c. That responds to C22
MDIO commands. The PCS for 1000Base-KX is different, and it responds to
C45 MDIO commands. It also incorporates the AN/LT block at this C45 MDIO
address. In the current mtip_backplane.c driver design, the lane switches
to backplane mode (thus enabling the respective PCS) once the link mode
was resolved to 1000base-KX through C73 autoneg, using phy_set_mode_ext().
But that is too late with 1000base-KX, since the AN/LT block won't
respond to C45 transactions either, if the port isn't pre-configured for
1000base-KX. So C73 autoneg won't work to begin with... Somebody needs
to pre-configure the SerDes lane for backplane mode, so that the
mtip_backplane.c driver can probe, but it's not clear who and based on
what.

Finally, I reckon that in the end, the PCS should be driven using a
struct phylink_pcs, by the lynx_pcs driver, and not as an mdio_device
using raw accesses by the mtip_backplane.c. In premise, this AN/LT IP
core can be integrated, to my knowledge, with any PCS and any SerDes,
so that should be also possible in the driver design. Yet, there's a
problem: in the 1G/10G modes, there would be 2 drivers for the same
mdio_device: one for the PCS and the other for the AN/LT block (PHY).
True, they are at different MMDs, but bindings multiple Linux drivers to
mdio_devices per MMD is not a thing, I guess?

Interrupt support is also missing, and that's very far away on my TODO
list. AFAIU, PCS/ANLT interrupts are routed by the SoC to the attached
MAC's IEVENT register, which isn't enabled as an interrupt source on any
Layerscape platform yet. I've structured the code using an irqpoll
thread for now, so it is more-or-less just as event-driven as an IRQ
based driver would be.

As a side note, I have analyzed the feedback previously given to Florinel,
especially the one from Russell:
https://lore.kernel.org/lkml/20200425105210.GZ25745@shell.armlinux.org.uk/

"This uses phylib, which is a problem ..."

and I still haven't changed that here. Without going into a wall of text
explanation, I'm not fully convinced that phylib isn't, in fact, the
best place for a backplane AN/LT driver to live. At least in the initial
implementation shown here, I'm not sure that going straight for a
phylink implementation of the AN/LT block would have solved any of the
problems that I described above.

Vladimir Oltean (8):
  phy: introduce the phy_check_cdr_lock() function
  phy: introduce the PHY_MODE_ETHERNET_PHY mode for phy_set_mode_ext()
  phy: xgkr: add configuration interface for copper backplane Ethernet
    PHYs
  net: phy: add C73 base page helpers
  net: phy: balance calls to ->suspend() and ->resume()
  net: phy: initialize phydev->master_slave_set to
    MASTER_SLAVE_CFG_UNKNOWN
  net: phy: mtip_backplane: add driver for MoreThanIP backplane AN/LT
    core
  dt-bindings: net: fsl,backplane-anlt: new binding document

 .../devicetree/bindings/net/ethernet-phy.yaml |    8 +
 .../bindings/net/fsl,backplane-anlt.yaml      |  238 +++
 drivers/net/mii.c                             |   34 +-
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/mtip_backplane.c              | 1735 +++++++++++++++++
 drivers/net/phy/phy_device.c                  |    5 +-
 drivers/phy/phy-core.c                        |   18 +
 include/linux/mii.h                           |  105 +
 include/linux/phy/phy-xgkr.h                  |  165 ++
 include/linux/phy/phy.h                       |   27 +
 11 files changed, 2341 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
 create mode 100644 drivers/net/phy/mtip_backplane.c
 create mode 100644 include/linux/phy/phy-xgkr.h

-- 
2.34.1

