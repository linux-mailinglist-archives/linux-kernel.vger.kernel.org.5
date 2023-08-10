Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653F777AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjHJOZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjHJOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCFB2D52;
        Thu, 10 Aug 2023 07:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967F365DFA;
        Thu, 10 Aug 2023 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F1C433C8;
        Thu, 10 Aug 2023 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677493;
        bh=7p8Hud1MeCzOurHJwL3jJ1TBhDa8aySU3uDX+gwqFgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp8C13AiP+ArasUcg0BgwEKeZ9TF5iXSg6OViYuVDo203gqQgE3o0Xxo4p6mJ4Y6C
         VFO2vA9/QOj3KmGQwhS7r+Jt6qfBJNdSfcUzAsOwm/A0N7u5Nd2/Jzr1/Kc5w1bzML
         VUbMRNq7Wiz5suRmfFYhXOs/nVoJjQfQtbcgOZj+vEjBTqaTa3dFEcYQbzVeKJX+mD
         9nztt2BWivoW8zv+xZtuz3HGXihsHp/xoeijTk3jS6H4HmdMTsWyt90zDfaHMdj/dM
         4/AlLc/ul5P333x2yqROmctGhXDhsqCg98QgcvG1WPnJGc1Wdphg1j5Pf5ThUcY4x/
         lCJ11zuL+A/Tg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 17/17] [RFC] Makefile.extrawarn: turn on missing-prototypes again
Date:   Thu, 10 Aug 2023 16:19:35 +0200
Message-Id: <20230810141947.1236730-18-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Over the years we went from > 1000 of warnings to under 100 earlier
this year, and I sent patches to address all the ones that I saw with
compile testing randcom configs on arm64, arm and x86 kernels. This is a
really useful warning, as it catches real bugs when there are mismatched
prototypes. In particular with kernel control flow integrity enabled,
those are no longer allowed.

Move the options out of the W=1 section to have them enabled by
default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm sure there are still regressions with CONFIG_WERROR when this gets
turned on, but it's getting very close, so it might be best to already
enable this in linux-next but wait one extra merge window to have it in
mainline while the last fixes trickle in.
---
 scripts/Makefile.extrawarn | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 40cd13eca82e8..fda5f9087a863 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -15,6 +15,9 @@ ifeq ("$(origin W)", "command line")
   KBUILD_EXTRA_WARN := $(W)
 endif
 
+KBUILD_CFLAGS += -Wmissing-declarations
+KBUILD_CFLAGS += -Wmissing-prototypes
+
 export KBUILD_EXTRA_WARN
 
 #
@@ -23,9 +26,7 @@ export KBUILD_EXTRA_WARN
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
 KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
-KBUILD_CFLAGS += -Wmissing-declarations
 KBUILD_CFLAGS += -Wmissing-format-attribute
-KBUILD_CFLAGS += -Wmissing-prototypes
 KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
 KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
-- 
2.39.2

