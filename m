Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64027EDA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjKPD1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjKPD1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:27:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D01A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:27:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE41C433C7;
        Thu, 16 Nov 2023 03:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700105229;
        bh=0RxvFSGgxRT7IzJsthnJWzmXWCyJavEwPeaq9aEW7Sc=;
        h=Date:From:To:Cc:Subject:From;
        b=g28Utjwy9tiQeSYo5Ou1JeJZ+xpcjmO2McxjRXcY6dku5ZFpCfd89/xGX+FMUj7dR
         kAYlx66JNZF+0x8GSf495dBz12b92M2laK/mKiH/gyHH41odO33dbCsvCFal1bMLcH
         cbE4DGYuxS7/QuWOfMspVxWURHDZOMvDACU8uXZh8hb1mowsEbUCIQZI9cCXhZidET
         ZnPcFPPM8C+5uRjgPiM48cPMbP+zB5NQv5tTrV5/TJac1BGN3KB1ISnTGH8RDY+TjQ
         baJqz3isNod82PvbColGx2jWivFpsEEO5RatsdyDagTQSjfVHCftQ4tYjmrtozdRJf
         QrLuGZhbeTHRA==
Date:   Wed, 15 Nov 2023 21:27:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] Makefile: Enable -Wstringop-overflow globally
Message-ID: <ZVWMCZ/jb4nX3yHn@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we have finished addressing all the remaining
issues regarding compiler option -Wstringop-overflow. So, we
are now in good shape to enable this compiler option globally.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 Makefile                   | 3 +++
 scripts/Makefile.extrawarn | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 690cde550acd..452b7d0e19e9 100644
--- a/Makefile
+++ b/Makefile
@@ -985,6 +985,9 @@ NOSTDINC_FLAGS += -nostdinc
 # perform bounds checking.
 KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
 
+# We are now in good shape to enable this option.
+KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
+
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
 
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2fe6f2828d37..1527199161d7 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -106,7 +106,6 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
 KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
-KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 
 KBUILD_CPPFLAGS += -Wundef
@@ -122,7 +121,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 ifdef CONFIG_CC_IS_CLANG
-- 
2.34.1

