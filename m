Return-Path: <linux-kernel+bounces-55775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10384C199
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7679B1F240C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA77DDCA;
	Wed,  7 Feb 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OFO8/Zw9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400BDDA0;
	Wed,  7 Feb 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267483; cv=none; b=ig43G18L1uBIOt6+1GF7J3QJoAC7xYYxRwyWDwYjzVnW18cdTAtSaQTTclYsIESt1y5R2yHqsOhM4NWaXcSlDqhInn/Wh6N1cqUOKyP/XFz6kPBmJD+ODto2LufTlWrw9cLOwEKEdJG/lT6Bb6iZUKi6i+vQIymU2ECLjcptTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267483; c=relaxed/simple;
	bh=aamFGoPuuPNKo8wINB10T1qgkZ9RmcVwN1zMQnmqm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dXvH5QR2RT+BSv4PqaYk7RR+2D+jhyLznIXO/NcUTR6MN4FGno5nMK/YO+gK3RkQ+RgkC/dJhecfYZHFhc58Rhokbv0yRsTlHGvZmauBhCFoS1FQZkyUp3lIG5S04FxESYpCtkPo5tAUdeh8PJJfk30VUJIqLvh7UfELXHIdD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OFO8/Zw9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707267477;
	bh=gS9bVi7d3BuAti1Fxp4166y1qwPviW9FAAk3mEXw2ao=;
	h=Date:From:To:Cc:Subject:From;
	b=OFO8/Zw9w9U2n+PYkbhppbFofbYoenMTVaU0lZ2W3R9UjxuIQ8Itz6s9RvXh445ym
	 v2aheaB2+uV92sS3g/KM/U9EI3W2flh5yBCQQMgqI/KXpUr3Q7RMd2hG8T2xUcmVhV
	 sFV4kHSMrpBfEq8qqlpL6A0H03m6MTrkbIH3LPf44toqZ0vU5fZN6+WZEhpXEKPDq0
	 JpHhs0wCMHIRakSdYilhCWnVJiaf3VkyvKVG+jFRjLu0ubwpct7Fn985TeMgK5jzWO
	 mpOxPCwAnLgr0XtdPXWRy34pIObUaHM2EQX2wAc8ty7FF+vej1ijFAoMH+NNT9wPQq
	 VeDFbTHpPayNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV1ts0DKPz4wc9;
	Wed,  7 Feb 2024 11:57:56 +1100 (AEDT)
Date: Wed, 7 Feb 2024 11:57:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Subject: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20240207115755.338828db@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FUoC2WMT2BdTrO0IRcOIzeS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FUoC2WMT2BdTrO0IRcOIzeS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

lib/math/mean_and_variance_test.c: In function 'mean_and_variance_weighted_=
test':
lib/math/mean_and_variance_test.c:33:50: error: 'struct mean_and_variance_w=
eighted' has no member named 'weight'
   33 |         struct mean_and_variance_weighted s =3D { .weight =3D 2 };
      |                                                  ^~~~~~
lib/math/mean_and_variance_test.c:35:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   35 |         mean_and_variance_weighted_update(&s, 10);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from lib/math/mean_and_variance_test.c:3:
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from lib/math/mean_and_variance_test.c:2:
lib/math/mean_and_variance_test.c:36:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 10);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:36:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 10);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:36:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 10);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:36:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   36 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 10);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:37:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:37:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:37:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:37:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   37 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:39:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   39 |         mean_and_variance_weighted_update(&s, 20);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:40:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 12);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:40:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 12);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:40:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 12);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:40:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   40 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 12);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:41:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:41:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:41:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:41:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   41 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:43:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   43 |         mean_and_variance_weighted_update(&s, 30);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:44:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 16);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:44:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 16);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:44:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 16);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:44:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   44 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 16);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:45:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:45:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:45:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:45:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   45 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:47:52: error: 'struct mean_and_variance_w=
eighted' has no member named 'weight'
   47 |         s =3D (struct mean_and_variance_weighted) { .weight =3D 2 };
      |                                                    ^~~~~~
lib/math/mean_and_variance_test.c:49:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   49 |         mean_and_variance_weighted_update(&s, -10);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:50:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -10);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:50:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -10);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:50:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -10);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:50:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   50 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -10);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:51:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:51:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:51:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:51:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   51 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 0);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:53:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   53 |         mean_and_variance_weighted_update(&s, -20);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:54:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -12);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:54:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -12);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:54:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -12);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:54:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   54 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -12);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:55:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:55:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:55:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:55:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   55 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 18);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:57:9: error: too few arguments to functio=
n 'mean_and_variance_weighted_update'
   57 |         mean_and_variance_weighted_update(&s, -30);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:58:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -16);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:58:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -16);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:58:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -16);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:58:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   58 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -16);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:59:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:59:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:59:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:59:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   59 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 72);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c: In function 'mean_and_variance_weighted_=
advanced_test':
lib/math/mean_and_variance_test.c:64:50: error: 'struct mean_and_variance_w=
eighted' has no member named 'weight'
   64 |         struct mean_and_variance_weighted s =3D { .weight =3D 8 };
      |                                                  ^~~~~~
