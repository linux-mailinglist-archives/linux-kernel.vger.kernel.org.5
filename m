Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66276B49C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjHAMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFE1990;
        Tue,  1 Aug 2023 05:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560B861589;
        Tue,  1 Aug 2023 12:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7575AC433C8;
        Tue,  1 Aug 2023 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690892370;
        bh=+5s8cG2CY5Onp0GpZcmd3v1HggtDETk/A4Sd/brvrbk=;
        h=From:To:Cc:Subject:Date:From;
        b=Yzc1tYVyol/6k8yp6m/TVa5VK9XLKtE7QO1s49VTnPx1N2E2NUL/WzIxgJgIzUBIW
         Yf4fZIP8QYqpzzeKZbeYkbEiEbTF1izJ0aO7zcul9UsTL+q/zKYnq2N3Em7QwZGAsd
         jUrDzJ0KcOeb9dHyFNMbltt8uNjeGz52SZxkEYtdfMsPA1WpV2FfY+iQeBZxB0yENf
         STF4JX1NqXVAQC2gfSyURESIhxmLxaAUlwek8b/KCdYSkI29O9monmx+k+xGcNmWIo
         FoI9MWlruoLQJd9j0HMsPX+cp1NUx8QCxD6jxZSlFzBRq8qiJQYjwGlidxfh8G4gYm
         1BHrn0ZdqB1pg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 1/2] kbuild: deb-pkg: use Debian compliant shebang for debian/rules
Date:   Tue,  1 Aug 2023 21:19:25 +0900
Message-Id: <20230801121926.1677205-1-masahiroy@kernel.org>
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
expanded by shell. The resuling string may not be "#!/usr/bin/make -f".

There was a reason to opt out the Debian policy.

If you run '/path/to/my/custom/make deb-pkg', debian/rules must also be
invoked by the same Make program. If #!/usr/bin/make were hard-coded in
debian/rules, the sub-make would be executed by a possibly different
Make version.

This is problematic due to the MAKEFLAGS incompatibility, especially the
job server flag. Old Make versions used --jobserver-fds to propagate job
server file descriptors, but Make >= 4.2 uses --jobserver-auth. The flag
disagreement between the parent/child Makes would result in a process
fork explosion.

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

(no changes since v1)

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

