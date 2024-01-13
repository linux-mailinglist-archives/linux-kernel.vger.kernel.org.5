Return-Path: <linux-kernel+bounces-25264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51E82CBFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75B9B2377F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91417210E0;
	Sat, 13 Jan 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXfPtKd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16120DF0;
	Sat, 13 Jan 2024 10:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADDFC43399;
	Sat, 13 Jan 2024 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705142630;
	bh=HMJz/xKuNKASWe7U/KjCcahJnEqUSiHLAv6q7X00jEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqXfPtKdBkT6GvG/yhrB2yc0Gt4paaqmZX4rihliFQ0ejqVzqmlWi9Zlbk687+8pW
	 JI5tQiMnVggTXky8xt32AAtLLOtA+FARcwJYgdCIjEpaTvpzTcCsYHeGl2OTVpRmuU
	 fnjOP6SZRQS+XMrpBlqbPk0Y/3+Urd0IyQvqSak/zvAmy2jgrKQWdPE76+Ir9MCh4u
	 t7cZqIZKZcwh3YRdmivMKnOG81vkHFED/qM6q8nMj7vMR5O2O4K1rJThrR8oQ58Thf
	 SVC4e5c/P5ZgbcvxQqZMit0F10zSXdtRSe7WJkOh5drQa/b0Ah0VBPzptshLYUcE+0
	 mrpnmlrJcZsBw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] kbuild: deb-pkg: make debian/rules quiet for 'make deb-pkg'
Date: Sat, 13 Jan 2024 19:43:37 +0900
Message-Id: <20240113104339.16131-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240113104339.16131-1-masahiroy@kernel.org>
References: <20240113104339.16131-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add $(Q) to the commands in debian/rules to make them quiet when the
package built is initiated by 'make deb-pkg' or when the 'terse' tag
is set to DEB_BUILD_OPTIONS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

Changes in v2:
  - Rebased

 scripts/package/debian/rules | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 697fbfa7595f..a183e95886e6 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -16,6 +16,8 @@ endif
 ifeq ($(origin KBUILD_VERBOSE),undefined)
     ifeq (,$(filter terse,$(DEB_BUILD_OPTIONS)))
         export KBUILD_VERBOSE := 1
+    else
+        Q := @
     endif
 endif
 
@@ -27,20 +29,20 @@ make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(r
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
-	$(MAKE) $(make-opts) $(if $(filter um,$(ARCH)),,headers) all
+	$(Q)$(MAKE) $(make-opts) olddefconfig
+	$(Q)$(MAKE) $(make-opts) $(if $(filter um,$(ARCH)),,headers) all
 
 .PHONY: clean
 clean:
-	rm -rf debian/files debian/linux-* debian/deb-env.vars*
-	$(MAKE) ARCH=$(ARCH) clean
+	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars*
+	$(Q)$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
 # directly. Run 'dpkg-architecture --print-set --print-format=make' to
@@ -49,6 +51,6 @@ ifndef DEB_HOST_ARCH
 include debian/deb-env.vars
 
 debian/deb-env.vars:
-	dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@.tmp
-	mv $@.tmp $@
+	$(Q)dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@.tmp
+	$(Q)mv $@.tmp $@
 endif
-- 
2.40.1


