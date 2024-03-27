Return-Path: <linux-kernel+bounces-120157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F288D362
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287B51F3AA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BAAFC19;
	Wed, 27 Mar 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c7OTPha+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAE2F50;
	Wed, 27 Mar 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499357; cv=none; b=od6BNrrv6//UojVEpUBtKMplSMoTHdG1OXaXm5UjAB5oOKMSV454HbI6rt1OlOxG6zLaIDmJ9lhUGXTs48f/edkGdREyzYig6ipNtdX1sVMG3l3jKYsPg9Ue5z64Va+lR00wCnQRA/a9pY6Aal0wTiiGeEXgy6PcPyH8RLX7nKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499357; c=relaxed/simple;
	bh=1j7b/9QOfiWV26BYUU5t+w4EZQiMQ8zLGxoOaBYPIWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oW3/ByPFqILhoEclI3o/bsWW00B4p41DsaNSL2zEVFQNuI6l5IGXKVwfwCxqIiv2o+HtCGxPPbH6E/pDunCePbL2dz2cEeCesGFzF9nBsZTyXZOfuIqf+rOYrLhnY69l9BImzeS9cYDbcOZv+i5v1zVH0e/uox4k6OwlQgLBaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=c7OTPha+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711499350;
	bh=KQ6k/J57X30/DQPmTSG0fUfoOiquKQ8alEoCBJWeExo=;
	h=Date:From:To:Cc:Subject:From;
	b=c7OTPha+DXyFX7K/gY8iKn2zVbLX3EKsV0OOpYISX33TSJVIU9zX4FWBW4Pa7MV+m
	 d2s3CZNX5A7+ZYZLRd5Tp8BmAZzUUtUe1kzASD2ceGBqhh4fFR6/Fo9LFWWQHQDCyA
	 tvcFv+rlRoFJoF1ZIAB1bEz2PYqfuKfh1CromOswcrXTDd2ZnHnsrF5WfLHwLkaSEu
	 mc0j3gSyhooA8lSBJZKRu/MvF7OOAfhERYJlpp4lYvquPS1R/Nf/6lbn93LuyE6m+A
	 RPJhF1NstzcX7sp891lKXvw7ld9Klyjf3WKDaUjHl2ZEfnrDxvhTm3nEAPSWk0uN+S
	 JEpx6JXCz9gqA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V46x132Rbz4wcF;
	Wed, 27 Mar 2024 11:29:09 +1100 (AEDT)
Date: Wed, 27 Mar 2024 11:29:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anup Patel <anup@brainfault.org>, Christoffer Dall
 <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Sean
 Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the kvm-arm
 tree
Message-ID: <20240327112907.33cd9bb1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vvn7PGP=2RjBf5VVyLbFnIw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Vvn7PGP=2RjBf5VVyLbFnIw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  tools/testing/selftests/kvm/aarch64/arch_timer.c

between commit:

  29b0075ed61c ("KVM: selftests: Fix __GUEST_ASSERT() format warnings in AR=
M's arch timer test")

from the kvm-arm tree and commit:

  5448d9282af5 ("KVM: selftests: Fix spelling mistake "trigged" -> "trigger=
ed"")

from the kvm-riscv tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/aarch64/arch_timer.c
index 93100b3f1312,16ac74d07d68..000000000000
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@@ -135,8 -135,8 +135,8 @@@ static void guest_run_stage(struct test
 =20
  		irq_iter =3D READ_ONCE(shared_data->nr_iter);
  		__GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
 -				"config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n"
 +				"config_iter + 1 =3D 0x%x, irq_iter =3D 0x%x.\n"
- 				"  Guest timer interrupt was not trigged within the specified\n"
+ 				"  Guest timer interrupt was not triggered within the specified\n"
  				"  interval, try to increase the error margin by [-e] option.\n",
  				config_iter + 1, irq_iter);
  	}

--Sig_/Vvn7PGP=2RjBf5VVyLbFnIw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYDaFMACgkQAVBC80lX
0Gxw1ggAinEtAG0d9NNLM1EX3ixxsy+EO6hgm0TP2h3HjWF6zVl9+K8fBsRriMkd
SwPepJ9hjDLeL8AZD/l9nvpPh+uB9QzSz/JZdm7YST/bTDm5iSsoOvRvPexEUV9O
oEnDWKexEc78YMzZ+xpdJqBTZgZCFn8ajBI3czK2NA2fVAxL9DoZfLUGlHpwjLXx
kxECuQ7h8T1NxJ2M+ushNDV3OwOZ9/lMnuObhbPEX551BPfcGb8TWEcly1m+/CUm
XzVCs4Mfo1KmbH9h381R91lroJcMUi682VdP7z0Bm8w31L58NrJBoYvsMFDpnDQ6
PZxsbfm5D69Pk/Wk7QnTFmDWVG7FxA==
=uLHq
-----END PGP SIGNATURE-----

--Sig_/Vvn7PGP=2RjBf5VVyLbFnIw--

