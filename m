Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAAC79E939
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbjIMN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbjIMN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:26:39 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7319BF;
        Wed, 13 Sep 2023 06:26:34 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E17D686CF0;
        Wed, 13 Sep 2023 15:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694611592;
        bh=ZoRncom13+1SucH+6e/ihE+z4HAqO3ZXwNnLkiQPJG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eYeiKT1OSjO2Lc0EddsbgS0RUWNQcHHNn3WiyvEqfZxYavWSQtc2osral0T8A+9KB
         YDs9heCykYo0oW2CV2i2aNGNie+qSROc4KLqoCpoxHPzPk1Jn4oQuLVgCxM/E7/y5B
         BjPeumUd4bIPh1MsRc/x2k/GzgpfUvAt7LS3HDUAibed7WeXNutNZImDnV9/FnZQHO
         wNqNSf4uilGAzzYfnu+dWBKyx76N6pLPcBW98D6rA/be7JLKz3kb9VsKqD/Abs26I6
         M9DrMITJOseHmesv9oHZ3V0e1wtldQY659Z91jMQLk1fr5RmvqoNVD+jlXZl3kpqnC
         5wGFxKxW4Agzw==
Date:   Wed, 13 Sep 2023 15:26:25 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <20230913152625.73e32789@wsk>
In-Reply-To: <61a58960-f2f3-4772-8f12-0d1f9cfec2c5@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
        <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
        <20230913104458.1d4cdd51@wsk>
        <61a58960-f2f3-4772-8f12-0d1f9cfec2c5@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ge1Ec=QvMDcE9ShpkKDmwRV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ge1Ec=QvMDcE9ShpkKDmwRV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > Just maybe mine small remark. IMHO the reset shall not pollute the
> > IRQ hander. The RESETC is just set on the initialization phase and
> > only then shall be served. Please correct me if I'm wrong, but it
> > will not be handled during "normal" operation. =20
>=20
> This is something i also wondered. Maybe if the firmware in the
> MAC-PHY crashes, burns, and a watchdog reset it, could it assert
> RESETC? I think maybe a WARN_ON_ONCE() for RESETC in the interrupt
> handler would be useful, but otherwise ignore it. Probe can then poll
> during its reset.
>=20
> > > +				regval =3D RESETC;
> > > +				/* SPI host should write RESETC
> > > bit with one to
> > > +				 * clear the reset interrupt
> > > status.
> > > +				 */
> > > +				ret =3D oa_tc6_perform_ctrl(tc6,
> > > OA_TC6_STS0,
> > > +
> > > &regval, 1, true,
> > > +
> > > false); =20
> >=20
> > Is this enough to have the IRQ_N deasserted (i.e. pulled HIGH)?
> >=20
> > The documentation states it clearly that one also needs to set SYNC
> > bit (BIT(15)) in the OA_CONFIG0 register (which would have the
> > 0x8006 value).
> >=20
> > Mine problem is that even after writing 0x40 to OA_STATUS0 and
> > 0x8006 to OA_CONFIG0 the IRQ_N is still LOW (it is pulled up via
> > 10K resistor).
> >=20
> > (I'm able to read those registers and those show expected values) =20
>=20
> What does STATUS0 and STATUS1 contain?

STATUS0 =3D> 0x40, which is expected.

Then I do write 0x40 to STATUS0 -> bit6 (RESETC) is R/W1C

After reading the same register - I do receive 0x00 (it has been
cleared).

Then I write 0x8006 to OA_CONFIG0.

(Those two steps are regarded as "configuration" of LAN865x device in
the documentation)

In this patch set -> the OA_COFIG0 also has the 0x6 added to indicate
the SPI transfer chunk.

Dump of OA registers:
{0x11, 0x7c1b3, 0x5e5, 0x0, 0x8006, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x3000, 0x1fbf, 0x3ffe0003, 0x0, 0x0}

Status 0 (0x8) -> 0x0
Status 1 (0x9) -> 0x0

> That might be a dumb question,
> i've not read the details for interrupt handling yet, but maybe there
> is another interrupt pending? Or the interrupt mask needs writing?

All the interrupts on MASK{01} are masked.=20

Changing it to:
sts &=3D ~(OA_IMASK0_TXPEM | OA_IMASK0_TXBOEM | OA_IMASK0_TXBUEM |
OA_IMASK0_RXBOEM | OA_IMASK0_LOFEM | OA_IMASK0_HDREM

doesn't fix this problem.

>=20
> > Was it on purpose to not use the RST_N pin to perform GPIO based
> > reset?
> >=20
> > When I generate reset pulse (and keep it for low for > 5us) the
> > IRQ_N gets high. After some time it gets low (as expected). But
> > then it doesn't get high any more. =20
>=20
> Does the standard say RST_N is mandatory to be controlled by software?
> I could imagine RST_N is tied to the board global reset when the power
> supply is stable.

It can be GPIO controlled. However, it is not required. I've tied it to
3V3 and also left NC, but no change.

> Software reset is then used at probe time.

I've reconfigured the board to use only SW based reset (i.e. set bit0
in OA_RESET - 0x3).

>=20
> So this could be a board design decision. I can see this code getting
> extended in the future, an optional gpiod passed to the core for it to
> use.

I can omit the RST_N control. I'd just expect the IRQ_N to be high
after reset.

>=20
> > > msecs_to_jiffies(1)); =20
> >=20
> > Please also clarify - does the LAN8651 require up to 1ms "settle
> > down" (after reset) time before it gets operational again? =20
>=20
> If this is not part of the standard, it really should be in the MAC
> driver, or configurable, since different devices might need different
> delays. But ideally, if the status bit says it is good to go, i would
> really expect it to be good to go. So this probably should be a
> LAN8651 quirk.

The documentation is silent about the "settle down time". The only
requirements is for RST_N assertion > 5us. However, when the IRQ_N goes
low, and the interrupt is served - it happens that I cannot read ID
from the chip via SPI.

>=20
> 	Andrew

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ge1Ec=QvMDcE9ShpkKDmwRV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUBuIEACgkQAR8vZIA0
zr0LmwgAriZRZHrUZYrvUO6mWWYXT+EjQutiLaLgNI0EQune4tI0ckUgCrvmRtJ0
qz7QWwjXwK7dn9qVfNfeaIq0BpAo7+x1a7P0w/gZU1T8iJB4GvK/VMx5lYia56Ty
72KLh5hX49NZBvLe6bijejeNlb5WTFSV9oTxjtEUdyMQJByD8DLfZKzPRwVHbbAE
5TJIUWsZ0dZA9b4DOndba9sOPpBE1SDClmA8lSZfBtSlTC/3ZXyMo76DGqHfMXxU
zx5ldUIBKOBmrinUcakiyLRfjU/FKwM0queR5E5Jk/MfLcDvKW4IGe6G6p2iAL4t
zuKaHXG9uaVWfX15Jng+/MDMVnv+GQ==
=IB3L
-----END PGP SIGNATURE-----

--Sig_/ge1Ec=QvMDcE9ShpkKDmwRV--
