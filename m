Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3C76242D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGYVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366019A4;
        Tue, 25 Jul 2023 14:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FCFC618E8;
        Tue, 25 Jul 2023 21:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E296BC433CD;
        Tue, 25 Jul 2023 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690319530;
        bh=q08Zp/HrT7heTstkuwX+BMifLSLWW6msQ6kNbV77Ua0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVp2RYFPSZl4vK96ZGq9qmqfDCFy4kJz3u7HldrwwbXSR782Mpz3b/QK6dKuHBUzD
         VDjtzf3sONi7ey6ndjz+rpZASFt75Dvd5VpBRyU57pcr3H41pZNZ/G6r9ebwBPpfMZ
         3Kb+CKiVhSN533P8+REn2c85tXMk9VNf2y++bOsEgKfJrlP8Z8ESVPNiJQ4KkSIlLn
         IuaIJGKGQxZe3BRtPNXIYtCOqU2OVitqJfsk4J4iC12WMnWuBxud1bdEQzJCHXydzT
         Jjsr1xxebF1byWjTPSmN4qhHZNTaP09KFWmXMO6uepy0l69ybRFVjdtOaTuN1A1SEP
         lcY6LmRlzxKXw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v2 1/2] scripts/mksysmap: Factor out sed ignored symbols expression into script
Date:   Tue, 25 Jul 2023 22:11:56 +0100
Message-Id: <20230725211157.17031-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230725211157.17031-1-will@kernel.org>
References: <20230725211157.17031-1-will@kernel.org>
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

