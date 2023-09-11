Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029DD79B1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379068AbjIKWlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbjIKO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:27 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80608E50;
        Mon, 11 Sep 2023 07:57:17 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 84AFD86E45;
        Mon, 11 Sep 2023 16:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694444235;
        bh=6BZTCrbY7JIU/gU/FlcDi4amb+9Cj/ty4qoviSaIi+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pT6Sc/K4H/1XmsroChmNBpxkv8EhRLWOL+hRJgdcgLGx1Kqo3JBNXLAXDYMosw4fq
         xd3TXXyDwG/wjGhw8YqhNHJAv6pD2OF+nysaOocG0RhPBJ4pJrcUIqs6cYcQhXQ1s9
         UuDRvpHaesTkZQfdG4iN2Y/erJOp1+AEIyZV5HVMTFCJkdPzUmSL7n8dfSeiqvKhS2
         Sq+bXVzne1grSJu3SOAb0uKe7WUfG6TbVh8meKEgDf48CfaGDVhtunF7x08d0YiTHG
         dcXv623q+LZVoUXwgYnkZ0Y3sk/bg4EIw7Ord7VWBYm6FLZoSHHZpbwcVwZ6uuqEwq
         NZvHOW2uPeJ6Q==
Date:   Mon, 11 Sep 2023 16:57:08 +0200
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
Message-ID: <20230911165708.0bc32e3c@wsk>
In-Reply-To: <20230905115512.3ac6649c@wsk>
References: <20230825153111.228768-1-lukma@denx.de>
        <20230905080614.ImjTS6iw@linutronix.de>
        <20230905115512.3ac6649c@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8XSE7au7Lm0FPJDKb+ziwHb";
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

--Sig_/8XSE7au7Lm0FPJDKb+ziwHb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> Hi Sebastian,
>=20
> > On 2023-08-25 17:31:11 [+0200], Lukasz Majewski wrote: =20
> > > Provide fix to decode correctly supervisory frames when HSRv1
> > > version of the HSR protocol is used.
> > >=20
> > > Without this patch console is polluted with:
> > > ksz-switch spi1.0 lan1: hsr_addr_subst_dest: Unknown node
> > >=20
> > > as a result of destination node's A MAC address equals to:
> > > 00:00:00:00:00:00.
> > >=20
> > > cat /sys/kernel/debug/hsr/hsr0/node_table
> > > Node Table entries for (HSR) device
> > > MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B],
> > > Address-B 00:00:00:00:00:00 00:10:a1:94:77:30      400bf,
> > > 399c,	        0
> > >=20
> > > It was caused by wrong frames decoding in the
> > > hsr_handle_sup_frame().
> > >=20
> > > As the supervisor frame is encapsulated in HSRv1 frame:
> > >=20
> > > SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
> > > SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> > > SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > SKB_I100000040: 00 00
> > >=20
> > > The code had to be adjusted accordingly and the MAC-Address-A now
> > > has the proper address (the MAC-Address-B now has all 0's).   =20
> >=20
> > Was this broken by commit
> > 	eafaa88b3eb7f ("net: hsr: Add support for redbox supervision
> > frames")
> >  =20
>=20
> Yes, it seems so.
>=20
> > ? Is this frame somehow special? I don't remember this=E2=80=A6
> >  =20
>=20
> Please refer to the whole thread - I've described this issue
> thoroughly (including hex dump of frames):
> https://lore.kernel.org/lkml/20230904175419.7bed196b@wsk/T/#m35cbfa4f1b89=
01d341fbc39659ace6a041f84c98
>=20
> In short - the HSRv1 is not recognized correctly anymore:
>=20
> HSR v0:
>     [Protocols in frame: eth:ethertype:hsr_prp_supervision]
>                                                                        =20
> HSR v1:
>     [Protocols in frame: eth:ethertype:hsr:hsr_prp_supervision]
>=20

Have you had time to review this patch?

Your comments are more than welcome.

>=20
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>   =20
> >=20
> > Sebastian =20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8XSE7au7Lm0FPJDKb+ziwHb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT/KsQACgkQAR8vZIA0
zr0AOAgAs0CIwM+g7skUkQ97pRHdo5AVv17Btzofx6gypvJfnFb0gf1tQcoRpmDh
vh7xIAPxf+eByxARu8e487m8zNfkMi367BZAtQr9gebklH17ghEZTNEkzUs0P9LU
9PMUP7MWQvCskLQMFHxVvZJVnQAFWEZOZbm6gWvYmVH6JzxriLh0rtcu5DWHl2mB
o6SX1iykaQmQceGSb7eW4Cfu5KecLIG156g9bC9uZ5/3jOq2JHHGilgtwU6+CGHA
rFKlLqpXouABuUWUmM9+O/sMBryOAGb4r7cASRBzAsBFDCuXpu4q/oyCT+it8fTl
jiOqJvCj0NqkE3TcaLDary8ujR/hIw==
=rYMm
-----END PGP SIGNATURE-----

--Sig_/8XSE7au7Lm0FPJDKb+ziwHb--
