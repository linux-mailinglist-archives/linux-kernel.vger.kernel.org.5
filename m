Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751B7FF899
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbjK3Rmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjK3Rme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:42:34 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93A110E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701366156; x=1701625356;
        bh=jHvQDQIsGh7IZyuZ4Z71fkUJ7lN6fsPyLlI85ioCOd4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aoBbVk9ACHHmxS9v/zNi4r1IrszVrrEk+96u5Vbtx6tteI/l/ac1n2/OtSshr4kLK
         EtjFckFu529Q2h8xsOmq48yhhbDu+Sr3EX4FQVVtgyhDiXj0PXlhm9K+GWiJdS7VCW
         ESJPd7VJ8D45YK2SLUCaIYtZryFEMHp+heEc/ds6S02yMmUwN+BM4Sz5rZ6AggisTi
         9Vurh4mtyuMBwd2Qp8bdoizuqGa5xEUuoX0bx68Q//tiWARi7paf3A+CDovtRku+Za
         uvcHJ7cGTuJdI7J7WbjXkbcg+dXM6rRi49cBqvwyNvF8/QilOGxuOScBWxA3hB/SF6
         9xqIzvRSaRGiw==
Date:   Thu, 30 Nov 2023 17:42:06 +0000
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
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
In-Reply-To: <20231129-alice-file-v1-7-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-7-f81afe8c7261@google.com>
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

On 11/29/23 14:12, Alice Ryhl wrote:
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index 578ee307093f..35576678c993 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -14,6 +14,9 @@
>  use alloc::boxed::Box;
>  use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
>=20
> +mod poll_table;
> +pub use self::poll_table::{PollCondVar, PollTable};

I think it makes more sense to put it under `rust/kernel/sync/`.
> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
> +        let ptr =3D self.0.get();
> +        // SAFETY: The `ptr` is valid because it originates from a refer=
ence, and the `_qproc`
> +        // field is not modified concurrently with this call.

What ensures this? Maybe use a type invariant?

> +        unsafe { (*ptr)._qproc }
> +    }

[...]

> +impl PollCondVar {
> +    /// Constructs a new condvar initialiser.
> +    #[allow(clippy::new_ret_no_self)]

This is no longer needed, as Gary fixed this, see [1].

[1]: https://github.com/rust-lang/rust-clippy/issues/7344

> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl =
PinInit<Self> {
> +        pin_init!(Self {
> +            inner <- CondVar::new(name, key),
> +        })
> +    }
> +}
> +
> +// Make the `CondVar` methods callable on `PollCondVar`.
> +impl Deref for PollCondVar {
> +    type Target =3D CondVar;
> +
> +    fn deref(&self) -> &CondVar {
> +        &self.inner
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for PollCondVar {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Clear anything registered using `register_wait`.
> +        self.inner.notify(1, bindings::POLLHUP | bindings::POLLFREE);

Isn't notifying only a single thread problematic, since a user could
misuse the `PollCondVar` (since all functions of `CondVar` are also
accessible) and also `.wait()` on the condvar? When dropping a
`PollCondVar` it might notify only the user `.wait()`, but not the
`PollTable`. Or am I missing something?

--=20
Cheers,
Benno

> +        // Wait for epoll items to be properly removed.
> +        //
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::synchronize_rcu() };
> +    }
> +}
