Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1717F8ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKYMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:51:29 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D618C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1700916693; x=1701175893;
        bh=5cwlw0HuMDDbZgo/K1At3+rO2e/15vaUqRXcq/BERzM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=FS3ez3D8nDEmE+MRVnSjRM9nxTRr8v9kzeCCfjs7zZYj3YGzeyW4G2sPVZfmcU2hW
         CDdNb/nAxVfWR0uZ5lu30LwUdKIGM1ZzwAkldj471VMulFRmoTbdgN6qS2QSrYELEU
         QSfRsiwmR0lL4KrlQTAsZA0hZ5BXW4cWJFaRDPkD0E22LxezynuZqdKe2JJiD2huVr
         HOfNXZciWch/10Vm/Bu2ZLszU5hX6vGLGtAu8nBEomhkCbmT/PkPOVNrssLXl8I30g
         ++D2QaElRThHrNYAUL9TUrIYwdqTGST66IGS560BcK817bPYxTnr7Jw0KOdZO2/mYq
         2hX2k5YW7GDhw==
Date:   Sat, 25 Nov 2023 12:51:23 +0000
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Tejun Heo <tj@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Message-ID: <20231125125024.1235933-3-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous two patches made it possible to add `#[pin_data]` to
structs with default values to const generic paramters.
This patch makes `Work` use `#[pin_data]` and removes an invocation of
`pin_init_from_closure`. This function is intended as a low level manual
escape hatch, so it is better to rely on the `pin_init!` macro.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---

@Miguel: This patch is based on v6.7-rc2, because `workqueue.rs` has yet
         to land in rust-next. The first two patches also apply to
         rust-next.

 rust/kernel/workqueue.rs | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b67fb1ba168e..15bcfdb1ed33 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -334,8 +334,10 @@ pub trait WorkItem<const ID: u64 =3D 0> {
 /// Wraps the kernel's C `struct work_struct`.
 ///
 /// This is a helper type used to associate a `work_struct` with the [`Wor=
kItem`] that uses it.
+#[pin_data]
 #[repr(transparent)]
 pub struct Work<T: ?Sized, const ID: u64 =3D 0> {
+    #[pin]
     work: Opaque<bindings::work_struct>,
     _inner: PhantomData<T>,
 }
@@ -357,21 +359,22 @@ pub fn new(name: &'static CStr, key: &'static LockCla=
ssKey) -> impl PinInit<Self
     where
         T: WorkItem<ID>,
     {
-        // SAFETY: The `WorkItemPointer` implementation promises that `run=
` can be used as the work
-        // item function.
-        unsafe {
-            kernel::init::pin_init_from_closure(move |slot| {
-                let slot =3D Self::raw_get(slot);
-                bindings::init_work_with_key(
-                    slot,
-                    Some(T::Pointer::run),
-                    false,
-                    name.as_char_ptr(),
-                    key.as_ptr(),
-                );
-                Ok(())
-            })
-        }
+        pin_init!(Self {
+            work: Opaque::ffi_init(|slot| {
+                // SAFETY: The `WorkItemPointer` implementation promises t=
hat `run` can be used as
+                // the work item function.
+                unsafe {
+                    bindings::init_work_with_key(
+                        slot,
+                        Some(T::Pointer::run),
+                        false,
+                        name.as_char_ptr(),
+                        key.as_ptr(),
+                    )
+                }
+            }),
+            _inner: PhantomData,
+        })
     }
=20
     /// Get a pointer to the inner `work_struct`.
--=20
2.40.1


