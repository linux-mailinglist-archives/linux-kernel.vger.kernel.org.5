Return-Path: <linux-kernel+bounces-55935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7F84C39F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59D728BDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BCA12E68;
	Wed,  7 Feb 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IG98X5p3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD41CD21;
	Wed,  7 Feb 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280510; cv=none; b=Sb2uXlZ/ka27NQ4NFPF9zUQpk9DHx+Z1Wm8KlRF/3MQWY6fJq3hnjQp6ZX9dtzPTfbBnVIkrjoW+q57yo5G72G3Hn/1I8X04DjPWEBP0v03UQjy0tmacP5FL37D09zVatqeGxH9dfowL69FXYyO/tt5rVz9mxqPwtJ//9Umqk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280510; c=relaxed/simple;
	bh=qJI7eNzmomK/NonfnHIZ3Nz1afIhuI/SSIjQfFADE2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lPF8rZvnFK0Khrl+p4/RZChc2Oz98zNMnquMTOUjx+9l5PIiJYlrHJTde8J+TqE+OSBPdXQ4u4jweGSP+Xx2D9HcjFAZYa0sCuCQvkoOQX7F2hh4x/RYf051i23qO+ZgYg9mbxlRLJQ29DXgUKr2BgqdeMKb8BnOeSYwa5C/0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IG98X5p3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707280504;
	bh=z9YwpF73pwWl7HHYVgw39x1Dmvsg3FtzgmklIGeR/Z4=;
	h=Date:From:To:Cc:Subject:From;
	b=IG98X5p3/Ehyjs5K5dtTlF24ecrtUHZsUV1s+Iv9dfN4M5sTwqtUp+QYszveQh8Vs
	 OvPt+BWzshGZ1JUgqZ6LSXukaPGSrq2c2+p41qjlPrAkcmtAzvLq5+h60sahmPRKTh
	 uk55eRTJqm9iI65Zdfp82J6vBDshU/AttpQQQggCeTDEhzlJXQz96pMWRE/1yetZ44
	 D3AXHn7UuI+6cB/23tpkEt9HJTWUWG5i2OMCGN4al/RNC0/QVtCwzBSxLm7pn+4aYt
	 AZEy5GNWadNrXw2hNEdFl2ipRO5VzszrPFKYvuEaAMS6TfxvfMBQL6v3G3U5kXodcP
	 7yHCm/zHh0qyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV6jL4qS3z4wcQ;
	Wed,  7 Feb 2024 15:35:02 +1100 (AEDT)
Date: Wed, 7 Feb 2024 15:35:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Jarkko Sakkinen
 <jarkko@profian.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Roth <michael.roth@amd.com>, Tom
 Lendacky <thomas.lendacky@amd.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the tip tree
Message-ID: <20240207153501.2c575b60@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A_aqSM6/V3s=i1Z7iKqJY9o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A_aqSM6/V3s=i1Z7iKqJY9o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  arch/x86/kvm/svm/sev.c

between commit:

  1ca5614b84ee ("crypto: ccp: Add support to initialize the AMD-SP for SEV-=
SNP")

from the tip tree and commit:

  cc4ce37bed85 ("KVM: SVM: Set sev->asid in sev_asid_new() instead of overl=
oading the return")

from the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/svm/sev.c
index f99435b6648f,f06f9e51ad9d..000000000000
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@@ -246,8 -254,7 +254,8 @@@ static void sev_unbind_asid(struct kvm=20
  static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
  {
  	struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
 +	struct sev_platform_init_args init_args =3D {0};
- 	int asid, ret;
+ 	int ret;
 =20
  	if (kvm->created_vcpus)
  		return -EINVAL;
@@@ -258,13 -264,11 +265,12 @@@
 =20
  	sev->active =3D true;
  	sev->es_active =3D argp->id =3D=3D KVM_SEV_ES_INIT;
- 	asid =3D sev_asid_new(sev);
- 	if (asid < 0)
+ 	ret =3D sev_asid_new(sev);
+ 	if (ret)
  		goto e_no_asid;
- 	sev->asid =3D asid;
 =20
 -	ret =3D sev_platform_init(&argp->error);
 +	init_args.probe =3D false;
 +	ret =3D sev_platform_init(&init_args);
  	if (ret)
  		goto e_free;
 =20

--Sig_/A_aqSM6/V3s=i1Z7iKqJY9o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXDCHUACgkQAVBC80lX
0GwG0gf9ExbnjoE/XTjiMmZ7JfLwh+GLq11VlGyW51dsyURCw6jK1lt3ukR6O387
DolkQJeb5U52V7U+weeDkoCZhNGrXjovnTXB+0CKOXno7yunkaPk6/JTk44gWC/i
/NgoRwRAerOrhfa2ayi7bQqSqzBu2KZXgmWmcPcWonZ/N0gsNX4r3e1bUJrDDhgN
ka2avv+G491ypfp/iUtzJ7PwrqwAVMOnJ4+iDgKpgF80XMuvGKmcMPv6tZgvmeMm
DO5y2uneYY7PsqQ6GidOts2gcH6KDYyNU/YbD+xSznqx1AgcvMl9N9fPT8FZnjah
S9oxMhOg7sTX+nRJ4t1n6zuGuRKouA==
=cSPR
-----END PGP SIGNATURE-----

--Sig_/A_aqSM6/V3s=i1Z7iKqJY9o--

