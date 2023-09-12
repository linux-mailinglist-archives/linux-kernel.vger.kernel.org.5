Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0779C99E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjILISE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjILISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:18:02 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ECDE73;
        Tue, 12 Sep 2023 01:17:58 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6C25486A49;
        Tue, 12 Sep 2023 10:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694506676;
        bh=DtoeluLm01NnQZKGYOEwCpPPjDcwpgfZ+EHpQIgHa3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zitroCYos6925tU//kpUU62WzBI9L3cRs6GaHr8j/q4LpefEJIth0dmobbQtxY6yn
         VjAd3BTcJaxrM2RNV1dvA7Xz6lmIfMtHydErLVJ3baOIJGrooemB1+vvldEjv2S+y2
         GhBq6Kl61vNkuhSiGv8q88HspjusyW/maBE5KoCLQHYIHtjeSX4qVyT+yukdxIlsJd
         GhuEiYX86mt/82BTN81uMneHj+YD8sxfriccy14GT+OH5RhVtpYaFgMhSs76m0y/ma
         vHM4rfyLv4mxMc0OZiPfr1xKBguD1nhoVOrTisj94r590pRFUE7QqRCXaLuixw5+zf
         MCbuigDnNe7wg==
Date:   Tue, 12 Sep 2023 10:17:48 +0200
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
Message-ID: <20230912101748.0ca4eec8@wsk>
In-Reply-To: <20230911160501.5vc4nttz6fnww56h@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
        <20230911165848.0741c03c@wsk>
        <20230911160501.5vc4nttz6fnww56h@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bwRV6NUh6F=O0WEHRBFibVB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bwRV6NUh6F=O0WEHRBFibVB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Mon, Sep 11, 2023 at 04:58:48PM +0200, Lukasz Majewski wrote:
> > Dear Community,
> >=20
> > Are there any comments regarding this new revision of the HSR
> > support for KSZ9477 switch?
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski =20
>=20
> Yeah, the integration with the DSA master's MAC address is not quite
> what I was expecting to see.
>=20
> See, both the DSA master's MAC address, as well as the HSR device's
> MAC address, can be changed at runtime with:
>=20
> ip link set eth0 address AA:BB:CC:DD:EE:FF # DSA master
> ip link set lan1 address AA:BB:CC:DD:EE:FF # indirectly changes the
> HSR's address too

IMHO, somebody who will use HSR will not fiddle with mac addresses of
LAN1 and ETH0. It will be setup by savvy user once at boot up.

>=20
> which is problematic because the hardware does not get updated in that
> case, but the address change is not refused either.
>=20
> Actually, the reason why I haven't yet said anything is because it
> made me realize that there is a pre-existing bug in net/dsa/slave.c
> where we have this pattern:
>=20
> 	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
> 		dev_uc_add(master, dev->dev_addr);
>=20
> but there is no replay of the dev_uc_add() call when the
> master->dev_addr changes. This really results in RX packet loss, as I
> have tested. I don't know what is the best way to solve it.
>=20
> Anyway, programming the MAC address of the DSA master or of the HSR
> device to hardware seems to require tracking the NETDEV_CHANGEADDR and
> NETDEV_PRE_CHANGEADDR events, even if only to reject those changes.

Please correct me if I'm wrong, but the above issue (with lack of sync
of mac address change in DSA master and its ports) seems to be
affecting HSR support in a minimal way (when considering the above).

If I may ask - what is your suggestion to have the HSR join feature
merged for KSZ9477 SoC ?

Will the above problem block the HSR offloading support mainlining,
even when the self mac address filtering is one of four HW based
features for this SoC?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bwRV6NUh6F=O0WEHRBFibVB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUAHqwACgkQAR8vZIA0
zr3IyQf/brMDtjdKMvUTCOs5kkNPIHCYms3dezF4itq3jM5N47duldHVXKhZ8o9V
oDZrpOA+5SNQz41tHOdsUNEHF8Cw1GF1nGn68UYtvVJYQ8xXiiLhQb3qUOEoxCCi
8RaPOx+a00JekyLPgp7i3tqsCakqx5SAWjqdwWkwJzvaLnGANLeRrmdne9PPUbcI
UfiE3jA9PO5qib7p7E8DePY4hL3iHcbfvoF/Xs9IlcByAR2V8/lEn3vpZSMpqHyC
M6a73XyAcIl8zv+jyPCZOXxMedyzEU2h2w0VoVeeX32EvXway9zpLxE/TDvTVdvE
PQziSTtAdi2zhLu2cMH/2GVkA60EQg==
=EbJK
-----END PGP SIGNATURE-----

--Sig_/bwRV6NUh6F=O0WEHRBFibVB--
