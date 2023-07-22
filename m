Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2D75D9CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGVEti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGVEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA767421D;
        Fri, 21 Jul 2023 21:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EE360A54;
        Sat, 22 Jul 2023 04:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC71C433C8;
        Sat, 22 Jul 2023 04:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001312;
        bh=kxFfSb2hxE1tRo3e11RL0sCUAGyQ5rQOcl7k3i5D0Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgZT8I4PmlGjzvsmMpDUlhWvXHHrVa8HbIZ+uoRfCH8I+OdHDBD7/4YP8obMnKSdy
         cqzrGKIkBWjqPp4PYWcz0qlQLDPxVZI6Czx0o3Y3VBOFnpWFjzE1t85wYi3PpfJ0Xq
         7DcooBmcyWbvzsSqj6rm++dzJX8gD8RNPd+APdcICOtDU4iOE5kKar2GeopBIq+NY/
         sWXVqYNmqdPawX2DhJGVDwiHEx2ADKfz3p9T690bRgCaSAyqMRj2dVDIF9zxmHpayh
         L3IWmySUPuKJF7FltPdUfdN67pUPrU58S+wZpEfWjOn6M5J4+486/+m8pSYNFywmjl
         JdbrfPlN01sYA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 12/19] kbuild: rpm-pkg: invoke the kernel build from rpmbuild for binrpm-pkg
Date:   Sat, 22 Jul 2023 13:47:59 +0900
Message-Id: <20230722044806.3867434-12-masahiroy@kernel.org>
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

To reduce the preprocess of the spec file, invoke the kernel build
from rpmbuild.

Run init/build-version to increment the release number not only for
binrpm-pkg but also for srcrpm-pkg and rpm-pkg.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package |  2 +-
 scripts/package/mkspec   | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 7cd61a374dae..8373644a0473 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -86,10 +86,10 @@ srcrpm-pkg: linux.tar.gz
 # ---------------------------------------------------------------------------
 PHONY += binrpm-pkg
 binrpm-pkg:
-	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec \
+		--build-in-place --noprep --define='_smp_mflags %{nil}' \
 		--define='make $(MAKE)'
 
 # deb-pkg srcdeb-pkg bindeb-pkg
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 22b980cf3d00..a9425d993667 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -35,6 +35,7 @@ fi
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
+%define pkg_release $("${srctree}/init/build-version")
 
 # _arch is undefined if /usr/lib/rpm/platform/*/macros was not included.
 %{!?_arch: %define _arch dummy}
@@ -44,18 +45,18 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Name: kernel
 	Summary: The Linux Kernel
 	Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
-	Release: $(cat .version 2>/dev/null || echo 1)
+	Release: %{pkg_release}
 	License: GPL
 	Group: System Environment/Kernel
 	Vendor: The Linux Community
 	URL: https://www.kernel.org
-$S	Source0: linux.tar.gz
-$S	Source1: config
-$S	Source2: diff.patch
+	Source0: linux.tar.gz
+	Source1: config
+	Source2: diff.patch
 	Provides: kernel-%{KERNELRELEASE}
-$S	BuildRequires: bc binutils bison dwarves
-$S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
-$S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
+	BuildRequires: bc binutils bison dwarves
+	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
+	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
 
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
@@ -83,14 +84,14 @@ $S$M	%description -n kernel-devel
 $S$M	This package provides kernel headers and makefiles sufficient to build modules
 $S$M	against the %{version} kernel package.
 $S$M
-$S	%prep
-$S	%setup -q -n linux
-$S	cp %{SOURCE1} .config
-$S	patch -p1 < %{SOURCE2}
-$S
-$S	%build
-$S	%{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
-$S
+	%prep
+	%setup -q -n linux
+	cp %{SOURCE1} .config
+	patch -p1 < %{SOURCE2}
+
+	%build
+	%{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
+
 	%install
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
-- 
2.39.2

