Return-Path: <linux-kernel+bounces-11531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2981E7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7521528311A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2424B4F200;
	Tue, 26 Dec 2023 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muzM/KiE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2924F1EC;
	Tue, 26 Dec 2023 13:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DAC433CB;
	Tue, 26 Dec 2023 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598778;
	bh=qV21Ddxy565YeVMxc5SZLejjsKbZ8CTNjuyHTzJU14s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muzM/KiEaiuwfCK9I8JLbD7PghAhWtcrnCeYuBNt+0ShtQnRV8n5Df7aT0Lpc2hAN
	 N1+3Pv87ppFluNbnEVskEMzSuuHelElRCW48pSbylCY5SauirAP+oGtWEPWFUp4CvG
	 kciQIGtBN+PIkvNl3GzjeTgcbuO4Fwvn/rZJP4pw5zS7O4NLntNqh1hmsgFn/Ly6qw
	 aWubuNusZ4E+iJIzkb6FlTB3N61MIcGBJOyovSmPxXF6LxcoJy4F6WLh473JNwNQd1
	 /byx4TG9CwIhmHcULXe63+cDKNuqMXEc/TnW8ulT3LWneaKcWGb26YZhXH0IbK/dk+
	 qJMGtqb5cUDKA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] kbuild: deb-pkg: squash scripts/package/deb-build-option to debian/rules
Date: Tue, 26 Dec 2023 22:52:39 +0900
Message-Id: <20231226135243.1393780-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231226135243.1393780-1-masahiroy@kernel.org>
References: <20231226135243.1393780-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binary-arch target needs to use the same CROSS_COMPILE as used in
build-arch; otherwise, 'make run-command' may attempt to resync the
.config file.

Squash scripts/package/deb-build-option into debian/rules, as it is a
small amount of code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/deb-build-option | 14 --------------
 scripts/package/debian/rules     |  5 +++--
 2 files changed, 3 insertions(+), 16 deletions(-)
 delete mode 100755 scripts/package/deb-build-option

diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
deleted file mode 100755
index 7950eff01781..000000000000
--- a/scripts/package/deb-build-option
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-only
-
-# Set up CROSS_COMPILE if not defined yet
-if [ "${CROSS_COMPILE+set}" != "set" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
-	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
-fi
-
-version=$(dpkg-parsechangelog -S Version)
-debian_revision="${version##*-}"
-
-if [ "${version}" != "${debian_revision}" ]; then
-	echo KBUILD_BUILD_VERSION=${debian_revision}
-fi
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 26bc6239e200..529b71b55efa 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -10,7 +10,9 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     MAKEFLAGS += -j$(NUMJOBS)
 endif
 
-make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE)
+revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
+CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
+make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
 
 .PHONY: binary binary-indep binary-arch
 binary: binary-arch binary-indep
@@ -24,7 +26,6 @@ build: build-arch build-indep
 build-indep:
 build-arch:
 	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
-	$(shell $(srctree)/scripts/package/deb-build-option) \
 	olddefconfig all
 
 .PHONY: clean
-- 
2.40.1


