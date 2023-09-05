Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C477929CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353194AbjIEQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354329AbjIEKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:44:34 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F4199;
        Tue,  5 Sep 2023 03:44:25 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 09C148644B;
        Tue,  5 Sep 2023 12:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693910658;
        bh=oQfqvrxQxUYX2AyYJlPF+NiDhn4uUqpVgDZrhk7D6zE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rOq8V4i9cW6heqvuJKA65SoD77mF4+5cK0R5up1Npp6qiKuxuswBT4/r4VkM8e6ZL
         7PXst1Qqt8y2+EZaMTDwPVvLoQG3WDxLuGDiT0f6x+znd1vDSdYPTaynQspKsaOPsc
         PR4OAaBx+RNFE/9rrdFn/0b0/hKTCfgEMbJ5WFFaC3nw5dewSfAx8Rl/30bAjDADyT
         a1qG0ElLXU2SrhDempCa1+AJrHYuSKSt6tjnzkQ+M0UmgqHKMCvzmdVmW9weguuHY8
         11bLvkmxSCjJYwdz1ZQeHATM0tbwOyV5lyTGOUe9wSLVBSWHrit47HZ+GT+rx/Nb+B
         EjTiXLAx/4OjA==
Date:   Tue, 5 Sep 2023 12:44:09 +0200
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
Subject: Re: [PATCH v3 RFC 2/4] net: dsa: Extend ksz9477 TAG setup to
 support HSR frames duplication
Message-ID: <20230905124409.40c7c2f1@wsk>
In-Reply-To: <20230905102239.mkufbzxwrvuatlrb@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-3-lukma@denx.de>
        <20230905102239.mkufbzxwrvuatlrb@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NbD=vAmHvH3dutbc5EgpdLp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NbD=vAmHvH3dutbc5EgpdLp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Mon, Sep 04, 2023 at 02:02:07PM +0200, Lukasz Majewski wrote:
> > The KSZ9477 has support for HSR (High-Availability Seamless
> > Redundancy). One of its offloading (i.e. performed in the switch IC
> > hardware) features is to duplicate received frame to both HSR aware
> > switch ports.
> >=20
> > To achieve this goal - the tail TAG needs to be modified. To be more
> > specific, both ports must be marked as destination (egress) ones.
> >=20
> > Moreover, according to AN3474 application note, the lookup bit (10)
> > should not be set in the tail tag.
> >=20
> > Last but not least - the NETIF_F_HW_HSR_DUP flag indicates that the
> > device supports HSR and assures (in HSR core code) that frame is
> > sent only once from HOST to switch with tail tag indicating both
> > ports.
> >=20
> > Information about bits to be set in tag is provided via KSZ generic
> > ksz_hsr_get_ports() function.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Use ksz_hsr_get_ports() to obtain the bits values corresponding to
> >   HSR aware ports
> >=20
> > Changes for v3:
> > - None
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 12 ++++++++++++
> >  include/linux/dsa/ksz_common.h         |  1 +
> >  net/dsa/tag_ksz.c                      |  5 +++++
> >  3 files changed, 18 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c index
> > d9d843efd111..579fde54d1e1 100644 ---
> > a/drivers/net/dsa/microchip/ksz_common.c +++
> > b/drivers/net/dsa/microchip/ksz_common.c @@ -3421,6 +3421,18 @@
> > static int ksz_setup_tc(struct dsa_switch *ds, int port, }
> >  }
> > =20
> > +u16 ksz_hsr_get_ports(struct dsa_switch *ds)
> > +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +
> > +	switch (dev->chip_id) {
> > +	case KSZ9477_CHIP_ID:
> > +		return dev->hsr_ports;
> > +	}
> > +
> > +	return 0;
> > +} =20
>=20
> When CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=3Dm:
>=20
> ld.lld: error: undefined symbol: ksz_hsr_get_ports
> referenced by tag_ksz.c:298
> (/opt/net-next/output-arm64-clang/../net/dsa/tag_ksz.c:298)
> net/dsa/tag_ksz.o:(ksz9477_xmit) in archive vmlinux.a
>=20
> But before you rush to add EXPORT_SYMBOL_GPL(ksz_hsr_get_ports), be
> aware that due to DSA's design, tag_ksz.ko and ksz_common.ko cannot
> have any symbol dependency on each other, and if you do that, you
> will break module auto-loading. More information here, there were
> also patches that removed those dependencies for other tagger/switch
> driver pairs:
> https://lore.kernel.org/netdev/20210908220834.d7gmtnwrorhharna@skbuf/
>=20

