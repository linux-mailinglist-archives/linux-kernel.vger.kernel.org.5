Return-Path: <linux-kernel+bounces-89414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617886F005
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32C1283E2F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460F566A;
	Sat,  2 Mar 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQLQzwDD"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133315AD9;
	Sat,  2 Mar 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709375408; cv=none; b=DeR4joN0By7YT4vyaGC3Ze6NbmH39+cThvKQl0gqx8iuJH6SNvLGGVsaXNz/KKejwxE/cbAL8DeE8UEDxq5Zc3iJmZmv7pwAF74A1uyT5RPkjC8Va2fOexQdQw+6pn45KJDUfTyKsYG5Y9NM+HYls/qOO3HZ2sIML5/Equ+30tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709375408; c=relaxed/simple;
	bh=oskbBhd1QuLrvDzAqj5rxcDFeE9FOLJHQL9jxXrcCmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlSBFXGBu/ysrsInkFRKr3j5Hm85HRGFpfWwrZdSe1CvmyDXvZ/YVntlfTipEkqI9mF/LiQGd61qokGnWQMYgohxjYxHsRZJWiSU5MPIldu/ncPMZdfNlcmFFhN8S+jtS0RIWcctKthyj/17mXmwWlq3wnzPolR3hfajn2uWqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQLQzwDD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so3094377a12.1;
        Sat, 02 Mar 2024 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709375404; x=1709980204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPyz20ce9KB0sHiKYK3GUodj8fA6Cyr+ENCVPRgV4y4=;
        b=jQLQzwDDQyIET+qKfhYdyemnXQ+xt7FdWzqRgRrF3iVApLJ8I2Cfw/4YRY7vxOnV/v
         jYBTh/KNB/GlHFsDHpyVMi8M3Y451RFal3PAsJJ1ZuhtMCr/V69bkH2B/P3OfRjKbunR
         hB97mOKCbDGn9bpuE0RvZ9VYdRAn/s4KDh+EdiFh4Eov+gnAiWnFj7uEkiU5AajEMWiR
         NymXkHUNrjdsETAmDwBivDHHC6SnhM3F3YnLqPn5PTuzv5BTliknQoqr+l7aa/pL8zoy
         jNDFO0z5QfbmcY0PNEFdSmyLvvAc9Mq8+vzZorhEg2tu66k881DQR0P6BDatV44F4Ywi
         hS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709375404; x=1709980204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPyz20ce9KB0sHiKYK3GUodj8fA6Cyr+ENCVPRgV4y4=;
        b=h++zAjt5YAMbMvxdDcYswDaENcZxE5UvH3LoLiBQawXnpr8o8WTbchkKFVkJtMdUdt
         LfRj9Bjy4kt2YkkHITaSVwyjyZXeQXwK4EfBvYmnQM9IIhknABHocwidWwnUs6RnYApX
         oA5wbO0u8v8gdN1vggMtsG49HGOZbph6iUaxvFU8KaibMDygtWPNgeQhW0k3lsI2mqsK
         JMIKXs9zPth7fI40ERmKYLehAKNg5P/nAVpBM7l+5pldnzwU2k6fyMFXjG37vk7vFOkJ
         Z1ww0jZXHBFcBJW3TycbHZYefSmlBCC/vqwS93fBqg9SDn1AYgUKo4FHc8BvGJdpkQso
         B1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmfmhVRGFVh/WvVS6PR9E3seQD09fmncrrAXLgXJL2Lr784V3tpNXODHASH25Ld8fM01tKWwkV0355Lb+mADYtYKpiKC611LII1KqJIfUN+DvkUWBP1THllX0PiEE20DPHfUcmkN61UAoS6Jk=
X-Gm-Message-State: AOJu0YxYcqRz/stEOT6hgD3hZF+LhvPrM0w/GnD2FhFKKafa0C0mRgZ7
	CJXH0BToMYkBs3BPxuqkn8xnqO50YYVjuAvl1rq4jTHpcVblWS4XqtC3csT5txEL3Nvayoql2wc
	26K+baDMxAFidoTv9/zfrW7vV7lmSgXQR3/byAQ==
