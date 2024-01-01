Return-Path: <linux-kernel+bounces-13959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67D8215F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294871F2156A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67EEAE4;
	Mon,  1 Jan 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P8mvohA+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1FEAC2;
	Mon,  1 Jan 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704153147;
	bh=fT41D17aS053xSaBSdZ3kdXTNCwLSGWr3ETa4koZxS8=;
	h=Date:From:To:Cc:Subject:From;
	b=P8mvohA+p/ebDhIvw/T9nlWkUTd4qKsZrS1kZ9xSZHdCPrD2x8VU2+Y2ULHn3xIS7
	 5RZRSn0M7HvtfLGubOmmZEntUqUwtg3IIDSgPZhbQBKxCkRgomKYRlpuDMil2EWRsy
	 KZ6++jVYDmBN7kfBA5s3pHnVMQTgC79zU4UUlrLh71Wc9DU4TFwZCN5Znb3DmTkiyj
	 8tLf8LNIS2KxQdPH/Q8MgQpMNJ6JBN1UNQW1N5aUfG4nqQ0p8prZHrHQsKB+4B/drI
	 TZE/qIQM2qoimJfB6TZShNhxJeFqBpBGmu5203dgW484W0rvzQjm5aV1DBiqmQSa6d
	 siM3uTWu4yLXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3t7s510tz4wny;
	Tue,  2 Jan 2024 10:52:25 +1100 (AEDT)
Date: Tue, 2 Jan 2024 10:52:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: DRI <dri-devel@lists.freedesktop.org>, Jeffrey Hugo
 <quic_jhugo@quicinc.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the mm tree
Message-ID: <20240102105223.7634699d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nj3n3oz8ER.n_Fp.+QqdXTS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nj3n3oz8ER.n_Fp.+QqdXTS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/accel/qaic/qaic_data.c

between commit:

  78f5d33f3dd4 ("mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER")

from the mm tree and commit:

  47fbee5f27ed ("accel/qaic: Update MAX_ORDER use to be inclusive")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/accel/qaic/qaic_data.c
index 24e886f857d5,cf2898eda7ae..000000000000
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@@ -451,7 -452,7 +452,7 @@@ static int create_sgt(struct qaic_devic
  		 * later
  		 */
  		buf_extra =3D (PAGE_SIZE - size % PAGE_SIZE) % PAGE_SIZE;
- 		max_order =3D min(MAX_PAGE_ORDER - 1, get_order(size));
 -		max_order =3D min(MAX_ORDER, get_order(size));
++		max_order =3D min(MAX_PAGE_ORDER, get_order(size));
  	} else {
  		/* allocate a single page for book keeping */
  		nr_pages =3D 1;

--Sig_/nj3n3oz8ER.n_Fp.+QqdXTS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTUDcACgkQAVBC80lX
0GwR1Af+MZT5Ie1hMcp412OyeJLJP0VMgjSICZYZoyTVEuZm4DiYz+eWPvLkvOh8
rmdRatJrE/Y29xaFjIHtAiCv0ab4M+f50hkw3p/6aA4PHCUKf8+Zg5bRQqjAcXB+
O8TQ6K+ZrrLSgbkCSPuhJa1aiSXL3jlraM6MPBrkepIWeTw53aBS80BnRXO0kZh0
+5gwMvO2UqZ/9t/vEH0TYVrVmau1zAiRx+20miBvHlk8wlF0gStwWuhKrRxZkMqE
4gzZnQGqbpTEpyqlodNQO9AIhHH3vu/p5CYrrluEplEGsH54Cel091bvjXyoEALF
ETWtLZ+Ng6X289xTrivLUWqYUc3N9w==
=eTR6
-----END PGP SIGNATURE-----

--Sig_/nj3n3oz8ER.n_Fp.+QqdXTS--

