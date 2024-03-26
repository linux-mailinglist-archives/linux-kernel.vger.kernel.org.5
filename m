Return-Path: <linux-kernel+bounces-118573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B888BCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372FEB21AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD5182B9;
	Tue, 26 Mar 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W6sb3PhX"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04331125B9;
	Tue, 26 Mar 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442980; cv=none; b=WV5NaSV2ycqFLzFzeH0wVgdWhnW2qn3IQ8+5dlmmOPGNLZED5icTI936977ygIkqLBeznYNFW0hOzJ0M68EWGoJSj2WxmunFgczrvc5TQqYoxIhf+bIuuzwq7CFCTLyeq3G34wEgyZ52EDtVMVwJC9q4jTkY078Fw0rT6qZFnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442980; c=relaxed/simple;
	bh=eK9g3rAF9QuSr1+qbKLGwZRlPMpzV7oqDZsrpXg/rcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGi7inDGJmIeNmyftf6uhBbR2voATa/CXFLl536otnk4Lec58PlLD8B2ic86AGf5a35OXIiX0Zxkpb/3xX2MxqMx4gJu2mCDknzEOrTNYmybZ+x9mKiNV4eKtfkfCw/gPy0k3JAYhZHUOfV2cwIsY9oM+1jXXHEZg7BaZcCtZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W6sb3PhX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 627A0C000F;
	Tue, 26 Mar 2024 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711442961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=djtT4ar2N3PrhGmug7K3I7GpRHozxVNMP+cK2xxicAI=;
	b=W6sb3PhXIVN8bLR58X8VykTFD5pHWw3+DbKLLb1wx6NxXEyC+f+HARjWKuE6/eALH88Jyz
	wBMdTz76qQThXTMujn0lfQ1Fyo8dBXBjmNqGfn4KIG4jD4GG6R6vG/w6mAVw24jhMRgyO1
	/cQTYge13rgTkhku9jBB9Uj2T3SISNa4qqBsE/tz1vWG/P+2JRsLJaIATY/UE7bBphqAV5
	3VcYMvvGubz1rf24rBA35RUVeDFbTxjsxlPwAWesaU2ygGQdmJI+wttkrUKw3OCuq8RVCn
	+GUQ1P4b5Uw8DKVuyfZ54GKNFWybW1Vb1wx7NzEVW7lN/mAHhJT2ysOcSE16Iw==
Message-ID: <277c78a696e27e77e34820ebf2f7a0d0ce5d0633.camel@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: allow MTU change when the interface
 is up
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 26 Mar 2024 09:49:19 +0100
In-Reply-To: <20240325185647.0ad674e9@kernel.org>
References: <20240325152735.1708636-1-thomas.perrot@bootlin.com>
	 <20240325205401.GF403975@kernel.org> <20240325185647.0ad674e9@kernel.org>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-rtmeiWdgqR/hbY6LMpWH"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: thomas.perrot@bootlin.com


--=-rtmeiWdgqR/hbY6LMpWH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, 2024-03-25 at 18:56 -0700, Jakub Kicinski wrote:
> On Mon, 25 Mar 2024 20:54:01 +0000 Simon Horman wrote:
> > I'm not sure that it is expected behaviour for an interface
> > to reset like this when a change of MTU is requested.
> > While conversely I think it is common (if not entirely desirable)
> > to prohibit changing the MTU when an interface is up.
> > What is the problem being addressed here?
>=20

The problem being addressed here, is that NetworkManager isn't able to
apply the MTU value set in the connection configuration file because
the link is already up, then the change_mtu callback returns an error:

"NetworkManager[412]: <debug> [1709629970.1735] platform: (eth0) link:
setting mtu 1400                                                     =20
NetworkManager[412]: <trace> [1709629970.1737] platform-linux: delayed-
action: schedule wait-for-response-rtnl (seq 41, timeout in
0.199992796, response-type 0)                                        =20
NetworkManager[412]: <trace> [1709629970.1737] platform-linux: delayed-
action: schedule refresh-link (ifindex 2)                            =20
NetworkManager[412]: <trace> [1709629970.1738] platform-linux: delayed-
action: handle refresh-link (ifindex 2)                              =20
NetworkManager[412]: <debug> [1709629970.1738] platform-linux: do-
request-link: 2                                                      =20
NetworkManager[412]: <trace> [1709629970.1739] platform-linux: rtnl:
recvmsg: new message NLMSG_ERROR, flags 0, seq 41                    =20
NetworkManager[412]: <debug> [1709629970.1740] platform-linux: rtnl:
recvmsg: error message from kernel: Device or resource busy (-16) for
request 41"

Kind regards,
Thomas Perrot

> Right..
>=20
> > > =C2=A0	dev->mtu =3D new_mtu;
> > > =C2=A0
> > > +	if (reset)
> > > +		macb_open(dev);
>=20
> .. imagine admin does this over SSH on a remote box and system=20
> is under memory pressure. Even ignoring the fact you're not checking
> the return value, the result of changing MTU should be either having=20
> the requested MTU (success) or having the old MTU (failure).
> Not "machine drops off the network" :(
>=20

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


--=-rtmeiWdgqR/hbY6LMpWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmYCjA8ACgkQn8ALBXH+
Cu151wv/eJxTxKVjILtwXPWoN8a8eYr7hfSRpx8M/MYqrwc4rCuFGuI4wx5vrrk2
N6pBBdqTRR6Ue4CaN/j3IiPS2BpRGmZBLqcfXETdTgPh1/2poRFqNClO6TtgZHwH
RQvAiwz3wgQPGHozT0FAfJWsvRdM31dyWxoM/wK28os3p8OQ34O9xSwW5HBcF/Vj
0ny9AlEfzVRUJKEB8sdEM7TzXKnzEdQp5JLoK5+lbl0z03/iBYK/I+H/rnx6QgxZ
7kzxpfu9e/bKjeLf8S+sCdWm3wD49RZPgRcyq/PMGuT+oCo/B7ADpSF07IvT4r5K
PiDp8hoJq/NMq70mO2OSPFMBRQMddJBRIypvTvRuURcdscqA/s1UC1SmFcJpTPMO
1kKg8UF4BgLuZMUTnJgiDxD6X85pvUgEn3fAXAbRCdJOxiDegSPLSq2vdKC0WnNC
nTF04TfB77BBK6muEoYoqlKSg7xPH0NtZhE5yrPqBhiB87gEPrJ00T0eyYu6oYa0
BDCD8xok
=N2Wi
-----END PGP SIGNATURE-----

--=-rtmeiWdgqR/hbY6LMpWH--

