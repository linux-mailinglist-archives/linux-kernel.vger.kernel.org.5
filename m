Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE747D4B07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjJXIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjJXIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4F172A;
        Tue, 24 Oct 2023 01:52:46 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6DNQlv21ZTBidvA/QYgU9WUU2cKXO4898OI1eWG1zA=;
        b=28Z87DFzxWilQQa8qKx7kVVRRXJFhUtjGyxM7ISHF/de62wuPPYmGfl8ZPCtCRTsaglFCH
        A4xmDoj3Obs4/FBcYCULeULhj0bqJQfiwqRNJB/jccEPZAW3uUujBnpOIzN69Xtyw5DyA4
        NTWVh0H9QvlbGJsNjQPibimKcu3i2EwpuoRjlnB2u3mcwco+f8ptzAdHKode/uvcW7h1qX
        cY8zGiSYbvSizpNhOx9CB8J2hZYVW3SR1yPXTUb22Mey9nwFY8YS0iQYfrmVZwHroBcDrB
        COaxMqqAzBoxgwc8uGt9z3YFo54v6qm68PNMncTRC3oAbWbL5Q92uB4oc7lNpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6DNQlv21ZTBidvA/QYgU9WUU2cKXO4898OI1eWG1zA=;
        b=4Qd9j9rfnmM0xUaCJjd4wrIJy31dn9R2J+NKereIX2+ImvlaAW7mZ52mlGcPjYoc4s5Et2
        pZFfGFWV5doA/8BQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Use LLVM addr2line and
 readelf if LLVM=1
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002165750.1661-3-will@kernel.org>
References: <20231002165750.1661-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <169813756376.3135.14752334773537866641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     86bf86e19d308a1dba41e5f1f7e8cc105a5efa49
Gitweb:        https://git.kernel.org/tip/86bf86e19d308a1dba41e5f1f7e8cc105a5efa49
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 02 Oct 2023 17:57:48 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 23 Oct 2023 08:36:33 -07:00

scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1

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

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20231002165750.1661-3-will@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index a35a420..6b82068 100755
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
 
