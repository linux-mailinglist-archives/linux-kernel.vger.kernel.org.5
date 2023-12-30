Return-Path: <linux-kernel+bounces-13442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40988206A6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F83F2822A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D8D290;
	Sat, 30 Dec 2023 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiPoJCnP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38BC8E0;
	Sat, 30 Dec 2023 13:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FAFC433C9;
	Sat, 30 Dec 2023 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944331;
	bh=wJWQwmRdH1pPYpBRNITxKPq6OkG6pHAnNrHczJWgfW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiPoJCnP22eAYdYAiZX+dMT580mxQCjPUs2dBLOFiw8rPVeLqDnJruv+2nb7jbCe1
	 Jh9pAt/JFSL0xadph+YrfIf6J8RK+7hN0JuEXl9ygt7PFM+Kqra3bKga9vQz0c0sqk
	 ve8xgExFEuhXu5PVQknhRGMVH+G9kmIdf9p6JlcfU/eJncNPvGXNIgrk5R2RuNRKKI
	 rnDyo24RP9tVhZ0Nfv1OSQdDckJm+/CwxD8JMI5tm6rDBM41jIIy+DihM8ozAVilK+
	 YKk/VphOdSBF4ZZQUTw2jttBfSSJrZ2oLxveGl5Tfr3Y7yTPICouu1feVoufnQpHEi
	 zZsE2u4ShRUog==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kbuild: deb-pkg: call more misc debhelper commands
Date: Sat, 30 Dec 2023 22:52:00 +0900
Message-Id: <20231230135200.1058873-5-masahiroy@kernel.org>
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

Use dh_prep instead of removing old build directories manually.

Use dh_clean instead of removing build directories and debian/files
manually.

Call dh_testdir and dh_testroot for preliminary checks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb     | 8 --------
 scripts/package/debian/rules | 6 +++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index d31b16afe0db..e797ad360f7a 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -28,8 +28,6 @@ install_linux_image () {
 	pname=$1
 	pdir=debian/$1
 
-	rm -rf ${pdir}
-
 	# Only some architectures with OF support have this target
 	if is_enabled CONFIG_OF_EARLY_FLATTREE && [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
 		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
@@ -97,8 +95,6 @@ install_linux_image () {
 install_linux_image_dbg () {
 	pdir=debian/$1
 
-	rm -rf ${pdir}
-
 	# Parse modules.order directly because 'make modules_install' may sign,
 	# compress modules, and then run unneeded depmod.
 	while read -r mod; do
@@ -128,8 +124,6 @@ install_kernel_headers () {
 	pdir=debian/$1
 	version=${1#linux-headers-}
 
-	rm -rf $pdir
-
 	"${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
 
 	mkdir -p $pdir/lib/modules/$version/
@@ -139,8 +133,6 @@ install_kernel_headers () {
 install_libc_headers () {
 	pdir=debian/$1
 
-	rm -rf $pdir
-
 	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH=$pdir/usr
 
 	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 407f46a4a655..5c5554c70949 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -32,6 +32,9 @@ package = $($(@:binary-%=%-package))
 DH_OPTIONS = -p$(package)
 
 define binary
+	$(Q)dh_testdir $(DH_OPTIONS)
+	$(Q)dh_testroot $(DH_OPTIONS)
+	$(Q)dh_prep $(DH_OPTIONS)
 	$(Q)+$(MAKE) $(make-opts) run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb $(package)'
 	$(Q)dh_installdocs $(DH_OPTIONS)
 	$(Q)dh_installchangelogs $(DH_OPTIONS)
@@ -62,7 +65,8 @@ build-arch:
 
 .PHONY: clean
 clean:
-	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars* debian/*.files
+	$(Q)dh_clean
+	$(Q)rm -rf debian/deb-env.vars* debian/*.files
 	$(Q)$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
-- 
2.40.1


