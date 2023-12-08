Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C3080AB3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574528AbjLHRxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574537AbjLHRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:53:17 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7300A1999
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=qfmys4whkrbxhizugrkv3fumau.protonmail; t=1702058001; x=1702317201;
        bh=hVJsuEvFyRzSwsIFDjR8bBfXvfqQalvBoy1pmXp64qw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mE9EkolL56rnQaDX118ZC8Qv3X5TZeYrKUwaDSEIQn+WhbP1IxA31PBFYX1w4PEfm
         tbDUzGQDgCFongIl664Rpjt0Q6D4+Ta/SBJvda/xqssrHxUAN/jDW+M0rZ26/jZ7bF
         hndgRizrrT3D+EtySJ7XnPTGMg1V4oE9UN6NpZai6CunjP+grH/LbKkJTx9or3kn/u
         7Y7h499dZSav1SYvkjLVnEWc7pPhiT0gxp7UgDLVBq3paoIX/LqcVWwVN/TqHRmJOF
         h6esC13pxSSp19Splgu14PaV0+GojhlmckFGZ9EGMD53F1Wblwgy4oTz1b5PPNmmgL
         L+R1EmlgGTGvA==
Date:   Fri, 08 Dec 2023 17:53:08 +0000
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
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <k_vpgbqKAKoTFzJIBCjvgxGhX73kgkcv6w9kru78lBmTjHHvXPy05g8KxAKJ-ODARBxlZUp3a5e4F9TemGqQiskkwFCpTOhzxlvy378tjHM=@proton.me>
In-Reply-To: <20231206-alice-file-v2-7-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-7-af617c0d9d94@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 12:59, Alice Ryhl wrote:
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 9bcbea04dac3..eeb291cc60db 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -51,3 +51,4 @@ mod bindings_helper {
>=20
>  pub const GFP_KERNEL: gfp_t =3D BINDINGS_GFP_KERNEL;
>  pub const __GFP_ZERO: gfp_t =3D BINDINGS___GFP_ZERO;
> +pub const POLLFREE: __poll_t =3D BINDINGS_POLLFREE;

You are no longer using this constant, should this still exist?

[...]

> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
> +        let ptr =3D self.0.get();
> +        // SAFETY: The `ptr` is valid because it originates from a refer=
ence, and the `_qproc`
> +        // field is not modified concurrently with this call since we ha=
ve an immutable reference.

This needs an invariant on `PollTable` (i.e. `self.0` is valid).

> +        unsafe { (*ptr)._qproc }
> +    }
> +
> +    /// Register this [`PollTable`] with the provided [`PollCondVar`], s=
o that it can be notified
> +    /// using the condition variable.
> +    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
> +        if let Some(qproc) =3D self.get_qproc() {
> +            // SAFETY: The pointers to `self` and `file` are valid becau=
se they are references.

What about cv.wait_list...

> +            //
> +            // Before the wait list is destroyed, the destructor of `Pol=
lCondVar` will clear
> +            // everything in the wait list, so the wait list is not used=
 after it is freed.
> +            unsafe { qproc(file.as_ptr() as _, cv.wait_list.get(), self.=
0.get()) };
> +        }
> +    }
> +}
> +
> +/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`]=
.
> +///
> +/// # Invariant
> +///
> +/// If `needs_synchronize_rcu` is false, then there is nothing registere=
d with `register_wait`.

Not able to find `needs_synchronize_rcu` anywhere else, should this be
here?

> +///
> +/// [`CondVar`]: crate::sync::CondVar
> +#[pin_data(PinnedDrop)]
> +pub struct PollCondVar {
> +    #[pin]
> +    inner: CondVar,
> +}

[..]

> +#[pinned_drop]
> +impl PinnedDrop for PollCondVar {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Clear anything registered using `register_wait`.
> +        //
> +        // SAFETY: The pointer points at a valid wait list.

I was a bit confused by "wait list", since the C type is named
`wait_queue_head`, maybe just use the type name?

--=20
Cheers,
Benno

> +        unsafe { bindings::__wake_up_pollfree(self.inner.wait_list.get()=
) };
> +
> +        // Wait for epoll items to be properly removed.
> +        //
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::synchronize_rcu() };
> +    }
> +}
