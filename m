Return-Path: <linux-kernel+bounces-161782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820608B5128
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A5283AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024FE10971;
	Mon, 29 Apr 2024 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ln+9Fqu8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5999F9DF;
	Mon, 29 Apr 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371474; cv=none; b=LpMoevNH7Q7UP2kTi5qKqD0Agquv2TbHkVEkXWLK3f5Gm1BCntZq4B80gfTjJVZFjU8qgNX1QjElP2hHYHjC2xl65I2ZJTn+VR9Wp/zEaF2OI7SgIThX5ng2LqOeXZq9OmyNf7aRb/fgUZn49pWZnPbVFF5/aWKxKjntBUFhIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371474; c=relaxed/simple;
	bh=B1QvDGqXDOx1Em79tWzqZzFenHw0d5XoIi08JJO1es0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bDc9RlGa4Ibufy+rfJ1GFZlmHxWmIdSzHn5/BtOAD8WxT+fQosRZmUjgOxy0EeG2SrT5O6GoaoTK0hpvoVUnXvpUfkdxQyOd0UN4f8Yt4bylJDAWxj8rYEF4TxgYAzBlojnmJd980ncm5TyPXkEEWmVN4U74hZjbr4jDdIuf/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ln+9Fqu8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714371467;
	bh=xvJMPYHnUvqOdOsRZ1kvlGWyZkMZBUVzzaeWzgYMsDk=;
	h=Date:From:To:Cc:Subject:From;
	b=ln+9Fqu81/bq4pS95rZXKDpREkkYJYIg/1tRVdrwD5aOP/Tkhg+K1jrrjfehygm0l
	 Or4FfM+v+/AuG7AEwpS2PniJ5wxMovmlQyqKPjRaNIttQJXc7p3tOIQYihbuxmxo0I
	 V0AxejI2NR2ZgCxYjw34a6/V1dyXfX6vXIT8RbvBbVz1PgjzLocFysEDDRcjsX0uFB
	 3AOfJsW/Aw0pLllK61fd9SbJ4lWLAjd26khrjk8FzVzEqZ7qQsAAL0pDz+C8QbEC+W
	 aFf+ac0ZiQng1KqAmaGoQP9aYGbgNZj5hG2DhPOvak5fuVEd7oadQ7KeoLL99Z/VLW
	 TehXCUoQn0Vvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSY620hWNz4wck;
	Mon, 29 Apr 2024 16:17:45 +1000 (AEST)
Date: Mon, 29 Apr 2024 16:17:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Sudan Landge <sudanl@amazon.com>
Subject: linux-next: manual merge of the random tree with the pm tree
Message-ID: <20240429161743.21019d15@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7vz6JvMrZ1rTxlL2.SrTB8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D7vz6JvMrZ1rTxlL2.SrTB8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  drivers/virt/vmgenid.c

between commit:

  00e8b52bf9f9 ("virt: vmgenid: drop owner assignment")

from the pm tree and commits:

  e07606713a90 ("virt: vmgenid: change implementation to use a platform dri=
ver")
  7b1bcd6b50a6 ("virt: vmgenid: add support for devicetree bindings")

from the random tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/D7vz6JvMrZ1rTxlL2.SrTB8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYvO4cACgkQAVBC80lX
0GxTPgf+OVBFBPgsFTklas/WhGYdYSSJATQuosYYob6N77L2wXd0t/qjQlM7LDRV
xs1nvGaYmkgL/QysBBV3zzaRomnWtZ83bD/rQtJooP3kSWRtoWRNCAZUSrdE3mdL
Pef4aGpICArMtjpa1LG/aYyE710PkgpWEIePKxzXzGy44rUAooMfS/CZhqPUz/JN
1Epg86dy4kpaTlPjT81xwCIc97gDYlKu9i6cJXpX5/1q37u0FzYVqfzbn2KdkLyn
oc8gUWCUPLlrkbs5dWnybbsSLShndCdsV8KG2K3Q0VbklRel8KdzLUxXrLX9VTpc
zlQQZ6VweqoQv+nFeUvjzkRBw5vzFg==
=otkS
-----END PGP SIGNATURE-----

--Sig_/D7vz6JvMrZ1rTxlL2.SrTB8--

