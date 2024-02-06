Return-Path: <linux-kernel+bounces-54287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A10684AD52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAEDB240A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E257690A;
	Tue,  6 Feb 2024 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tzwbc3RG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DF73188;
	Tue,  6 Feb 2024 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192835; cv=none; b=N6ntmQPOxb0g5y0x7uU0GhW7SB6pXLGjbd9OfJmGWzAMM82t1QUA0GVqowy29gT80OJcbDHD6ZdKyqa23LC4DjLS7nrmhQuYWIi+GWV4fxMi5y3Jsm0XR0Rr/7VFtPNm4pqM4uJP1zV0t9rJGRVgLmUb3zsooQ53WrEKjSN4Cgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192835; c=relaxed/simple;
	bh=MkpjDqEoEKy/sPAWP3i2g+8+gO9pM6DMBdORSM2lfAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkBsy6Tumk2QJuoZqkiOxxQSv86xS4/wxWic38wmH7YhF96/iAhGWL7F9Fhx2lne3M5fG7mBI//ve5/gtB7N3g+p/4gK7XdODuC/bdg99mn4ta/Tfrh+BmJmaVbHPblJfw6bYfCA9f0o73FfYGZJMJit7c01KPlf22VAzqIW8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Tzwbc3RG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707192829;
	bh=G4367yS/igy6jo8f7kZFngEk0gxBayjC0JnVD/0nhIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tzwbc3RGjaQr+sGzsNbrHps3VrngckNmL1OOWr4r+CeO7HhjQunvAAIlzT7ELCiLZ
	 5Qaj2xICd8IZU46/cezcjynYB3KegcnV/sBLV+Quo1EmB3dEPQxy7j1/mRHgBvCKI+
	 YuqMlXyOLJa8NGxcmrsBJSM11SPuw2MnO8ZXSnMH1bOq/FeaHVMT4Aq00yBmeisRvu
	 0tOG/X5uGbQZ8Jkc7R7cL5ZPQ9C8hJogBoA4GkBNymKWvJ8OBqzbzg8Gnm8XN4iUbV
	 PBrEOZ4EZXBAAn5esTjF2Q6e4yCHyHL16XZff/ve1H7NFHD0VrsXj1FOAVXGluZ0Ul
	 gyz1THjOICusw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTVHK0lYwz4wcC;
	Tue,  6 Feb 2024 15:13:48 +1100 (AEDT)
Date: Tue, 6 Feb 2024 15:13:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20240206151346.1945cbdf@canb.auug.org.au>
In-Reply-To: <20240206131050.0e86d882@canb.auug.org.au>
References: <20240206131050.0e86d882@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h_lBjqgYGdBgBoGROW9kFc_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/h_lBjqgYGdBgBoGROW9kFc_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Feb 2024 13:10:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
>=20
> In file included from /home/sfr/next/next/include/linux/bits.h:6,
>                  from /home/sfr/next/next/include/linux/bitops.h:6,
>                  from /home/sfr/next/next/include/linux/kernel.h:23,
>                  from /home/sfr/next/next/io_uring/nop.c:2:
> /home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>     7 | #define BIT(nr)                 (UL(1) << (nr))
>       |                                        ^~
> /home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in expan=
sion of macro 'BIT'
>   538 |         REQ_F_CAN_POLL          =3D BIT(REQ_F_CAN_POLL_BIT),
>       |                                   ^~~
>=20
> (and mny more similar)
>=20
> Introduced by commit
>=20
>   d964e8440442 ("io_uring: add io_file_can_poll() helper")
>=20
> REQ_F_CAN_POLL_BIT is 32.

This became a build failure in the i386 defconfig build, so I reverted comm=
it

  efaf6760976d ("Merge branch 'for-6.9/io_uring' into for-next")

i.e. the merge of the whole topic branch.

--=20
Cheers,
Stephen Rothwell

--Sig_/h_lBjqgYGdBgBoGROW9kFc_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBsfoACgkQAVBC80lX
0Gxhdwf9Fh0qCYJP/4v0A2DTwUUors6KeaYmP0iwRml5+bfrlkGx2onm8/n1Gqpd
I34HF+WaNtzrTWGM+G0Yu9quOSLXgrfjGxgBCrYQwPP7TsOgEaQpN7hviyn22v04
pDDDQpUii9lre8tpT+xUrh6fbgzD50rN7L/1qUoP3F4pWED2K1F6HsdMAF3fRVb4
1bH9uRr4dqZ7e5PSeQ/rEi2jKd87nh+++TLrF+/nu+NJdehrKJKAqKyxKZS8Ub5g
SdUd/NTP+3qQegVUHdIkK3OJbZGgbHDCttx7BQPB98uMJSu1+yXtNPARPPcxGFbm
y0BI+kI3wEDc1e0yh5n48sIxnGWQFg==
=9nWc
-----END PGP SIGNATURE-----

--Sig_/h_lBjqgYGdBgBoGROW9kFc_--

