Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD397B58F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjJBQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbjJBQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0264B8;
        Mon,  2 Oct 2023 09:58:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE9C433C7;
        Mon,  2 Oct 2023 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265882;
        bh=q5YCA8p0CGC7cTGNfTdRfhSsu0Oi56m79bI+z6AlhIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smS5zvrQR+zwmmjSJOrtQGBHEGCoK9wYqujaWmDDRGeHNtGeUZ5yPgbZGMXTK2u+x
         AW8tODwGP5hVzlD0/G6LuTLfzTslF9o5X2rhAtCDzLOxadA0j66DBebRXWUi1sbp+9
         TdNm6VV3MivgjNXLYi2V84DAQ0hVShAmQWPUjodVam4s7JTCbMBhPKV73ml/++V3uN
         jwAvEyLfyzujWkMNOrIRG/MzGBudnLWmnHCjOu0cWcfdKuyOZwsnUSwt7wBCwKrjCG
         mXABdfgP2hAdr52MbifgZup1jO4ZM6unX39omk5yuoYov7cKTzppRQoOPcTIZOJdzA
         pG3ghlndlW0wQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 2/3] scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
Date:   Mon,  2 Oct 2023 17:57:48 +0100
Message-Id: <20231002165750.1661-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231002165750.1661-1-will@kernel.org>
References: <20231002165750.1661-1-will@kernel.org>
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
accept LLVM= as an indication to use the llvm- tools, optionally
specifying their location or specific version number.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index a35a420d0f26..6b8206802157 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -58,8 +58,21 @@ die() {
 	exit 1
 }
 
-READELF="${CROSS_COMPILE:-}readelf"
-ADDR2LINE="${CROSS_COMPILE:-}addr2line"
+UTIL_SUFFIX=""
+if [[ "${LLVM:-}" == "" ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+
+	if [[ "${LLVM}" == *"/" ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ "${LLVM}" == "-"* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF="${UTIL_PREFIX}readelf${UTIL_SUFFIX}"
+ADDR2LINE="${UTIL_PREFIX}addr2line${UTIL_SUFFIX}"
 AWK="awk"
 GREP="grep"
 
-- 
2.42.0.582.g8ccd20d70d-goog

