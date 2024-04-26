Return-Path: <linux-kernel+bounces-159541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333A8B2FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503C8284A05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCD13A40B;
	Fri, 26 Apr 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eYjhE38b"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04742282FD;
	Fri, 26 Apr 2024 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111059; cv=none; b=W+RhJ/4k75YwID/iSuTgHXnIbSN5ORDTiBZqw34NFfVTdTWKR/7yQvBW77VfS8CGFfEaHkk75NG/+xLhpEaXBsOukZMshdEyLM3DbOHkGqxAYWsM85Rw8ZiZvDP14ZX2O97WkOE+EI3G1+mZ9w4lEXMr9A+5na3qRyOqT8iTR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111059; c=relaxed/simple;
	bh=mBReC7h8PXppwFFu2pI8/O+aztbOk1UJ9dCCARvq0No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K7YkepVxAVKiLAyD1wJKduMWnNf0AvUXGktdqZ+R8dQkmrFapXzOTHgxm2nUqOumEqWfZ4hln28ZSUMJzpNhClcgXZzikTJjtd+HRPkfDawT2pzwIne8bo3XJ9rAzXFBq39vAkpYat+lT/snX+hgL9xQy70Kh2y6GxTjV5rCzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eYjhE38b; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714111054;
	bh=cwxQSbYeVT0eKer8AIrRsOXGmUapNqpYECkP5Xuix1o=;
	h=Date:From:To:Cc:Subject:From;
	b=eYjhE38bPiYA61YQNRcovqm8Ks5rnWWaz5PxcwqSfSgu7jRpd6zBYhiQWRDoFYOyn
	 AGKHxXcMUq1aazF9kypwoJps7diANOzfK5TEATwyab0F7ZmZvWS6frMfpckuPiftMC
	 PcWpngtcnRupjIL6Tbrg6LSvKTRBR1oXJr0BpCPSJTcmpkzZwQLJwgx5ZMZg+eeHgb
	 5RAI3GcNL/f+MyiqLpBr/KeTDjJnKC+NYR3mezqrKczE7PAXpUl4d6yRP0qc7jdl9B
	 9WJEpZ/xfxde6qTIu7yFYKzKgrH1D+kMRHiDCT0vrE0MM6tHfcKAWGgLoQFdFuFhPB
	 fSYYNb1ZG/vIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQhp56k6kz4wc8;
	Fri, 26 Apr 2024 15:57:33 +1000 (AEST)
Date: Fri, 26 Apr 2024 15:57:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Max Filippov
 <jcmvbkbc@gmail.com>
Subject: linux-next: manual merge of the execve tree with the mm tree
Message-ID: <20240426155730.5c03ae33@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SWuLex9OyMn4yg7AY6Y6Wt/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SWuLex9OyMn4yg7AY6Y6Wt/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the execve tree got a conflict in:

  fs/binfmt_elf_fdpic.c

between commits:

  ddfa3901a4de ("binfmt_elf_fdpic: fix /proc/<pid>/auxv")
  f559d7a05917 ("binfmt_elf_fdpic-fix-proc-pid-auxv-checkpatch-fixes")

from the mm-nonmm-unstable branch of the mm tree and commit:

  10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv")

from the execve tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/SWuLex9OyMn4yg7AY6Y6Wt/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrQkoACgkQAVBC80lX
0GzUdgf/Sa0f7EEq6VpGRcEAROEblJQMJp5Bockxm9Wo2gseb8RjOvnbszCAAp27
V9Jr4Sl9kcM51Uj3dwxAikfj5IedE4BQgYiDgn2qXwEYjeaWvMnYswCb1M149zN5
ko/u0xMK0Uos/DGMbZLHPe+ALpUHgJQvmIsLewodzfJttZrKDOfjJuft/8tiYU1Q
d83BlZWDQPR1IGoKGrbcSmZoo0GA7+32Hq94WFQcTrReCptel3zkmQIxDpRbRTmI
58Ft8kmkr3jUJLk+BUsnJbCo6NUMQ97TV219MG1nL7HQpyyw/MJuIy/bJBMI4WRp
nJmGmGTd7ADcR3xwMWokHXvTHwtXMg==
=OEa6
-----END PGP SIGNATURE-----

--Sig_/SWuLex9OyMn4yg7AY6Y6Wt/--

