Return-Path: <linux-kernel+bounces-69274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E985867F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE9E2846DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EBA1384BC;
	Fri, 16 Feb 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PutBVRDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8A1369B3;
	Fri, 16 Feb 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113932; cv=none; b=L2gBYTdFpSL0K22PQDa4XL+qzWwo0ZTAJWrkuTWooziTRh5OZhClcVnH2gDF3wFOGtV6Jc5n3Y2uz3dQBmSVA6uHQ7O0w+yzWnkEjtsNfudsqHuLGz7TwObdWozpqHeXB04HZm2OdqviaW7MhFFJxWX6A86i4/kJ8XVp3aqGjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113932; c=relaxed/simple;
	bh=R1LMfj9gVDiZNBYMZ6CkLziOlU3U2JW7BDD5n3g2mmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxlUttoVab+ANgzFYtrW7q2glN0QXJtXPXHMv5BShXzIEVhWxbkli/SXrW9YUtMYpDQmFiZ9/cGoAIxNDHlzFhyOkY3GL4o8Xp3uXjXh6pIKbsmAZFvVc3ssFvVg01Sz+YT6T/FT7wkRzs/exj69220T/QStCaFKk9NiZ1RASaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PutBVRDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10613C433C7;
	Fri, 16 Feb 2024 20:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708113931;
	bh=R1LMfj9gVDiZNBYMZ6CkLziOlU3U2JW7BDD5n3g2mmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PutBVRDOJ0AhYFHo/tpgEmoaztL2dbsaXO9xeFS6nboUFven0b56z+4VVIy72D27W
	 pxcQ8mjsG5GBxd3aZyiP9MU4tsc5cHXfkySzkfSj2Le5kqyiKKmuECptDjIXrIGabb
	 uk01MFwKov9w72IciH/KOe9rjek6cevhr7IlSvZUXHTm6jz6Y/Eg0XmS6osn9QhVSe
	 Sm754gmrZ2b87vx8lndsozX1aal1WnRiRJJb3YEHwxXVirSnykbryjpkAE0m5rX048
	 Hts8nPUmiHVuSytIuNT2yUIWMtWdslxU37UjE3d/YSUbYOwluCTJKrAtJCEIK2VsiT
	 qNC0X22156OPA==
Date: Fri, 16 Feb 2024 20:05:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yang Xiwen <forbidden405@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Message-ID: <20240216-pedometer-unselect-91abab6c5df0@spud>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
 <SEZPR06MB6959592677F8F2C79BC2FBB7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <428581c5-48e5-4b89-8925-9847bd69dc70@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QVgl+GZRyK1hmYfQ"
Content-Disposition: inline
In-Reply-To: <428581c5-48e5-4b89-8925-9847bd69dc70@lunn.ch>


--QVgl+GZRyK1hmYfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 02:01:08PM +0100, Andrew Lunn wrote:
> > For me, it's a bit lucky to find a (partially) working driver in mainli=
ne.
> > It'll take me even more time if no mainline driver is available. In fac=
t, i
> > wrote the driver for mainline u-boot from scratch and it has been merge=
d. So
> > it's good to have this binding accepted unmodified, or i'll have to mod=
ify
> > u-boot side driver code to keep them sync.
>=20
> Sorry, but that is not how it works. If during review we decided it
> needs to be modified, you will need to modify it.
>=20
> I would suggest you first mainstream bindings to the kernel, because
> it has active DT maintainers how really care about bindings. Then get
> is merged to u-boot.

Just to note, the U-Boot folk are currently working on a model where
they will be importing the kernel's dts files directly into their tree
along with the bindings. I think they're adding dtbs_check too.
Although that will be opt-in per board, it does point to an increased
desire for compliance there too, which is great.

--QVgl+GZRyK1hmYfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc/ABQAKCRB4tDGHoIJi
0j8sAQD2c05BpITziSacIWuej2svOsRp0VT3YMfHkPUUkr9i5gD5ATlE5UkCnX/D
+6TfB08s4psf/tfFB2ffKcgyUnI6Mgw=
=OTN/
-----END PGP SIGNATURE-----

--QVgl+GZRyK1hmYfQ--

