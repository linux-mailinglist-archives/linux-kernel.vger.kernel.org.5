Return-Path: <linux-kernel+bounces-150406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE18A9E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3FB28413B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013616F90B;
	Thu, 18 Apr 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MR9Y1Fwh"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5D16D4C7;
	Thu, 18 Apr 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454646; cv=none; b=o2tnqyN6xQJYkCLE0Dui1gHdqa+h5DnQl5IqeJQRvAHz1njztRSsZObVDboS68Ezwv5QWSxOrEGl+z0f7dvo+j2AUQSdkt4hQDu6zG4WzYE5y7yvHpfGGqVgBt6NpgMtrQ+t/3NVu4dfFAqbAB8lD5mi1r+/CxO6UnJy3DGhOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454646; c=relaxed/simple;
	bh=YnM2rikz5QhT/QqddK0QVZbnso2VB0ijxW0fpbt/2BE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjuZqJDeg95tRjdcp4xZskILLh77dNv7ihsRbnUgQ0GD9kk/Yc1Ho1jpJFubd/D0e9gRNcXMPBjtQq7pRscfcxRQrSfkJo43IZnkR5OoLbXHqyu+oVYM6XDepLEYElAxv0tpDcFvkfCBcXX3QkKBfdvHMYUtDirTJ9GGEKauiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MR9Y1Fwh; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 67A7B88667;
	Thu, 18 Apr 2024 17:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713454637;
	bh=dMc6Ldce7k8mU0jXQXvWlHEwIG8N0QD36Brp4Z2RFJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MR9Y1FwhTa9DliKINJOQNgD/L/HjC2bMxvBlmFjuqmL04P+BTGLGfWDv4hZyVhSPQ
	 RiDUkCdL+svnHQcoQ7TKY1E/BKGq423yVwN95d4hfBgJHAyKjwpwX/0tP4y04OaH0K
	 9LfB33PcEfbYsNcvyyspjrVvavdxLnNxlgYlhuyCL+Gp6k6fZF1M4uVcpK9BTy37+1
	 jZ2C11N8qGnVGhAlJ1iSG8rVRKAeAMAe0rsRNofSJYbKbhlMi+NMzeiWzdRYDeUycS
	 k4s6SJZDGg3MHnl62in9oCC8eDPyiPZ7RxEy3mfchoMBn2UVrlOLxM1AFTSFTOxJna
	 tWaaHvJgILVyQ==
Date: Thu, 18 Apr 2024 17:37:06 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Casper Andersson <casper.casan@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support
 (HSR-SAN)
Message-ID: <20240418173706.206e6a2f@wsk>
In-Reply-To: <86bk66hjyf.fsf@gmail.com>
References: <20240415124928.1263240-1-lukma@denx.de>
	<20240415124928.1263240-2-lukma@denx.de>
	<86mspt7glf.fsf@gmail.com>
	<20240416150359.7362c762@wsk>
	<86bk66hjyf.fsf@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O9g3=yDfNv/1EZa2C=08YyX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/O9g3=yDfNv/1EZa2C=08YyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Casper,

> Hi,
>=20
> Sorry for the late reply, I was awaiting confirmation on what I can
> say about the hardware I have access to. They won't let me say the
> name :( but I can give some details.

Ok, good :-)

At least I'm not alone and there is another person who can validate the
code (or behaviour) on another HSR HW.

(Some parts of the specification could be double checked on another HW
as well).

>=20
> On 2024-04-16 15:03 +0200, Lukasz Majewski wrote:
> >> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote: =20
> >> > Changes for v3:
> >> >
> >> > - Modify frame passed Port C (Interlink) to have RedBox's source
> >> > address (SA) This fixes issue with connecting L2 switch to
> >> > Interlink Port as switches drop frames with SA other than one
> >> > registered in their (internal) routing tables.   =20
> >>  =20
> >> > +	/* When HSR node is used as RedBox - the frame received
> >> > from HSR ring
> >> > +	 * requires source MAC address (SA) replacement to one
> >> > which can be
> >> > +	 * recognized by SAN devices (otherwise, frames are
> >> > dropped by switch)
> >> > +	 */
> >> > +	if (port->type =3D=3D HSR_PT_INTERLINK)
> >> > +		ether_addr_copy(eth_hdr(skb)->h_source,
> >> > +				port->hsr->macaddress_redbox);
> >> >  =20
> >>=20
> >> I'm not really understanding the reason for this change. Can you
> >> explain it in more detail? =20
> >
> > According to the HSR standard [1] the RedBox device shall work as a
> > "proxy" [*] between HSR network and SAN (i.e. "normal" ethernet)
> > devices.
> >
> > This particular snippet handles the situation when frame from HSR
> > node is supposed to be sent to SAN network. In that case the SA of
> > HSR (SA_A) is replaced with SA of RedBox (SA_RB) as the MAC address
> > of RedBox is known and used by SAN devices.
> >
> >
> > Node A  hsr1  |=3D=3D=3D=3D=3D=3D| hsr1 Node Redbox |   |
> > (SA_A) [**]   |	     |           eth3   |---| ethX SAN
> > 	      |      |        	 (SA_RB)|   |  (e.g switch)
> >
> >
> > (the =3D=3D=3D=3D=3D=3D represents duplicate link - like lan1,lan2)
> >
> > If the SA_A would be passed to SAN (e.g. switch) the switch could
> > get confused as also RedBox MAC address would be used. Hence, all
> > the frames going out from "Node Redbox" have SA set to SA_RB.
> >
> > According to [1] - RedBox shall have the MAC address.
> > This is similar to problem from [2]. =20
>=20
> Thanks for the explanation, but I still don't quite follow in what way
> the SAN gets confused. "also RedBox MAC address would be used", when
> does this happen? Do you mean that some frames from Node A end up
> using the RedBox MAC address so it's best if they all do?

