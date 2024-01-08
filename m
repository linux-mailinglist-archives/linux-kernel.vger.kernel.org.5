Return-Path: <linux-kernel+bounces-20167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B851827AED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDA51F24000
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12A537E0;
	Mon,  8 Jan 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="usFMCTdi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA92904
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704754678;
	bh=Et58EhwEA0tDd3zujt9GnM9dv5dsfHb9ovqlvrRfljs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=usFMCTdiVgqzfZTfu+P2BBjNYwj3OuTta4njS8C0pP9LFoQSAg+xX6rgJcxyp2Yle
	 s/althnhCW++T7sAk5qG1YLbtTb9K4miFGNBQXmSFr1X4Q+BHVV3u6JFUS89O/yZ4w
	 OeinwccBtUXlFaDl2h4AdRbmyk4Eu96+24qR7RWDACRWR7Q5Ll+fT+acvgfbARGBBF
	 yS5MquaOttUx4MMO0Lf6ehveZL9LII0nVBbz+mWPbXBeommL1ULkxuN4NulCjEy5UW
	 GuKCqjhU67D1Wm0LrkP6E206SL++A0onxEMaWmEPzMFy+5TXO1FHmZIaAIprLvTQXh
	 JULkV24aFJr4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T88bp2xqYz4wbr;
	Tue,  9 Jan 2024 09:57:58 +1100 (AEDT)
Date: Tue, 9 Jan 2024 09:57:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: lucas.dimarchi@intel.com, ogabbay@kernel.org,
 thomas.hellstrom@linux.intel.com, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <20240109095757.1313b2d9@canb.auug.org.au>
In-Reply-To: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ADUhnR/f0fUP1Nsqi8QDnxE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ADUhnR/f0fUP1Nsqi8QDnxE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, 8 Jan 2024 13:33:36 -0800 "Paul E. McKenney" <paulmck@kernel.org> w=
rote:
>
> Recent -next trees get the following build error for allmodconfig builds:
>=20
> ------------------------------------------------------------------------
>=20
> drivers/gpu/drm/xe/xe_gt_pagefault.c: In function =E2=80=98xe_guc_pagefau=
lt_handler=E2=80=99:
> ./include/linux/fortify-string.h:57:33: error: writing 16 bytes into a re=
gion of =C2=A0size 0 [-Werror=3Dstringop-overflow=3D]
> =C2=A0=C2=A0=C2=A057 | #define __underlying_memcpy =C2=A0 =C2=A0 __builti=
n_memcpy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^
> ./include/linux/fortify-string.h:644:9: note: in expansion of macro =E2=
=80=98__underlying_memcpy=E2=80=99
> =C2=A0=C2=A0644 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 __underlying_##op(p, q, __f=
ortify_size); \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~=
~~~~~~
> ./include/linux/fortify-string.h:689:26: note: in expansion of macro =E2=
=80=98__fortify_memcpy_chk=E2=80=99
> =C2=A0=C2=A0689 | #define memcpy(p, q, s)=C2=A0 __fortify_memcpy_chk(p, q=
, s, \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro =
=E2=80=98memcpy=E2=80=99
> =C2=A0=C2=A0340 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~
> In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_vm_types.h:16,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_bo.h:13,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
> drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] i=
nto destination object =E2=80=98tile=E2=80=99 of size 8
> =C2=A0=C2=A0102 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xe_tile *tile;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|

Which architecture?  What compiler and version?  Anything special in your b=
uild
setup?  I do x86_64 allmodconfig builds all day with gcc v13.2 and I don't =
see
this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/ADUhnR/f0fUP1Nsqi8QDnxE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWcffUACgkQAVBC80lX
0GxIpQf8C+6WGqhvESkIIly6tjpCUu/1HJBcrCHnC+4k19bEzMzMINZ3E1cYSdnE
x6qj+3hXIFsiA8+0DYdJBriPX8b6CFm4I4+aS/2Ux72dMB+YlFQe98Bdm3eiCWAa
9w+T/aWevvwsFGgbhLf1whlsnEEx3KR/nZ7pwMyJpXie6NokWlSFUNt67K1odPwk
gskrA708EFZxGNveTpY73MHh5OVsoyazS5So5SP97cy/kemdasISkr7TVBGbfFju
3d8ww8F4YWfU6rAWSbejrkJCvbhJ2b2M0uzHF2ljdAeQUrc0cl7/iO0WzAzPwxgc
5vDoXAbboee5bLDZThu3ggTnV8j9DA==
=uG5V
-----END PGP SIGNATURE-----

--Sig_/ADUhnR/f0fUP1Nsqi8QDnxE--

