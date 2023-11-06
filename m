Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69977E309E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjKFXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjKFXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:06:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF0D73;
        Mon,  6 Nov 2023 15:06:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A5DC433C7;
        Mon,  6 Nov 2023 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312000;
        bh=4G1C15qqWoa8WZ4NPJj+98V/NuK8foqW7t8CBB/oMHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2+7Z6Q2HrIeFGoa/qDRAZmDBo+XvqKf2zT/Gf29nA9G375a7L57CkbiPBkhSoxYn
         YeS68Aw8thutptTT+8MKzXZQalAWlLFKZ77OvBJkaCd5w22+9OgUbyA2IqnhIl+J2n
         WrU3OzIu86Pn0idCgktA9FvLUnrgoEe3PKFzQtJ79J6ANC71gtrAPnDv1cEwXyOtfL
         42xmFkrFERn4yx5IXtkv5rzOXSlb3rJJR90SZWy4SUhfeLssZg8VzaItCiCZgSDd+r
         qxmdJcbNavhnUAnJQgRmbhAiHP+3HwwkJ7z+OqngIlsY3sZPnLzoxBsxfqm3c+1H2b
         EeeadQI9qIEUA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        Sasha Levin <sashal@kernel.org>, masahiroy@kernel.org,
        samitolvanen@google.com, keescook@chromium.org,
        peterz@infradead.org, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 5/5] x86/retpoline: Make sure there are no unconverted return thunks due to KCSAN
Date:   Mon,  6 Nov 2023 18:06:11 -0500
Message-ID: <20231106230622.3734225-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106230622.3734225-1-sashal@kernel.org>
References: <20231106230622.3734225-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 2d7ce49f58dc95495b3e22e45d2be7de909b2c63 ]

Enabling CONFIG_KCSAN leads to unconverted, default return thunks to
remain after patching.

As David Kaplan describes in his debugging of the issue, it is caused by
a couple of KCSAN-generated constructors which aren't processed by
objtool:

  "When KCSAN is enabled, GCC generates lots of constructor functions
  named _sub_I_00099_0 which call __tsan_init and then return.  The
  returns in these are generally annotated normally by objtool and fixed
  up at runtime.  But objtool runs on vmlinux.o and vmlinux.o does not
  include a couple of object files that are in vmlinux, like
  init/version-timestamp.o and .vmlinux.export.o, both of which contain
  _sub_I_00099_0 functions.  As a result, the returns in these functions
  are not annotated, and the panic occurs when we call one of them in
  do_ctors and it uses the default return thunk.

  This difference can be seen by counting the number of these functions in the object files:
  $ objdump -d vmlinux.o|grep -c "<_sub_I_00099_0>:"
  2601
  $ objdump -d vmlinux|grep -c "<_sub_I_00099_0>:"
  2603

  If these functions are only run during kernel boot, there is no
  speculation concern."

Fix it by disabling KCSAN on version-timestamp.o and .vmlinux.export.o
so the extra functions don't get generated.  KASAN and GCOV are already
disabled for those files.

  [ bp: Massage commit message. ]

Closes: https://lore.kernel.org/lkml/20231016214810.GA3942238@dev-arch.thelio-3990X/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20231017165946.v4i2d4exyqwqq3bx@treble
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Makefile            | 1 +
 scripts/Makefile.vmlinux | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/Makefile b/init/Makefile
index ec557ada3c12e..cbac576c57d63 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
 KASAN_SANITIZE_version-timestamp.o := n
+KCSAN_SANITIZE_version-timestamp.o := n
 GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 3cd6ca15f390d..c9f3e03124d7f 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -19,6 +19,7 @@ quiet_cmd_cc_o_c = CC      $@
 
 ifdef CONFIG_MODULES
 KASAN_SANITIZE_.vmlinux.export.o := n
+KCSAN_SANITIZE_.vmlinux.export.o := n
 GCOV_PROFILE_.vmlinux.export.o := n
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
-- 
2.42.0

