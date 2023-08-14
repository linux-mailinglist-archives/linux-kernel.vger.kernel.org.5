Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BB77B491
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjHNIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjHNIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:47:06 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702010C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:47:05 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:46:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=6tf7jz7u4rgs3bvq3n5hlsdnem.protonmail; t=1692002824; x=1692262024;
        bh=+y/4hwjE9xTPBuUzHSo6g+e55bg8L+V4bqZtkGtraCM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VBx8s9iEtWxkKgrYspZcruM+PDspV9IubBxy3NR9+IXX26WLTxFQ2GyudmdxCRqP6
         gQjLu1hc6mE244ph3QYqkgfBY+rC00A1VjSkfQ0gSOF0a1q5FtrRl1FRDsVYVb2QRI
         79cryyyphfK4zDylndAV50fVdxY6XjACv9AU3B5puoVz7kMyZBITZOBIUuocYrR6px
         CLJ3JO6HMpcGxlmmV09Uo0+vB5uRk1AIqz1WTS/6eGPiKCwZEmq+hMBf24CKTznQ/I
         gpcTdxefkHMfli3MCLsN9b8QkFtF9Ng+B1WRAFnWD+SBQbsqxGqUMD3orQbHwAFSJq
         W60adFkHjvzow==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 05/13] rust: init: wrap type checking struct initializers in a closure
Message-ID: <20230814084602.25699-6-benno.lossin@proton.me>
In-Reply-To: <20230814084602.25699-1-benno.lossin@proton.me>
References: <20230814084602.25699-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- added Reviewed-by from Gary.

v2 -> v3:
- added Reviewed-by's from Martin and Alice.

v1 -> v2:
- do not call the created closure.

 rust/kernel/init/macros.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 454f31b8c614..2bad086cda0a 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1040,14 +1040,14 @@ macro_rules! __init_internal {
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
@@ -1168,8 +1168,8 @@ macro_rules! __init_internal {
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


