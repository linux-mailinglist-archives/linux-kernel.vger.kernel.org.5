Return-Path: <linux-kernel+bounces-142950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA18A326F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF41C23F69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0B147C95;
	Fri, 12 Apr 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cyTSbVfl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B0144D34;
	Fri, 12 Apr 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935695; cv=none; b=hI5J9yoGCw/jndy+3bRzOTmXNdtjq20NBpdO2tGuJFmbAfsW78fy8c0ipQTUyJLLWUgBPUYZzbIf94QJxJx8wjgoVwbEALFnYmz4Z9mF9XT+TqgMdPj5KQTw0InAB5lCfCR5dMpOu1+nd9NoEObA9hjTytBIPfzrckJ9bvlFvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935695; c=relaxed/simple;
	bh=xv5GskYPQh/bdYUrHDvVzkViHT9Q8wEHbflL/X/TEkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heVGxUReHgu10w94ympsQG8qUhU5cH0EG/zzp81YihMeF0rZWc0inFdzorleyKk5LqUBPHL3GYhLn3E7lm6H6BrcQleszAcv/cT3Pci+b252EA8RMXfCF0LGUbqbujFCmbFb3Xd9vxtdIwLfuQrnSNr+Gfjomz1E+z/pmSEl9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cyTSbVfl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712935692;
	bh=xv5GskYPQh/bdYUrHDvVzkViHT9Q8wEHbflL/X/TEkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyTSbVflJjcSfFqNbFhnyVekkJ0HOMl6VOxAWSEMZlIhwqepNVVMXl9nAJxW242h2
	 ipq417AkNny3HCaw3HKxi2l68bzzu9b0YSBXU4GgjNqpcqrTL8ZG3BaAICwk34CrMX
	 DFLWxeX8tdIry5q5usnFuO2IMB6VprNiubJZIVfBBfT6H28IEiAuP5uX1o4ljUGO/u
	 kRj01CaKOo1eL5KjaPejzL8WN/Cqf7XJWP38D0KJVJGu1KVNLJqHRb3eaxpY0ljXPA
	 7pHB2/JWGRqhfGCAA/Q1js44CP4bqSZW2i1Q8mRYwbUDBHESi9LkOsDbdI822uXITi
	 gJjFq+85kUMEg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 11B923782117;
	Fri, 12 Apr 2024 15:28:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B79B810608F7; Fri, 12 Apr 2024 17:28:11 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:28:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-rockchip@lists.infradead.org, 
	linux-phy@lists.infradead.org, Frank Wang <frank.wang@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Kever Yang <kever.yang@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v5 00/10] RK3588 USBDP support
Message-ID: <msttmdg2va7cwutn23f5zsmi6assert62in5esyovdfcpsudgx@6hwh7qwirstb>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
 <171293314494.1912962.2483494926339362221.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26xfkqfmlvq46c2i"
Content-Disposition: inline
In-Reply-To: <171293314494.1912962.2483494926339362221.b4-ty@sntech.de>


--26xfkqfmlvq46c2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Heiko,

On Fri, Apr 12, 2024 at 04:46:43PM +0200, Heiko Stuebner wrote:
> On Tue, 9 Apr 2024 00:50:27 +0200, Sebastian Reichel wrote:
> > This adds Rockchip RK3588 USBDP PHY support, which is used for two of t=
he three
> > USB3 controllers in the RK3588 (the third one uses a different PHY, whi=
ch is
> > already supported). The USBDP PHY offers USB3 dual-role and DisplayPort=
=2E The
> > driver and bindings being upstreamed contains the DP parts, but only US=
B3 has
> > been tested by me (upstream does not yet have a DRM DP bridge driver fo=
r this
> > platform).
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [...]
>
> I've rearranged some things in the evb1 patch:
> - vbus* before vcc*
> - some newlines between properties and subnodes around
>   the endpoints

Thanks, sorry for the extra work.

-- Sebastian

--26xfkqfmlvq46c2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYZUwgACgkQ2O7X88g7
+prvMxAAn/qQMN3VahlJ2xicppQhn/iGZC2aaKw6gEGDJy3xAnFr41nzyLyVHEIr
dR/Hw7ip1EUYK47Zx8hk4Xoq93bmtiuasmVq/QudBVwa3fYBWhqWRh51PeMC7h40
ZV0DPXhsTn7imeaDkMI/2Cj1Dqj3guB6VEvlg8L/lReWLA5T5tBNr5rz4Uu/Jab5
QZeGu/UKGU2LUubE73UdrAikTs+PrExgaE2y471k3szChV08LiBBZjYhRwAD2eCL
ykU+fa+pntf2ygr90GzGOD69dBkFJIg8C2WH7uBBWB7qEgSAt5C6eFVtNfixALnA
EBYNSuWQOeSjFxr0ekNdnNETnFMsh1raRK4TqE3rQ+g/WENkp6mLreVHcpg12EgA
LmKuC5iGgngObHPkST0MUEVbszFAmhoyMlEyg2FFT5FZXK0P+ntSJUVN6tAXCECh
ztx0qZPagjc+xUgETknb+0w8/EeZTBRYzXs+VnLJxPtiUff7YPu6PiY0s6nvG1po
I4Es1QSaQ2gR13yzccV3ZEXD/U99VKlq59taeIp+JCEi0AuWhr69eVUaHwyprios
mPPOgsx8UG+oT53o+YhvcSJRBEwdNRVQYikBtna1XOHOidYb+cMRo9CmVLM8cbBf
dc09icsSiYLwwP6MDdrvkQ8CUVBySE0QS6kwB9bnY926kJPNMtw=
=F10l
-----END PGP SIGNATURE-----

--26xfkqfmlvq46c2i--

