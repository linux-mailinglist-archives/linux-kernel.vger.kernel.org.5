Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA3792BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbjIERAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbjIEPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:20:31 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52FED;
        Tue,  5 Sep 2023 08:20:23 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 51DC686925;
        Tue,  5 Sep 2023 17:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693927221;
        bh=OG3VPJqPxqjuy7LBsAHIHZki/Tvp7RaVeVVqn9O5OHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANIdRQjY3Gx3QM8wLUA0q9c6d5U29WQ6iYw3ZxgIj3464HrLuCwsVA9Vd8hUwi3wu
         fLp2aIzUM4Uqd7Y9613hHT3pImC6SSFyaPXU/RpqY8ytWe4IUVombOpx+DFmKmgAH4
         LTmSYfSIls4k6ARQA9PnVW3mGqeSrLwd+p8lK7Zz9U7CnruHEcErvI04kmOYFC6Ml1
         HSv2IrIaAL6xS+do+/ZUSSn0t34Z/Iy6jhT6+bf2OmjbFSBheEdwpqcGoG3RZQG4Eb
         nwQiEjih1ovmQteUjtp9ig32VrOG3VjY1Bfi/zJ8zm5JnuJugyJ8kaFNJps+41QSnx
         +0vVmM6cX+wMA==
Date:   Tue, 5 Sep 2023 17:20:13 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905172013.7234d653@wsk>
In-Reply-To: <20230905130355.7x3vpgdlmdzg6skz@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230905103750.u3hbn6xmgthgdpnw@skbuf>
        <20230905131103.67f41c13@wsk>
        <20230905130355.7x3vpgdlmdzg6skz@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//XFdAs9lKN2EjwgxCYc7413";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//XFdAs9lKN2EjwgxCYc7413
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 05, 2023 at 01:11:03PM +0200, Lukasz Majewski wrote:
> > > > +/* The KSZ9477 provides following HW features to accelerate
> > > > + * HSR frames handling:
> > > > + *
> > > > + * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
> > > > + * 2. RX PACKET DUPLICATION DISCARDING
> > > > + * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS
> > > > FILTERING
> > > > + *
> > > > + * Only one from point 1. has the NETIF_F* flag available.
> > > > + *
> > > > + * Ones from point 2 and 3 are "best effort" - i.e. those will
> > > > + * work correctly most of the time, but it may happen that some
> > > > + * frames will not be caught. Hence, the SW needs to handle
> > > > those
> > > > + * special cases. However, the speed up gain is considerable
> > > > when
> > > > + * above features are used.
> > > > + *
> > > > + * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled,
> > > > as HSR frames
> > > > + * can be forwarded in the switch fabric between HSR ports.   =20
> > >=20
> > > How do these 2 concepts (autonomous forwarding + software-based
> > > elimination of some frames) work together? If software is not the
> > > sole receiver of traffic which needs to be filtered further, and
> > > duplicates also get forwarded to the network, does this not break
> > > the HSR ring?=20
> >=20
> > Autonomous forwarding is based on KSZ9477, having the HSR ports
> > "bridged" to send frames between them.
> >=20
> > Then, there is also based on HSR tag, and SA in-KSZ9477 feature RX
> > packet duplication discarding which will discard duplicated frames.
> >=20
> > Last but not least the - packet loop prevention.
> >=20
> > My understanding is as follows:
> >=20
> > 1. RX packet duplication removes copy of a frame, which is
> > addressed to cpu port of switch. =20
>=20
> Does the duplicate elimination function only do that, as you say, or
> is it supposed to also eliminate duplicates for packets flooded to 2
> ports as well (the host port, and the other ring port)?
>=20

In the "RX PACKET DUPLICATION DISCARDING" (from [1]) the hash of DA and
SA and seq number is used to assess if received frame is a duplicated.

----8<-------
If a matching (based on above??) frame has already been received on the
other port, the frame is dropped. If not, then standard forwarding rules
apply.=20
---->8-------

> If the latter, then it will fail to eliminate duplicates for packets
> that didn't visit the CPU. So the ring will rely on the self-address
> filtering capability of the other devices, in order not to collapse.
> I see that the software implementation also offers self-address
> filtering in hsr_handle_frame() -> hsr_addr_is_self(), but I don't see
> anything making that mandatory in IEC 62439-3:2018. Can we assume that
> the other ring members will know how to deal with it?
>=20
> > 2. The "bridge" of HSR passes frames in-KSZ9477, which are not
> > addressed to this cpu host (between other HSR nodes). =20
>=20
> How is the switch supposed to know which packets are addressed to this
> CPU port and which are not? I expect separate answers for unicast,
> multicast and broadcast.
>=20
> > 3. Packet loop prevention - the HSR packet with SA of note which
> > sent it - is not further forwarded.
> >  =20
> > > What are the causes due to which self-address filtering and
> > > duplicate elimination only work "most of the time"? =20
> >=20
> > Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
> > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Ava=
ilability-Seamless-Redundancy-Application-Note-00003474A.pdf
> > =20
>=20
> Ok, so the limitation is a race condition in hardware such that, when
> duplicate packets are received on member ports very close in time to
> each other, the hardware fails to detect that they're duplicates.

+1.

>=20
> > > > +	/* Enable discarding of received HSR frames */
> > > > +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> > > > +	data |=3D HSR_DUPLICATE_DISCARD;
> > > > +	data &=3D ~HSR_NODE_UNICAST;
> > > > +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> > > > +
> > > > +	/* Self MAC address filtering for HSR frames to avoid
> > > > +	 * traverse of the HSR ring more than once.
> > > > +	 *
> > > > +	 * The HSR port (i.e. hsr0) MAC address is used.
> > > > +	 */
> > > > +	for (i =3D 0; i < ETH_ALEN; i++) {
> > > > +		ret =3D ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> > > > hsr->dev_addr[i]);
> > > > +		if (ret)
> > > > +			return ret;   =20
> > >=20
> > > FWIW:
> > > https://lore.kernel.org/netdev/155ff37f-43d5-5fe0-6de4-c4639909553d@g=
mail.com/
> > > Some coordination will be required regarding the MAC address that
> > > the switch driver needs to program to these registers.  =20
> >=20
> > Writing of this MAC address is _required_ for PREVENTING PACKET
> > LOOP IN THE RING BY SELF-ADDRESS FILTERING feature. =20
>=20
> In case it was not clear, I was talking about coordination between you
> and Oleksij. He needs to program the same register for Wake on LAN.

