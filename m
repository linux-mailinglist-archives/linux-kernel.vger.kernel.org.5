Return-Path: <linux-kernel+bounces-93326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62162872E09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698391C22DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F441759F;
	Wed,  6 Mar 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MthsFKv6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA72D502;
	Wed,  6 Mar 2024 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709699830; cv=none; b=T70tEYsQYgemv8/EH358VipRwCIxW0I9sRoAGIwwwuMeEXmaQ7w1M8VfcfDE6MMnwQwYMV5d+M3AZu8Xw/wZSwzyWeEYaxgUzbZyviXvzPcJCwMkQk8KIO6p10IPv1pjIYf0/2l1K2UtDJ5n4u/mAY/Pz9Za9dFm+GJLwQR3zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709699830; c=relaxed/simple;
	bh=Y0mH/zaPoVocETKg6kpuspDUnEHZhSz4VfiL15lkm00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/9P8KtIVxcJHLrnKSl14cpDVdgCWD8hwbV/BtVJonmS2lCsY/amM7Gz8kxwM5vB7jklFQXli892jBRlftX0SDubGcsevuSe5yOFAWx5vtx6A2EX9ww/wP53FG2+4iYlcrCmhPtEzN2ne7OeNPmv6MB3oxaudZl9Qs8kn8AR6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MthsFKv6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709699825;
	bh=g45YWtQPWYyFKk9lYbKuu33cPJlZ5PqjVCZ8f6/R94U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MthsFKv69iwvVeac0j9H/mQ380rHEb2NKQBd/+QQSDafndrRpcs6mtuu2D66qcVDg
	 kreZRqrehASCAt4a2B5/JA3+YkEqy+1yULmoGTTCXK33BKiC4TI4Wk8gzMwuVmIES6
	 H7VSkJp50psHfwT4sqlQUJ6kFr5Iw8+FwVVzIXA8fuYBPZXDKY2KuFQGb7W/Q0OXfO
	 IXEX2++bgtE6DizCyuJUUtQyw5+1jguY+p6e0OB/wXo3cdTZ6P5FbefWBbMtGQwQaE
	 cADtrttRQiE+hgfi/E2mV3CDjrIr+EiuxeSWAZg3ZBClD75qQyA6wLWnFNdglkiYyn
	 e0WyqQkbwAi+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqKQm287Cz4wc4;
	Wed,  6 Mar 2024 15:37:04 +1100 (AEDT)
Date: Wed, 6 Mar 2024 15:37:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Tong Tiangen
 <tongtiangen@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20240306153703.499661d2@canb.auug.org.au>
In-Reply-To: <CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
References: <20240306105150.06a456da@canb.auug.org.au>
	<CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H=8NnPvhmwfm8YLeS2at2dy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H=8NnPvhmwfm8YLeS2at2dy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 5 Mar 2024 18:48:30 -0800 Linus Torvalds <torvalds@linux-foundation=
org> wrote:
>
> On Tue, 5 Mar 2024 at 15:51, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
> >
> > fs/coredump.c: In function 'dump_user_range':
> > fs/coredump.c:923:40: warning: left-hand operand of comma expression ha=
s no effect [-Wunused-value]
> >   923 | #define dump_page_copy(src, dst) ((dst), (src))
> >       |                                        ^
> > fs/coredump.c:948:58: note: in expansion of macro 'dump_page_copy'
> >   948 |                         int stop =3D !dump_emit_page(cprm, dump=
_page_copy(page, dump_page));
> >       |                                                          ^~~~~~=
~~~~~~~~
> >
> > Introduced by commit
> >
> >   4630f2caafcd ("coredump: get machine check errors early rather than d=
uring iov_iter") =20
>=20
> Bah. If comes from that
>=20
>   #define dump_page_copy(src,dst) ((dst),(src))
>=20
> and I did it that way because I wanted to avoid *another* warning,
> namely the "dst not used" thing.
>=20
> But it would have probably been better to either make it an inline
> function, or maybe an explicit cast, eg
>=20
>   #define dump_page_copy(src,dst) ((void)(dst),(src))
>=20
> or whatever.

This became a build failure for my i386 defconfig build, so I did this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 6 Mar 2024 15:28:12 +1100
Subject: [PATCH] fix up for "coredump: get machine check errors early rather
 than during iov_iter"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/coredump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ea155ffee14c..5353b7ac67f2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -920,7 +920,10 @@ static struct page *dump_page_copy(struct page *src, s=
truct page *dst)
=20
 #define dump_page_alloc() ((struct page *)8) // Not NULL
 #define dump_page_free(x) do { } while (0)
-#define dump_page_copy(src, dst) ((dst), (src))
+static struct page *dump_page_copy(struct page *src, struct page *dst)
+{
+        return NULL;
+}
=20
 #endif
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/H=8NnPvhmwfm8YLeS2at2dy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXn8u8ACgkQAVBC80lX
0GyEPwgAoemQcKdVCx2t1rgczIHrF2FJ9C/uf0RZ70Hh1DJg6s11JdEWDS68x2a7
HBxSlt7oynZG45qkY/wd3GCIXnw9gYF7t03w5Vp1PuALgelfO4wgqKOhy3YXPChx
VTvLDMtef+Qf0MY2cF6+e+hWh0F/7xKi5+cvFBpfy0ynnc15mVUJggnhcoSZ4bUf
KQ6OxfJxfnGWLSN3t3QOEI0XM1zKHsa4JTdux+TjoMhiMGILdJv+1+9Z8fbnbsn/
kK+97WBUoeQ8T/voFlB/RW3Ww8YNH56eJz0Diwlw/risNlbLmtLSAydx2cPzzVQC
KVaTLMjk900+a+BclfMQE4P/sdpCuA==
=cm7u
-----END PGP SIGNATURE-----

--Sig_/H=8NnPvhmwfm8YLeS2at2dy--

