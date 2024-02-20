Return-Path: <linux-kernel+bounces-73762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1385CABE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7C3B22C92
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867321534F4;
	Tue, 20 Feb 2024 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a8lFVhJV"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD914F9DA;
	Tue, 20 Feb 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468112; cv=none; b=U2Tc7z5tub0fizE0MT/E+mImFIKDe0eRbF2fMkUomz9pYoIUTEtMXUUBqWc0sMYr5Pwz+Xe06uB5fP9WIK2COj5qwC/l+zrG4zVY76XQKI1BEPpnKozE6/tFW4NhaupbkVih1dRSM1fC/0/+X3waC424e/Qv67n18t6+H5Jj8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468112; c=relaxed/simple;
	bh=7NXLSYnf/Lrs4LQuACzLW7h7m5aWGwqaD3rFH4DuEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ULTTvxrKWh/aQECzZppr/89dvTQNxIZsys8BArbjOFTkb6p3nY/H1x1BwNdgcnP4V6Kk3erpQ7gIzDF3gTEJUisA6kXGT1Tu3By8Fo5bkaf2ufIsewCTm5HlLdwveEEbFCJalcsOjIAuz1HUwQqK05kIUQc2I7+TwiyyvDXq4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=a8lFVhJV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708468108;
	bh=JxU2cRIh+tOf0myC2dVoeQWdEzdziZB69qhTugFyKcE=;
	h=Date:From:To:Cc:Subject:From;
	b=a8lFVhJVR5qvBQ5GWlVqEYx/JWFzZ0UlLy74AxNqhpnKJTrQwcHuZkSBYYU0mPshw
	 3DjMwxC0AdDlefOsCAjydCUvfNoGFRLwfRFv+2hU/863cOsj0DcT1V2OAEgIqKUvND
	 Zktqt05FZHC8BRWKicgkqPB+nsCKEj/i9FsAcYTkSesm+YPj7oXOCqjDxC0RhRsYrv
	 bajo6N9PxHsXmr7rxd139rbjxIKFcBv4qDEyBMONCdiq3TtVFMs0TGKh1ozsGZmbJH
	 vEQ6ysLQMnqtuqfkA9FsFJFFhkP7d0FbLf5ulBwYse7zd2VguloupiVf0nvt7bLZZC
	 /QrGfC1IVD4CA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfYvv62rvz4wcF;
	Wed, 21 Feb 2024 09:28:27 +1100 (AEDT)
Date: Wed, 21 Feb 2024 09:28:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-soc-fixes tree
Message-ID: <20240221092826.748e70c4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4y4KvpRoxVhs=/kn1m=DpGF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4y4KvpRoxVhs=/kn1m=DpGF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc-fixes tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (interrup=
t_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt pro=
vider
arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): Faile=
d prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (interr=
upt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (interrup=
t_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in inter=
rupt provider
arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): Faile=
d prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (interr=
upt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (interru=
pt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in inte=
rrupt provider
arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interrupt_=
provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in interru=
pt provider
arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Failed =
prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (interrupt=
_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in interr=
upt provider
arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Failed=
 prerequisite 'interrupt_provider'
arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (interrupt=
_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in interr=
upt provider
arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Failed=
 prerequisite 'interrupt_provider'

Introduced/exposed by commit

  78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")

I guess you missed some :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/4y4KvpRoxVhs=/kn1m=DpGF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVJ4oACgkQAVBC80lX
0Gxukgf/Qpzj0x0uECtr5ytBixlrC7o1m0w8RBDsEXaMGym8e5pODZ/a7lhN6NRI
YbtGW+o1JIiYZdb41b1kwspv3kS2Ssf0As2M2GcFoOsQFQ9JpjbFP5RFPL2hfqCc
xNj5WexAhtGvc8rotdaj7PJfzaBVPsS1jtjwZ8dWrHt689kACvqLslCG0nku9NAW
RfOxLZk5SoilZqbQjKdFPyqEfSbQAbGQrpwrFiZh64xzyUraEwKO9xpHmvv+NtU1
U36HMKftlvjRqxVbSapsnWNkBoGmRlP4b+kRKUtAzC4EVFHysn3y6c2gxsaODrHH
yWDMWPtMriLzYxX5W7eAGmgA78RnbA==
=ou5Y
-----END PGP SIGNATURE-----

--Sig_/4y4KvpRoxVhs=/kn1m=DpGF--

