Return-Path: <linux-kernel+bounces-70695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE585859B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABBE1C21942
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B2AD23;
	Mon, 19 Feb 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hpOBXJwe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9A79D1;
	Mon, 19 Feb 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315596; cv=none; b=h1jPbDvpg9YCjkM3KWR1vR3G+XW/EAawE2iURuHsPLKw5Q3hGHuimkfRF/cYqvh8CfDH3VO80b+YgovVULIeEPEh9AP/sptTgZhxAmGjSYy+iyJowmVVSfbgQgba358De+2CdRojeE4d1UlYX8V4URD70ERkN5T3UNQgzVcFuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315596; c=relaxed/simple;
	bh=f8bk4l8XQZbJxFiR5khf60WRY6aCEbpFe4ogWBXfFWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZd4QbnLR4Rl9VqF+i8i1RnDjo/buw++nZWJAxhv5ERpgje6F+8z8i6ob0aD6JtxkOjrseiW/7518E3wt+wVkB5RauNJVQ5v/oGPz4HV4jdCZsvSlR7psRbUgLO/w30k4OsXGTvhPBhKO40RDKOWkNAlz0wmIB8Fqo6iNXPpSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hpOBXJwe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708315591;
	bh=/S1Eja2o3kqWVFRHqnQWvKVOhVbhP6ACipGm2aPnAnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpOBXJweQ+fG/OU6TFGZCxTWpnEA2yx4TfCGkpVl7ueBRgfPzFDgSuOB+pu8D/vre
	 2TmjjDmoJ36AKZGopI128HjI22qVdkLWME1ZUGlkWhBqNBfkAkxb0p6yTOMNU+oHFT
	 uMh8gQmvc3UI81IajcD47B2TcgqAV0WzP1F8xcqgwglqXVIiDGyavSw0o1ei+5bKcT
	 OvwuuDTwJRIkZHVU7SE2NW3Mg7tALL5tDEzF3AfCw/V5x8VwPAY5PeCRZ9exjPidTq
	 vNuXtPMwlnUNFg5VUuny2FgUrm3RlT6JZ/TwWu1kAMaMl0PKyPFhbBPgGDbdohAXgw
	 MVy+wHh7QZM0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdTVv14j9z4wcM;
	Mon, 19 Feb 2024 15:06:31 +1100 (AEDT)
Date: Mon, 19 Feb 2024 15:06:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul
 <vkoul@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <20240219150629.7d45ae60@canb.auug.org.au>
In-Reply-To: <20240219144423.16a76202@canb.auug.org.au>
References: <20240219144423.16a76202@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CDQpwSQ_AR+KHuUVK//8QZn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CDQpwSQ_AR+KHuUVK//8QZn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 19 Feb 2024 14:44:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the phy-next tree got a conflict in:
>=20
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>=20
> between commit:
>=20
>   d4c08d8b23b2 ("phy: qcom-qmp-usb: fix v3 offsets data")
>=20
> from the phy tree and commit:
>=20
>   52cfdc9c6c33 ("phy: qcom: qmp-usb: drop dual-lane handling")
>=20
> from the phy-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually the below ...
--=20
Cheers,
Stephen Rothwell

diff --cc drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 5c003988c35d,6b6994cb77d7..85253936fac3
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@@ -1621,27 -1328,7 +1336,23 @@@ static const struct qmp_usb_offsets qmp
  	.rx		=3D 0x1000,
  };
 =20
 +static const struct qmp_phy_cfg ipq6018_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
 +	.offsets		=3D &qmp_usb_offsets_v3,
 +
 +	.serdes_tbl		=3D ipq9574_usb3_serdes_tbl,
 +	.serdes_tbl_num		=3D ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
 +	.tx_tbl			=3D msm8996_usb3_tx_tbl,
 +	.tx_tbl_num		=3D ARRAY_SIZE(msm8996_usb3_tx_tbl),
 +	.rx_tbl			=3D ipq8074_usb3_rx_tbl,
 +	.rx_tbl_num		=3D ARRAY_SIZE(ipq8074_usb3_rx_tbl),
 +	.pcs_tbl		=3D ipq8074_usb3_pcs_tbl,
 +	.pcs_tbl_num		=3D ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
 +	.vreg_list		=3D qmp_phy_vreg_l,
 +	.num_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
 +	.regs			=3D qmp_v3_usb3phy_regs_layout,
 +};
 +
  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
  	.offsets		=3D &qmp_usb_offsets_v3,
 =20
  	.serdes_tbl		=3D ipq8074_usb3_serdes_tbl,
@@@ -1676,9 -1361,7 +1385,7 @@@ static const struct qmp_phy_cfg ipq9574
  };
 =20
  static const struct qmp_phy_cfg msm8996_usb3phy_cfg =3D {
- 	.lanes			=3D 1,
-=20
 -	.offsets		=3D &qmp_usb_offsets_v3,
 +	.offsets		=3D &qmp_usb_offsets_v3_msm8996,
 =20
  	.serdes_tbl		=3D msm8996_usb3_serdes_tbl,
  	.serdes_tbl_num		=3D ARRAY_SIZE(msm8996_usb3_serdes_tbl),

--Sig_/CDQpwSQ_AR+KHuUVK//8QZn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXS08UACgkQAVBC80lX
0GzHCwf/dJgek783+V4ehDgFSe7Ufdlf8AKHoDJlsZwyk3jJwFCBW3dIoehJX8cz
h8GMZgAc+NGYkFY7mw8p/QWdcVe874bBSQItXVfJUVGzamWR71U9SpscIZO7LWw1
HMxOzM5dl3QtRgafBz24BZPoPHu6plKozC9igIFuAvkkwMudBfj44bkkwgjAq1aN
sN6zoEntgbaPZbS/gaH+XxcGG/laZuwppmXhHhVCATh5BXnXITcu4sJiBchttgAS
wnbe22BAJQkNDtud9pSal5wRjEJHidA4U3ub5Lr1DAUdCQ9Cjdtky1QeiMP1+PSI
QbXMRL5q06mSx5yyltXthUWhCtnPtg==
=cEJj
-----END PGP SIGNATURE-----

--Sig_/CDQpwSQ_AR+KHuUVK//8QZn--

