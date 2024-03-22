Return-Path: <linux-kernel+bounces-110876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3088651C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B811B2119D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD64409;
	Fri, 22 Mar 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qVfIFa9z"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FB17FD;
	Fri, 22 Mar 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073626; cv=none; b=qKLl+mecaiWn2BsZkdJnd3dSXGJEI26+3DYnhyf1GZGhtohNNYZAyGyMK2hXhcVYGSIem4k0eJviR9JtmSN8XsZdUI4Yjmh1i6nsq1ioMrqDTHhvOvjfEBYWzsfOcYk37FhknAZ/VZwN/dElt5TLg0SUvh4oXE43Jay9loRn3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073626; c=relaxed/simple;
	bh=KJfPSTtP5VnPiVOBTywlSV6Niya9qDRX9b9ELlLv20k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZq9UJFJdv3t6/IRERf7bfdLfAm32Jod4aTV/xoHjdsYuQHIJta09DEANIbxvlNqFnjALFKsexvRMttwAJ13Ciyeg1KzAkmQq/0bmuw8lJmM6IrVEtrpVZJPWBD+mzI62wa3FegZ68kcKiNazV3YL9hx2L7WmEqFreSC6aVc7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qVfIFa9z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711073619;
	bh=fC4rWjyRs6bC5yBlygw9VwcDtTx+EXZPCLfDorKu1uE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVfIFa9z2PlChpKGebRYKpdBPdEHbliHLtEjwCOGS54o8EgsW1i8Y497tdkvD8dgN
	 0pVwCtC43/lGFb67a0faaOpoos+J5yTr5N4pAwklydl8iC5P1XXZT7g+JH4N7PKXco
	 wc9W7QYrp/6EfS6WwmFzlKr252QqrKmiF41qiCC0z8FtuH5vV3NObGZ1irv3sy4ysc
	 mxLQ3CtJSCK05AQ+EVthoY78OZEphJchHrXM1X9WrwQAqUiOBqwxsfUkyAo4dQ/Nxk
	 VEn1nMPPJteACAMd8iVNCmjlYY+OdjNzBN2Zjhm5ARylVkhAa+0vVW3Jly+mA6Kr/F
	 XSAt/WwSRsn9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V15Tv2k9Hz4wcv;
	Fri, 22 Mar 2024 13:13:39 +1100 (AEDT)
Date: Fri, 22 Mar 2024 13:13:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20240322131338.4ef08fe1@canb.auug.org.au>
In-Reply-To: <20240322103229.28d823b8@canb.auug.org.au>
References: <20240322084131.2316eb8f@canb.auug.org.au>
	<ZfzAKMlYY7IkWXUg@x1>
	<ZfzAZJmrBwVi5e28@x1>
	<20240322103229.28d823b8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GGeghdCZ_dtNZdayAV2LM6Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GGeghdCZ_dtNZdayAV2LM6Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Fri, 22 Mar 2024 10:32:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 21 Mar 2024 20:19:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.=
org> wrote:
 >=20
> > About this specific problem, was this done on over a previous build? Can
> > you try after a 'make -C tools/perf clean' ? =20
>=20
> It was done over a previous build.  I can try a clean build later
> today.  We have had this problem before with different include files
> and I think it came down to a missing dependency.

It builds OK if I do the clean first.

--=20
Cheers,
Stephen Rothwell

--Sig_/GGeghdCZ_dtNZdayAV2LM6Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX86VIACgkQAVBC80lX
0GzqtAf9ESpVcsbVTjC2t8oVZLUKHp6tzm34fW+/T66u3JK1AxTzKexh6oY8JFR3
+qP6Ov3I1VHcLkU6KtbsPRLR/5yqVUYfg573kIDgYdbAunsg2MmyklKNo1RDC0Fk
p9s2SNQVvfh4Atl+bM93n18DjZIbnvc6rHZeYDzFye2/2kz9NPmb0hH5GPnyKrAh
20/SatR5q80WvKMWjnE/TjUur5N2XHCNkKZGRYDiI9YoT2QwnbBSiU1puNwGVB/r
whyRqxNKE16gFRDxP0AtASUnlQ3QbsSxF935p+AxmlOIfFTcM9wNf6moonELF3dx
qPlL4Pos1dolAd1PCPuyMIt7aI0OKQ==
=P15u
-----END PGP SIGNATURE-----

--Sig_/GGeghdCZ_dtNZdayAV2LM6Y--

