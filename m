Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6A757B30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGRMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGRMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:04:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F619A0;
        Tue, 18 Jul 2023 05:04:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EFC0218E8;
        Tue, 18 Jul 2023 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689681832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcCkWnZUOHY/Sf1BWe3lgRRDTuoQCOqXBJxqBFvSUCI=;
        b=2YYugYC+Enel0PrgKJcncUJBkqbIDEOuHK7wgiHXmk2CX9K8zQEoed4m95jRTv/VjQj23N
        JphtDrJcqdJvH+svaQE3grLyf9x0kTdLCKvslKmENk2HcDxnDBsCRPuM2620D6ZvrDhv4f
        pNFN6Ppu2xTUJqwCpQdnf8XTjt0NPCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689681832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcCkWnZUOHY/Sf1BWe3lgRRDTuoQCOqXBJxqBFvSUCI=;
        b=PJoqenbvlmnXp9+Glk6cu66+zfOK29pIMidnd+UiFuBSAPNIlwIIVUfRxv3Y6b7Z2N3w/c
        BQ8fkgAKvwEwskAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id BE74C2C142;
        Tue, 18 Jul 2023 12:03:51 +0000 (UTC)
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
Subject: [PATCH v5] depmod: Handle installing modules under a prefix
Date:   Tue, 18 Jul 2023 14:03:47 +0200
Message-ID: <20230718120348.383-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689681454.git.msuchanek@suse.de>
References: <cover.1689681454.git.msuchanek@suse.de>
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
v5: switch to pkgconfig
---
 Makefile          | 4 +++-
 scripts/depmod.sh | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 47690c28456a..1620d224ad9c 100644
--- a/Makefile
+++ b/Makefile
@@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
 # makefile but the argument can be passed to make if needed.
 #
 
-MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+export KERNEL_MODULE_DIRECTORY := $(shell pkg-config --print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/null && pkg-config --variable=module_directory kmod || echo /lib/modules)
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

