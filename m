Return-Path: <linux-kernel+bounces-149925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967548A97EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D2A281CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9515E21B;
	Thu, 18 Apr 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UCO4Z4Rs"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EC15E1EE;
	Thu, 18 Apr 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437630; cv=none; b=laaB4ffyPlCuVLMyy0YpOkksyuoRtYxRHqW8CM0Vy3Va9/u7Tcy6dsyK3KRRNDomwuf1M2D5wyNra85AQ2crpQ0NMiV2sCjlI3W+B8AXzA/eBuNGNNyTvIrlcaQT/THbWve3y7EDSEwM/86KqFa4UegyB0KxYirTSomyh9H4RMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437630; c=relaxed/simple;
	bh=0bMymNfyilD0mEZmB2VOm3tjTxQImGlD7fHVsxlSUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itfaASZnwYvVdqR1zQOzy2StAv8VJ/vUiLI4OpP//3RR354wtdNLFeg5XHfRXTfIUK80NLyT8b1C+jfC4ziGLhUMhoV2h9xT1+nZyWZK/pwD85wB3QvQeac38tt85gRu2rL1rOCEowLhBkYyex9BONbrewge62Zbg26IbH0YHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UCO4Z4Rs; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 34549884D0;
	Thu, 18 Apr 2024 12:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713437626;
	bh=Hr5k1M/26cGwCrFIGpMIAqPOxeHJ0YhH3NLKzZ9M5q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCO4Z4RsJN5FsP/0P5noDLYR15AsfXdyCm5VEOm+qoL7DU99xtdt2C69DRrTEqUYD
	 VI1pxGuUAOJFWbQ4y9GWYpVuIpxR9E0QQYLAjMpIj555gNfBSWS3B474YLs3G+seVa
	 rX3qKVHdYB0znglvbxpVRvY0yfAXQ+IO9lMi9rVQRzas+TzxlnqYmXpLhr8sgc+42w
	 GE0fQfp6tQiiPceXlGIikChhrQNfcuWhmrLkbjNwx0/qxcnx36pMmq/QZZ2VMkcCik
	 8jlvrtJQSisU9micFB4h4xsnvVDpclq3PW+OqXFCr7vDAFVX3AMNWA6U9x97eAPBe6
	 P5Vk8BcajrQhQ==
Date: Thu, 18 Apr 2024 12:53:36 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, "Ricardo B. Marliere"
 <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support
 (HSR-SAN)
Message-ID: <20240418125336.7305d545@wsk>
In-Reply-To: <497b3f9b6d91a076c67f959ba878583a91b03cf5.camel@redhat.com>
References: <20240415124928.1263240-1-lukma@denx.de>
	<20240415124928.1263240-2-lukma@denx.de>
	<497b3f9b6d91a076c67f959ba878583a91b03cf5.camel@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o5cE9Pr733kdcosiTR3KCdG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/o5cE9Pr733kdcosiTR3KCdG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On Mon, 2024-04-15 at 14:49 +0200, Lukasz Majewski wrote:
> > Introduce RedBox support (HSR-SAN to be more precise) for HSR
> > networks. Following traffic reduction optimizations have been
> > implemented:
> > - Do not send HSR supervisory frames to Port C (interlink)
> > - Do not forward to HSR ring frames addressed to Port C
> > - Do not forward to Port C frames from HSR ring
> > - Do not send duplicate HSR frame to HSR ring when destination is
> > Port C
> >=20
> > The corresponding patch to modify iptable2 sources has already been
> > sent:
> > https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
> >=20
> > Testing procedure:
> > ------------------
> > The EVB-KSZ9477 has been used for testing on net-next branch
> > (SHA1: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f).
> >=20
> > Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for
> > ports 1/2 (with HW offloading for ksz9477) was created. Port 3 has
> > been used as interlink port (single USB-ETH dongle).
> >=20
> > Configuration - RedBox (EVB-KSZ9477):
> > if link set lan1 down;ip link set lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > interlink lan3 supervision 45 version 1 ip link set lan4 up;ip link
> > set lan5 up ip link set lan3 up
> > ip addr add 192.168.0.11/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > Configuration - DAN-H (EVB-KSZ9477):
> >=20
> > ip link set lan1 down;ip link set lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > supervision 45 version 1 ip link set lan4 up;ip link set lan5 up
> > ip addr add 192.168.0.12/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > This approach uses only SW based HSR devices (hsr1).
> >=20
> > --------------          -----------------       ------------
> > DAN-H  Port5 | <------> | Port5         |       |
> >        Port4 | <------> | Port4   Port3 | <---> | PC
> >              |          | (RedBox)      |       | (USB-ETH)
> > EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> > --------------          -----------------       ------------ =20
>=20
> The above description is obsoleted by follow-up tests, right?
>=20

No, it is still valid if one would like to use/test this code on two
KSZ9477-EVB boards.

However, I can add also information referring to hsr_redbox.sh tests as
well.

> Thanks,
>=20
> Paolo
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/o5cE9Pr733kdcosiTR3KCdG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYg+7AACgkQAR8vZIA0
zr1mhQgAuvTF/ITyY9rqDnd8OVYrmLANtF+DZvm3ILNdaNFE3/lZRmEPJVJ1TxuC
SWoOZGbpJzY/8cFPfa93Jlt2nHn/jdAKkQloNoGFc0eE+oJ7eJiavFchYyipVsVI
2/iFYckysXYsnIykYZ42Ck7FrhEtOXJqrmjG7WrwqCoHg2n940v8+mXLP5X/l5xF
3xL/joKPEq00ejTrnNCSwCcLrsq/JAh9mMoVWpGsklv8zqupOkrzh5Bx7Ogl/QVN
i4F/GWY/8H153ThxkCo5FaM4d4itzTQx8OEAm5D/Mg+wGxF4n2ESjyUbjm3D4RcB
19O15jHVzVH1RDHI10+ozb3exZ11/Q==
=iMUr
-----END PGP SIGNATURE-----

--Sig_/o5cE9Pr733kdcosiTR3KCdG--

