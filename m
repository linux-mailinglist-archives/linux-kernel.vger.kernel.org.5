Return-Path: <linux-kernel+bounces-84013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA286A151
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFA81C23CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203514EFDB;
	Tue, 27 Feb 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="In8IxSv1"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4914E2C6;
	Tue, 27 Feb 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067804; cv=none; b=jDdRiiBYXj3wyF0FMZr2RCIbAeZ7NOZL9+JTbxSHpvejzaxAJak1GcVqrc0lPFh1Vt4ILBuzHW/lhojZk9xSpnzdEqoKV8gbvJRXAzTU4aSFoLJt1oGfoY6KxX5uh9yzWllNfc9sTd5rD/AQ/zkvveofYsPZz2vAbzlFbOt4isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067804; c=relaxed/simple;
	bh=OPlJx50tQm0vtIktxMp7JM6rjPx7VNp/6/GPYllOp/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T/FcNW0bx80jaerXJ3VOIBs+SOo8WpmgVDoIAB2gUhX7ODhGzSVfHg3je94bfJgnB5X3hk6JNenyJrTIQOe/7Tx5jOx3rRWAazmkfC8pDM7MmIP7Els2FavyVHbxsV1Y89GWVODFtbhR7VoolUKfsD1OkAkXi3CIeLvIiKEORvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=In8IxSv1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709067797;
	bh=2mTESaB92galiU5WXgr0fjzlCtiOxdAmEFvyUlXRpwk=;
	h=Date:From:To:Cc:Subject:From;
	b=In8IxSv1mx6W4LC2kvhYDC1tZBqP2s6B5RxCPqtDOqMUT/y0LklaYqP/k67SiLHRj
	 O178+7KkLqOqgeP/edOjITiKg2kGIG7umAXV+6t7XR0jDmaqhqrNOSgIPZSTJlk4TO
	 4WiLN9weaRrg8YuMy4LBQSf0jcW4mIk6XJ1Zwn7rValE0JVOTWEsNaqfTV5iqT7r+I
	 gup3Jf4twA4RixTO/l9BTx/zCjt4kSKUuTn5Cx5OVMOWhRw/b0c2yDOWdnGkhBWpGv
	 NczQ/JQoq+YwCXORkzh8oXokokyyeqARMCIl9LuZN8XVn6M8Bj9Fp+lvzXv3BC0G2d
	 NvZobaiXv6RaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkqhN64FPz4wb2;
	Wed, 28 Feb 2024 08:03:16 +1100 (AEDT)
Date: Wed, 28 Feb 2024 08:03:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20240228080315.2cc34760@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gt9sRXK8qVpqdyG_z0INwlE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Gt9sRXK8qVpqdyG_z0INwlE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1abea7339b40 ("irqchip/riscv-intc: Fix low-level interrupt handler setup =
for AIA")

Fixes tag

  Fixes: c1be2ae5987a ("irqchip/riscv-intc: Add support for RISC-V AIA")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 3c46fc5b5507 ("irqchip/riscv-intc: Add support for RISC-V AIA")

--=20
Cheers,
Stephen Rothwell

--Sig_/Gt9sRXK8qVpqdyG_z0INwlE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXeThMACgkQAVBC80lX
0Gy6Mgf+IBq057BEYRFrEsdv9G9crYwSheTHoSSkZ8VKIL/5F48HQ8v5O7AkolJH
Vfk+dCcDJNFqGiMKvtOf3k72t/XV9XWt3Pu+nv3yiG6zvKdkgJhzvEgQE3tp4BW8
buAZ+8qJN62o+w560FpOaWSnUURVuVkrEOrkzuQWvt9X9QcReGITvw6BPKpMilek
cMSnZh/N7LQ/9JFoNUMIUvAIhiKDxEJ17+vOD8QeUe16wRVbhR53iB7iiCmbfQFT
3ksFWLbXOJlvuORSHS9GIDx1tRpXajo2dqUU2l7NrRv2w2gMokDFDG3VB01BVX+8
jxq/zSMFaXjXYrtNivLf974p7Wdsfw==
=nnEW
-----END PGP SIGNATURE-----

--Sig_/Gt9sRXK8qVpqdyG_z0INwlE--

