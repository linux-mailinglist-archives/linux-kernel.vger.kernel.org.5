Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B4785E12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjHWRGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjHWRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:06:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2BE6D;
        Wed, 23 Aug 2023 10:06:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 055A0220E8;
        Wed, 23 Aug 2023 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692810395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C2bDP+RYe/WMPBfbqXzw2/DSC4K9ktSOPhYda02frvc=;
        b=Hs21X2I29NMI3Do/56pWK9LOF72bo95cDq8Co47n4wfh9GPtWzrfQ8ZQF1rsl364XyEJZd
        g/8ulJQBjprOR8g0dFWKg7uGh9ddVCXWsUP0TtbTrQOIpkSZiukhjD+7FGn8oX+MELwD0b
        +t3GnzuoIA64re5iymUJrCPFUFT3p9A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBD821351F;
        Wed, 23 Aug 2023 17:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lkXRNJo85mSUVQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Aug 2023 17:06:34 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH] depmod: Remove version parsing hack
Date:   Wed, 23 Aug 2023 19:06:32 +0200
Message-ID: <20230823170632.14377-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kbuild on usr-merged distro like:

        make INSTALL_MOD_PATH="$BUILD_DIR_C/mods" \
             MODLIB="$BUILD_DIR_C/mods/usr/lib/modules/$release" \
             modules_install

(notice the '/usr' insert)

where
        release=$(make -s kernelrelease)

depmod fails:

>   DEPMOD  /var/tmp/build/mods/usr/lib/modules/6.5.0-rc5-default
> ln: failed to create symbolic link '/var/tmp/build/mods/lib/modules/99.98.6.5.0-rc5-default': No such file or directory
> depmod: ERROR: could not open directory /var/tmp/build/mods/usr/lib/modules/99.98.6.5.0-rc5-default: No such file or directory
> depmod: FATAL: could not search modules: No such file or directory

I used kmod-30-8.1.x86_64 (openSUSE Tumbleweed with usr-merge).

The explicit MODLIB doesn't cut it because of another path dependency in
depmod's hack. That provision was added in commit bfe5424a8b31 ("kbuild:
Hack for depmod not handling X.Y versions") (2011, v3.0).
It says the hack is needed for module-init-tools < 3.13, 3.13 is from
2011 too. Actually, it seems to be a cautious action between 2.6.xx
series and an expected 3.0 but it ended up as 3.0.0 and SUBLEVEL=0
has been since then (so even the busybox's depmod should work without
the hack).

Remove the hack to make builds with custom INSTALL_MOD_PATH on
usr-merged distros possible.

Link: https://lore.kernel.org/r/CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu%3DXvSWRuZ-pNAFWVw@mail.gmail.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 scripts/depmod.sh | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..84311255e4bf 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -23,24 +23,6 @@ if [ -z $(command -v $DEPMOD) ]; then
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
-- 
2.41.0

