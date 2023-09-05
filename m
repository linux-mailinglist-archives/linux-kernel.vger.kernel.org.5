Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8879281F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbjIEQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354013AbjIEJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:13:04 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29DDA;
        Tue,  5 Sep 2023 02:12:59 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 17FBF8653D;
        Tue,  5 Sep 2023 11:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693905176;
        bh=BR/Zgf6gM+aK4Rpc+OxCgQx8h+FpEmUgs5GKhVdx3Po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tq3lQyDy8e/VMKCf0W4txJ0mIzWnKR4lsZWdFTH5EQ4gqLcqjjPmgsieDNBDteMHu
         Dq7+H2IKUaisHciwWdFNcHOqwZ4TD5qH13zitOG7gdLHOxJX7p6rTkwR8KmtqSTdOO
         192X5mlkk97P1NLUF6EamsK9P10j+1b8Dgz0P6CMZDeFZQYcvXQWsTbbDAhkM5kW5q
         dYF9ETmiZYaeAuMne2IlYjwvEHPnnLNaAQv/FnFKmtSKbSnk9zIwiHeWQDM78ldp4/
         bHeFAE+bzHo30P0ZJviNbBpSdiQsyGifoba3DFiKvOJ4ORHphiqIKhF7pshmFLMXl4
         Tv+eZjWQYZzPA==
Date:   Tue, 5 Sep 2023 11:12:48 +0200
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
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230905111248.0d3c8ed9@wsk>
In-Reply-To: <20230904205304.h3fdjqcijytztlpb@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-5-lukma@denx.de>
        <20230904205304.h3fdjqcijytztlpb@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N02/Ma2Yt09=3DGVRL4akQi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N02/Ma2Yt09=3DGVRL4akQi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Mon, Sep 04, 2023 at 02:02:09PM +0200, Lukasz Majewski wrote:
> > This patch provides the common KSZ (i.e. Microchip) DSA code with
> > support for HSR aware devices.
> >=20
> > To be more specific - generic ksz_hsr_{join|leave} functions are
> > provided, now only supporting KSZ9477 IC.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - None
> >=20
> > Changes for v3:
> > - Do not return -EOPNOTSUPP for only PRP_V1 (as v2 will not be
> > caught) ---
> >  drivers/net/dsa/microchip/ksz_common.c | 69
> > ++++++++++++++++++++++++++ 1 file changed, 69 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c index
> > 579fde54d1e1..91d1acaf4494 100644 ---
> > a/drivers/net/dsa/microchip/ksz_common.c +++
> > b/drivers/net/dsa/microchip/ksz_common.c @@ -16,6 +16,7 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/if_bridge.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/if_hsr.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/of_mdio.h> =20
>=20
> This conflicts with commit f44a90104ee5 ("net: dsa: Explicitly include
> correct DT includes") from July, merged through net-next.
>=20
> "New features" material for networking goes through this tree, please
> submit patches that were formatted (and tested) on top of the most
> recent version of the "main" branch, and use git-send-email
> --subject-prefix "[RFC PATCH vN net-next]" to denote that.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/
>=20
> If patches fail to apply to the target kernel, you lose the benefit of
> automatic build testing (which would have highlighted a problem that
> exists since v3). With RFC patches, the kbuild test robot sends build
> breakage reports only to you - with normal patches it sends them to
> everybody.

Thanks for the info.

>=20
> Please wait for more feedback before posting RFC v5. I will review in
> more detail, but it will take some time.

Ok. I will wait for your feedback and then sent RFC v4.

>=20
> Thanks.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/N02/Ma2Yt09=3DGVRL4akQi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT28REACgkQAR8vZIA0
zr3ofAf/VsqyC6fNByFdfaeUZyLGDANPQztAF4Jc4ATfbwd4bRCZgM+SIiwDEgeB
3r/SuACh3g5uNMlyApeXEEhVDinvAhW1WLZg9mQfgRtEmr+iCSSnVfXihcZYS4tA
HycYd8z+SHAlVsWzBt6hyCpXZdJ+WBT/xeoQbBlRLWCgnplX9MXOV5O8nIcNAXMP
dDgOPMZfuUwCTJHQT2neYWLLooxPVkn3ooAZwzwkG4Q6Y6jCooC3l3r0QX7qNs4h
9Dl4POA4iqAY7fej1MCGwXg+G6YWLaZjz+8Hcw/ShW6qnV2YfdMOSgKGmkhSzJ53
OGaDFEyWofRfpEaSkYSpk2YrVta+Sg==
=m7df
-----END PGP SIGNATURE-----

--Sig_/N02/Ma2Yt09=3DGVRL4akQi--
