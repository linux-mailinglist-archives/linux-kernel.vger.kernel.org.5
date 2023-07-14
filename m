Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779BE753AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbjGNMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjGNMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:21:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED11FD6;
        Fri, 14 Jul 2023 05:21:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE2E522103;
        Fri, 14 Jul 2023 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689337287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNe8idGh8AhD5+hHQZpsPL59psm6FR8/RCbKm61pH2E=;
        b=vXsRp0tcRJfFimJyLjP1QbJiQYuZM44d0JGuYNbqmsTbljBQfa8L/PCC9IsL9jmQrY2Q7/
        WHdQfKyuREK5Ip3zI2vJrQUYX79dx1PVCtMeNkL/lznHyrVp9GKIgLfl7dokv6HZmPM7os
        bP/dWnmewq+L0YEO2NsOz45co+RXEIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689337287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNe8idGh8AhD5+hHQZpsPL59psm6FR8/RCbKm61pH2E=;
        b=CjXy6UpXkH0Qcw/+xNiDCQzr5EuOWwWs5h20kXpoN74P429a0cZptMvcu/5Zc265vTdbNo
        7CW9sEC7RpW9iPAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 91DC02C142;
        Fri, 14 Jul 2023 12:21:27 +0000 (UTC)
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
Subject: [PATCH v3] depmod: Handle installing modules under a prefix
Date:   Fri, 14 Jul 2023 14:21:08 +0200
Message-ID: <20230714122111.7528-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
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

Some distributions aim at not shipping any files in / outside of usr.

The path under which kernel modules are installed is hardcoded to /lib
which conflicts with this goal.

When kmod provides the config command, use it to determine the correct
module installation prefix.

This is a prefix under which the modules are searched by kmod on the
system, and is separate from the temporary staging location already
supported by INSTALL_MOD_PATH.

With kmod that does not provide the config command empty prefix is used
as before.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Avoid error on systems with kmod that does not support config
command
v3: More verbose commit message
---
 Makefile          | 4 +++-
 scripts/depmod.sh | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 47690c28456a..b1fea135bdec 100644
--- a/Makefile
+++ b/Makefile
@@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
 # makefile but the argument can be passed to make if needed.
 #
 
-MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
+
+MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
 PHONY += prepare0
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..88ac79056153 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -27,16 +27,16 @@ fi
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
 tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
-mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
+mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
 if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
-	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
-		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
+	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
+		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
 		depmod_hack_needed=false
 	fi
 fi
 rm -rf "$tmp_dir"
 if $depmod_hack_needed; then
-	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
+	symlink="$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.98.$KERNELRELEASE"
 	ln -s "$KERNELRELEASE" "$symlink"
 	KERNELRELEASE=99.98.$KERNELRELEASE
 fi
-- 
2.41.0

