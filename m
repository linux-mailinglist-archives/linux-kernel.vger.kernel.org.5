Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7677D3E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjJWRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjJWRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1AB0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:45:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754EBC433C8;
        Mon, 23 Oct 2023 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698083125;
        bh=X2EiXljEqLgjkMvgVksP7BUN5cbAO2JI6oZUqCn5eWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5sZlBXBs5Iog9qQoDZ2/bLkWFr3eeiiWVLVSZ+sI7fj7xIIRbHUoWbq2iHyPy76w
         wc88r56+X9avGXu+OMTWHjzXYfpfBL610QgzkF899uZdDPH7s7n1846Siq42LNgHNH
         vJ+SgFDeIwPuHFNF4crhAnR5vLxKHOehoGgUTLp6Ja1E7VJiFSt9/iLj5WBEFWolsw
         OUnXCYwblWnSwgnFRinkG5ce/hAaLYppdnsCtd+OQDe06609TMIIaLOC7MhP13nMhH
         dQFc2UqAd5c8HVXPZNRrL2nzk4IS30mWZuAOICUKr9QnFaCkWw4YU+IQ30qXUph4r9
         t5Sa6AK8jlnMQ==
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
        patches@lists.linux.dev
Subject: [PATCH 3/4] x86/rust: depend on !RETHUNK
Date:   Mon, 23 Oct 2023 19:44:47 +0200
Message-ID: <20231023174449.251550-3-ojeda@kernel.org>
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

The Rust compiler does not support the equivalent of
`-mfunction-return=thunk-extern` yet [1]. Thus, currently, `objtool`
warns about it, e.g.:

    samples/rust/rust_print.o: warning: objtool: _R...init+0xa5c:
    'naked' return found in RETHUNK build

The support in `rustc` for `-Zfunction-return` has been submitted and
is being reviewed [2]. It adds the needed LLVM function attributes and,
with it, I got a RETHUNK kernel build with Rust enabled that does not
print the `objtool` related warnings, boots in QEMU and can load a kernel
loadable module.

In any case, until proper/complete support is added to `rustc`, make it
a hard restriction until the mitigation is in place.

This may have an impact for developers that may not need/care about the
mitigation in the Rust side (e.g. Ubuntu offers Rust as a "technology
preview" [3]), but given we are getting closer to having the first actual
in-tree Rust kernel users, it seems like the right time to disallow
it. This should also avoid confusion [4].

Link: https://github.com/rust-lang/rust/issues/116853 [1]
Link: https://github.com/rust-lang/rust/pull/116892 [2]
Link: https://lore.kernel.org/rust-for-linux/ZSQXqX2%2Flhf5ICZP@gpd/ [3]
Link: https://lore.kernel.org/rust-for-linux/CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com/ [4]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..9452b4102b99 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1889,6 +1889,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !RETHUNK
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
-- 
2.42.0

