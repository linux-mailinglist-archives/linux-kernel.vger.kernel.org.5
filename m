Return-Path: <linux-kernel+bounces-9273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FF81C337
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFA1F25891
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052E63B9;
	Fri, 22 Dec 2023 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lf6uZXau"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F955611B;
	Fri, 22 Dec 2023 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703213654;
	bh=eX/YRvlvj6xcZsVmrDkmxFXSC1ktngYFQfcPaHfFbLI=;
	h=Date:From:To:Cc:Subject:From;
	b=lf6uZXaub9uBTc4kABnc4KS4ogU8ewN6zEBoWYCI7YNosoiSf4ihPUuz1dNntW++J
	 uy0grkNHQXI383pUiY7ZNOGXKdEx7n0EUWFjB+XxzLOat45nqRwTnMaPRkTxN5PX2Y
	 12lgXzp1/QHgRQXKuxeytMedRyLWXRCOt/7fNz/LqYNA+N6rJ6bWdgDWihq09eEvnD
	 iGnxdijJt/wcUL4+mC+7mvJaBGMCHNL1/N+SamRCs9vi0+/xWUmvlrb3wDRgptlsQy
	 AuFwsc7n1NR8or0C+5AiJQDpQIP+e7Hymrwg9F43P72nKyQKsZ+GBnH0fWSvoKnnY/
	 LlBmhZeneM1hg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SxBhj1ztbz4wxv;
	Fri, 22 Dec 2023 13:54:13 +1100 (AEDT)
Date: Fri, 22 Dec 2023 13:54:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20231222135412.6bd796cc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7.VD=SF5oH=_vsUg/znPun";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D7.VD=SF5oH=_vsUg/znPun
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

drivers/platform/x86/intel/pmc/arl.c:680:6: warning: no previous prototype =
for 'arl_d3_fixup' [-Wmissing-prototypes]
  680 | void arl_d3_fixup(void)
      |      ^~~~~~~~~~~~
drivers/platform/x86/intel/pmc/arl.c:685:5: warning: no previous prototype =
for 'arl_resume' [-Wmissing-prototypes]
  685 | int arl_resume(struct pmc_dev *pmcdev)
      |     ^~~~~~~~~~
drivers/platform/x86/intel/pmc/lnl.c:503:6: warning: no previous prototype =
for 'lnl_d3_fixup' [-Wmissing-prototypes]
  503 | void lnl_d3_fixup(void)
      |      ^~~~~~~~~~~~
drivers/platform/x86/intel/pmc/lnl.c:509:5: warning: no previous prototype =
for 'lnl_resume' [-Wmissing-prototypes]
  509 | int lnl_resume(struct pmc_dev *pmcdev)
      |     ^~~~~~~~~~

Introduced by commits

  f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_=
pmc_core driver")
  119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_=
pmc_core driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/D7.VD=SF5oH=_vsUg/znPun
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWE+lQACgkQAVBC80lX
0GxZtAf4/BQKsQ2JL/UGjJCJwhoqd4UWSUfpAlchaRvpel8ZdfMJzQTaV8+kwxL2
zaXXoJQ8584KA2Ii88xycZiTLRBhS2S+ouYMTDi8y1ZOIgM/pi2Xdjaa2r5eHXgB
ULNti8Z9VT0LFPKxrIH0C8je1AvxdEmJjgaWTzOQzWJEqrQgycWDoXhncwyJUzlC
FgoLyoHXluuJOsIqp8FAlzrpjBc1lVHew5jbA8L0GvplvLasUlXzlnGcby42vIww
WD9Pp7ZSsGxXnKl+s1/Mqw2/nmuP0Lb8Pu4W5znsgvityNtrDBrDPClCdUmy5agA
K+df4tvkEuv56AUv/Faz7SlXF5OC
=mov6
-----END PGP SIGNATURE-----

--Sig_/D7.VD=SF5oH=_vsUg/znPun--

