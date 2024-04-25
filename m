Return-Path: <linux-kernel+bounces-157912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB3E8B1881
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42121F21C23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39C101D4;
	Thu, 25 Apr 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nuvXSNgk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C06AB9;
	Thu, 25 Apr 2024 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009088; cv=none; b=s49m7LvXu97713Y9rDtI8MXK83QYzGpPz88KImNOF/NFTuoxEwzexpnOq57nRW4yPNOsPyv5nrDOOBOcKiKjwoRczjfq9yOmSK3nr9PtPnFD6lOo89prbaxekvlMxxKAXg94J74Owmem4N0y9RCWBLbHcIppHnB0etO/6/symYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009088; c=relaxed/simple;
	bh=MHYtD2sJF03wVR4nXqNZeRFZerkUYEAHw6+Qh6vgp4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+tNm5chUTeSlUUe+T8M4uZSkx/q2WV0O4PPvb5A9+Anx0RufBGS9844ZVmbslVadAeZVPOuGBSO66KcJFLj22vt0KDdH0/P5Np7hruBEuI45ulfZwToOpWEENFb1GSHS9epItfZZfl8O+CvmNselCEQlsD+fDfGEaSDZ9mCgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nuvXSNgk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714009076;
	bh=exPTEHMjq67gxZNOUyo+Wsbjpf6DCOvMm91+5rcTAyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuvXSNgkClLxOAT10XD7rZw48OdFhjr747FywNzrIIYcdSKXyBQIOlTeECJjus8qb
	 QlCdtYOYUXGit8F/sLTNfkZ6KMqB/UXAIRzKRLHNYGF/1nkRqF2ERLCn6xj+C04bP/
	 tRZ6MZ69xY+Z6O54VM/4NZm5umDDGy8Pl2Jhv39mJkcgxR0GDAf5+D2siMDkim0/B2
	 m9paWboFfoubUkxC/EyRrb72G1dcXSD/9ALxQMtqJsc+T3RXzJEJOPozkUSw0KPQSg
	 KT/ygIKl+s4zT8d5hgW8o5BF2qxGmQ1E1EhaOUzWRPYL2R5epHx0xtQEqT9h4ymX42
	 BI6pLU5RP9sTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPz503cGHz4wyp;
	Thu, 25 Apr 2024 11:37:56 +1000 (AEST)
Date: Thu, 25 Apr 2024 11:37:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: linux-next: manual merge of the modules tree with the mm tree
Message-ID: <20240425113755.250be7a3@canb.auug.org.au>
In-Reply-To: <CAJuCfpFT7tBigfSEO2iGKn5YtB0hFgVF-2Sfh+60nAO7drCeqg@mail.gmail.com>
References: <20240424123935.2f65e886@canb.auug.org.au>
	<20240424130757.531be2842c505a62246d180c@linux-foundation.org>
	<ZilrutXaEB0laSvr@kernel.org>
	<CAJuCfpFmZmw-CW17OWjmxzh5BdXsc7a_1HcdEL7kmLTZDpU5kw@mail.gmail.com>
	<CAJuCfpFT7tBigfSEO2iGKn5YtB0hFgVF-2Sfh+60nAO7drCeqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7PyCfeDXf3+o=7JLC8gWN/v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7PyCfeDXf3+o=7JLC8gWN/v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 24 Apr 2024 21:24:06 +0000 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> On Wed, Apr 24, 2024 at 8:33=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Wed, Apr 24, 2024 at 1:31=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote: =20
> > >
> > > On Wed, Apr 24, 2024 at 01:07:57PM -0700, Andrew Morton wrote: =20
> > > > On Wed, 24 Apr 2024 12:39:35 +1000 Stephen Rothwell <sfr@canb.auug.=
org.au> wrote:
> > > > =20
> > > > > Today's linux-next merge of the modules tree got a conflict in:
> > > > >
> > > > >   kernel/module/main.c
> > > > >
> > > > > between commits:
> > > > >
> > > > >   7f014cdda4cb ("lib: code tagging module support")
> > > > >   5ab9b0c7ea5c ("lib: prevent module unloading if memory is not f=
reed")
> > > > >
> > > > > from the mm-unstable branch of the mm tree and commits:
> > > > >
> > > > >   0746f9982603 ("module: make module_memory_{alloc,free} more sel=
f-contained")
> > > > >   18da532eefc8 ("mm/execmem, arch: convert remaining overrides of=
 module_alloc to execmem")
> > > > >
> > > > > from the modules tree.
> > > > >
> > > > > I fixed it up (I think, see below) and can carry the fix as
> > > > > necessary. This is now fixed as far as linux-next is concerned, b=
ut any
> > > > > non trivial conflicts should be mentioned to your upstream mainta=
iner
> > > > > when your tree is submitted for merging.  You may also want to co=
nsider
> > > > > cooperating with the maintainer of the conflicting tree to minimi=
se any
> > > > > particularly complex conflicts. =20
> > > >
> > > > That's a shame.  I don't see much that we can do to reduce the dama=
ge here. =20
> > >
> > > I can rebase it on mm-unstable and this can go via the mm tree. =20
> >
> > Conflict resolution looks fine to me. I'll run relevant tests on
> > linux-next within 2 hours. =20
>=20
> Tests are passing and module loading/unloading works fine on linux-next.

Unfortunately, due to a failure in my boot tests, the new (conficting)
part of the modules tree was not included in linux-next yesterday.

See https://lore.kernel.org/all/20240424183503.2a6ce847@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/7PyCfeDXf3+o=7JLC8gWN/v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYps/MACgkQAVBC80lX
0Gwjlgf+KCHOGHKaEjvfnP0CILSxh12Y66mDzqxlte021U/UdtJlx2byfxzDn/r3
QLRNcXU4pT4GBYRXiYf2J3UeHNoz4qTKRIhlCep4L6qW0guUDu6Gw1NroALXI1We
u8ZjUlH5jps86x+uxUZdCmIVwcGOt8L7a75HzaGphCxSUdS6SuC/lhEV6ETkYtyT
0jt8TF5h1Gyw3B5cm8PEA9EZBSgdm9oTGJDWIYwQwLmDFZhoeZJKpE1WqszjiUW/
Vfg5+HWCId44qpplNI4fwYeJ8LjgWsHBTuR4e5pSWUw2yGQ5mcSYmMWoWnivdu3s
YLnCiJf9/SvmBgOHgFl2FLXYS1dG9g==
=dGZj
-----END PGP SIGNATURE-----

--Sig_/7PyCfeDXf3+o=7JLC8gWN/v--

