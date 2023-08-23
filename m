Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728B785723
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjHWLvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjHWLvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FFDB;
        Wed, 23 Aug 2023 04:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3542B64A6D;
        Wed, 23 Aug 2023 11:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081F0C433C7;
        Wed, 23 Aug 2023 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791459;
        bh=at6MwZstCK4YYvJ/JENZT9OnY5U7qwdQvQ8iXxtDGtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+dzP8W5sVJegKiGHku5Bp2hI0RCOwciogN11sjhg9SBjngWylSnHg2IPA4SE93wP
         sQN7AutlFsQwCVEB5jLiUdwtXrymkAX7f9OHl8Jb6rQbiW8YEFSrEq1VhFKdJLoE/d
         lORgMFqHAmFe9z3w/6D5vX79QA8iBjVLl4vnmBYLtMkLYDLafhjvuhI8QQIXwNActw
         GNFD/UZ5LbWHlIbsHHetdLrU1I7TC8aH+gqVH56g+Ajn54BtFxTdJ5zN8DEQ5mHyIH
         HvQ7TP8SacJOB2Om8IJVKLCm6IiEm/3JNFWPTo969bk349/mwDHiIC2Yv0IVBPRqMU
         XKZkGal/chvJg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/8] kbuild: move depmod rule to scripts/Makefile.modinst
Date:   Wed, 23 Aug 2023 20:50:43 +0900
Message-Id: <20230823115048.823011-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

depmod is a part of the module installation.

scripts/Makefile.modinst is a better place to run it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 |  8 --------
 scripts/Makefile.modinst |  9 +++++++++
 scripts/depmod.sh        | 10 ++++++----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index e2dfa3b994f7..c9c8019e4720 100644
--- a/Makefile
+++ b/Makefile
@@ -509,7 +509,6 @@ LEX		= flex
 YACC		= bison
 AWK		= awk
 INSTALLKERNEL  := installkernel
-DEPMOD		= depmod
 PERL		= perl
 PYTHON3		= python3
 CHECK		= sparse
@@ -1871,15 +1870,8 @@ PHONY += modules_check
 modules_check: $(MODORDER)
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
 
-quiet_cmd_depmod = DEPMOD  $(MODLIB)
-      cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
-                   $(KERNELRELEASE)
-
 modules_install:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
-ifndef modules_sign_only
-	$(call cmd,depmod)
-endif
 
 else # CONFIG_MODULES
 
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ab0c5bd1a60f..7a64ece9b826 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -86,6 +86,15 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
 	$(call cmd,strip)
 	$(call cmd,sign)
 
+__modinst: depmod
+
+PHONY += depmod
+depmod: $(modules)
+	$(call cmd,depmod)
+
+quiet_cmd_depmod = DEPMOD  $(MODLIB)
+      cmd_depmod = $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
+
 else
 
 $(dst)/%.ko: FORCE
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index fca689ba4f21..ee771ccb1f9c 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -3,12 +3,14 @@
 #
 # A depmod wrapper used by the toplevel Makefile
 
-if test $# -ne 2; then
-	echo "Usage: $0 /sbin/depmod <kernelrelease>" >&2
+if test $# -ne 1; then
+	echo "Usage: $0 <kernelrelease>" >&2
 	exit 1
 fi
-DEPMOD=$1
-KERNELRELEASE=$2
+
+KERNELRELEASE=$1
+
+: ${DEPMOD:=depmod}
 
 if ! test -r System.map ; then
 	echo "Warning: modules_install: missing 'System.map' file. Skipping depmod." >&2
-- 
2.39.2

