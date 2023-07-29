Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105E768269
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjG2WEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 18:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG2WEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 18:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF392134
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 15:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D9E60B29
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246FFC433CA;
        Sat, 29 Jul 2023 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690668250;
        bh=hZIkmpMvMxGLbBwQwkx5l+uBVt7Fp7DYNU7L1mha3QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM7ATPjPuurBRStKBoIymFY3w6eFeeTB5IInyxUv0ZogB4Y16tbR3278qTAc1QJhw
         bzWHFRPU0bqXx27Q5ETkO8KFGA5PtbJDbJPoj3IqxPdW+ULsZbH332/QvBDvx+yjfP
         G/bXrQvyiye8L9gJVgcCoKFOCBnNZ0o5hjOujAfeO0w+VjK+/FxRcWL/7uye/PEKsX
         zp4kp7+Uik8bDBmVR2sh4yliuaeT5+40hNy+0qYRtvkRCZDsiZgyLDDT1R5b5MTwbo
         bERGnYDKFnSvK1GXbROapjYqTGXBVF6RH9By6tJ8adUCh6uxa4k7kxeG+4GInsOu8I
         0bbB6xOwiYjPg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 2/2] rust: enable `no_mangle_with_rust_abi` Clippy lint
Date:   Sun, 30 Jul 2023 00:03:17 +0200
Message-ID: <20230729220317.416771-2-ojeda@kernel.org>
In-Reply-To: <20230729220317.416771-1-ojeda@kernel.org>
References: <20230729220317.416771-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduced in Rust 1.69.0 [1], this lint prevents forgetting to set
the C ABI when using `#[no_mangle]` (or thinking it is implied).

For instance, it would have prevented the issue [2] fixed by commit
c682e4c37d2b ("rust: kernel: Mark rust_fmt_argument as extern "C"").

    error: `#[no_mangle]` set on a function with the default (`Rust`) ABI
      --> rust/kernel/print.rs:21:1
       |
    21 | / unsafe fn rust_fmt_argument(
    22 | |     buf: *mut c_char,
    23 | |     end: *mut c_char,
    24 | |     ptr: *const c_void,
    25 | | ) -> *mut c_char {
       | |________________^
       |
       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#no_mangle_with_rust_abi
       = note: requested on the command line with `-D clippy::no-mangle-with-rust-abi`
    help: set an ABI
       |
    21 | unsafe extern "C" fn rust_fmt_argument(
       |        ++++++++++
    help: or explicitly set the default
       |
    21 | unsafe extern "Rust" fn rust_fmt_argument(
       |        +++++++++++++

Thus enable it.

In rare cases, we may need to use the Rust ABI even with `#[no_mangle]`
(e.g. one case, before 1.71.0, would have been the `__rust_*`
functions). In those cases, we would need to `#[allow(...)]` the lint,
since using `extern "Rust"` explicitly (as the compiler suggests)
currently gets overwritten by `rustfmt` [3].

Link: https://github.com/rust-lang/rust-clippy/issues/10347 [1]
Link: https://github.com/Rust-for-Linux/linux/pull/967 [2]
Link: https://github.com/rust-lang/rustfmt/issues/5701 [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 658ec2b8aa74..93bf3eca3ead 100644
--- a/Makefile
+++ b/Makefile
@@ -467,6 +467,7 @@ export rust_common_flags := --edition=2021 \
 			    -Dclippy::let_unit_value -Dclippy::mut_mut \
 			    -Dclippy::needless_bitwise_bool \
 			    -Dclippy::needless_continue \
+			    -Dclippy::no_mangle_with_rust_abi \
 			    -Wclippy::dbg_macro
 
 KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
-- 
2.41.0

