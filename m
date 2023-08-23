Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB841785CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjHWQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjHWQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE9184
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B358B64C73
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBB7C433C9;
        Wed, 23 Aug 2023 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692806582;
        bh=B0H4dHXC38o+d2MdOwkbIjWWV7KKjINlqQcF0ZM4v/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaJBfxIuHDGUQfR82jwImtDeEYwRnuK598N3YnBro4YqghUOgGDC0vQYXNDkE/vwZ
         EtsEENYUkTsXjXCwDiPjR3e2Z/vw9fGcxwnTOJ+KxxjC7O6dnXcgwGD9VHnJaMQDSB
         nBnyFwRrYBM7sis6zcmoS8qpK5V+3Dvw9Mi7JIfxxDffZJlJPaDbXSrcIT+7WtGhYJ
         rPzO6ViFue+yyoRNYMUZp6xMlSKCfll2IXEWSzR7W8iCqFGu043C1cY8pXoBEo0WYK
         SnuA8Y9Sz697KGy/MLYIZUSOCrQL8nPNW6K39l8dzUw51GPlHwRSwh0p9jNRdUoylB
         6dDmv+iYdAw8g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 1/2] rust: arc: add explicit `drop()` around `Box::from_raw()`
Date:   Wed, 23 Aug 2023 18:02:42 +0200
Message-ID: <20230823160244.188033-2-ojeda@kernel.org>
In-Reply-To: <20230823160244.188033-1-ojeda@kernel.org>
References: <20230823160244.188033-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`Box::from_raw()` is `#[must_use]`, which means the result cannot
go unused.

In Rust 1.71.0, this was not detected because the block expression
swallows the diagnostic [1]:

    unsafe { Box::from_raw(self.ptr.as_ptr()) };

It would have been detected, however, if the line had been instead:

    unsafe { Box::from_raw(self.ptr.as_ptr()); }

i.e. the semicolon being inside the `unsafe` block, rather than
outside.

In Rust 1.72.0, the compiler started warning about this [2], so
without this patch we will get:

        error: unused return value of `alloc::boxed::Box::<T>::from_raw` that must be used
        --> rust/kernel/sync/arc.rs:302:22
        |
    302 |             unsafe { Box::from_raw(self.ptr.as_ptr()) };
        |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = note: call `drop(Box::from_raw(ptr))` if you intend to drop the `Box`
        = note: `-D unused-must-use` implied by `-D warnings`
    help: use `let _ = ...` to ignore the resulting value
        |
    302 |             unsafe { let _ = Box::from_raw(self.ptr.as_ptr()); };
        |                      +++++++                                 +

Thus add an add an explicit `drop()` as the `#[must_use]`'s
annotation suggests (instead of the more general help line).

Link: https://github.com/rust-lang/rust/issues/104253 [1]
Link: https://github.com/rust-lang/rust/pull/112529 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/sync/arc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 172f563976a9..4c14d540a581 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -299,7 +299,7 @@ fn drop(&mut self) {
             // The count reached zero, we must free the memory.
             //
             // SAFETY: The pointer was initialised from the result of `Box::leak`.
-            unsafe { Box::from_raw(self.ptr.as_ptr()) };
+            unsafe { drop(Box::from_raw(self.ptr.as_ptr())) };
         }
     }
 }
-- 
2.42.0

