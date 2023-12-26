Return-Path: <linux-kernel+bounces-11535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F081E7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895071F22998
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011050259;
	Tue, 26 Dec 2023 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgBVAgpa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130B4EB5E;
	Tue, 26 Dec 2023 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16D5C433CA;
	Tue, 26 Dec 2023 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598785;
	bh=Xd3RiHeuNxlRf7T5i6AVEz2ZQo7xF4C6gARQq5XvO3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgBVAgpa6Mx1oNF36hARX877uYe/EOtNlyhZoVHLngzwJVt6yp2RDtyng8vyZUCsW
	 PTqrIWxpbVVeQgO4Oz/SnlroG04pZdSQ3BPOqNpBDJ5kTb71GMuT9cQXd+5P7+0+ap
	 zHoAlPNpgIpv9PHUpizffQ09MQqNUbC9o7TlsgwB66ke/FmncOgMNxTUix4NF6Tjpe
	 SnBDzugE8xAVvBWS84voRh6oAh0RW4B6PdgzJbapSVNkpikfsB8Oy+OhUVwgpsEkpJ
	 7xRFDYEJE3B43+8Ps/VnYzYUcbcM6q/WZN4WWzPzMYI6al4Y+f2Yk4EtKkvx1ZeD/e
	 jbYrym1T/OTcw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] kbuild: deb-pkg: use more debhelper commands in builddeb
Date: Tue, 26 Dec 2023 22:52:43 +0900
Message-Id: <20231226135243.1393780-6-masahiroy@kernel.org>
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

Commit 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know
enabled packages") started to require the debhelper tool suite.

Use more dh_* commands in create_package():

 - dh_installdocs to install copyright
 - dh_installchangelogs to install changelog
 - dh_compress to compress changelog
 - dh_fixperms to replace the raw chmod command
 - dh_gencontrol to replace the raw dpkg-gencontrol command
 - dh_md5sums to record the md5sum of included files
 - dh_builddeb to replace the raw dpkg-deb command

Set DEB_RULES_REQUIRES_ROOT to 'no' in case debian/rules is executed
directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

 scripts/package/builddeb     | 23 ++++++++---------------
 scripts/package/debian/rules |  2 ++
 scripts/package/mkdebian     |  2 +-
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 2eb4910f0ef3..436d55a83ab0 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -26,23 +26,16 @@ if_enabled_echo() {
 
 create_package() {
 	local pname="$1" pdir="$2"
-	local dpkg_deb_opts
 
-	mkdir -m 755 -p "$pdir/DEBIAN"
-	mkdir -p "$pdir/usr/share/doc/$pname"
-	cp debian/copyright "$pdir/usr/share/doc/$pname/"
-	cp debian/changelog "$pdir/usr/share/doc/$pname/changelog.Debian"
-	gzip -n -9 "$pdir/usr/share/doc/$pname/changelog.Debian"
-	sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%P\0' \
-		| xargs -r0 md5sum > DEBIAN/md5sums"
+	export DH_OPTIONS="-p${pname} -P${pdir}"
 
-	# a+rX in case we are in a restrictive umask environment like 0077
-	# ug-s in case we build in a setuid/setgid directory
-	chmod -R go-w,a+rX,ug-s "$pdir"
-
-	# Create the package
-	dpkg-gencontrol -p$pname -P"$pdir"
-	dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
+	dh_installdocs
+	dh_installchangelogs
+	dh_compress
+	dh_fixperms
+	dh_gencontrol
+	dh_md5sums
+	dh_builddeb -- ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS}
 }
 
 install_linux_image () {
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 36d51f60f98d..1f56938ea5d4 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -1,6 +1,8 @@
 #!/usr/bin/make -f
 # SPDX-License-Identifier: GPL-2.0-only
 
+export DEB_RULES_REQUIRES_ROOT := no
+
 include debian/rules.vars
 
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 93a24712b9a1..070149c985fe 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -193,7 +193,7 @@ Section: kernel
 Priority: optional
 Maintainer: $maintainer
 Rules-Requires-Root: no
-Build-Depends: debhelper
+Build-Depends: debhelper-compat (= 12)
 Build-Depends-Arch: bc, bison, cpio, flex, kmod, libelf-dev:native, libssl-dev:native, rsync
 Homepage: https://www.kernel.org/
 
-- 
2.40.1


