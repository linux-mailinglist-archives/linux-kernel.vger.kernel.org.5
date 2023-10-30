Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C087DB907
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjJ3LeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:34:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85658C2;
        Mon, 30 Oct 2023 04:34:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A264C433C7;
        Mon, 30 Oct 2023 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698665661;
        bh=XBOZSHuoRoD8WSPEZTng3lqWdqh+3Xe2FMkuy6z6a5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=h7FAyb6L9+v/tF5yELzcBvV8YRsztwzw7cEAW+REYwt+YuHpBEA1E5G5HybX0aB4H
         /tTM0Vje5C0dQvzg3m736p1/tVI02ubFMfaqlSA0/RirHr2WHX155UHkY+4j0HPgDd
         sTNChCTbF96Wj3i0V7e92or2k+M4uUh4W9oBbRXGRpEJvPQ9TPEQoi+t9drnIDAsjO
         6p/x7Nh1CR6ZbvSvZrP17eRbuPh+exeiZfVrGOq4q1Xk8IrH4O55cPYgAmWUhYnEMH
         425paWxK73OY9a31Kjnv/JUKh5aFni2E0yomCT6+vYMPwKo4L3wGxw7CwjCZ33syVS
         FvtPW4VgmxnQw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] kbuild: dummy-tools: pretend we understand -fpatchable-function-entry
Date:   Mon, 30 Oct 2023 12:34:16 +0100
Message-ID: <20231030113416.5208-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0f71dcfb4aef (powerpc/ftrace: Add support for
-fpatchable-function-entry) added a script to check for
-fpatchable-function-entry compiler support. The script expects compiler
to emit the section __patchable_function_entries and few nops after a
function entry.

If the compiler understands and emits the above,
CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY is set.

So teach dummy-tools' gcc about this.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 scripts/dummy-tools/gcc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 07f6dc4c5cf6..e6c41427c02f 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -91,6 +91,16 @@ if arg_contain -S "$@"; then
 		fi
 		exit 0
 	fi
+
+	# For arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
+	if arg_contain -m64 "$@" && arg_contain -fpatchable-function-entry=2 "$@"; then
+		echo "func:"
+		echo ".section __patchable_function_entries"
+		echo ".localentry"
+		echo "  nop"
+		echo "  nop"
+		exit 0
+	fi
 fi
 
 # To set GCC_PLUGINS
-- 
2.42.0

