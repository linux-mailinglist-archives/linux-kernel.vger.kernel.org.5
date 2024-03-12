Return-Path: <linux-kernel+bounces-100794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28FD879D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C77B21EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C841143736;
	Tue, 12 Mar 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tf7z2+dF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7C3FE4B;
	Tue, 12 Mar 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278072; cv=none; b=IqgrJIpdMz2++ubv+5zkXrYSLCNboUhFkXvemcRttCO0n+C/KO+fuB+yJKxQittErh0WsG5sWjrAef1m9bIXzP7F200haECZ//M+KDnAr6HUd2OgU0IzrDwqMhv5NP371cyhC9jgSwBnCCSPe+9UUM7ECitX9DOaGsr3B1/VmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278072; c=relaxed/simple;
	bh=vAxk2waN+sYqtbztEH/nA2je6c7kmeSt1OZ0Aejr3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHc6gLgf/VWpn6H6QQkiLKyfqIjsf+c5DW9khcbqH9hbVNJBw/JGOiKG0NawZ3yeXMrgilXP1W+aSu0kMwUUSqE7tUkaoJSEjhXqpGIpqaYoMjYW57opnUyn5SbaPtg9LjUOEzI1/mhjORvrhGqgLHMlLCPqE7YJ+O1Mgols08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tf7z2+dF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710278068;
	bh=wEGQV5QIaqEZ6hE3isP0MS3DIrgiN1kCQL0kkaGLXUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tf7z2+dFcVb3u4FnpAcmb0wLn+HH1bMYTTw2cOGKRjaDOZiFNskfQlRVBR9qgGB5V
	 AlWEk39uQrVGWT/gfFUzGQTQ0rf8cMA6hXD+SLzvQr0VDHFTWXMlTHWhXwg/h9sH8z
	 bA1VNwXDRxDSA2hrHpm9zc0w9n2YYcn+JPmvUNSBzoYOg8KQhQZ1ZwI6p3c3PXJhlO
	 eft4/rYW4eVW+TdibZsfa74/qa/M66W8tczWKPPd+NcuMjWdEqIdQCkuXS+RK3R4ID
	 X8dAHIrfYyuJnCLti2J2wYKKBsWqNpmTPxGUNDX+TisX8S3HfE4bZHTxP2LV3iNkou
	 U9mNRUcVPvEFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvRGq66qfz4wcT;
	Wed, 13 Mar 2024 08:14:27 +1100 (AEDT)
Date: Wed, 13 Mar 2024 08:14:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20240313081426.44f1c755@canb.auug.org.au>
In-Reply-To: <20240312074537.2c327a9d@kernel.org>
References: <20240312153304.0ef1b78e@canb.auug.org.au>
	<20240312074537.2c327a9d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MS.Ywcd3R4P0HlkwfmH7M4k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MS.Ywcd3R4P0HlkwfmH7M4k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, 12 Mar 2024 07:45:37 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 12 Mar 2024 15:33:04 +1100 Stephen Rothwell wrote:
> > After merging the net-next tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected inde=
ntation.
> > Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected ind=
entation. =20
>=20
> Sorry to ask basic questions during the merge window, but what version
> of sphinx do you use?  The warnings generated seem to depend rather
> heavily on the version :(

Currently I am using version 7.2.6.  I update it occasionally when a
new version appears in Debian Testing.

--=20
Cheers,
Stephen Rothwell

--Sig_/MS.Ywcd3R4P0HlkwfmH7M4k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXwxbIACgkQAVBC80lX
0GzzTwf6AinMMCHWzI3YHUeQ7NxUYmLrj42C0E/sgXVnMfNLtpj58J6hQanKdu+J
60vcIarcUO7zRqZy3qLqz8OeqtY4M9wpVr/qjE1I8cZ+eMLW+6P5+S77US/b64kN
rQ6aH4sYPH0k59AEm2BSdJfh4a6rDjwgTaK132V5u+qo1rBNowPKKkRLPexubxM0
ESlhMRWOPsC3WTFY+ZCH+y3xJqs6xt0tEg3edrxnOfgdYZcZBeE768GUr2k384Nx
QeBsztLV4fJhrGrNetdsZQxzq8rVX3EUcX5VvxCHc/3UVYjMtQ74paE3pNCNaPWR
7op8PQmoQJS0EP8fpk35RZbKnZQS1g==
=Cozv
-----END PGP SIGNATURE-----

--Sig_/MS.Ywcd3R4P0HlkwfmH7M4k--

