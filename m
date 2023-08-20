Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A56782098
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjHTWSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjHTWSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB69F;
        Sun, 20 Aug 2023 15:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8978B60B58;
        Sun, 20 Aug 2023 22:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C44C433C8;
        Sun, 20 Aug 2023 22:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692569895;
        bh=tG9mOM2phpCGnVoXIGzMICupAugSnUVLKJ2nHQ7Yyfg=;
        h=From:To:Cc:Subject:Date:From;
        b=m4yiuHIWfY/k4mABE1vQnHDP5EeFvFLV4Dz4fWC7ULoZDWfNBP2zJnv18qbR8/4e/
         Fp9BAu/zM7SfdkxdZmSrSI5NtQaFLEYzsDKo/26qAwZoV7b6VKVU/ykPGDCWVZNPGG
         KsaRxOwGVxxmwxNnWwOgqShZHaMyaZHZh4NjaMTgpTPwUV4LA+/c5rT7YA51hu42aN
         mhNOufh9180n+DlcJ5M54OWLmp88vmwlbiuqciK6xLbzJs4uczfgC190IgSl5KUB1z
         cO5RlR6U52o+4KoMytUaRChz/xCnURa8+wEq8a7zM1THfNnLR/LZr4br/TbeywOnIF
         7BQM2X6m+EdpQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2] kbuild: deb-pkg: support DEB_BUILD_OPTIONS=parallel=N in debian/rules
Date:   Mon, 21 Aug 2023 07:18:02 +0900
Message-Id: <20230820221802.3902935-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make srcdeb-pkg' generates a source package, which you can build
later by using dpkg-buildpackage.

In older dpkg versions, 'dpkg-buildpackage --jobs=N' sets not only
DEB_BUILD_OPTIONS but also MAKEFLAGS. Hence, passing -j or --jobs
to dpkg-buildpackage was enough for parallel execution.

The behavior was changed by commit 1d0ea9b2ba3f ("dpkg-buildpackage:
Change -j, --jobs semantics to non-force mode") of dpkg project. [1]

Since then, 'dpkg-buildpackage --jobs=N' sets only DEB_BUILD_OPTIONS,
which is not parsed by the current debian/rules. You cannot parallelly
build the generated source package unless you pass the alternative
--jobs-force option or set the MAKEFLAGS environment variable.

Debian policy [2] suggests the following code snippet for debian/rules.

  ifneq (,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
      NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
      MAKEFLAGS += -j$(NUMJOBS)
  endif

I tweaked the code snippet to filter out parallel=1 and pass --jobs=1
to dpkg-buildpackage from scripts/Makefile.package. It is needed to keep
'make deb-pkg' without the -j option running in serial. Please note that
dpkg-buildpackage sets parallel=<nproc> in DEB_BUILD_OPTIONS by default
(that is, --jobs=auto is the default) and --jobs=1 is needed to restore
the serial execution. When dpkg-buildpackage is invoked from Kbuild,
the number of jobs is inherited from the top level Makefile. Passing
--jobs=1 to dpkg-buildpackage allows debian/rules to skip parsing
DEB_BUILD_OPTIONS.

[1] https://salsa.debian.org/dpkg-team/dpkg/-/commit/1d0ea9b2ba3f6a2de5b1a6ff55f3df7b71f73db6
[2] https://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules-options

Reported-by: Bastian Germann <bage@linutronix.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Simplify the code and make it work with all Make versions.

 scripts/Makefile.package     | 2 +-
 scripts/package/debian/rules | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index f8a948ec2c6b..2bcab02da965 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		--rules-file='$(MAKE) -f debian/rules' -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		--rules-file='$(MAKE) -f debian/rules' --jobs=1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 226e127efd63..3dafa9496c63 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -5,6 +5,11 @@ include debian/rules.vars
 
 srctree ?= .
 
+ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
+    NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
+    MAKEFLAGS += -j$(NUMJOBS)
+endif
+
 .PHONY: binary binary-indep binary-arch
 binary: binary-arch binary-indep
 binary-indep: build-indep
-- 
2.39.2

