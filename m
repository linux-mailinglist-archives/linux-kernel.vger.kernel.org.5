Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4F772963
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHGPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHGPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF3919A9;
        Mon,  7 Aug 2023 08:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA36E61E2C;
        Mon,  7 Aug 2023 15:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68116C433C7;
        Mon,  7 Aug 2023 15:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422630;
        bh=Tv6VzIDd4SIlArHBmIHp9VMuLmiykxV8wOzCt+lQsFg=;
        h=From:Date:Subject:To:Cc:From;
        b=pYDj8uco4GtRbiwzZQvDQuZqaghPK/L/nkZ2pZfUDnIp7eOfWyTy/bnDqck2DL0gE
         8/J8KohuKXxPgOci7K/A8KXF6nnLlgrH1pHUpNk8WGaZtjV1crio+MHCk8fjkQBjPb
         CY1iec/HzpPhW3xRDtkKQ+TBmSba1u33OsXGvvv1NKSpJnDCZlzFSg+Ukjgldo+khW
         hkBW83rtyKiJj5XWDeHSlFTKBJZH9vPpe7hUyAnitqiN0abMEoeBCyXVJwvI15Mck7
         IUf3QHQ/Zl76gPtJEiy8nLKVqbBbA+2zPP6WvhNW+FOwHpha5VtoxoPOMx7osRLVXH
         uIYxVPT/mrtUg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 07 Aug 2023 08:36:28 -0700
Subject: [PATCH v2] lib: test_scanf: Add explicit type cast to result
 initialization in test_number_prefix()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-test_scanf-wconstant-conversion-v2-1-839ca39083e1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHsP0WQC/42NXQrCMBCEr1L22ZU2rdT65D2kSH42bVAS2YSol
 N7dtCfwbb6B+WaBSOwowqVagCm76IIvIA4V6Fn6idCZwiBq0dbnusVEMd2jlt7iWwcfk/QJS8j
 E2xbN0JNVtlXqZKBYXkzWffaH21h4djEF/u6Hudna/925wQb7zshh6AwZpa8PYk/PY+AJxnVdf
 2Pr4zvPAAAA
To:     pmladek@suse.com, rostedt@goodmis.org
Cc:     senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Tv6VzIDd4SIlArHBmIHp9VMuLmiykxV8wOzCt+lQsFg=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCkX+ZfeXZ6ZtHxLf+QKvwd7Tp7avsChcfJjk+TXPnrKr
 //+fHzwV0cpC4MYB4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYiMJORoav2WeXuqfc1LXM
 uqpxcbGBc36moElHXIvRPN9Z00otxX0Y/kpIswrm9WVFdX77Iffx5Yzku3Ou3OPevTddYY1pq5N
 AOA8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change in clang allows it to consider more expressions as
compile time constants, which causes it to point out an implicit
conversion in the scanf tests:

  lib/test_scanf.c:661:2: warning: implicit conversion from 'int' to 'unsigned char' changes value from -168 to 88 [-Wconstant-conversion]
    661 |         test_number_prefix(unsigned char,       "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lib/test_scanf.c:609:29: note: expanded from macro 'test_number_prefix'
    609 |         T result[2] = {~expect[0], ~expect[1]};                                 \
        |                       ~            ^~~~~~~~~~
  1 warning generated.

The result of the bitwise negation is the type of the operand after
going through the integer promotion rules, so this truncation is
expected but harmless, as the initial values in the result array get
overwritten by _test() anyways. Add an explicit cast to the expected
type in test_number_prefix() to silence the warning. There is no
functional change, as all the tests still pass with GCC 13.1.0 and clang
18.0.0.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1899
Link: https://github.com/llvm/llvm-project/commit/610ec954e1f81c0e8fcadedcd25afe643f5a094e
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Add spaces in initializer to match result (Andy)
- Add 'Cc: stable', as builds with CONFIG_WERROR will be broken, such as
  allmodconfig
- Link to v1: https://lore.kernel.org/r/20230803-test_scanf-wconstant-conversion-v1-1-74da994dedbc@kernel.org
---
 lib/test_scanf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index b620cf7de503..a2707af2951a 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -606,7 +606,7 @@ static void __init numbers_slice(void)
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
 do {										\
 	const T expect[2] = { expect0, expect1 };				\
-	T result[2] = {~expect[0], ~expect[1]};					\
+	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
 	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
 } while (0)

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230803-test_scanf-wconstant-conversion-d97efbf3bb5d

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

