Return-Path: <linux-kernel+bounces-150854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7038AA5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B11C212A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD26A8D2;
	Thu, 18 Apr 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KwM7SCxb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28D2AF0F;
	Thu, 18 Apr 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482246; cv=none; b=VaPeXCoMhLEQqcq3SYXbW0WxXq42p59ef3RIiANWy5UdcBewhc66OZVlZndg9KLj7CzT7eC/XVbxJIRNKe3F91WjhlRgJFl2WHH2m+AHRMyhwL2iOBKw+ia+62KAEol29a9pm9cU032qFE4QQFx2UE8rc4AtzyOFzoJPEK4wZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482246; c=relaxed/simple;
	bh=YdP7b8e5Nuf4lU7Q8iiryH+MIbQCENb/Z5UOFyeu5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkXP+/4zFhnM4bsj8soJ5bSfay3zc4QBa29S5AtyO3peP4LQUqa1LOJIyMUZqlqCoDUW4J+d7wGMnLVAYg+NaYzzakocu8qt2Rf8GKDMSt04NS/ZgA/WUe/JqCBhJRxFOvvG6plijNAxOfavCct8BuvEaWwlHvnef4pBtMN8xV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KwM7SCxb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713482239;
	bh=NpD7ATiwMTosHFPN5iZq+GiEzxh99S5fUAwGw96lqaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwM7SCxbIvESYOsSfk5tUZ+QZnqWH8kRDDXGso/oLOAN2/edLCrY5ALs3gWK0s7bZ
	 qHrk1UjF5jBcqVOL7rRHDO2owpO/lJoOla2OV5YApjyxl5iQHxCJ+tlDhnQrlkikmd
	 d/cu6iOObZYH1bZIxqEiKmry8zjvBloildRQQO0w42k7dpjmc3/BLKls+WzoVv7TN0
	 +VR/NcgiC6wFNFqbapg4zc9lu+xa5IcmaCSS0keuCb/ZRTH9mLiNGGwD1wFfXc9Jsg
	 3AE9+F/0VFflL5MBMMHe22bUvgztKa9upwXDIdIwzHaXdVLOxTCS4+dnBaUAJQprse
	 w+TstsOP/QDTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLDFW3ZLPz4wxX;
	Fri, 19 Apr 2024 09:17:19 +1000 (AEST)
Date: Fri, 19 Apr 2024 09:17:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
 <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: [PATCH][RFT] Re: linux-next: build failure after merge of the
 perf tree
Message-ID: <20240419091717.50ce0a81@canb.auug.org.au>
In-Reply-To: <ZiGRQZQGl0REHm9A@x1>
References: <20240402094116.79751030@canb.auug.org.au>
	<ZhlRn0TUkcDaAZT5@x1>
	<20240413124340.4d48c6d8@canb.auug.org.au>
	<ZiGRQZQGl0REHm9A@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H6Dt84TtF663y1Pep1It+vN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H6Dt84TtF663y1Pep1It+vN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 18 Apr 2024 18:31:45 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
>=20
> And reproduced the problem, find below a patch that reverts the patch
> that removes tools/include/uapi/linux/stat.h, with it applied in the
> sequence above right after the merge of perf-tools-next it seems to
> work, i.e. it builds without problems.
>=20
> Can you please test this so that I can get it into perf-tools-next?

That works for me.  Thanks for this.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # PowerPC le incermental=
 build

I will apply that patch to linux-next today (if you don't have time to
update your tree before I merge it).
--=20
Cheers,
Stephen Rothwell

--Sig_/H6Dt84TtF663y1Pep1It+vN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYhqf0ACgkQAVBC80lX
0Gy1PwgAlv6rgGiHtGkCcmlx3KG8PBHrodob2oT1rbcNzFXsIPpq6APKN23XWMVt
t4md/vOj2cvM77DCyvO41EIfLsHLnKHYPVYP2VMIEh1Ogq8MvpQHg9+K8dgnkiOf
uS3HIzcptH3FMX1QJnhjK7JcqfYcw7GKisrE4A/FZFRR4FqWV2Gl7xKpVyMG8eYd
4whRMk9NZ8OAaI7sEztrP5hBRduqFKz8wkkuZb8UESPniQfPqkgg/FfCWODyzIAf
e8GFbL+Fs+v7IDDMHq/pIV7cjPmvlRrwpFBjOynxh620X3Nw89LhPOubL3o2cu0a
Oj4YTXxuGIGjcOm6Va9tu2hJZ11NrQ==
=rcAH
-----END PGP SIGNATURE-----

--Sig_/H6Dt84TtF663y1Pep1It+vN--

