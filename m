Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B6767D7A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjG2JKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjG2JKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:10:31 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29D49DB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:10:03 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=oeiw4vx7yna6jha6bjbqylksbe.protonmail; t=1690621802; x=1690881002;
        bh=pQx6ihcSvIvQbgV/BbP1F61LnlGypfrLDVQD2l3NnSY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DQjd3O6krWMb6w6+BBC7iqizJ08O0WXNNmNV7ZfY08l4HV8f5wScaDrARRhWDaXWm
         h/QFvAkYLcmRrc+FCNtwdwvxtg+uzZiFcXPxlktpHnK6eTiVpiGQbAvZyBRUy17lW0
         ankNpi1N/xj4O/sdOeQHt3qQxHtWqKHaBCH6ayYy142AeHbnU5VqdO4fNjWfmoog4p
         KMFFwz9n0D8IhmPN5grUjre/ZkAS8dpzcfcErS0M2leEm2T2bGuXnk5NnsZLdyZysC
         exFdp21cSBNvFqq4JKGaapbuGq8OzcnZxgZW4d3EHFU8wq1hnCjw7vuOIAnTLxqNJ3
         jHK6JTuG3Ehdg==
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
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v3 05/13] rust: init: wrap type checking struct initializers in a closure
Message-ID: <20230729090838.225225-6-benno.lossin@proton.me>
In-Reply-To: <20230729090838.225225-1-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
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


