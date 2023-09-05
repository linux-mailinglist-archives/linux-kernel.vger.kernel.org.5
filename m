Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16D792865
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjIEQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354716AbjIENsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:48:03 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B3191;
        Tue,  5 Sep 2023 06:47:55 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4041A86575;
        Tue,  5 Sep 2023 15:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693921672;
        bh=FEDFXScdTgxVh47ZYyWs06//HWJO6IlGc0m4jNQNqUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tkr2EcB1EqH0pMA3M4fk8QgrS84FOjxpcc00UfIFH7GHt5RXf7rneRiTg7xfncdML
         Y0JjjyuzJl0WKkPKYnTWuStCPS0PB7aL6s0UGbMBP2tBuy3RKpS11ZjkbXq4Kgk7ca
         Mm9J0Fu/8jao1q4MVn9jnkDPL8iaWdYh+AoC+yVfPlOLp71RDro75OB+5QKYvKK4D0
         3PNsCLf8cUrxzbJYsYWrvWHO+A4G3HB8k8GPw9enGpN5Zoaxi8yvhTp23AX07Iqovx
         SsoAANiFAF0Dm9pJFSCKBIB687aTbuoGsX25gt4CtYTyZFYc1Uo0uO6pCcN14GtXBR
         Cw2b1ETKZ5aGA==
Date:   Tue, 5 Sep 2023 15:47:44 +0200
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
Message-ID: <20230905154744.648c1a8b@wsk>
In-Reply-To: <20230905120501.tvkrrzcneq4fdzqa@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-5-lukma@denx.de>
        <20230904120209.741207-5-lukma@denx.de>
        <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
        <20230905132351.2e129d53@wsk>
        <20230905120501.tvkrrzcneq4fdzqa@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+hut5hP6N6FM.lYbJUHQWJL";
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

--Sig_/+hut5hP6N6FM.lYbJUHQWJL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Tue, Sep 05, 2023 at 01:23:51PM +0200, Lukasz Majewski wrote:
> > > Should be squashed into patch 3/4. The split does not make the
> > > code easier to review for me. =20
> >=20
> > So you recommend to have only one patch in which the hsr_join{leave}
> > function from ksz_common.c and ksz9477_hsr_join{leave} from
> > ksz9477.c are added? =20
>=20
> Correct. In addition, patch 1/4 will be dropped. So there will be 2
> patches, one on net/dsa/tag_ksz.c and the other on
> drivers/net/dsa/microchip/.

Ok.

>=20
> > > I don't see any restriction to allow offloading a single HSR
> > > device. =20
> >=20
> > As I've written in the other response - I've followed the xrs700x.c
> > convention.  =20
>=20
> "the xrs700x.c convention"
>=20
> xrs700x_hsr_join():
>=20
> 	/* Only ports 1 and 2 can be HSR/PRP redundant ports. */
> 	if (port !=3D 1 && port !=3D 2)
> 		return -EOPNOTSUPP;
>=20
> So, checking for ports 1 and 2 is a stronger condition than the one
> I'm asking you to enforce.
>=20
> The KSZ9477 is more flexible. It can enable HSR offload on any 2
> ports, not just on ports 1 and 2. But it can still be 2 ports max, no
> more. You haven't copied the xrs700x convention, but you haven't
> adapted it, either.

Ok. I've misuderstood your suggestion. You were asking about having one
hsr offloaded setup (hsr0 =3D> lan1 + lan2) and in the same time
non-offloaded setup (hsr1 =3D> lan3 + lan4).

>=20
> > Moreover, for me it seems more natural, that we only allow full HSR
> > support for 2 ports or none. Please be aware, that HSR supposed to
> > support only 2 ports, and having only one working is not
> > recommended by vendor. =20
>=20
> And where is it enforced that full HSR offload is only applied to 2
> ports or none?

In the ksz_jsr_join() at ksz_common.c -> we exit from this function
when !partner.

>=20
> > > Looking at patch 3/4, that will obviously not work due to some
> > > hardware registers which are global and would be overwritten by
> > > the second HSR device. =20
> >=20
> > I cannot guarantee that there will not be any "side effects" with
> > this approach. And to be honest - I would prefer to spent time on
> > testing recommended setups. =20
>=20
> Please read my reply again, keeping in mind that by "HSR device" I
> mean "hsr0" in the commands below, and not the member ports as you've
> assumed when responding.

