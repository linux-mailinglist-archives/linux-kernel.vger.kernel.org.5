Return-Path: <linux-kernel+bounces-70667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3884859ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029551C20EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940BB257D;
	Mon, 19 Feb 2024 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tirE7gwQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BB1FC8;
	Mon, 19 Feb 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311493; cv=none; b=MW3ZY9eA4I5SCIzmCIB5Zky5+LlV1adP9IRtqSNVNDIpb+ZDZrMjYcUnPxo6yJTW1+MDvCme1QFGjn6/ec/vNvxoGjX3noLLYq6EDaaf8pvCkFgFECjMoFb9eD9tnZyumWRHCMnF4Re37PHLMV6Ehixx9pOefZRB2Vk3y5CQW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311493; c=relaxed/simple;
	bh=gctggYPLGlntgRouCIS1Y5xS9wy4M1dICUmfSMUaA2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VUdRpB3+kBR4sPJZ0/TJKQniuevH6zkE/dSzj26apPVGudwUaimCP+/sR+pK+euUAQbx1WQuudd2HecO7PLtnmrOFWDuWVP6maMLG7P5sBohVZijs19BSW5MSOxlhLEhRVI8opf3Olpg/FhSNgkGJfZDT+2ZfUTeOjvJ5OTOViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tirE7gwQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708311488;
	bh=7XaKWVD9KB3AwSX0RxGYmJEUX1mxEDnJZN5p2hnu4+o=;
	h=Date:From:To:Cc:Subject:From;
	b=tirE7gwQkigdBfOiXJLEWoOdlMv7xicMQ+bb8KwBI0l75izAOwmj+ROEHmIl/ZKdE
	 hqlrvppMFDuW4rCs5n+diq7qeGSS5nyfTnXfaWoYgMxcNP8NHtklGzy8TgftO41Kxz
	 GmKWlt82Uah4fykXuWZnuAbHPHm4zad8eXEkl4irt4d8KzzYBUZAlcljnEdDBKrFZH
	 7vFI1hyIlGaSeaHZwtUXZejUlA5uHfb+b02iyDUI1i2YKSxR4ZqWQFMN3ZRt1WN2Dv
	 4pnT030y9o2LJS1YKqltYqSCwv03x+mXrfXwl93nnRsB5mLtOPTnKWWRiRUKdVVqmH
	 k0CuP4d9znDXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdRzz2BrNz4wcK;
	Mon, 19 Feb 2024 13:58:06 +1100 (AEDT)
Date: Mon, 19 Feb 2024 13:58:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20240219135805.1c4138a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0lq+TnyNw/r+bgBwPDvE7v7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0lq+TnyNw/r+bgBwPDvE7v7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

  9cce9c6c2c3b ("arm64: mm: Handle LVA support as a CPU feature")
  352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k gra=
nule configs")

from the arm64 tree and commit:

  da9af5071b25 ("arm64: cpufeature: Detect HCR_EL2.NV1 being RES0")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpufeature.c
index 0be9296e9253,f309fd542c20..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -721,13 -754,12 +756,14 @@@ static const struct __ftr_reg_entry=20
  			       &id_aa64isar2_override),
 =20
  	/* Op1 =3D 0, CRn =3D 0, CRm =3D 7 */
 -	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
 +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0,
 +			       &id_aa64mmfr0_override),
  	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
  			       &id_aa64mmfr1_override),
 -	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2,
 +			       &id_aa64mmfr2_override),
  	ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
+ 	ARM64_FTR_REG(SYS_ID_AA64MMFR4_EL1, ftr_id_aa64mmfr4),
 =20
  	/* Op1 =3D 1, CRn =3D 0, CRm =3D 0 */
  	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
@@@ -2701,33 -2817,13 +2779,40 @@@ static const struct arm64_cpu_capabilit
  		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
  		.matches =3D has_lpa2,
  	},
 +#ifdef CONFIG_ARM64_VA_BITS_52
 +	{
 +		.capability =3D ARM64_HAS_VA52,
 +		.type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
 +		.matches =3D has_cpuid_feature,
 +		.field_width =3D 4,
 +#ifdef CONFIG_ARM64_64K_PAGES
 +		.desc =3D "52-bit Virtual Addressing (LVA)",
 +		.sign =3D FTR_SIGNED,
 +		.sys_reg =3D SYS_ID_AA64MMFR2_EL1,
 +		.field_pos =3D ID_AA64MMFR2_EL1_VARange_SHIFT,
 +		.min_field_value =3D ID_AA64MMFR2_EL1_VARange_52,
 +#else
 +		.desc =3D "52-bit Virtual Addressing (LPA2)",
 +		.sys_reg =3D SYS_ID_AA64MMFR0_EL1,
 +#ifdef CONFIG_ARM64_4K_PAGES
 +		.sign =3D FTR_SIGNED,
 +		.field_pos =3D ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
 +		.min_field_value =3D ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
 +#else
 +		.sign =3D FTR_UNSIGNED,
 +		.field_pos =3D ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
 +		.min_field_value =3D ID_AA64MMFR0_EL1_TGRAN16_52_BIT,
 +#endif
 +#endif
 +	},
 +#endif
+ 	{
+ 		.desc =3D "NV1",
+ 		.capability =3D ARM64_HAS_HCR_NV1,
+ 		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+ 		.matches =3D has_nv1,
+ 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
+ 	},
  	{},
  };
 =20

--Sig_/0lq+TnyNw/r+bgBwPDvE7v7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSw70ACgkQAVBC80lX
0GyVwgf/ZHEO28wMM8fAb+rIwWzYhYPmN/J+oY9/fOCQugZk145/bDic7aowxLIi
6wakG6HC7l1e7fD2ZMCFXX3q01wQzxPe5WxOyu9p/F1t5kDoLTUuXvsFZGA+D0CT
wrJysenGrAQ1QGQzY2Xb1oWX2r15PTfAsXbo1XteyWRxPXxgp0XeMT1tN0CbyPws
G1mh1COBaUb/dekFfTKYQKwO6Aulr/R5sQp+ECozBE78Agoo5hedwDssMMjPdW3e
BszpUSPcs19HbyUVfCC9blfV4/XvqSc7tJqlJYhgbdRZoedyl3/fI+0dzPpcA98X
pAHQU/INbAOYfPsPULnrCtrEsuSurQ==
=1mRN
-----END PGP SIGNATURE-----

--Sig_/0lq+TnyNw/r+bgBwPDvE7v7--

