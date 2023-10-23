Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33427D3E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjJWRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjJWRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:45:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA83B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:45:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B35EC433C8;
        Mon, 23 Oct 2023 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698083116;
        bh=x+AnEYyCYS2x5kfZRpQSdT2vBC5eC4hfcf5UNbmXbyI=;
        h=From:To:Cc:Subject:Date:From;
        b=sHJfJAgGebHbRUreMFoDdC8Zx8dwCATh8GgoqOwJdOdKi6QiUQNgPthgDj+l7nyvc
         anHJUj49RvwOHDH1ZNUq4L7n6uhCGow7ZrZ7z9YQrom2xQCdZcg8Hj10u69GREJvE0
         7nEAeAd30mv52yNgOCDf1i2373ZrpBAhzltQROTz2U4qG/0nIXfXfIdUuL3uQGwWrz
         tbVYFGsgJrrF8Mo7oOyay4W9phJbcAlGKYKccfiOMnMaozXelfFstGSLZcinX4+nbz
         JWfiF5wchZHfTlrOJBdvEtztk14mKxsIDTrb0ypSpz+Epg8ZTXnJNFGs86m1ZMqc8C
         3YPtcv8wiyirQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/4] x86/rust: support RETPOLINE
Date:   Mon, 23 Oct 2023 19:44:45 +0200
Message-ID: <20231023174449.251550-1-ojeda@kernel.org>
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

Support the `RETPOLINE` speculation mitigation by enabling the target
features that Clang does.

The existing target feature being enabled was a leftover from
our old `rust` branch, and it is not enough: the target feature
`retpoline-external-thunk` only implies `retpoline-indirect-calls`, but
not `retpoline-indirect-branches` (see LLVM's `X86.td`), unlike Clang's
flag of the same name `-mretpoline-external-thunk` which does imply both
(see Clang's `lib/Driver/ToolChains/Arch/X86.cpp`).

Without this, `objtool` would complain if enabled for individual object
files (like it is planned in the future), e.g.

    rust/core.o: warning: objtool:
    _R...escape_default+0x13: indirect jump found in RETPOLINE build

In addition, change the comment to note that LLVM is the one disabling
jump tables when retpoline is enabled, thus we do not need to use
`-Zno-jump-tables` for Rust here -- see commit c58f2166ab39 ("Introduce
the "retpoline" x86 mitigation technique ...") [1]:

    The goal is simple: avoid generating code which contains an indirect
    branch that could have its prediction poisoned by an attacker. In
    many cases, the compiler can simply use directed conditional
    branches and a small search tree. LLVM already has support for
    lowering switches in this way and the first step of this patch is
    to disable jump-table lowering of switches and introduce a pass to
    rewrite explicit indirectbr sequences into a switch over integers.

As well as a live example at [2].

Cc: Daniel Borkmann <daniel@iogearbox.net>
Link: https://github.com/llvm/llvm-project/commit/c58f2166ab3987f37cb0d7815b561bff5a20a69a [1]
Link: https://godbolt.org/z/esT8xnaxj [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 arch/x86/Makefile               | 2 +-
 scripts/generate_rust_target.rs | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5bfe5caaa444..3df7c7c81918 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -195,7 +195,7 @@ ifdef CONFIG_RETPOLINE
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
   # Additionally, avoid generating expensive indirect jumps which
   # are subject to retpolines for small number of switch cases.
-  # clang turns off jump table generation by default when under
+  # LLVM turns off jump table generation by default when under
   # retpoline builds, however, gcc does not for x86. This has
   # only been fixed starting from gcc stable version 8.4.0 and
   # onwards, but not for older ones. See gcc bug #86952.
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3c6cbe2b278d..163089ae13ba 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -156,7 +156,14 @@ fn main() {
         );
         let mut features = "-3dnow,-3dnowa,-mmx,+soft-float".to_string();
         if cfg.has("RETPOLINE") {
+            // The kernel uses `-mretpoline-external-thunk` (for Clang), which Clang maps to the
+            // target feature of the same name plus the other two target features in
+            // `clang/lib/Driver/ToolChains/Arch/X86.cpp`. These should be eventually enabled via
+            // `-Ctarget-feature` when `rustc` starts recognizing them (or via a new dedicated
+            // flag); see https://github.com/rust-lang/rust/issues/116852.
             features += ",+retpoline-external-thunk";
+            features += ",+retpoline-indirect-branches";
+            features += ",+retpoline-indirect-calls";
         }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");

base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
-- 
2.42.0

