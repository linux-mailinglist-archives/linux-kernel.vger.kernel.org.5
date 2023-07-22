Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780875D9C6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGVEtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGVEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D683C3A;
        Fri, 21 Jul 2023 21:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6807260A64;
        Sat, 22 Jul 2023 04:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF563C433CB;
        Sat, 22 Jul 2023 04:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001307;
        bh=cuTukx/nqcQppGnMG50r7nMzOf11MWzBvrfhG/qxv+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghrFSViTYGLOEr8m9iwmuZEqXL5DGGDY68BgcoSlkfyMMZLowxj1FthOUvtiGpYOU
         XgWK3EdP8gAdlmiiNAZ6PyNVyK/S9AuCENMBct8ZnROrezO5YdgVwmiaHiGhvw7G5C
         i4v5GScJZ3Mi9rMEAW97IgKXfGLRPEECQv/hOiAVFpI5cIo1PNFdwEdmJ0U57vcuxW
         WhDdEyeKJtkfwHsNODzO8jmHOIyMYnRFRFsGyz8SPGAvXgzHgqXQCg/cXUayGCQLQu
         jRmU2NDJl3VAyQqgopRaN9EbdT70PkqNLiebKTs2BqflUTdbKJkEmDd6lZ9bQPnFNG
         5KzQMi6SICH5A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 09/19] kbuild: refactor kernel-devel RPM package and linux-headers Deb package
Date:   Sat, 22 Jul 2023 13:47:56 +0900
Message-Id: <20230722044806.3867434-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-devel RPM package and the linux-headers Debian package
provide headers and scripts needed for building external modules.

They copy the necessary files in slightly different ways - the RPM
copies almost everything except some exclude patterns, while the Debian
copies less number of files. There is no need to maintain different code
to do the same thing.

Split the Debian code out to scripts/package/install-extmod-build, which
is called from both of the packages.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb             | 29 +--------------------
 scripts/package/install-extmod-build | 39 ++++++++++++++++++++++++++++
 scripts/package/mkspec               |  6 +----
 3 files changed, 41 insertions(+), 33 deletions(-)
 create mode 100755 scripts/package/install-extmod-build

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 032774eb061e..bf3f8561aa68 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -162,34 +162,7 @@ install_kernel_headers () {
 
 	rm -rf $pdir
 
-	(
-		cd $srctree
-		find . arch/$SRCARCH -maxdepth 1 -name Makefile\*
-		find include scripts -type f -o -type l
-		find arch/$SRCARCH -name Kbuild.platforms -o -name Platform
-		find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f
-	) > debian/hdrsrcfiles
-
-	{
-		if is_enabled CONFIG_OBJTOOL; then
-			echo tools/objtool/objtool
-		fi
-
-		find arch/$SRCARCH/include Module.symvers include scripts -type f
-
-		if is_enabled CONFIG_GCC_PLUGINS; then
-			find scripts/gcc-plugins -name \*.so
-		fi
-	} > debian/hdrobjfiles
-
-	destdir=$pdir/usr/src/linux-headers-$version
-	mkdir -p $destdir
-	tar -c -f - -C $srctree -T debian/hdrsrcfiles | tar -xf - -C $destdir
-	tar -c -f - -T debian/hdrobjfiles | tar -xf - -C $destdir
-	rm -f debian/hdrsrcfiles debian/hdrobjfiles
-
-	# copy .config manually to be where it's expected to be
-	cp $KCONFIG_CONFIG $destdir/.config
+	"${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
 
 	mkdir -p $pdir/lib/modules/$version/
 	ln -s /usr/src/linux-headers-$version $pdir/lib/modules/$version/build
diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
new file mode 100755
index 000000000000..af7fe9f5b1e4
--- /dev/null
+++ b/scripts/package/install-extmod-build
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+set -e
+
+destdir=${1}
+
+test -n "${srctree}"
+test -n "${SRCARCH}"
+
+is_enabled() {
+	grep -q "^$1=y" include/config/auto.conf
+}
+
+mkdir -p "${destdir}"
+
+(
+	cd "${srctree}"
+	echo Makefile
+	find "arch/${SRCARCH}" -maxdepth 1 -name 'Makefile*'
+	find include scripts -type f -o -type l
+	find "arch/${SRCARCH}" -name Kbuild.platforms -o -name Platform
+	find "$(find "arch/${SRCARCH}" -name include -o -name scripts -type d)" -type f
+) | tar -c -f - -C "${srctree}" -T - | tar -xf - -C "${destdir}"
+
+{
+	if is_enabled CONFIG_OBJTOOL; then
+		echo tools/objtool/objtool
+	fi
+
+	find "arch/${SRCARCH}/include" Module.symvers include scripts -type f
+
+	if is_enabled CONFIG_GCC_PLUGINS; then
+		find scripts/gcc-plugins -name '*.so'
+	fi
+} | tar -c -f - -T - | tar -xf - -C "${destdir}"
+
+# copy .config manually to be where it's expected to be
+cp "${KCONFIG_CONFIG}" "${destdir}/.config"
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 34b2489106cf..22e290d23d8a 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -28,9 +28,6 @@ else
 fi
 
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
-EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
---exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
---exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
 
 # We can label the here-doc lines for conditional output to the spec file
 #
@@ -112,8 +109,7 @@ $M	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
 $S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 $S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/source
-$S$M	mkdir -p %{buildroot}/usr/src/kernels/%{KERNELRELEASE}
-$S$M	tar cf - $EXCLUDES . | tar xf - -C %{buildroot}/usr/src/kernels/%{KERNELRELEASE}
+$S$M	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
 $S$M	cd %{buildroot}/lib/modules/%{KERNELRELEASE}
 $S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} build
 $S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} source
-- 
2.39.2

