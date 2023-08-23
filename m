Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63073785725
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjHWLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjHWLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE285DB;
        Wed, 23 Aug 2023 04:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B73964B5F;
        Wed, 23 Aug 2023 11:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE55C433BB;
        Wed, 23 Aug 2023 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791461;
        bh=17ZI9OuOHnRLfA+Aw4o40RdR2fIS9vJw5OhR2qQpZiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUxX4xhsUQgev7TX7KnUzypflQUoGPIqH8x29uyoEn26LluX/etqEJ1udaR/94PEz
         GRJiMpf1EMIA9nJAp64bvT3EdAn+HalMD8WVX6ed7DwYReKntOvr0zF5c+VeB45iYp
         yqqux7rPhmld+o67J4rmILzy8FflfnQ4JRWe/CPYcsxDS9+LFlKN6p6dEQ13GzQDrx
         SCqzA7gT/mo0ujZGj3kVfM0/VTUj8K+3uzVkZGHSDCmq3uLor8uV1N8xfV5IyeRjFX
         Wd+PweV490O6s4pKn5yZ3XDD5DFXE5E3lqHNm4gzgg9sGAQD+SD+SC3oPknXYVovAV
         m2/bbSFidLEgQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/8] kbuild: remove $(MODLIB)/source symlink
Date:   Wed, 23 Aug 2023 20:50:44 +0900
Message-Id: <20230823115048.823011-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the old commit "kbuild: Introduce source symlink in
/lib/modules/.../". [1]

The current Kbuild does not require $(MODLIB)/source. If the kernel was
built in a separate output directory, $(MODLIB)/build/Makefile wraps
the Makefile in the source tree. It is enough for building external
modules.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=e09e58867154b8aae0a3ac26a9b1c05962f5a355

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index c9c8019e4720..7d9cab3d2186 100644
--- a/Makefile
+++ b/Makefile
@@ -1486,14 +1486,10 @@ modules_install: $(modinst_pre)
 PHONY += __modinst_pre
 __modinst_pre:
 	@rm -rf $(MODLIB)/kernel
-	@rm -f $(MODLIB)/source
+	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)
 ifdef CONFIG_MODULES
-	@ln -s $(abspath $(srctree)) $(MODLIB)/source
-	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
-		rm -f $(MODLIB)/build ; \
-		ln -s $(CURDIR) $(MODLIB)/build ; \
-	fi
+	@ln -s $(CURDIR) $(MODLIB)/build
 	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
 endif
 	@cp -f modules.builtin $(MODLIB)/
-- 
2.39.2

