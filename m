Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F305D781D11
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHTJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHTJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA8D2;
        Sun, 20 Aug 2023 02:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEB261ADA;
        Sun, 20 Aug 2023 09:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F64EC433C8;
        Sun, 20 Aug 2023 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692522910;
        bh=dQwixiJ5YSja69keHsNUxrA+cKlDQpjYQOOiI8zPpAU=;
        h=From:To:Cc:Subject:Date:From;
        b=Vw6QHABYQrdSMRQPg3c3OiWjHAd3i8J3q82VfqlEQ5jBlW4NszWlHPa/AozGs6K2D
         kR7pnB4pS4BEycLcyAbG5u7u+KBWD3d14ni7jsltiaWf6p/p2EYffga/sng9LgKeOY
         D/3T3m8J9MX2y1G1l57jtPjmxdreaBJLSL06enklVLmuhqJlkomdvI0qGUcwO4dRIE
         X/4Ywt8o0gcniyW0hfNZscT6BIzHG99qS9lcgrnH2CipJVAAPOtjaLwwumHCjVooHV
         4IwKzoPEDT8TPfQzbzdEbvEt++Ph7rt71NchZuan52GXvlUc5eTsTYJ8rFsHsEysov
         6nPem4qNO8O3Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: deb-pkg: support DEB_BUILD_OPTIONS=parallel=N in debian/rules
Date:   Sun, 20 Aug 2023 18:15:05 +0900
Message-Id: <20230820091505.3812160-1-masahiroy@kernel.org>
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

'make srcdeb-pkg' generates a source package, which you can build
later by using dpkg-buildpackage.

In older dpkg versions, 'dpkg-buildpackage -j N' sets not only
DEB_BUILD_OPTIONS but also MAKEFLAGS. Hence, passing -j (--jobs)
to dpkg-buildpackage was enough to run parallel building.

The behavior was changed by commit 1d0ea9b2ba3f ("dpkg-buildpackage:
Change -j, --jobs semantics to non-force mode") of dpkg project. [1]

Since then, 'dpkg-buildpackage -j N' sets only DEB_BUILD_OPTIONS,
which is not parsed by the current debian/rules. You cannot build it
in parallel unless you pass --jobs-force instead or set the MAKEFLAGS
environment variable.

Debian policy [2] suggests the following code snippet for debian/rules.

  ifneq (,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
      NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
      MAKEFLAGS += -j$(NUMJOBS)
  endif

I added slightly different code to debian/rules so 'make -j N deb-pkg'
works as before. In this case, the '-j N' should not be specified in
debian/rules again. 'make deb-pkg' without the -j option must explicitly
pass -j1 to dpkb-buildpackage because otherwise DEB_BUILD_OPTIONS
contains parallel=<nproc> by default.

This should work with almost all Make versions Kbuild supports.

Only the corner case I found not working is 'make-3.82 -j deb-pkg',
which results in single thread building. It is not a big deal because
-j without an argument, which does not limit the number of jobs, is
rarely used.

As far as I tested, the MAKEFLAGS format varies by Make versions.

                 command line option         $(MAKEFLAGS) in recipe
 Make 3.82            -j                            j
                      -j1                         <none>
                      -j2                          -j
 Make 4.0/4.1         -j                           -j
                      -j1                         <none>
                      -j2                          -j
 Make 4.2+            -j                           -j
                      -j1                          -j1
                      -j2                          -j2

[1] https://salsa.debian.org/dpkg-team/dpkg/-/commit/1d0ea9b2ba3f6a2de5b1a6ff55f3df7b71f73db6
[2] https://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules-options

Reported-by: Bastian Germann <bage@linutronix.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package     | 4 +++-
 scripts/package/debian/rules | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index f8a948ec2c6b..f8b9ba4705c8 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -148,7 +148,9 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		--rules-file='$(MAKE) -f debian/rules' -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		--rules-file='$(MAKE) -f debian/rules' \
+		$(if $(filter-out -j1,$(filter -j%,$(MAKEFLAGS))),,--jobs=1) \
+		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 226e127efd63..4753173daaae 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -5,11 +5,13 @@ include debian/rules.vars
 
 srctree ?= .
 
+JOBS = $(if $(filter -j%,$(MAKEFLAGS)),,$(patsubst parallel=%,-j%,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
+
 .PHONY: binary binary-indep binary-arch
 binary: binary-arch binary-indep
 binary-indep: build-indep
 binary-arch: build-arch
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
+	$(MAKE) $(JOBS) -f $(srctree)/Makefile ARCH=$(ARCH) \
 	KERNELRELEASE=$(KERNELRELEASE) \
 	run-command KBUILD_RUN_COMMAND=+$(srctree)/scripts/package/builddeb
 
@@ -17,7 +19,7 @@ binary-arch: build-arch
 build: build-arch build-indep
 build-indep:
 build-arch:
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
+	$(MAKE) $(JOBS) -f $(srctree)/Makefile ARCH=$(ARCH) \
 	KERNELRELEASE=$(KERNELRELEASE) \
 	$(shell $(srctree)/scripts/package/deb-build-option) \
 	olddefconfig all
@@ -25,4 +27,4 @@ build-arch:
 .PHONY: clean
 clean:
 	rm -rf debian/files debian/linux-*
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) clean
+	$(MAKE) $(JOBS) -f $(srctree)/Makefile ARCH=$(ARCH) clean
-- 
2.39.2

