Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F37FC2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346878AbjK1PjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbjK1PjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:39:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B8B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:39:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A32AC433C7;
        Tue, 28 Nov 2023 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701185966;
        bh=Ul+5JsEr00hCpcNY6/TNQDzkKwuTkuFGMnHWCDK+NiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bxtKZl5cWQvfmShV2blhYD0rDSVuah4Ce0Eozowu4YOmpaYNRnSb6GLgpLG0AWcut
         Iwr6tTepl394varvsVmU920cR7OmdKvFrcGMfSOrDw46hVs4DQ7pb0ai+zk6vcqzEI
         je5wWmc/0iegGdNDotkuZ+LeVAASpcsvPazhoKMBOpYcEqEuQFqBWshfM820Qx3y2z
         HMya6KS6oNDZtscgJA+TbVOPEHr2A11XC49PQSWqJJ27xPhWEmulgKkMjFnb8sfDUi
         gPs7wsZsQv5AoXdP9Pvs8D93I7da5S3WRRM3tvWajQyOeFFUTWMR7MJPT0hd6d1ik6
         wZL1U2qEboNwQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Guillem Jover <guillem@debian.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: deb-pkg: remove the fakeroot builds support
Date:   Wed, 29 Nov 2023 00:38:58 +0900
Message-Id: <20231128153858.84932-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
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

In 2017, the dpkg suite introduced the rootless builds support with the
following commits:

  - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
  - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds")

This feature is available in the default dpkg on Debian 10 and Ubuntu
20.04.

Remove the old method.

Additionally, export DEB_RULES_REQUIRES_ROOT=no in case debian/rules is
invoked without dpkg-buildpackage. This change aligns with the Debian
kernel commit 65206e29f378 ("Allow to run d/rules.real without root").
While the upstream kernel currently does not run dh_testroot, it may
be useful in the future.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - add DEB_RULES_REQUIRES_ROOT=no to debian/rules

 scripts/Makefile.package     | 4 +---
 scripts/package/builddeb     | 8 +-------
 scripts/package/debian/rules | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 0c3adc48dfe8..a81dfb1f5181 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -109,8 +109,6 @@ debian-orig: linux.tar$(debian-orig-suffix) debian
 		cp $< ../$(orig-name); \
 	fi
 
-KBUILD_PKG_ROOTCMD ?= 'fakeroot -u'
-
 PHONY += deb-pkg srcdeb-pkg bindeb-pkg
 
 deb-pkg:    private build-type := source,binary
@@ -125,7 +123,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		-R'$(MAKE) -f debian/rules' -j1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		-R'$(MAKE) -f debian/rules' -j1 -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index d7dd0d04c70c..2fe51e6919da 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -36,19 +36,13 @@ create_package() {
 	sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%P\0' \
 		| xargs -r0 md5sum > DEBIAN/md5sums"
 
-	# Fix ownership and permissions
-	if [ "$DEB_RULES_REQUIRES_ROOT" = "no" ]; then
-		dpkg_deb_opts="--root-owner-group"
-	else
-		chown -R root:root "$pdir"
-	fi
 	# a+rX in case we are in a restrictive umask environment like 0077
 	# ug-s in case we build in a setuid/setgid directory
 	chmod -R go-w,a+rX,ug-s "$pdir"
 
 	# Create the package
 	dpkg-gencontrol -p$pname -P"$pdir"
-	dpkg-deb $dpkg_deb_opts ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
+	dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
 }
 
 install_linux_image () {
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 3dafa9496c63..f23d97087948 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -5,6 +5,8 @@ include debian/rules.vars
 
 srctree ?= .
 
+export DEB_RULES_REQUIRES_ROOT := no
+
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
     MAKEFLAGS += -j$(NUMJOBS)
-- 
2.40.1

