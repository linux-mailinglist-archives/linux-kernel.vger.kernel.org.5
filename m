Return-Path: <linux-kernel+bounces-94708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCB8743D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE041F215FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC361CA87;
	Wed,  6 Mar 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NhEPqTgf"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C71F4E2;
	Wed,  6 Mar 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767421; cv=none; b=ZsfQT11XMdpeSQTYz2G4YAN/NZ5m8RMTloGNLcY94C5LCij+wAfIbyQwpwPOe2UhF+Kx3znuWl9+zEqSBcLdtUomZ0eIr4lfpG2c8AFXAKmenKD25sdBxMNyzbiV3p+HkyKHNiNOxdRqY/XRGpa/G1W2h9LC40GFFSRJDw8eaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767421; c=relaxed/simple;
	bh=iz0MmE5ufz7Uu0Bwr1nuZDuLAnvfNg4CBcrYSwQpOQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KNt1o2pJW6gKgy8uEN2BVKAFXUGr1PF7XBkKhGJhe6Dh/5FKJs0hznbf+mzRnG5wSkwqGfJNpprq3w/Q5qYulKmyVnBkF8O4aA+ZKrrDy/0fhJLKKBYLFFgGLIBP4p3rmYVmlIrwg7dk4giSjw3JXI0QyZ2+/8PXZdrFQHLuI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NhEPqTgf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709767415;
	bh=FZXeQEIdwXlGJvA07K9m/Cro4xP/ThwWpwE1wnciCRk=;
	h=Date:From:To:Cc:Subject:From;
	b=NhEPqTgfJm//YA590y4qlWjv0EyMLWR7d0cqanL0R6ktRTaaWN3O/n++WduUnBMGA
	 rf42koV3EAwHlklIbUDUv+43sKVSnl+i844d4+3+h8XhvHQimix4PeCgJj7uNubaB5
	 0zYFB+b3m4LA5frLnLB5UI74jzI16iv7k4Rmb9yCrrsECSWLk+i4S+rU7H30106PTL
	 hta/MaVPI8XRK71gdv52rogTUtqZ7DH9YVPPEaoxkF7EiXgmICj0KWvsKORlsaWVgD
	 pA/o4YwOAKUu7MYNlb02CA2N09a6Lr6IZy59bBUtYLAdZERFkLMC7ewTCx+z/3VW4Y
	 HLkfa0QYLrAjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqpQZ2NC4z4wc7;
	Thu,  7 Mar 2024 10:23:34 +1100 (AEDT)
Date: Thu, 7 Mar 2024 10:23:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>
Cc: Jeff Layton <jlayton@kernel.org>, Jiachen Zhang
 <zhangjiachen.jaycee@bytedance.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the fuse tree
Message-ID: <20240307102332.6793fbc7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OjKIYfVWi9M0_=J15R_vwgl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OjKIYfVWi9M0_=J15R_vwgl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/fuse/file.c

between commit:

  8a5fb1864313 ("fuse: remove an unnecessary if statement")

from the fuse tree and commit:

  9a7eec48c971 ("fuse: adapt to breakup of struct file_lock")

from the vfs-brauner tree.

I fixed it up (the former removed a statement updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/OjKIYfVWi9M0_=J15R_vwgl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo+vQACgkQAVBC80lX
0GxOoAgApT3//cFPYBH8ThTsUfBiE9XTLfR3uqkyr+uyt1xgD6oTk1Xcz/TqqpzA
r7Jkfp+ts5o7FTQi3jVoXBxNOu/3vgMrx+NJbqSuYOgn9ZmgSiT+rnc3QV855+bX
shjczBDu4a+1/3a2IQemTPnfXJDE5agNfTYIZx8WsxOQ+7Q1xtKCxVhB3G0LIAzb
Ax9/imt/XBS27AgAKfdS6Z2QRKY+TG/rpxZ1Mnr/PmbjWienZWlLcLHkuoUxovo5
3bO2KtB8TJB+I//6TcambXpcHk6X6LIkq/LhxgvSgOrD6azSfELFJuaQrIP4c37y
gJir/cq/chWJS/6xFM9WhBCPi8C6Dw==
=clP9
-----END PGP SIGNATURE-----

--Sig_/OjKIYfVWi9M0_=J15R_vwgl--

