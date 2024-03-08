Return-Path: <linux-kernel+bounces-96441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39649875C27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BFB1C214C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B12377A;
	Fri,  8 Mar 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jlyc/N6z"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF82261B;
	Fri,  8 Mar 2024 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862879; cv=none; b=lYZPS7i51Y57r6p3jT7eqIYOhyUkIN2DmZhR175lQSBQR0TmIbTKod2mLY+7ONZ2jkAHY3Y9VdiBMOnonhRfdgzTSvD+0qdb7XvLYjL0qEeL8C5juqBuepKPl9R6PIgePZEpVtNIG7et1b88oLFXUiJ2zxaWT/KBocQX1/fORpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862879; c=relaxed/simple;
	bh=zwIL5bre8WjgdN5iGa+y8sIhr2JXpBxUmqq7cAYXBdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=unPGm/uwmxLOcOxwPhbqYJ7MBgy+tjnG6hqSDgyLLr1kUjpZ3tX+hR6OHJu3RDBy8slcTZrzDRxg0h3CQhzand9txyKrknxDXGQwBoMOwz7v3oZuWge4mY4T//toaX077NJHAt4k17kDfbzufgL/8kJ7gjiBJncOXId+rbiZUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jlyc/N6z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709862875;
	bh=T9AbWj8KaUN3mo7iBufsNz2EsT/Tf4GLokW5EZgaoCI=;
	h=Date:From:To:Cc:Subject:From;
	b=jlyc/N6z/+oz1An/59QwJlN6Su9Of51tk99xkQRYLYhH6nD7h1YJw7p5lo0i5m8eU
	 FzIZNCURe+13C9BHWGAagY1wLCTX6InZxUrI0Me38GxXEJeCZH4heSnyyFzNujQ4mq
	 IPG/6QUY4e0CJcwkRTgKkWC/D0G1F7mhchiLuIPJAPizLrNYH2pKI9M+T+FcWpVC/w
	 2P7U9p7k4eu9Mti6or4g5A2Gb5AiNE8qhlYxsOY5HSB1BWZXX2LQRe1k4VH4IBBbZo
	 GfjPYSFk6KpErcagxI8nflb/sCkpdE4aU/LSKICWajuIzkzhBsXRubWFVIVlfZxm3S
	 G+fHoqAwnw4Xw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrTkM0FLxz4wc9;
	Fri,  8 Mar 2024 12:54:34 +1100 (AEDT)
Date: Fri, 8 Mar 2024 12:54:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20240308125433.134c0dbe@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Fw0gdrGjUedmklPffBBkkg";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5Fw0gdrGjUedmklPffBBkkg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

  203f2b95a882 ("arm64/fpsimd: Support FEAT_FPMR")
  9cce9c6c2c3b ("arm64: mm: Handle LVA support as a CPU feature")
  352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k gra=
nule configs")
  2aea7b77aabc ("arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and VA=
Range")

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
index d6679d8b737e,f309fd542c20..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -754,16 -752,14 +789,17 @@@ static const struct __ftr_reg_entry=20
  			       &id_aa64isar1_override),
  	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
  			       &id_aa64isar2_override),
 +	ARM64_FTR_REG(SYS_ID_AA64ISAR3_EL1, ftr_id_aa64isar3),
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
@@@ -1088,12 -1084,11 +1125,13 @@@ void __init init_cpu_features(struct cp
  	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
  	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
  	init_cpu_ftr_reg(SYS_ID_AA64MMFR3_EL1, info->reg_id_aa64mmfr3);
+ 	init_cpu_ftr_reg(SYS_ID_AA64MMFR4_EL1, info->reg_id_aa64mmfr4);
  	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
  	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 +	init_cpu_ftr_reg(SYS_ID_AA64PFR2_EL1, info->reg_id_aa64pfr2);
  	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
  	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
 +	init_cpu_ftr_reg(SYS_ID_AA64FPFR0_EL1, info->reg_id_aa64fpfr0);
 =20
  	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
  		init_32bit_cpu_features(&info->aarch32);
@@@ -2750,32 -2817,13 +2828,39 @@@ static const struct arm64_cpu_capabilit
  		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
  		.matches =3D has_lpa2,
  	},
 +	{
 +		.desc =3D "FPMR",
 +		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
 +		.capability =3D ARM64_HAS_FPMR,
 +		.matches =3D has_cpuid_feature,
 +		.cpu_enable =3D cpu_enable_fpmr,
 +		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, FPMR, IMP)
 +	},
 +#ifdef CONFIG_ARM64_VA_BITS_52
 +	{
 +		.capability =3D ARM64_HAS_VA52,
 +		.type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
 +		.matches =3D has_cpuid_feature,
 +#ifdef CONFIG_ARM64_64K_PAGES
 +		.desc =3D "52-bit Virtual Addressing (LVA)",
 +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, VARange, 52)
 +#else
 +		.desc =3D "52-bit Virtual Addressing (LPA2)",
 +#ifdef CONFIG_ARM64_4K_PAGES
 +		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, TGRAN4, 52_BIT)
 +#else
 +		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, TGRAN16, 52_BIT)
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

--Sig_/5Fw0gdrGjUedmklPffBBkkg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqb9kACgkQAVBC80lX
0GwTUQgAjT/kY/WN8mKOv/DwJavyuHsHovd6blDF+QGdsDNQN2AeNCSqWhT6dKpa
lD5nwEohr1ZXo3JRMuCly+DSN5hpMLtDNrPYYS+AoBh+E3hGg0UISgCNzxs1eI4v
aJF+qRmmyq/D9fJfdJ5R84j+pPpZX16WqO/0XYiVfr146AmezVx08idF/6DRsGBy
aFbqIX4KZCzl7zXDlYStVvxwAQ33VGp1PN+xBgukySRF4aMoB2ci2xI86YfQ/gsh
QfW+XnPnMWMRTXNopVEwEzztF8Gkt+gjtkjHJ87nMLamNnz+Ti4hc3YQYmfhWTgA
l1OBvrnRCFmB89y8vCRkFR/diFrCcQ==
=M4wr
-----END PGP SIGNATURE-----

--Sig_/5Fw0gdrGjUedmklPffBBkkg--

