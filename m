Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A6813266
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573377AbjLNODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573115AbjLNODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:03:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBDA9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:03:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48648C433C8;
        Thu, 14 Dec 2023 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702562597;
        bh=TmBlvdhMtwd+CkVq89ydLq0CdC3DZHSb/94YMt+8cx8=;
        h=From:To:Cc:Subject:Date:From;
        b=FSGR75HF8Uib5Aw6ixmy6n88N7GAR4E0yWRjocRCwxIpVzJaSaIQUU24OgU7gXugw
         DYdvOUH8LXwIfLoBZTvuj8yTMzr1M3jaLmRBDv3L79Znt910VQSZKYxMOaFvde9ztA
         MFRAUbzY2VQNgIOjQqe/jAoSuu9JR+Ls4tNhQihAUcZDxFjgp50X7bAjObi+HpbpF+
         PHDPksngqGzcZj/Qkd7Zd0+9NKqSqvsXuyLA0Pwmr5Ch9zHdRt8PAcPhh+F4um32eZ
         wq1TNJHTpfOOpCpQsSWDH2bWg+l7x4Hl7O6Ws6kjjC0E4zCRRraKkWYNlDMl95r3g4
         DwAjT8rMNmKJg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: resolve symlinks for O= properly
Date:   Thu, 14 Dec 2023 23:03:05 +0900
Message-Id: <20231214140305.531963-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Kbuild follows the logical chain of directories for the O=
option, just like 'cd' (or 'realpath --logical') does.

Example:

    $ mkdir -p /tmp/a /tmp/x/y
    $ ln -s /tmp/x/y /tmp/a/b
    $ realpath /tmp/a/b/..
    /tmp/x
    $ realpath --logical /tmp/a/b/..
    /tmp/a
    $ make O=/tmp/a/b/.. defconfig
    make[1]: Entering directory '/tmp/a'
      [snip]
    make[1]: Leaving directory '/tmp/a'

'make O=/tmp/a/b/.. defconfig' creates the kernel configuration in
/tmp/a instead of /tmp/x despite the directory path /tmp/a/b/..
resolves to the physical directory path /tmp/x.

This is because Kbuild internally uses the 'cd ... && pwd' for the
path resolution, but this behavior is not predictable for users.
Additionally, it is not consistent with how the Kbuild handles the
M= option or GNU Make works with 'make -C /tmp/a/b/..'.

Using the physical directory structure for the O= option seems more
reasonable.

The comment says "expand a shell special character '~'", but it has
already been expanded to the home directory in the command line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 24fac1889997..a05f0f7c99e0 100644
--- a/Makefile
+++ b/Makefile
@@ -190,14 +190,11 @@ ifeq ("$(origin O)", "command line")
 endif
 
 ifneq ($(KBUILD_OUTPUT),)
-# Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
-# expand a shell special character '~'. We use a somewhat tedious way here.
-abs_objtree := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
-$(if $(abs_objtree),, \
-     $(error failed to create output directory "$(KBUILD_OUTPUT)"))
-
+# $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p' first.
+$(shell mkdir -p $(KBUILD_OUTPUT))
 # $(realpath ...) resolves symlinks
-abs_objtree := $(realpath $(abs_objtree))
+abs_objtree := $(realpath $(KBUILD_OUTPUT))
+$(if $(abs_objtree),,$(error failed to create output directory "$(KBUILD_OUTPUT)"))
 endif # ifneq ($(KBUILD_OUTPUT),)
 
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
-- 
2.40.1

