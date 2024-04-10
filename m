Return-Path: <linux-kernel+bounces-139543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB628A042A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D022428606B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C43FB1C;
	Wed, 10 Apr 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kr4LjhKz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6014A8C;
	Wed, 10 Apr 2024 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792591; cv=none; b=Krqb5K76fG/UYHwHsR++cpYzxKxTSptkux8M7bh+uTe4RNBeh8q2sU8E+B2mkq5osZY45aAtXeWRAZllJ/Zqcn8bU+/cEB3v9TAIfAkpZHxpCLhomu1gWMTiHfWB56DRBFjoU+SUylad9hhS9gNpjPQkX+rbO/VZLPNda30aNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792591; c=relaxed/simple;
	bh=Wlf9g8GOb1r5jWi/A0508ZHQCI2O7fau5DNZ2cowtPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PGgO7xr6HVZo4dF6sP6Ur9y23Hq26kVnBKLA6R3l53lIUKH+kh0PU2mhzJLjL3lNKqLyA0+L2B4yZ0HrWBSRIC6rwAbjJXUFy4h5fft9E901UWYTbnacZrhH418ss21m54zge7DYaSJxjtL9qkeoWsVnD6j5zuGDWu2mjLp8y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kr4LjhKz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712792579;
	bh=XQ9C+k4eCZlfGEat901NgLTAkMpjN889F56O5XotGGo=;
	h=Date:From:To:Cc:Subject:From;
	b=kr4LjhKzM4vTarW3Ws6SDCnByN+bmJvG3MJ3mUJMFqWBUkuEuN8258D44UTW0djxj
	 LTVMdPcrg4WXmrGKqsiDcOaiCVvLC1Q40DtJU6r7CsCueXNAV7ELcIZX+0yNNKcPZr
	 SFkiF6FqlP/bCwQs04oxiJZKWGcRDZIEX+2pwEYKSt3D2oYyI/gcbwbCQjKRyKgtlu
	 j8gjm/Ep8wFfc1VbvnXVCwdWZI5tJBY983iVobn1vLsv30oboFstUxsDbHpzt5DLSw
	 loNNjp1+sPduLLsf6IJ/Ip3+4JzCZ+ls+Eh48kfni+mxZceUdVws5wpRQahpDrUiaY
	 +4oerxKPW9qmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFKBp4wGKz4wnv;
	Thu, 11 Apr 2024 09:42:58 +1000 (AEST)
Date: Thu, 11 Apr 2024 09:42:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Bo-Wei Chen <tim.chenbw@gmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Gary Guo <gary@garyguo.net>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with the rust-fixes
 tree
Message-ID: <20240411094256.08b7d7b9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j3jeFoemNYZhHS36v_A4BYF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j3jeFoemNYZhHS36v_A4BYF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  Documentation/rust/arch-support.rst

between commit:

  01848eee20c6 ("docs: rust: fix improper rendering in Arch Support page")

from the rust-fixes tree and commit:

  81889e8523e6 ("RISC-V: enable building 64-bit kernels with rust support")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/rust/arch-support.rst
index c9137710633a,4d1495ded2aa..000000000000
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@@ -16,7 -16,8 +16,8 @@@ support corresponds to ``S`` values in=20
  Architecture   Level of support  Constraints
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
  ``arm64``      Maintained        Little Endian only.
 -``loongarch``  Maintained        -
 +``loongarch``  Maintained        \-
+ ``riscv``      Maintained        ``riscv64`` only.
  ``um``         Maintained        ``x86_64`` only.
  ``x86``        Maintained        ``x86_64`` only.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

--Sig_/j3jeFoemNYZhHS36v_A4BYF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXJAAACgkQAVBC80lX
0Gw5qwgAhbSjB91yM5sV+T1z80tkKLqH/cQ2j8bL97C4nttYfu70UG8unMvY2SbB
JXDfjctttZuvZ9br3KImesadu7+ZO/mJ93P8ZdEH/vomvqwWu6oGONilc9WxSKi2
P+7RIvnYtI+l1q92Fh4//33ajVG1m1vRAufUvRMk3FPLn9CEs5wGJu/OjOW2kTPc
NZLh4HAGOzU9xAz6eU+oSxTvDmfBcIrkTTG0MExnCIU/7mgENzRH3HK5b3KOU6nn
L0q40oPD8JNAGehmN0IAfyrge3w1IYNx1ae7PFfTANAo0x+PJ3ZIwTshXHFWc1Iq
/hRxPEoPDtjRBQUfM6N2oXSHR2GmtA==
=Ay4c
-----END PGP SIGNATURE-----

--Sig_/j3jeFoemNYZhHS36v_A4BYF--

