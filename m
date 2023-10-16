Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0F7CACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjJPPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJPPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:00:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A6AB;
        Mon, 16 Oct 2023 08:00:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24F11C000F;
        Mon, 16 Oct 2023 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697468434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppkDtMZrQStND01nwr+Zoe8BhS+PL2DK/7cIl9/gVis=;
        b=Tunkb17v62OZltx/uVcuSmnnpvWaf7eWs14cCjQdXud+YiNmf9b8dfoPyPsytcqbQeQA7L
        VjDS1Pg9jpuQnAnijOqM3DGaanf6fTb5Cf8aMTzJjn1GojBFJ7s0YsVS6fIQ9bzpn/+Qfs
        Jf4Nu8NbRMdud4fuJhsLVQEHgho6QWEEf6bbp6SkDP8UqjCabpuvecGIHcNQzgQG4kp0nG
        qjwaADz2RPE6f+A1hOT/B0vSjFEZK8mHoBAoCnRLg3U5QtwvNedz2MOi0j/V/BKC0HSURL
        eg3XISnf5MiyIMfl1O/nq/5YUUH6KZb4EHOffsD4rvWbrLqA7e6bvD2XMcSuhg==
Date:   Mon, 16 Oct 2023 17:00:27 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
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
Message-ID: <20231016170027.42806cb7@kmaincent-XPS-13-7390>
In-Reply-To: <20231016072204.1cb41eab@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
        <20231016124134.6b271f07@kmaincent-XPS-13-7390>
        <20231016072204.1cb41eab@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 07:22:04 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 16 Oct 2023 12:41:34 +0200 K=C3=B6ry Maincent wrote:
> > > Netdev vs phylib is an implementation detail of Linux.
> > > I'm also surprised that you changed this.   =20
> >=20
> > This is the main reason I changed this. This is Linux implementation
> > purpose to know whether it should go through netdev or phylib, and then
> > each of these drivers could use other timestamps which are hardware
> > related. =20
>=20
> For an integrated design there's 90% chance the stamping is done=20
> by the MAC. Even if it isn't there's no difference between PHY
> and MAC in terms of quality.

Ok, but there might be quality difference in case of several timestamp
configuration done in the MAC. Like the timestamping precision vs frequency
precision. In that case how ethtool would tell the driver to switch between
them?

My solution could work for this case by simply adding new values to the enu=
m:

enum {
	NETDEV_TIMESTAMPING =3D (1 << 0),
	PHYLIB_TIMESTAMPING =3D (1 << 1),
	MAC_TS_PRECISION =3D (1 << 2)|(1 << 0),
	MAC_FREQ_PRECISION =3D (2 << 2)|(1 << 0),
}

Automatically Linux will go through the netdev implementation and could pass
the enum value to the netdev driver.

> But there is a big difference between MAC/PHY and DMA which would
> both fall under NETDEV?

Currently there is no DMA timestamping support right? And I suppose it fill=
 fall
under the net device management?

In that case we will have MAC and DMA under netdev and PHY under phylib and
we won't have to do anything more than this timestamping management patch:=
=20
https://lore.kernel.org/netdev/20231009155138.86458-14-kory.maincent@bootli=
n.com/
