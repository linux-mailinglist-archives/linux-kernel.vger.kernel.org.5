Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3B7D3E30
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJWRqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjJWRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:45:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA010C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:45:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D5AC433C9;
        Mon, 23 Oct 2023 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698083130;
        bh=OTtEvmCKMm7ojlLCYfNOXX7WV2Av9drz4oNtw+8PMlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBorsQHMmnAu6kmE5ZXnl/NeCJl1/ssPb1p3rjG7224RgRmP4RRgELONe6e9SKZ3y
         aEg8OPmzcybUoSAXG5o0vw80EQ0ebbRjPyZpqQw9CzDZib222bjnXMvXNf7j48uY/e
         6YmKBSJscijZqMPNdjeDAnR9TFLxbdGYFZOM2XsY4eUNwbdZhB9UHr+K33sDiePSYe
         IWM/f80LtwdlHNLMMpz9Wnn0QxeVS+78vi64HdOdEvKEgifB7PNOz/n1LGpjgalS5m
         B0Wxb5Xvb9NNAFf7N7P6izCO4JbGedwTX3467RVNYqwyBOtEWJtAqN13b0s7o9X/HZ
         QtY8nfCBWF+lA==
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
        patches@lists.linux.dev, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 4/4] x86/rust: support RETHUNK
Date:   Mon, 23 Oct 2023 19:44:48 +0200
Message-ID: <20231023174449.251550-4-ojeda@kernel.org>
In-Reply-To: <20231023174449.251550-1-ojeda@kernel.org>
References: <20231023174449.251550-1-ojeda@kernel.org>
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

When support for `-Zfunction-return` lands in Rust [1], this patch may
be used to enable RETHUNK support on top of the previous patch.

Link: https://github.com/rust-lang/rust/pull/116892 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Note that this patch is not meant to be applied now, it is only here to
show what will be needed to drop the depends on from the previous patch.

 arch/x86/Makefile | 5 +++++
 init/Kconfig      | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3df7c7c81918..818fdb1a92c5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,11 +24,15 @@ RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)

 ifdef CONFIG_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
+RETHUNK_RUSTFLAGS	:= -Zfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
+RETPOLINE_RUSTFLAGS	+= $(RETHUNK_RUSTFLAGS)
 endif

 export RETHUNK_CFLAGS
+export RETHUNK_RUSTFLAGS
 export RETPOLINE_CFLAGS
+export RETPOLINE_RUSTFLAGS
 export RETPOLINE_VDSO_CFLAGS

 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
@@ -193,6 +197,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
+  KBUILD_RUSTFLAGS += $(RETPOLINE_RUSTFLAGS)
   # Additionally, avoid generating expensive indirect jumps which
   # are subject to retpolines for small number of switch cases.
   # LLVM turns off jump table generation by default when under
diff --git a/init/Kconfig b/init/Kconfig
index 9452b4102b99..6d35728b94b2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1889,7 +1889,6 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
-	depends on !RETHUNK
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
--
2.42.0
