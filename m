Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605657FD640
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjK2MEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjK2MEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:04:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4819AB;
        Wed, 29 Nov 2023 04:04:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAkpyshGOQvUqL0WuPAZsoQ1Uc9imlMATjGabLS+battump91oEA0TkgQhgdhvgNNb9I0rEVaGXeisw/EN88jQd7BcRuB9qFmuMbCDCDJ8Bp+Snw7GTc2L59V4TSLU22mH5lV07a5EQjzk1EWeB8Z2a2ytsojAais1S0pKhXDFN92xv4gZoN/J+bD5Pwx1f80yobW3F0gCw6a0d21X8RkZpwNZOvh+q6awqyieqSd8+iffB2o7xxrw4IF8BNcSJ4mdtG0KEAXbUkqblUuBh2jjnQalqLU50yKC2tgWgLjtWDPxTeqIXoUWTbQGBYerOxJe4kwkX/QvBFBp0dlN5zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni2vZol5Mo9Ps2EzVeXQvYReZv+9WoiGpyxuKqx0HQE=;
 b=XkT0fM0xvQUiFC3h9rlbS79fttNJxFN00aPiP/uQUlFN6H7R7wXHq4Knq1jcQU2ikyLZwWwEdP/Pv6pZQC6ij6hx7f+v5CQ3NSfWHkKxVipK6AApUql8K2SU/UY2By2Ums3S/23ujaXivNwUN6snvxIN2jDDpdSJpHH3n8u0g59oZzcQ4hAi2ILtGNecm4nyYWMyqNNaHb5TbhzSizFqnBnQzLYXeUxWfN9V2nTjjc6nbGWL0bX8NjHs1ng8sh/qyuNxsl4tngW8OfBpnwr6w61wfFqWsZwFWIHfNwBL3ZUTexegr6U5Sweca+RxqLiWJx2DvmPqXCX03Q0phCk3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni2vZol5Mo9Ps2EzVeXQvYReZv+9WoiGpyxuKqx0HQE=;
 b=NIRQpvavc3cgzUP6zXDfmvBcW7oVahzrGpsuMUd0P+Njs7K2pNxud0zgpw3FYOuJizYiph28Ff014mA3vX/RWzyEpkNrI73pXVjbdKcBBlp9iOGWjgAO4F2QfD4spYl4MMrzGLNvC1y3K4fEFM9mJPrPlDCTAiURYzWQPTd+YKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 12:04:50 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 12:04:50 +0000
