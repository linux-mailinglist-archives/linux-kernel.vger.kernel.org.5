Return-Path: <linux-kernel+bounces-75633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B285EC86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6901C22811
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AD86AFA;
	Wed, 21 Feb 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NFKEE333"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD1EC5;
	Wed, 21 Feb 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556823; cv=none; b=usu6pgn/u1SQUKNhxw0lgQErgyPjKFrwBJRlO0t9FUhWkPyl+ePZBzkQ1IijdZwaZXOzboDhm9ASGt+fBshAMdWtkGM5xzBxhdDhnvDEZb9DAiSDe65EdT6zpNQw1Rh0tPqbkloXoEKZEcSO/8chIb4V6eSBEFXNHLjo+X8+PqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556823; c=relaxed/simple;
	bh=Gwpylj/sT4sjUiniryxyurq72mhwJX0hnZbtxFhHT5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T3OChJOHXeif824FkDVkfNEHS/FR7N1p/Pilq2VWzs6NUE+sHu9uBeo+dpYOpPYOMIBozAyXpXwiKX6dQHq99QzvguIXSbVfzE2GRJcSHF3e9HuJLeQ81RZ9MqDj5bdyKT1PQTnoGVkMd4bj2P53S2CI0TLZDNVqXaq/PrnRsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NFKEE333; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708556818;
	bh=Ib2C9zjSUcH4lTi6XWnBc7cedDQvZTeIr7QOPZ60WaI=;
	h=Date:From:To:Cc:Subject:From;
	b=NFKEE333dJztxDGs2KTQ/u76F64STOXw5KpJKZBSgZfc/iPjvhKnEUcSNkSf7Oq8O
	 yWWwTR/C19undrzJz5cLOtfyrzTmU8qUNNmLj8dhFP6UBkWpUS1VloXLumGUHXKoJt
	 yTupGrdlrYo59xeo1q0DZ7+D5QJOEDZ5hfy79itrn1BvAdeYrVtgSwjlrxYqBCRjwf
	 dFS+B3tQWZVsepBBR1hOLhDbMMhxXgdFwxMOkylCsJWkII7eqpGOXlQLSCb/RnOFPZ
	 dH0FlROCYggJhZSizWw6b+iGEGwErEy+maPlOxdvCEf2TfhGo/rEzBtuTM8aYsVrEk
	 zOgFF2vK85DJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgBjt2Ybqz4wcF;
	Thu, 22 Feb 2024 10:06:58 +1100 (AEDT)
Date: Thu, 22 Feb 2024 10:06:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20240222100656.0a644254@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6je1p2tIlVil2AvLIAwL2g.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6je1p2tIlVil2AvLIAwL2g.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid applicati=
on of 'sizeof' to an incomplete type 'struct timespec64'
        __u32 size =3D sizeof(struct timespec64);
                     ^     ~~~~~~~~~~~~~~~~~~~
util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaratio=
n of 'struct timespec64'
        __u32 size =3D sizeof(struct timespec64);
                                   ^

Caused by commit

  29d16de26df1 ("perf augmented_raw_syscalls.bpf: Move 'struct timespec64' =
to vmlinux.h")

This is a ppc64 le build.

I have used the perf tree from next-20240221 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/6je1p2tIlVil2AvLIAwL2g.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXWghAACgkQAVBC80lX
0GxBZwgAk3Mk1RF4oYH8dHKJ8Jx3P2OTDVSDJrM8/7t44RElOZosaDiNv94jTzBq
JWo161cFkbFi0+xAy12juOsvptiq83+f9/PiaGhlOVjVKNtwSD4MLnK6TiRDudd4
0tedfNYDOZfXeDCHHej2+Kns29QHjtCorladyyNvrC6GZ+NGgev2L3N3djVk3ZP3
JSRTZM0LhFy8SDcAhnHReoRkBSQs3vLTuHgw5aCefpiY1G07F7IEQ7FBB4DFH2yA
tleEYzfjsuN9R47HipYEtokRSZhPNRZvQhdmk6MXEtkRmbinv0FOEFA8PUXSp/NF
+VLhkZT6lUf4E/GyMLVR5JH8ncnHAw==
=ewK4
-----END PGP SIGNATURE-----

--Sig_/6je1p2tIlVil2AvLIAwL2g.--

