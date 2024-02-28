Return-Path: <linux-kernel+bounces-84458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1B86A700
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2761F2C76B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F61CFBF;
	Wed, 28 Feb 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M4Byfd2j"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924994400;
	Wed, 28 Feb 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089380; cv=none; b=mY0qMqkWIfAp3TcPFXxtr4Cusz+jL2xP+cVBr+1ru7/OyXtZqt58HBxSa5e0S84dj6TtaFYRofd4AyhtD8KWsNeAalYrqv9987VCd6SnscMRFzzDNi1AM0S8zhcMYGaVVeeLISNojAy3Zi2dcQ42K49OV9N/G4hqmEyVqX65F1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089380; c=relaxed/simple;
	bh=Q66R9DTUxExse3Q6kcLa99VMembszL/iKn8UIUEa2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u20K21hi/wFZRthksqMzR2rbJDdCYicF0NYtD6OlZn1MyG4+NGNOIKGUsz5PudA2l7YwWhztVVa4RSildOn7eMev89J2r6q1WiDS3cfMfV0SDe0e3SrPDYLlPt4scU5AF7km7+OOR3ecMKxMHjJwi/CgAqfAhl3k/crk3eWK6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=M4Byfd2j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709089374;
	bh=5lAPAzYiDu9GuiUchcWSYC31bGjsbi4A7tqyBwQYXmE=;
	h=Date:From:To:Cc:Subject:From;
	b=M4Byfd2j9W6saaT9i4uwsb0A7VFObQD9Yy8N/EMLmqIAX3r159EpJesk4B0gSb0L+
	 LvKKf5vl4dzjsXQok9derMPcmh79HjzHACxb7CddinaqX5JiVi8fYvveu9oD8oCMMO
	 ielCkekpY8Gt9DIEFTnGL2vn06UrkbY4QCutefK+BhfCiz91KskNDWgPUho7984cQH
	 okTI9AN4Q3kkjiPgs4bBc6PjnWJN8m3G75dmqA4Fq+Hqwwwwdkr5Ci0SCUwixOLsY0
	 08JKMAEgdKNjQ7zkrJejIOmVcH41E8/ZOqS+lva4m/CO3bMr4v1+E48m4+qUUiDf8c
	 Udrjp5MOJKO5g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkzgK1N1Jz4wbQ;
	Wed, 28 Feb 2024 14:02:53 +1100 (AEDT)
Date: Wed, 28 Feb 2024 14:02:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp tree
Message-ID: <20240228140252.6d4e5e85@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v/VC.VhoeQ63U7+/POQR=2i";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/v/VC.VhoeQ63U7+/POQR=2i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  2867ef32ce00 ("x86/vdso: Move vDSO to mmap region")

This is commit

  3c6539b4c177 ("x86/vdso: Move vDSO to mmap region")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/v/VC.VhoeQ63U7+/POQR=2i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXeolwACgkQAVBC80lX
0GzWOAf9GLRIpfF6c8Djjwf60807vXMzHA+RZBykBewsmCyEkQxoO5LYzmIKdQkO
ECkjAMz+h37hdroY/ozwTeKKSoz2jUSU98g3xNQwsiVxhR85hoZFXFrC/1w/J3dZ
v7V5aMZkra7IVhNq6l1VK17UemcuX+fEALikgxBpxUZj1jtQKqU/XnBaYuxZ9jmx
B3XcJ3FvFRIe0eEqJB3LXK9ZJHEEwiR/ZXH5dNHg/5LjPZgC/ZjghEKZMBIz99L8
1idSDbGKqVuELct9pyHyM8uWdvt5/56AQAXqiFVz4uUL2dPlHAwr6q0wkNhVeYZB
PRxmEC7AiZfU/CqoiMANFsi8oktiTg==
=GqyW
-----END PGP SIGNATURE-----

--Sig_/v/VC.VhoeQ63U7+/POQR=2i--

