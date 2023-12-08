Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4121180A8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573825AbjLHQXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjLHQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:23:00 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C65A1989;
        Fri,  8 Dec 2023 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=bl7oekikwvbkhhq4nzdqaedpky.protonmail; t=1702052582; x=1702311782;
        bh=09cIzzcTTW19QYNpR3uVKQ8ubxQmSzjsq6tAhHqkl1o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QL7tC3OWmhjbkW9UhAlFm+Nhu+97KWzvZ9kGUqtM7EvSXhDQ8ITlZl3+CQ4PMm/VI
         rB2+oExNW5SXa5arRInKnsfENrZqxSdWFmmKEl976xU8H6XoChMSUEfln0RKiEfru2
         sw7l7Jm9gWqj8gRGeweJAQ6s7ifrqKP9s06OInGkBbZFTHbuW0Qo99y3r4MoFPXV/E
         4sDw9FiIJ7dZYqoddh6JbVD5j0X/QgGGzyRiRZUwEUOabiiTm4m9xoAaF5zDQKapSI
         cHSSH3NGfE5M3+pl+uyehI3RjWRocNkxCwj6Esuv1ossSJKeXw6+/nB7+JYE2A1tj7
         HGYOBhFH1Vm0A==
Date:   Fri, 08 Dec 2023 16:22:48 +0000
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
Subject: Re: [PATCH v2 3/7] rust: security: add abstraction for secctx
Message-ID: <bynTQw4ZTfXBA0m3PYPL50jFnGQIzZnONT_L0TUNuWGtLwJhk6m0jeYQktfEIRmcVZIvKX9MOHwu4RgLWuH3nm5E_AiWNDKuKt_D2HSqsQw=@proton.me>
In-Reply-To: <20231206-alice-file-v2-3-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-3-af617c0d9d94@google.com>
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
> +impl SecurityCtx {
> +    /// Get the security context given its id.
> +    pub fn from_secid(secid: u32) -> Result<Self> {
> +        let mut secdata =3D core::ptr::null_mut();
> +        let mut seclen =3D 0u32;
> +        // SAFETY: Just a C FFI call. The pointers are valid for writes.
> +        unsafe {
> +            to_result(bindings::security_secid_to_secctx(
> +                secid,
> +                &mut secdata,
> +                &mut seclen,
> +            ))?;
> +        }

Can you move the `unsafe` block inside of the `to_result` call? That way
we only have the unsafe operation in the unsafe block. Additionally, on
my side it fits perfectly into 100 characters.

> +        // INVARIANT: If the above call did not fail, then we have a val=
id security context.
> +        Ok(Self {
> +            secdata,
> +            seclen: seclen as usize,
> +        })
> +    }

[...]

> +    /// Returns the bytes for this security context.
> +    pub fn as_bytes(&self) -> &[u8] {
> +        let ptr =3D self.secdata;
> +        if ptr.is_null() {
> +            // We can't pass a null pointer to `slice::from_raw_parts` e=
ven if the length is zero.
> +            debug_assert_eq!(self.seclen, 0);

Would this be interesting enough to emit some kind of log message when
this fails?

> +            return &[];
> +        }
> +
> +        // SAFETY: The call to `security_secid_to_secctx` guarantees tha=
t the pointer is valid for
> +        // `seclen` bytes. Furthermore, if the length is zero, then we h=
ave ensured that the
> +        // pointer is not null.
> +        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
> +    }
> +}
> +
> +impl Drop for SecurityCtx {
> +    fn drop(&mut self) {
> +        // SAFETY: This frees a pointer that came from a successful call=
 to
> +        // `security_secid_to_secctx` and has not yet been destroyed by =
`security_release_secctx`.
> +        unsafe {
> +            bindings::security_release_secctx(self.secdata, self.seclen =
as u32);
> +        }

If you move the `;` to the outside of the `unsafe` block this also fits
on a single line.

--=20
Cheers,
Benno

> +    }
> +}
