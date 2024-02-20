Return-Path: <linux-kernel+bounces-72210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289C85B0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656631C2209A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214A5381E;
	Tue, 20 Feb 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cBtJV6JS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E209535B4;
	Tue, 20 Feb 2024 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395731; cv=none; b=dAxWKc38V4uNr64Uohllfv3mR3WuRtHxUvaJ5JOyPmAZHrkBt17Z5KCY/x4wjZ+jViHu5jsEor92mcan8EciQS5ufuP0D1zaZIXmdIpum8a1Ltkj7YK2N7r6jFpcQRRxWj7BRyM+5JCpBq56iaHpwJKYLsoGwJsHJEe9t5upQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395731; c=relaxed/simple;
	bh=F3rppOqCnmwBMyrITBdJnjZPj97LNyry9Dr4MDGrUL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sCFf4dOrMr5IliYCKHGUz3tozFXw2Be5vQVMZB8ox6a6sHNiNU9eGZsc9PrmLpTqYybL9RxJToWpERSrNVZ1OXqP1hkqIO4UdG3t6X9hpLQTEXFnqR9rKF8zqRxdWqjCfJqDEzXoVNIyXMJqd2jNlYN0FehN1lyjPgZGx0Z3FTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cBtJV6JS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708395720;
	bh=o+QmmCu0VyeDAnMMY+kJjUw92FzrmY//tfzHi3lE+x8=;
	h=Date:From:To:Cc:Subject:From;
	b=cBtJV6JSiKBmolQq/q2/XK1M3cCx9XmCYcTw6wN/WajGZdXrT3BimhTgGi1SWKyxK
	 2E3MrwgujIrKS7RJH0QN4HWXKXvIMD9KiRP5OTw7iArI2Xad8K6XMILAGrxyFQDo0w
	 HnwQgt5fMcYwOVChdDWcGDWPuuDaf8A0GLXytR4QAMzneaojX4ihonX5XoioutjqeH
	 TICXoEBoX+M/YwtLRD44OCsfuwnuzlXoGg1ppqv5IXqYaedLlYWmvMBnX9KC0qCdjR
	 2DHOK9/gGjVMa7l7emSiblCWCqqHBjJknQc5L6SjUMWaydYksARktsnmuRGhUfho8H
	 y//Od34W++TIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tf37q1QgGz4wc7;
	Tue, 20 Feb 2024 13:21:58 +1100 (AEDT)
Date: Tue, 20 Feb 2024 13:21:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20240220132157.6d3cd5dd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eG3kAavMA3SDAFnHuHGkKlN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eG3kAavMA3SDAFnHuHGkKlN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

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
index d380ae783b73,f309fd542c20..000000000000
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
@@@ -2701,24 -2817,13 +2779,31 @@@ static const struct arm64_cpu_capabilit
  		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
  		.matches =3D has_lpa2,
  	},
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

--Sig_/eG3kAavMA3SDAFnHuHGkKlN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXUDMUACgkQAVBC80lX
0GyEOggAocPVcrTQ+1gwQz+9bsoGgLOguazJKKRyzv+O0acFpanTDUQQ1QX9OgfF
uaw7kPfuMhUsjB4Mv/56OyLK2EGg7TAG6pqxaG6yo9KWXzPqCCyJUzJRuWUin3O1
z9GQk8jR33YDBAuMMeS/eSoOYrmklbQ13xlCELU+K3E5bVSkThzScqOLWyeFGl6h
LX/ljXfYNfMzT3vIYMQBynrWhA3sYwq8bZYE7KFk5utdNiV5kAgd3Keeh9Y9xE98
keOlLvp40QI+LUc3H7ndntgkl0/YRP6rvFxwmHv0oMU8xIE5Tu+VahaXnXtq7zo2
l3AqoBnH9l4tKFA2+V1AH4NqQgUO1w==
=BPwg
-----END PGP SIGNATURE-----

--Sig_/eG3kAavMA3SDAFnHuHGkKlN--

