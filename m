Return-Path: <linux-kernel+bounces-82430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9A86846E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658521F225F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32913541D;
	Mon, 26 Feb 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TQV3JW4O"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F621E878;
	Mon, 26 Feb 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988627; cv=none; b=m70k9nC7Tfoy+7WoVVh7yYLeFR8u1trcCwGvtBo/Qsz+7uQCJjsrK2+3C54jPjUXLRCMfuB0xTnHYBJFfpzKUkSwqVfzTyW+SvG01USfVWQ+4vnmFNzJl7R2WDPjz11DrCSE+xvqNBOBc4NIEHX3j1N3zmOgnBA19MVOhBhkoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988627; c=relaxed/simple;
	bh=JCo1qii8yFiXcyz7GwvVbZU8mdZnZAbkXKJprXLQXAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lP2MhryP2E2s2iXYQe1rj5HRKPZZbmy1KvCNDshB4X3eQYr+Z6QyhH+Mf+05tHDGQxqpEwC8yOPicsKMIlsBrj5Mj4KgFWWHCfv0qu1BI3jwhqukOfGxEyWbfTRW4fxM1FEwwOeKmMG8RKiy2ZPuwadDApHSeNmFbfrv/8qUiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TQV3JW4O; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708988620;
	bh=RA5pyVGVpeMHztHsPvWh2/DejPVZ4y1rM0WtuJXcLXs=;
	h=Date:From:To:Cc:Subject:From;
	b=TQV3JW4Ot6ikgvdNI/skoCi9CKJJlXjYHopvV1I3lqoz1bhSdy2D9zR2dMYUwq2m9
	 b/d/zwhDJPVypVzwcLmR/Lo0tf3AFW+UuX91IMkiQGqcInFElAr2ppCF2M+uEQTqxG
	 o5OKCgme12aTnKJzu34VAdZlZ6T1nzr8EXxiCmT0vKuQQ3LMsthQ7e6IVArvZFXPHf
	 LFFoF2XxQObtLudSxOf1ZPJQgBae6k2KF8xgbchYDbEEqdw/qWInwmggc5FZXBmQV0
	 mDuXtqNpsrjhh+MGpD7g+y35/cxBGHCTI+lqpCeqfZnrlxbpLOWLlR9N9fhzqlyqtb
	 XhY6xg2FyUFOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkGPl6FZcz4wc1;
	Tue, 27 Feb 2024 10:03:39 +1100 (AEDT)
Date: Tue, 27 Feb 2024 10:03:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Huacai Chen <chenhuacai@loongson.cn>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Jamie Cunliffe
 <Jamie.Cunliffe@arm.com>, Jinyang He <hejinyang@loongson.cn>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Youling
 Tang <tangyouling@loongson.cn>
Subject: linux-next: manual merge of the loongarch tree with the arm64 tree
Message-ID: <20240227100337.4e9b64c1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bBpqdYJovqmzVDa.RswQkpG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bBpqdYJovqmzVDa.RswQkpG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the loongarch tree got a conflict in:

  arch/loongarch/Makefile

between commit:

  f82811e22b48 ("rust: Refactor the build target to allow the use of builti=
n targets")

from the arm64 tree and commit:

  58aeb61a338e ("LoongArch: Add ORC stack unwinder support")

from the loongarch tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/loongarch/Makefile
index fa4fb09909ae,e3bc02fb7fdc..000000000000
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@@ -82,7 -92,15 +92,16 @@@ KBUILD_AFLAGS_MODULE		+=3D -Wa,-mla-globa
  KBUILD_CFLAGS_MODULE		+=3D -fplt -Wa,-mla-global-with-abs,-mla-local-with=
-abs
  endif
 =20
+ KBUILD_AFLAGS			+=3D $(call cc-option,-mno-relax) $(call cc-option,-Wa$(c=
omma)-mno-relax)
+ KBUILD_CFLAGS			+=3D $(call cc-option,-mno-relax) $(call cc-option,-Wa$(c=
omma)-mno-relax)
+ KBUILD_AFLAGS			+=3D $(call cc-option,-mthin-add-sub) $(call cc-option,-W=
a$(comma)-mthin-add-sub)
+ KBUILD_CFLAGS			+=3D $(call cc-option,-mthin-add-sub) $(call cc-option,-W=
a$(comma)-mthin-add-sub)
+=20
+ ifdef CONFIG_OBJTOOL
+ KBUILD_CFLAGS			+=3D -fno-jump-tables
+ endif
+=20
 +KBUILD_RUSTFLAGS			+=3D --target=3D$(objtree)/scripts/target.json
  KBUILD_RUSTFLAGS_MODULE		+=3D -Crelocation-model=3Dpic
 =20
  ifeq ($(CONFIG_RELOCATABLE),y)

--Sig_/bBpqdYJovqmzVDa.RswQkpG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdGMkACgkQAVBC80lX
0GzSNgf/bRR/GisK08NXhhejpfXnEhIPuPc16bAHR0u5RKaTtPu/opXD6NBPGDy1
HSo29bZjlsGyFyLv5X9PZ6dzxRWaca6CAf13RLGhe5L+81hl5h9zWd3zG5jwiA4L
asurjYCQHHsQGbtV6NGSYeSC00rQlI68mpRZt7qzfBuoRniu3vjJfq4W6Pqgm1Wx
WD3tDZxG5ddZfUr+wWLIOgZpgZpJlG4v/lq58+vR2lqFOIPsxdDeFL2PXNnth9uC
r09ITzA+gbz1l4p85kZQFvLcfBSUq/GwLuKN4dmmiz9FZ1pHTcYyivpAjNUMknvl
OniKBF3eLsm/tVeFYjPFjvClyFexbQ==
=paYl
-----END PGP SIGNATURE-----

--Sig_/bBpqdYJovqmzVDa.RswQkpG--

