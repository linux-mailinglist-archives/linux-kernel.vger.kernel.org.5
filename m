Return-Path: <linux-kernel+bounces-159212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC188B2AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502C3B21529
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B16155A43;
	Thu, 25 Apr 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gmH+hgnV"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FA153812;
	Thu, 25 Apr 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080898; cv=none; b=TwjicXxRGIHGalQm6zYL81FOKC4BQL298m/HJkxbKg+ixPGQbJenH4nvQ9a7gOMDXLT5pj7CFNG3YfcGCbljfjIKh2qqp6WGWQHYMP7hjmwP/KA8sL30c4iY9Gz4hk03lat/tQPiXPWO3JOliFdGV7WQdxBX53mORnrV7FQEduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080898; c=relaxed/simple;
	bh=YtT+9N11G/oagDxFwRs8nvK/R4iQrquRafZwkitYN7k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJS3WdUpT8vq4u4vIbCa9ZtELWnFW9HggqSnKxrEPt2+zcOIiWYYiVuxfezKb4WTwE4xGMWcvTh/CIgpfdO/LQ+DE8LykRNtciNOpPOkTKM8Idoo8zOmetN/6UP2tMXol0/xTfcN8e2siuatnu8wkD2p7V2Ovw7+T6uZqY3+ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gmH+hgnV; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714080887; x=1714340087;
	bh=UJd86kWm35t/O3VTlkvSGLGEC+zSkf49elPIO6KdbFY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gmH+hgnVw8qfTX37fl+0eCO6I/Bt3A4JMWO6ab7NggAjrSkyEDrWXQJrsFMbWnVm0
	 YG5IznlBMmt2imUFw033mRKJY9Pm1VMmNgEUwfNmvOlHdYkle0+bfY5p8fYiwg+gsO
	 nM/kUgoTuhQvi6s6aXDbs8WOZse0NU2XlEPjeZ0G7E5O35UIPXHJVBc98hhICRnqUG
	 uovJko74t5sHFjX/Rcor62H4rwyYkfR9ZD7GhWZxoC0iikOIWkqKn8/GzBKvZgUlNb
	 3gbBp/TI10NbdfMWpX4yttZ+Au0FvKc++6kFvKvPokn23FTxYdTNhKjSMvy1WndmoY
	 FuozYaKBrN8cw==
Date: Thu, 25 Apr 2024 21:34:44 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: init: add re-initialization functions
Message-ID: <20240425213419.3904105-2-benno.lossin@proton.me>
In-Reply-To: <20240425213419.3904105-1-benno.lossin@proton.me>
References: <20240425213419.3904105-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fd954416d514fda6cdb8e68aded583cacd674889
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sometimes it is necessary to split allocation and initialization into
two steps. One such situation is when reusing existing allocations
obtained via `Box::drop_contents`. See [1] for an example.
In order to support this use case add `re_[pin_]init` functions to the
pin-init API. These functions operate on already allocated smart
pointers that contain `MaybeUninit<T>`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f=
5bc592@proton.me/ [1]
---
 rust/kernel/init.rs    | 88 ++++++++++++++++++++++++++++++------------
 rust/kernel/prelude.rs |  2 +-
 2 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 9608f2bd2211..b37b23f07bf7 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1159,13 +1159,8 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Pin<Self>,
     where
         E: From<AllocError>,
     {
-        let mut this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
+        let this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
+        this.re_pin_init(init)
     }
=20
     #[inline]
@@ -1173,13 +1168,8 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) =
-> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
+        let this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
+        this.re_init(init)
     }
 }
=20
@@ -1189,13 +1179,8 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Pin<Self>,
     where
         E: From<AllocError>,
     {
-        let mut this =3D UniqueArc::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
+        let this =3D UniqueArc::new_uninit(flags)?;
+        this.re_pin_init(init)
     }
=20
     #[inline]
@@ -1203,13 +1188,68 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
 -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this =3D UniqueArc::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
+        let this =3D UniqueArc::new_uninit(flags)?;
+        this.re_init(init)
+    }
+}
+
+/// Smart pointer that can re-initialize its content.
+pub trait InPlaceReInit<T> {
+    /// The type `Self` turns into when re-initialized.
+    type Initialized;
+
+    /// Re-initializes `self` with the given initializer.
+    ///
+    /// Does not drop the current value and considers it as uninitialized =
memory.
+    fn re_init<E>(self, init: impl Init<T, E>) -> Result<Self::Initialized=
, E>;
+
+    /// Re-initializes `self` with the given initializer.
+    ///
+    /// Does not drop the current value and considers it as uninitialized =
memory.
+    fn re_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::=
Initialized>, E>;
+}
+
+impl<T> InPlaceReInit<T> for Box<MaybeUninit<T>> {
+    type Initialized =3D Box<T>;
+
+    fn re_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initial=
ized, E> {
+        let slot =3D self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
         // slot is valid.
         unsafe { init.__init(slot)? };
         // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
+        Ok(unsafe { self.assume_init() })
+    }
+
+    fn re_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Se=
lf::Initialized>, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() }.into())
+    }
+}
+
+impl<T> InPlaceReInit<T> for UniqueArc<MaybeUninit<T>> {
+    type Initialized =3D UniqueArc<T>;
+
+    fn re_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initial=
ized, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() })
+    }
+
+    fn re_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Se=
lf::Initialized>, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() }.into())
     }
 }
=20
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..078b2b1d84ae 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -37,6 +37,6 @@
=20
 pub use super::{str::CStr, ThisModule};
=20
-pub use super::init::{InPlaceInit, Init, PinInit};
+pub use super::init::{InPlaceInit, InPlaceReInit, Init, PinInit};
=20
 pub use super::current;
--=20
2.44.0



