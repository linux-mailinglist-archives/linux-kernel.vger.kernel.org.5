Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D67753696
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjGNJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjGNJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:45 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779435A2;
        Fri, 14 Jul 2023 02:31:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DDFCB5BC90;
        Fri, 14 Jul 2023 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326101;
        bh=pmERp6GwnOCWkgphnzptIlYb6DLdsFhpRouByq625cQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=kdLKIFgKGIwIntnz0AYgYdJvrgRLnnaI9MlYtqgh04f6DRCdyEJsf1wCQz/bICx4h
         Qu4xtfwtlzbagPh3ny4EsL9dxxSnfv+odIkxV5lscrKYPAe64NHpifx3W+U6dxLi/G
         Y6Nf0R3QOG2AJzHVEDQrrYB2I44moYV9sGHdVr9SPiJmfeJHwO7nJfPZvQGwEU/GRw
         xFmwpIZbCmFnjfQP8D2EA1pMZVkNmfCfJJK7WILd4XjK51yJSynQKWMOqPwseqwtDg
         G7pIumuQWNqHZQm0ZE5G2V98/nyldQKujWMnfE011Uau369ialqAGfMq8vU9oS9Kwf
         pGlz20dcsxNmw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:14:01 +0900
Subject: [PATCH RFC 09/11] rust: init: Update documentation for new mutex
 init style
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-9-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
In-Reply-To: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=2511;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=pmERp6GwnOCWkgphnzptIlYb6DLdsFhpRouByq625cQ=;
 b=SSD6fmaYAIs7/HNgGcRACQ89lpuCPIOoeaRkkZ2UkBP8Q1hptBMoz/GGwxRAszksq/cVul+Uq
 V3ShxAHSYKjA01dNJeNpjtApErQmrziR42b2PVrJ58GJ9xhMTUqfHrU
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have classless Mutex creation, update the docs to reflect
the new API.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/init.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b4332a4ec1f4..f190bbd0bab1 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -36,7 +36,7 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
-//! use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! use kernel::{prelude::*, sync::Mutex};
 //! # use core::pin::Pin;
 //! #[pin_data]
 //! struct Foo {
@@ -46,7 +46,7 @@
 //! }
 //!
 //! let foo = pin_init!(Foo {
-//!     a <- new_mutex!(42, "Foo::a"),
+//!     a <- Mutex::new_named(42, "Foo::a"),
 //!     b: 24,
 //! });
 //! ```
@@ -56,7 +56,7 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
-//! # use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! # use kernel::{prelude::*, sync::Mutex};
 //! # use core::pin::Pin;
 //! # #[pin_data]
 //! # struct Foo {
@@ -65,7 +65,7 @@
 //! #     b: u32,
 //! # }
 //! # let foo = pin_init!(Foo {
-//! #     a <- new_mutex!(42, "Foo::a"),
+//! #     a <- Mutex::new_named(42, "Foo::a"),
 //! #     b: 24,
 //! # });
 //! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo);
@@ -98,7 +98,7 @@
 //! impl DriverData {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             status <- new_mutex!(0, "DriverData::status"),
+//!             status <- Mutex::new_named(0, "DriverData::status"),
 //!             buffer: Box::init(kernel::init::zeroed())?,
 //!         })
 //!     }
@@ -242,7 +242,7 @@
 /// }
 ///
 /// stack_pin_init!(let foo = pin_init!(Foo {
-///     a <- new_mutex!(42),
+///     a <- Mutex::new(42),
 ///     b: Bar {
 ///         x: 64,
 ///     },
@@ -294,7 +294,7 @@ macro_rules! stack_pin_init {
 /// }
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
-///     a <- new_mutex!(42),
+///     a <- Mutex::new(42),
 ///     b: Box::try_new(Bar {
 ///         x: 64,
 ///     })?,
@@ -320,7 +320,7 @@ macro_rules! stack_pin_init {
 /// }
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
-///     a <- new_mutex!(42),
+///     a <- Mutex::new(42),
 ///     b: Box::try_new(Bar {
 ///         x: 64,
 ///     })?,

-- 
2.40.1

