Return-Path: <linux-kernel+bounces-49163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF568466AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558DEB2322E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF1DDD6;
	Fri,  2 Feb 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ThLHEQBS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41E8BE1;
	Fri,  2 Feb 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846378; cv=none; b=ZCcgzj8q6pZgN6ICw3NLlBmPXd49JDZ13iqQK3snlmB3QwbthUFh3uiVHD5Hxm9/vWUbcunjLAGSM9wYjaKpKeJ7ghy1pY1sQ27MXE35k2hs8KUXug9AQ30GgDV6DZ9uHLfQl6Svi9hqFcibJui0Ilcx17axC6L/oAVmm8xuypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846378; c=relaxed/simple;
	bh=QzEhyZ/AjWdCqBZ7Tb/w4lAB4oUYf9rFeWxGrnrWYPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qlrzlcwumGfwfvzhF32FBNBk4ciMupw11b/TgRNQlS/Z6Imo71BTs/yxSc68MtIFwH7edOroyLq7T+j18CEH7BKYTFtKiHVUJSjRqPtgQQ4LhBn8/IwIXxNAu6vgb4pgtZUuPMAP95/rIGLobSijXIFYOGriIfttu2HV++sZp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ThLHEQBS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706846374;
	bh=SbRycSWNgVtn3G+ZRHuFY2qcGel0XSRTKvh7++fPqNk=;
	h=Date:From:To:Cc:Subject:From;
	b=ThLHEQBSGvrjDDqT1Nq5WiIfYfutsC/5J/ZIoqnNdbvN8cTz7r8zOSK4L9Ejdz3mv
	 nzufdmCzSpioqtr78jjjrd4i+bLasnVI2JJ6dDofV7vMdS4k6lP7Sb9sxSPeglHBa6
	 9lF0dKbNjvwCvjTGBZID6eZJ5KQfM32UyFb7Hm3jeiMctYwCJ+dquRduiLY8fp1t1j
	 +LgoskOG7nazmHLZ8VKz1FHWTdmK3oylglWsalHAEFKtIHkPyRbILukkUMkCFZLDx3
	 oZ63EIobeMogMYpXiH3+2vks7MHaktZGJ1JmqvKez/vqTRR68dxm+3bCzoPkOLTrDK
	 K7SFxERXbQiYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TR28j0LNHz4wcb;
	Fri,  2 Feb 2024 14:59:32 +1100 (AEDT)
Date: Fri, 2 Feb 2024 14:59:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Michael Roth
 <michael.roth@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20240202145932.31c62fd6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ykspLj8QIjBmiaVUFaZPk=C";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ykspLj8QIjBmiaVUFaZPk=C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/virt/coco/sev-guest.rst:75: WARNING: Inline emphasis start-st=
ring without end-string.
Documentation/virt/coco/sev-guest.rst:78: WARNING: Inline emphasis start-st=
ring without end-string.
Documentation/virt/coco/sev-guest.rst:81: WARNING: Inline emphasis start-st=
ring without end-string.
Documentation/virt/coco/sev-guest.rst:83: WARNING: Definition list ends wit=
hout a blank line; unexpected unindent.

Introduced by commit

  f5db8841ebe5 ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")

--=20
Cheers,
Stephen Rothwell

--Sig_/ykspLj8QIjBmiaVUFaZPk=C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8aKQACgkQAVBC80lX
0Gz0Ggf7BF1esHiAJIx5iZ7dQwGM5wPxsOV/1LTP7n3fxopM6apPXxPdqru24WaX
/ZqMYtGK4DxAUDTjZ9RTpQcAquvZ7OnpD8WORlDrIMVDNYeoFrMjOg3zaVCuUqOp
cbIA+c2fx5tMvGEXPJC9vL1HK1gHBfSlgs5XZKMqIOQ/qcdXKe5NY3RofgZapWxv
8z+JiFRa76kjK+24DC4XLyFupQtSOgWL73sV9m5yCMpvQ+ngBPJO37RDXk28bdzs
5LQgJxTAgiUKtLxiNRnApUAk0oTAJIizUzO9PuRU7NFteznx04z3PCDuM3NB79H3
v77D5v0gjrXCZOfzy+LWFzvyVONszA==
=i0Fw
-----END PGP SIGNATURE-----

--Sig_/ykspLj8QIjBmiaVUFaZPk=C--

