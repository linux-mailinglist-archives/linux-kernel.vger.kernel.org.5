Return-Path: <linux-kernel+bounces-14962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7882255D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DDE1C22B90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A861772C;
	Tue,  2 Jan 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XBE+QBBu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC71772A;
	Tue,  2 Jan 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704236607;
	bh=Yl+BIDdg260YOhWTGwAtZ/Up6ss/fNGvZoOG0rLjvPM=;
	h=Date:From:To:Cc:Subject:From;
	b=XBE+QBBuny6vDjM/BxjcW35nwrutCrPIO8oV3C5ZJ9IQj++xGr2bedZ2payeMCieI
	 WTKzuAbEC3CTape+Rip3iwL9RD0AJUBHpIxeyL6E6J9AIRrzzy0JscB9sAgF5CWY7K
	 twepkS6XjL3t3PKU7ySmwXyC/nceWl9zbgZW9B6sWV6xGacnnh+kDEwus9tyPOKDZC
	 XVcTVB+OFQaPDsh6/+3inhK+iCAHr+3BAfsLpTjO3PdxM+Jp/y5I1dm17VSOPZMAP8
	 QntTOKhYFOpP4SHnmtSKrprZ7l5Nc0KOSBvmCVKeGwTuSra9V+qYZOwlH9iSPHP03x
	 LqJUdA+jnfDGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4T0s6L0wz4wp0;
	Wed,  3 Jan 2024 10:03:25 +1100 (AEDT)
Date: Wed, 3 Jan 2024 10:03:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will
 Deacon <will@kernel.org>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf tree
Message-ID: <20240103100324.05f47bb8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CKAH0IHe4gwM3Qlv76cwbvz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CKAH0IHe4gwM3Qlv76cwbvz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/kernel/perf_event_v6.c

between commit:

  5cd7da19cb97 ("arm: perf: Remove PMU locking")

from the arm-perf tree and commit:

  ced296f63635 ("ARM: Delete ARM11MPCore perf leftovers")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/kernel/perf_event_v6.c
index 8fc080c9e4fb,0cbf46233d6b..000000000000
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@@ -436,35 -386,9 +373,8 @@@ static void armv6pmu_disable_event(stru
  	val &=3D ~mask;
  	val |=3D evt;
  	armv6_pmcr_write(val);
 -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
  }
 =20
- static void armv6mpcore_pmu_disable_event(struct perf_event *event)
- {
- 	unsigned long val, mask, evt =3D 0;
- 	struct hw_perf_event *hwc =3D &event->hw;
- 	int idx =3D hwc->idx;
-=20
- 	if (ARMV6_CYCLE_COUNTER =3D=3D idx) {
- 		mask	=3D ARMV6_PMCR_CCOUNT_IEN;
- 	} else if (ARMV6_COUNTER0 =3D=3D idx) {
- 		mask	=3D ARMV6_PMCR_COUNT0_IEN;
- 	} else if (ARMV6_COUNTER1 =3D=3D idx) {
- 		mask	=3D ARMV6_PMCR_COUNT1_IEN;
- 	} else {
- 		WARN_ONCE(1, "invalid counter number (%d)\n", idx);
- 		return;
- 	}
-=20
- 	/*
- 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
- 	 * simply disable the interrupt reporting.
- 	 */
- 	val =3D armv6_pmcr_read();
- 	val &=3D ~mask;
- 	val |=3D evt;
- 	armv6_pmcr_write(val);
- }
-=20
  static int armv6_map_event(struct perf_event *event)
  {
  	return armpmu_map_event(event, &armv6_perf_map,

--Sig_/CKAH0IHe4gwM3Qlv76cwbvz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWUljwACgkQAVBC80lX
0GyYmQf+Jh1/UudwcpUoiFM+H+vdp5fYgFOPAifjQ1r4kY7eI+sX9O7XPMTthz8u
RuiykcpB0q1mbzL3czPaqDelcNs9nNyl7zgDb8HINFOd0PNi6qQ3MT6KhDITI55+
dkEcx0ttunPBbEx7rpitFeI79fYM8uTwnNAoE8oVO0zSv4iTJyFfva3FUaFajx4z
7Fl5fI+3mYyxWh/BgyUXeIhpdTBLZCRiMrim4BWmTK5TVdR1J5RlVhTNpg/9KPyh
sQmS90+ufamzwZPy0uCY/rpA5WEnmiBEc3KYpzLuksI2LMOj+Iierl6ps2bzXo/2
PGHgGTpTeIeRmuhjwWbUuI3efmWw1w==
=1Vlt
-----END PGP SIGNATURE-----

--Sig_/CKAH0IHe4gwM3Qlv76cwbvz--

