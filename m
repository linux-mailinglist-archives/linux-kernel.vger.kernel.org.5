Return-Path: <linux-kernel+bounces-74074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E1085CFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B5628456B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BDF39FC0;
	Wed, 21 Feb 2024 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YQRRiEU7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC239AF1;
	Wed, 21 Feb 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493417; cv=none; b=Y3d0ecVKFoYzCjO1JZIjbh9Ui1xNq6HspWgoLry3eXgCjNeuOQEAVxPMP+LS11lXXRvCjyKAS7JadzjC2Kp/19NoRrBIYntqJ4+RCqd2RFgoQz9Q1jbIpopOwbopIPVroRqMMpt0KdBApkHFNOkmEyHltRxYBax37tMIdTT7Hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493417; c=relaxed/simple;
	bh=TstZ7gaQL4APdokx0BRsi7KY401fTHJY/C9qmxVNOTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiN/3LQV+0RvnjTUlFvQ8hiH8VEikuQtedTx/DUvdYHwaQl6Lj/BOWBFLMdouH/rlp/PR1untttQ88PslZ7GjraQEsOy7KOoscbOhOFbODHDIBT0dWQQXXg5K5ihMOgza/XGtXi1Dk3fBKEZXMkR6l6L4jvoRBx9fgf32jTYjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YQRRiEU7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708493412;
	bh=UbR/3icVfa2qWzkdtDgQIqP2aGsp+IED1sx6TLj5ukQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQRRiEU7EdcvhiGdkXVJCAxnr2N2XMWwpqJbdYp3ZKQT0HZCQT7Cwyg2Q2We+5+2R
	 aRH1dzcfjkvc0VC5f98JTyQHeuFTkJiWXxV88FQZlftb2gbZQRCKZhWV/EriMHwTGL
	 p8EfuLLi6V8lfdRLEOpAQ28n+31MKMElU+niyrjKTpqL00aaso0ABDK9pmrVczSHyC
	 z7XVonLjGhtyTH3CTBHRhZStkJYtThvlZ+Qg7mbXXR1GAv3NJxcioigxGBJh01iivB
	 D+HNHMsr0ogIoIaAED6sQ4qFjZDC92ir7Knb3nusjEnU8jvgyPrbAcoVcDKtV+7UU4
	 sUMub4df/6OrQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TflGW4S5Kz4wc4;
	Wed, 21 Feb 2024 16:30:11 +1100 (AEDT)
Date: Wed, 21 Feb 2024 16:30:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
Message-ID: <20240221163010.5f81813a@canb.auug.org.au>
In-Reply-To: <20240221092826.748e70c4@canb.auug.org.au>
References: <20240221092826.748e70c4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rq22gDeMu4XxzAZPnY.wJux";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rq22gDeMu4XxzAZPnY.wJux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 21 Feb 2024 09:28:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the arm-soc-fixes tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (interr=
upt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt p=
rovider
> arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (interr=
upt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
> arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (inter=
rupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in in=
terrupt provider
> arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interrup=
t_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in inter=
rupt provider
> arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Faile=
d prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (interru=
pt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in inte=
rrupt provider
> arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (interru=
pt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in inte=
rrupt provider
> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
>=20
> Introduced/exposed by commit
>=20
>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
>=20
> I guess you missed some :-(

Also these from the arm64 defconfig build:

arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrupt_=
provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells' i=
n interrupt provider
arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: Warning (interru=
pt_map): Failed prerequisite 'interrupt_provider'
arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrupt_=
provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells' i=
n interrupt provider
arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dtb: Warning (interru=
pt_map): Failed prerequisite 'interrupt_provider'

--=20
Cheers,
Stephen Rothwell

--Sig_/rq22gDeMu4XxzAZPnY.wJux
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVimIACgkQAVBC80lX
0GwTxAf+Mn967p1+Zv8P/ni3TvTIy2wD89SdrJFpGzqCzmdpENiXwYGvIhcmudwb
7QRTjPUVBxge6ZtSRtA3u/NcrO99TlmXkR2S0a73k1q8ZbhTAlRzp1cOE0+xXUb3
IgYADZbmNdzVXfnwa4IFnUmVdVIb6yYAVqiMu2Q+UV9GGxC1iznIK3Vs442lDEXS
dC3+r2nNgztXYnvoPXd6Hhnzu74e24usEwd3SSu/SgAh4HabQm2Ol5d9uwl/He3J
ZWwR3WOAgge67TiFj1CBRvq/+vraRu6qj2S70CAJ1mvit9Yc5MhVqX0AM0TjqeiD
dWc7VXPvgEEwN2CfQWR2QgVLLFxOLw==
=deZB
-----END PGP SIGNATURE-----

--Sig_/rq22gDeMu4XxzAZPnY.wJux--