The SAN (let's say it is a switch) can communicate with RedBox or Node
A. In that way the DA is different for both (so SA on reply is also
different). On my setup I've observed frames drop (caused probably by
switch filtering of incoming traffic not matching the outgoing one).

When I only use SA of RedBox on traffic going to SAN, the problem is
gone.

IMHO, such separation (i.e. to use only RedBox's SA on traffic going to
SAN) is the "proxy" mentioned in the standard.

>=20
> I see there is already some address replacement going on in the HSR
> interface, as you pointed out in [2]. And I get your idea of being a
> proxy. If no one else is opposed to this then I'm fine with it too.
>=20

Ok.

> >> The standard does not say to modify the
> >> SA. However, it also does not say to *not* modify it in HSR-SAN
> >> mode like it does in other places. In HSR-HSR and HSR-PRP mode
> >> modifying SA breaks the duplicate discard. =20
> >
> > IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between two
> > types (and not fully compatible) networks.
> > =20
> >> So keeping the same behavior for all
> >> modes would be ideal.
> >>=20
> >> I imagine any HW offloaded solutions will not modify the SA, so if
> >> possible the SW should also behave as such. =20
> >
> > The HW offloading in most cases works with HSR-HSR setup (i.e. it
> > duplicates frames automatically or discards them when recived - like
> > ksz9477 [3]).
> >
> > I think that RedBox HW offloading would be difficult to achieve to
> > comply with standard. One "rough" idea would be to configure
> > aforementioned ksz9477 to pass all frames in its HW between SAN and
> > HSR network (but then it wouldn't filter them). =20
>=20
> I don't know anything about ksz9477. The hardware I have access to is
> supposed to be compliant with 2016 version in an offloaded situation
> for all modes (HSR-SAN, PRP-SAN, HSR-PRP, HSR-HSR).

Hmm... Interesting.

As fair as I know - the ksz9477 driver from Microchip for RedBox sets
internal (i.e. in chip) vlan for Node_A, Node_B and Interlink, so _all_
packets are flowing back and forth between HSR and SAN networks ....

> Though, I haven't
> verified if the operation is fully according to standard.

You may use wireshark on device connected as SAN to redbox and then see
if there are any frames (especially supervisory ones) passed from HSR
network.

> It does not
> modify any addresses in HW.

By address - you mean the MAC addresses of nodes?

>=20
> Does the interlink port also reach the drivers?

Could you be more specific in your question?

> Does it call
> port_hsr_join and try to join as an HSR port?=20

No, not yet.

The community (IIRC Vladimir Oltean) suggested to first implement the
RedBox Interlink (HSR-SAN) in SW. Then, we may think about adding
offloading support for it.

> Do we maybe need a
> separate path or setting for configuring the interlink in the
> different modes (SAN, HSR, PRP interlink)?

I think that it shall be handled as an extra parameter (like we do have
now with 'supervision' or 'version') in ip link add.

However, first I would like to have the "interlink" parameter added to
iproute2 and then we can extend it to other modes if requred.

>=20
> > Notes:
> >
> > [*] - However there is no specific "guidelines" on how the "proxy"
> > shall be implemented.
> >
> > [**] - With current approach - the SAN MAC addresses are added to
> > "node table" of Node A. For Node RedBox those are stored in a
> > separate ProxyNodeTable. I'm not sure if this is the best possible
> > approach [***], as ideally only MAC addresses of HSR "network"
> > nodes shall be visible.
> >
> > [***] - I think that this "improvement" could be addressed when HSR
> > support is added to Linux as it is the pre-requisite to add support
> > for it to iproute2. Afterwards, the code can be further refined (as
> > it would be added to net-next anyway).
> >
> > [****] - As I'm now "on the topic" - I can share full setup for
> > busybox to run tests included to v5 of this patch set.
> >
> >
> > Links:
> >
> > [1] - IEC 62439-3:2021
> >
> > [2] -
> > https://elixir.bootlin.com/linux/latest/source/net/hsr/hsr_framereg.c#L=
397
> >
> > [3] -
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/microchi=
p/ksz9477.c#L1341
> > =20
>=20
> BR,
> Casper




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/O9g3=yDfNv/1EZa2C=08YyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYhPiIACgkQAR8vZIA0
zr2QNwf/QDoVd6hOFqEOoJdPBnRveTnP7o7gf8MjQ8wgGuI0fVw7zquMK6Xjc8hp
eS/SYzXeP6EkjXstKmnRIwfW+llpwE5syZc5lI6lFik0VVMSGQTG/2tsFBG7WUy5
/Z53vFwDtQQEldAuoBTUZQ5FFbXYl2yieNCwbTFWUtgIGb5z0hWPLYVXT/lgJ40X
LHXBrDacdOyAD7NRPibMq4k6z+wL2fRqhhoL+4O2JOiPu3ymdlDFqObx6NsgysLf
vmoCeghWNGi9xpty6RQRks/6t7soQHUypQ9K++G+hpkVZXp9jB7Rtm1N07eCQOif
VHvrdKHwPgZ1kPoebqNWPHgxGROk5w==
=MJO3
-----END PGP SIGNATURE-----

--Sig_/O9g3=yDfNv/1EZa2C=08YyX--

