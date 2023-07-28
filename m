Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000ED766BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjG1Le3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjG1Le0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:34:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCE19A1;
        Fri, 28 Jul 2023 04:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE78D6210D;
        Fri, 28 Jul 2023 11:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDBC433CD;
        Fri, 28 Jul 2023 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544064;
        bh=11Y/2vUczXq1zex6nKxwrM3jqc49ICOzRUdx4wC2BY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9WHnz15nlN8jrFYE+P5sHthvGhkzs5ETS0KFCk3serXXVpDV5I76lP4MNBw37yQ/
         17Hg0dBVemJ86i90tY0habw2oMXp/GhsH+NSXWik9eBjZYFMfbrVKLk3A6+X5nf97L
         9glyR9vZzJ8R9zqkUHuqMU8rL2LQQaZ5TtbMn2QB+dz0vDM3jBNegR8jxlgUwKRrdR
         N3FpVx77t92pnHL5GnQg7TpKup2ZFANeiEgcl5KsoCQKH1O1srMvQoOOegosIs0qWa
         0Zu5L1uFSu3Q297Hh9JOpqHTTyM/MI4P00aJUbsUaI7qOpUvHKAZ5lLLZ0h5P8sLSr
         g64rp59Zof+gg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 1/4] scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
Date:   Fri, 28 Jul 2023 12:34:12 +0100
Message-Id: <20230728113415.21067-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728113415.21067-1-will@kernel.org>
References: <20230728113415.21067-1-will@kernel.org>
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

GNU utilities cannot necessarily parse objects built by LLVM, which can
result in confusing errors when using 'faddr2line':

$ CROSS_COMPILE=aarch64-linux-gnu- ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
do_one_initcall+0xf4/0x260:
aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
$x.73 at main.c:?

Although this can be worked around by setting CROSS_COMPILE to "llvm=-",
it's cleaner to follow the same syntax as the top-level Makefile and
accept LLVM=1 as an indication to use the llvm- tools.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e73aca4f908..62a3fa6f6f59 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -58,8 +58,14 @@ die() {
 	exit 1
 }
 
-READELF="${CROSS_COMPILE:-}readelf"
-ADDR2LINE="${CROSS_COMPILE:-}addr2line"
+if [ "${LLVM:-}" == "1" ]; then
+	UTIL_PREFIX=llvm-
+else
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+fi
+
+READELF="${UTIL_PREFIX}readelf"
+ADDR2LINE="${UTIL_PREFIX}addr2line"
 AWK="awk"
 GREP="grep"
 
-- 
2.41.0.487.g6d72f3e995-goog

