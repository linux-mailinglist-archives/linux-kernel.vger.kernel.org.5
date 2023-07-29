Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59670768015
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjG2OiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2OiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA05A8;
        Sat, 29 Jul 2023 07:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B097860C68;
        Sat, 29 Jul 2023 14:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A30C433C9;
        Sat, 29 Jul 2023 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690641500;
        bh=vtWsqKGXBtO/1q4tL+rXkzYaevQSYzf89qO8jTqbrC4=;
        h=From:To:Cc:Subject:Date:From;
        b=r4R8iXlrXje1MsaRytB+OZuXp3YStlS5JXZp3VQmqNDR3riil7B8ZX7IhyCGxvZZP
         acAjWZ98luBVkiCyV/0hehf5vnTjxu191BN2KLTOuyDWbPK/XY+Wte2Kjm8IsEhM7+
         7D45b/Q+DKvyeSBmzg8RZmi3VjSErcGCiPqiB+avzeBZramPivgoOcSm5FSdEfFbrC
         ZU/xMAxY0D62OWD+lTixW19H1vhMW1FqfrqWzZbqo7iSg5MQu+BPLeNgAgf/cL86SF
         P/ZISwPIf3dFrrKjtOoJlBdPv3a1u8AtzwyQy8FSIeKvYaJJvmYhFxAtcEPTpmEbz5
         2QQn37XoitM2w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/2] kbuild: deb-pkg: use Debian compliant shebang for debian/rules
Date:   Sat, 29 Jul 2023 23:38:13 +0900
Message-Id: <20230729143814.1509196-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debian Policy "4.9. Main building script: debian/rules" requires
"debian/rules must start with the line #!/usr/bin/make -f". [1]

Currently, Kbuild does not follow this policy.

When Kbuild generates debian/rules, "#!$(command -v $MAKE) -f" is
expanded by shell. The result may not be "#!/usr/bin/make -f".

There was a reason to opt out the Debian policy.

If you run '/path/to/my/custom/make deb-pkg', debian/rules must also be
invoked by the same Make program. If #!/usr/bin/make were hard-coded in
debian/rules, the sub-make would be executed by a possibly different
Make version.

This is problematic due to the MAKEFLAGS incompatibility, especially the
job server flag. Old Make versions used --jobserver-fds to propagate job
server file descriptors, but Make >= 4.2 uses --jobserver-auth. The flag
disagreement between the parent and the child Make would result in a
process fork explosion.

However, having a non-standard path in the shebang causes another issue;
the generated source package is not portable as such a path does not
exist in other build environments.

This commit solves those conflicting demands.

Hard-code '#!/usr/bin/make -f' in debian/rules to create a portable and
Debian-compliant source package.

Pass '--rules-file=$(MAKE) -f debian/rules' when dpkg-buildpackage is
invoked from Makefile so that debian/rules is executed by the same Make
program as used to start Kbuild.

[1] https://www.debian.org/doc/debian-policy/ch-source.html#main-building-script-debian-rules

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 2 +-
 scripts/package/mkdebian | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 85beab0363d7..f8a948ec2c6b 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		--rules-file='$(MAKE) -f debian/rules' -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 9105abab9728..2829f5b8aea6 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -264,7 +264,7 @@ EOF
 fi
 
 cat <<EOF > debian/rules
-#!$(command -v $MAKE) -f
+#!/usr/bin/make -f
 
 srctree ?= .
 KERNELRELEASE = ${KERNELRELEASE}
-- 
2.39.2

