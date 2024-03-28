Return-Path: <linux-kernel+bounces-122781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8088FD28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170B0B29046
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E37C6C1;
	Thu, 28 Mar 2024 10:34:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1E57895;
	Thu, 28 Mar 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622048; cv=none; b=L1cC9zNfYdM7gQljoPouDCevciotLwYCnV+EH7JM/xOT7J0hsHSXx6Vc9pFSEYC1hDmrPA6557fn5yuNxQQsdR35KSUuxdi93YwtV181dSZgywsyFw1dHfyu8mep3KYEeUA/mNu+W/I4wxZMo9e/v6HUfoQqXNqyMh0ppOfdf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622048; c=relaxed/simple;
	bh=9GKBgRe8M71pv5YsV8sYX43vihykXoAI4QMvCVvtNFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmBsPnGbSprLGQLwLbDrJkkwY7p3tP20ljUWmSTVvt+4JqqEhJf2+fPUP4QXzomP7HjyQ1BtlJdSbZkg5zB3OfmgpHJbyI263HQSrYtduUFcHCtf/5uiUoyJKbdsDPquXDdcdX3gczZd6TejXGDyfGdm78bikGH/L2WZ0JKAxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C0AA91C0081; Thu, 28 Mar 2024 11:34:04 +0100 (CET)
Date: Thu, 28 Mar 2024 11:34:04 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 4.19 035/148] wifi: mwifiex: debugfs: Drop unnecessary
 error check for debugfs_create_dir()
Message-ID: <ZgVHnFAGan7e+mYK@duo.ucw.cz>
References: <20240324235012.1356413-1-sashal@kernel.org>
 <20240324235012.1356413-36-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tkcsipe4i8KMbCTU"
Content-Disposition: inline
In-Reply-To: <20240324235012.1356413-36-sashal@kernel.org>


--tkcsipe4i8KMbCTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jinjie Ruan <ruanjinjie@huawei.com>
>=20
> [ Upstream commit 50180c7f8e3de7c2d87f619131776598fcb1478d ]
>=20
> debugfs_create_dir() returns ERR_PTR and never return NULL.
>=20
> As Russell suggested, this patch removes the error checking for
> debugfs_create_dir(). This is because the DebugFS kernel API is developed
> in a way that the caller can safely ignore the errors that occur during
> the creation of DebugFS nodes. The debugfs APIs have a IS_ERR() judge in
> start_creating() which can handle it gracefully. So these checks are
> unnecessary.

Additional error handling does not break anything.

This does not fix a bug, and thus does not belong into stable.

Best regards,
								Pavel
							=09
> +++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
> @@ -977,9 +977,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
>  	priv->dfs_dev_dir =3D debugfs_create_dir(priv->netdev->name,
>  					       mwifiex_dfs_dir);
> =20
> -	if (!priv->dfs_dev_dir)
> -		return;
> -
>  	MWIFIEX_DFS_ADD_FILE(info);
>  	MWIFIEX_DFS_ADD_FILE(debug);
>  	MWIFIEX_DFS_ADD_FILE(getlog);

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tkcsipe4i8KMbCTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVHnAAKCRAw5/Bqldv6
8nWfAJ9PHvxLJw8k4iAUnXui+VmjI/BQ4gCeJBZ/PeipfPLhm5EZaYu7SOY+W4c=
=Cb2c
-----END PGP SIGNATURE-----

--tkcsipe4i8KMbCTU--

