Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3462757B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjGRMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjGRMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:03:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78B10F5;
        Tue, 18 Jul 2023 05:03:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 176BD1FDB9;
        Tue, 18 Jul 2023 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689681807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcavZlTXNr5DDwygCINQcHq1XhLMqp354UXQuIuczEw=;
        b=BtAQsJkCTuJZQLLaotPySYX6YkhuVG98Bvhmzs5zpl14/3RgadNS6KMaKzQwt4Fu1435iM
        7PSDwYkkTHH+KMLUPAys1lkbJWnn4JPmqYPLJy55QvuTMkVkd/D3164Z65XI7L2OwPrHCJ
        BJ4U8p0bduCP8Kx5WUPNfUK+znAHym8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689681807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcavZlTXNr5DDwygCINQcHq1XhLMqp354UXQuIuczEw=;
        b=YcTlvotKxmSD8cmKZsvcUf64LQkPsQsvzOivjn+7yVeE7rwsG/t2MjOSA7Zo+3OacpnDxK
        bitcATWVQ19NcBDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id CA4D92C149;
        Tue, 18 Jul 2023 12:03:26 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH kmod v5 4/5] kmod: Add pkgconfig file with kmod compile time configuration
Date:   Tue, 18 Jul 2023 14:01:55 +0200
Message-ID: <468b3f572d3b84f25bb53ec8fcb15ed4871914d4.1689681454.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689681454.git.msuchanek@suse.de>
References: <cover.1689589902.git.msuchanek@suse.de> <cover.1689681454.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show distconfdir (where system configuration files are searched/to be
installed), sysconfdir (where user configuration files are searched),
module compressions, and module signatures supported.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: mention module signature in commit message
v3: add sysconfdir
v5: add distconfdir, switch to pkgconfig
---
 Makefile.am      |  2 +-
 configure.ac     | 11 +++++++++++
 tools/kmod.pc.in |  9 +++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 tools/kmod.pc.in

diff --git a/Makefile.am b/Makefile.am
index 14eb07e63cea..6d0b2decfef3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -96,7 +96,7 @@ libkmod_libkmod_internal_la_DEPENDENCIES  = $(libkmod_libkmod_la_DEPENDENCIES)
 libkmod_libkmod_internal_la_LIBADD = $(libkmod_libkmod_la_LIBADD)
 
 pkgconfigdir = $(libdir)/pkgconfig
-pkgconfig_DATA = libkmod/libkmod.pc
+pkgconfig_DATA = libkmod/libkmod.pc tools/kmod.pc
 
 bashcompletiondir=@bashcompletiondir@
 dist_bashcompletion_DATA = \
diff --git a/configure.ac b/configure.ac
index 728f88a56704..b4584d6cdc67 100644
--- a/configure.ac
+++ b/configure.ac
@@ -21,6 +21,9 @@ LT_INIT([disable-static pic-only])
 AS_IF([test "x$enable_static" = "xyes"], [AC_MSG_ERROR([--enable-static is not supported by kmod])])
 AS_IF([test "x$enable_largefile" = "xno"], [AC_MSG_ERROR([--disable-largefile is not supported by kmod])])
 
+module_compressions=""
+module_signatures="legacy"
+
 #####################################################################
 # Program checks and configurations
 #####################################################################
@@ -94,6 +97,7 @@ AC_ARG_WITH([zstd],
 AS_IF([test "x$with_zstd" != "xno"], [
 	PKG_CHECK_MODULES([libzstd], [libzstd >= 1.4.4], [LIBS="$LIBS $libzstd_LIBS"])
 	AC_DEFINE([ENABLE_ZSTD], [1], [Enable Zstandard for modules.])
+	module_compressions="zstd $module_compressions"
 ], [
 	AC_MSG_NOTICE([Zstandard support not requested])
 ])
@@ -105,6 +109,7 @@ AC_ARG_WITH([xz],
 AS_IF([test "x$with_xz" != "xno"], [
 	PKG_CHECK_MODULES([liblzma], [liblzma >= 4.99], [LIBS="$LIBS $liblzma_LIBS"])
 	AC_DEFINE([ENABLE_XZ], [1], [Enable Xz for modules.])
+	module_compressions="xz $module_compressions"
 ], [
 	AC_MSG_NOTICE([Xz support not requested])
 ])
@@ -116,6 +121,7 @@ AC_ARG_WITH([zlib],
 AS_IF([test "x$with_zlib" != "xno"], [
 	PKG_CHECK_MODULES([zlib], [zlib], [LIBS="$LIBS $zlib_LIBS"])
 	AC_DEFINE([ENABLE_ZLIB], [1], [Enable zlib for modules.])
+	module_compressions="gzip $module_compressions"
 ], [
 	AC_MSG_NOTICE([zlib support not requested])
 ])
@@ -134,6 +140,7 @@ AS_IF([test "x$with_openssl" != "xno"], [
 		AC_MSG_NOTICE([openssl sm3 support not detected])
 		CPPFLAGS="$CPPFLAGS -DOPENSSL_NO_SM3"
 	])
+	module_signatures="PKCS7 $module_signatures"
 ], [
 	AC_MSG_NOTICE([openssl support not requested])
 ])
@@ -298,6 +305,9 @@ AC_DEFINE_UNQUOTED(KMOD_FEATURES, ["$with_features"], [Features in this build])
 # Generate files from *.in
 #####################################################################
 
+AC_SUBST([module_compressions], $module_compressions)
+AC_SUBST([module_signatures], $module_signatures)
+
 AC_CONFIG_FILES([
 	Makefile
 	man/Makefile
@@ -305,6 +315,7 @@ AC_CONFIG_FILES([
 	libkmod/docs/version.xml
 	libkmod/libkmod.pc
 	libkmod/python/kmod/version.py
+	tools/kmod.pc
 ])
 
 
diff --git a/tools/kmod.pc.in b/tools/kmod.pc.in
new file mode 100644
index 000000000000..2595980a6b35
--- /dev/null
+++ b/tools/kmod.pc.in
@@ -0,0 +1,9 @@
+prefix=@prefix@
+sysconfdir=@sysconfdir@
+distconfdir=@distconfdir@
+module_compressions=@module_compressions@
+module_signatures=@module_signatures@
+
+Name: kmod
+Description: Tools to deal with kernel modules
+Version: @VERSION@
-- 
2.41.0

