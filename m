Return-Path: <linux-kernel+bounces-13440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65538206A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728CC1F21AF5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847ABA26;
	Sat, 30 Dec 2023 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgkfbaYC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F0B661;
	Sat, 30 Dec 2023 13:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB020C433C8;
	Sat, 30 Dec 2023 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944328;
	bh=h/bVRvqBDpxa6Xn0ybqaJ9bxYvhDa1MDNIDx4fYYn6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgkfbaYCDnHDqECG5hJVZR4EQlngt3vDZwFAgOzAFgdXSBoJ7FXVGq7VOueQuzxsS
	 hHwa1t8KnFh4E8L5rr3MbbignJ7mDEOXoiTR+DXXqLlfemzFZH+S4PhLjRW3VnYPDk
	 drVHFhSJcJ+E51onp3H6vscUszm3mH33sAR4eu3Bzkm2bSq0EhdWkrkGruZAITfeoD
	 3+dJPOhpQpfo5Dvbul59uZCTRhsL2nKuExlfb/YIxeUUtr2ais4vJRqBHClToyoY7K
	 pWYhp24PFAfwIfpLQsdHfiMLV5cndhZ14/E409qw7CADQ2RFYaHQNSamG1yrtZtD2U
	 FwCxOQ9coOuJg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kbuild: deb-pkg: use debian/<package> for tmpdir
Date: Sat, 30 Dec 2023 22:51:58 +0900
Message-Id: <20231230135200.1058873-3-masahiroy@kernel.org>
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

Use debian/<package> for tmpdir, which is the default of debhelper.
This simplifies the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 41 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 842ee4b40528..bf96a3c24608 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -25,9 +25,7 @@ if_enabled_echo() {
 }
 
 create_package() {
-	local pname="$1" pdir="$2"
-
-	export DH_OPTIONS="-p${pname} -P${pdir}"
+	export DH_OPTIONS="-p${1}"
 
 	dh_installdocs
 	dh_installchangelogs
@@ -39,8 +37,8 @@ create_package() {
 }
 
 install_linux_image () {
-	pdir=$1
-	pname=$2
+	pname=$1
+	pdir=debian/$1
 
 	rm -rf ${pdir}
 
@@ -109,7 +107,7 @@ install_linux_image () {
 }
 
 install_linux_image_dbg () {
-	pdir=$1
+	pdir=debian/$1
 
 	rm -rf ${pdir}
 
@@ -139,8 +137,8 @@ install_linux_image_dbg () {
 }
 
 install_kernel_headers () {
-	pdir=$1
-	version=$2
+	pdir=debian/$1
+	version=${1#linux-headers-}
 
 	rm -rf $pdir
 
@@ -151,7 +149,7 @@ install_kernel_headers () {
 }
 
 install_libc_headers () {
-	pdir=$1
+	pdir=debian/$1
 
 	rm -rf $pdir
 
@@ -171,28 +169,13 @@ for package in ${packages_enabled}
 do
 	case ${package} in
 	*-dbg)
-		install_linux_image_dbg debian/linux-image-dbg;;
+		install_linux_image_dbg "${package}";;
 	linux-image-*|user-mode-linux-*)
-		install_linux_image debian/linux-image ${package};;
+		install_linux_image "${package}";;
 	linux-libc-dev)
-		install_libc_headers debian/linux-libc-dev;;
+		install_libc_headers "${package}";;
 	linux-headers-*)
-		install_kernel_headers debian/linux-headers ${package#linux-headers-};;
+		install_kernel_headers "${package}";;
 	esac
+	create_package "${package}"
 done
-
-for package in ${packages_enabled}
-do
-	case ${package} in
-	*-dbg)
-		create_package ${package} debian/linux-image-dbg;;
-	linux-image-*|user-mode-linux-*)
-		create_package ${package} debian/linux-image;;
-	linux-libc-dev)
-		create_package ${package} debian/linux-libc-dev;;
-	linux-headers-*)
-		create_package ${package} debian/linux-headers;;
-	esac
-done
-
-exit 0
-- 
2.40.1


