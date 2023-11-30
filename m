Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA17FF65C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjK3Qke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjK3Qk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:40:29 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8F1A3;
        Thu, 30 Nov 2023 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701362431; x=1701621631;
        bh=aUwMWJjNDKEwZmf6rHJqm0TKxpV/+zt7aI/cwBnNF/A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ehwizPfWAQhgd+7ta7CVxTTmFCLL9OZt2OTvHEdaMgrWXuHZyzNtxt32CUCB1M1PE
         6Q+MytXCCWjdVY4dbSvh6ZJKpIPHcoYlRCO+llV1Xp7icXNkd0rCP0iJqnsIUNchCq
         vhjmms7N2eQ7KF8DgyqKB/J40WXRCW17Ire313/raamQ4GRVNVJo1nW5l2u+gwoSrD
         dGF7BTHj/ahSWnAkJBD+hsBw5ttmcbKOTao+Z8d3w4BlBlRvcdgDQAGODrIGsqu71+
         rbRLbghNbiq+a+sjoiF4TvWS2W3VSuL2zQ0mH2WIU6Iv0P+QW5++cSqJPpi80t3Y51
         C2KroYXNBsJbw==
Date:   Thu, 30 Nov 2023 16:40:08 +0000
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
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <_xnOTacjwsOFSA4oog2DJs0VLa1w0EaSPM3rqDUjIZAmNgiq0V0-bJwfVZdDKaydes_rJb30Zz4TyacYImYZHK6i0-LR8AYbQa2T1l0h3K8=@proton.me>
In-Reply-To: <20231129-alice-file-v1-4-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-4-f81afe8c7261@google.com>
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

On 11/29/23 14:11, Alice Ryhl wrote:
> +impl FileDescriptorReservation {
> +    /// Creates a new file descriptor reservation.
> +    pub fn new(flags: u32) -> Result<Self> {
> +        // SAFETY: FFI call, there are no safety requirements on `flags`=
.
> +        let fd: i32 =3D unsafe { bindings::get_unused_fd_flags(flags) };
> +        if fd < 0 {
> +            return Err(Error::from_errno(fd));
> +        }

I think here we could also use the modified `to_result` function that
returns a `u32` if the value is non-negative.

> +        Ok(Self {
> +            fd: fd as _,
> +            _not_send_sync: PhantomData,
> +        })
> +    }
> +
> +    /// Returns the file descriptor number that was reserved.
> +    pub fn reserved_fd(&self) -> u32 {
> +        self.fd
> +    }
> +
> +    /// Commits the reservation.
> +    ///
> +    /// The previously reserved file descriptor is bound to `file`. This=
 method consumes the
> +    /// [`FileDescriptorReservation`], so it will not be usable after th=
is call.
> +    pub fn commit(self, file: ARef<File>) {
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags`, and `file.ptr` is
> +        // guaranteed to have an owned ref count by its type invariants.
> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> +
> +        // `fd_install` consumes both the file descriptor and the file r=
eference, so we cannot run
> +        // the destructors.
> +        core::mem::forget(self);
> +        core::mem::forget(file);

Would be useful to have an `ARef::into_raw` function that would do
the `forget` for us.

--=20
Cheers,
Benno
