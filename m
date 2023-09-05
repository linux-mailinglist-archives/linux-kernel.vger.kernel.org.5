Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D4792542
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjIEQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354140AbjIEJz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:55:26 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D2132;
        Tue,  5 Sep 2023 02:55:21 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AC3398691E;
        Tue,  5 Sep 2023 11:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693907719;
        bh=tneArmjlXh/92OwvwEXRg4SIPn/5tACoYN/VdtMqX14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXxj3B8h4GHsX/ZSHDzI34CBEnFu2WhGmLXrvtV5RWh+6T8Mh2svxNrTFiWkbPRVm
         vOKLhARth24umPrEVhrLJ4g2bZsSjKlimjle2n+v5yi1Q8RkYm65X53sCdwiktn+ka
         J8xLelHLKg8uzvfCZUMVgFqJNlsA2RAjsE72z+BOCfkhrjibUT4KPsuDKvXWoZwuZ4
         qhCeowwtX/ukvKz6gg+eWVXFbRiZX4YEcGumwZ9E4n2jzhlwJ3DbakQLI18hYNFe8F
         BA6dO89qrM/bFVDJvMJtmQDlPVePSf4w1X/AoXKts0lAPIgfSsuyEvkC5cqhNwPmkd
         rjKwk98/uwEQw==
Date:   Tue, 5 Sep 2023 11:55:12 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230905115512.3ac6649c@wsk>
In-Reply-To: <20230905080614.ImjTS6iw@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
        <20230905080614.ImjTS6iw@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K9EA_PJANH_w1VlIBP+xs5a";
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

--Sig_/K9EA_PJANH_w1VlIBP+xs5a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> On 2023-08-25 17:31:11 [+0200], Lukasz Majewski wrote:
> > Provide fix to decode correctly supervisory frames when HSRv1
> > version of the HSR protocol is used.
> >=20
> > Without this patch console is polluted with:
> > ksz-switch spi1.0 lan1: hsr_addr_subst_dest: Unknown node
> >=20
> > as a result of destination node's A MAC address equals to:
> > 00:00:00:00:00:00.
> >=20
> > cat /sys/kernel/debug/hsr/hsr0/node_table
> > Node Table entries for (HSR) device
> > MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B],
> > Address-B 00:00:00:00:00:00 00:10:a1:94:77:30      400bf,
> > 399c,	        0
> >=20
> > It was caused by wrong frames decoding in the
> > hsr_handle_sup_frame().
> >=20
> > As the supervisor frame is encapsulated in HSRv1 frame:
> >=20
> > SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
> > SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> > SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > SKB_I100000040: 00 00
> >=20
> > The code had to be adjusted accordingly and the MAC-Address-A now
> > has the proper address (the MAC-Address-B now has all 0's). =20
>=20
> Was this broken by commit
> 	eafaa88b3eb7f ("net: hsr: Add support for redbox supervision
> frames")
>=20

Yes, it seems so.

> ? Is this frame somehow special? I don't remember this=E2=80=A6
>=20

Please refer to the whole thread - I've described this issue thoroughly
(including hex dump of frames):
https://lore.kernel.org/lkml/20230904175419.7bed196b@wsk/T/#m35cbfa4f1b8901=
d341fbc39659ace6a041f84c98

In short - the HSRv1 is not recognized correctly anymore:

HSR v0:
    [Protocols in frame: eth:ethertype:hsr_prp_supervision]
                                                                       =20
HSR v1:
    [Protocols in frame: eth:ethertype:hsr:hsr_prp_supervision]


> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Sebastian


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/K9EA_PJANH_w1VlIBP+xs5a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT2+wAACgkQAR8vZIA0
zr072Qf/eV4LIBVYp9d5zhpfLc7ppusqB5QsQQ3ksDnOCRoNJkFEH04Gk17UTyQR
YlSHdWsJ9GQRRZUdldGo4c8D+xSKzI+W46HT8nsnAsDTRcalABJ5zIb+2SCmFhL/
QLwkMMTbRKSWFqKsCk1Viy9+wiLpn6TfdbO+rY+8hTuA1H9rC++a1KaeYecy+O1q
gDZ4Be12ic1P/CWeGLH7FAWtUFyEHHojTdIAkrRvUFUol8GfZspJq3SlIaPAJLqu
Oy9Fq3suxIONkufZIa89ypP2ADreYAcXw6BDuPohBZJmUDM/4fPluC6dNisx7I6Q
oHPcVKeIvWb8AcqvCucDd58xdSkQYg==
=0DwX
-----END PGP SIGNATURE-----

--Sig_/K9EA_PJANH_w1VlIBP+xs5a--
