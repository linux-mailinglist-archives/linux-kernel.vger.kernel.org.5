Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D775D9C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGVEtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGVEse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CF03C1B;
        Fri, 21 Jul 2023 21:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E733C60A51;
        Sat, 22 Jul 2023 04:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44787C433C7;
        Sat, 22 Jul 2023 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001306;
        bh=Tseeay/kHUJT/g4fC6akk3UE+1foZq5ZUvDTIeFuPSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MggZCs3OIoVl/nagMrqEkVze7pAPoBo9PJ+hhthCiO1gzwf8rVkCN4IqQbgoGmuPd
         PxUaoXZW/6AdTVTHxFY9HgOt/anClFxO+zecXP/aSBC845lvPEAIxNSYVUBz/3WAoO
         BiLfjYE5kRHA0JieR58PbuD2l1oDulHtxXM1K1KaoG+6+LXBbI1BRqHt/lYvJc7Fzu
         srAPxNuAjYOFMF1Pp6p2nK5THIalvJpWOsctU98NvxqRexH4yvwKQS8zdBAT8DgmZZ
         HnzdUOXoHvsrQ7iqgnmtwdvk2UaXWgWukZeaPzRJQXDqyxLgrMdKa7geI0hXdd8tuK
         cgGfBq9z7nVXw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 08/19] kbuild: add a phony target to run a command with Kbuild env vars
Date:   Sat, 22 Jul 2023 13:47:55 +0900
Message-Id: <20230722044806.3867434-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cases where we want to run a command with the same
environment variables as Kbuild uses. For example, 'make coccicheck'
invokes scripts/coccicheck from the top Makefile so that the script can
reference to ${LINUXINCLUDE}, ${KBUILD_EXTMOD}, etc. The top Makefile
defines several phony targets that run a script.

We do it also for an internally used script, which results in a somewhat
complex call graph.

One example:

 debian/rules binary-arch
   -> make intdeb-pkg
      -> scripts/package/builddeb

It is also tedious to add a dedicated target like 'intdeb-pkg' for each
use case.

Add a generic target 'run-command' to run an arbitrary command in an
environment with all Kbuild variables set.

The usage is:

  $ make run-command KBUILD_RUN_COMMAND=<command>

The concept is similar to:

  $ dpkg-architecture -c <command>

This executes <command> in an environment which has all DEB_* variables
defined.

Convert the existing 'make intdeb-pkg'.

Another possible usage is to interrogate a Make variable.

  $ make run-command KBUILD_RUN_COMMAND='echo $(KBUILD_CFLAGS)'

might be useful to see KBUILD_CFLAGS set by the top Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 4 ++++
 scripts/Makefile.package | 4 ----
 scripts/package/mkdebian | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 47690c28456a..f258ef13fa5d 100644
--- a/Makefile
+++ b/Makefile
@@ -2133,6 +2133,10 @@ kernelversion:
 image_name:
 	@echo $(KBUILD_IMAGE)
 
+PHONY += run-command
+run-command:
+	$(Q)$(KBUILD_RUN_COMMAND)
+
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
       cmd_rmfiles = rm -rf $(rm-files)
 
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index e9217e997c68..7cd61a374dae 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -146,10 +146,6 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
-PHONY += intdeb-pkg
-intdeb-pkg:
-	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
-
 # snap-pkg
 # ---------------------------------------------------------------------------
 PHONY += snap-pkg
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index ba2453e08d40..9105abab9728 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -283,7 +283,8 @@ build: build-arch
 binary-indep:
 binary-arch: build-arch
 	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
-	KERNELRELEASE=\$(KERNELRELEASE) intdeb-pkg
+	KERNELRELEASE=\$(KERNELRELEASE) \
+	run-command KBUILD_RUN_COMMAND=+\$(srctree)/scripts/package/builddeb
 
 clean:
 	rm -rf debian/files debian/linux-*
-- 
2.39.2

