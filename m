Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB117C8980
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjJMQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjJMQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:00:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1ABB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:00:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82914C433C8;
        Fri, 13 Oct 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697212822;
        bh=u+6i2j6XgDiZISn3nwFQCjd6YhiHVmta/eViuIK/P/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CSc2bD7eybZaki5AH35Q3D0dZDoo53pl+PYSUo9EomKRIaoJHSqPj4cDxXMwN8aGm
         s8jxTm77u1jwE5ztMBM69XYmuYNW7Rx60lWkqjqnucpgdgJlLByWgQFm4tJk84W8Iz
         MGXAeXbWyc6UzBF4pIN9SLdrfVOcuUGfDHd1KAOCCQthrP6ZKXOPqyNwpMpHZdXMiN
         Y1F0S4JYGLVWoi/fM0L9JdDHJZidNcfZlX6gxO/WQi0e3ez0zINVk8lyUt+8wvEct6
         4YHPpp9zkUsZffwZILf05ZOD2qEGx8AI6Eq+oGbBdIAE6RafGlUH8BVj1/8pgaOvFY
         lHNs3NzJMsYsg==
Date:   Fri, 13 Oct 2023 09:00:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231013090020.34e9f125@kernel.org>
In-Reply-To: <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 10:23:43 +0200 K=C3=B6ry Maincent wrote:
> > > +/*
> > > + * Hardware layer of the TIMESTAMPING provider
> > > + * New description layer should have the NETDEV_TIMESTAMPING or
> > > + * PHYLIB_TIMESTAMPING bit set to know which API to use for timestam=
ping.   =20
> >=20
> > If we are talking about hardware layers, then we shall use either=20
> > PHY_TIMESTAMPING or MAC_TIMESTAMPING. PHYLIB is the sub-subsystem to=20
> > deal with Ethernet PHYs, and netdev is the object through which we=20
> > represent network devices, so they are not even quite describing simila=
r=20
> > things. If you go with the {PHY,MAC}_TIMESTAMPING suggestion, then I=20
> > could see how we could somewhat easily add PCS_TIMESTAMPING for instanc=
e. =20
>=20
> I am indeed talking about hardware layers but I updated the name to use N=
ETDEV
> and PHYLIB timestamping for a reason. It is indeed only PHY or MAC timest=
amping
> for now but it may be expanded in the future to theoretically to 7 layers=
 of
> timestamps possible. Also there may be several possible timestamp within =
a MAC
> device precision vs volume.
> See the thread of my last version that talk about it:
> https://lore.kernel.org/netdev/20230511203646.ihljeknxni77uu5j@skbuf/
>=20
> All these possibles timestamps go through exclusively the netdev API or t=
he
> phylib API. Even the software timestamping is done in the netdev driver,
> therefore it goes through the netdev API and then should have the
> NETDEV_TIMESTAMPING bit set.

Netdev vs phylib is an implementation detail of Linux.
I'm also surprised that you changed this.

> > > + */
> > > +enum {
> > > +	NO_TIMESTAMPING =3D 0,
> > > +	NETDEV_TIMESTAMPING =3D (1 << 0),
> > > +	PHYLIB_TIMESTAMPING =3D (1 << 1),
> > > +	SOFTWARE_TIMESTAMPING =3D (1 << 2) | (1 << 0),   =20
> >=20
> > Why do we have to set NETDEV_TIMESTAMPING here, or is this a round-abou=
t=20
> > way of enumerating 0, 1, 2 and 3? =20
>=20
> I answered you above the software timestamping should have the
> NETDEV_TIMESTAMPING bit set as it is done from the net device driver.
>=20
> What I was thinking is that all the new timestamping should have
> NETDEV_TIMESTAMPING or PHYLIB_TIMESTAMPING set to know which API to pass
> through.
> Like we could add these in the future:
> MAC_DMA_TIMESTAMPING =3D (2 << 2) | (1 >> 0),
> MAC_PRECISION_TIMESTAMPING =3D (3 << 2) | (1 >> 0),
> ...
> PHY_SFP_TIMESTAMPING =3D (2 << 2) | (1 << 1),
> ...

What is "PRECISION"? DMA is a separate block like MAC and PHY.
