Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB597A052C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbjINNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbjINNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:12:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766511BEB;
        Thu, 14 Sep 2023 06:12:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17996C433C7;
        Thu, 14 Sep 2023 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697157;
        bh=ksHtCQ3f6WqJu168Hihgnq5gW72bRry4aHrKZsuI6oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMWtA2/9zKmWrRQ+C+6DLotBrdjcrS0yycwZfI4UCKzYByIf08lwLi+3PfdWgW2Y2
         hZZt+l1gZLCffo+OznQ+0WmZaMTQjxMG7Is13CfMDJwcKCqsynW9qflMAsrahhOiZQ
         Q3TwpOoJXTQ4vLCMQU254oOOEI2ARspiMDkdQHN8DR0zGpz7VimPJxRPNz4wJ1WAzh
         CRII/0UuS5uE0hPbKhi4BdoEf7hfiC6NScPfyCpDJbGM9egdmnKwySTFbVJJcJMfUS
         MLP3I8O8c+ZmpN+v4ZWm4X0BNC5687hSohZaIAaRDBf9zAt6z3Xq6cnn1gr3ti24F4
         YkNoQC9G5I6uA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v4 2/3] scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
Date:   Thu, 14 Sep 2023 14:12:24 +0100
Message-Id: <20230914131225.13415-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914131225.13415-1-will@kernel.org>
References: <20230914131225.13415-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.42.0.283.g2d96d420d3-goog

