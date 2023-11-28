Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218567FBA98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbjK1M4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK1M4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B227D51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:56:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA23FC433C8;
        Tue, 28 Nov 2023 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176216;
        bh=hKHaJ8sHOi5d/nae+CksoGF2YrFTwPKeiImXwy1CbcA=;
        h=From:To:Cc:Subject:Date:From;
        b=suRWt3rkU4bFv+rCEf4KZ8VphF9jns7IdIZjFj4SWTxc3ruyjfGa20ZZQbMdpt1rv
         6SHkme8ylhuhhz9/uDA2lTLToaUTczmO1MHNDxxpzDS2rHbn0zVN4KVHTLA/X74SBh
         q/IXZ1ts897FtyqfWHRdvZFgiGZUaUQiawvjFIRVB3f7UqEbgfK+b6Ce6pxGPL2L91
         0UBU85XL/GV/+J1vEqtiA0FaMMQkm73kMKdWZ5dSAh9JFmhdvrlTrAcjYtP0qHw2wr
         RwjKfr8omqpG9koNe73qHtzIWvE0Hb/pWk0129nNQkM6f+CB1D0rS9Podqk9TOcngD
         SeuUgYH3PbC/g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Guillem Jover <guillem@debian.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: remove the fakeroot builds support
Date:   Tue, 28 Nov 2023 21:56:42 +0900
Message-Id: <20231128125642.24931-1-masahiroy@kernel.org>
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

In 2017, the dpkg suite added the rootless builds support with the
following commits:

  - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
  - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds")

It is supported by the default dpkg on Debian 10 and Ubuntu 20.04.

Remove the old method.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 4 +---
 scripts/package/builddeb | 8 +-------
 2 files changed, 2 insertions(+), 10 deletions(-)

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
-- 
2.40.1