X-Google-Smtp-Source: AGHT+IGsfWk1Di8Ec9x1m5F46yQlvDVONiRhXLFVAV64psd0Ulw5dSuRexqmM353cYb98JLxV6LK1VG4mJvrTxoBwSc=
X-Received: by 2002:a05:6402:176b:b0:566:9437:c89c with SMTP id
 da11-20020a056402176b00b005669437c89cmr3127286edb.22.1709375404346; Sat, 02
 Mar 2024 02:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-rust-locks-get-mut-v5-1-c5131dbbd3c4@gmail.com> <ZeJcTl0WuegYHe2h@boqun-archlinux>
In-Reply-To: <ZeJcTl0WuegYHe2h@boqun-archlinux>
From: Mathys Gasnier <mathys35.gasnier@gmail.com>
Date: Sat, 2 Mar 2024 11:29:53 +0100
Message-ID: <CAAZKF4ACqr7W+nwDJyaXLy9V2_zQyR8ATemBJFKWAcSw=UmbFA@mail.gmail.com>
Subject: Re: [PATCH v5] rust: locks: Add `get_mut` method to `Lock`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 1 mars 2024 =C3=A0 23:53, Boqun Feng <boqun.feng@gmail.com> a =C3=
=A9crit :
>
> On Fri, Mar 01, 2024 at 06:33:23PM +0100, Mathys-Gasnier via B4 Relay wro=
te:
> > From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> >
> > Having a mutable reference guarantees that no other threads have
> > access to the lock, so we can take advantage of that to grant callers
> > access to the protected data without the cost of acquiring and
> > releasing the locks. Since the lifetime of the data is tied to the
> > mutable reference, the borrow checker guarantees that the usage is safe=
.
> >
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> > ---
> > Changes in v5:
> > - Adding example
> > - Link to v4: https://lore.kernel.org/r/20240226-rust-locks-get-mut-v4-=
1-24abf57707a8@gmail.com
> >
> > Changes in v4:
> > - Improved documentation
> > - Link to v3: https://lore.kernel.org/r/20240222-rust-locks-get-mut-v3-=
1-d38a6f4bde3d@gmail.com
> >
> > Changes in v3:
> > - Changing the function to take a `Pin<&mut self>` instead of a `&mut s=
elf`
> > - Removed reviewed-by's since big changes were made. Please take anothe=
r
> >   look.
> > - Link to v2: https://lore.kernel.org/r/20240212-rust-locks-get-mut-v2-=
1-5ccd34c2b70b@gmail.com
> >
> > Changes in v2:
> > - Improved doc comment.
> > - Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-=
1-ce351fc3de47@gmail.com
> > ---
> >  rust/kernel/sync/lock.rs | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index f12a684bc957..345ca7be9d9f 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -7,7 +7,11 @@
> >
> >  use super::LockClassKey;
> >  use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaqu=
e, types::ScopeGuard};
> > -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d};
> > +use core::{
> > +    cell::UnsafeCell,
> > +    marker::{PhantomData, PhantomPinned},
> > +    pin::Pin,
> > +};
> >  use macros::pin_data;
> >
> >  pub mod mutex;
> > @@ -121,6 +125,38 @@ pub fn lock(&self) -> Guard<'_, T, B> {
> >          // SAFETY: The lock was just acquired.
> >          unsafe { Guard::new(self, state) }
> >      }
> > +
> > +    /// Gets the data contained in the lock.
> > +    ///
> > +    /// Having a mutable reference to the lock guarantees that no othe=
r threads have access to the
> > +    /// lock. And because `data` is not structurally pinned, it is saf=
e to get a mutable reference
> > +    /// to the lock content.
> > +    ///
> > +    /// # Example
> > +    ///
>
> Thanks! But please see below:
>
> > +    /// Using `get_mut` with a mutex.
> > +    ///
> > +    /// ```
>
> The example looks good, however, I was thinking about something like:
>
>     /// ```
>     /// use kernel::sync::{new_mutex, Mutex};
>     ///
>     /// let mut m =3D Box::pin_init(new_mutex!(None))?;
>     ///
>     /// assert_eq!(*(m.lock()), None);
>     ///
>     /// Mutex::get_mut(m.as_mut()).replace(42i32);
>     ///
>     /// assert_eq!(*(m.lock()), Some(42));
>     ///
>     /// # Ok::<(), Error>(())
>     /// ```
>
> because, this will also run something instead of just compiling a
> function.
>
> > +    /// use kernel::sync::Mutex;
> > +    ///
> > +    /// struct Example {
> > +    ///     a: u32,
> > +    ///     b: u32,
> > +    /// }
> > +    ///
> > +    /// fn example(m: Pin<&mut Mutex<Example>>) {
> > +    ///     // Calling from Mutex to avoid conflict with Pin::get_mut(=
).
> > +    ///     let mut data =3D Mutex::get_mut(m);
>
> The other thing I notice when I try to make the above example work is:
> `Pin` also has a `get_mut`[1] function, so seems we have to use
> `Mutex::get_mut` to invoke the correct function, I personally want the
> following just works:
>
>         m.as_mut().get_mut().replace(42i32);
>
> and looks to me the simplest way is to change the function's name (for
> example `get_data_mut`), and we can do:
>
>         m.as_mut().get_data_mut().replace(42i32);
>
> Thoughts?