Yes. I do get your point.

>=20
> > >=20
> > > For example, a5psw_port_bridge_join() has a similar restriction to
> > > offload a single bridge device. =20
> >=20
> > HSR is IMHO a bit different than plain "bridge" offloading. =20
>=20
> Maybe this was not clear, but by "similar" I mean: if you replace the
> "bridge" word with "hsr", and you copy that code snippet from a5psw,
> you get the desired outcome.
>=20
> static int ksz_hsr_join(struct dsa_switch *ds, int port, struct
> net_device *hsr, /* optionally pass the extack argument from the
> caller */) {
> 	struct ksz_device *dev =3D ds->priv;
>=20
> 	/* We only support 1 HSR device */
> 	if (dev->hsr_dev && hsr !=3D dev->hsr_dev) {
> 		NL_SET_ERR_MSG_MOD(extack,
> 				   "Offload supported for a single
> HSR"); return -EOPNOTSUPP;
> 	}
>=20

Ok.

> 	dev->hsr_dev =3D hsr;
>=20
> 	...
>=20
> 	return 0;
> }
>=20
> I did not imply that HSR is not different than bridge offloading.
> I don't see how that is even related to the discussion.
>=20
> > > If you return -EOPNOTSUPP, then DSA should fall back to an
> > > unoffloaded, 100% software-based HSR device, and that should work
> > > too.  =20
> >=20
> > And then we would have one port with SW HSR and another one with HW
> > HSR? =20
>=20
> No. One HSR device (hsr0, with 2 member ports) with offload and one
> HSR device (hsr1, with 2 member ports) without offload (see (b)
> below).
>=20
> > >It would be good if you could verify that the unoffloaded HSR
> > > works well after the changes too. =20
> >=20
> > I've tested on KSZ9477-EVB the SW HSR operation with two ports (and
> > two or three boards) and HW HSR offloading. Results are presented
> > in the cover-letter. =20
>=20
> "results in the cover letter"
>=20
> Results:
> With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> With no offloading                     RX: 63 Mbps  TX: 63 Mbps
>=20
> What was the setup for the "no offloading" case?
>=20

I used two boards. I've used the same kernel with and without HSR
offloading patches.

Cables were connected to port1 and port2 on each board. Non HSR network
was connected to port3.

> (a) kernel did not contain the offloading patch set
>=20

Yes.

> (b) the testing was on hsr1, in the situation below:
>=20
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
> version 1 # offloaded ip link add name hsr1 type hsr slave1 lan3
> slave2 lan4 supervision 45 version 1 # unoffloaded
>=20

I did not setup two hsr devices on the same board. I've used two boards
with hsr0 setup on each.

> (d) in some other way (please detail)
>=20
> I was specifically asking about situation (b).

I did not tested the hsr0, hsr1 as my (real) use case is with KSZ9477
having only 3 ports available for connection (port 1,2,3).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/+hut5hP6N6FM.lYbJUHQWJL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3MYAACgkQAR8vZIA0
zr2hOwgAioIh83U/59WvQqS+Np2hIQOO/+Fjb8jR+dIhbk7ABdzEndeoZ31nJ8AA
6NGzoeZIZs5QiEGIOM4fhmSjt7n0Crz8KmEyjckLRtIhQROTYk1LOOK9RZKBuaiF
a6hm+voY2d6cSMg8rU754y2Rs9RuCoprHn4LZ2vKnfohw6TwdASPePrXJ4CYNFEU
12OcDfKKPpc374j+DG5u0NlhSFj9ExIMP3eCJBJjvchNM+G6Fo0taInB0fB8rZSi
vKJiW5jURQbShxviCUo4iDDXLYSaYtnIKoJtuXBJGachDJjBK6BOSOC1SX6wxfhA
GsOwHeCsPRD1KcwZUmS7xnsOv53y4A==
=AMD3
-----END PGP SIGNATURE-----

--Sig_/+hut5hP6N6FM.lYbJUHQWJL--
