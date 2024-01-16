Return-Path: <linux-kernel+bounces-28269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383182FC52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C081F28D72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86165250FE;
	Tue, 16 Jan 2024 20:46:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DD250EF;
	Tue, 16 Jan 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438018; cv=none; b=CUX3Q6FyLvVSeu3kbUssuClqT35xLmx8dikidHdtpHCex5eveFlcMkEkkcwgv7FW0S/cfJfhdfXbPZD2JTIV/yA1va/qoSio2rTWUa+hEjjOPgNs7ajWCKXyZZ7xmGVyVH/cFb4kMESQXNc3gAuQ0OjF3BGmGiuU3+Rwy6Az11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438018; c=relaxed/simple;
	bh=ospxE6Ywnr4fHa2us3RDJ0glfrJaABYoOmOTOUL9jbM=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=QzFuojRiM5slxTcUt5+RlN+F+rATzbTaFqVFk+gGsz8oWE96avsTywnhpPCodJlYvcW6AMOjvAsx3RCxm9hsd+5SMsAXXszuXlXAKL5ZRLtD3J+M+QMIYO/EQMwmv6VjjVOSRHhWcHAfNHku6l+4H47/ad+cgEYD6jVYIYCHRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE19D1C007B; Tue, 16 Jan 2024 21:46:54 +0100 (CET)
Date: Tue, 16 Jan 2024 21:46:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 4.19 11/12] gfs2: Refcounting fix in
 gfs2_thaw_super
Message-ID: <ZabrPnsVr6WHz2lM@duo.ucw.cz>
References: <20240116002817.216837-1-sashal@kernel.org>
 <20240116002817.216837-11-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w5MB4wnlx5osspG+"
Content-Disposition: inline
In-Reply-To: <20240116002817.216837-11-sashal@kernel.org>


--w5MB4wnlx5osspG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Andreas Gruenbacher <agruenba@redhat.com>
>=20
> [ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]
>=20
> It turns out that the .freeze_super and .thaw_super operations require
> the filesystem to manage the superblock refcount itself.  We are using
> the freeze_super() and thaw_super() helpers to mostly take care of that
> for us, but this means that the superblock may no longer be around by
> when thaw_super() returns, and gfs2_thaw_super() will then access freed
> memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
> that.

Patch was broken during backport.

> +++ b/fs/gfs2/super.c
> @@ -1013,6 +1013,7 @@ static int gfs2_freeze(struct super_block *sb)
>  		goto out;
>  	}
> =20
> +	atomic_inc(&sb->s_active);
>  	for (;;) {
>  		error =3D gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
>  		if (!error)
> @@ -1034,6 +1035,7 @@ static int gfs2_freeze(struct super_block *sb)
>  	error =3D 0;
>  out:
>  	mutex_unlock(&sdp->sd_freeze_mutex);
> +	deactivate_super(sb);
>  	return error;
>  }

Notice the goto out? That now jumps around the atomic_inc, but we
still do decrease. This will break 4.19, please fix or drop.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--w5MB4wnlx5osspG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabrPgAKCRAw5/Bqldv6
8vXvAJ4xPIsInQY8b9aJf+YojgyqIbnsEgCfdfWZWyfqcu9gi+6i7xz/o4JIdnY=
=u5qo
-----END PGP SIGNATURE-----

--w5MB4wnlx5osspG+--

