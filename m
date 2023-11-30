Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06557FFD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376782AbjK3UwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3UwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:52:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06526D54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:52:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B17C433C7;
        Thu, 30 Nov 2023 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701377534;
        bh=R7LNuLwRzlt/17e18V7R1EEOuUFGqpcWy3MHGj0x6iM=;
        h=Date:From:To:Cc:Subject:From;
        b=PH9L32LDTUo5YBVfdO+i974H6l5nZItyapR+AsLpeoGzf/+dGCu1c+X+ivz0qgAhv
         +ubaCZfQPmAeHFtWPvxjrYsyh8V0OvLWxCfqKemE0TiBLk02sCZqL65asc3cPEz/9t
         KAT/mFR7jEEK8re5RUp3wiVeqEIDk9V9LU9zz17+5drCadHLfMdB18Q9ndgkdF+uku
         ImJYlkGfUNJvFioVreeYdyiVIcczEMuV+ZhFF6y1+hSwDx5p+IrMUcF8X7vDRt51M5
         6JB4ng2ylWAtNJxDcQGXioxeERJhmYABsjgkx2EecpJs0NnW2DCHpRgTUUN5u38X3l
         IpQI2NCEwvZlA==
Date:   Thu, 30 Nov 2023 14:52:10 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] init: Kconfig: Disable -Wstringop-overflow for GCC-11
Message-ID: <ZWj1+jkweEDWbmAR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Wstringop-overflow is buggy in GCC-11. Therefore, we should disable
this option specifically for that compiler version. To achieve this,
we introduce a new configuration option: GCC11_NO_STRINGOP_OVERFLOW.

The compiler option related to string operation overflow is now managed
under configuration CC_STRINGOP_OVERFLOW. This option is enabled by
default for all other versions of GCC that support it.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 Makefile     |  4 +++-
 init/Kconfig | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2cfd71ae3a86..8adc611fb611 100644
--- a/Makefile
+++ b/Makefile
@@ -982,7 +982,9 @@ NOSTDINC_FLAGS += -nostdinc
 # perform bounds checking.
 KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
 
-KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
+#Currently, disable -Wstringop-overflow for GCC 11, globally.
+KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) += $(call cc-option, -Wno-stringop-overflow)
+KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) += $(call cc-option, -Wstringop-overflow)
 
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..aaaa99a5d2a9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -876,6 +876,18 @@ config CC_NO_ARRAY_BOUNDS
 	bool
 	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
 
+# Currently, disable -Wstringop-overflow for GCC 11, globally.
+config GCC11_NO_STRINGOP_OVERFLOW
+	def_bool y
+
+config CC_NO_STRINGOP_OVERFLOW
+	bool
+	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC_VERSION < 120000 && GCC11_NO_STRINGOP_OVERFLOW
+
+config CC_STRINGOP_OVERFLOW
+	bool
+	default y if CC_IS_GCC && !CC_NO_STRINGOP_OVERFLOW
+
 #
 # For architectures that know their GCC __int128 support is sound
 #
-- 
2.34.1