Date:   Wed, 29 Nov 2023 14:04:46 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <20231129120446.dfwei5cd7ulbdj4v@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277a4cdf-fef6-4d40-baac-01d5da40ce62@quicinc.com>
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: d63ada48-5376-40cf-d680-08dbf0d36332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /z/337GhTHLZmO130U/ECMvAXG5lCDSi5VNL438J8wwXFuKBKWy28k5gbqfcvQBQ4jeahq+88XUeTa1/bU9uOSLQzrlCP0AmpYJwTlpFCnPr3ErYBJlhSQ5gCEUz7twDmYoDPXLAOnFzE+Hllm1W/W3G+9+3on+44DaQlRbRWObA3sfT0rbcio57FV3BLsYFDFThrQl2OaUFb6666hGhBXmY/zXmSO4fCT/Bnj3qL8IQ0acXPwOrMV2yajpDaQpxvxd3DpxHvJx3mEsgQL+R8m1ha+QfUn9tiXDfIkcFffPqnQGw4X7wfh2kgpTtBIvCi4DEwG41MbqnbuEeHIKiZddLohhHJJjkkVzusvutrFSJksk5l9+T7wDt4ctIQBAC6AbAH7dXe0JYX8yn3pvw3gVbZ1eEsvvYJBGFQbJpSXowraWrAYvsVN9tlNQ9qhP+wEmcXFn3eEQv94wOo3GNF392TxbrMhNwfGp9o4/KeoS49y6r3e0HguHYEIejJJ20VfQlTxsOIWuVhOSwf5UpGxSp+F+7QNpj3GDhUeWEMwiwtEc62k48uYSLyIIhwTpD/31gVFUGHj68kxfAyZQl0tWzHllWkpTqP9eFbrSeOjgR94L5nSBcsUSd1pOxdb+v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(26005)(86362001)(38100700002)(44832011)(7416002)(5660300002)(83380400001)(6506007)(6512007)(6666004)(478600001)(9686003)(54906003)(66556008)(66476007)(6916009)(8936002)(66946007)(8676002)(4326008)(316002)(41300700001)(33716001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37VU+32mNLTF3FyuHGNrUrokxYKnQytfq23WEZHbPN1FyWHe2xRly0uutMpi?=
 =?us-ascii?Q?W4xdG/zcUQ+4VKnAQdTsWG46ZAfEod0r9MvkIhZUTLCe89yEZ9hX+LqWozC1?=
 =?us-ascii?Q?4MuEHz3g3Y4+HxcpsAN9H8/L2W38JRDZcudYhXQpfT8dfWIENNpkz8090V7h?=
 =?us-ascii?Q?d9bfIcWyOgTl+duhr3uRWhJ57BqIgRcuAU0cFF/dLqZPvEVyPh1JXnGKftQ6?=
 =?us-ascii?Q?C4wxvchbH1N2AnuYYcxVX6ecnNnXmQD8QM2VdNONSAJ2obvew9i71Mgu/xB6?=
 =?us-ascii?Q?Gw7oCZZIWOFaEk+ymw6cuI7v0QlJkytnOWZFOlrCGonxKGf8vzYw3PD5TqYI?=
 =?us-ascii?Q?DiACoSGuHtOdNdOG43J7MuIZNhzxDwtSVoekrdba7DMNUKWEUZboV4Dk1mbf?=
 =?us-ascii?Q?BpZHk8c878tZ5sK9RUNptpWt0egzto8Do4vYOxAw2i4hsr1lTygXh0Cfa+Gg?=
 =?us-ascii?Q?cNBQHLKS57/VB5sq9VwCfvijIwmDx/jjiYVO9nwhe4LdJHZiYyhgQIqVgTru?=
 =?us-ascii?Q?3/xHhJ/9n6u3CKrbfJfpd+EADswzZpzuT+3r0EYY0CPVMh2rSJCtFeJJIM7P?=
 =?us-ascii?Q?8k84ct4/GR/zI3meqd6ZQdWu/0Wt0ntA65ggR5kFNwkOFfpc8X5icETZTkbA?=
 =?us-ascii?Q?hKeMoCcIkTR6je4ay8D1bHQ0lVzHB0wPv4vJhg3u8iknpel3mzlz5QX3rpph?=
 =?us-ascii?Q?u8mdeC8uSui3SmnsUbbsFUY4YgolmrdICKCU1Glwc/T/DbgAgZ6EzCdT7Ul3?=
 =?us-ascii?Q?EpP6GhwsHHNkjYHmfsH63Wwoy3IN8JOUPLguDqPfzF7YfYcNfCGg2/P5teGn?=
 =?us-ascii?Q?q+lM8rg8p5mtey1cmsfR5yUQuuImcbexAs1z4fpM+vzE6IaurUw64PMHM1xZ?=
 =?us-ascii?Q?U3TBhGLq2QlXQHTkLLQLwUdOvQGSEMlQ1//2oeCHLzjU+zT96EXF+pwfjSM/?=
 =?us-ascii?Q?7FCDhC9HcGrdvPBpv3o9dwEXFY9+lh0G7YS10968EyP90w/LtweujAbJit3n?=
 =?us-ascii?Q?6qPTPIEoRkMAlX8xWuIrRmf6nHUdar3SNXSmgv8UzNuyk7URmfSyrNe/zsBD?=
 =?us-ascii?Q?kD3gWfUOXO/UsCPjWt1P7yeBbXBk74Hai0Vh8dfTdY//WjtqmzwQw9bn3TvL?=
 =?us-ascii?Q?5uQItE5hoKqjTKnaDYkiIJA6/VPusPDyesW4CwYZnrH6iXj4LyaDyaMcJb+i?=
 =?us-ascii?Q?Bainr2IO9TnnVJkIkWOTZYT3tdnsnG+kgRIc2SVqfqpuuUchQLd/9pb21J3x?=
 =?us-ascii?Q?lLaz3wbeua1sbDT5u+v+UO4xwVmjDcF9Go0rrAT7JV/aaO9CgQSjpuG8+Vg0?=
 =?us-ascii?Q?OML8x9yJEKHmWAKS5LmypmlRTMi6xGX2eO2ZS6D1JJMUgDQxUl4TcJuoT0O9?=
 =?us-ascii?Q?32P5+nEUUJ4dECCGA4b4Pv/x4NyhbIj76ygp/0oQH+phJE6VGzBUIH1wTxq1?=
 =?us-ascii?Q?JZC/TJKLlyaeCX6MTu2cMLjrCrcLc+QJdNTGqy1+wSVcnGMwhXHhg4ATmtDl?=
 =?us-ascii?Q?QEO4T6NXsnkDZhIt/GjHw4AjtAn+7Qc+f12BjL5ftGG8YYb2vppBhvoTy4ZU?=
 =?us-ascii?Q?g2h8s4D+IOHZ055RMj5uZqRY2CyzgQ6cK9k1aqJxyybrZJ0tEuo38LkevqVd?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ada48-5376-40cf-d680-08dbf0d36332
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 12:04:49.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTQ6vOBQVXiV1NGzDlPHbBODwzc5E2JJKgMinGvZbz3KRbh7kzTq2KbqhMoQpbaENTBHxyYa2WwxVG/JLrkUbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 06:34:16PM +0800, Jie Luo wrote:
> > > The PCS drivers in drivers/net/pcs/ should be in PHY side, such as
> > > pcs-lynx.c and pcs-xpcs.c, they are configuring the MDIO device
> > > registers.
> > 
> > Wrong. No they are not. Just because they are accessed via MDIO does
> > not mean they are in the PHY. MDIO can be used for more than just the
> > PHY, and is on a lot of platforms.
> > 
> > LX2160A for example has many MDIO buses, and the PCSes (of which there
> > are multiple inside the chip, and use pcs-lynx) are accessed through
> > the MDIO bus specific to each port. They are not MMIO mapped.
> > 
> > The same is true on stmmac platforms, where xpcs is used - xpcs is the
> > _MAC_ side PCS.
> > 
> > Sorry but you are wrong.
> > 
> 
> OK, but it creates the PCS driver based on the MDIO device in pcs-lynx.c
> looks like this PCS is located in PHY device from hardware perspective.

In some ways, this contradiction has a potato-patato aspect to it.
As Russell says, NXP devices do have internal SGMII/USXGMII/10GBASE-R
ports which use pcs-lynx.c to access the registers of the PCS layer
(which are on MDIO buses internal to the SoC). They could legally be
called PHYs, because they have all the layers that 802.3 says a PHY
should have: a PCS, a PMA and a PMD.

But what phylib understands a phy_device to be is a more restricted
definition than just "a PHY - any PHY". Originally, phylib considered a
struct phy_device to be something (a discrete chip) that has pins and a
phy_interface_t towards its host side, and pins + an ethtool_link_mode_bit_indices
on its media side.

Traditionally, the media side is exclusively copper (BASE-T, BASE-T1) or
fiber (BASE-SX/LX).

A struct phy_device was then also used with PHY_INTERFACE_MODE_INTERNAL
to represent the built-in BASE-T PHYs that are embedded within certain
small/medium business Ethernet switches. And then, more and more other
similar embedded copper PHYs.

The idea is that (1) a phy_device connects to a remote system, and
(2) the phylib API does not have insight into the components of the
PHY it controls: PCS, PMA, PMD. It's all just a monolithic struct phy_device.

Because there are serial phy_interface_t modes where the MAC also need a
PHY to even connect to the phylib PHY, a problem presented itself:
phylib only has support for a single phy_device. So a new framework
appeared: phylink, which uses the unmodified phylib layer for the
external PHY, but models the MAC-side PHY using a different API. Later
on, that API became the phylink_pcs.

To muddy the waters, a phylink_pcs structure usually connects to another
local component as described above, like a phylib PHY (on-board or on an
SFP module). But it can also connect directly to a remote system (like a
phy_device would). But the phylink_pcs is always integrated in silicon
with the MAC, and the "media side" of it is a phy_interface_t type, not
an ethtool_link_mode_bit_indices type.

Having a separate phylink_pcs is what allows us to work around phylib's
limitation of having a single phy_device. The reverse is also true: you
can have a single phylink_pcs, and that belongs to the client MAC driver.

The other layers (PMA/PMD) of the MAC-side PHY are modeled in the kernel
as a struct phy (https://docs.kernel.org/driver-api/phy/index.html), and
we have the phy_set_mode_ext() API for reconfiguring this layer to a
different mode. Again, this is not applicable for phylib PHYs, which are
monolithic.

Given the above definitions, what NXP has and drives with pcs-lynx.c is
not a struct phy_device, but a MAC-side PCS represented by a phylink_pcs.
It absolutely does not matter that the register access method for the
PCS is an internal MDIO bus. FWIW, the PMA/PMD layer is at
drivers/phy/freescale/phy-fsl-lynx-28g.c.

So, if put into the proper context, what Russell is saying is correct,
but I think you need a bit of history to not get even more confused
about why it is the way it is.
