Return-Path: <linux-kernel+bounces-111624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA06886EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7AD1C21F30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C04AED4;
	Fri, 22 Mar 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKGBb7CV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88221482F3;
	Fri, 22 Mar 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117991; cv=none; b=MtCdfrE7dGVm66msihMKg/OV4QnBqfN8wXfjGgqRqmi8g9ctN5oyhzX4ExHOEB8XEJY9xqQhJabyKOLZTD50eJUbO6Y+Of+nvWqFfc07qIozffi36EMZNWfGRoOPLWTWK+iLTpKpyJR6biSd34yFnQ/KYgtAk0PzSvuEWvttNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117991; c=relaxed/simple;
	bh=4YU5WJf3WfMHlYPfI4XCeU2I+hTiZpRkSk8J5jLQ3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSVlg/gMx1Rq5g8pCj/pMVHIxvy5VIjTuHRvpZSwwcg9+0tk9QLKqyhBcssuFOEwaW+oYqp1j8m4ip3RjiMrlZBqmbXd9Pv9rzZXSyv4XV9scTBefPLTQsXG0+/KrhVyvD1jkDvcclu9euzaMbOK6tcuvMDN1sarOQduDdz82Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKGBb7CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10EDC433C7;
	Fri, 22 Mar 2024 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117990;
	bh=4YU5WJf3WfMHlYPfI4XCeU2I+hTiZpRkSk8J5jLQ3es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKGBb7CVwSNfseamU9SLwfCBi1CD8fJAzWGocTw3UXL9kktHcbKcThy5pmURa2GiI
	 odwd+u+Hl4JTOP62AIuwq6GzhX/8nz8tSsklYm+mA9wQjZ7Ocdf8WhSa/pLHW7P68S
	 0nC8rurOXdVmiqOMcrAPu8Q6jdpB7UyxSrJAKsokzr9ytv2WA8z4elkS1wK3J5LIv3
	 n69SpoUwx+TqT0gA5kubjfSNZN31zKGVsdor3xECKvKSWMCOuLqsyqZMtsf48GCTsZ
	 OYv94CzFu5tG7ySnSF3bz5LFz7p8CndkkemKf7Ulvh8HGj4aR2WmoYsodkT58fbS55
	 ZhdDZNleEmIjg==
Date: Fri, 22 Mar 2024 14:33:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: coding-style: ask function-like
 macros to evaluate parameters
Message-ID: <7d965b3a-c857-4498-aea9-5a3ad8ad5b76@sirena.org.uk>
References: <20240322084937.66018-1-21cnbao@gmail.com>
 <20240322084937.66018-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F/USLqwBIaw6nYmg"
Content-Disposition: inline
In-Reply-To: <20240322084937.66018-2-21cnbao@gmail.com>
X-Cookie: No passes accepted for this engagement.


--F/USLqwBIaw6nYmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 09:49:36PM +1300, Barry Song wrote:

> The driver code, for itself, seems be quite innocent and placing
> maybe_unused seems pointless,
>=20
>  struct page *dst_page =3D sg_page(req->dst);
>=20
>  for (i =3D 0; i < nr_pages; i++)
>  	flush_dcache_page(dst_page + i);
>=20
> And it should be independent of architectural implementation
> differences.
>=20
> Let's provide guidance on coding style for requesting parameter
> evaluation or proposing the migration to a static inline
> function.

Reviewed-by: Mark Brown <broonie@kernel.org>

--F/USLqwBIaw6nYmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX9lp4ACgkQJNaLcl1U
h9D/3Qf+OAmGX1LtgvGmlxtBTyB3f+RqYVcaN+eDJ5mmGb/PBXtUHrCWMIjdJV1T
alW4pNoJlPHSip3U7gjDx/VVEkHpBMD6wl3aoTYn+1iiG+8fwxu5WRYWptGwx3ux
NULjEcNjGxzdVH6RBC/9KiOEU3WyWMBRDlNzA78mngM8JDDOephB6Z8OEYbz53A7
PQGn3ogxV5WvhEYmJw402pzierGbewLnmiPTJhhdp81l+kIGFKtuxch8Ucde+tzw
qU2EgbM7OVuXj3LVw/aDPjyYJwZhwXUVuV+TB1MVqog4dqkbon6UgPonc2PPwTnO
EOFhcKG422l9nhl/Iig/3i1DVCAVZw==
=i5nb
-----END PGP SIGNATURE-----

--F/USLqwBIaw6nYmg--

