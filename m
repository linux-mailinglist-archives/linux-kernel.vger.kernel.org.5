Return-Path: <linux-kernel+bounces-13441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E08206A4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164EA1C212B8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DBBE67;
	Sat, 30 Dec 2023 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz9XIKbG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B1BA45;
	Sat, 30 Dec 2023 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D8C433CC;
	Sat, 30 Dec 2023 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944329;
	bh=zkEEcJ/BgQNaFI4OxXzXZP6UJ1d1sIRgE54D7s6R+qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sz9XIKbGux9/yCiAJKc/VEsKOUFvOmYZ/RxfNRUIR1zegZ1OCuj7NZX638OkksG2t
	 RRgFgHtmUzM1pXFn0LfCZHZ1dXTdfy80HqIAVPuYVnNeM+pfb5ed/7UumDSWAl2rXX
	 Zwb+fX0YI1XNUwQI/xImeQ3ScpVF7vnNchubDGcBaKCXSthAF1ofVKZf2kN0qMYi6p
	 PT3LbIaoRsK2eUGmW9pIM6rID8WeFlfmpDFfokg+NTs0Wky4l4hbSfitq5YD0pEi6Z
	 7vJilJfGZKjcV7x79G0qdPFlI8hWsHJOcf7fVmEttCAsrbvfCWCF+Au+Eu+5wMveWp
	 0EzigAzrZDa5w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kbuild: deb-pkg: build binary-arch in parallel
Date: Sat, 30 Dec 2023 22:51:59 +0900
Message-Id: <20231230135200.1058873-4-masahiroy@kernel.org>
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

'make deb-pkg' builds build-arch in parallel, but binary-arch serially.

Given that all binary packages are independent of one another, they can
be built in parallel.

I am uncertain whether debian/files is robust against a race condition.
Just in case, make dh_gencontrol (dpkg-gencontrol) output to separate
debian/*.files, which are then concatenated into debian/files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb     | 40 ++++++++++--------------------------
 scripts/package/debian/rules | 35 +++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index bf96a3c24608..d31b16afe0db 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -24,18 +24,6 @@ if_enabled_echo() {
 	fi
 }
 
-create_package() {
-	export DH_OPTIONS="-p${1}"
-
-	dh_installdocs
-	dh_installchangelogs
-	dh_compress
-	dh_fixperms
-	dh_gencontrol
-	dh_md5sums
-	dh_builddeb -- ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS}
-}
-
 install_linux_image () {
 	pname=$1
 	pdir=debian/$1
@@ -161,21 +149,15 @@ install_libc_headers () {
 	mv "$pdir/usr/include/asm" "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
 }
 
-rm -f debian/files
+package=$1
 
-packages_enabled=$(dh_listpackages)
-
-for package in ${packages_enabled}
-do
-	case ${package} in
-	*-dbg)
-		install_linux_image_dbg "${package}";;
-	linux-image-*|user-mode-linux-*)
-		install_linux_image "${package}";;
-	linux-libc-dev)
-		install_libc_headers "${package}";;
-	linux-headers-*)
-		install_kernel_headers "${package}";;
-	esac
-	create_package "${package}"
-done
+case "${package}" in
+*-dbg)
+	install_linux_image_dbg "${package}";;
+linux-image-*|user-mode-linux-*)
+	install_linux_image "${package}";;
+linux-libc-dev)
+	install_libc_headers "${package}";;
+linux-headers-*)
+	install_kernel_headers "${package}";;
+esac
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index b3f80f62236c..407f46a4a655 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -19,12 +19,39 @@ revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
 CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
 make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
 
+binary-targets := $(addprefix binary-, image image-dbg headers libc-dev)
+
+all-packages = $(shell dh_listpackages)
+image-package = $(filter linux-image-% user-%, $(filter-out %-dbg, $(all-packages)))
+image-dbg-package = $(filter %-dbg, $(all-packages))
+libc-dev-package = $(filter linux-libc-dev, $(all-packages))
+headers-package = $(filter linux-headers-%, $(all-packages))
+
+mk-files = $(patsubst binary-%,debian/%.files,$1)
+package = $($(@:binary-%=%-package))
+DH_OPTIONS = -p$(package)
+
+define binary
+	$(Q)+$(MAKE) $(make-opts) run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb $(package)'
+	$(Q)dh_installdocs $(DH_OPTIONS)
+	$(Q)dh_installchangelogs $(DH_OPTIONS)
+	$(Q)dh_compress $(DH_OPTIONS)
+	$(Q)dh_fixperms $(DH_OPTIONS)
+	$(Q)dh_gencontrol $(DH_OPTIONS) -- -f$(call mk-files,$@)
+	$(Q)dh_md5sums $(DH_OPTIONS)
+	$(Q)dh_builddeb $(DH_OPTIONS) -- $(addprefix -Z,$(KDEB_COMPRESS))
+endef
+
+.PHONY: $(binary-targets)
+$(binary-targets): build-arch
+	$(Q)truncate -s0 $(call mk-files,$@)
+	$(if $(package),$(binary))
+
 .PHONY: binary binary-indep binary-arch
 binary: binary-arch binary-indep
 binary-indep: build-indep
-binary-arch: build-arch
-	$(Q)$(MAKE) $(make-opts) \
-	run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb'
+binary-arch: $(binary-targets)
+	$(Q)cat $(call mk-files,$^) > debian/files
 
 .PHONY: build build-indep build-arch
 build: build-arch build-indep
@@ -35,7 +62,7 @@ build-arch:
 
 .PHONY: clean
 clean:
-	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars*
+	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars* debian/*.files
 	$(Q)$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
-- 
2.40.1


