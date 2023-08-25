Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639D788FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHYUla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjHYUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:41:02 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 13:40:59 PDT
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA92135
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:40:59 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 06E272565E783; Fri, 25 Aug 2023 13:20:37 -0700 (PDT)
From:   Yonghong Song <yonghong.song@linux.dev>
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] kallsyms: Change func signature for cleanup_symbol_name()
Date:   Fri, 25 Aug 2023 13:20:36 -0700
Message-Id: <20230825202036.441212-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of cleanup_symbol_name() do not use the return value.
So let us change the return value of cleanup_symbol_name() to
'void' to reflect its usage pattern.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/kallsyms.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

NOTE:
This patch needs to be applied after the following patch:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=
=3D33f0467fe069

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e12d26c10dba..18edd57b5fe8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -163,12 +163,12 @@ unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
=20
-static bool cleanup_symbol_name(char *s)
+static void cleanup_symbol_name(char *s)
 {
 	char *res;
=20
 	if (!IS_ENABLED(CONFIG_LTO_CLANG))
-		return false;
+		return;
=20
 	/*
 	 * LLVM appends various suffixes for local functions and variables that
@@ -178,12 +178,10 @@ static bool cleanup_symbol_name(char *s)
 	 * - foo.llvm.[0-9a-f]+
 	 */
 	res =3D strstr(s, ".llvm.");
-	if (res) {
+	if (res)
 		*res =3D '\0';
-		return true;
-	}
=20
-	return false;
+	return;
 }
=20
 static int compare_symbol_name(const char *name, char *namebuf)
--=20
2.34.1

