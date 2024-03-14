Return-Path: <linux-kernel+bounces-103911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE0F87C677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9300D1C20E61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A2125C9;
	Thu, 14 Mar 2024 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rj6V2IbB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84100FC12;
	Thu, 14 Mar 2024 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459119; cv=none; b=UlXvprpfMY56wRHfUhPMmR26p1SuHTVJXSTzmK3tIWaFgrEFKrMnhg1D/ykz+ePG/8ev1h70WIdJJt6e2cKBWMBKHb3vNwkQqrC0hgvaag0PNaV7WfZNxqLynS95TgCEqke8WX4GVYx6Cs65jxsF1XGt4ZaKRa5Ycvjem7IJbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459119; c=relaxed/simple;
	bh=/Nxif6wGy3TdqcKi0V6sODJjV6iwo1AjewdOxFWtHpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bt8Fms0/qoyjboZ/rX6UGYJEyOIp8FnbRibHzquV+eV46FxU9MkOaJuU+cpgj/FEXDbWDbQ6uPmaD784AhMyxKYowB7SPhSkjkpC4lndMJa6TC6MzKYLfNo3I+2s+JzbJLErqGBIORItQJ9XxntqC7FRO1s+KANbY+ZrhXcVrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rj6V2IbB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710459112;
	bh=OsxHWr7icc+V61IambhZDA5GJm7mXenCqBWEO974Dxo=;
	h=Date:From:To:Cc:Subject:From;
	b=rj6V2IbBsDcQiHd42yhkJDEHLzlDREQK+jDBvpuYifhvIzLeUs1XgLYEDyyRPjJ+k
	 Mh/NBxRr/9pNErqSc2NC+rqMGsPe7bfYG8ChHn/tDIo1FafcjXAUbuqcN7LobMyAgi
	 a0RbfRtkFMebBIFZ9kuImjUjglxG+6950Mv0Ucqmh15zoHvg/AAq6maoo59XMm8AT0
	 lSr96BFBb+w9KA8B/HFfYhA/2jUPPUtnUTDBGWkoMTrB6arykvayAx7/+aq2SNl0Bn
	 1EF4Jv68fsUuois0p9U/bIg4ugSHATZEEPC2E/yNo8bnv18QnRo7uvcPH4HqLrYveX
	 koFjhYNYFAdvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwkDN3Mqkz4wcR;
	Fri, 15 Mar 2024 10:31:48 +1100 (AEDT)
Date: Fri, 15 Mar 2024 10:31:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Locus Wei-Han Chen <locus84@andestech.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>
Subject: linux-next: manual merge of the risc-v tree with the arm64 tree
Message-ID: <20240315103146.225b653b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gIl4xHy/dJKTUfoTHBkA85/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gIl4xHy/dJKTUfoTHBkA85/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  drivers/perf/Kconfig

between commits:

  c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
  f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit archite=
ctures")

from the arm64 tree and commit:

  bc969d6cc96a ("perf: RISC-V: Introduce Andes PMU to support perf event sa=
mpling")

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

diff --cc drivers/perf/Kconfig
index 004d86230aa6,564e813d8c69..000000000000
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@@ -86,15 -86,20 +86,29 @@@ config RISCV_PMU_SB
  	  full perf feature support i.e. counter overflow, privilege mode
  	  filtering, counter configuration.
 =20
 +config STARFIVE_STARLINK_PMU
 +	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
 +	bool "StarFive StarLink PMU"
 +	help
 +	   Provide support for StarLink Performance Monitor Unit.
 +	   StarLink Performance Monitor Unit integrates one or more cores with
 +	   an L3 memory system. The L3 cache events are added into perf event
 +	   subsystem, allowing monitoring of various L3 cache perf events.
 +
+ config ANDES_CUSTOM_PMU
+ 	bool "Andes custom PMU support"
+ 	depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
+ 	default y
+ 	help
+ 	  The Andes cores implement the PMU overflow extension very
+ 	  similar to the standard Sscofpmf and Smcntrpmf extension.
+=20
+ 	  This will patch the overflow and pending CSRs and handle the
+ 	  non-standard behaviour via the regular SBI PMU driver and
+ 	  interface.
+=20
+ 	  If you don't know what to do here, say "Y".
+=20
  config ARM_PMU_ACPI
  	depends on ARM_PMU && ACPI
  	def_bool y

--Sig_/gIl4xHy/dJKTUfoTHBkA85/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXziOIACgkQAVBC80lX
0GzVjAgAn1ru/3poCYZFZ2tb7LNWXVfVrvHM1ggEk7g6NnxF8l7EzluWG8lrD5VZ
jhlGWtzCR6lPG+c6o267JwZfhAtuQy2XKFq6NYV7RUZR+WVXOgBlF0hA8EtcBNj/
2Jc1QVJk/xqhUoFfTvEZKqXahB3DKonlAEhs1moDi61TNP8w714B7UN66Wx+WP9l
zhJwJEmxETxjQ4kHOCrQlNIKuK8Q48a7RDsnNKLki7PlRvw4kBDOFrjrxqvtuJdt
xjBFkYGxxZdt3Win4gJXKdQ0aHjj1iEnBLH4xNBrFx4//et6aArU7GD0ooolog8g
2IOJifoq05RTTGNmVjbbwvqeNwIctw==
=sbyV
-----END PGP SIGNATURE-----

--Sig_/gIl4xHy/dJKTUfoTHBkA85/--

