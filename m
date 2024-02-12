Return-Path: <linux-kernel+bounces-62400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBED851FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D228535D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CE4CE12;
	Mon, 12 Feb 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="skn/ADoZ"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17764D121;
	Mon, 12 Feb 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773631; cv=none; b=LP77Uc8i07zrzBk2iWarom72ssI6s89MfhdWuhhU27cdhf7HXrM8k3t5lEeVixjfI0uY1Yi/zSVGOKuk1EYNPEodNZYC1bNoaq93S8d3Tb41myuXIe6vEIG8PqI6TEKxnZuOjLUnWXBzQm0dnL9KYSzNxkDl0kZN4yrUpIonZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773631; c=relaxed/simple;
	bh=Bq/LpEnbaTHE5PaJja0JFnAUJzmhDupOXRcOwpXgHhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYuXyG6bP6fpqE2ry0PUtY3UV5pvFquI00ASEA0OJ8+7W2qMXa0pdmdpWCaQjZvOoXJ3cvBovf3n3CdRj/+BGSYSatk2XalK7KNcU97s92gK69ilGI6lsXTcYTwLhdQ7FG6zDDd480/3Dnf5ARcJ4POahFFKHJt5L/XGryaHNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=skn/ADoZ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:a903:359f:8aea:3bdc])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 96B377D9C9;
	Mon, 12 Feb 2024 21:33:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1707773628; bh=Bq/LpEnbaTHE5PaJja0JFnAUJzmhDupOXRcOwpXgHhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Mon,=2012=20Feb=202024=2021:33:48=20+0000|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Jakub=20Kicinski=20<kuba@kerne
	 l.org>|Cc:=20James=20Chapman=20<jchapman@katalix.com>,=0D=0A=09Sam
	 uel=20Thibault=20<samuel.thibault@ens-lyon.org>,=20edumazet@google
	 .com,=0D=0A=09gnault@redhat.com,=20davem@davemloft.net,=20pabeni@r
	 edhat.com,=0D=0A=09corbet@lwn.net,=20netdev@vger.kernel.org,=20lin
	 ux-doc@vger.kernel.org,=0D=0A=09linux-kernel@vger.kernel.org|Subje
	 ct:=20Re:=20[PATCHv3]=20PPPoL2TP:=20Add=20more=20code=20snippets|M
	 essage-ID:=20<ZcqOvDgXsG2W8t8l@katalix.com>|References:=20<2024020
	 3223513.f2nfgaamgffz6dno@begin>=0D=0A=20<20240209082046.6a87f7f8@k
	 ernel.org>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Re
	 ply-To:=20<20240209082046.6a87f7f8@kernel.org>;
	b=skn/ADoZKlwuQsmd3YhintZw9Agr5SKneSj1rNClejPSfeLC5nqui2b3j/Muk4wpF
	 zGiPZQdXbntvYN580mrWNmxNHhyfZQ5caI/3/hp8Y5LI1loMGgDpyXJss8vV0FCoNo
	 KcWp1QqtRHydGUCPfyjTMaVIOyjdP6mPlI/LrdbNnIm0z4RgR4CzAmdV9W1Pemh6WL
	 WjBjrqTeOf8tlobMoD+A1EEHFv4Zy3n0MDH58QBqYVtxWrEJdASu8o3nqB2wpzq8Sf
	 Y7qJDjh03VSkYoZYrljieRV+Y4Kj6W3kUXz9q1RD6ii9S2dk5veVM1y7gIY0SQAuQb
	 cBNhOVzIqqjRw==
Date: Mon, 12 Feb 2024 21:33:48 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: James Chapman <jchapman@katalix.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, pabeni@redhat.com,
	corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] PPPoL2TP: Add more code snippets
Message-ID: <ZcqOvDgXsG2W8t8l@katalix.com>
References: <20240203223513.f2nfgaamgffz6dno@begin>
 <20240209082046.6a87f7f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPH0nXQ1L/7W8EfL"
Content-Disposition: inline
In-Reply-To: <20240209082046.6a87f7f8@kernel.org>


--DPH0nXQ1L/7W8EfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Fri, Feb 09, 2024 at 08:20:46 -0800, Jakub Kicinski wrote:
> On Sat, 3 Feb 2024 23:35:13 +0100 Samuel Thibault wrote:
> > The existing documentation was not telling that one has to create a PPP
> > channel and a PPP interface to get PPPoL2TP data offloading working.
> >=20
> > Also, tunnel switching was not mentioned, so that people were thinking
> > it was not supported, while it actually is.
> >=20
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>=20
> James, Tom, looks good?

Sorry for the silence -- I think for v2 we had some discussion of
whether the PPPIOCBRIDGECHAN docs really belonged in l2tp.rst or not
and I wasn't sure whether the same issue would be raised again.

For me I'm happy enough having it mentioned in the l2tp documentation,
so long as the example is clear and accurate.  I've responded to the
patch now with a couple of suggestions on that front.

Thanks,
Tom
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--DPH0nXQ1L/7W8EfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXKjrsACgkQlIwGZQq6
i9Bo9gf+M2HejzgmlPv3lvUmunb+CR9btn3EyqFs8s+Nov178iSOPaLXpRJRavrt
EQ8ktZIf3Umn3fnYE6fnClNK/iu1R/8Uzc3Rsy4TRYFDQPGGxJE9AUot2HAfSjne
wVHz6YciXfCvNZJXjf8SEh8uyhpjXRK/PuESPjgkpH1lo2+4Ju+i336f0UtWPR06
fcZ4ACeGcaHIE4dDKT3J8C1hSXFsy9AK0z758mT0ESDC2vtfkAxtzUgDcf/h8OVk
giyl84hvIrNJK6aTLYXEv7HPZIdK58G281Jhi2VTwNFbeSoQafTQlQhsKxGL9bM3
wo1wMJ8uPsbMEUAk2/a9tqtIZP2HGA==
=/yw/
-----END PGP SIGNATURE-----

--DPH0nXQ1L/7W8EfL--

