Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAB75980D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGSOU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGSOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:20:53 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2651993;
        Wed, 19 Jul 2023 07:20:44 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689776443; x=1690035643;
        bh=DsEfSlKtIhyTB7NkpS5sssxEHNqI+QqAvnsnKYAwLtk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bC5l9XnAlrfdaq2S5N8x5zKK+FHAetJ5Qoe3fWVLWY0MN12Z6bYFJOnh7qF1QhQ8A
         7Y8++xHkylHtv06khzindeO9YELBrZiRYIJwXZ5JgQODdCPOSBuf0A5hYME84tJ/0X
         uWkzgAF9ipSb5S4EmVjrU/M4Di2j4hoWBmmgMubB1zQrWzquDMRDMhdfkimwq/4dTB
         paPXsBuQL1rrWJr3ePiYKVTpH3bOH6nptIry5TmBDyQu0iSjSl/sPfB4HYBK2Xiq8d
         5yCe/yrjOAtNt21S3EGzfW99kSq+/Jp9s4AJb+XEbiVZyHVrburFMl321d96JmnDXB
         4hzuS60K6qpeA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] rust: init: wrap type checking struct initializers in a closure
Message-ID: <20230719141918.543938-5-benno.lossin@proton.me>
In-Reply-To: <20230719141918.543938-1-benno.lossin@proton.me>
References: <20230719141918.543938-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of the init macros there is a `if false` statement
that type checks the initializer to ensure every field is initialized.
Since the next patch has a stack variable to store the struct, the
function might allocate too much memory on debug builds. Putting the
struct into a closure that is never executed ensures that even in debug
builds no stack overflow error is caused. In release builds this was not
a problem since the code was optimized away due to the `if false`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v1 -> v2:
* do not call the created closure

 rust/kernel/init/macros.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index c5f977f52d0c..160b95fc03c9 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1038,14 +1038,14 @@ macro_rules! __init_internal {
                     // once, this struct initializer will still be type-ch=
ecked and complain with a
                     // very natural error message if a field is forgotten/=
mentioned more than once.
                     #[allow(unreachable_code, clippy::diverging_sub_expres=
sion)]
-                    if false {
+                    let _ =3D || {
                         $crate::__init_internal!(make_initializer:
                             @slot(slot),
                             @type_name($t),
                             @munch_fields($($fields)*,),
                             @acc(),
                         );
-                    }
+                    };
                 }
                 Ok(__InitOk)
             }
@@ -1166,8 +1166,8 @@ macro_rules! __init_internal {
         @acc($($acc:tt)*),
     ) =3D> {
         // Endpoint, nothing more to munch, create the initializer.
-        // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
-        // get the correct type inference here:
+        // Since we are in the closure that is never called, this will nev=
er get executed.
+        // We abuse `slot` to get the correct type inference here:
         unsafe {
             ::core::ptr::write($slot, $t {
                 $($acc)*
--=20
2.41.0


