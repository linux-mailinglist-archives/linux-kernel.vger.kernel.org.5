Return-Path: <linux-kernel+bounces-147960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5A8A7BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4957C1C20F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD6F535A4;
	Wed, 17 Apr 2024 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iW2uUq5d"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CDBE4E;
	Wed, 17 Apr 2024 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331751; cv=none; b=Cc6RY/4X0yhmCXbclW0eY8mF+lvxIdH1Db2XVfpoiifuFKNKApcVXZYb5ey7G2OEgVYAtLi+Naid552483uq6GZmn86tTEwSZPBM8nspUXgBlJgdxQfoZXy9Hk8SkGvOKjrsQEnv1oJT9JA6/o6Y1JSUuj3pS23qPOHrsdRve7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331751; c=relaxed/simple;
	bh=OifDQbcJp4r7eu2NhLz6xbsvnaX8sjeCXCHE9D4QYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWITNkzGECYMoGc3T3igWmH1Ltp8elI7SvqbprvYbv14c/ui3ZUn7xMDjTMgezBY5AowhXkPEipG+/GyfEr+FFcNCA46yHSC+mN8k9C1MLY+HOvotxSmCizVpA+Kk67a4659y8/BtAyjbwsXv7ZUUQh9sPI2a/zUvgpgXdmUmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iW2uUq5d; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713331745;
	bh=6dBK1X7uEM27YFQC+XuCWbQVncPoTrMhJPJ3YMBYJfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iW2uUq5d5UlZEKVoAWjWEQIIZh/ofsfaEIBQErkB9zK72x/AkoovlpN8fM9dBEbe/
	 OZcmHrVIe2On6KegBWolfb/xD/l9p03jyVuUz6zdHLX41J40xJu8ioOu7Mc/jP0a17
	 BM1TQUWhhTLp99dvseQHYKb5DpEHhtpddl+gQFkNAbC/p9yQ5Mgfj57mTg4BowmChH
	 Oz6UhOOvxgo68iEKC3DlrE/RxWCs/Z3Itpd/zAjCoz8vKMBVcJ88gBsoyBtCOIDn3I
	 xbyJS9vuA4gjN4oCUHomPiI895LEPjJO9EghERbGzWejFZFRA63qTvhR40g/2dvy74
	 F7dYZHwA831iQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VK8bP0jc7z4wyl;
	Wed, 17 Apr 2024 15:29:05 +1000 (AEST)
Date: Wed, 17 Apr 2024 15:29:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qiang Zhang <qiang4.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
Message-ID: <20240417152904.17fa874d@canb.auug.org.au>
In-Reply-To: <20240416115114.8f1673a2490d31f77d276a41@linux-foundation.org>
References: <20240416173525.13bfd8dc@canb.auug.org.au>
	<20240416115114.8f1673a2490d31f77d276a41@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tTAEg7zNEKKM8vvCp.6NbDd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tTAEg7zNEKKM8vvCp.6NbDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 16 Apr 2024 11:51:14 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 16 Apr 2024 17:35:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > lib/bootconfig.c:911: warning: Function parameter or struct member 'ear=
ly' not described in '_xbc_exit'
> > lib/bootconfig.c:911: warning: expecting prototype for xbc_exit(). Prot=
otype was for _xbc_exit() instead
> >=20
> > Introduced by commit
> >=20
> >   aaeda6237dec ("bootconfig: use memblock_free_late to free xbc memory =
to buddy")
> >=20
> > from the mm-hotfixes-unstable branch of the mm-hotfixes tree. =20
>=20
> Thanks.  How's this?
>=20
> --- a/lib/bootconfig.c~bootconfig-use-memblock_free_late-to-free-xbc-memo=
ry-to-buddy-fix
> +++ a/lib/bootconfig.c
> @@ -901,7 +901,8 @@ static int __init xbc_parse_tree(void)
>  }
> =20
>  /**
> - * xbc_exit() - Clean up all parsed bootconfig
> + * _xbc_exit() - Clean up all parsed bootconfig
> + * @early: in early xbc init error
>   *
>   * This clears all data structures of parsed bootconfig on memory.
>   * If you need to reuse xbc_init() with new boot config, you can
> _
>=20

OK, so the above two warnings went away, but now I get

lib/bootconfig.c:909: warning: expecting prototype for _xbc_exit(). Prototy=
pe was for xbc_exit() instead

Commit

  aaeda6237dec ("bootconfig: use memblock_free_late to free xbc memory to b=
uddy")

that was in the mm tree yesterday is not there now.

--=20
Cheers,
Stephen Rothwell

--Sig_/tTAEg7zNEKKM8vvCp.6NbDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYfXiAACgkQAVBC80lX
0Gw3JAf+OYUqk9c7q5BDXIF7RJzhtNgvb18mkgz2wmNDeMbwdeVHj2uSXYo7wPbm
YSUDtk84ga559qAflvVcs0vudOin1KG3Vkv31p6/N+aXBpkvDFij1xZ/uNCtcKRH
uTbnv/4G5O+BVRNXg0ysINesKRq8ISt9726gzLPghpVytWPP5P1MsXzc8x5YNT3w
J/u9Z068F02z6K1b38ehtDvwov2oFl1Fx0bF4v0MHb5LnF134cS59QsSS/zS21HZ
DZkdYRsKjdDezlxlC6TpnHmSKjM5T5OjWKUwpoUx9welbmwmIswqDAG2PVArHHHg
HUTwqs1pcAMcs9s3jstpc/T2zVCSOw==
=aTkw
-----END PGP SIGNATURE-----

--Sig_/tTAEg7zNEKKM8vvCp.6NbDd--

