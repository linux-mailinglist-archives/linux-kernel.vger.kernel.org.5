Return-Path: <linux-kernel+bounces-100912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB1879F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54901F228A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146846B80;
	Tue, 12 Mar 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UuhkqJ3f"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CB14293;
	Tue, 12 Mar 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285323; cv=none; b=m+rneIgzULj6cA3UvGGf0SghHBK8FhHPUQzRFi05EKmwDn+9znEbdHmNqcJPwCjEBlS03bsJcTPyygCfkjEBLmysMHtkwmUX2QVD3Mfkz+KhFvE7bJLS+DlIN+EBghIBCQ5uhrpQThueqaUfkeszG/mBuN3qf2UP0D8/rcSVNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285323; c=relaxed/simple;
	bh=YMumfy62LMbpDVBMh+X3bB7Gji5ZfK1CU4I9f8SM+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbfPeq8OUOYaRTfZTAIhXgWjWTI2gd+AGQ2G0I76Rf03E22r7qOqwhwW9bW9Mf723ckqoryZlQvio4CFCW2J17GvTVpPTuNToN7E+Xeqm+Yv9qtpFrT6r98yTCSEYAc5mnaIOeYGqONc5XTW9e2/qLIllL4xthdwQjmFcG178M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UuhkqJ3f; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710285318;
	bh=B+4KN1xkYdkrc/Uo268JWRZW4K2hj/u546GnWtrEepc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuhkqJ3fnxWE6E7hcXRo2tfacrwA6vMFJjE3JZ/fRomCOHnqa5QxokDkdPMcYn4rh
	 MNuin9bdqc+LBCu3H9f0JvHDPt1pezt6NjXVQSbScPwdSiBepmFF7CW7EMafQlI6o9
	 vvklIWxspA33h0RBS4S9BoOZ3tlgSI3Kjn24jLTaoEFEwZ6DJLzP8gNAnu+W16OXJ5
	 m3SdA09n6CIHsBuSdYo45nRSdwBCJ2fP9yPe/0sJ89hAK+I0tujyBr0/6KDR22Dmk/
	 nHPB+lnXzcJ8QjAI2T66pVIQEU6Tjqz1fpVXKOg/c3/TxCZ8z8rbz8rOOBmJ7HbqIz
	 uHRgb6W8jHchg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvTyF3fSVz4wqN;
	Wed, 13 Mar 2024 10:15:17 +1100 (AEDT)
Date: Wed, 13 Mar 2024 10:15:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: linux-next: manual merge of the edac tree with the jc_docs tree
Message-ID: <20240313101516.25300dcf@canb.auug.org.au>
In-Reply-To: <20240222142041.34342553@canb.auug.org.au>
References: <20240222142041.34342553@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R85v+ca_wCej8xuWD0EzUH0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R85v+ca_wCej8xuWD0EzUH0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 22 Feb 2024 14:20:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the edac tree got a conflict in:
>=20
>   Documentation/index.rst
>=20
> between commit:
>=20
>   9ee367809c67 ("docs: Include simplified link titles in main index")
>=20
> from the jc_docs tree and commits:
>=20
>   1289c431641f ("Documentation: RAS: Add index and address translation se=
ction")
>   0e4fd816b08e ("Documentation: Move RAS section to admin-guide")
>=20
> from the edac tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc Documentation/index.rst
> index 429a407470c8,9dfdc826618c..000000000000
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@@ -112,8 -112,7 +112,7 @@@ to ReStructured Text format, or are sim
>   .. toctree::
>      :maxdepth: 1
>  =20
>  -   staging/index
>  +   Unsorted documentation <staging/index>
> -    RAS/ras
>  =20
>  =20
>   Translations

This is now a conflict between the jc_docs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/R85v+ca_wCej8xuWD0EzUH0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXw4gQACgkQAVBC80lX
0Gz7nAf9FufwkHzfM+WC64ASx0Ul6vPlouOO+49atpEvLejLnmGSXEJcEuqc6tld
DlRwZsB257UAaO7gfHqQfmwwOMeXZ8rKOVolW2ffjTSxJcMr1SZl4zSrgujzSSKM
1I8BmfMVhCFEGWQCsOn5PFJSFM2Sv4xhkyxB3EuhXrgOEYlA301Oyv26a7rZHTXQ
G3qq59mWLpi5B9LBa8xNaNq2+it/r8B/qrydbOOxCU/Q1YBNK4gEZh7EKDCJpYzM
o0fb/N7333eIGR561qO1dQsE9tQrI0jLlXBXTo+2diZNJnWXSpx7mvmZVW3QEoCx
QX6lztTmO3N2q/RbYU0lsNnAfVyl/g==
=38Lq
-----END PGP SIGNATURE-----

--Sig_/R85v+ca_wCej8xuWD0EzUH0--

