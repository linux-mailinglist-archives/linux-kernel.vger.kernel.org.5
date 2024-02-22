Return-Path: <linux-kernel+bounces-75843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB485EFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DCE28196B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3C1754E;
	Thu, 22 Feb 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZGHPD41W"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B788111A1;
	Thu, 22 Feb 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572049; cv=none; b=WfrWfugEKH6ZsVv99KVZjxPg7KuYmpog6mmMpcjmeO+CFqzyJQ96y2kT/bepNj8uCDy39gcHsY5jU65Kb/RWTUF0Ni9WUqn6AXuWIG23ovMkjI9dXrPSZK4q+mtTFs2oj9s5VCg8J2wSTYwZFZaNSsLfvuQbbBWInCxXV0ouQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572049; c=relaxed/simple;
	bh=IQ0ZMvLgOUxRopPeocg673eNhzfHGAiic6IZwBbhKNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dctj9v+2AV++60vmUtmUnUDuImnAbQOtid0qPxZSgIvPDQsXIGFWJTBg3kV3cxWJ2mxAG0/ll8DnTGHZ23ySFtFoWiQ2fDvR05og3xWUuxq15zF16VSGEUk1zRE03g3at2jXiWwqqlKe+F+G6qq+rTOspiXwBFikorH4lzP0L7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZGHPD41W; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708572044;
	bh=oBSO6ysOSxxXiUfgyhcUecXa9K+EP0YyTafSTYmTvms=;
	h=Date:From:To:Cc:Subject:From;
	b=ZGHPD41W5HAuQ1qTji3ozalkxA7m1nYjnp4h5MbhyTlW/4vPB/qROt0ff0KFaK4XR
	 4ss8+0hxY5m6ydRx9za3jtX8H4a/WiCH40EeKm3S6Rpqmro35bPmv2Pj0QeMEqYfNx
	 hsWhy/PXZecq12ItXsrQ+hOhv71dE+F2Hs9mE9DveJ4aZ8LGMXGaf/zfaHqJbGPKwd
	 sIXs1NO0SJ27Q852bjasftcRr6h6eNNCHX1BqqDdGie3uMxYlb5VhVDZhVOCYky2e1
	 GjMRSd4j/9FeOnYyrRpvicr9W/ClgYLN1LiygAGIwc71MAT4+2sCAv0RQ/4uXn7AVc
	 01+mCVQxp6G2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgJLf3xQDz4wxY;
	Thu, 22 Feb 2024 14:20:42 +1100 (AEDT)
Date: Thu, 22 Feb 2024 14:20:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: linux-next: manual merge of the edac tree with the jc_docs tree
Message-ID: <20240222142041.34342553@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zU8aYJJPKg0ASmlJ9nmc7mR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zU8aYJJPKg0ASmlJ9nmc7mR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the edac tree got a conflict in:

  Documentation/index.rst

between commit:

  9ee367809c67 ("docs: Include simplified link titles in main index")

from the jc_docs tree and commits:

  1289c431641f ("Documentation: RAS: Add index and address translation sect=
ion")
  0e4fd816b08e ("Documentation: Move RAS section to admin-guide")

from the edac tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/index.rst
index 429a407470c8,9dfdc826618c..000000000000
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@@ -112,8 -112,7 +112,7 @@@ to ReStructured Text format, or are sim
  .. toctree::
     :maxdepth: 1
 =20
 -   staging/index
 +   Unsorted documentation <staging/index>
-    RAS/ras
 =20
 =20
  Translations

--Sig_/zU8aYJJPKg0ASmlJ9nmc7mR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXWvYkACgkQAVBC80lX
0GzlUgf+Mqrx36oqhJE2739fYlkK9j9PV6lbpYiohSqDp4Iku8wNB7YQjof67VBG
k/iK1Z4rL2K/JYS8klwlRo9yLiL3SttjKFdmTdPGHCBzCe8c5ZU4cNQWhL+ZjmqE
P+ma5rs9Xp7+QYGSSxIuCFcvEcl5ram6aTRS3cMhvxj4FC5ZoDnNleiHQnXzrLB9
4qKn1fWIIYtI/nrlkoxo4yPstIjQkjZ856il2YUge0klCdJqalESEc5CiuA2jqVf
QIh3vfvozVvFl1o5A5AAmY4OlMEmHaH97U6sl9cR+KUwnfivpD1obRbYl7eRgWvT
//fOQo3ZPfmpBNMNU3OQOHSqZAcBRg==
=VrXX
-----END PGP SIGNATURE-----

--Sig_/zU8aYJJPKg0ASmlJ9nmc7mR--

