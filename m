Return-Path: <linux-kernel+bounces-25266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2998482CC06
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397431C21DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479922111B;
	Sat, 13 Jan 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfJU9lFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5F21110;
	Sat, 13 Jan 2024 10:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F2C43394;
	Sat, 13 Jan 2024 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705142634;
	bh=qojQBt1Bg5uxXkkZTt84eMBF6leDUzIvdOIhZFTxWJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfJU9lFpqCXpxLe3cUEJVHNlKj9bYF0BnzZ5d6mLCPGGPdtjo3QD6iFKiHXRO5fPa
	 iWFEe87kpbr8Yzh0AM4imdcM0scW3wz1Bo0ziue5WTqkXDbSY7HhmDmlULbtBpFK1E
	 /y1hSwvDHCctxdb266Fu0jmDviqyWpf1+7NInKslbmZPlTkcbw2AZThS94uNAoXPAm
	 KtBfoqHmXVCMkDWwd6ffeee7kqRckzHjbjH4F6fb9nVvC15GEekbc6/9hZ3mYUPih5
	 86KGP2y38KPmrx58DhYPXJx2cDhxg3krCG/izE6loXYiw1HgAZdnG3K4oIpirCNFyV
	 ZQyMJuSJIDJRA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] kbuild: deb-pkg: call more misc debhelper commands
Date: Sat, 13 Jan 2024 19:43:39 +0900
Message-Id: <20240113104339.16131-4-masahiroy@kernel.org>
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

Use dh_prep instead of removing old build directories manually.

Use dh_clean instead of removing build directories and debian/files
manually.

Call dh_testdir and dh_testroot for preliminary checks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

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
index 57f1cf7c6b32..ca07243bd5cd 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -42,6 +42,9 @@ package = $($(@:binary-%=%-package))
 DH_OPTIONS = -p$(package)
 
 define binary
+	$(Q)dh_testdir $(DH_OPTIONS)
+	$(Q)dh_testroot $(DH_OPTIONS)
+	$(Q)dh_prep $(DH_OPTIONS)
 	$(Q)+$(MAKE) $(make-opts) run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb $(package)'
 	$(Q)dh_installdocs $(DH_OPTIONS)
 	$(Q)dh_installchangelogs $(DH_OPTIONS)
@@ -72,7 +75,8 @@ build-arch:
 
 .PHONY: clean
 clean:
-	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars* debian/*.files
+	$(Q)dh_clean
+	$(Q)rm -rf debian/deb-env.vars* debian/*.files
 	$(Q)$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
-- 
2.40.1