Ok. Thanks for the information.

>=20
> > In the ifconfig output - the lan1, lan2 and hsr0 shall all have the
> > same MAC address assigned.
> >=20
> > I simply take the hsr0 mac address.
> >  =20
> > > It seems that it is not single purpose. =20
> >=20
> > At least in the case of HSR it looks like single purpose (for the
> > loop prevention). =20
>=20
> And for WoL, REG_SW_MAC_ADDR_0 is also single purpose. And for the
> MAC SA in the generated PAUSE frames, also single purpose. Single +
> single + single =3D ?
>=20
> Being a common register for multiple functions, I hope that it won't
> be the users who discover than when multiple functionalities are used
> in tandem (like WoL+HSR), they partially overwrite what the other has
> done.

This cannot be excluded, yes. However, I think that HSR ports will not
use WoL...

>=20
> So, by coordination, I mean something like a cohesive way of thinking
> out the driver.
>=20
> For WoL/pause frames, the linked discussion suggested that the switch
> MAC address could be kept in sync with the DSA master's MAC address.
>=20
> Could that also work here, and could we add a restriction to say
> "Offload not supported for HSR device with a MAC address different
> from the DSA master" and return -EOPNOTSUPP in ksz_hsr_join()? Then
> ksz9477_hsr_join() would not modify this register.

In my case - the lanX ports (and hsr0) gets the same MAC address as it
is assigned to eth0 (the cpu port).

So, yes I can add such code to avoid problems.

>=20
> > > > +	/* Enable per port self-address filtering */
> > > > +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
> > > > PORT_SRC_ADDR_FILTER, true);
> > > > +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> > > > +		     PORT_SRC_ADDR_FILTER, true);
> > > > +
> > > > +	/* Setup HW supported features for lan HSR ports */
> > > > +	slave =3D dsa_to_port(ds, port)->slave;
> > > > +	slave->features |=3D KSZ9477_SUPPORTED_HSR_FEATURES;
> > > > +
> > > > +	slave =3D dsa_to_port(ds, partner->index)->slave;
> > > > +	slave->features |=3D KSZ9477_SUPPORTED_HSR_FEATURES;   =20
> > >=20
> > > Can the code that is duplicated for the partner port be moved to
> > > the caller? =20
> >=20
> > I've followed the convention from xrs700x driver, where we only make
> > setup when we are sure that on both HSR ports the "join" has been
> > called. =20
>=20
> If code that is duplicated for both member ports can be moved to code
> paths that get executed for each individual port, then the resulting
> driver code may turn out to be less complex.
>=20
> It's not a big deal if it can't, and maintaining a sane operating mode
> in that transient state (HSR device with a single member port) is
> obviously much more important. But the question was if it can, and I
> don't think you've answered that?

I think that it would be possible to have single execution patch per
joining port (for example join is called on lan1 and then on lan2).

I'm concerned with writing common registers - for example
REG_HSR_PORT_MAP. If there are no side effects (like hsr port support
must be set for both at once), we can try to make single execution path.

Links:

[1] -
https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availab=
ility-Seamless-Redundancy-Application-Note-00003474A.pdf



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//XFdAs9lKN2EjwgxCYc7413
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3Ry0ACgkQAR8vZIA0
zr1Kjgf8CGKPYInx1vdmDl3uFjIgo0UcvAg5fFGjXzaZ1DUpN53Ag40mBaXO0nuj
A+2OfuyyhkbjG4997c5eUhJg1GG6dK8UebcPWtfj1HkHRIAj+hgcCf10UVBh5Un+
PyxIGhRMGJKfKJatdvNVCqgqiWwp60wKhPk+vCgZo2lyQ/1DXF5syR4tlZBpzKpg
FhoquSa68pBtaQOtWAO11/MEqnektcGtfuFCg6P2mQOq9itZEKLGGe77ISJG+GPd
rs0cS9/4b4qZjLqi5awsAtEC6K5RX4kc3z2MJ1igP/ynybcpvoPDKoNmi8YvpDS+
VjEcLK7LdRCK/1T0l0GNfhVk6zQlbQ==
=sP6j
-----END PGP SIGNATURE-----

--Sig_//XFdAs9lKN2EjwgxCYc7413--
