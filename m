Return-Path: <linux-kernel+bounces-97945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0134877210
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDFC1F21600
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E045940;
	Sat,  9 Mar 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TmbVPr7Q"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952414503E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709999726; cv=none; b=G+fBj4uuN8olYxIE2N64PD92ylU1Htpqb0ghdJtTND4SN7nQCaWCYFIIxhGssPlhuPSjkoO2XkuLs+NkwuGs++VxllqnSfG05vVhuXa/eX7/IEvjSAE+gsfYPyxPp/O+V0T8RQLQI/QMwE2PAW9UGWwnOF3bczunzv+Nsp0xrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709999726; c=relaxed/simple;
	bh=d6ujX5QMz1tmNKIt/U0yYWjhSRY/osTOtHSTIF8XBXY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBQhbBJqiypvWghi7avp01hLpIGF0epqURTrzurc7RSstZ+CESA9YPYlti9UGLBzLmcCyjefzy3QPa15FkLfN3ljEBE7cMmeBPmn4/xm4oiPbiU6y3NHIMna+24r0cJOOK7cdswjcIxihwEQJAk5JoRqKqRxZdOnMLbJ+cZRkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TmbVPr7Q; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709999717; x=1710258917;
	bh=/tByVpPOQqxliq0F4vWuV5WVPpv3O6Lr3QVczYQPpwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TmbVPr7QReeFYM1W8tqBdf0dUBVpQYXsZpnJwNQkoaD6ipTtjqCT2c9t7Xrhg29Bv
	 ulf2b5GTTXcI51YeklSyz0mNa9lSw7es2yPXTGrMhN0Ik0l60CDnnomLUrRP/wqCeS
	 DU4Db0UsmK4TbWgNNL/fzJdSGuXOZ3sjEmQVk6rlZRxwhG7z4nrD/QjfAOciz+A+U/
	 km++O759mdJZXYH7Ilx5J9EfIV5WYyo+xEhQsPULNDUNSzni1TkkPcXa644nBjanMO
	 drkeXgQuD2raIJHjkCRnBYLa6nfGsyUO+JPVz2YlE1krkDoV+aPK7AIzqJQKZxyRGS
	 GXFQ14h2w4lqw==
Date: Sat, 09 Mar 2024 15:54:52 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Message-ID: <20240309155243.482334-3-benno.lossin@proton.me>
In-Reply-To: <20240309155243.482334-1-benno.lossin@proton.me>
References: <20240309155243.482334-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The previous two patches made it possible to add `#[pin_data]` on
structs with default generic parameter values.
This patch makes `Work` use `#[pin_data]` and removes an invocation of
`pin_init_from_closure`. This function is intended as a low level manual
escape hatch, so it is better to rely on the safe `pin_init!` macro.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
---
v2 -> v3:
no changes

v1 -> v2:
- improve commit message wording
- change `:` to `<-` in `pin_init!` invocation

 rust/kernel/workqueue.rs | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 544f0c51f1b7..ab4d64fbdb78 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -342,8 +342,10 @@ pub trait WorkItem<const ID: u64 =3D 0> {
 /// This is a helper type used to associate a `work_struct` with the [`Wor=
kItem`] that uses it.
 ///
 /// [`run`]: WorkItemPointer::run
+#[pin_data]
 #[repr(transparent)]
 pub struct Work<T: ?Sized, const ID: u64 =3D 0> {
+    #[pin]
     work: Opaque<bindings::work_struct>,
     _inner: PhantomData<T>,
 }
@@ -365,21 +367,22 @@ pub fn new(name: &'static CStr, key: &'static LockCla=
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
+            work <- Opaque::ffi_init(|slot| {
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
2.42.0



