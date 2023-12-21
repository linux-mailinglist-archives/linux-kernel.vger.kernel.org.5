Return-Path: <linux-kernel+bounces-9185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443FA81C20B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4231F23B18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05279490;
	Thu, 21 Dec 2023 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Acc1blG3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9977635;
	Thu, 21 Dec 2023 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703202090;
	bh=kAL68R42L/qHAwP3JxvpwmzbbtwIJ3XAu/35EiD4ahE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Acc1blG3oMWT2dr9u55ZJgDMl7JfxhLW6ndcXO+u4Q+sQvTFGOnpECI0TJHKNUbgZ
	 UgCrgqrnRdKAC9JzwmMI37vyPcTwm6ku+o0CYOOcr8qcq/IKFpsfizr+ABEVJGym0Z
	 OTZwD2GRPydkGgJnDvakX/BBfVzQuTz6nnT70s+MHupbUnhb2lu6KKI49TfXvP4dTA
	 s26qRU7VbXaGNvNZbkUol8clgDDdtoHsx0onoT86i+J03c15CI0afUWZF7VnSW2mz7
	 oM7IobYzhvMv+4BStnKNDEQbVakuhEHrYVwQfK3jXps/AOXhkho+teDapEmVoA/ecX
	 5pANnCHvLx66A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx6QK4LL1z4wcJ;
	Fri, 22 Dec 2023 10:41:29 +1100 (AEDT)
Date: Fri, 22 Dec 2023 10:41:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
 <dhowells@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231222104128.395c9f7b@canb.auug.org.au>
In-Reply-To: <20231221111847.689ea41f@canb.auug.org.au>
References: <20231221111847.689ea41f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.cm1.unLtjyuD5TDODiIrCG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.cm1.unLtjyuD5TDODiIrCG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Dec 2023 11:18:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> fs/netfs/buffered_write.c: In function 'netfs_kill_pages':
> fs/netfs/buffered_write.c:569:17: error: implicit declaration of function=
 'generic_error_remove_page'; did you mean 'generic_error_remove_folio'? [-=
Werror=3Dimplicit-function-declaration]
>   569 |                 generic_error_remove_page(mapping, folio_page(fol=
io, 0));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 generic_error_remove_folio
>=20
> Caused by commit
>=20
>   dec5b4af52dc ("netfs: Provide a writepages implementation")
>=20
> interacting with commit
>=20
>   af7628d6ec19 ("fs: convert error_remove_page to error_remove_folio")
>=20
> from the mm-stable tree.
>=20
> I have applied the following merge resolution patch:

The resolution is now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Dec 2023 11:08:57 +1100
Subject: [PATCH] fixup for "netfs: Provide a writepages implementation"

interacting with

  af7628d6ec19 ("fs: convert error_remove_page to error_remove_folio")

from the mm-stable tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a739805dd394..d7ce424b9188 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -566,7 +566,7 @@ static void netfs_kill_pages(struct address_space *mapp=
ing,
 			folio_end_fscache(folio);
 		folio_end_writeback(folio);
 		folio_lock(folio);
-		generic_error_remove_page(mapping, &folio->page);
+		generic_error_remove_folio(mapping, folio);
 		folio_unlock(folio);
 		folio_put(folio);
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/.cm1.unLtjyuD5TDODiIrCG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWEzSgACgkQAVBC80lX
0Gy67Qf/dBCQz53014sVyhGXcSUBCZ6wcBh0sJ5qVPDzKbel88D531CbblYRGh5r
B+mPM1JkjciKQPuxszrmdIaaILv1b0vdgCgor1htROIX3GP9+x9G1Zj8jUQDg3B0
Ot7cCLupwrkv7pVdNPJxZcCvBhx5DvvHTJQCJ21xJbc17NSvOvj/Sy5DpFN/ILHc
H2KmLX2EjabRf8I1QiGMa5K/JCi9s23CfkqxdCrR8tYWRq5hB9qFzKtrPjKHdBWT
5cDMslFP/ptvZ4eabzEy+Rt4i7Db6KM2rUtWk60wgVd6nM+xXPhLqMjngk01aVGl
gC3LxwzZhQ/UxWYwA95eUmYc55iCGg==
=q7oI
-----END PGP SIGNATURE-----

--Sig_/.cm1.unLtjyuD5TDODiIrCG--

