Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F66792BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjIEQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354382AbjIELLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:11:15 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA11AB;
        Tue,  5 Sep 2023 04:11:11 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5ED5586983;
        Tue,  5 Sep 2023 13:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693912270;
        bh=nfv8Djq+1XzRoLYZA7o94p1iLlwa4gunqIE27pNi85Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wcs4+53JOChZr2CaUOTt2yd9OtZQqxuAj8HyDG4rirNE7HqXV7+ifIdlaXOtMgbvk
         ZTxHnrGE+jfOrLDC3Rur63usrIAkqso1TO5hC0xhxievD6OQe3arEeamCxUl7sTVyP
         tN+k1prBy5XR7S5OB/CGkAaKdZujF0HKi1hdbBAcVisII77gNVyV4HNiNa+ZQlBbjE
         MR8DV5/oDavLrgRlQESo/At2iUizSJ1n9r3Lodxwtzsm9Cj7clk3TQ9sUii1hMI0ak
         PnLnA1McT2DZR1jzX5ctjXK2wid2X/CG0DwSE/x3HPG8jyoTLXO7Ida5uc0ayCwNZY
         FjnfzcjHdgz9Q==
Date:   Tue, 5 Sep 2023 13:11:03 +0200
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
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905131103.67f41c13@wsk>
In-Reply-To: <20230905103750.u3hbn6xmgthgdpnw@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-1-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230904120209.741207-4-lukma@denx.de>
        <20230905103750.u3hbn6xmgthgdpnw@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7sH1kqL/ScrbYnL=_OZvBj3";
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

--Sig_/7sH1kqL/ScrbYnL=_OZvBj3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Mon, Sep 04, 2023 at 02:02:08PM +0200, Lukasz Majewski wrote:
> > This patch adds functions for providing in KSZ9477 switch HSR
> > (High-availability Seamless Redundancy) hardware offloading.
> >=20
> > According to AN3474 application note following features are
> > provided:
> > - TX packet duplication from host to switch (NETIF_F_HW_HSR_DUP)
> > - RX packet duplication discarding
> > - Prevention of packet loop
> >=20
> > For last two ones - there is a probability that some packets will
> > not be filtered in HW (in some special cases). Hence, the HSR core
> > code shall be used to discard those not caught frames.
> >=20
> > Moreover, some switch registers adjustments are required - like
> > setting MAC address of HSR network interface.
> >=20
> > Additionally, the KSZ9477 switch has been configured to forward
> > frames between HSR ports (1,2) members.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Use struct ksz_device to store hsr ports information (not struct
> > dsa)
> >=20
> > Changes for v3:
> > - Enable in-switch forwarding of frames between HSR ports (i.e.
> > enable bridging of those two ports)
> >=20
> > - The NETIF_F_HW_HSR_FWD flag has been marked as supported by the
> > HSR network device
> >=20
> > - Remove ETH MAC address validity check as it is done earlier in
> > the net driver
> >=20
> > - Add comment regarding adding support for NETIF_F_HW_HSR_FWD flag
> > ---
> >  drivers/net/dsa/microchip/ksz9477.c | 103
> > ++++++++++++++++++++++++++++ drivers/net/dsa/microchip/ksz9477.h |
> >  4 ++ 2 files changed, 107 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c
> > b/drivers/net/dsa/microchip/ksz9477.c index
> > 83b7f2d5c1ea..c4ed89c1de48 100644 ---
> > a/drivers/net/dsa/microchip/ksz9477.c +++
> > b/drivers/net/dsa/microchip/ksz9477.c @@ -1141,6 +1141,109 @@ int
> > ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
> > return ksz_pwrite16(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
> > }=20
> > +/* The KSZ9477 provides following HW features to accelerate
> > + * HSR frames handling:
> > + *
> > + * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
> > + * 2. RX PACKET DUPLICATION DISCARDING
> > + * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS FILTERING
> > + *
> > + * Only one from point 1. has the NETIF_F* flag available.
> > + *
> > + * Ones from point 2 and 3 are "best effort" - i.e. those will
> > + * work correctly most of the time, but it may happen that some
> > + * frames will not be caught. Hence, the SW needs to handle those
> > + * special cases. However, the speed up gain is considerable when
> > + * above features are used.
> > + *
> > + * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
> > HSR frames
> > + * can be forwarded in the switch fabric between HSR ports. =20
>=20
> How do these 2 concepts (autonomous forwarding + software-based
> elimination of some frames) work together? If software is not the sole
> receiver of traffic which needs to be filtered further, and duplicates
> also get forwarded to the network, does this not break the HSR ring?
>=20

Autonomous forwarding is based on KSZ9477, having the HSR ports
"bridged" to send frames between them.

Then, there is also based on HSR tag, and SA in-KSZ9477 feature RX
packet duplication discarding which will discard duplicated frames.

Last but not least the - packet loop prevention.

My understanding is as follows:

1. RX packet duplication removes copy of a frame, which is addressed to
cpu port of switch.

2. The "bridge" of HSR passes frames in-KSZ9477, which are not
addressed to this cpu host (between other HSR nodes).

3. Packet loop prevention - the HSR packet with SA of note which sent
it - is not further forwarded.

> What are the causes due to which self-address filtering and duplicate
> elimination only work "most of the time"?

Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availab=
ility-Seamless-Redundancy-Application-Note-00003474A.pdf

>=20
> > + */
> > +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> > NETIF_F_HW_HSR_FWD) +
> > +int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr,
> > +		     struct dsa_port *partner)
> > +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +	struct net_device *slave;
> > +	u8 i, data;
> > +	int ret;
> > +
> > +	/* Program which ports shall support HSR */
> > +	dev->hsr_ports =3D BIT(port) | BIT(partner->index);
> > +	ksz_write32(dev, REG_HSR_PORT_MAP__4, dev->hsr_ports);
> > +
> > +	/* Forward frames between HSR ports (i.e. bridge together
> > HSR ports) */
> > +	ksz_prmw32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4,
> > dev->hsr_ports,
> > +		   dev->hsr_ports);
> > +	ksz_prmw32(dev, partner->index,
> > REG_PORT_VLAN_MEMBERSHIP__4,
> > +		   dev->hsr_ports, dev->hsr_ports); =20
>=20
> Call ksz9477_cfg_port_member() instead?

