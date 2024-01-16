Return-Path: <linux-kernel+bounces-28267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFD82FC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEFE1C27C35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD550A8E;
	Tue, 16 Jan 2024 20:45:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050C50A88;
	Tue, 16 Jan 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437916; cv=none; b=mf7mhNHTkjICj+P6cb8LHyaBD2VCWrdIpH/xsTZH7Cwmwr26vkD5rVVVR6oxg+rORALdWm/K/BxST9CNTWWM8O+TqQGE9+yoyNEqaK9aI64lFyiaFwLDnt4oR9BSfVBCSq2VKCh34A0UpV0lXNVBgWKbO75Ox4iaRzz8XcUA+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437916; c=relaxed/simple;
	bh=cpoF2QRvffxs5P0l93ZWXcMU8qnywNzlM0H3okDE7U0=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=NYLQY0R+duT/fF7kS3ngqYD2b0frF3hEHVlu6Co1OkPKyHy+Cr2kR6GgGNhRHe6OCU/DCgFZq1L2WqSVfswYo1hPwOk3eyRS/DDH+kGqtFjwFmiAIysCJfaJ6CgOGDxGZWqGGlukPIdK+/jA0R7lQVddZcFJAGHLnJ7EUULB3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CFFBB1C007B; Tue, 16 Jan 2024 21:45:12 +0100 (CET)
Date: Tue, 16 Jan 2024 21:45:12 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	bleung@chromium.org, tzungbi@kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 5.10 3/8] platform/chrome: cros_ec_debugfs: Fix
 permissions for panicinfo
Message-ID: <Zabq2PKJwsllm9zk@duo.ucw.cz>
References: <20240116001457.214018-1-sashal@kernel.org>
 <20240116001457.214018-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="675u0NmgRUhg/z09"
Content-Disposition: inline
In-Reply-To: <20240116001457.214018-3-sashal@kernel.org>


--675u0NmgRUhg/z09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Avadhut Naik <Avadhut.Naik@amd.com>
>=20
> [ Upstream commit 0706526ec7704dcd046239078ac175d11a88a95e ]
>=20
> The debugfs_create_blob() function has been used to create read-only bina=
ry
> blobs in debugfs. The function filters out permissions, other than S_IRUS=
R,
> S_IRGRP and S_IROTH, provided while creating the blobs.
>=20
> The very behavior though is being changed through previous patch in the
> series (fs: debugfs: Add write functionality to debugfs blobs) which makes
> the binary blobs writable by owners. Thus, all permissions provided while
> creating the blobs, except S_IRUSR,S_IWUSR, S_IRGRP, S_IROTH, will be
> filtered by debugfs_create_blob().

This needs previous patch to make sense (according to changelog), and
we don't have that. Please drop.

BR,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--675u0NmgRUhg/z09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabq2AAKCRAw5/Bqldv6
8jkYAKCM+eQYH8va0mKtV3wZTZtsHTbUVACfXo1J98rXiWFpnEW18o9a48UABcc=
=hK0M
-----END PGP SIGNATURE-----

--675u0NmgRUhg/z09--