I don't understand why `Pin::get_mut` creates a conflict as it should
be behind a where close forcing the type to be `UnPin`.
The name of the function was chosen to be the same as rust std
`Mutex::get_mut` [1],
but you are right renaming this to something else might be the easiest
way of fixing it

Regards,
Mathys Gasnier

[1]: https://doc.rust-lang.org/std/sync/struct.Mutex.html#method.get_mut

> Regards,
> Boqun
>
>
> [1]: https://doc.rust-lang.org/core/pin/struct.Pin.html#method.get_mut
>
>
>
> > +    ///     data.a +=3D 10;
> > +    ///     data.b +=3D 20;
> > +    /// }
> > +    /// ```
> > +    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
> > +        // SAFETY: The lock will only be used to get a reference to th=
e data, therefore self won't
> > +        // get moved.
> > +        let lock =3D unsafe { self.get_unchecked_mut() };
> > +        lock.data.get_mut()
> > +    }
> >  }
> >
> >  /// A lock guard.
> >
> > ---
> > base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
> > change-id: 20240118-rust-locks-get-mut-c42072101d7a
> >
> > Best regards,
> > --
> > Mathys-Gasnier <mathys35.gasnier@gmail.com>
> >
> >

Le ven. 1 mars 2024 =C3=A0 23:53, Boqun Feng <boqun.feng@gmail.com> a =C3=
=A9crit :
>
> On Fri, Mar 01, 2024 at 06:33:23PM +0100, Mathys-Gasnier via B4 Relay wro=
te:
> > From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> >
> > Having a mutable reference guarantees that no other threads have
> > access to the lock, so we can take advantage of that to grant callers
> > access to the protected data without the cost of acquiring and
> > releasing the locks. Since the lifetime of the data is tied to the
> > mutable reference, the borrow checker guarantees that the usage is safe=
.
> >
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> > ---
> > Changes in v5:
> > - Adding example
> > - Link to v4: https://lore.kernel.org/r/20240226-rust-locks-get-mut-v4-=
1-24abf57707a8@gmail.com
> >
> > Changes in v4:
> > - Improved documentation
> > - Link to v3: https://lore.kernel.org/r/20240222-rust-locks-get-mut-v3-=
1-d38a6f4bde3d@gmail.com
> >
> > Changes in v3:
> > - Changing the function to take a `Pin<&mut self>` instead of a `&mut s=
elf`
> > - Removed reviewed-by's since big changes were made. Please take anothe=
r
> >   look.
> > - Link to v2: https://lore.kernel.org/r/20240212-rust-locks-get-mut-v2-=
1-5ccd34c2b70b@gmail.com
> >
> > Changes in v2:
> > - Improved doc comment.
> > - Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-=
1-ce351fc3de47@gmail.com
> > ---
> >  rust/kernel/sync/lock.rs | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index f12a684bc957..345ca7be9d9f 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -7,7 +7,11 @@
> >
> >  use super::LockClassKey;
> >  use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaqu=
e, types::ScopeGuard};
> > -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d};
> > +use core::{
> > +    cell::UnsafeCell,
> > +    marker::{PhantomData, PhantomPinned},
> > +    pin::Pin,
> > +};
> >  use macros::pin_data;
> >
> >  pub mod mutex;
> > @@ -121,6 +125,38 @@ pub fn lock(&self) -> Guard<'_, T, B> {
> >          // SAFETY: The lock was just acquired.
> >          unsafe { Guard::new(self, state) }
> >      }
> > +
> > +    /// Gets the data contained in the lock.
> > +    ///
> > +    /// Having a mutable reference to the lock guarantees that no othe=
r threads have access to the
> > +    /// lock. And because `data` is not structurally pinned, it is saf=
e to get a mutable reference
> > +    /// to the lock content.
> > +    ///
> > +    /// # Example
> > +    ///
>
> Thanks! But please see below:
>
> > +    /// Using `get_mut` with a mutex.
> > +    ///
> > +    /// ```
>
> The example looks good, however, I was thinking about something like:
>
>     /// ```
>     /// use kernel::sync::{new_mutex, Mutex};
>     ///
>     /// let mut m =3D Box::pin_init(new_mutex!(None))?;
>     ///
>     /// assert_eq!(*(m.lock()), None);
>     ///
>     /// Mutex::get_mut(m.as_mut()).replace(42i32);
>     ///
>     /// assert_eq!(*(m.lock()), Some(42));
>     ///
>     /// # Ok::<(), Error>(())
>     /// ```
>
> because, this will also run something instead of just compiling a
> function.
>
> > +    /// use kernel::sync::Mutex;
> > +    ///
> > +    /// struct Example {
> > +    ///     a: u32,
> > +    ///     b: u32,
> > +    /// }
> > +    ///
> > +    /// fn example(m: Pin<&mut Mutex<Example>>) {
> > +    ///     // Calling from Mutex to avoid conflict with Pin::get_mut(=
).
> > +    ///     let mut data =3D Mutex::get_mut(m);
>
> The other thing I notice when I try to make the above example work is:
> `Pin` also has a `get_mut`[1] function, so seems we have to use
> `Mutex::get_mut` to invoke the correct function, I personally want the
> following just works:
>
>         m.as_mut().get_mut().replace(42i32);
>
> and looks to me the simplest way is to change the function's name (for
> example `get_data_mut`), and we can do:
>
>         m.as_mut().get_data_mut().replace(42i32);
>
> Thoughts?
>
> Regards,
> Boqun
>
>
> [1]: https://doc.rust-lang.org/core/pin/struct.Pin.html#method.get_mut
>
>
>
> > +    ///     data.a +=3D 10;
> > +    ///     data.b +=3D 20;
> > +    /// }
> > +    /// ```
> > +    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
> > +        // SAFETY: The lock will only be used to get a reference to th=
e data, therefore self won't
> > +        // get moved.
> > +        let lock =3D unsafe { self.get_unchecked_mut() };
> > +        lock.data.get_mut()
> > +    }
> >  }
> >
> >  /// A lock guard.
> >
> > ---
> > base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
> > change-id: 20240118-rust-locks-get-mut-c42072101d7a
> >
> > Best regards,
> > --
> > Mathys-Gasnier <mathys35.gasnier@gmail.com>
> >
> >

