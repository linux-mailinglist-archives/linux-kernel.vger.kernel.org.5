Return-Path: <linux-kernel+bounces-42054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AF83FBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058861F21CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E5DDA7;
	Mon, 29 Jan 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uK5XGN4S"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD5D512;
	Mon, 29 Jan 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491355; cv=none; b=qPrnUBL9D6cUiZgclc8tFAzJPZFGcypI+2my/7dPz4B5KbBnVMTNw52ViTcG0hC4KXez2va2oWuX265uMgonP02Iae76owhICwOw6/1i+hvxOVmJDWOoNhGpB2AaaK7BXFBNocLx0JCe6AlGEhv7LHr7Rkxgczqi4Ct6flMHXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491355; c=relaxed/simple;
	bh=pjbYvFMENRbS68jZj8cjMBd/jpeufTJF+qdJQv7i5CU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MZk7LvSkSGI9AbL8tgQrAYlks48NlEtbXHFkMyjS6PIZdgjUufzyALPyg/45rNFeygXb/6GvEUrfLiOm32Gq2F5WtXmljUL8zx40WQ63eF3elu4fMq62tR6F+dleFF28ZrwD6cB4G6S+qTW8AC80Lvx5Q7T1hGDImsp8FhPW7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=uK5XGN4S; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706491346;
	bh=ej++JI4xHBopx3cmrO3Csbo3V0nSbz03q6RENvGen1k=;
	h=Date:From:To:Cc:Subject:From;
	b=uK5XGN4SRcnIrVdEOHSZGGnFWIFfN03eRsQ2CWBSLRm2DD9sqQlXkR6iCI78r0Wzt
	 HoX6lX8/exAM9ZVcTFhpIQWfWMNMHMdxx4GfNGA7VVHiFuYsxak9y8v7rrYPcNy3Ko
	 5vW065r3zxtYt79VDgNVm/xs7H+dG+29hp6JXy/9SUHElKbKhdGkiE9mh1uBQZmR99
	 LTUydIjo0imc326exahSYizZDL+GCdpJfxrCdfJ/Xvq/fZKEA3rXaLUskFjYCkWECP
	 qQFNwO8LXrKKEw/1JYhMSVwdgSFY5ABebHPKhA/27KAg5sT5o3t5mWVrCX93kPUHLf
	 reU9oLH9OPEcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNVsD3T4qz4wc3;
	Mon, 29 Jan 2024 12:22:24 +1100 (AEDT)
Date: Mon, 29 Jan 2024 12:22:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20240129122222.6b690c58@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nHeO8L+/kxhVHrklb2Pbdyv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nHeO8L+/kxhVHrklb2Pbdyv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/compiler_types.h:89,
                 from <command-line>:
kernel/irq/irq_sim.c: In function 'irq_domain_create_sim':
include/linux/compiler_attributes.h:76:41: error: expected expression befor=
e '__attribute__'
   76 | #define __cleanup(func)                 __attribute__((__cleanup__(=
func)))
      |                                         ^~~~~~~~~~~~~
include/linux/cleanup.h:64:25: note: in expansion of macro '__cleanup'
   64 | #define __free(_name)   __cleanup(__free_##_name)
      |                         ^~~~~~~~~
kernel/irq/irq_sim.c:173:19: note: in expansion of macro '__free'
  173 |         pending =3D __free(bitmap) =3D bitmap_zalloc(num_irqs, GFP_=
KERNEL);
      |                   ^~~~~~

Caused by commit

  590610d72a79 ("genirq/irq_sim: Shrink code by using cleanup helpers")

I have used the tip tree from next-20240125 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/nHeO8L+/kxhVHrklb2Pbdyv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW2/c4ACgkQAVBC80lX
0GyNDAgAnU/0sz8sLlaeAwJ93uQ3icCr92C7tIgqcxtiZtJ4RJvwxlYeViXVOEGB
D64S8WmL/D3Q/jgWtAM/6VO86U+bNLlewRAfKMWa/HaI2Y0vqQNfmaFOVUskJG1u
qkuQggEdWe3rjD2pa8DMyqomXspCD9XHCuBUZ9ttSe5wYlIaJZKltB4+g8Ytt/Ax
ME/P5WoiEjzdH2NvI8hKsql1Y5vJtH8iZFeEpBHybs7aBeEN0qcwwvVkRXcTAm1M
VSOxr4ck0forFXWFfTomxXTmpr0kq/LHHD7PRJI7c2zoLGLunH+LDeKfqY3D9QYP
4AQ65L5+eutQC2zNgWO31Rs2Dk8MfQ==
=fn+n
-----END PGP SIGNATURE-----

--Sig_/nHeO8L+/kxhVHrklb2Pbdyv--

