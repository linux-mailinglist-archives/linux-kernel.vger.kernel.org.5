Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681F7CC952
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJQQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJQQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:59:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854AAB;
        Tue, 17 Oct 2023 09:59:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B373C433C7;
        Tue, 17 Oct 2023 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697561988;
        bh=geQXKRC2Jvb636FBZET9oMZ/p3D7F0Z9S0YyA2XEv1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nc9rTl4PB8xxDCMVkyK3df1khEKShyJ57b6NDmta0G2eJU2ZvclP44qA/XiusW0S5
         D97OnJZLlKyg2zbwoGWPg/rWGjKiNb1x1F9oe2tXplNWGfr4dPS7Q5573kYwlt5er8
         B/2QMqCcZFyNoFMP2NVxLLJBEPLbasPIapHFS3r/2Y6mlFhOGrgVgbOb2yjqfnixnE
         T/YFYT+970Fl3Yk//lRN4LSeVvjJUtrtQ8U+VMJfvbfUQ4rv7kk6sP2dZMn1Uoi2KS
         AtX9jeMJCLQGrQds3DPLPzAeOgk8FbMvPkvnif0xghx5KCMhapfwIhjffbMKd38kEi
         jiQdkUSdfBRtA==
Date:   Tue, 17 Oct 2023 09:59:46 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: [PATCH] x86/srso: Fix panic in return thunk during boot
Message-ID: <20231017165946.v4i2d4exyqwqq3bx@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X>
 <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X>
 <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231017052834.v53regh66hspv45n@treble>
 <20231017153222.GA707258@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017153222.GA707258@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_KCSAN causes a panic during boot due to an "invalid
opcode" in __x86_return_thunk():

  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00316-g91174087dcc7 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__x86_return_thunk+0x0/0x10
  Code: e8 01 00 00 00 cc e8 01 00 00 00 cc 48 81 c4 80 00 00 00 65 48 c7 04 25 d0 ac 02 00 ff ff ff ff c3 cc 0f 1f 84 00 00 00 00 00 <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc e9 db 8c 8e fe 0f
  RSP: 0018:ffffaef1c0013ed0 EFLAGS: 00010246
  RAX: ffffffffa0e80eb0 RBX: ffffffffa0f05240 RCX: 0001ffffffffffff
  RDX: 0000000000000551 RSI: ffffffffa0dcc64e RDI: ffffffffa0f05238
  RBP: ffff8f93c11708e0 R08: ffffffffa1387280 R09: 0000000000000000
  R10: 0000000000000282 R11: 0001ffffa0f05238 R12: 0000000000000002
  R13: 0000000000000282 R14: 0000000000000001 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff8f93df000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff8f93d6c01000 CR3: 0000000015c2e000 CR4: 0000000000350ef0

The panic is triggered by the UD2 instruction which gets patched into
__x86_return_thunk() when alternatives are applied.  After that point,
the default return thunk should no longer be used.

As David Kaplan describes, the issue is caused by a couple of
KCSAN-generated constructors which aren't processed by objtool:

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

Fixes: 91174087dcc7 ("x86/retpoline: Ensure default return thunk isn't used at runtime")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20231016214810.GA3942238@dev-arch.thelio-3990X/
Debugged-by: David Kaplan <David.Kaplan@amd.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 init/Makefile            | 1 +
 scripts/Makefile.vmlinux | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/Makefile b/init/Makefile
index ec557ada3c12..cbac576c57d6 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
 KASAN_SANITIZE_version-timestamp.o := n
+KCSAN_SANITIZE_version-timestamp.o := n
 GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 3cd6ca15f390..c9f3e03124d7 100644
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
2.41.0

