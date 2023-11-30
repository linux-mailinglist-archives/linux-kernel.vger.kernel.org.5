Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CA7FF2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjK3Oxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjK3Oxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:53:49 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2A1A4;
        Thu, 30 Nov 2023 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701356031; x=1701615231;
        bh=/dZ6NFV/G0RLkBAHtfCz9HT+dyLmnY7azuvPxmWLInY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cNBncAt8SBbwtWIg8zhpCfPOPlRcxBBpPki5cySbkQEjhluV7qcu2z/NWiBIJNz/K
         kt+9BjY6peS+QqKE3SWeyaQ6vNnt8pWYjFxB1VLXkbGHNk0Dyl7fktaiBpaz81eMRr
         tWmxK/ZnwLetZvAWw6B1boUPy5r45NIaXE7BBtLtR9jh8C5GDsPvZu8tZs0oj+Cm3a
         at38RTfr6yaS+qwT0dJTQY8D7+/awYP/Eovl597NqfnZjH5NAgSTNbEewCPlC59Hay
         2YyBud7z1rCSKlAH7iV0jZvmX12n943XTQpiXWa2voaLYuEdCEHEpEtyQYL4q0LvWQ
         GMMlMV4IHo5cQ==
Date:   Thu, 30 Nov 2023 14:53:35 +0000
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
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
In-Reply-To: <20231129-alice-file-v1-1-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-1-f81afe8c7261@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 13:51, Alice Ryhl wrote:
> +/// Flags associated with a [`File`].
> +pub mod flags {
> +    /// File is opened in append mode.
> +    pub const O_APPEND: u32 =3D bindings::O_APPEND;

Why do all of these constants begin with `O_`?

[...]

> +impl File {
> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> +    ///
> +    /// The file descriptor belongs to the current process.
> +    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
> +        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let ptr =3D ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_=
or(BadFdError)?;
> +
> +        // INVARIANT: `fget` increments the refcount before returning.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })

Missing `SAFETY` comment.

> +    }
> +
> +    /// Creates a reference to a [`File`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at a valid file and tha=
t its refcount does not
> +    /// reach zero during the lifetime 'a.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
> +        // INVARIANT: The safety requirements guarantee that the refcoun=
t does not hit zero during
> +        // 'a. The cast is okay because `File` is `repr(transparent)`.
> +        unsafe { &*ptr.cast() }

Missing `SAFETY` comment.

> +    }
> +
> +    /// Returns the flags associated with the file.
> +    ///
> +    /// The flags are a combination of the constants in [`flags`].
> +    pub fn flags(&self) -> u32 {
> +        // This `read_volatile` is intended to correspond to a READ_ONCE=
 call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guaran=
tees a nonzero refcount.
> +        //
> +        // TODO: Replace with `read_once` when available on the Rust sid=
e.
> +        unsafe { core::ptr::addr_of!((*self.0.get()).f_flags).read_volat=
ile() }
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `File` is always ref-count=
ed.
> +unsafe impl AlwaysRefCounted for File {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::get_file(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero.
> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +/// Represents the `EBADF` error code.
> +///
> +/// Used for methods that can only fail with `EBADF`.
> +pub struct BadFdError;
> +
> +impl From<BadFdError> for Error {
> +    fn from(_: BadFdError) -> Error {
> +        EBADF
> +    }
> +}
> +
> +impl core::fmt::Debug for BadFdError {
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result=
 {
> +        f.pad("EBADF")
> +    }
> +}

Do we want to generalize this to the other errors as well? We could modify
the `declare_error!` macro in `error.rs` to create these unit structs.

--=20
Cheers,
Benno
