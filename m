Return-Path: <linux-kernel+bounces-79387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637886217B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396D31C22DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C4946AD;
	Sat, 24 Feb 2024 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/XMuoCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565717CE;
	Sat, 24 Feb 2024 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736959; cv=none; b=e3WNrF6aDDKVTrnpr/MTHoAD6p2XnaIuNXMtKjt8OX6NjBJy0r7q3zsmJfct5wsO9n/KJE1EK+my7N/FFQN22w+KWJSP4tVY3E09EYS7BN9llmggX4Zfmi6170xEEZkufzDpgPo39jzFs+9hr6REBoeSn5aLnpBuhmmy6mc03SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736959; c=relaxed/simple;
	bh=my5CMJ6zcBl0pr3HLHlWJzmJozak4gldUem21XvufyY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABRv+r/BZPt1RLuSwnXMsz12B1Q5aKLsSQWLvbmXj8BsrxHasgBm4iuvYx5D9Jous4AvkD+9TONNh/l1Uz/KRmerO2Mou0jTt98U4zbIB+aDHVd3gbdex2OKZbfajpKS9J5JpB4oy6s2rZGcOwqmAoX2sg8Xv8ymAEfv14DSO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/XMuoCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D75C433F1;
	Sat, 24 Feb 2024 01:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736959;
	bh=my5CMJ6zcBl0pr3HLHlWJzmJozak4gldUem21XvufyY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R/XMuoCLiw1FNWNs41PzqM4GRnA2W0IPhEeQxgh3IE0+aJ3MGlfU7aMBX/h+rnfzg
	 IJOaB02lbRDqN78vIZ6OJzrkV8grSR7BU5mynm32QfUYyqtxklqmK34HQMHyc8tllu
	 xp0KMn1NaenWIIyNhzYW/no6P8INUUP44SQtiA+61fBoaGwJm5go5DapsIddMJwM1o
	 gYyJWH7OSSEEL0U/3dtXTfClieAPgQg3rN4LGvosmK1A4k00pvnRsGvlYkZRU1NR6Z
	 TFpjWmdPvEvPyjF5iUxF8W7ccrbChkHHglv5EZTp7AusrvLnyMTjKFV3MjUd33vCIy
	 DQd9xKJ51Kg9Q==
Date: Fri, 23 Feb 2024 17:09:18 -0800
Subject: [PATCH 1/4] mean and variance: Promote to lib/math
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667510.1860799.10812652044600913490.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
References: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

Small statistics library, for taking in a series of value and computing
mean, weighted mean, standard deviation and weighted deviation.

The main use case is for statistics on latency measurements.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Daniel Hill <daniel@gluo.nz>
Cc: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                          |    9 +++++++++
 fs/bcachefs/Kconfig                  |   10 +---------
 fs/bcachefs/Makefile                 |    3 ---
 fs/bcachefs/util.c                   |    2 +-
 fs/bcachefs/util.h                   |    3 +--
 include/linux/mean_and_variance.h    |    0 
 lib/Kconfig.debug                    |    9 +++++++++
 lib/math/Kconfig                     |    3 +++
 lib/math/Makefile                    |    2 ++
 lib/math/mean_and_variance.c         |    3 +--
 lib/math/mean_and_variance_test.c    |    3 +--
 11 files changed, 28 insertions(+), 19 deletions(-)
 rename fs/bcachefs/mean_and_variance.h => include/linux/mean_and_variance.h (100%)
 rename fs/bcachefs/mean_and_variance.c => lib/math/mean_and_variance.c (99%)
 rename fs/bcachefs/mean_and_variance_test.c => lib/math/mean_and_variance_test.c (99%)


diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d38685394..3e13de69b7f07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13387,6 +13387,15 @@ S:	Maintained
 F:	drivers/net/mdio/mdio-regmap.c
 F:	include/linux/mdio/mdio-regmap.h
 
+MEAN AND VARIANCE LIBRARY
+M:	Daniel B. Hill <daniel@gluo.nz>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+T:	git https://github.com/YellowOnion/linux/
+F:	include/linux/mean_and_variance.h
+F:	lib/math/mean_and_variance.c
+F:	lib/math/mean_and_variance_test.c
+
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 5cdfef3b551a7..72d1179262b33 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -24,6 +24,7 @@ config BCACHEFS_FS
 	select XXHASH
 	select SRCU
 	select SYMBOLIC_ERRNAME
