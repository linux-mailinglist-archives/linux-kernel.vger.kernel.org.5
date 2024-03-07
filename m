Return-Path: <linux-kernel+bounces-96261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FE87596C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8931C23AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3613B78E;
	Thu,  7 Mar 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vf6KB1z/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699F1384B1;
	Thu,  7 Mar 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847264; cv=none; b=DEqWe3IEZSIbUhDhEhbbvT3RcL4fG0XRgzJC6ZRVnTJ7Qt/jpi5PT9Fk/ND+oWUKpngMT+exfv4mTc27nhaRabziD0Kjop+cHouPJgWVyN8GGzcTQjfkP5befEB3BUNR/xYHyBBIbnJPWqB7NyHNTpFZBHcc5NT/+0fMDsGEhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847264; c=relaxed/simple;
	bh=G4TbYJzHdoA4FFKJcbEIABoH7r4QSFhmR72wWJlK8NM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FND14X6iXlfMPB4nIA9xH/vTd1Wv0MlVWv/hE1QaWfSAznZza9FTanmp2qCn9YbWav5wc58PCn3uHYxVl42yZ1ynMAOdILnp4VDCMVl3dBNPNP3NEbtzpMihZS2IbvrAIJFigAwUJQ6qdKcy5Ne7OKD6nuvc/HIwxTQCVJQ3EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Vf6KB1z/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709847257;
	bh=ZzvYtmA6HCNmtmHgXfPGQe5t4Xj6tZU566OGx8MrIsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vf6KB1z/DLDLOuXFblZL6l/EhpsiMf6xA/b1ahXgs9dBBsGBKPXBoyWIla94Q56pL
	 UlI1acQjqCd1wvZaxPjRK2v80DQYOXCwONDxUvbJetZ1OkyeWHhq/xNHmCScZeQHd+
	 Rkkt0QVwX9ED1BaimZV/+s//gnyzcWYldTWJ4mYwCY4KdiWDbYnRyfLzDiH6tHGH1a
	 wop1LI+dhoE8P7lwRlGY9Q11L793OWcSzWyqjbzgWr0mN/7W777ApDeXLO9y5vHSEC
	 AeACjI6AoI9tvk+kvcp42br8dxbZhJ2svisDG0VQKV0oZjF0JjfWtMwsAdKxi9Dq5r
	 NnRFZKGBciFCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrMy058fjz4wbh;
	Fri,  8 Mar 2024 08:34:15 +1100 (AEDT)
Date: Fri, 8 Mar 2024 08:34:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro
 <viro@zeniv.linux.org.uk>, Alessio Balsini <balsini@android.com>, Amir
 Goldstein <amir73il@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: linux-next: manual merge of the fuse tree with Linus' tree
Message-ID: <20240308083415.640fe691@canb.auug.org.au>
In-Reply-To: <CAJfpegstDJ6p42itTiL33tMTcbV8tUiMowpk8y9A-52_Oasvnw@mail.gmail.com>
References: <20240306103438.2c0a6f44@canb.auug.org.au>
	<CAJfpegstDJ6p42itTiL33tMTcbV8tUiMowpk8y9A-52_Oasvnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g9_.HsaUmrHgDCo/2OydX1z";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/g9_.HsaUmrHgDCo/2OydX1z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Thu, 7 Mar 2024 15:16:00 +0100 Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 6 Mar 2024 at 00:34, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> > diff --cc fs/fuse/inode.c
> > index 516ea2979a90,02869edf72f3..000000000000
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@@ -930,14 -942,6 +942,16 @@@ void fuse_conn_init(struct fuse_conn *f
> >   }
> >   EXPORT_SYMBOL_GPL(fuse_conn_init);
> >
> >  +static void delayed_release(struct rcu_head *p)
> >  +{
> >  +      struct fuse_conn *fc =3D container_of(p, struct fuse_conn, rcu);
> >  +
> >  +      put_user_ns(fc->user_ns);
> > ++      if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > ++              fuse_backing_files_free(fc);
> >  +      fc->release(fc);
> >  +}
> >  + =20
>=20
> fuse_backing_files_free() doesn't need to be called after an RCU
> delay, so it should be resolved like this:
>=20
> diff --cc fs/fuse/inode.c
> index 516ea2979a90,02869edf72f3..000000000000
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@@ -954,7 -959,9 +966,9 @@@ void fuse_conn_put(struct fuse_conn *fc
>                         WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                         kfree(bucket);
>                 }
> +               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +                       fuse_backing_files_free(fc);
>  -              fc->release(fc);
>  +              call_rcu(&fc->rcu, delayed_release);
>         }
>   }
>   EXPORT_SYMBOL_GPL(fuse_conn_put);

Thanks, I will do that from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/g9_.HsaUmrHgDCo/2OydX1z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqMtcACgkQAVBC80lX
0GzA6gf/Vxq+7Mzj99etumHtukJua/4uk1o9kUr2YEea32sDW5UOT8gB2aFx8haf
b9GWfrfsPckpMaJbuM3BXO0NLE1ND0fYpDi2VEKxNTjxn13qQ6WNzDG4s25LnC75
h9pRCeuo9npau3B7Inw5TqdZxob5f1AKoFLBoP0eHjvXKjtdL0aSNCKp6UU2OG6Z
OWIdrc2Vk88bMnw+aqddZlUByVna+8VmxQXRXm8gF3it8twQepUgMR50+yemW9wv
l0JB98oXps//bGX8dKXc07PiusRFFNFbVQLCoxvOKb0yj0JDzFw/RqwKRqQsPZVQ
3CbvyoGUZk1rlgFb/fo1Zd9PvQBCMw==
=w0Ie
-----END PGP SIGNATURE-----

--Sig_/g9_.HsaUmrHgDCo/2OydX1z--

