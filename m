Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E175832C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGRRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjGRRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:01:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B730DA;
        Tue, 18 Jul 2023 09:59:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCB8021881;
        Tue, 18 Jul 2023 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689699535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OjGGhMViPLhUrPIXcS8z7NODS9q5SOF67JHp0ks1PI4=;
        b=Z1AD8OXwd6DHhwZq/f7992l/3BmBVSoKE5G67annpEQNKuLGK7S9JZ1/N8Y1KIiihVmDxR
        Pf8a1q8vXuMPTje3oYe6Z868UncHiG9bLZsMamx3n3sIINFXM6yQ6jYgCZb2Zbo1HiWDm8
        ixfhtr1iGOMpnJMC5O7FDuSDfOJwKZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689699535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OjGGhMViPLhUrPIXcS8z7NODS9q5SOF67JHp0ks1PI4=;
        b=ssCmNkTziPWWcXWWv3q2FZ/WICV6qp5Fl7Z3F45oSeXgThh2qMgWACclIFF/tneCRqkaHX
        YbdiUSthM8trrvDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id ABC082C142;
        Tue, 18 Jul 2023 16:58:55 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] Revert "kbuild: Hack for depmod not handling X.Y versions"
Date:   Tue, 18 Jul 2023 18:58:43 +0200
Message-ID: <20230718165848.14392-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hack for ancient version of module-init-tools that was added in
Linux 3.0.

Since then module-init-tools was replaced with kmod.

This hack adds an additional indirection, and causes confusing errors
to be printed when depmod fails.

Reverts commit 8fc62e594253 ("kbuild: Do not write to builddir in modules_install")
Reverts commit bfe5424a8b31 ("kbuild: Hack for depmod not handling X.Y versions")

Link: https://lore.kernel.org/linux-modules/CAK7LNAQMs3QBYfWcLkmOQdbbq7cj=7wWbK=AWhdTC2rAsKHXzQ@mail.gmail.com/

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 scripts/depmod.sh | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..fca689ba4f21 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -23,33 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
 	exit 0
 fi
 
-# older versions of depmod require the version string to start with three
-# numbers, so we cheat with a symlink here
-depmod_hack_needed=true
-tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
-mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
-if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
-	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
-		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
-		depmod_hack_needed=false
-	fi
-fi
-rm -rf "$tmp_dir"
-if $depmod_hack_needed; then
-	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
-	ln -s "$KERNELRELEASE" "$symlink"
-	KERNELRELEASE=99.98.$KERNELRELEASE
-fi
-
 set -- -ae -F System.map
 if test -n "$INSTALL_MOD_PATH"; then
 	set -- "$@" -b "$INSTALL_MOD_PATH"
 fi
-"$DEPMOD" "$@" "$KERNELRELEASE"
-ret=$?
-
-if $depmod_hack_needed; then
-	rm -f "$symlink"
-fi
-
-exit $ret
+exec "$DEPMOD" "$@" "$KERNELRELEASE"
-- 
2.41.0

