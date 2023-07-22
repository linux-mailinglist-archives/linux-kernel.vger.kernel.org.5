Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001175D9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGVEut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGVEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82F46AC;
        Fri, 21 Jul 2023 21:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0DFD60A64;
        Sat, 22 Jul 2023 04:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52774C433CB;
        Sat, 22 Jul 2023 04:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001321;
        bh=48TYLXDk2TZk+T1Fx9XPl8wRZKrGD3cF6zfP4SYoA0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoU0nAY1eP4T61+9clSYpSNgSfwWWh5UlvXHQA//yjU3npmsHTTOKSvm94lha13Oz
         VlQR+ktlhlf2gImIIzl4WuCm3bwrzllNjw1HT93s9YXAW/b3nJdMoKSdZSJ85c3Quz
         I/m6oaHdjG3haE1snv63ELmDYLmC3bxtdl1YhBLbX434PIqwU7SoAQA1rrb3Ykfek6
         PCl4jK408qph6rby2DCGuCbOYY9onlVrywe+VW+ZoMyhUB621OEviungDsh/gJtF6G
         AmDAwQ6gafSHqU2SVT7k4BsYvnTrDTFUSjhiBTlMSu27sDFLjSNomBlchLc5PQHWul
         30V1JW4Jha8Qg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 18/19] kbuild: rpm-pkg: refactor *rpm-pkg targets
Date:   Sat, 22 Jul 2023 13:48:05 +0900
Message-Id: <20230722044806.3867434-18-masahiroy@kernel.org>
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

Merge the similar build targets.

Also, make the output location consistent.

Previously, source packages were created in the build directory,
while binary packages under ~/rpmbuild/RPMS/.

Now, Kbuild creates the rpmbuild/ directory in the build directory,
and saves all packages under it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 52 +++++++++++++++++++++-------------------
 scripts/package/mkspec   |  8 -------
 2 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index bf2da97f29d0..0ace3973a0d1 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -11,7 +11,6 @@ TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
                samples scripts security sound tools usr virt \
                .config Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
-MKSPEC     := $(srctree)/scripts/package/mkspec
 
 quiet_cmd_src_tar = TAR     $(2).tar.gz
       cmd_src_tar = \
@@ -66,32 +65,37 @@ $(linux-tarballs): archive-args = --prefix=linux/ $$(cat $<)
 $(linux-tarballs): .tmp_HEAD FORCE
 	$(call if_changed,archive)
 
-# rpm-pkg
+# rpm-pkg srcrpm-pkg binrpm-pkg
 # ---------------------------------------------------------------------------
-PHONY += rpm-pkg
-rpm-pkg: srpm = $(shell rpmspec --srpm --query --queryformat='%{name}-%{VERSION}-%{RELEASE}.src.rpm' kernel.spec)
-rpm-pkg: srcrpm-pkg
-	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -rb $(srpm) \
-	--build-in-place --noprep \
-	--define='_smp_mflags %{nil}' --define='make $(MAKE)'
 
-# srcrpm-pkg
-# ---------------------------------------------------------------------------
-PHONY += srcrpm-pkg
-srcrpm-pkg: linux.tar.gz
-	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
-	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -bs kernel.spec \
-	--define='_smp_mflags %{nil}' --define='_sourcedir rpmbuild/SOURCES' --define='_srcrpmdir .'
+quiet_cmd_mkspec = GEN     $@
+      cmd_mkspec = $(srctree)/scripts/package/mkspec > $@
 
-# binrpm-pkg
-# ---------------------------------------------------------------------------
-PHONY += binrpm-pkg
-binrpm-pkg:
-	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/kernel.spec
-	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
-		$(UTS_MACHINE)-linux -bb $(objtree)/kernel.spec \
-		--build-in-place --noprep --define='_smp_mflags %{nil}' --without devel \
-		--define='make $(MAKE)'
+kernel.spec: FORCE
+	$(call cmd,mkspec)
+
+PHONY += rpm-sources
+rpm-sources: linux.tar.gz
+	$(Q)mkdir -p rpmbuild/SOURCES
+	$(Q)ln -f linux.tar.gz rpmbuild/SOURCES/linux.tar.gz
+	$(Q)cp $(KCONFIG_CONFIG) rpmbuild/SOURCES/config
+	$(Q)$(srctree)/scripts/package/gen-diff-patch rpmbuild/SOURCES/diff.patch
+
+PHONY += rpm-pkg srcrpm-pkg binrpm-pkg
+
+rpm-pkg:    private build-type := a
+srcrpm-pkg: private build-type := s
+binrpm-pkg: private build-type := b
+
+rpm-pkg srcrpm-pkg: rpm-sources
+rpm-pkg srcrpm-pkg binrpm-pkg: kernel.spec
+	+$(strip rpmbuild -b$(build-type) kernel.spec \
+	--define='_topdir $(abspath rpmbuild)' \
+	$(if $(filter a b, $(build-type)), \
+		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}') \
+	$(if $(filter b, $(build-type)), \
+		--without devel) \
+	$(RPMOPTS))
 
 # deb-pkg srcdeb-pkg bindeb-pkg
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c08567ae7fb1..d41608efb747 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -9,14 +9,6 @@
 #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
 #
 
-# how we were called determines which rpms we build and how we build them
-if [ -z "$1" ]; then
-	mkdir -p rpmbuild/SOURCES
-	cp linux.tar.gz rpmbuild/SOURCES
-	cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
-	"${srctree}/scripts/package/gen-diff-patch" rpmbuild/SOURCES/diff.patch
-fi
-
 if grep -q CONFIG_MODULES=y include/config/auto.conf; then
 echo '%define with_devel %{?_without_devel: 0} %{?!_without_devel: 1}'
 else
-- 
2.39.2

