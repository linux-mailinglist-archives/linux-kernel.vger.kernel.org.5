Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09487792B25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbjIEQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354403AbjIELYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:24:06 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC41AB;
        Tue,  5 Sep 2023 04:24:00 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A3CD286983;
        Tue,  5 Sep 2023 13:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693913039;
        bh=aZiQZIfHLo3V1mQBP/zVuNU3lXX/EfHt55H4rQrKfWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynjI/KrWLk/BSEy0qaXEUjUyx72215WxB9GkIfuDgMCsyGTxuWFysPMy+p5xjbnRd
         stG6/PF9Q3fQcR3ztY9Zmo/bhGkTCIWm84g9xgm18VIQM0lyCB4i0t1egeYxmG42uv
         xGWibY1tIlu5TIplcpBqX8kxqaT4kzENaYOy/wyOjxJTnW14zN57e/u78f2drgXhWR
         w5xJN3GnAAiAkGhDNQY9Qwp5cx87vhWT7xKiNNma/wYwpFsH9TH2MtljB8HdLLSDMa
         T9tzJBJP2BHTdX67YT9hrxTTSqk8v8eG4DIy5Pf6deYk49KMOiQnXbJMAqmj34oxRg
         Z0xlGDGCsKi6Q==
Date:   Tue, 5 Sep 2023 13:23:51 +0200
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
Message-ID: <20230905132351.2e129d53@wsk>
In-Reply-To: <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-5-lukma@denx.de>
        <20230904120209.741207-5-lukma@denx.de>
        <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ubD0zOjY3M9hPEvv5dRxPU0";
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

--Sig_/ubD0zOjY3M9hPEvv5dRxPU0
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
> > caught) =20
>=20
> Should be squashed into patch 3/4. The split does not make the code
> easier to review for me.

So you recommend to have only one patch in which the hsr_join{leave}
function from ksz_common.c and ksz9477_hsr_join{leave} from ksz9477.c
are added?

>=20
> > ---
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
> >  #include <linux/of_mdio.h>
> > @@ -3433,6 +3434,72 @@ u16 ksz_hsr_get_ports(struct dsa_switch *ds)
> >  	return 0;
> >  }
> > =20
> > +static int ksz_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr) +{
> > +	struct dsa_port *partner =3D NULL, *dp;
> > +	struct ksz_device *dev =3D ds->priv;
> > +	enum hsr_version ver;
> > +	int ret;
> > +
> > +	ret =3D hsr_get_version(hsr, &ver);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (dev->chip_id) {
> > +	case KSZ9477_CHIP_ID:
> > +		if (!(ver =3D=3D HSR_V0 || ver =3D=3D HSR_V1))
> > +			return -EOPNOTSUPP; =20
>=20
> move the "default: return -EOPNOTSUPP" statement from below here.
>=20

Ok, I will add default statement with -EOPNOTSUPP.

> > +	} =20
>=20
> I don't see any restriction to allow offloading a single HSR device.

As I've written in the other response - I've followed the xrs700x.c
convention.=20

Moreover, for me it seems more natural, that we only allow full HSR
support for 2 ports or none. Please be aware, that HSR supposed to
support only 2 ports, and having only one working is not recommended by
vendor.

> Looking at patch 3/4, that will obviously not work due to some
> hardware registers which are global and would be overwritten by the
> second HSR device.

I cannot guarantee that there will not be any "side effects" with this
approach. And to be honest - I would prefer to spent time on testing
recommended setups.

>=20
> For example, a5psw_port_bridge_join() has a similar restriction to
> offload a single bridge device.

HSR is IMHO a bit different than plain "bridge" offloading.

>=20
> If you return -EOPNOTSUPP, then DSA should fall back to an
> unoffloaded, 100% software-based HSR device, and that should work
> too.=20

And then we would have one port with SW HSR and another one with HW
HSR?

>It would be good if you could verify that the unoffloaded HSR
> works well after the changes too.

I've tested on KSZ9477-EVB the SW HSR operation with two ports (and two
or three boards) and HW HSR offloading. Results are presented in the
cover-letter.

>=20
> > +
> > +	/* We can't enable redundancy on the switch until both
> > +	 * redundant ports have signed up.
> > +	 */
> > +	dsa_hsr_foreach_port(dp, ds, hsr) {
> > +		if (dp->index !=3D port) {
> > +			partner =3D dp;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!partner)
> > +		return 0;
> > +
> > +	switch (dev->chip_id) {
> > +	case KSZ9477_CHIP_ID:
> > +		return ksz9477_hsr_join(ds, port, hsr, partner);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ksz_hsr_leave(struct dsa_switch *ds, int port,
> > +			 struct net_device *hsr)
> > +{
> > +	struct dsa_port *partner =3D NULL, *dp;
> > +	struct ksz_device *dev =3D ds->priv;
> > +
> > +	dsa_hsr_foreach_port(dp, ds, hsr) {
> > +		if (dp->index !=3D port) {
> > +			partner =3D dp;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!partner)
> > +		return 0;
> > +
> > +	switch (dev->chip_id) {
> > +	case KSZ9477_CHIP_ID:
> > +		return ksz9477_hsr_leave(ds, port, hsr, partner);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct dsa_switch_ops ksz_switch_ops =3D {
> >  	.get_tag_protocol	=3D ksz_get_tag_protocol,
> >  	.connect_tag_protocol   =3D ksz_connect_tag_protocol,
> > @@ -3452,6 +3519,8 @@ static const struct dsa_switch_ops
> > ksz_switch_ops =3D { .get_sset_count		=3D ksz_sset_count,
> >  	.port_bridge_join	=3D ksz_port_bridge_join,
> >  	.port_bridge_leave	=3D ksz_port_bridge_leave,
> > +	.port_hsr_join		=3D ksz_hsr_join,
> > +	.port_hsr_leave		=3D ksz_hsr_leave,
> >  	.port_stp_state_set	=3D ksz_port_stp_state_set,
> >  	.port_pre_bridge_flags	=3D ksz_port_pre_bridge_flags,
> >  	.port_bridge_flags	=3D ksz_port_bridge_flags,
> > --=20
> > 2.20.1
> >  =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ubD0zOjY3M9hPEvv5dRxPU0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3D8cACgkQAR8vZIA0
zr1RLQf/c8BX2Odp4/YRH8NivGg1j3Pae6ZQRbFB3I3UUaa1NJBUy/7S1DDxNrJu
zt1M/ACnfuurVIThp5CY3FfzY13Ig36uq+bCSX4t2P2vHQgwsRkXyaG/WEW4dMHl
EaT2nLFB/RcWTkDMklYV8jy+BA8d3M6Iejd5No9Ui+ICxuEemH6jBbEFXdsUl9pJ
b7TS+Q0eyoiO/2U3g0laSmVM2UiIBPMU7STXYg+TbyQYkoRMQHlsQpcaYjOBzPvt
jYSzJM2VifAMM8BFPqZuXJQUJB7WKr6wAMqFVNE/kjjN3W+8FTdjYbd4K0oGW3Dp
Xmv6CHd1XLWYBaPCkOxJQjj4RwGIig==
=tlXv
-----END PGP SIGNATURE-----

--Sig_/ubD0zOjY3M9hPEvv5dRxPU0--
