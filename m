Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4447FCB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376654AbjK1Xx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Xxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:53:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343419AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:54:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D90C433C7;
        Tue, 28 Nov 2023 23:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701215642;
        bh=VbzLBZ/YYyTvUGv4/iK4ZZqJeQrZU/0QjMg1LUuUi1k=;
        h=From:To:Cc:Subject:Date:From;
        b=P2ttvRu6LCRc2NS+7C8SHzFk3J3EUa3WYM98z1Irrlea6vASLS4w/4xGhR5UY5xHm
         cBdNMNzHf0FdxNgIGPulW2p98FuME9N+Vm2i5TvpNiZOQ82YDKcgtn4+ttpxTgQlwh
         C7DsA3h5gtSld+qmeswoYwZp9NHtVN+z2z35hwS9Uo2+oCD/jWJn8AiUN8rWL5/2ko
         dTV6xjc5VvB4wUkExly+a3/RFS5z/JdjwNhWgvPMqQb0CmbZw2tK6JQu3gV2dAIQj8
         pat6wPu+25qbXVswIv8Ab+7HaeX5pGipLQUUjkq42QGP2ddHADgJdUvy1f806SM3hL
         6HNYOw+koeXLg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Guillem Jover <guillem@debian.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kbuild: deb-pkg: remove the fakeroot builds support
Date:   Wed, 29 Nov 2023 08:53:56 +0900
Message-Id: <20231128235356.527642-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Remove DEB_RULES_REQUIRES_ROOT=no again
    (resent in order to clarify which one should be applied)

Changes in v2:
  - add DEB_RULES_REQUIRES_ROOT=no to debian/rules

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

