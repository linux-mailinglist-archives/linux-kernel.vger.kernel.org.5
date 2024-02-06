Return-Path: <linux-kernel+bounces-54137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D984AB60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DEB1F2589D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF415D1;
	Tue,  6 Feb 2024 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D45K9hca"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26310E4;
	Tue,  6 Feb 2024 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181609; cv=none; b=SxBSmwNYv6DwRBefo8ebRzm01AfKTeirnrqy21IA0zcAZp5y9GChrirhwMoAr+sl+9xMFglP5AeVc5XPr4TlRtoULfKmRkvsDjIFY5rkLj3kq14fh+uB+2aTj5WTlwRjujetZg/e8GfUOodcT+FJAK2DKHccJw8whiypI9Apuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181609; c=relaxed/simple;
	bh=8brotDgIv/mOm2mHmMZq1YeN7q4v6JJ4y6F71FYbX64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrdiQXnHib/4XmseP+fOhNvy5hLy38dyQNKu8klsX3Imc5w/LUcefRho/GIRW21M4JV8lUwcFy/t/1F96XoaNjA13IaqmtV4muoPOs5gHWDRWO7b40dCTxeR86/5ENTdVP72p6mIFmcqbxkM7um/FNEDf0SDoVk6DiYRla6xz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=D45K9hca; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707181605;
	bh=2vDOcQqrXnD/DT/s1m9g+ZZ/YWdvacfHhw9HRCRbVXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D45K9hcao5cQV0oSsPK8wHRiIIN1VEH1Vy6r1G22jOBIiFG8j14AeQLoRPnaMagYc
	 0SMrxahnPfIBmZXMjGv5ywu33YKjAFAiKSaz5heHi0cn6uO3W4aLBdjcKyqVPkAXdF
	 2iWOpDu+Go+rGX7CnsIQwlFaiuG8A7Sw9pTqjaTZE9cOsU4vBhrfzaPtdmD/iL06K+
	 z0+oHHjdOgLhov4jO1GQnuvhToeM4hNYs1+ANrJ5WaM31cJnzVCsSeMgDYkhjraP6w
	 ve7vBAgjS9lhNPpAAUYvWDCHzmcu7lO15cwvAQECUVK5mWwAziIt+jaII+LUnKOxpk
	 QNI4XQxnIsXpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTQ7S3np1z4wxx;
	Tue,  6 Feb 2024 12:06:44 +1100 (AEDT)
Date: Tue, 6 Feb 2024 12:06:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Inki Dae
 <inki.dae@samsung.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>, Robert
 Foss <rfoss@kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20240206120643.1d30764c@canb.auug.org.au>
In-Reply-To: <20240206115956.4570e9b1@canb.auug.org.au>
References: <20240206115956.4570e9b1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R5MrDFgjJgkcfwl1oGYogXX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R5MrDFgjJgkcfwl1oGYogXX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Feb 2024 11:59:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   drivers/gpu/drm/bridge/samsung-dsim.c
>=20
> between commit:
>=20
>   ff3d5d04db07 ("drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE")
>=20
> from Linus' tree and commit:
>=20
>   b2fe2292624a ("drm: bridge: samsung-dsim: enter display mode in the ena=
ble() callback")
>=20
> from the drm-misc tree.
>=20
> I fixed it up (see below, please check) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I changed my mind and just used the latter version of this file.
--=20
Cheers,
Stephen Rothwell

--Sig_/R5MrDFgjJgkcfwl1oGYogXX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBhiMACgkQAVBC80lX
0GxeKAgAkwQiFzWc9h4CfzDkViFqu8H/3j8jQCOL2MrI0BRFd//8tfIgFyEx7a3Y
NM6ij5nZP/7LrEELmOe7J/L8xBjhJel34x+aoKXlRFVtgUpauNQLYf8f4vL7CE1F
hP09q3GOWEMo9q+FyhmlZBBE7NDYFXtSPYm2pedIKe0VxrJtnMREtnn4nZ+vsaQn
wxdaWppYiN7eSLHc8dKE85tjr3sn6ILBDMLoRWgDX9EENec2Tnhc+HD7+cmt/OhF
yUiyenHVxTZwjeyUd0SPgT0jZHtklj5tRvO2/kT2xp3NC7yAgptFunRdtVBGbMoz
tSZeRFmfZOsf1V45x4vkJrSD+fgeCg==
=L2LP
-----END PGP SIGNATURE-----

--Sig_/R5MrDFgjJgkcfwl1oGYogXX--