lib/math/mean_and_variance_test.c:68:17: error: too few arguments to functi=
on 'mean_and_variance_weighted_update'
   68 |                 mean_and_variance_weighted_update(&s, i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:70:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 11);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:70:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 11);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:70:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 11);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:70:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   70 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), 11);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:71:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:71:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:71:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:71:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   71 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:73:52: error: 'struct mean_and_variance_w=
eighted' has no member named 'weight'
   73 |         s =3D (struct mean_and_variance_weighted) { .weight =3D 8 };
      |                                                    ^~~~~~
lib/math/mean_and_variance_test.c:76:17: error: too few arguments to functi=
on 'mean_and_variance_weighted_update'
   76 |                 mean_and_variance_weighted_update(&s, i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:78:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -11);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:78:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -11);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:78:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_mean'
   78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -11);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:78:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   78 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s=
), -11);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:79:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:79:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:79:31: error: too few arguments to functi=
on 'mean_and_variance_weighted_get_variance'
   79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:79:9: note: in expansion of macro 'KUNIT_=
EXPECT_EQ'
   79 |         KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_varian=
ce(s), 107);
      |         ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:198:5: note: declared here
  198 | u64 mean_and_variance_weighted_get_variance(struct mean_and_varianc=
e_weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c: In function 'do_mean_and_variance_test':
lib/math/mean_and_variance_test.c:94:51: error: 'struct mean_and_variance_w=
eighted' has no member named 'weight'
   94 |         struct mean_and_variance_weighted vw =3D { .weight =3D weig=
ht };
      |                                                   ^~~~~~
lib/math/mean_and_variance_test.c:98:17: error: too few arguments to functi=
on 'mean_and_variance_weighted_update'
   98 |                 mean_and_variance_weighted_update(&vw, initial_valu=
e);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:102:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_mean'
  102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  initial_value);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:102:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  initial_value);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:102:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_mean'
  102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  initial_value);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:102:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  102 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  initial_value);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:103:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_stddev'
  103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),0);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:103:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),0);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:200:5: note: declared here
  200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_=
weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:103:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_stddev'
  103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),0);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:103:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  103 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),0);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:200:5: note: declared here
  200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_=
weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:108:17: error: too few arguments to funct=
ion 'mean_and_variance_weighted_update'
  108 |                 mean_and_variance_weighted_update(&vw, data[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:193:6: note: declared here
  193 | void mean_and_variance_weighted_update(struct mean_and_variance_wei=
ghted *s,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:112:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_mean'
  112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  weighted_mean[i]);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:112:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  weighted_mean[i]);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:112:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_mean'
  112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  weighted_mean[i]);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:112:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  112 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_mean(vw),  weighted_mean[i]);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:196:5: note: declared here
  196 | s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_we=
ighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:113:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_stddev'
  113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),weighted_stddev[i]);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/kunit/test.h:693:22: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:113:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),weighted_stddev[i]);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:200:5: note: declared here
  200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_=
weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:113:39: error: too few arguments to funct=
ion 'mean_and_variance_weighted_get_stddev'
  113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),weighted_stddev[i]);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/kunit/test.h:693:38: note: in definition of macro 'KUNIT_BASE_BINAR=
Y_ASSERTION'
  693 |         const typeof(left) __left =3D (left);                      =
              \
      |                                      ^~~~
include/kunit/test.h:885:9: note: in expansion of macro 'KUNIT_BINARY_INT_A=
SSERTION'
  885 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:882:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MS=
G'
  882 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
lib/math/mean_and_variance_test.c:113:17: note: in expansion of macro 'KUNI=
T_EXPECT_EQ'
  113 |                 KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_ge=
t_stddev(vw),weighted_stddev[i]);
      |                 ^~~~~~~~~~~~~~~
include/linux/mean_and_variance.h:200:5: note: declared here
  200 | u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_=
weighted s,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  cfca113ae06c ("mean_and_variance: put struct mean_and_variance_weighted o=
n a diet")

I have used the bcachefs tree from next-20240206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/FUoC2WMT2BdTrO0IRcOIzeS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXC1ZMACgkQAVBC80lX
0GyrTggAnPLDA+g9GQtKygc1E1Ub69fq6tFKHlKqca/oWvIn4rjzSQ7zsGhQhv31
R5y+yHvVZRj8UZGcrIW36XmKbKL1seEZ6Rlj6uMGOrzZ/d0Oxxs7Qrj0C4P6UfPs
bDhlKVewAMKxXb3k8gQ/To51mdnVrg7IJ3UGycoqCHbgHZeiqjpN1chrW6/yvOfY
vs8pfkJNnfzGEkFPkrPTyIjg93kkhggkdje5tcuE3Rx0F9e8kSNsmebOp7jCeWl6
Gt7GH5TBtDnD81A5VQ3oGqqgfIaQsYyYLz0TcJkTnbRh4H8UNDTCfGHFdKBYXP89
X7X9A8BTvCXPH3JUUEFS7w/AIbYFHw==
=2fGa
-----END PGP SIGNATURE-----

--Sig_/FUoC2WMT2BdTrO0IRcOIzeS--

