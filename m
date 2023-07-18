Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD1757B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjGRMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGRMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:03:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234061AC;
        Tue, 18 Jul 2023 05:03:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CAF6721941;
        Tue, 18 Jul 2023 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689681806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvlHBvqzPVM+nrKUqZQDh23criIIq4TPNlulM1tUKbU=;
        b=uILsdidTecf92JYgECvLrQhnFdQY+6FmWuA1D/Gdx4V07v+kaeQvFC4us9MpJdrCjL2ePC
        0viN1qkGD2EYl8K8FZihOaylqZyuNnv3LcgSItVl7omZnZC4jeiWp3ZawiiWDF5Pb2vHXW
        QiM67Yi3lvwxKzCNeFwyJaG4zOXFSl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689681806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvlHBvqzPVM+nrKUqZQDh23criIIq4TPNlulM1tUKbU=;
        b=z/ARLjsbrKOj94fNaoMqeUwPJ/r6tWDKQvjSlelPBgTpGKHnQewT4jDPitwbE4HFxUsAhl
        i5yiKzWM/QaOwJDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 8BC872C146;
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
Subject: [PATCH kmod v5 3/5] libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
Date:   Tue, 18 Jul 2023 14:01:54 +0200
Message-ID: <a290343ce32e2a3c25b134e4f27c13b26e06c9e0.1689681454.git.msuchanek@suse.de>
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

There is an ongoing effort to limit use of files outside of /usr (or
${prefix} on general). Currently all modprobe.d paths are hardcoded to
outside of $prefix. Teach kmod to load modprobe.d from ${prefix}/lib.

On some distributions /usr/lib and /lib are the same directory because
of a compatibility symlink, and it is possible to craft configuration
files with sideeffects that would behave differently when loaded twice.
However, the override semantic ensures that one 'overrides' the other,
and only one configuration file of the same name is loaded from any of
the search directories.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Fix commit message typo
v3: Fix modprobe.d path list in code comment
v5: Add distconfdir
---
 Makefile.am        | 1 +
 configure.ac       | 5 +++++
 libkmod/libkmod.c  | 7 ++++---
 man/Makefile.am    | 9 +++++++--
 man/depmod.d.xml   | 1 +
 man/modprobe.d.xml | 1 +
 tools/depmod.c     | 1 +
 7 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8ba85c91a0f3..14eb07e63cea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,7 @@ AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir) \
 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
+	-DDISTCONFDIR=\""$(distconfdir)"\" \
 	${zlib_CFLAGS}
 
 AM_CFLAGS = $(OUR_CFLAGS)
diff --git a/configure.ac b/configure.ac
index 331cc8a1ffd5..728f88a56704 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,6 +79,10 @@ AC_COMPILE_IFELSE(
 # --with-
 #####################################################################
 
+AC_ARG_WITH([distconfdir], AS_HELP_STRING([--with-distconfdir=DIR], [directory to search for distribution configuration files]),
+        [], [with_distconfdir='${prefix}/lib'])
+AC_SUBST([distconfdir], [$with_distconfdir])
+
 AC_ARG_WITH([rootlibdir],
         AS_HELP_STRING([--with-rootlibdir=DIR], [rootfs directory to install shared libraries]),
         [], [with_rootlibdir=$libdir])
@@ -313,6 +317,7 @@ AC_MSG_RESULT([
 
 	prefix:			${prefix}
 	sysconfdir:		${sysconfdir}
+	distconfdir:		${distconfdir}
 	libdir:			${libdir}
 	rootlibdir:		${rootlibdir}
 	includedir:		${includedir}
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 2670f9a4611a..09e6041461b0 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -65,6 +65,7 @@ static const char *const default_config_paths[] = {
 	SYSCONFDIR "/modprobe.d",
 	"/run/modprobe.d",
 	"/usr/local/lib/modprobe.d",
+	DISTCONFDIR "/modprobe.d",
 	"/lib/modprobe.d",
 	NULL
 };
@@ -237,9 +238,9 @@ static char *get_kernel_release(const char *dirname)
  *                to load from user-defined configuration parameters such as
  *                alias, blacklists, commands (install, remove). If NULL
  *                defaults to /etc/modprobe.d, /run/modprobe.d,
- *                /usr/local/lib/modprobe.d and /lib/modprobe.d. Give an empty
- *                vector if configuration should not be read. This array must
- *                be null terminated.
+ *                /usr/local/lib/modprobe.d, DISTCONFDIR/modprobe.d, and
+ *                /lib/modprobe.d. Give an empty vector if configuration should
+ *                not be read. This array must be null terminated.
  *
  * Create kmod library context. This reads the kmod configuration
  * and fills in the default values.
diff --git a/man/Makefile.am b/man/Makefile.am
index 11514d52a190..2fea8e46bf2f 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -17,9 +17,14 @@ EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
 CLEANFILES = $(dist_man_MANS)
 
 %.5 %.8: %.xml
-	$(AM_V_XSLT)$(XSLT) \
+	$(AM_V_XSLT)if [ '$(distconfdir)' != '/lib' ] ; then \
+		sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' $< ; \
+	else \
+		sed -e '/@DISTCONFDIR@/d' $< ; \
+	fi | \
+	$(XSLT) \
 		-o $@ \
 		--nonet \
 		--stringparam man.output.quietly 1 \
 		--param funcsynopsis.style "'ansi'" \
-		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl $<
+		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 8d3d821cddc8..f282a39cc840 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -40,6 +40,7 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/depmod.d/*.conf</filename></para>
+    <para><filename>@DISTCONFDIR@/depmod.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 0ab3e9110a7e..2bf6537f07e6 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -41,6 +41,7 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/modprobe.d/*.conf</filename></para>
+    <para><filename>@DISTCONFDIR@/modprobe.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/run/modprobe.d/*.conf</filename></para>
     <para><filename>/etc/modprobe.d/*.conf</filename></para>
diff --git a/tools/depmod.c b/tools/depmod.c
index 1d1d41db860f..630fef9c8fb0 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -54,6 +54,7 @@ static const char *const default_cfg_paths[] = {
 	SYSCONFDIR "/depmod.d",
 	"/run/depmod.d",
 	"/usr/local/lib/depmod.d",
+	DISTCONFDIR "/depmod.d",
 	"/lib/depmod.d",
 	NULL
 };
-- 
2.41.0

