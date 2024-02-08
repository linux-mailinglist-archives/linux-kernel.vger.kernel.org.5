Return-Path: <linux-kernel+bounces-58794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7284EBDF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A4BB25CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2B50245;
	Thu,  8 Feb 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dePIYP2U"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FC4F5E5;
	Thu,  8 Feb 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432384; cv=none; b=IaNk3g2uWLWvoHgAl6Yx1I0ULfC9Ze+fa13LsZurtBpYCaEw87e5s589tFQ9qCQn5zoiHIn4JaP6TcA4Zhsuz4v8vRIN2vJW8BfVegebPD8BGYZHi/tEhGl5fLLyIpQzUBsosEvgrrc/gIWvejNrvghm3FyzWQOPsU99W3v1WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432384; c=relaxed/simple;
	bh=D6o5eQpzQiGKeme0HFvjHP0MHbnYmqS2pN8kt5KHoUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU4u8HDqNfM1ihmnU1BLSnuG4CXNxQNW74QVlLA49sC1bMvZ8fzPqGDGA1gX5U0zPHGueVao2IFu48GJZVVNZNa3mjSrR9uU2plqEykYD7TUfx5nm55EdJcR0aF/xA9ZFB0uCkspWCUQzCUvDif6w32bO7TBCoNLgBXStN01P/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dePIYP2U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707432377;
	bh=f+6yMiDyUw4wfxXPslSMKZJAI3q4S9wnf5bFRFwo/EY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dePIYP2U2Sb91w889i0NHFroVDz3W4KNMYQiusq1ZRHcLqKQWiOx2dhW2BoM7Bc7S
	 B2M8KO6Er1kgCXA7/KtvbYww8HLWpI3asvhZuO0GB1KXCWjOQeNSSqQiDLMZjfyQ1c
	 S2EdpnGxHv/NfDSL2C7TRu79a4KrdO2slX3cN/u37B+M2eIc1xdTu+lwnX0hHzDgOc
	 TybuvYkkUEnKYYfTcNMcG6SSv+/U/75ZXhuvGTs6+He9fGJViqRXChTwSFMG/XxbVA
	 9F54p40jUw0bA4AdB+xJv6pkLkPeRdr9nWkFPou5+Cf+6SyZjeEfN0GQdPOP/3jHnW
	 sHTTnAAwiY3uQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWBt062yNz4wcs;
	Fri,  9 Feb 2024 09:46:16 +1100 (AEDT)
Date: Fri, 9 Feb 2024 09:46:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20240209094615.5acd86fc@canb.auug.org.au>
In-Reply-To: <20240207115755.338828db@canb.auug.org.au>
References: <20240207115755.338828db@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+oZln.xemLfhXAYoJ57d74V";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+oZln.xemLfhXAYoJ57d74V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 7 Feb 2024 11:57:55 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the bcachefs tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> lib/math/mean_and_variance_test.c: In function 'mean_and_variance_weighte=
d_test':
> lib/math/mean_and_variance_test.c:33:50: error: 'struct mean_and_variance=
_weighted' has no member named 'weight'
>    33 |         struct mean_and_variance_weighted s =3D { .weight =3D 2 };
>       |                                                  ^~~~~~
> lib/math/mean_and_variance_test.c:35:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    35 |         mean_and_variance_weighted_update(&s, 10);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from lib/math/mean_and_variance_test.c:3:
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from lib/math/mean_and_variance_test.c:2:
> lib/math/mean_and_variance_test.c:36:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 10);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:36:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 10);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:36:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 10);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:36:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 10);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:37:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:37:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:37:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:37:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:39:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    39 |         mean_and_variance_weighted_update(&s, 20);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:40:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 12);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:40:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 12);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:40:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 12);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:40:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 12);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:41:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:41:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:41:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:41:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:43:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    43 |         mean_and_variance_weighted_update(&s, 30);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:44:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 16);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:44:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 16);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:44:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 16);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:44:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 16);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:45:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:45:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:45:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:45:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:47:52: error: 'struct mean_and_variance=
_weighted' has no member named 'weight'
>    47 |         s =3D (struct mean_and_variance_weighted) { .weight =3D 2=
 };
>       |                                                    ^~~~~~
> lib/math/mean_and_variance_test.c:49:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    49 |         mean_and_variance_weighted_update(&s, -10);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:50:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -10);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:50:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -10);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:50:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -10);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:50:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -10);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:51:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:51:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:51:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:51:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 0);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:53:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    53 |         mean_and_variance_weighted_update(&s, -20);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:54:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -12);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:54:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -12);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:54:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -12);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:54:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -12);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:55:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:55:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:55:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:55:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 18);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:57:9: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
>    57 |         mean_and_variance_weighted_update(&s, -30);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:58:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -16);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:58:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -16);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:58:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -16);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:58:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -16);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:59:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:59:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:59:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:59:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 72);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c: In function 'mean_and_variance_weighte=
d_advanced_test':
> lib/math/mean_and_variance_test.c:64:50: error: 'struct mean_and_variance=
_weighted' has no member named 'weight'
>    64 |         struct mean_and_variance_weighted s =3D { .weight =3D 8 };
>       |                                                  ^~~~~~
> lib/math/mean_and_variance_test.c:68:17: error: too few arguments to func=
tion 'mean_and_variance_weighted_update'
>    68 |                 mean_and_variance_weighted_update(&s, i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:70:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 11);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:70:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 11);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:70:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 11);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:70:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), 11);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:71:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:71:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:71:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:71:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:73:52: error: 'struct mean_and_variance=
_weighted' has no member named 'weight'
>    73 |         s =3D (struct mean_and_variance_weighted) { .weight =3D 8=
 };
