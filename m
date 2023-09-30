Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F027B4005
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjI3KjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3Ki7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:38:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133A193;
        Sat, 30 Sep 2023 03:38:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC2C433C8;
        Sat, 30 Sep 2023 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696070336;
        bh=ObsaoJzZCd6Y+/Hau9L6u5iVOT+vjhyYDzlov334978=;
        h=From:To:Cc:Subject:Date:From;
        b=HAtFK7MltYgaaoBG7kbomIGo8aFmFqgdfgTkKhp0j9vqFWoz8iGcJg0Oag7rEOJ0b
         vrLb3OyGJSJntn4pY6VYNv6OwwDuAhQo6banErA9Pob7EM58+0+qaJXc+G63RuuEbo
         Jp9leg8GpZWxfAqo8fzm3r88d1eC/8AbvKgWsTWvGHAFXxCO0ag83Ly4BxTJrbOXRB
         TKfb44Zuqg+n7/nPt5oLWJputpqdq99R9wUvHDQcg7njJFb6X31y6jN5lnj9JG5Dw0
         9Tr5W/WiNrrihNNFPdDbWoVTntDYCOO0dykJJ/E/pSeKFuA33YEDYl4S8vngfpQEQP
         JBIGpZvLK2S1Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: rpm-build: generate kernel.spec in rpmbuild/SPECS/
Date:   Sat, 30 Sep 2023 19:38:47 +0900
Message-Id: <20230930103847.1272324-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.spec is the last piece that resides outside the rpmbuild/
directory. Move all RPM-related files to rpmbuild/ consistently.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore                 | 1 -
 Makefile                   | 2 +-
 scripts/Makefile.package   | 8 ++++----
 scripts/package/mkspec     | 6 ++++++
 scripts/remove-stale-files | 2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0bbae167bf93..98274e1160d7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,7 +74,6 @@ modules.order
 #
 # RPM spec file (make rpm-pkg)
 #
-/kernel.spec
 /rpmbuild/
 
 #
diff --git a/Makefile b/Makefile
index 3de08c780c74..9e77a58207a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1486,7 +1486,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/signing_key.pem \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
-		  kernel.spec rpmbuild \
+		  rpmbuild \
 		  rust/libmacros.so
 
 # clean - Delete most, but leave enough to build external modules
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 2bcab02da965..05b8c3e29aac 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -69,9 +69,9 @@ $(linux-tarballs): .tmp_HEAD FORCE
 # ---------------------------------------------------------------------------
 
 quiet_cmd_mkspec = GEN     $@
-      cmd_mkspec = $(srctree)/scripts/package/mkspec > $@
+      cmd_mkspec = $(srctree)/scripts/package/mkspec $@
 
-kernel.spec: FORCE
+rpmbuild/SPECS/kernel.spec: FORCE
 	$(call cmd,mkspec)
 
 PHONY += rpm-sources
@@ -88,8 +88,8 @@ srcrpm-pkg: private build-type := s
 binrpm-pkg: private build-type := b
 
 rpm-pkg srcrpm-pkg: rpm-sources
-rpm-pkg srcrpm-pkg binrpm-pkg: kernel.spec
-	+$(strip rpmbuild -b$(build-type) kernel.spec \
+rpm-pkg srcrpm-pkg binrpm-pkg: rpmbuild/SPECS/kernel.spec
+	+$(strip rpmbuild -b$(build-type) rpmbuild/SPECS/kernel.spec \
 	--define='_topdir $(abspath rpmbuild)' \
 	$(if $(filter a b, $(build-type)), \
 		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}' \
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index d41608efb747..ce201bfa8377 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -9,6 +9,12 @@
 #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
 #
 
+output=$1
+
+mkdir -p "$(dirname "${output}")"
+
+exec >"${output}"
+
 if grep -q CONFIG_MODULES=y include/config/auto.conf; then
 echo '%define with_devel %{?_without_devel: 0} %{?!_without_devel: 1}'
 else
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 8b1a636f8543..385610fe3936 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -38,4 +38,4 @@ rm -rf include/ksym
 
 find . -name '*.usyms' | xargs rm -f
 
-rm -f binkernel.spec
+rm -f *.spec
-- 
2.39.2

