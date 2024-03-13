Return-Path: <linux-kernel+bounces-102609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9E87B485
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C181F22969
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F95C90B;
	Wed, 13 Mar 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="inRtZpEe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFB5A0EB;
	Wed, 13 Mar 2024 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369873; cv=none; b=mykK3voT7RAhwmSNPO6h5fVh/e9PEORKTAUzfH5f0gpNLJUGLGFCWL4/XNREmAloU28bfGkaTcmXpTvtihvanJ6gtzS5CZiOx4UVo2eGt2uLbR2v32QMQmm732Hh9gYDvvcYpK8x2JuLvBEyuFQFAa7iFwc4i949OkQOC0bOeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369873; c=relaxed/simple;
	bh=9SfhzD7WzR3l4SJ6N4L0s4jyKZxID98y82s5AYHquQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU6wGAW/afN3xNw9e7Z6qC6mfl4gCQAtwBaYhSxIjZZcL0aB566TzGNJr8EcXv3XK/MJJJPAdXoglL/3LfrHJeswDXlNOCXqKHQo0lNoPf8GtHVDdOA/l7cafO0uiiFdnuF9d5QzzXrFAh+HyUD/PQuFMQAQRkvYh7dHmokTsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=inRtZpEe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710369868;
	bh=2skIhSkaZNIe/CehCvOoNGoYXeQoAEZI8KQCkyfRZ8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=inRtZpEeG8PkjSs2Ds3C6pXTnaOXBkd0dO463iJ7W7/967ecLyulRsNryrrk3HNmr
	 bvneQkfVnipNU3dCWOQZTftJiBEnemf9FbMY5DHD9+H3rRCI3VVvoaST3yffIdLoSg
	 x3j48fycS5XWyxU9ltprgBEhFzJz2ddwn0q/Jd0s0TaQwMHDWO73Ooz+4/ss4S3D0h
	 tgq62Z6Xpuu/zy9LjhpkLqxpeiRF75RZrrUex2SUIAcXf0P8OjCAe5gbI3b1bwoOb4
	 lRdjRYNJVf6X0nUyv0rTQaBts/hvDoaCfT+TtjJLwEzARJaZWMtKhCwfKf39RznguV
	 BUXgDTrzQB1jQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw5DD32sDz4wcg;
	Thu, 14 Mar 2024 09:44:28 +1100 (AEDT)
Date: Thu, 14 Mar 2024 09:44:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the kbuild tree
Message-ID: <20240314094426.0d2b3d79@canb.auug.org.au>
In-Reply-To: <20240226165811.56f71171@canb.auug.org.au>
References: <20240226165811.56f71171@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GO0ujt7O9IZQpeVC.JAPY4Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GO0ujt7O9IZQpeVC.JAPY4Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2024 16:58:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kspp tree got a conflict in:
>=20
>   scripts/Makefile.lib
>=20
> between commit:
>=20
>   bf48d9b756b9 ("kbuild: change tool coverage variables to take the path =
relative to $(obj)")
>=20
> from the kbuild tree and commits:
>=20
>   918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
>   557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
>=20
> from the kspp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc scripts/Makefile.lib
> index 298bd8c80d65,b4a248c20654..000000000000
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@@ -181,8 -175,11 +181,11 @@@ endi
>  =20
>   ifeq ($(CONFIG_UBSAN),y)
>   _c_flags +=3D $(if $(patsubst n%,, \
> - 		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SAN=
ITIZE_ALL)), \
>  -		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
> ++		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)y), \
>   		$(CFLAGS_UBSAN))
> + _c_flags +=3D $(if $(patsubst n%,, \
>  -		$(UBSAN_SIGNED_WRAP_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)=
$(UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
> ++		$(UBSAN_SIGNED_WRAP_$(target-stem).o)$(UBSAN_SANITIZE_$(target-stem).=
o)$(UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
> + 		$(CFLAGS_UBSAN_SIGNED_WRAP))
>   endif
>  =20
>   ifeq ($(CONFIG_KCOV),y)

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/GO0ujt7O9IZQpeVC.JAPY4Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXyLEoACgkQAVBC80lX
0GwE9Af+On16ur/pW+Et6PQXq0dcC2mug9g38fwHD6mStE3iOCW/L8hRwBzcekCK
jUCvpC7H3DJHW+elcUUDvG5hDLGP5YKH0lpIofQjbJpnr0gSQCRi8OmLckeaPJM5
j8Uu8R9HNcFtK9K3pwYhEBjdArk6R7sSEOQjA/HpkvmscYVquXrhCeq/qE5gfXYc
O7B+h7i1GXkCu7gBT6EWATxaW0S5EQMhBR2ET2mRyU1DwE6Q5gFydnMxFVVKEgHv
atnKzsuJFzJiEoWDAQ+gRo49DxC7qQ7uodHxyz8B7LBiWwNpjpw5mWLIM2RsCLoh
Bw8FJuxYEycUL1sFbhdA3d/IY5DhTg==
=893b
-----END PGP SIGNATURE-----

--Sig_/GO0ujt7O9IZQpeVC.JAPY4Z--

