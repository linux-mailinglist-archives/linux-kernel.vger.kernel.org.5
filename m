Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20777F117C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjKTLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjKTLOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:14:50 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55890F0;
        Mon, 20 Nov 2023 03:14:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98CF31C000D;
        Mon, 20 Nov 2023 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fOmr1EeD2uGJyE5b6S6DHbDXU7wDK5HnO7BStGLZ7U=;
        b=ZmThG8/njdOgch0QqfERanqoa7ROiFYwMdVehhBXSBXv6M/Bs5YtwXRvadRrFJKOK2jJZ2
        ykPahvc5xvDZcxQSqPm3VLdqOqG4oLhrwr1/qsZBeMZoiviapny0f5T4xfNtVtC5UU58gy
        Y0R3Eg3Pne48VT1UfGWZz2PjmtbNvL3uOS89a4USeBNd8gGO7lgLCndb29rnWgDBPjXGZX
        7GyDSWEoJfXwckKtkkFHVnFoKVPbPPiwYMGvuaQrNbP1mwyIPIPEBEp5ZNrV0YZz4xutdB
        xHWmRNHnXfSqMO9PWRm88UhBgOjb/qnT9DnY6sdcTdL8Ks2Nl5N6AVMyohi0RQ==
Date:   Mon, 20 Nov 2023 12:14:40 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
In-Reply-To: <20231120105255.cgbart5amkg4efaz@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
        <20231118183433.30ca1d1a@kernel.org>
        <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
        <20231120105255.cgbart5amkg4efaz@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 12:52:55 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> > > So you only support PHYLIB?
> > >=20
> > > The semantics need to be better documented :( =20
> >=20
> > Yes as we don't really know how each MAC deal with the timestamping
> > before ndo_hwstamp_get/set. Using phylib only allows us to be sure these
> > NDO are implemented and the management of timestamping is coherent in t=
he
> > MAC. Also It will push people to move on to these NDOs.
> >=20
> > Ok I will add documentation.
>=20
> When Jakub says "the semantics need to be better documented", I'm also
> thinking of a different direction.
>=20
> From what I understand, Maxime is working on representing multiple
> phylib PHYs in the UAPI:
> https://patchwork.kernel.org/project/netdevbpf/cover/20231117162323.62697=
9-1-maxime.chevallier@bootlin.com/

Yes I am also following his patch series.=20
=20
> Does your UAPI proposal make it possible in any way to select
> timestamping in phylib PHY A rather than PHY B? Or do you think it is
> extensible to support that, somehow?

It does not support it for now.
I didn't want to base my work on his series as it could work without it for=
 now
and I didn't want to wait to have his series accepted. It is more a future
possible support as I don't have anything to test it and I don't know if su=
ch
hardware exists right now.
I think it will be extensible to support that, my thinking was to create th=
is
struct in net_device struct:

struct {
	enum layer;
	u32 id;
} ts;

With id saving the phy_index of the PHY X used when the layer PHY is select=
ed.
This id could also be used to store the timestamp point in case of several
timestamp in a MAC.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
