Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270E7CCA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjJQRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7190;
        Tue, 17 Oct 2023 10:52:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:52:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697565148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QO7THutm9DbzDFqvBo8CeUszTWk5DcsXoee7Ok6T8A=;
        b=oPfwVabj4mW8EPgc5AFNhLZFbW0ejqgqBMimVX7IJc56hO1syU0gQrIgpGGhhHHqBCeDUp
        3cTNVxAzWyXbnuWF7RWuEYf9wj38rVTLio4mVKuPyF5Iog+ddyYbplcrrsVeBxqUYfDgnQ
        b+dMu7jnaH4E408vOwF2zD+TjvZrJ9borL2b6xcM7SB0W2uPlMPJFjW0Lhu/5mT2p6QihK
        Tbukq3QF/+AgphxyQZX8gWEI8/LqCtg2RLIM6QqnA281cgUAu9SCiP+zmGgObochO/dlpx
        yCXTaJ8yacQMaz9ANA2kUwYwY4cY7zzwccXkyqFiIj6Vxa+J3lk6D1AKlvZh8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697565148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QO7THutm9DbzDFqvBo8CeUszTWk5DcsXoee7Ok6T8A=;
        b=Y/BqD6PeQzzmg4hdzlsMQ+V3wbWrXeoNcMwBQsMYiTInE/hpKu49yAZLIeXe3qLo13q+Hk
        HUgd6aA42rG7UJCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/retpoline: Make sure there are no unconverted
 return thunks due to KCSAN
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017165946.v4i2d4exyqwqq3bx@treble>
References: <20231017165946.v4i2d4exyqwqq3bx@treble>
MIME-Version: 1.0
Message-ID: <169756514789.3135.9006141912388432463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     28860182b7d88e5be76f332c34377288ad08e87a
Gitweb:        https://git.kernel.org/tip/28860182b7d88e5be76f332c34377288ad08e87a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 17 Oct 2023 09:59:46 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 19:46:04 +02:00

x86/retpoline: Make sure there are no unconverted return thunks due to KCSAN

Enabling CONFIG_KCSAN causes the undefined opcode exception diagnostic
added by

  91174087dcc7 ("x86/retpoline: Ensure default return thunk isn't used at runtime")

which is supposed to catch unconverted, default return thunks, to fire.
The resulting panic is triggered by the UD2 instruction which gets
patched into __x86_return_thunk() when alternatives are applied.  After
that point, the default return thunk should no longer be used.

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

Fixes: 91174087dcc7 ("x86/retpoline: Ensure default return thunk isn't used at runtime")
Closes: https://lore.kernel.org/lkml/20231016214810.GA3942238@dev-arch.thelio-3990X/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20231017165946.v4i2d4exyqwqq3bx@treble
---
 init/Makefile            | 1 +
 scripts/Makefile.vmlinux | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/Makefile b/init/Makefile
index ec557ad..cbac576 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
 KASAN_SANITIZE_version-timestamp.o := n
+KCSAN_SANITIZE_version-timestamp.o := n
 GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 3cd6ca1..c9f3e03 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -19,6 +19,7 @@ quiet_cmd_cc_o_c = CC      $@
 
 ifdef CONFIG_MODULES
 KASAN_SANITIZE_.vmlinux.export.o := n
+KCSAN_SANITIZE_.vmlinux.export.o := n
 GCOV_PROFILE_.vmlinux.export.o := n
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
