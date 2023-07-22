Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1486875D9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGVEt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGVEtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ECE4481;
        Fri, 21 Jul 2023 21:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C1A60A38;
        Sat, 22 Jul 2023 04:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55880C433C9;
        Sat, 22 Jul 2023 04:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001315;
        bh=K5EMB4EDqAGzw3tXLfrUnbHaTr83QeJOoKsDtkrvNl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSnQAo56iRUsS9UpvQS8Tv/WMntDW2EL0COYoZ9ju4fYGHiojyYq66XRWIAlZws9z
         wR5/Q0BorMYEOn70a1bOY1kVIPfkSMX6rnS4zCrDtN+WtGVm6vsLO4+ODowQEdi9XY
         1JhZr/B21BHoUhsD/I1vJW5WZCEx/23SVJLxgrH4pKc0K1Mix5sonG3xeubBQYkpER
         tibuS9Xr9h+i0x6SFPCx30El76Y4/fkMp86sOgw29Jn5H9eEe9V5tOj4mRbllye+LO
         bH3NlSKlcLzW88LW0FQt5iMN7EzKXWGF6D7ge/AmReM6ejGIyNqN7QJl5h3V7szdlG
         IBYiBp7SEuagg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 14/19] kbuild: rpm-pkg: introduce %{with_devel} switch to select devel package
Date:   Sat, 22 Jul 2023 13:48:01 +0900
Message-Id: <20230722044806.3867434-14-masahiroy@kernel.org>
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

scripts/package/mkspec preprocesses the spec file by sed, but it is
unreadable. This commit removes the last portion of the sed scripting.

Remove the $S$M prefixes from the conditionally generated lines.
Instead, surround the code with %if %{with_devel} ... %endif.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package |  2 +-
 scripts/package/mkspec   | 53 +++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8373644a0473..c36ae03d6002 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -89,7 +89,7 @@ binrpm-pkg:
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec \
-		--build-in-place --noprep --define='_smp_mflags %{nil}' \
+		--build-in-place --noprep --define='_smp_mflags %{nil}' --without devel \
 		--define='make $(MAKE)'
 
 # deb-pkg srcdeb-pkg bindeb-pkg
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 2613e85cd844..511cae46a90d 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -10,11 +10,7 @@
 #
 
 # how we were called determines which rpms we build and how we build them
-if [ "$1" = prebuilt ]; then
-	S=DEL
-else
-	S=
-
+if [ -z "$1" ]; then
 	mkdir -p rpmbuild/SOURCES
 	cp linux.tar.gz rpmbuild/SOURCES
 	cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
@@ -22,17 +18,12 @@ else
 fi
 
 if grep -q CONFIG_MODULES=y include/config/auto.conf; then
-	M=
+echo '%define with_devel %{?_without_devel: 0} %{?!_without_devel: 1}'
 else
-	M=DEL
+echo '%define with_devel 0'
 fi
 
-# We can label the here-doc lines for conditional output to the spec file
-#
-# Labels:
-#  $S: this line is enabled only when building source package
-#  $M: this line is enabled only when CONFIG_MODULES is enabled
-sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
+cat<<-EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
 %define pkg_release $("${srctree}/init/build-version")
@@ -76,14 +67,16 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	building most standard programs and are also needed for rebuilding the
 	glibc package.
 
-$S$M	%package devel
-$S$M	Summary: Development package for building kernel modules to match the %{version} kernel
-$S$M	Group: System Environment/Kernel
-$S$M	AutoReqProv: no
-$S$M	%description -n kernel-devel
-$S$M	This package provides kernel headers and makefiles sufficient to build modules
-$S$M	against the %{version} kernel package.
-$S$M
+	%if %{with_devel}
+	%package devel
+	Summary: Development package for building kernel modules to match the %{version} kernel
+	Group: System Environment/Kernel
+	AutoReqProv: no
+	%description -n kernel-devel
+	This package provides kernel headers and makefiles sufficient to build modules
+	against the %{version} kernel package.
+	%endif
+
 	%prep
 	%setup -q -n linux
 	cp %{SOURCE1} .config
@@ -107,7 +100,9 @@ $S$M
 	cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
 	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
-$S$M	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
+	%if %{with_devel}
+	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
+	%endif
 
 	%clean
 	rm -rf %{buildroot}
@@ -143,10 +138,12 @@ $S$M	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/pa
 	%files headers
 	%defattr (-, root, root)
 	/usr/include
-$S$M
-$S$M	%files devel
-$S$M	%defattr (-, root, root)
-$S$M	/usr/src/kernels/%{KERNELRELEASE}
-$S$M	/lib/modules/%{KERNELRELEASE}/build
-$S$M	/lib/modules/%{KERNELRELEASE}/source
+
+	%if %{with_devel}
+	%files devel
+	%defattr (-, root, root)
+	/usr/src/kernels/%{KERNELRELEASE}
+	/lib/modules/%{KERNELRELEASE}/build
+	/lib/modules/%{KERNELRELEASE}/source
+	%endif
 EOF
-- 
2.39.2

