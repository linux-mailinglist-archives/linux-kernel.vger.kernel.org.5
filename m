Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DC78EC95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbjHaLyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHaLye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:54:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C68C5;
        Thu, 31 Aug 2023 04:54:30 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2DD14805C1;
        Thu, 31 Aug 2023 13:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693482868;
        bh=s9C/kMwJurNj9m5xf2qLpYtZKtu6ZCmIyRCq5Ip5Eqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+WqBSHUPbXCvCZDLbLMtIA8KOuD0G+MMfbHjVWJtAvIsFbd3JwHtQC5jRKiBbgUW
         mIAO/oR3hV/MkIKcbojuv5+eTqFjxzaIcT5V/yNZJX5V6fbPcbs//LptZrGtXoDP1p
         HQvHB4IuA6759gW32sTIVt62PRt/gZ63NhUz+62hPRK5hrD9Q+MNx7Juck/BnCX0mi
         rVh6bv5arwhtXNp1DZNtTULdzbyt/LmeIg6MnZ0fMtFzxRZRrHHQtiEk4YONiV2rdz
         71TKbim71JgIm2d0NldvPKpCruxAv3S5JiqTFd+A27ev7nFwYhM+QLZxJkGiiyggg5
         WHhBGtXEBU6mA==
Date:   Thu, 31 Aug 2023 13:54:15 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] net: dsa: hsr: Enable HSR HW offloading for
 KSZ9477
Message-ID: <20230831135415.1dfd8c5c@wsk>
In-Reply-To: <b6aa2a338c2a2db597415e073819a5fe6d0187a9.camel@redhat.com>
References: <20230831111827.548118-1-lukma@denx.de>
        <b6aa2a338c2a2db597415e073819a5fe6d0187a9.camel@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jM9aM9xWa7OVx/m1qz5B46K";
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

--Sig_/jM9aM9xWa7OVx/m1qz5B46K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On Thu, 2023-08-31 at 13:18 +0200, Lukasz Majewski wrote:
> > This patch series provides support for HSR HW offloading in KSZ9477
> > switch IC.
> >=20
> > To test this feature:
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ifconfig lan1 up;ifconfig lan2 up
> > ifconfig hsr0 192.168.0.1 up
> >=20
> > To remove HSR network device:
> > ip link del hsr0
> >=20
> > Test HW:
> > Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
> >=20
> > Performance SW used:
> > nuttcp -S --nofork
> > nuttcp -vv -T 60 -r 192.168.0.2
> > nuttcp -vv -T 60 -t 192.168.0.2
> >=20
> > Code: v6.5-rc7 Linux repository
> > Tested HSR v0 and v1
> > Results:
> > With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> > With no offloading 		       RX: 63 Mbps  TX: 63 Mbps
> >=20
> >=20
> > Lukasz Majewski (4):
> >   net: dsa: Extend the ksz_device structure to hold info about HSR
> > ports net: dsa: Extend ksz9477 TAG setup to support HSR frames
> > duplication net: dsa: hsr: Enable in KSZ9477 switch HW HSR
> > offloading net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave}
> > functions
> >=20
> >  drivers/net/dsa/microchip/ksz9477.c    | 96
> > ++++++++++++++++++++++++++ drivers/net/dsa/microchip/ksz9477.h    |
> >  4 ++ drivers/net/dsa/microchip/ksz_common.c | 81
> > ++++++++++++++++++++++ drivers/net/dsa/microchip/ksz_common.h |  3 +
> >  include/linux/dsa/ksz_common.h         |  1 +
> >  net/dsa/tag_ksz.c                      |  5 ++
> >  6 files changed, 190 insertions(+)
> >  =20
> I'm sorry, it looks like I was not clear previously.
> ---
> ## Form letter - net-next-closed
>=20
> The merge window for v6.6 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
>=20
> Please repost when net-next reopens after Sept 11th.
>=20

This is in fact the RFC kind of patch, as you were the only one who
replied with feedback on it.

If possible - I would like to gain as much feedback as possible until
11.09, so this patch set could be applied then.

> RFC patches sent for review only are obviously welcome at any time.
>=20

Shall I send RFC again? Or is the above explanation enough to proceed
with review?

> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/jM9aM9xWa7OVx/m1qz5B46K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTwf2cACgkQAR8vZIA0
zr0dwgf8D8mGVYVc8/LUKsa1Orc0F8I/RrqxRziPuHP8bmqquJDXCoy8szrT4o9r
RVUSqefsOTmMNYB2V5FqCyqQbf9pjeSpssNDXLOm6qwbm+byNegHgp9e52IixBud
nq5553wBWCfByz8PNcGwDTJ6irYbwQkKMiLQNoIfhx30OfLFscaGcKuZRFx8wEI1
ppl7E7v3Tj0bSmgjFw20FIQ8/tvxJdIYgxCHU98a2cZCaKVNR2LB3nv7pXjZouvr
9la2jWBQ2cYpUnqFnuvlzSyQexb5ipAtE6ADP3gd2oz+ibmytd2yEw2Bg0pjyNJI
pwZFsk5s9fWxbMGdKBTH9L5AJ21G2A==
=aVyX
-----END PGP SIGNATURE-----

--Sig_/jM9aM9xWa7OVx/m1qz5B46K--
