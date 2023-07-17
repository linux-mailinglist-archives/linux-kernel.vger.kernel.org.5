Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC017560BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGQKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGQKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:41:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787DA173E;
        Mon, 17 Jul 2023 03:41:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0C0591FDA8;
        Mon, 17 Jul 2023 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689590463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S86dhMRLrCdTR5PKHVfEnd0pvbnS5R7FdSBuvy/YLY0=;
        b=wc64ghXcNImcIgHyUewvvsxBCNFJdverpvQa3rHIX7eNuIh8m+b3FfVD6h8NVE7wjLMn14
        Fh+niHB8T3C+iFN/G0Hx7gyOe1HFTjB3qxMs1Ghy1XTCGcSibWta20a781KRY6HBKbto1g
        Y1w9t3b8dVUqlXzCBg1J5C+zKcGcDcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689590463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S86dhMRLrCdTR5PKHVfEnd0pvbnS5R7FdSBuvy/YLY0=;
        b=5SPYBpKVIArtLLt5PcPA5Ga6AU2PTo9e1JSYDljiPfUNHbOJbLr8XPamD7vPWv0ryT4pZ2
        1JWgW8IMinMUKgDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 8CFD92C143;
        Mon, 17 Jul 2023 10:41:02 +0000 (UTC)
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
Subject: [PATCH v4] depmod: Handle installing modules under a prefix
Date:   Mon, 17 Jul 2023 12:40:58 +0200
Message-ID: <20230717104100.6146-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689589902.git.msuchanek@suse.de>
References: <cover.1689589902.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distributions aim at shipping all files in /usr.

The path under which kernel modules are installed is hardcoded to /lib
which conflicts with this goal.

When kmod provides the config command, use it to determine the correct
module installation path.

With kmod that does not provide the config command /lib/modules is used
as before.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Avoid error on systems with kmod that does not support config
command
v3: More verbose commit message
v4:
  - Document jq requirement
  - fix bashism
  - Update to getting full module path, not just additional prefix
---
 Documentation/process/changes.rst | 15 +++++++++++++++
 Makefile                          |  4 +++-
 scripts/depmod.sh                 |  8 ++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 5561dae94f85..f96a867ab85f 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -41,6 +41,7 @@ bison                  2.0              bison --version
 pahole                 1.16             pahole --version
 util-linux             2.10o            fdformat --version
 kmod                   13               depmod -V
+jq                     any              jq --version
 e2fsprogs              1.41.4           e2fsck -V
 jfsutils               1.1.3            fsck.jfs -V
 reiserfsprogs          3.6.3            reiserfsck -V
@@ -176,6 +177,15 @@ You will need openssl to build kernels 3.7 and higher if module signing is
 enabled.  You will also need openssl development packages to build kernels 4.3
 and higher.
 
+
+Kmod
+----
+
+``depmod`` is needed for building modular kernels. ``jq`` is additionally needed
+when support for installing modules outside of the default location
+``/lib/modules`` is required. Missing ``jq`` will result in an error message
+during build even if the tool is not needed.
+
 Tar
 ---
 
@@ -463,6 +473,11 @@ Kmod
 - <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
 - <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
 
+jq
+--
+
+- <https://github.com/jqlang/jq/tags>
+
 Ksymoops
 --------
 
diff --git a/Makefile b/Makefile
index 47690c28456a..5eb04baaac58 100644
--- a/Makefile
+++ b/Makefile
@@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
 # makefile but the argument can be passed to make if needed.
 #
 
-MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+export KERNEL_MODULE_DIRECTORY := $(shell kmod config >/dev/null 2>&1 && kmod config | jq -r .module_directory || echo /lib/modules)
+
+MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)
 export MODLIB
 
 PHONY += prepare0
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..06961f990fcb 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -27,16 +27,16 @@ fi
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
 tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
-mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
+mkdir -p "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE"
 if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
-	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
-		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
+	if test -e "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE/modules.dep" -o \
+		-e "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE/modules.dep.bin"; then
 		depmod_hack_needed=false
 	fi
 fi
 rm -rf "$tmp_dir"
 if $depmod_hack_needed; then
-	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
+	symlink="$INSTALL_MOD_PATH$KERNEL_MODULE_DIRECTORY/99.98.$KERNELRELEASE"
 	ln -s "$KERNELRELEASE" "$symlink"
 	KERNELRELEASE=99.98.$KERNELRELEASE
 fi
-- 
2.41.0