+1

Thanks for the information.

>=20
> > +
> > +	/* Enable discarding of received HSR frames */
> > +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> > +	data |=3D HSR_DUPLICATE_DISCARD;
> > +	data &=3D ~HSR_NODE_UNICAST;
> > +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> > +
> > +	/* Self MAC address filtering for HSR frames to avoid
> > +	 * traverse of the HSR ring more than once.
> > +	 *
> > +	 * The HSR port (i.e. hsr0) MAC address is used.
> > +	 */
> > +	for (i =3D 0; i < ETH_ALEN; i++) {
> > +		ret =3D ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> > hsr->dev_addr[i]);
> > +		if (ret)
> > +			return ret; =20
>=20
> FWIW:
> https://lore.kernel.org/netdev/155ff37f-43d5-5fe0-6de4-c4639909553d@gmail=
.com/
> Some coordination will be required regarding the MAC address that the
> switch driver needs to program to these registers.=20

Writing of this MAC address is _required_ for PREVENTING PACKET LOOP IN
THE RING BY SELF-ADDRESS FILTERING feature.

In the ifconfig output - the lan1, lan2 and hsr0 shall all have the
same MAC address assigned.

I simply take the hsr0 mac address.

> It seems that it
> is not single purpose.

At least in the case of HSR it looks like single purpose (for the loop
prevention).

>=20
> > +	}
> > +
> > +	/* Enable global self-address filtering if not yet done
> > during switch
> > +	 * start
> > +	 */
> > +	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data);
> > +	if (!(data & SW_SRC_ADDR_FILTER)) {
> > +		data |=3D SW_SRC_ADDR_FILTER;
> > +		ksz_write8(dev, REG_SW_LUE_CTRL_1, data);
> > +	} =20
>=20
> If there is no way that SW_SRC_ADDR_FILTER can be unset after
> ksz9477_reset_switch() is called, then this is dead code which should
> be removed.

