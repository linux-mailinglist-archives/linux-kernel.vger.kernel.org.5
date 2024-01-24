Return-Path: <linux-kernel+bounces-37797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375183B58E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71351C22657
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E632136666;
	Wed, 24 Jan 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dpNIy7eC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A412BE97;
	Wed, 24 Jan 2024 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138626; cv=none; b=LnjtBtKehgbUm/voSUTX6aFUDkC/tDbeQVL6IhEx9219bXzer0vjYSsJbMrxexOKkesnA30uhDLD68redGA4BDrn9atZYi0TrsAQjCVXN32QzkssiFR9yjpI28NKiytUClHQnoEMb/UO0937kx6CHNv5gIp7inmc0V5CSv+z4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138626; c=relaxed/simple;
	bh=u5B2VE4u4ABSVPxnKB6KqdGSyAr4IT2Dlx50a65DClA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hZixw500D7PTkwvKofFAwQ0pUSkTlCC9GyASWtPsEXrU/d/oZ8wk3Zfh8UXKG8Hlwvtl/cbkl5Ye9aWHgNLi9OLyV2KuMgklk/+SiYMp1WMkIxgtt3audGvKGeaf69arkKTqFqb2PtOKq8T76b7arRkfUNlUoui7PQAlwVpIf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dpNIy7eC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706138615;
	bh=x8eIRKNYdF+5HBm++fuUSbMGNNhIF6Q2DRYnZpGEVAk=;
	h=Date:From:To:Cc:Subject:From;
	b=dpNIy7eCTafiUBmvgX+bf3OoVPHvJP+1FWOW03qsUXGaLdb27YMzvEdNGc8gz53X4
	 s+U3spltwCy4p98YCqhAs70QUmOD8/C62r318ISmDGx+4lsBZECCpp56iFFxgkVz7j
	 sXOQ6AzEW4C2o7NWlagb16GXh614g0uR+g5SABH0OPPrzVkRQPWwYA35a4QU6D10Zj
	 i/glY/Xq7Yxy0eFNZmqcWHWNP/H2kYgjx0EcQzaFmdpvIxTjBoGL9M08x8YKsIASVm
	 ZLXqeIXf/89CONAE18Y553Wse4X9cLgkWH1kJSgis6K0xkPnk3WOTTWKnGE50Le5P0
	 weHyuwuBUklJA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL0Py6Z9Nz4wcJ;
	Thu, 25 Jan 2024 10:23:34 +1100 (AEDT)
Date: Thu, 25 Jan 2024 10:23:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240125102333.6701aa08@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Prsahim64JxKlDIN+=xOm.9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Prsahim64JxKlDIN+=xOm.9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

make[4]: *** No rule to make target 'kernel/elfcorehdr.o', needed by 'kerne=
l/built-in.a'.  Stop.

Presumably caused by commit

  1777bfb42f56 ("crash: remove dependency of FA_DUMP on CRASH_DUMP")

from the mm-unstable branch of the mm tree.  It looks like the expected
file rename did not happen.

I have applied the following (git) patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 25 Jan 2024 09:58:54 +1100
Subject: [PATCH] fix up for "crash: remove dependency of FA_DUMP on
 CRASH_DUMP"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/{crash_dump.c =3D> elfcorehdr.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename kernel/{crash_dump.c =3D> elfcorehdr.c} (100%)

diff --git a/kernel/crash_dump.c b/kernel/elfcorehdr.c
similarity index 100%
rename from kernel/crash_dump.c
rename to kernel/elfcorehdr.c
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/Prsahim64JxKlDIN+=xOm.9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxm/UACgkQAVBC80lX
0GygPQf+J9cWCByRYqKmzZKMU033t515y4zmjieSlRos88nnawAYsTEGgcbdU841
4oXJgAiRguRNAIocyLU67LBmnpQAFW6xKLzUU2xtpdgN5e9k8A08FJtMqsWcnvdN
6IlFCic7GcW22FY+NYQ5sK2V44zmOPQmhBsqa8G+i8hEJT0RmD93THQ1Y6f5drQ1
8pvei8ajGofj0xtErRGrLK5macxivy7T5j3P5h8mJ9NRvaken3ATn1QPupsp8In8
Uc2bDN8NfDeUllIOeUOzaxiynnjYcmrkJpbiXGlSb5TRvC0aXVrOmbL/2YT9ui2g
47bki6QeDvtODJY/B9ZaoKWwu1c5Hg==
=LhPh
-----END PGP SIGNATURE-----

--Sig_/Prsahim64JxKlDIN+=xOm.9--

