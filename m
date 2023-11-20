Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622787F14AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjKTNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjKTNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:49:38 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F39116;
        Mon, 20 Nov 2023 05:49:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 143D220010;
        Mon, 20 Nov 2023 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700488172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GFf2MmlZRbRryB9gq03P/QdrczVE9sVH3xjYJA5blE=;
        b=WU9e64b7dxhhmS5tY3Ewf9DZhZ4FNQbEc1dqBCABIwKqcCTEGu3N5XUxqYFN6+1NwBXNmL
        4K0FCzqi7f5BmNvus4CG5MVVkI424l1fUBhRVFGCAMGk9L5sWQilQuHGK+Dxl8QpDwO0ns
        YxQzQQKvVzIk1c/q7yn4oIIrcGP4tI7+nZGRclVear2DMioqjTi7fvoj0KtQie5zIZjbwR
        JvpDlLMWXFp8aNbILVoYqrx2asmCQTlgH6WDpTGQhX/QpU4kfMDDztRA0OhcflpcpqSYij
        u6rH1gWnoPZYryN9ahnkBGNIP6acA8bIUvsQRn200q0fwWgqsrlfHN1p6XNBow==
Date:   Mon, 20 Nov 2023 14:49:29 +0100
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
Message-ID: <20231120144929.3375317e@kmaincent-XPS-13-7390>
In-Reply-To: <20231120120601.ondrhbkqpnaozl2q@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
        <20231118183433.30ca1d1a@kernel.org>
        <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
        <20231120105255.cgbart5amkg4efaz@skbuf>
        <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
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

On Mon, 20 Nov 2023 14:06:01 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Mon, Nov 20, 2023 at 12:14:40PM +0100, K=C3=B6ry Maincent wrote:
> > > Does your UAPI proposal make it possible in any way to select
> > > timestamping in phylib PHY A rather than PHY B? Or do you think it is
> > > extensible to support that, somehow? =20
> >=20
> > It does not support it for now.
> > I didn't want to base my work on his series as it could work without it=
 for
> > now and I didn't want to wait to have his series accepted. It is more a
> > future possible support as I don't have anything to test it and I don't
> > know if such hardware exists right now.
> > I think it will be extensible to support that, my thinking was to create
> > this struct in net_device struct:
> >=20
> > struct {
> > 	enum layer;
> > 	u32 id;
> > } ts;
> >=20
> > With id saving the phy_index of the PHY X used when the layer PHY is
> > selected. This id could also be used to store the timestamp point in ca=
se
> > of several timestamp in a MAC. =20
>=20
> Ok, and I suppose the "u32 id" would be numerically the same as the
> ETHTOOL_A_HEADER_PHY_INDEX nlattr that Maxime is proposing?

Yes.

> The next question would be: if a driver performs PHY management in
> firmware, and does not use phylib, how should user space interact with it?
> What timestamping layer and upon what should the ID be chosen?

In that case it could be the second options I refereed to.
Using the id to select the right timestamp within the NIC driver.
It indeed won't be called PHY timestamping as it is managed by the NIC firm=
ware
but as it is managed by only one firmware and driver using the id to separa=
te
the available timestamp seems a good idea.

Another solution would be to create another value in the layer enumeration.
PHY_NIC_TIMESTAMPING? Better idea? I am not good at naming.
=20
> Finally (and unrelated to the question above), why is SOFTWARE_TIMESTAMPI=
NG
> even a layer exposed in the UAPI? My understanding of this patch set is
> that it is meant to select the source of hardware timestamps that are
> given to a socket. What gap in the UAPI does the introduction of a
> SOFTWARE_TIMESTAMPING hwtstamping layer cover?

As I explained to Jakub:
The software timestamping comes from the MAC driver capabilities and I deci=
ded
to separate software and MAC timestamping. If we select PHY timestamping we
can't use software timestamping and for an user, selecting the MAC as
timestamping seems not logical to use software timestamping (I got confused
myself when I first dig into it long time ago). Be able to select
directly Software timestamping seems appropriate and won't bring any harm. =
What
do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
