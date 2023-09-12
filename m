Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB379D321
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjILOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjILODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:03:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978D10CE;
        Tue, 12 Sep 2023 07:03:46 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E9A5986CE8;
        Tue, 12 Sep 2023 16:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694527413;
        bh=7RkUAGMCfi7iAUFa72vwf8XSB8v0QaeVARDr2wGADh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s1I8iO7W5/SoLJTcrXgXZQ1j1MKBG5krveDxaVV/WI04d4dWKlyq1WEAq6vwoV7cL
         anrRH/Ldo+/iBRQdaKUdZ9D+eIQgC38d2vD17MP9DAKAyNIdOuWvroQDxkMsEsvhRy
         sZ1RAjHp0iO4g9aMFKNirrloIULsFToR5x7JziirhxCDpyVEY2JZKze8Lqa6xfrfao
         Sn7CuVKzjeqOp1HUXCHypm+Sy5A+LgXy59kV6Wh9krCp0bkCE+aVubJ9SlMZ0Uxoue
         pr918rya5ck1Ac8Sqe2WnS4MSKB56iPeqUBIVIl2zDIaQE84Z4+IjHHX2HBACPdNiD
         bveebMahdGMOA==
Date:   Tue, 12 Sep 2023 16:03:26 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230912160326.188e1d13@wsk>
In-Reply-To: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
        <20230911165848.0741c03c@wsk>
        <20230911160501.5vc4nttz6fnww56h@skbuf>
        <20230912101748.0ca4eec8@wsk>
        <20230912092909.4yj4b2b4xrhzdztu@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Kz8AWmYzMdcebRSB9lKr2n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Kz8AWmYzMdcebRSB9lKr2n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 12, 2023 at 10:17:48AM +0200, Lukasz Majewski wrote:
> > IMHO, somebody who will use HSR will not fiddle with mac addresses
> > of LAN1 and ETH0. It will be setup by savvy user once at boot up. =20
>=20
> The point is, it has to work in all configurations that are accepted
> by the kernel.
>=20
> > Please correct me if I'm wrong, but the above issue (with lack of
> > sync of mac address change in DSA master and its ports) seems to be
> > affecting HSR support in a minimal way (when considering the
> > above). =20
>=20
> It's a different (and very old) bug for sure. But it has impact upon
> the v4 patch set as you've presented it here.
>=20
> > If I may ask - what is your suggestion to have the HSR join feature
> > merged for KSZ9477 SoC ? =20
>=20
> Anything that makes sense and works is worth considering.
>=20
> For example, one can argue that since we already have this pattern in
> 2 places in net/dsa/slave.c:
>=20
> 	/* If the port doesn't have its own MAC address and relies on
> the DSA
> 	 * master's one, inherit it again from the new DSA master.
> 	 */
> 	if (is_zero_ether_addr(dp->mac))
> 		eth_hw_addr_inherit(dev, master);
>=20
> then the consistent way to react to NETDEV_CHANGEADDR events on the
> master is to change the user ports' MAC address yet again, to track
> the master.
>=20
> In any case, as long as it's the DSA master's address that we program
> to hardware, then I see it as inevitable to add a new struct
> dsa_switch_ops :: master_addr_change() function, similar to
> master_state_change(). The driver would always be notified of the
> current (even initial) MAC address, and it could update the hardware
> registers (for WoL, pause frames and HSR self-address filtering, in
> this case).
>=20
> The above 2 changes could be one way to ensure that if a HSR device
> was accepted for offload initially, it will remain in a configuration
> that will keep working.
>=20

Please correct my understanding. The above change would affect the
whole DSA subsystem. It would require to have the core DSA modified and
would affect its operation?

>=20
> Or you can argue that dragging the DSA master into the discussion
> about how we should program REG_SW_MAC_ADDR_0 is a complication.

Yes, it is IMHO the complication.

> An
> API internal to the microchip ksz driver could be added, where the
> user ports on which the various specialty features are enabled (HSR,
> WoL) take a reference on the REG_SW_MAC_ADDR_0 with their MAC address.
> If the reference on REG_SW_MAC_ADDR_0 gets bumped from 0 to 1, the
> hardware is programmed with the requesting port's MAC address. If the
> reference is already elevated, then a request to increase it, coming
> from another port, is accepted or denied, depending on whether the MAC
> address of that port is equal to what's programmed into
> REG_SW_MAC_ADDR_0 or not.
> The refusal gets propagated to the user,
> together with an informative extack message. The ports which hold a
> reference on REG_SW_MAC_ADDR_0 cannot have their MAC address changed
> - and for this, you'd have to add a hook to dsa_switch_ops (and thus
> to the driver) from dsa_slave_set_mac_address().
>=20

git grep -n "REG_SW_MAC_ADDR_0"
drivers/net/dsa/microchip/ksz8795_reg.h:326:#define REG_SW_MAC_ADDR_0
        0x68=20
drivers/net/dsa/microchip/ksz9477.c:1194:
     ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,

drivers/net/dsa/microchip/ksz9477_reg.h:169:#define REG_SW_MAC_ADDR_0
0x0302

In the current net-next the REG_SW_MAC_ADDR_0 is altered used (the only
usage are now with mine patches on ksz9477).

To sum up:

1. Up till now in (net-next) REG_SW_MAC_ADDR_0 is ONLY declared for
Microchip switches. No risk for access - other than HSR patches.

2. The MAC address alteration of DSA master and propagation to slaves
is a generic DSA bug.

Considering the above - the HSR implementation is safe (to the extend
to the whole DSA subsystem current operation). Am I correct?


>=20
> So, there are some options to pick from.
>=20
> > Will the above problem block the HSR offloading support mainlining,
> > even when the self mac address filtering is one of four HW based
> > features for this SoC? =20
>=20
> I don't know, that depends on you.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/5Kz8AWmYzMdcebRSB9lKr2n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUAb64ACgkQAR8vZIA0
zr065Qf+Jy6FiMFEAEZIGtIgC1oIupTIDnZW6Tw1pcaJCCPY8ELAWEulAQ7aSYEH
UtXLSVrBFt9vxQHWideo1bpYfMVfOA2D04bocvRz1A9UeDM1a7kEpGrdWj3Oifte
U4FPJVclrB3biyDmsVXyRYG/q//DrteX806hxgkx0pE7NYDjwkM5iu4oOS3HWVdL
uXtbfIOhgWGl6WEf4izc4AaMcgLPt/iTAuDYOp2TrcUfuCt2xZYINJOCMl0aN5yF
CvmTsKaKISwHDtReZS+bj4CLX1QCdPPfTlVUuFr+BOmodS9APdmhylS7rbJ8USAK
rto+LvE9oWRkvrEpDS0RJl9PjzcKSw==
=ZsNK
-----END PGP SIGNATURE-----

--Sig_/5Kz8AWmYzMdcebRSB9lKr2n--
