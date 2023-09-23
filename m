Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1267AC25D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjIWNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIWNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FA19E;
        Sat, 23 Sep 2023 06:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzPET60pC55/itSPf7/sqQZ6XEoXuIwN06JcDLm0sUSvn33OZE01ArwQjIFWQ9tzLCwhlyfXjFMzTEMys1E65KH8QlqSaOM38/S5e9gJjn/a3fxUq5g5szF9LDdxY5+kVOZPFOl0qegiSVPbFuTOlWCMFrbHkLNEnQU9GJ3be2ovWKdIdLvelZv81GhVW0IJCVwsprqFJGAr9AUhXQ03UIhuUde80YwXxlks8/NNkkSiLaOBP9MO1fTFz14w5MprTRaCkW+aKDwiMrR/OxkM7A+7IcEM/vUvj6YO45duQNtM05idIbKFiwCV6NXt1w1l0Wkj2hVP1+g50Q8BGTm2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3L10oSZih4S6oiall6EzZMnfy7CHYrJoapsphP+Wmg=;
 b=SF7sV48s/HrmPpnhZk1DnrwVirqZdU1m3PZY8GR+vsSuxiVgVtmN9Mx+E4trp8o9BwGmWCE8sGXQVkMsoHi59WEbEaXVF8x3pCQq0kYwA2om7/ygIAddeGzx2BPSKeuRuYHIDsGOWSxeNNCXUuZ7vFlWCoRzxkqcG4uQoEGmqZQ8rC0llGPGVA8V0XZotfxbI27kqWfntbxzmhg/8BpfLQVlLTSuwWed5dAXeTCxM9LUpSiFeESkIZ+QGZtQ6bPZ2P144DRkpDIX9Dvqg3EAVxihGJneKDD2K5oDw3Fx5GF3I1XxxPpD90afnxDxf4bejQTx8wXhb5LDgqPAJ2WZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3L10oSZih4S6oiall6EzZMnfy7CHYrJoapsphP+Wmg=;
 b=jiqxYaXMLjw0A2eHVoK4pXblU3VigFHaeqOC4wpdE8X7pYt2sgJwZVL+xugEcm8pRoPhLBsCUc6cvY56vdT0tr2ylp67FcL1EXtOtq8K/xpg6SWsFe/FzvUwaYEFBywRSTXA0KCWAyLxKcKUFt2AFBFk9NxTLp5I4UgKRrahutQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 13:49:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:21 +0000
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
Subject: [RFC PATCH v2 net-next 00/15] Add C72/C73 copper backplane support for LX2160
Date:   Sat, 23 Sep 2023 16:48:49 +0300
Message-Id: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: d86deed9-e973-429b-b255-08dbbc3be3c0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOx8eIrE7lo25LbClTKD3ffr9XUQGLZk/xuWl8x4uNv46MVkx6k/tPjhxRrrj2ItWOPlzDEJQ/WQu967Bg+fgzftHsWZNA1bnJEfyCwT4+RscjdTBSRzaUNb+2Ksa+CuggCksV7S4G8ra9pXdcRpwhcOmxcjfDJ8kbYuzH5XZRHriXa/IRCe3B9V/4ZVXvwP2Y+G1cVO7L5550zoWaovANhZHKyIN/ENq2BDN7BXXNtJ7ZLkFCF1O2Rfz0kl994Dl+24K4gE12dMKoADnkfj8oCJY6d/EHjUyrS4d0VMLHC4mMoxVK+h+ciKlHWOl2KNksGR8CyAGIkXbqb7vqSBrysqDsA2dOykbvo/VIFrNNqoeHTYJnz49szBuh0lsP4NW6w+4Nz0uZBUYb5WLyr1BOehFBp2Cy5Ifmp1EmJ9hCs2Wr2XDPA2bXzzaFxPWvwxrzV8iOA7QB7eLL39qTgMwaYaQFUc5ab/PG7PncVlwNr1CUzT7ohnQmA82WPbBEuqIJjzxXI8QTb/QmYXnEQUv93XXzURk0Nt4HbQ2ehjXA2PDHuZL0wDvdVtaMFEQeIgowruPSb7Zq3gskAR5quiNoq+leUY4UeSJgNk5UJQ7Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(6512007)(52116002)(6506007)(6486002)(6666004)(83380400001)(86362001)(38350700002)(38100700002)(36756003)(1076003)(2616005)(26005)(2906002)(41300700001)(316002)(7416002)(44832011)(54906003)(66946007)(66476007)(66556008)(478600001)(966005)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yojxPfPsMres7Nm6XDwOFJyCLMSDm2gYFraB1wQnzLYNVfkhfxvb7Mwe3D4M?=
 =?us-ascii?Q?Z8K/tNhMHpmvon/q8u0D1yuM9GWoGXHI9/NgONewnO6bpTmkGPDmO8bFjrFI?=
 =?us-ascii?Q?gYVwgDeVOOTNRMjjcgYgA+wVyrBKppQiyJlSsWMH8ro9hdHwYkn2xnZ5K1KQ?=
 =?us-ascii?Q?LWKte6Q0rtj0VsMURjXXXtzEqfQMah++0yZmIHtYGJyAkXysVNeBGig7xajS?=
 =?us-ascii?Q?STGheUtuOC/VS3Yv4bnZY+f+iya6cb7Yi3xVZrdvn6HSa4YIg1f4SwfoalXM?=
 =?us-ascii?Q?zovYZCjTi878VlNzNB2qrfOvymGZVBj9edfkH7PCn64RAGKXxuQ5lPrIsuwz?=
 =?us-ascii?Q?rfcrOaKX6rEJp+33bibv5qbaxMToiXtkWYMty8Fr4SJPNQ32wWoYZauy6tjE?=
 =?us-ascii?Q?XKMYL4KF81pNsV9V/Mi8y3igWTojx+QTsvScEU2D12GB7wbrlcbikrP8Tnbo?=
 =?us-ascii?Q?VcBifPSvn2m3Ox9/NlNKg7Y5IjSWI/3X8pBvhmVTDVCYUoyE6Iy83eMtaImO?=
 =?us-ascii?Q?27zRwQR7j+tL9n/btURVgGuMK+FiW5HVYIfIubPR4Ic7uJRjTSPFLdw3Ob0p?=
 =?us-ascii?Q?nM/E/+7yQ57B2YoG74trzQ4typFLM6Bhjzuc/zHvGri2zbvVxz4HR/lOdMqU?=
 =?us-ascii?Q?2BkIE6BLZRU8Gm/jyob/9PFEJWHIO+p4aqxMDmkvpoq6q+RU6gous9ZtVjLx?=
 =?us-ascii?Q?yZqYTFZkBzO2jfDBgLFG9kJs37TE5T0A8tYpoyRUtbFVVEJCJwElhvOrqPgh?=
 =?us-ascii?Q?n5Lpuh792RgMO0PwrTWfexdEGVPX/KxpvCGtsvWqW+APWnoelIO3OqAhrpv5?=
 =?us-ascii?Q?3/7cfsWBAzPR+1ZlNDwuaWrn1hsCijtrb85k6qX2bPmlW6SYmPGkiozlsM23?=
 =?us-ascii?Q?/Ev5GKY/66775VpG0h8/wo42f/Zo6qGeKPRbzyc15TEzL8LzgKOwyxca7nUN?=
 =?us-ascii?Q?iSvQcHgMnhU97nir8TYGj1e6w/1UYeT5/dTiyj6jZ0SeXrw+Z6+YFuCWobvo?=
 =?us-ascii?Q?ZWgAbtMtEm0ZDfAOHr/NwpqNZCVqFSq4/rMLQ2SGpHYNY/ExvyQXvFL/LLXw?=
 =?us-ascii?Q?csEki147pOZ5MXGZFmNV6rmbUto9LGTM3WOf14l5Kdm+kPKBVQL+7O6DNQ2F?=
 =?us-ascii?Q?RHGsRNI55pGLdtaHk9IkiGnzTtP8B+8JA18p0eqUT6eYkETCRicYfFLCDhrf?=
 =?us-ascii?Q?kb/aePk4x7SVKGTsDQl3xuNhENe/VaxYXMd1gWyikn+NNKxB+laHzQ5s1elP?=
 =?us-ascii?Q?IqjInlXUs8NJBYIV59LBW4OpF2gNPhkdg1cY93b/winLpe9WouCth+46m+fY?=
 =?us-ascii?Q?yoebIjHBLLro3oE6Zg6daVqFp6qGh7q4QG3pUIfQqzjbNKDwrqUR4ELM+4xQ?=
 =?us-ascii?Q?cl/X4Br0iz/9bT2Nbt5RElyLPJMKq7XJL3iICAf9tMLpcEY58wQ68W4HYRuf?=
 =?us-ascii?Q?NVZYPZHQZRFwJt7xvURtjVDTU2LGsb4gC1W9A9o4TV0X0fvyoYBkRGDhPAZX?=
 =?us-ascii?Q?+UkESF/EdugtQxBrAJtJNewzB8DrwlNFhGal1czpU1H26C8UK/cc43bQ6Hmi?=
 =?us-ascii?Q?fk9hXtSlyQBRzyIobUfaDFt9n1pobCvnykjJlXY6ToWxR5+Pa+K4wQqONW/f?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86deed9-e973-429b-b255-08dbbc3be3c0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:21.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATeaj1G4gOmNyFNwJFQnz2vfpxOzGgcxYxMQQf6x5+FgPj2i4N6BYS93TKlNQbyM5zZPBH5thJ7lmKHH9t0v4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
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