Ok. I will look on that

> Not to mention that there are other problems with the "dev->hsr_ports"
> concept. For example, having a hsr0 over lan0 and lan1, and a hsr1
> over lan2 and lan3, would set dev->hsr_ports to GENMASK(3, 0).

I doubt that having two hsr{01} interfaces is possible with current
kernel.

The KSZ9477 allows only to have 2 ports of 5 available as HSR
ones.

The same is with earlier chip xrs700x (but this have even bigger
constrain - there only ports 1 and 2 can support HSR).=20

> But
> you want an xmit coming from hsr0 to get sent only to GENMASK(1, 0),
> and an xmit from hsr1 only to GENMASK(3, 2).
>=20
> In this particular case, the best option seems to be to delete
> ksz_hsr_get_ports().

Please see my below comment.

>=20
> > +
> >  static const struct dsa_switch_ops ksz_switch_ops =3D {
> >  	.get_tag_protocol	=3D ksz_get_tag_protocol,
> >  	.connect_tag_protocol   =3D ksz_connect_tag_protocol,
> > diff --git a/include/linux/dsa/ksz_common.h
> > b/include/linux/dsa/ksz_common.h index 576a99ca698d..fa3d9b0f3a72
> > 100644 --- a/include/linux/dsa/ksz_common.h
> > +++ b/include/linux/dsa/ksz_common.h
> > @@ -50,4 +50,5 @@ ksz_tagger_data(struct dsa_switch *ds)
> >  	return ds->tagger_data;
> >  }
> > =20
> > +u16 ksz_hsr_get_ports(struct dsa_switch *ds);
> >  #endif /* _NET_DSA_KSZ_COMMON_H_ */
> > diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> > index ea100bd25939..903db95c37ee 100644
> > --- a/net/dsa/tag_ksz.c
> > +++ b/net/dsa/tag_ksz.c
> > @@ -293,6 +293,11 @@ static struct sk_buff *ksz9477_xmit(struct
> > sk_buff *skb, if (is_link_local_ether_addr(hdr->h_dest))
> >  		val |=3D KSZ9477_TAIL_TAG_OVERRIDE;
> > =20
> > +	if (dev->features & NETIF_F_HW_HSR_DUP) {
> > +		val &=3D ~KSZ9477_TAIL_TAG_LOOKUP; =20
>=20
> No need to unset a bit which was never set.

I've explicitly followed the vendor's guidelines - the TAG_LOOKUP needs
to be cleared.

But if we can assure that it is not set here I can remove it.

>=20
> > +		val |=3D ksz_hsr_get_ports(dp->ds);
> > +	} =20
>=20
> Would this work instead?
>=20
> 	struct net_device *hsr_dev =3D dp->hsr_dev;
> 	struct dsa_port *other_dp;
>=20
> 	dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
> 		val |=3D BIT(other_dp->index);
>=20

I thought about this solution as well, but I've been afraid, that going
through the loop of all 5 ports each time we want to send single packet
will reduce the performance.

Hence, the idea with having the "hsr_ports" set once during join
function and then use this cached value afterwards.

> > +
> >  	*tag =3D cpu_to_be16(val);
> > =20
> >  	return ksz_defer_xmit(dp, skb);
> > --=20
> > 2.20.1
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/NbD=vAmHvH3dutbc5EgpdLp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3BnkACgkQAR8vZIA0
zr1vLgf+PU00qM1jp1h9eWcq3/+PT1Dz1wvwfAJyo0RfNKZs+/+OK9kSQjl0kJsX
0tWT4/0EMUfin/oRNTjjCYPmXukqZntiU5o98EPRfPGUSEI6namnIuqlhyC0r8cS
U/EIHPzr7UAdsbt7ovFDQiA33OvA1vShU3NQwMozjQwVRVcouZBNu03EwsHjeax4
sRjxAGt+YaRi06Ft4G3Trm1e1Toxks3b7F0rykxPAQX1I3sADo0yrjPk7SA3BgXJ
kBS8/f2kz4WQUhVbwHFSoYaybod+We8nF14HzSnHSh7bHrtGOJJjG/Wl21+1p+KR
e1jP/Cnq0KUxzoZ/lDDXW8vJlxj0gQ==
=uWmA
-----END PGP SIGNATURE-----

--Sig_/NbD=vAmHvH3dutbc5EgpdLp--