+	select MEAN_AND_VARIANCE
 	help
 	The bcachefs filesystem - a modern, copy on write filesystem, with
 	support for multiple devices, compression, checksumming, etc.
@@ -86,12 +87,3 @@ config BCACHEFS_SIX_OPTIMISTIC_SPIN
 	Instead of immediately sleeping when attempting to take a six lock that
 	is held by another thread, spin for a short while, as long as the
 	thread owning the lock is running.
-
-config MEAN_AND_VARIANCE_UNIT_TEST
-	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	depends on BCACHEFS_FS
-	default KUNIT_ALL_TESTS
-	help
-	  This option enables the kunit tests for mean_and_variance module.
-	  If unsure, say N.
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 1a05cecda7cc5..b11ba74b8ad41 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -57,7 +57,6 @@ bcachefs-y		:=	\
 	keylist.o		\
 	logged_ops.o		\
 	lru.o			\
-	mean_and_variance.o	\
 	migrate.o		\
 	move.o			\
 	movinggc.o		\
@@ -88,5 +87,3 @@ bcachefs-y		:=	\
 	util.o			\
 	varint.o		\
 	xattr.o
-
-obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 231003b405efc..c9d13dcf3ef1a 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -22,9 +22,9 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/sched/clock.h>
+#include <linux/mean_and_variance.h>
 
 #include "eytzinger.h"
-#include "mean_and_variance.h"
 #include "util.h"
 
 static const char si_units[] = "?kMGTPEZY";
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index b414736d59a5b..0059481995ef7 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -17,8 +17,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
-
-#include "mean_and_variance.h"
+#include <linux/mean_and_variance.h>
 
 #include "darray.h"
 
diff --git a/fs/bcachefs/mean_and_variance.h b/include/linux/mean_and_variance.h
similarity index 100%
rename from fs/bcachefs/mean_and_variance.h
rename to include/linux/mean_and_variance.h
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc0..817ddfe132cda 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2191,6 +2191,15 @@ config CPUMASK_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEAN_AND_VARIANCE_UNIT_TEST
+	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select MEAN_AND_VARIANCE
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the kunit tests for mean_and_variance module.
+	  If unsure, say N.
+
 config TEST_LIST_SORT
 	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index 0634b428d0cb7..7530ae9a3584f 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,6 @@ config PRIME_NUMBERS
 
 config RATIONAL
 	tristate
+
+config MEAN_AND_VARIANCE
+	tristate
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 91fcdb0c9efe4..8cdfa13a67ce0 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -4,6 +4,8 @@ obj-y += div64.o gcd.o lcm.o int_log.o int_pow.o int_sqrt.o reciprocal_div.o
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
+obj-$(CONFIG_MEAN_AND_VARIANCE) += mean_and_variance.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/fs/bcachefs/mean_and_variance.c b/lib/math/mean_and_variance.c
similarity index 99%
rename from fs/bcachefs/mean_and_variance.c
rename to lib/math/mean_and_variance.c
index bf0ef668fd383..ba90293204bae 100644
--- a/fs/bcachefs/mean_and_variance.c
+++ b/lib/math/mean_and_variance.c
@@ -40,10 +40,9 @@
 #include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/math64.h>
+#include <linux/mean_and_variance.h>
 #include <linux/module.h>
 
-#include "mean_and_variance.h"
-
 u128_u u128_div(u128_u n, u64 d)
 {
 	u128_u r;
diff --git a/fs/bcachefs/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
similarity index 99%
rename from fs/bcachefs/mean_and_variance_test.c
rename to lib/math/mean_and_variance_test.c
index 019583c3ca0ea..f45591a169d87 100644
--- a/fs/bcachefs/mean_and_variance_test.c
+++ b/lib/math/mean_and_variance_test.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <kunit/test.h>
-
-#include "mean_and_variance.h"
+#include <linux/mean_and_variance.h>
 
 #define MAX_SQR (SQRT_U64_MAX*SQRT_U64_MAX)
 


