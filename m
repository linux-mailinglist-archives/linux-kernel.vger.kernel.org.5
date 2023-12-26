Return-Path: <linux-kernel+bounces-11539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E581E7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A0C1C21E08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564AD2230C;
	Tue, 26 Dec 2023 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrizIdsH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C81E487;
	Tue, 26 Dec 2023 14:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BB4C433C8;
	Tue, 26 Dec 2023 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703601245;
	bh=cMKdaJ1jcRx8KAs7hSbmNJKzZX2VPA0PcqyRXDg1p9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=lrizIdsHXpZQgoGJsMF+pXPd5CqZny3N+eeIzElP0exefiIJS7Zg8d50K9Gip0YEI
	 l/oKG84bscELItWYWQ1gsalxQf1b4VS/7emUhjMh72ABkEorkdQ4oUjfVszjIJfzaC
	 U68lfvgTdQKY4GA5gplw/Lr3davBLzNcymzsZW5xFPccvwFFwiRcsl+iE/OMi/rbrL
	 T00LZXf3ZJa2SjmmV7HA57zvrZuDge7gRasCp11fH8TLeUquX4dsRxua4FSvBzVdmP
	 WRkk+9mdLCrDvqDsMV29+E1Z4xZo+OAb+UccFc/uCpL+j61RmkSbG0fe6kriCRWIcB
	 dvs+x6aQVnHzw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: use build ID instead of debug link for dbg package
Date: Tue, 26 Dec 2023 23:33:59 +0900
Message-Id: <20231226143359.1438995-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two ways of managing separate debug info files:

 [1] The executable contains the .gnu_debuglink section, which specifies
     the name and the CRC of the separate debug info file.

 [2] The executable contains a build ID, and the corresponding debug info
     file is placed in the .build-id directory.

We could do both, but the former, which 'make deb-pkg' currently does,
results in complicated installation steps because we need to manually
strip the debug sections, create debug links, and re-sign the modules.
Besides, it is not working with module compression.

This commit abandons the approach [1], and instead opts for [2].

Debian kernel commit de26137e2a9f ("Drop not needed extra step to add
debug links") also stopped adding debug links.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 436d55a83ab0..cc8c7a807fcc 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -49,7 +49,7 @@ install_linux_image () {
 		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
 	fi
 
-	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
+	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" INSTALL_MOD_STRIP=1 modules_install
 	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
 
 	# Install the kernel
@@ -110,25 +110,21 @@ install_linux_image () {
 
 install_linux_image_dbg () {
 	pdir=$1
-	image_pdir=$2
 
 	rm -rf ${pdir}
 
-	for module in $(find ${image_pdir}/lib/modules/ -name *.ko -printf '%P\n'); do
-		module=lib/modules/${module}
-		mkdir -p $(dirname ${pdir}/usr/lib/debug/${module})
-		# only keep debug symbols in the debug file
-		${OBJCOPY} --only-keep-debug ${image_pdir}/${module} ${pdir}/usr/lib/debug/${module}
-		# strip original module from debug symbols
-		${OBJCOPY} --strip-debug ${image_pdir}/${module}
-		# then add a link to those
-		${OBJCOPY} --add-gnu-debuglink=${pdir}/usr/lib/debug/${module} ${image_pdir}/${module}
-	done
+	# Parse modules.order directly because 'make modules_install' may sign,
+	# compress modules, and then run unneeded depmod.
+	while read -r mod; do
+		mod="${mod%.o}.ko"
+		dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
+		buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+		link="${pdir}/usr/lib/debug/.build-id/${buildid}.debug"
 
-	# re-sign stripped modules
-	if is_enabled CONFIG_MODULE_SIG_ALL; then
-		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${image_pdir}" modules_sign
-	fi
+		mkdir -p "${dbg%/*}" "${link%/*}"
+		"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
+		ln -sf --relative "${dbg}" "${link}"
+	done < modules.order
 
 	# Build debug package
 	# Different tools want the image in different locations
@@ -176,9 +172,7 @@ for package in ${packages_enabled}
 do
 	case ${package} in
 	*-dbg)
-		# This must be done after linux-image, that is, we expect the
-		# debug package appears after linux-image in debian/control.
-		install_linux_image_dbg debian/linux-image-dbg debian/linux-image;;
+		install_linux_image_dbg debian/linux-image-dbg;;
 	linux-image-*|user-mode-linux-*)
 		install_linux_image debian/linux-image ${package};;
 	linux-libc-dev)
-- 
2.40.1


