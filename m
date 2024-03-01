Return-Path: <linux-kernel+bounces-87754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECF86D889
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AF4283EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3702B9C6;
	Fri,  1 Mar 2024 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sV3sXs//"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D9101EB;
	Fri,  1 Mar 2024 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255476; cv=none; b=es0YoL6rxHwOpm4nFOx17Pp20zB2gZsiiNvej+6m9jVLBdu5sILnfpG4bi210+7jajX1A+yEFDikg42yLKanOAGt6WjNk96EJZGkaF2wrtyIbvrDw3dad2pifyhC7Uy9sUmi1JSAHqM7L/rljz22bv7bF83w2xPZc4hwH3hlUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255476; c=relaxed/simple;
	bh=h++OtKFqGmFFfi9llnEE4L1VD8vuWEltExm9TiJQL1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sW9reypdV4TYFE+aNtcuTjIO7582lYhDsVvaPYFBlET02Io0LaFjQpWQPPEjpzDNOrbYwTdPqxC0vh2UfEnNmiU7UKkqC8qMCw6d23dfQqOb3UaAg0TQv32iNSa7R6tjnGep1wDLOCo6eswcKbJWcXWQHM4p3A80/2ZDbCScb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sV3sXs//; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709255470;
	bh=mBRQuaFS1jC5CvQAtw82OFJoQClesQDOW9qI9XMCInA=;
	h=Date:From:To:Cc:Subject:From;
	b=sV3sXs//4SvdsoMqJart9b1jU7NLxsMyVDH6itqqwnTGtEg5mMz7zvIL+GNN6Qqr0
	 7K1XKvHsWOrZMfUPKo/PimTJd8b54o9Y3edNANcQsFPWnuaYlE/1lSOUDgMOEe8T8t
	 yXl8Qg/0XhpE2u0obM+axdW4aysecNOdtWTEe48GLbpkuLSABOfNwJG3Guu7UKOA+V
	 tgLjoLn8x/VpKupOe3HdtNVGBiS08BOzU9MRfhTtE+QoFt1BuC+O8Kn7eifzcr/LQD
	 WokQO/XhuaDkPvvKcWz8iWlTBBqldZvsi7A5zWMXxzoCcFpyPbZJHs3OREJLaZ2rzQ
	 7aFcnmfD+9x+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm95V38Hnz4wck;
	Fri,  1 Mar 2024 12:11:09 +1100 (AEDT)
Date: Fri, 1 Mar 2024 12:11:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20240301121108.5d39e4f9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T0XkoVTyb0nAwXHzF50yHeg";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/T0XkoVTyb0nAwXHzF50yHeg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from <command-line>:
In function 'tcp_struct_check',
    inlined from 'tcp_init' at net/ipv4/tcp.c:4700:2:
include/linux/compiler_types.h:442:45: error: call to '__compiletime_assert=
_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct t=
cp_sock, __cacheline_group_end__tcp_sock_write_rx) - offsetofend(struct tcp=
_sock, __cacheline_group_begin__tcp_sock_write_rx) > 99
  442 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:423:25: note: in definition of macro '__comp=
iletime_assert'
  423 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:442:9: note: in expansion of macro '_compile=
time_assert'
  442 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
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
net/ipv4/tcp.c:4687:9: note: in expansion of macro 'CACHELINE_ASSERT_GROUP_=
SIZE'
 4687 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write=
_rx, 99);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  99123622050f ("tcp: remove some holes in struct tcp_sock")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/T0XkoVTyb0nAwXHzF50yHeg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhKywACgkQAVBC80lX
0Gy/EggAi4WvLCkErXXayhJ7TSDsuuU8J3zHF4pdCSZsaqtV+Ahb1EdIbO2IF310
HwA2Cl1f6W0MKw+B0sRpISC4rZvvWJfbP7BC8hSk9glWRlE1O8rnLYOwKBoI8fuf
yGJ4Gavc5/CoZCqQQW96il2MvvEwbT8PRk/CZqmawXmW/0PsPWuTfTRcA9n3/8rQ
twGz7JZ0ISx6z7mlUI1+IaCuRq4CtRVQ8sLModrrgptBqZer/4rlIn/fim16+odp
+zDjK1atKGeIdl4r27KYymZMgTw0TE15lJ1Xx/sTvqa57woHuOg6QbNEKI6X6x+3
okW0Pbt0sqUAqCTe1ykVmNkkqmcRUg==
=FMBw
-----END PGP SIGNATURE-----

--Sig_/T0XkoVTyb0nAwXHzF50yHeg--

