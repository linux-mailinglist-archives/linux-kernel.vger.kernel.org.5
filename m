Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E93766BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjG1Lef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjG1Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE42D5B;
        Fri, 28 Jul 2023 04:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36184620FF;
        Fri, 28 Jul 2023 11:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F31C433C8;
        Fri, 28 Jul 2023 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544066;
        bh=q08Zp/HrT7heTstkuwX+BMifLSLWW6msQ6kNbV77Ua0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQdHV/wp9RlqPD9y7oURfC5NiYE9B94pfY5qWKb1wh+dIya3UQtjS0OGzihi4wXS7
         Ujw7ZskQgxU7XcGchqZbNK/U8wEM/V+3VEXF06kiOF3ERQVoFY32muocpULA0KkZC7
         mOBtXc7YWbTknfzrg9H8oS8V2rM4deH2nrtmrsHwgBDj9OmEEv1dolhbZZfuG7qrFb
         KI3MOonCq09uBmLerRZjzWpxmKg5TO1GfNWe5MGDYH8nzTFHqiE6w4EbE3WRZsW31X
         oYmQs6BMM1LSGhJHsd8zFba47LYa7n7CbCTb8sMJP7C7U5ndcCflqoIk0LcXMbZiIN
         JH/ZJ8URUZCxw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 2/4] scripts/mksysmap: Factor out sed ignored symbols expression into script
Date:   Fri, 28 Jul 2023 12:34:13 +0100
Message-Id: <20230728113415.21067-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728113415.21067-1-will@kernel.org>
References: <20230728113415.21067-1-will@kernel.org>
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

To prepare for 'faddr2line' reusing the same ignored symbols list as
'mksysmap', factor out the relevant sed expression into its own script,
removing the double-escapes for '$' symbols as they are no longer
required.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/mksysmap                | 77 +--------------------------------
 scripts/sysmap-ignored-syms.sed | 74 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 76 deletions(-)
 create mode 100644 scripts/sysmap-ignored-syms.sed

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 9ba1c9da0a40..a98b34363258 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -16,7 +16,7 @@
 # 'W' or 'w'.
 #
 
-${NM} -n ${1} | sed >${2} -e "
+${NM} -n ${1} | sed >${2} -f $(dirname $0)/sysmap-ignored-syms.sed -e "
 # ---------------------------------------------------------------------------
 # Ignored symbol types
 #
@@ -27,81 +27,6 @@ ${NM} -n ${1} | sed >${2} -e "
 # w: local weak symbols
 / [aNUw] /d
 
-# ---------------------------------------------------------------------------
-# Ignored prefixes
-#  (do not forget a space before each pattern)
-
-# local symbols for ARM, MIPS, etc.
-/ \\$/d
-
-# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
-/ \.L/d
-
-# arm64 EFI stub namespace
-/ __efistub_/d
-
-# arm64 local symbols in PIE namespace
-/ __pi_\\$/d
-/ __pi_\.L/d
-
-# arm64 local symbols in non-VHE KVM namespace
-/ __kvm_nvhe_\\$/d
-/ __kvm_nvhe_\.L/d
-
-# arm64 lld
-/ __AArch64ADRPThunk_/d
-
-# arm lld
-/ __ARMV5PILongThunk_/d
-/ __ARMV7PILongThunk_/d
-/ __ThumbV7PILongThunk_/d
-
-# mips lld
-/ __LA25Thunk_/d
-/ __microLA25Thunk_/d
-
-# CFI type identifiers
-/ __kcfi_typeid_/d
-/ __kvm_nvhe___kcfi_typeid_/d
-/ __pi___kcfi_typeid_/d
-
-# CRC from modversions
-/ __crc_/d
-
-# EXPORT_SYMBOL (symbol name)
-/ __kstrtab_/d
-
-# EXPORT_SYMBOL (namespace)
-/ __kstrtabns_/d
-
-# ---------------------------------------------------------------------------
-# Ignored suffixes
-#  (do not forget '$' after each pattern)
-
-# arm
-/_from_arm$/d
-/_from_thumb$/d
-/_veneer$/d
-
-# ---------------------------------------------------------------------------
-# Ignored symbols (exact match)
-#  (do not forget a space before and '$' after each pattern)
-
-# for LoongArch?
-/ L0$/d
-
-# ppc
-/ _SDA_BASE_$/d
-/ _SDA2_BASE_$/d
-
-# ---------------------------------------------------------------------------
-# Ignored patterns
-#  (symbols that contain the pattern are ignored)
-
-# ppc stub
-/\.long_branch\./d
-/\.plt_branch\./d
-
 # ---------------------------------------------------------------------------
 # Ignored kallsyms symbols
 #
diff --git a/scripts/sysmap-ignored-syms.sed b/scripts/sysmap-ignored-syms.sed
new file mode 100644
index 000000000000..14b9eb2c9ed9
--- /dev/null
+++ b/scripts/sysmap-ignored-syms.sed
@@ -0,0 +1,74 @@
+# ---------------------------------------------------------------------------
+# Ignored prefixes
+#  (do not forget a space before each pattern)
+
+# local symbols for ARM, MIPS, etc.
+/ \$/d
+
+# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
+/ \.L/d
+
+# arm64 EFI stub namespace
+/ __efistub_/d
+
+# arm64 local symbols in PIE namespace
+/ __pi_\$/d
+/ __pi_\.L/d
+
+# arm64 local symbols in non-VHE KVM namespace
+/ __kvm_nvhe_\$/d
+/ __kvm_nvhe_\.L/d
+
+# arm64 lld
+/ __AArch64ADRPThunk_/d
+
+# arm lld
+/ __ARMV5PILongThunk_/d
+/ __ARMV7PILongThunk_/d
+/ __ThumbV7PILongThunk_/d
+
+# mips lld
+/ __LA25Thunk_/d
+/ __microLA25Thunk_/d
+
+# CFI type identifiers
+/ __kcfi_typeid_/d
+/ __kvm_nvhe___kcfi_typeid_/d
+/ __pi___kcfi_typeid_/d
+
+# CRC from modversions
+/ __crc_/d
+
+# EXPORT_SYMBOL (symbol name)
+/ __kstrtab_/d
+
+# EXPORT_SYMBOL (namespace)
+/ __kstrtabns_/d
+
+# ---------------------------------------------------------------------------
+# Ignored suffixes
+#  (do not forget '$' after each pattern)
+
+# arm
+/_from_arm$/d
+/_from_thumb$/d
+/_veneer$/d
+
+# ---------------------------------------------------------------------------
+# Ignored symbols (exact match)
+#  (do not forget a space before and '$' after each pattern)
+
+# for LoongArch?
+/ L0$/d
+
+# ppc
+/ _SDA_BASE_$/d
+/ _SDA2_BASE_$/d
+
+# ---------------------------------------------------------------------------
+# Ignored patterns
+#  (symbols that contain the pattern are ignored)
+
+# ppc stub
+/\.long_branch\./d
+/\.plt_branch\./d
-- 
2.41.0.487.g6d72f3e995-goog

