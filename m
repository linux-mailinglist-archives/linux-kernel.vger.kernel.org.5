Return-Path: <linux-kernel+bounces-136093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822089CFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B571F2257C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFE44EB2B;
	Tue,  9 Apr 2024 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I9OQ7OcN"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA925757;
	Tue,  9 Apr 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626840; cv=none; b=QRSGfvn3lqW7redQZg8FsROeoOFG5JNBt8eDZxwIL903GhnPmGqKZ4lswal8qxkBJ1juUw5mD5ihQQouYoKoBA5zWRSjwyB5vxtmLclDhEMHDGWjnJnfPx65PBTGvmuuhkGFhQ85+Kpl7szWa5l7SBbLL6uHrN23+MXfxZCIDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626840; c=relaxed/simple;
	bh=u1b5vGF6fjegDxFgiSzn3/ni0Say/Sygjxb+PXPiyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GHDfkUyfchLagdP+WS9QLLFDjUHYBrJtlKzPsOdY6U6Gq+h6zOA3d5iMg5Cyy/hh3wykomJDK59Ja2ayiVt5y+rUG4JZnXXtqDAyKBDOvnWmL7PPU+JVIt21DQ19BVQ+o8myucknIAWJxr++iMEyPo7LoKF1bIGYe3hZGOTlWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=I9OQ7OcN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712626831;
	bh=ZKghRgYADVS4N/Cyb6zg9wI0ZitXOazy/b7vObIc1LQ=;
	h=Date:From:To:Cc:Subject:From;
	b=I9OQ7OcNPpC7QC5rlfP4lr57hdihskhK0pC3z7gtpslUzXmz97T1UrCUp2mxudMED
	 Ge2P6YMMLGmmfNHlhV7PAQdSAy0LjcFyT1vIyjtzEEBOcK6O6kZepu6c1ICCKf4M8R
	 3eF4vohGMBcEczuhPBxK7ew6ty9E+6d8VuvRcDid2DRywzJq8e1HbG3VyOzuB2jOAt
	 f7J+XccTY93+MSvHL7Kh/jAaMY0MQsMPDki3wvpWO3VSj8a7tvZxnIYxL/T6G7BxgO
	 YT5IFVt2cz62uMc56QfUbstB7cZkAS2LpBb6Mjedk09Ycl67Qu7hyRygqrhyuCpdAE
	 HfqYJRygo7y8Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VD7vL6tSYz4x1Y;
	Tue,  9 Apr 2024 11:40:30 +1000 (AEST)
Date: Tue, 9 Apr 2024 11:40:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20240409114028.76ede66a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZBgaFDbHVPMizQTjD3D=DAu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZBgaFDbHVPMizQTjD3D=DAu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from <command-line>:
In function 'tcp_struct_check',
    inlined from 'tcp_init' at net/ipv4/tcp.c:4703:2:
include/linux/compiler_types.h:460:45: error: call to '__compiletime_assert=
_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct t=
cp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct t=
cp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 92
  460 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:441:25: note: in definition of macro '__comp=
iletime_assert'
  441 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:460:9: note: in expansion of macro '_compile=
time_assert'
  460 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/cache.h:108:9: note: in expansion of macro 'BUILD_BUG_ON'
  108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP)=
 - \
      |         ^~~~~~~~~~~~
net/ipv4/tcp.c:4673:9: note: in expansion of macro 'CACHELINE_ASSERT_GROUP_=
SIZE'
 4673 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write=
_txrx, 92);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Presumably caused by commit

  d2c3a7eb1afa ("tcp: more struct tcp_sock adjustments")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZBgaFDbHVPMizQTjD3D=DAu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYUnIwACgkQAVBC80lX
0GwXGwf9FONJR9D6iryOPmMaLVw43NAJJ+G5ykiKuCx/yn+JRUCILh7+ntM8Z2CM
aUAC0D5iJYS+qwoxemf+XPUhY30mxZc01x3ZP967OEn+kG+oGqhv5NeIRZ8eT7hq
Qr+I3vDWv/i/zOMsBoaIgACFN0BvVVd1AOOkcLlZt/HJ+leGbTOXVcS4HSI94fLp
FiEhlvLyPnebhGRgC0kXGdDP8Jn/Sk4Lrt7jqxwOhiJf4Jj8WGumInLxOZJYJnjk
tltuNDZVNeO23Bm9YRNtgD/fkgrF3tfSqwzgdNxH1QwKGSmype5dxoTnkMcVxs1m
XNEcuj0Ycv6PkfSQXWgnd/4ysziZeg==
=urwm
-----END PGP SIGNATURE-----

--Sig_/ZBgaFDbHVPMizQTjD3D=DAu--

