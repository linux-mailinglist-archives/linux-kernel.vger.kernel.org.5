Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831D75D9D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGVEuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGVEtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519914687;
        Fri, 21 Jul 2023 21:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E9D60B07;
        Sat, 22 Jul 2023 04:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518E5C43391;
        Sat, 22 Jul 2023 04:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001318;
        bh=VPUaxVtXdPuq4HOqNcJIyglxoF0IOoqdg44mkFjj0xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/gQUaCOpGdMRfrDiYuPDjF9izqAaP27voG5UdnyPecGtsnuRCiyG37Kb9Dd6GO5t
         0UYVo0WEkGpNWGcXJL6i9JzTvhLjvoZk16PipBBZxDfSNMbzlJVH7I4Dx91D/TIPz9
         FCRKTt1yCqsf0pc8OzR/YK3irXNF4Wjva5gY4aAtuL2bbMkge4qdHSfMtplKSYmdIF
         quV6ZSRrtxRzk9U0kF4xUIOload+bM/ie6Y/dvrdesW5NOL4cv4DyvoOPQss7uxIsS
         67p0fNvIwB5V1GV8VHXVyP+T9luA+vnG61bMn6vR1yza7vHcHnDmNlImpZWa+VRpdn
         HqQwuYrsqkoNQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 16/19] kbuild: rpm-pkg: rename binkernel.spec to kernel.spec
Date:   Sat, 22 Jul 2023 13:48:03 +0900
Message-Id: <20230722044806.3867434-16-masahiroy@kernel.org>
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

Now kernel.spec and binkernel.spec have the exactly same contents.

Use kernel.spec for binrpm-pkg as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore                 | 2 +-
 Makefile                   | 2 +-
 scripts/Makefile.package   | 4 ++--
 scripts/remove-stale-files | 2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 9fd4c9533b3d..0bbae167bf93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,7 +74,7 @@ modules.order
 #
 # RPM spec file (make rpm-pkg)
 #
-/*.spec
+/kernel.spec
 /rpmbuild/
 
 #
diff --git a/Makefile b/Makefile
index f258ef13fa5d..5a263e5f6559 100644
--- a/Makefile
+++ b/Makefile
@@ -1595,7 +1595,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/signing_key.pem \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
-		  *.spec rpmbuild \
+		  kernel.spec rpmbuild \
 		  rust/libmacros.so
 
 # clean - Delete most, but leave enough to build external modules
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index c36ae03d6002..be9602fa98da 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -86,9 +86,9 @@ srcrpm-pkg: linux.tar.gz
 # ---------------------------------------------------------------------------
 PHONY += binrpm-pkg
 binrpm-pkg:
-	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
+	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/kernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
-		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec \
+		$(UTS_MACHINE)-linux -bb $(objtree)/kernel.spec \
 		--build-in-place --noprep --define='_smp_mflags %{nil}' --without devel \
 		--define='make $(MAKE)'
 
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index f3659ea0335b..8b1a636f8543 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -37,3 +37,5 @@ rm -f .scmversion
 rm -rf include/ksym
 
 find . -name '*.usyms' | xargs rm -f
+
+rm -f binkernel.spec
-- 
2.39.2

