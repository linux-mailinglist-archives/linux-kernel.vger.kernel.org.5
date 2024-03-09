Return-Path: <linux-kernel+bounces-97893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5287713B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9EE281BB8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38393BBE4;
	Sat,  9 Mar 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UNM7Iip7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767739ADF;
	Sat,  9 Mar 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709989352; cv=none; b=Y04colxq9yRzSbqxjuiEz1s8al6dmvfaHQOXF4S4QbiPCKFE+t6Vd4DoTOk9pi6QUY/REX7s3uTDOkHZ07J06TuMCe/k/KV+CEABqM4E79gNAW+69zqqnb9XptlIeyjmyJbVXfLqTUU/c6AMyFUfbSV5aoEPqjqI/tfkCUNibJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709989352; c=relaxed/simple;
	bh=yJU5AhyChs/qGIIOFDlmSPkQN9x/hoS+kMrDVKSn+x8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXuUtnuN5mma7FaXsrSFYdFffyGl5m/LiN+LvOHTjqU6cBvayJDXMdnz1aujBPuosQFYy9CqJZZckP4r9um9ipMupE+vxeDmpsu/xEyVlfLhoIqcW7oNY5VIuee7SfYNQjtPBlL+SkWekyZeEJX6xPo2HFpw6bisv5Ab5vGFrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UNM7Iip7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709989348; x=1710248548;
	bh=dTvrg5FoLKiS/SP8wSIvA3SXIFzsUQxNxxJNt35wq14=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UNM7Iip7dqkGzZxIDVk1pRRvrY7t3YVpQJTFOVi5vRIzzXd2KnAFB+N5PtJFhl6Iq
	 wOXeQOAFsJ1mDxyWgghBYFiXdoM+R8s0fTmssSqCxMLLr/YijwZOBKG52+W4Q4jtFN
	 m68V/P6GgYLFmZ04ooOFNF2AaMrl/IKaK6l9kJLPlQs66ArRdrO38PARCgGy+UiXlT
	 0Qr5unTDcxmV6+9XNFSL0hBS7EqKEpKvMuWT1K1lg71nfLD0HIGJd6dmdf868hKC1Q
	 AXUgp22ceCXSCBQEVTHkDvIY3QsLveT2it5RYkRGJyFQpucst+d+yQoR2pwSZzklAt
	 5/fxXEA2EyxLA==
Date: Sat, 09 Mar 2024 13:02:07 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
Message-ID: <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me>
In-Reply-To: <20240228-arc-for-list-v2-2-ae93201426b4@google.com>
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com> <20240228-arc-for-list-v2-2-ae93201426b4@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/28/24 14:00, Alice Ryhl wrote:
> Decrement the refcount of an `Arc`, but handle the case where it hits
> zero by taking ownership of the now-unique `Arc`, instead of destroying
> and deallocating it.
>=20
> This is a dependency of the linked list that Rust Binder uses. The
> linked list uses this method as part of its `ListArc` abstraction.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/sync/arc.rs | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 53addb8876c2..df2dfe0de83c 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -290,6 +290,37 @@ pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
>       pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>           core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
>       }
> +
> +    /// Converts this [`Arc`] into a [`UniqueArc`], or destroys it if it=
 is not unique.
> +    ///
> +    /// When this destroys the `Arc`, it does so while properly avoiding=
 races. This means that
> +    /// this method will never call the destructor of the value.
> +    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
> +        // We will manually manage the refcount in this method, so we di=
sable the destructor.
> +        let me =3D ManuallyDrop::new(self);
> +        // SAFETY: We own a refcount, so the pointer is still valid.
> +        let refcount =3D unsafe { me.ptr.as_ref() }.refcount.get();
> +
> +        // SAFETY: If the refcount reaches a non-zero value, then we hav=
e destroyed this `Arc` and
> +        // will return without further touching the `Arc`. If the refcou=
nt reaches zero, then there
> +        // are no other arcs, and we can create a `UniqueArc`.

This comment is not explaining why it is safe to call
`refcount_dec_and_test` on `refcount`.
It dose however explain what you are going to do, so please keep it, but
not as a SAFETY comment.

> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcoun=
t) };
> +        if is_zero {
> +            // SAFETY: We have exclusive access to the arc, so we can pe=
rform unsynchronized
> +            // accesses to the refcount.
> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(=
1)) };
> +
> +            // SAFETY: We own one refcount, so we can create a `UniqueAr=
c`. It needs to be pinned,
> +            // since an `Arc` is pinned.

The `unsafe` block is only needed due to the `new_unchecked` call, which
you could avoid by using `.into()`. The `SAFETY` should also be an
`INVARIANT` comment instead.

--=20
Cheers,
Benno

> +            unsafe {
> +                Some(Pin::new_unchecked(UniqueArc {
> +                    inner: Arc::from_inner(me.ptr),
> +                }))
> +            }
> +        } else {
> +            None
> +        }
> +    }
>   }
>=20
>   impl<T: 'static> ForeignOwnable for Arc<T> {
>=20
> --
> 2.44.0.rc1.240.g4c46232300-goog
>=20


