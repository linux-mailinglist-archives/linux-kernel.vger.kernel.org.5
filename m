Return-Path: <linux-kernel+bounces-13439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345288206A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF04FB213BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B8946C;
	Sat, 30 Dec 2023 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMHcSBpv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7D8F65;
	Sat, 30 Dec 2023 13:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B0DC433CB;
	Sat, 30 Dec 2023 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944326;
	bh=kDbLJxPgBxd0hxuVu8WO1yEFieOFRTfcfLs0cYwU+DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMHcSBpvo7B5K13+zqSWNAHlxna6pKVh2SM6n1VZ7bNqHaA/sxvQ+wWj7TFo2uFkp
	 jSX0Nl0GQdqc6shqmy3oJGcFSs1uhZYoHdn4P5XCwnpYeQF5Q1WP1OHbUE4lp4AZPt
	 AFViReyWtCCUF/r/8c3W+DRwlogPOTbj4jw/od6rqmk2kJoNUZ4+LvvQO5zYFxc7/K
	 oMIlz7TyByTbYORuNOO/SjXC2M1hiMWMKD67WlJZDYXSm4v21SeUXZgWT8TaSoJ9iu
	 NCKZI9q9YGrbkXA6QFpv6J153orCu1nKxYIf+XRZ4nYP4nCkIxI0HJw7fENKir2RKQ
	 05EPLKopj/yKg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kbuild: deb-pkg: make debian/rules quiet by default
Date: Sat, 30 Dec 2023 22:51:57 +0900
Message-Id: <20231230135200.1058873-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231230135200.1058873-1-masahiroy@kernel.org>
References: <20231230135200.1058873-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add $(Q) to commands in debian/rules to make them quiet when the package
built is initiated by 'make deb-pkg'.

While the commands in debian/rules are not hidden when you directly work
with the debianized tree, you can set 'terse' to DEB_BUILD_OPTIONS to
silence them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/debian/rules | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index a686c37d0d02..b3f80f62236c 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -11,6 +11,10 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     MAKEFLAGS += -j$(NUMJOBS)
 endif
 
+ifneq (,$(filter terse,$(DEB_BUILD_OPTIONS)))
+    Q ?= @
+endif
+
 revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
 CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
 make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
@@ -19,20 +23,20 @@ make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(r
 binary: binary-arch binary-indep
 binary-indep: build-indep
 binary-arch: build-arch
-	$(MAKE) $(make-opts) \
+	$(Q)$(MAKE) $(make-opts) \
 	run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb'
 
 .PHONY: build build-indep build-arch
 build: build-arch build-indep
 build-indep:
 build-arch:
-	$(MAKE) $(make-opts) olddefconfig
-	$(MAKE) $(make-opts) headers all
+	$(Q)$(MAKE) $(make-opts) olddefconfig
+	$(Q)$(MAKE) $(make-opts) headers all
 
 .PHONY: clean
 clean:
-	rm -rf debian/files debian/linux-* debian/deb-env.vars*
-	$(MAKE) ARCH=$(ARCH) clean
+	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars*
+	$(Q)$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
 # directly. Run 'dpkg-architecture --print-set --print-format=make' to
@@ -41,6 +45,6 @@ ifndef DEB_HOST_ARCH
 -include debian/deb-env.vars
 
 debian/deb-env.vars:
-	dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@.tmp
-	mv $@.tmp $@
+	$(Q)dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@.tmp
+	$(Q)mv $@.tmp $@
 endif
-- 
2.40.1


