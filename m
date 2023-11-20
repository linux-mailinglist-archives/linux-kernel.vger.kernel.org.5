Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9797F1671
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjKTOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjKTOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:54:21 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721810CC;
        Mon, 20 Nov 2023 06:53:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A3A32000C;
        Mon, 20 Nov 2023 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700492027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjKENZFyX54rFkqeyuDYUZ6Ty9kSEaFLut91D/l6Ncg=;
        b=BQLcaqE8ggFlKmCl9aqn13XcvzJyg3PLP8bx3vEuNOV6zJwmyVQkvuWjtn62y6zKtOK5pk
        cpOmlwAo1j7ndcps4ZewnhSn0sH/iiZBIbC4U6mYhnVog8hynOmBn8Spa1R3qNxySHcNep
        k27e1yImpOd35sY1cPkUV1pfLyKSpcGY4qo9MatqtQuxwIq3tiWn2+gYRvzyymtwFiQ3ce
        JO+NzWM/CZlchn6wGcjoAeoa0fg03J18Isui6BNvfoEGVqw5xJUVpPECRsu8em/G+ygzyW
        LGSBRhhu5RgcqafJMJwtswsEvg4gI+Gvshhvg90NwjlOvZonwk96FRh9+ONqYw==
Date:   Mon, 20 Nov 2023 15:53:44 +0100
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
Message-ID: <20231120155344.14cd69d9@kmaincent-XPS-13-7390>
In-Reply-To: <20231120142316.d2emoaqeej2pg4s3@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
        <20231118183433.30ca1d1a@kernel.org>
        <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
        <20231120105255.cgbart5amkg4efaz@skbuf>
        <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
        <20231120144929.3375317e@kmaincent-XPS-13-7390>
        <20231120142316.d2emoaqeej2pg4s3@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 16:23:16 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Mon, Nov 20, 2023 at 02:49:29PM +0100, K=C3=B6ry Maincent wrote:
> > > The next question would be: if a driver performs PHY management in
> > > firmware, and does not use phylib, how should user space interact wit=
h it?
> > > What timestamping layer and upon what should the ID be chosen? =20
> >=20
> > In that case it could be the second options I refereed to.
> > Using the id to select the right timestamp within the NIC driver.
> > It indeed won't be called PHY timestamping as it is managed by the NIC
> > firmware but as it is managed by only one firmware and driver using the=
 id
> > to separate the available timestamp seems a good idea.
> >=20
> > Another solution would be to create another value in the layer enumerat=
ion.
> > PHY_NIC_TIMESTAMPING? Better idea? I am not good at naming. =20
>=20
> The point I was trying to make is that your current choice of exposing
> PHY_TIMESTAMPING in UAPI, when it really only refers to phylib PHYs,
> would lead exactly to this sort of UAPI balkanization where everyone
> wants to add more timestamping layers, and to define IDs to be specific
> to their own invented layer. Maybe the concept of timestamping layers is
> not what user space should see at all.
>=20
> In previous email discussions, I was proposing to Jakub and you "what if
> we didn't let user space select a specific layer like PHY_TIMESTAMPING
> or MAC_TIMESTAMPING at all, but just select a specific phc_index as the
> provider of hardware timestamps"?
>=20
> The limitation we're trying to lift is that currently, there can be only
> a single provider of hardware timestamps. We make that provider customiza=
ble.
> There is already a good understanding from user space that, if "ethtool -=
T"
> on an interface says there is no PHC, then there are going to be no
> hardware timestamps. So I thought it would be much more intuitive if the
> timestamping layer could be selected by the user merely by an unified
> phc_index (provided by a phylib phy or firmware based driver or whatever),
> and everything else would just be an implementation detail of the kernel.
> No one should care that it's a phylib phy, and shouldn't use a different
> procedure to identify its ID based on whether it's a phylib or firmware
> PHY.
>=20
> It's a bit hard to align my expectation of what this series should offer
> with yours. I think we're talking past each other, which unfortunately
> makes me lose track and interest. I wish you could have answered my
> earlier question about this alternative proposal.
> https://lore.kernel.org/netdev/20231013170903.p3ycicebnfrsmoks@skbuf/

I did thought about it but I got stuck by the case of hardware timestamping
without PHC. Richard explained the reason of its existence here:
https://lore.kernel.org/netdev/ZS3MKWlnPqTe8gkq@hoboy.vegasvil.org/#t

Maybe I got a bit stuck in my implementation and should investigate more yo=
ur
proposition and how to deal with this case. Do you have an idea on how to
solve it?

> > > Finally (and unrelated to the question above), why is
> > > SOFTWARE_TIMESTAMPING even a layer exposed in the UAPI? My understand=
ing
> > > of this patch set is that it is meant to select the source of hardware
> > > timestamps that are given to a socket. What gap in the UAPI does the
> > > introduction of a SOFTWARE_TIMESTAMPING hwtstamping layer cover? =20
> >=20
> > As I explained to Jakub:
> > The software timestamping comes from the MAC driver capabilities and I
> > decided to separate software and MAC timestamping. =20
>=20
> Why? What was the problem? This confuses me because I don't understand
> what is the problem that the solution is trying to address, and whether
> the solution is orthogonal to all the other UAPI that exists for
> software and hardware timestamping at the socket layer - which AFAIK can
> happily coexist.
>=20
> > If we select PHY timestamping we can't use software timestamping and
> > for an user, selecting the MAC as timestamping seems not logical to
> > use software timestamping (I got confused myself when I first dig into
> > it long time ago). Be able to select directly Software timestamping
> > seems appropriate and won't bring any harm. What do you think? =20
>=20
> Hmm, can you please explain what is the reason why software timestamping
> can't coexist with PHY timestamping? It is a genuine question to which I
> don't have an answer - I haven't used PHY timestamping. It must be
> something specific to that, since I do know that MAC + software
> timestamping work simultaneously just fine.

The software timestamp is managed through the MAC driver calling
skb_tx_timestamp() function. The PHY driver does not call it, that's why th=
ere
is no software timestamping in PHY driver capabilities. Also the PHY driver
doesn't know if the MAC driver support it so it currently can not coexist w=
ith
PHY timestamping.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