>       |                                                    ^~~~~~
> lib/math/mean_and_variance_test.c:76:17: error: too few arguments to func=
tion 'mean_and_variance_weighted_update'
>    76 |                 mean_and_variance_weighted_update(&s, i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:78:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -11);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:78:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -11);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:78:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_mean'
>    78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -11);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:78:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean=
(s), -11);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:79:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:79:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:79:31: error: too few arguments to func=
tion 'mean_and_variance_weighted_get_variance'
>    79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:79:9: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
>    79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_vari=
ance(s), 107);
>       |         ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:198:5: note: declared here
>   198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varia=
nce_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c: In function 'do_mean_and_variance_test=
':
> lib/math/mean_and_variance_test.c:94:51: error: 'struct mean_and_variance=
_weighted' has no member named 'weight'
>    94 |         struct mean_and_variance_weighted vw =3D { .weight =3D we=
ight };
>       |                                                   ^~~~~~
> lib/math/mean_and_variance_test.c:98:17: error: too few arguments to func=
tion 'mean_and_variance_weighted_update'
>    98 |                 mean_and_variance_weighted_update(&vw, initial_va=
lue);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:102:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_mean'
>   102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  initial_value);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:102:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  initial_value);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:102:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_mean'
>   102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  initial_value);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:102:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  initial_value);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:103:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_stddev'
>   103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),0);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:103:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),0);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:200:5: note: declared here
>   200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_varianc=
e_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:103:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_stddev'
>   103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),0);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:103:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),0);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:200:5: note: declared here
>   200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_varianc=
e_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:108:17: error: too few arguments to fun=
ction 'mean_and_variance_weighted_update'
>   108 |                 mean_and_variance_weighted_update(&vw, data[i]);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:193:6: note: declared here
>   193 | void mean_and_variance_weighted_update(struct mean_and_variance_w=
eighted *s,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:112:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_mean'
>   112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  weighted_mean[i]);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:112:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  weighted_mean[i]);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:112:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_mean'
>   112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  weighted_mean[i]);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:112:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_mean(vw),  weighted_mean[i]);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:196:5: note: declared here
>   196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_=
weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:113:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_stddev'
>   113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),weighted_stddev[i]);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:113:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),weighted_stddev[i]);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:200:5: note: declared here
>   200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_varianc=
e_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:113:39: error: too few arguments to fun=
ction 'mean_and_variance_weighted_get_stddev'
>   113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),weighted_stddev[i]);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BIN=
ARY_ASSERTION'
>   693 |         const typeof(left) __left =3D (left);                    =
                \
>       |                                      ^~~~
> include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT=
_ASSERTION'
>   885 |         KUNIT_BINARY_INT_ASSERTION(test,                         =
              \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_=
MSG'
>   882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>       |         ^~~~~~~~~~~~~~~~~~~
> lib/math/mean_and_variance_test.c:113:17: note: in expansion of macro 'KU=
NIT_EXPECT_EQ'
>   113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_=
get_stddev(vw),weighted_stddev[i]);
>       |                 ^~~~~~~~~~~~~~~
> include/linux/mean_and_variance.h:200:5: note: declared here
>   200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_varianc=
e_weighted s,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   cfca113ae06c ("mean_and_variance: put struct mean_and_variance_weighted=
 on a diet")
>=20
> I have used the bcachefs tree from next-20240206 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/+oZln.xemLfhXAYoJ57d74V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFWbcACgkQAVBC80lX
0Gxo4gf/V+pd4OU1JfAKI7pRH0zvnqKalvOLXENAUTgoIcUofbFbb+wdv677UNR6
ZrLBs9rs/ZB/t7snKf3D15mKgtM2lj2kMdJ5rtUxldHLXZ0rnu+KT19uou9HW+dv
cDdtQZG0WxyEsCDtTIBGMCR3AMAgIviYAp08XsKAYBAYxN5mLaMakxPec9wIPjkg
0bt72cEI/9bJINPRL2vd4B3YpnQ6nJf5S14QH2Z7hj96ogE+5UvwL7g1QtX726YQ
uZhsKF1bNYqtrPAxZVPp1RvIsd+QKZorHg3b9jVMrZc37C8smgqh1dsSOAMRj40z
WJoSg5oBNnuu6ewahpVQnw+ouHPn0A==
=p6fv
-----END PGP SIGNATURE-----

--Sig_/+oZln.xemLfhXAYoJ57d74V--

