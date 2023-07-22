Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F175D9BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGVEsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGVEsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49173583;
        Fri, 21 Jul 2023 21:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7364160A4C;
        Sat, 22 Jul 2023 04:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53EFC433CB;
        Sat, 22 Jul 2023 04:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001298;
        bh=b+tgQJzqqP7hzh4EZCRAABtIzrvO2u08e4LOuvHC6/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5J6n3mnOrcTUsbm2l4+l1/oNSQmhesOSf2I+V9TO7cg2A8V85HP8E/k3IjYk+sct
         U9TBvU1sq3kgockPpAAK37eBAFtY2IvUu5LmTyA7fmI0rOfx1qlcGubZeL4N9jFN+Y
         KZ1LHYJe6c0gJMTAaUkZKHCNsbnUOFliaOxi8Lv2VGOc9VuhrLcY4m7UnD7GUAfQNy
         9OjtMMmFvGeFpjDamtSZYuBA0jXdR/ZbgydZJ4XHJu9nzeLT2zbL1aJA7hh7d+HZnb
         +LYw39R+jzVi/2tE5aZYhAOsylsm6TMqu9z5CqOW659Uao6ezwpUF26myGiaFwxYBB
         m55B8EtN/3j8g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 03/19] kbuild: rpm-pkg: do not hard-code $MAKE in spec file
Date:   Sat, 22 Jul 2023 13:47:50 +0900
Message-Id: <20230722044806.3867434-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, $MAKE will expand to the GNU Make program that created the
source RPM. This is problematic if you carry it to a different build
host to run 'rpmbuild' there.

Consider this command:

  $ /path/to/my/custom/make srcrpm-pkg

The spec file in the SRPM will record '/path/to/my/custom/make', which
exists only on that build environment.

To create a portable SRPM, the spec file should avoid hard-coding $MAKE.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package |  5 +++--
 scripts/package/mkspec   | 12 +++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 92dbc889bd7c..e9217e997c68 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -72,7 +72,7 @@ PHONY += rpm-pkg
 rpm-pkg: srpm = $(shell rpmspec --srpm --query --queryformat='%{name}-%{VERSION}-%{RELEASE}.src.rpm' kernel.spec)
 rpm-pkg: srcrpm-pkg
 	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -rb $(srpm) \
-	--define='_smp_mflags %{nil}'
+	--define='_smp_mflags %{nil}' --define='make $(MAKE)'
 
 # srcrpm-pkg
 # ---------------------------------------------------------------------------
@@ -89,7 +89,8 @@ binrpm-pkg:
 	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
-		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
+		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec \
+		--define='make $(MAKE)'
 
 # deb-pkg srcdeb-pkg bindeb-pkg
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index a83b17b4a0d9..9b2b4386019d 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -38,6 +38,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 #  $S: this line is enabled only when building source package
 #  $M: this line is enabled only when CONFIG_MODULES is enabled
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
+%{!?make: %define make make}
+
 	Name: kernel
 	Summary: The Linux Kernel
 	Version: $__KERNELRELEASE
@@ -89,19 +91,19 @@ $S	cp %{SOURCE1} .config
 $S	patch -p1 < %{SOURCE2}
 $S
 $S	%build
-$S	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
+$S	%{make} %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
 	mkdir -p %{buildroot}/boot/efi
-	cp \$($MAKE -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+	cp \$(%{make} -s image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
 	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
 	%else
-	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+	cp \$(%{make} -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
-$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
-	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+$M	%{make} %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+	%{make} %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
-- 
2.39.2

