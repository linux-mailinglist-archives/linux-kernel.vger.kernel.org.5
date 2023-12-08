Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1882809D39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573267AbjLHHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjLHHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:37:08 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF71720;
        Thu,  7 Dec 2023 23:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1702021030; x=1702280230;
        bh=ZZHZA4Gcm1UpAbYA1AbNrAIVMwWMUdvwEKstGqvJtBA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WNENKgdH1uy5nNR/BW1az5Ut181MDrpK5hzs+KBapoRlvuX+aNaGE0lqCI+/IYGPR
         CUej+4t5yvzRThFiGhy0zbW7Eva0OsO7yGRFUjp+sdRkrEMSUoIWjdp6nj+ZpHpw38
         KZnlDxLAcWCeP/CzDQ+QC+YKt3Fuoe3L3YKQD6UFLd7BKuv36MUx1W++hlsVqOVRDi
         CiIjhNNNoRcGfSeZN8J12w2tyXOgwVT/hF/VI2pTUvZK1x2i5DUeZxqW2avJJqfl51
         +cA69HuuXZ/en2XpmdeGCxyVt+x/ZrydtI9RHEPJCE/kOx6SuCjWgrleWCjNDsbuKZ
         ZIk3iJaJpH00A==
Date:   Fri, 08 Dec 2023 07:37:03 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
In-Reply-To: <20231206-alice-file-v2-4-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-4-af617c0d9d94@google.com>
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

On 12/6/23 12:59, Alice Ryhl wrote:
> +    /// Commits the reservation.
> +    ///
> +    /// The previously reserved file descriptor is bound to `file`. This=
 method consumes the
> +    /// [`FileDescriptorReservation`], so it will not be usable after th=
is call.
> +    pub fn fd_install(self, file: ARef<File>) {
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags`, and `file.ptr` is
> +        // guaranteed to have an owned ref count by its type invariants.

There is no mention of the requirement that `current` has not changed
(you do mention it on the `_not_send` field, but I think it should also
be in the safety comment here).

> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> +
> +        // `fd_install` consumes both the file descriptor and the file r=
eference, so we cannot run
> +        // the destructors.
> +        core::mem::forget(self);
> +        core::mem::forget(file);
> +    }
> +}
> +
> +impl Drop for FileDescriptorReservation {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.fd` was returned by a previous call to `get_unu=
sed_fd_flags`.

Ditto.

> +        unsafe { bindings::put_unused_fd(self.fd) };
> +    }
> +}
> +
>  /// Represents the `EBADF` error code.
>  ///
>  /// Used for methods that can only fail with `EBADF`.
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index fdb778e65d79..a4584d6b26c0 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -387,3 +387,13 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type =
`R`.
>      Right(R),
>  }
> +
> +/// Zero-sized type to mark types not [`Send`].
> +///
> +/// Add this type as a field to your struct if your type should not be s=
ent to a different task.
> +/// Since [`Send`] is an auto trait, adding a single field that is `!Sen=
d` will ensure that the
> +/// whole type is `!Send`.
> +///
> +/// If a type is `!Send` it is impossible to give control over an instan=
ce of the type to another
> +/// task. This is useful when a type stores task-local information for e=
xample file descriptors.
> +pub type NotThreadSafe =3D PhantomData<*mut ()>;

This should be in its own commit.

Then you can also change the usages of `PhantomData<*mut ()>` in
`Guard` and `TaskRef`.

It would be nice to use `NotThreadSafe` as the value instead of
`PhantomData`, since it is a bit confusing...=20
I think we might be able to also have a constant with the same name
that is just `pub const NotThreadSafe: NotThreadSafe =3D PhantomData;`.

--=20
Cheers,
Benno
