Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160777F5900
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKWHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKWHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:18:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B205F9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:18:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5023C433C7;
        Thu, 23 Nov 2023 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700723924;
        bh=o6yyNvYxe2T/DPjfVyBDtP8DgRNYyj26Jx6smGQqn2I=;
        h=From:To:Cc:Subject:Date:From;
        b=vJANAcqJEEQVLC091ZNgaWwnguY6ty3nlnqE5ETGJKtClUWUO0ueZPqjvx6xmUm2V
         Y5VAL4r6R2bSM8YrVylCsHqIjv6c6SCWsZaLEDjvnZDglb+e9dr0ZDuU9MIVAbilNg
         xKg+WRZbymzVLe7QR1TmFBb8mBsoA9l8lbzVegWWZWKIjf9iRW0+qu3Z6HDqMRPlz8
         U3eaDVbvzd/+DiFgr01Uj2CHqxDTfEPhT4/iuh/tkda9D9Il5DAhubZ4hd9RB41+2e
         MjI5zOKD+YxtJNvOlKeQmzZA4ErWls4KLYsx0mg9reE/vsfc7RvOBrd9lyrnwlyi5M
         xzTgK+/p9fh2g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: remove the last use of old cmd_src_tar rule in packaging
Date:   Thu, 23 Nov 2023 16:18:24 +0900
Message-Id: <20231123071824.476845-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpm-pkg and deb-pkg targets have transitioned to using 'git archive'
for tarball creation.

Although the old cmd_src_tar is still used by snap-pkg, there is no need
to create a tarball solely for passing the source to snapcraft.

Instead, you can use 'source-type: local' to tell the source location to
snapcraft.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Note for reviewers/testers:

You cannot run 'make snap-pkg' on recent distributions, but you can use
Ubuntu 18.04, at least. To test this, you can run the ubuntu:18.04
Docker image, and excecute 'apt-get install snapcraft', and then
'make snap-pkg'. The generated kernel snap can be used for
Ubuntu Core 18.


 Makefile                           |  2 --
 scripts/Makefile.package           | 24 +-----------------------
 scripts/package/snapcraft.template |  2 +-
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 724c79bebe72..f128a1a1b1a0 100644
--- a/Makefile
+++ b/Makefile
@@ -609,8 +609,6 @@ export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
 export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
 			  -name CVS -o -name .pc -o -name .hg -o -name .git \) \
 			  -prune -o
-export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
-			 --exclude CVS --exclude .pc --exclude .hg --exclude .git
 
 # ===========================================================================
 # Rules shared between *config targets and build targets
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 3addd1c0b989..3c38be77acf0 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -4,27 +4,6 @@
 include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.lib
 
-KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
-# Include only those top-level files that are needed by make, plus the GPL copy
-TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
-               include init io_uring ipc kernel lib mm net rust \
-               samples scripts security sound tools usr virt \
-               .config Makefile \
-               Kbuild Kconfig COPYING $(wildcard localversion*)
-
-quiet_cmd_src_tar = TAR     $(2).tar.gz
-      cmd_src_tar = \
-if test "$(objtree)" != "$(srctree)"; then \
-	echo >&2; \
-	echo >&2 "  ERROR:"; \
-	echo >&2 "  Building source tarball is not possible outside the"; \
-	echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT"; \
-	echo >&2; \
-	false; \
-fi ; \
-tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
-	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
-
 # Git
 # ---------------------------------------------------------------------------
 
@@ -157,9 +136,8 @@ snap-pkg:
 	rm -rf $(objtree)/snap
 	mkdir $(objtree)/snap
 	$(MAKE) clean
-	$(call cmd,src_tar,$(KERNELPATH))
 	sed "s@KERNELRELEASE@$(KERNELRELEASE)@; \
-		s@SRCTREE@$(shell realpath $(KERNELPATH).tar.gz)@" \
+		s@SRCTREE@$(abs_srctree)@" \
 		$(srctree)/scripts/package/snapcraft.template > \
 		$(objtree)/snap/snapcraft.yaml
 	cd $(objtree)/snap && \
diff --git a/scripts/package/snapcraft.template b/scripts/package/snapcraft.template
index 626d278e4a5a..85d5e07d1b40 100644
--- a/scripts/package/snapcraft.template
+++ b/scripts/package/snapcraft.template
@@ -10,5 +10,5 @@ parts:
   kernel:
     plugin: kernel
     source: SRCTREE
-    source-type: tar
+    source-type: local
     kernel-with-firmware: false
-- 
2.40.1