Changes in v2:
- replace phy_check_cdr_lock() with phy_get_status(PHY_STATUS_CDR_LOCK)
- rename PHY_MODE_ETHERNET_PHY to PHY_MODE_ETHTOOL
- stop describing the AN/LT block in the device tree and make use of the
  fact that it is discoverable. Add phy_get_status(PHY_STATUS_PCVT_ADDR)
  to the generic PHY layer to discover it.
- add the 25GBase-KR-S and 25GBase-CR-S link modes. Proper treatment of
  RS-FEC and BASE-R FEC is still TODO (will also require new API in the
  generic PHY layer).
- rework the implementation from a phylib phy_device to a phylink_pcs
  component (library code). The phy-mode is still "internal". It may or
  may have not been the right thing to do. There are some things to say
  about that on patch 08/15.
- support multi-lane link modes - tested with 40GBase-KR4
- solve the pre-configuration and register access problem for 1000Base-KX
  by having mtip_get_mdiodev() pre-configure the SerDes lane and
  protocol converter for the highest supported backplane link mode.

The original cover letter for the RFC v1 at
https://patchwork.kernel.org/project/netdevbpf/cover/20230817150644.3605105-1-vladimir.oltean@nxp.com/
is still attached below.

=================================================

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

Vladimir Oltean (15):
  phy: introduce phy_get_status() and use it to report CDR lock
  phy: introduce the PHY_MODE_ETHTOOL mode for phy_set_mode_ext()
  phy: ethernet: add configuration interface for copper backplane
    Ethernet PHYs
  phy: allow querying the address of protocol converters through
    phy_get_status()
  net: add 25GBase-KR-S and 25GBase-CR-S to ethtool link mode UAPI
  net: mii: add C73 base page helpers
  net: phylink: centralize phy_interface_mode_is_8023z() &&
    phylink_autoneg_inband() checks
  net: phylink: allow PCS to handle C73 autoneg for phy-mode =
    "internal"
  net: ethtool: introduce ethtool_link_mode_str()
  net: phylink: support all ethtool port modes with inband modes
  net: phylink: support the 25GBase-KR-S and 25GBase-CR-S link modes too
  net: phylink: add the 25G link modes to
    phylink_c73_priority_resolution[]
  dt-bindings: lynx-pcs: add properties for backplane mode
  net: pcs: mtip_backplane: add driver for MoreThanIP backplane AN/LT
    core
  net: pcs: lynx: use MTIP AN/LT block for copper backplanes

 .../bindings/net/pcs/fsl,lynx-pcs.yaml        |   15 +-
 drivers/net/mii.c                             |   34 +-
 drivers/net/pcs/Kconfig                       |    8 +
 drivers/net/pcs/Makefile                      |    1 +
 drivers/net/pcs/mtip_backplane.c              | 2022 +++++++++++++++++
 drivers/net/pcs/mtip_backplane.h              |   87 +
 drivers/net/pcs/pcs-lynx.c                    |  135 ++
 drivers/net/phy/phy-core.c                    |    2 +-
 drivers/net/phy/phylink.c                     |   53 +-
 drivers/phy/phy-core.c                        |   31 +
 include/linux/ethtool.h                       |    6 +
 include/linux/mii.h                           |  105 +
 include/linux/phy/phy-ethernet.h              |  292 +++
 include/linux/phy/phy.h                       |   83 +
 include/linux/phylink.h                       |    1 +
 include/uapi/linux/ethtool.h                  |    2 +
 net/ethtool/common.c                          |   12 +
 17 files changed, 2876 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/pcs/mtip_backplane.c
 create mode 100644 drivers/net/pcs/mtip_backplane.h
 create mode 100644 include/linux/phy/phy-ethernet.h

-- 
2.34.1