Yes. Correct. I will remove it.

>=20
> > +
> > +	/* Enable per port self-address filtering */
> > +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
> > PORT_SRC_ADDR_FILTER, true);
> > +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> > +		     PORT_SRC_ADDR_FILTER, true);
> > +
> > +	/* Setup HW supported features for lan HSR ports */
> > +	slave =3D dsa_to_port(ds, port)->slave;
> > +	slave->features |=3D KSZ9477_SUPPORTED_HSR_FEATURES;
> > +
> > +	slave =3D dsa_to_port(ds, partner->index)->slave;
> > +	slave->features |=3D KSZ9477_SUPPORTED_HSR_FEATURES; =20
>=20
> Can the code that is duplicated for the partner port be moved to the
> caller?

I've followed the convention from xrs700x driver, where we only make
setup when we are sure that on both HSR ports the "join" has been
called.

>=20
> > +
> > +	pr_debug("%s: HSR join port: %d partner: %d port_map:
> > 0x%x\n", __func__,
> > +		 port, partner->index, dev->hsr_ports);
> > +
> > +	return 0;
> > +}
> > +
> > +int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct
> > net_device *hsr,
> > +		      struct dsa_port *partner)
> > +{
> > +	struct ksz_device *dev =3D ds->priv;
> > +
> > +	/* Clear ports HSR support */
> > +	ksz_write32(dev, REG_HSR_PORT_MAP__4, 0);
> > +
> > +	/* Disable forwarding frames between HSR ports */
> > +	ksz_prmw32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4,
> > dev->hsr_ports, 0);
> > +	ksz_prmw32(dev, partner->index,
> > REG_PORT_VLAN_MEMBERSHIP__4,
> > +		   dev->hsr_ports, 0);
> > +
> > +	/* Disable per port self-address filtering */
> > +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
> > PORT_SRC_ADDR_FILTER, false);
> > +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> > +		     PORT_SRC_ADDR_FILTER, false);
> > +
> > +	return 0;
> > +}
> > +
> >  int ksz9477_switch_init(struct ksz_device *dev)
> >  {
> >  	u8 data8;
> > diff --git a/drivers/net/dsa/microchip/ksz9477.h
> > b/drivers/net/dsa/microchip/ksz9477.h index
> > b6f7e3c46e3f..634262efb73c 100644 ---
> > a/drivers/net/dsa/microchip/ksz9477.h +++
> > b/drivers/net/dsa/microchip/ksz9477.h @@ -58,5 +58,9 @@ int
> > ksz9477_dsa_init(struct ksz_device *dev); int
> > ksz9477_switch_init(struct ksz_device *dev); void
> > ksz9477_switch_exit(struct ksz_device *dev); void
> > ksz9477_port_queue_split(struct ksz_device *dev, int port); +int
> > ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device
> > *hsr,
> > +		     struct dsa_port *partner);
> > +int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct
> > net_device *hsr,
> > +		      struct dsa_port *partner);
> > =20
> >  #endif
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

--Sig_/7sH1kqL/ScrbYnL=_OZvBj3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT3DMcACgkQAR8vZIA0
zr2NswgA0rt9t6pOfJjLTT7WEfgqizDsy99TXVtKFVurg50Py7R7ieEU9yQjglio
Lg1FgFnZZYESQ1HX5tJLtmzKROmJJlDDDVCIAucafge9GF0IE+1BLHn82jzz/NiD
EdorATavJoU8x1Df7o0+y7bEogOt9KqigDldmV3FiYWbcgC6Yf2sFFGU9gIH35Iw
9k7rlF0Bgkz+4r0oseiXLbO+v8RLVTzpMXzHQGpamGEv8BHNIUjmgdqpEySBXtB8
9BpgTJo0Qi69JRxPl6j/ARhEGxeyjBL6Dga/XrHSeMaXPHDbr5X0smk7W60mihZh
AnFRx0vhBTUrMg8Pt+r1Wdn+hdG1qw==
=1Jf1
-----END PGP SIGNATURE-----

--Sig_/7sH1kqL/ScrbYnL=_OZvBj3--
