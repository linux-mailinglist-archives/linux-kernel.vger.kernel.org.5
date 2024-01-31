Return-Path: <linux-kernel+bounces-47213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18821844A97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B030FB25268
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12839AEE;
	Wed, 31 Jan 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKaA1ibN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79039AF0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737927; cv=none; b=ijsox2b4nQANHtTG6ZfW9Xa9Jfo2uU8muaoiLXwuLyq6IgfxQD+9L3o5I4Lqo/SpOByuXcasuq/t/TE+dPZ3ZPrQ4B1xrPsl4poN06KHIvB+bwqb4XnCLuQDEzQL9XWisqk4GmEHXQ+hbsKW1hz/3ospZAlxdylBdWDd/vUZ6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737927; c=relaxed/simple;
	bh=vFjHvXfUL5i6feP5C3Ew07enH8d3nXchQKB2m0acciQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZdPEp2Bij+DBkBOYVw+k6Tili0sTfr/mAkyBCEp3Tq0joupqnrIL16nKWQIen96kOU6JvIDt8v1zP51HlFF18H7RaUufbfJYdaA1WVJYYQj81vXGQR5k1v1wTeBZusEosvw9rn5gEX2xNf/kQr+tuk9xkE5ou6VnxrLynpM9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKaA1ibN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE07BC433F1;
	Wed, 31 Jan 2024 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737927;
	bh=vFjHvXfUL5i6feP5C3Ew07enH8d3nXchQKB2m0acciQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKaA1ibNitOv514tmX9UOv95/OLytrnlFI4vS3s+qtWfnOvM0bCqXQtuEM2rXJh+3
	 52X0OGyRzUD4qylbeC8TjCChJOUw594geQ+xcnuaDc3xJUiW/uNizqf7WMsEnup6FN
	 HXubtJLLEMdULg/qeC8VPqiK8E59A45f/APQrMDA1PGj5U5znrhZGbvPDXWaXYSUuE
	 IbXAxxc/iWOTfhRRKxoVSN5gWKp6qXUgDvwtZ1ggdaxi8qPqaB7vT1Zvz/yHOgM3rn
	 i/rwW1OwoslaiqmWasc4yV79t6NM5x0ZNt38sSvogB4tz60hBLl8fdGPPB7AmVbzGE
	 +Y8WHR46VklZA==
Date: Wed, 31 Jan 2024 21:52:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <6f9b1f85-560a-402f-a813-7962218dce96@sirena.org.uk>
References: <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
 <ZbnIzqmClhAvPxKC@slm.duckdns.org>
 <20240131042031.GA3946229@dev-arch.thelio-3990X>
 <ZbnLk7pZbcODRNER@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8J6gE/oZudS89Qo6"
Content-Disposition: inline
In-Reply-To: <ZbnLk7pZbcODRNER@slm.duckdns.org>
X-Cookie: Disc space -- the final frontier!


--8J6gE/oZudS89Qo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:24:51PM -1000, Tejun Heo wrote:

> Ah, I see. How about the following?
>=20
> Thanks.
>=20
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9221a4c57ae1..31c1373505d8 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1510,7 +1510,7 @@ static void wq_update_node_max_active(struct workqu=
eue_struct *wq, int off_cpu)
> =20
>  	lockdep_assert_held(&wq->mutex);
> =20
> -	if (!cpumask_test_cpu(off_cpu, effective))
> +	if (off_cpu >=3D 0 && !cpumask_test_cpu(off_cpu, effective))
>  		off_cpu =3D -1;

This commit was also breaking at91sam9g20ek (and still is in today's
-next), the fix here gets that booting again:

Tested-by: Mark Brown <broonie@kernel.org>

--8J6gE/oZudS89Qo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW6wQIACgkQJNaLcl1U
h9A8PggAhbi2pIn/tX3EJG4jko4rmlpT5Iq2q59qN57s02VMcGKN/LdKhO7TBCF1
V/ezYDG9a3maiQKWRJd+3nc/ZKVDFdjEUprvnR2Y7lvNqQcOeionUookfqA3EIhj
qVBEV0jnBMXtVwOs18JMN8rwwLnNwcSXshnvdQZwzDX4yNO3x/KXsoEShnjrbsB/
7uRq1KTdafnPvB4ADVLf3L7NOdqEDfjexaXdxEcvBWhA14HDs99ZWiQPASd0EDa9
LD4uFS5MLTf7oah6wVKXCDRumYeAQXqvjh8/bH//WsHPFOk1Sb2ADliE3v380SQg
a5174RT31J+WnI4krNRlDs7ERIoZuw==
=fiOl
-----END PGP SIGNATURE-----

--8J6gE/oZudS89Qo6--

