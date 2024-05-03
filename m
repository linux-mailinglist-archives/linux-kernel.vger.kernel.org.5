Return-Path: <linux-kernel+bounces-167268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76B8BA6BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041E81F21F69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BEF139CE6;
	Fri,  3 May 2024 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EXeA4W6Q"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E7224D0;
	Fri,  3 May 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714715544; cv=none; b=hlGD3p74xdMdGvfCUDAMPQzJrYUS1V31x94tHpdLahu1ZnDu1gTyn/5SBHuo1YFDfHDI9Ls10a2lTWF+nvccyFrVxx4MABFaVt9OUXPv0ND7/agBP0X/Chb1DODaYYxlCV/y3obBnTxyXRy+fuU/JQx5onQtIXdWmVKBxJf+OwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714715544; c=relaxed/simple;
	bh=9pv3EwGTx9i7Xe19e7suJEgQc428qtzwFanLLNFw+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o50huTUP3JwzTv7svF8TYNlKQtysyUFBJ1u98SoRzfExa2Kzr8Deiy1ivB/O+OF1VroyzRI6t1Qwqa4QmIV8rviOlyO/9lcCWbfDv9KgWDLaR4MYmf9ZkjcKRl1XqseFEO1Cq8BfOh/mCv6NsQcz6VOgZljL6EaaXCIjv2K9xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EXeA4W6Q; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714715538;
	bh=vzGaRy77es6ENVr8TbEtx4fxiipOa+6iUF9HSYhMIzE=;
	h=Date:From:To:Cc:Subject:From;
	b=EXeA4W6QFhQvfZoqf+e6Z/UexqHFyiqpghqJakTDppDlG/sdK9INvhoAGs0Xqly+V
	 WetBTsxqwqLGgkHxSmFouSEMUu42LJxyFzFrQfPqtj7cCiNOXrPD8fKLCnMi4wZHoe
	 9Js8OxAzeVvo/uz6R32SI+WoxkgbKUIIFHRNPPshGHWkcg/m15OCx70pNt5G5HEP0u
	 7NneeNgZA77OMwXMl/Kaw/c7dMrR00LedwJR9wX3GzrFdWnQaZKdiDGdE/R8iizCTK
	 etnL4R8jlRllPG2i8zFnlhb/VE/L+2va1e+Ini9MBqawQ+6ceVAHih+RHxaTPQXnBN
	 srCkQce4i0eyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW0Lp2wf1z4wck;
	Fri,  3 May 2024 15:52:18 +1000 (AEST)
Date: Fri, 3 May 2024 15:52:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yury Norov <yury.norov@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the mm tree
Message-ID: <20240503155215.22466d02@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YZV15e6mYmmMAUJv8W==.nI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/YZV15e6mYmmMAUJv8W==.nI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  include/linux/bitops.h

between commit:

  120c5991cbae ("bitops: optimize fns() for improved performance")

from the mm-nonmm-unstable branch of the mm tree and commit:

  1b6ef2812522 ("bitops: Optimize fns() for improved performance")

from the bitmap tree.

I fixed it up (I just used the latter as it had a more recent date) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/YZV15e6mYmmMAUJv8W==.nI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0e48ACgkQAVBC80lX
0Gz5Egf/eYAbNTYsz/C3Kc7MaH8QeQ/NEeIbg0h2DEjLMVw+Pq7svMNoDfWGRVF4
juGqithBjsasmEXIgwbywbHDV2/qiNwyx7e7xOEeNiMfyYQYG+FwIUg6Ofb8CMd3
1xKFutyurfwBSYQ/k0gKiirgFturj8Rl0Qooy/88I1zWzkGik31IZxNeQjmHrIdw
JBNwD5fSjVAdkJJdzYxrX+USnmTU3J9EqkwaISz6hnVd8HikH0MF2IJP7MRD3RbP
lUxJBd+8SCxwnq0G4GlK0tC3zQ6k5EgtFj6i5y2EIBx8YqzBg3oDi2ej4jc2mm6Z
MIOsflMzsMJQM08ItrH3HhT42a4OOQ==
=L3us
-----END PGP SIGNATURE-----

--Sig_/YZV15e6mYmmMAUJv8W==.nI--

