Return-Path: <linux-kernel+bounces-28377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF382FDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8966EB24F14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A341D555;
	Tue, 16 Jan 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PF05/ej8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269211CD0F;
	Tue, 16 Jan 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448160; cv=none; b=ITtQ1lf9rzicjmhjcUZYT2aDzXpRFFgBBiWpQGPy2vu7fhr6t+QJKsbIgus4/fhi50ivb/RTBpsAY3nOG9XXDv1a7CEZKLyiSKvI1jdZ0Mk2G4fciCEkU16bWSsKGyIyx1bCaeE2DP+st4lIjsKeCoxyuXhmg6prutJETFob4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448160; c=relaxed/simple;
	bh=odl2Y9Kivf8+W0FpEJhEXzn+jbTtzX0v6NW8SwFabUM=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type; b=RzRsCeV0Nzc0RHtu6J19yQhcgFWnFGwMnkC2NrSshaQppdZuzGMIpc2siDQb7d2Zjo/FEOI1j6e3YHkus3Z8fiAvFM1+AWpHWnhwiJLXivsbASfsS3G3BYP91OkKZFkXx+jhXmvfbEKbsrxfCdaFCLiqzrbglDfoisbmuQ1hAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=PF05/ej8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705448153;
	bh=UBD3Mzd0bAfPfkeBET4buY5BWvFVqwQWr712c4DLxHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PF05/ej8oUoUgON8PX/6BpRQm0oljRc/ofAVltRGEOuXmO9Fs/ousb4QDcQzOioni
	 OauwXiq9U4qeEplzx36/jBJlfiE3ZmOk7x6vHickKhUYFnBbKyP8dMy+rztIthry71
	 4kLt+XVXR1XFb3TJlypF67VVJCeJzQwGpxPgyrMLsGp8S9Nvs+wqsqgw3MdvckvUri
	 dlNFbrUnojekleoscupnSVYUk4qHQgKwWFMgobD32Mg0ctyc1Lg94OZK8DdopnHhQ9
	 /cBCXctfvcXCUjDNHPJ+vpoDMkCCgO8jKzXP3HzUul/qGj2i0LV1if7NF6rGNmfGlu
	 V3obXCWi6YVUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TF53r0SFTz4wcJ;
	Wed, 17 Jan 2024 10:35:51 +1100 (AEDT)
Date: Wed, 17 Jan 2024 10:35:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Helge Deller <deller@gmx.de>, Heiner Kallweit <hkallweit1@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the fbdev tree with the i2c tree
Message-ID: <20240117103550.05ccef37@canb.auug.org.au>
In-Reply-To: <20240109113914.6178e733@canb.auug.org.au>
References: <20240109113914.6178e733@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fRlDahp=ZCP3F83WHkgmat4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fRlDahp=ZCP3F83WHkgmat4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Jan 2024 11:39:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Today's linux-next merge of the fbdev tree got a conflict in:
>=20
>   drivers/video/fbdev/intelfb/intelfb_i2c.c
>=20
> between commit:
>=20
>   ef2984d633ce ("fbdev: remove I2C_CLASS_DDC support")
>=20
> from the i2c tree and commit:
>=20
>   256b7e8673a6 ("fbdev/intelfb: Remove driver")

This is now commit

  689237ab37c5 ("fbdev/intelfb: Remove driver")

in Linus' tree.

> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the i2c tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fRlDahp=ZCP3F83WHkgmat4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnEtYACgkQAVBC80lX
0GyudQf/Z/mpbXa+b+XsD23H9VsHyrj/k4L4keARN1c9rhDccUK9kZIrx88W7Ys1
ps+3LTRhdBnurUO6SZAXbAcQP/uEHMrRSlapbjStMfdvTdbohzLZ0SiW9UtaFSHL
4TOeESCIoQ86EPmaDoFQtxqTp5eegjji7rp3YvvSoJxS8fI5YqgJk4p24mmbzmk/
bAXVtIyeu/SnOmntfiBa6CNEkLfYn1zYQj+HLTxRiVJEq84GOqI+slrZTrOnJMqj
JrMA/8b067WxCL7E4y/TjUpHBteh/J3wo9NdIxTHekyajyabzXAo2+Ru2AiTk3Z6
hFr+tdtvDNAw59KChMORq78GSU66bg==
=Es1E
-----END PGP SIGNATURE-----

--Sig_/fRlDahp=ZCP3F83WHkgmat4--

