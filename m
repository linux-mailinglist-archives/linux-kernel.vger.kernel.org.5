Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B540A75FE77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGXRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGXRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145D4203
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE4F61312
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EDAC433C7;
        Mon, 24 Jul 2023 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690220725;
        bh=i/3ARKu2v/GvD5MJ/ESSUDjGzezlHuJEXEcQosWyGxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giw/2Q3xI3BJd+qXlnT5waP43ZXAgYm5VhgjSj8yRAByRpbbHrtlZsqiolfmNQk0i
         9HJLQz5NPiV08MPYrJ6x7nH2ect7N6NvRMGZghRrPOgaRLIrlqOZf5EJOYlc9RzX/4
         5ngKvNYTRf4aUYODIPD7qPFn7Y4ZiMkWyCYXtnWpN3tqYtZtSn0epwmlsWWRxu5lAo
         kjX90gJ3/G07/dWqJg69QhS8+ZXaP3V7B4jfPrg/32i814sfzCN5TmHSsTTxhaqp/O
         obRFovv3/hPnlQlKKgkUK8vWusSRcFQ6PvhrSzwDXAMRjFCIhMGBKd7xf9v391UjHE
         d8CHYroZ1sJNg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH 2/2] scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
Date:   Mon, 24 Jul 2023 18:45:17 +0100
Message-Id: <20230724174517.15736-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230724174517.15736-1-will@kernel.org>
References: <20230724174517.15736-1-will@kernel.org>
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
index 60368a1cdaed..24845267efb2 100755
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

