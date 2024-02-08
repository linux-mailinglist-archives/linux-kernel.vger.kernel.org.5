Return-Path: <linux-kernel+bounces-57371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921D84D794
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8381C22C33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6236113;
	Thu,  8 Feb 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b5lnIEIn"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4201CD19;
	Thu,  8 Feb 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355831; cv=none; b=jW7y5SP85li4WinZDkiV5b7OLzMWKhGExi7cuLqE1a1gjEfHvkhPcNZ99Q3XBJrNdSxP4kxuVaMbPecXlof2h0hTG9s99NZjkPsUKTQAcjSSJVHegQaGQ63GA/6dLoBeobKV3JmDo+GsdabuZTtWm5PzNeT/a3cyt7bRlcadGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355831; c=relaxed/simple;
	bh=muz7Bui59U4LNvcntLNkBS8HDXhspLwGzQwrxYYzZi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=p/ci6nqlX0mkoXyjd3coZtqqsxVKnIl/OtjNsenPBDDZJRz4SwB5mv49NZiqo0LzY+OJute23utlE6AA/JhGffmcEtlUHFT5int5IqZkhNccdDTo8ll/tsmXfUahDFjGjhKV3M3qNJysa9P8CBFpzqcHw/EGtJiCGu9blOKu1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b5lnIEIn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707355826;
	bh=hdmd2hgEp/CWvvERaKzFlKQcnW3ajQj+e4t2lGrolTQ=;
	h=Date:From:To:Cc:Subject:From;
	b=b5lnIEInxnjfdNPfaGUWqhToOGcRFBCZhWzMv8KOSEZUxDDcwqsPFQoohpi9zd5bQ
	 rzJasu/TR9MugR9V709RS806bLmPWVxIh9ddoTZ2Qj2DdrMy5VHjOdNcYv4qxOl2Ma
	 OWMDrt6inda4BPgupOIUncFZSkUIzNLXFdttoE0asxHKVZOVlDtRuLHYJj7JoJoGO5
	 i247oDdf0cfjLCF3zS/dLshHSK9YcB9TUZ/f4sutlKo1Lmq/H2t4R8G5Y2nIaAZxGF
	 b2DLWELQnfzouRM0QMVERsElLVjMAYY68nGdXm343+PhVOkUSrrJQsRb3vair0II67
	 rdPBwUHMxt1aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVfYs2J57z4wc6;
	Thu,  8 Feb 2024 12:30:24 +1100 (AEDT)
Date: Thu, 8 Feb 2024 12:30:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20240208123022.272f57bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XuVZMLCnqmZxo2P198xFIFs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XuVZMLCnqmZxo2P198xFIFs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/include/asm/coco.h

between commit:

  e45964771007 ("x86/coco: Define cc_vendor without CONFIG_ARCH_HAS_CC_PLAT=
FORM")

from Linus' tree and commit:

  1c811d403afd ("x86/sev: Fix position dependent variable references in sta=
rtup code")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/coco.h
index 76c310b19b11,21940ef8d290..000000000000
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@@ -10,9 -11,15 +11,15 @@@ enum cc_vendor=20
  	CC_VENDOR_INTEL,
  };
 =20
 -extern enum cc_vendor cc_vendor;
+ extern u64 cc_mask;
+=20
  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 +extern enum cc_vendor cc_vendor;
- void cc_set_mask(u64 mask);
+ static inline void cc_set_mask(u64 mask)
+ {
+ 	RIP_REL_REF(cc_mask) =3D mask;
+ }
+=20
  u64 cc_mkenc(u64 val);
  u64 cc_mkdec(u64 val);
  #else

--Sig_/XuVZMLCnqmZxo2P198xFIFs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXELq4ACgkQAVBC80lX
0GwtfQf/RhHu9/gcivmHMxnyXeUhtCcPlPvzLuou7c7cfpbMaGLmn70w0gCN/F14
dB5I//tUDXUnQHti4rrCTOTKrGzcWDxwMH96RWNp4lFWKpyTDmEqvR6eC9pLavTq
gcGAP2qRrqRjIi9/hI3lXP9IGXdybIBWRLDjlxieUubsezjJw8CuBjjfIL1+NRJK
SicGpbresO0AmT/J7UWwo05VBElefM2PL4cTHO+SUWPIwK/X0nZHY7Uy84sXmO5t
szWTO4VmWJz09hpWMWqpyO1u+w79m00/ObdeQiw8+dILJ8NRwFtjhXpxvmOxX/fo
ir5RHaB+lRmUKvD4tugH8LwhHcSF5g==
=9k8H
-----END PGP SIGNATURE-----

--Sig_/XuVZMLCnqmZxo2P198xFIFs--

